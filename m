Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A224C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4C020735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbgZI1RL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4C020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICeb-0006Rm-E7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICag-0001hL-FY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICae-0008Qt-8v
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G4AFT9erKKugKmUGRcSA/TttGr/atnBILdTrDRdZyjk=;
 b=IbgZI1RL5OCpkeqR8DgW/1qoxGQDeLfqBJK2T5dTYu+ubbUBVmQBjskg3+TmeRYueURDj2
 KvVGtJw3d513jOLDIsBEiVWD2zSiKy4LKr2ijSx13P/5yr6oBDL0l4F/a8eo09Yk48CcAl
 DTXMq6G7UudVsBnoahG7YQIT5EV/4pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-02e7_6-rMp-k4o-N_QYXdg-1; Tue, 15 Sep 2020 11:09:46 -0400
X-MC-Unique: 02e7_6-rMp-k4o-N_QYXdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 424B38ECFBA;
 Tue, 15 Sep 2020 15:09:13 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C5B10013BD;
 Tue, 15 Sep 2020 15:09:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs/system: clarify deprecation schedule
Date: Tue, 15 Sep 2020 16:07:34 +0100
Message-Id: <20200915150734.711426-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 philmd@redhat.com, Daniel Berrange <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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
bW92ZWQgaW4gdGhlIDUuMS4wIHJlbGVhc2UuCgpTdWdnZXN0ZWQtYnk6IERhbmllbCBQLiBCZXJy
YW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCnYyOgogKiBVc2UgRGFuJ3Mgc3VnZ2VzdGVkIHdv
cmRpbmcgW0RhbmllbCBCZXJyYW5nZV0KLS0tCiBkb2NzL3N5c3RlbS9kZXByZWNhdGVkLnJzdCB8
IDkgKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2RlcHJlY2F0ZWQucnN0IGIvZG9jcy9zeXN0
ZW0vZGVwcmVjYXRlZC5yc3QKaW5kZXggMGNiOGIwMTQyNC4uZjJkNWJkOGNlMSAxMDA2NDQKLS0t
IGEvZG9jcy9zeXN0ZW0vZGVwcmVjYXRlZC5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vZGVwcmVjYXRl
ZC5yc3QKQEAgLTMsMTAgKzMsMTEgQEAgRGVwcmVjYXRlZCBmZWF0dXJlcwogCiBJbiBnZW5lcmFs
IGZlYXR1cmVzIGFyZSBpbnRlbmRlZCB0byBiZSBzdXBwb3J0ZWQgaW5kZWZpbml0ZWx5IG9uY2UK
IGludHJvZHVjZWQgaW50byBRRU1VLiBJbiB0aGUgZXZlbnQgdGhhdCBhIGZlYXR1cmUgbmVlZHMg
dG8gYmUgcmVtb3ZlZCwKLWl0IHdpbGwgYmUgbGlzdGVkIGluIHRoaXMgc2VjdGlvbi4gVGhlIGZl
YXR1cmUgd2lsbCByZW1haW4gZnVuY3Rpb25hbAotZm9yIDIgcmVsZWFzZXMgcHJpb3IgdG8gYWN0
dWFsIHJlbW92YWwuIERlcHJlY2F0ZWQgZmVhdHVyZXMgbWF5IGFsc28KLWdlbmVyYXRlIHdhcm5p
bmdzIG9uIHRoZSBjb25zb2xlIHdoZW4gUUVNVSBzdGFydHMgdXAsIG9yIGlmIGFjdGl2YXRlZAot
dmlhIGEgbW9uaXRvciBjb21tYW5kLCBob3dldmVyLCB0aGlzIGlzIG5vdCBhIG1hbmRhdG9yeSBy
ZXF1aXJlbWVudC4KK2l0IHdpbGwgYmUgbGlzdGVkIGluIHRoaXMgc2VjdGlvbi4gVGhlIGZlYXR1
cmUgd2lsbCByZW1haW4gZnVuY3Rpb25hbCBmb3IgdGhlCityZWxlYXNlIGluIHdoaWNoIGl0IHdh
cyBkZXByZWNhdGVkIGFuZCBvbmUgZnVydGhlciByZWxlYXNlLiBBZnRlciB0aGVzZSB0d28KK3Jl
bGVhc2VzLCB0aGUgZmVhdHVyZSBpcyBsaWFibGUgdG8gYmUgcmVtb3ZlZC4gRGVwcmVjYXRlZCBm
ZWF0dXJlcyBtYXkgYWxzbworZ2VuZXJhdGUgd2FybmluZ3Mgb24gdGhlIGNvbnNvbGUgd2hlbiBR
RU1VIHN0YXJ0cyB1cCwgb3IgaWYgYWN0aXZhdGVkIHZpYSBhCittb25pdG9yIGNvbW1hbmQsIGhv
d2V2ZXIsIHRoaXMgaXMgbm90IGEgbWFuZGF0b3J5IHJlcXVpcmVtZW50LgogCiBQcmlvciB0byB0
aGUgMi4xMC4wIHJlbGVhc2UgdGhlcmUgd2FzIG5vIG9mZmljaWFsIHBvbGljeSBvbiBob3cKIGxv
bmcgZmVhdHVyZXMgd291bGQgYmUgZGVwcmVjYXRlZCBwcmlvciB0byB0aGVpciByZW1vdmFsLCBu
b3IKLS0gCjIuMjYuMgoK


