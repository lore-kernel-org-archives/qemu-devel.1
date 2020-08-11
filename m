Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4050220756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTX0zz6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Rpp-0006gu-Fd
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 06:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5Ros-00067c-NW
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:47:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5Roq-0001nB-5j
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597142866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dt48sDSWlxZB9QQPIaHBPpb/bwOEKoiFUS77UHsynYE=;
 b=aTX0zz6EWr/HblmUcuOcYDBoa5HW7/aAWXbxB7EdZB2wOb6KR+JAV2Xcw8xdi0QC31GrMX
 aE92MDGQcbo5pX8XkQN5KmfcM07pgGwlIPQwNyZ4mmDf34jDDdvnyiRRI8mhLuFR+GIpRh
 r3H/RScl+vNaT1AzQnBWeqGCj7vLN6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-0LzkGOvwOcKhbdhQv0IcaA-1; Tue, 11 Aug 2020 06:47:45 -0400
X-MC-Unique: 0LzkGOvwOcKhbdhQv0IcaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C11F1902EA1;
 Tue, 11 Aug 2020 10:47:44 +0000 (UTC)
Received: from localhost (ovpn-114-81.ams2.redhat.com [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDA586F12F;
 Tue, 11 Aug 2020 10:47:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/system: clarify deprecation scheduled
Date: Tue, 11 Aug 2020 11:47:36 +0100
Message-Id: <20200811104736.17140-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, philmd@redhat.com,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHNlbnRlbmNlIGV4cGxhaW5pbmcgdGhlIGRlcHJlY2F0aW9uIHNjaGVkdWxlIGlzIGFtYmln
dW91cy4gTWFrZSBpdApjbGVhciB0aGF0IGEgZmVhdHVyZSBkZXByZWNhdGVkIGluIHRoZSBOdGgg
cmVsZWFzZSBpcyBndWFyYW50ZWVkIHRvCnJlbWFpbiBhdmFpbGFibGUgaW4gdGhlIE4rMXRoIHJl
bGVhc2UuIFJlbW92YWwgY2FuIG9jY3VyIGluIHRoZSBOKzJuZApyZWxlYXNlIG9yIGxhdGVyLgoK
QXMgYW4gZXhhbXBsZSBvZiB0aGlzIGluIGFjdGlvbiwgc2VlIGNvbW1pdAoyNTk1NmFmM2ZlNWRk
MDM4NWFkODAxN2JjNzY4YTZhZmU0MWUyYTc0ICgiYmxvY2s6IEZpbmlzaCBkZXByZWNhdGlvbiBv
ZgoncWVtdS1pbWcgY29udmVydCAtbiAtbyciKS4gVGhlIGZlYXR1cmUgd2FzIGRlcHJlY2F0ZWQg
aW4gUUVNVSA0LjIuMC4gSXQKd2FzIHByZXNlbnQgaW4gdGhlIDUuMC4wIHJlbGVhc2UgYW5kIHJl
bW92ZWQgaW4gdGhlIDUuMS4wIHJlbGVhc2UuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogZG9jcy9zeXN0ZW0vZGVwcmVjYXRlZC5yc3Qg
fCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9kZXByZWNhdGVkLnJzdCBiL2RvY3Mvc3lzdGVt
L2RlcHJlY2F0ZWQucnN0CmluZGV4IDg1MWRiZGViOGEuLmZlY2ZiMmYxYzEgMTAwNjQ0Ci0tLSBh
L2RvY3Mvc3lzdGVtL2RlcHJlY2F0ZWQucnN0CisrKyBiL2RvY3Mvc3lzdGVtL2RlcHJlY2F0ZWQu
cnN0CkBAIC00LDkgKzQsOSBAQCBEZXByZWNhdGVkIGZlYXR1cmVzCiBJbiBnZW5lcmFsIGZlYXR1
cmVzIGFyZSBpbnRlbmRlZCB0byBiZSBzdXBwb3J0ZWQgaW5kZWZpbml0ZWx5IG9uY2UKIGludHJv
ZHVjZWQgaW50byBRRU1VLiBJbiB0aGUgZXZlbnQgdGhhdCBhIGZlYXR1cmUgbmVlZHMgdG8gYmUg
cmVtb3ZlZCwKIGl0IHdpbGwgYmUgbGlzdGVkIGluIHRoaXMgc2VjdGlvbi4gVGhlIGZlYXR1cmUg
d2lsbCByZW1haW4gZnVuY3Rpb25hbAotZm9yIDIgcmVsZWFzZXMgcHJpb3IgdG8gYWN0dWFsIHJl
bW92YWwuIERlcHJlY2F0ZWQgZmVhdHVyZXMgbWF5IGFsc28KLWdlbmVyYXRlIHdhcm5pbmdzIG9u
IHRoZSBjb25zb2xlIHdoZW4gUUVNVSBzdGFydHMgdXAsIG9yIGlmIGFjdGl2YXRlZAotdmlhIGEg
bW9uaXRvciBjb21tYW5kLCBob3dldmVyLCB0aGlzIGlzIG5vdCBhIG1hbmRhdG9yeSByZXF1aXJl
bWVudC4KK2ZvciAxIG1vcmUgcmVsZWFzZSBhZnRlciBkZXByZWNhdGlvbi4gRGVwcmVjYXRlZCBm
ZWF0dXJlcyBtYXkgYWxzbyBnZW5lcmF0ZQord2FybmluZ3Mgb24gdGhlIGNvbnNvbGUgd2hlbiBR
RU1VIHN0YXJ0cyB1cCwgb3IgaWYgYWN0aXZhdGVkIHZpYSBhIG1vbml0b3IKK2NvbW1hbmQsIGhv
d2V2ZXIsIHRoaXMgaXMgbm90IGEgbWFuZGF0b3J5IHJlcXVpcmVtZW50LgogCiBQcmlvciB0byB0
aGUgMi4xMC4wIHJlbGVhc2UgdGhlcmUgd2FzIG5vIG9mZmljaWFsIHBvbGljeSBvbiBob3cKIGxv
bmcgZmVhdHVyZXMgd291bGQgYmUgZGVwcmVjYXRlZCBwcmlvciB0byB0aGVpciByZW1vdmFsLCBu
b3IKLS0gCjIuMjYuMgoK


