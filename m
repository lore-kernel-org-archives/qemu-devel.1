Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A32020719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUgrz/RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A32020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Rm-0001Bq-4w
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MT-0003jb-I3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MN-0006F1-Az
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ccWbG9UyUgYBonJIQ/nL1HXbpG43SIIRm1DDC84+Dig=;
 b=DUgrz/RBfeEImQ4tcbMWxzJYJHbVRGx8VIzjjKDWtcExRVWJlZrpYlXp1uM4ppNvNmWzBh
 A/a7MQrdpFu7dIytuY+7B0Bl22I0CGwTv1bNIoO7z5R7S4xuzSC6/0nFXGrHZjVmas5df/
 93LXnIk+bMPNEBEU48hbc2mSTVqYXSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-XHnP_ls3MrybzEMTnm4AGw-1; Wed, 23 Sep 2020 12:11:08 -0400
X-MC-Unique: XHnP_ls3MrybzEMTnm4AGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F8F3186DD36;
 Wed, 23 Sep 2020 16:11:07 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA81173668;
 Wed, 23 Sep 2020 16:11:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/13] docs/system: clarify deprecation schedule
Date: Wed, 23 Sep 2020 17:10:25 +0100
Message-Id: <20200923161031.69474-8-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kg
PGJlcnJhbmdlQHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIwMDkxNTE1MDczNC43MTE0MjYt
MS1zdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGRvY3Mvc3lzdGVtL2RlcHJlY2F0ZWQucnN0IHwg
OSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vZGVwcmVjYXRlZC5yc3QgYi9kb2NzL3N5c3Rl
bS9kZXByZWNhdGVkLnJzdAppbmRleCA4MDhjMzM0ZmU3Li4zNzdjZDY0NjgxIDEwMDY0NAotLS0g
YS9kb2NzL3N5c3RlbS9kZXByZWNhdGVkLnJzdAorKysgYi9kb2NzL3N5c3RlbS9kZXByZWNhdGVk
LnJzdApAQCAtMywxMCArMywxMSBAQCBEZXByZWNhdGVkIGZlYXR1cmVzCiAKIEluIGdlbmVyYWwg
ZmVhdHVyZXMgYXJlIGludGVuZGVkIHRvIGJlIHN1cHBvcnRlZCBpbmRlZmluaXRlbHkgb25jZQog
aW50cm9kdWNlZCBpbnRvIFFFTVUuIEluIHRoZSBldmVudCB0aGF0IGEgZmVhdHVyZSBuZWVkcyB0
byBiZSByZW1vdmVkLAotaXQgd2lsbCBiZSBsaXN0ZWQgaW4gdGhpcyBzZWN0aW9uLiBUaGUgZmVh
dHVyZSB3aWxsIHJlbWFpbiBmdW5jdGlvbmFsCi1mb3IgMiByZWxlYXNlcyBwcmlvciB0byBhY3R1
YWwgcmVtb3ZhbC4gRGVwcmVjYXRlZCBmZWF0dXJlcyBtYXkgYWxzbwotZ2VuZXJhdGUgd2Fybmlu
Z3Mgb24gdGhlIGNvbnNvbGUgd2hlbiBRRU1VIHN0YXJ0cyB1cCwgb3IgaWYgYWN0aXZhdGVkCi12
aWEgYSBtb25pdG9yIGNvbW1hbmQsIGhvd2V2ZXIsIHRoaXMgaXMgbm90IGEgbWFuZGF0b3J5IHJl
cXVpcmVtZW50LgoraXQgd2lsbCBiZSBsaXN0ZWQgaW4gdGhpcyBzZWN0aW9uLiBUaGUgZmVhdHVy
ZSB3aWxsIHJlbWFpbiBmdW5jdGlvbmFsIGZvciB0aGUKK3JlbGVhc2UgaW4gd2hpY2ggaXQgd2Fz
IGRlcHJlY2F0ZWQgYW5kIG9uZSBmdXJ0aGVyIHJlbGVhc2UuIEFmdGVyIHRoZXNlIHR3bworcmVs
ZWFzZXMsIHRoZSBmZWF0dXJlIGlzIGxpYWJsZSB0byBiZSByZW1vdmVkLiBEZXByZWNhdGVkIGZl
YXR1cmVzIG1heSBhbHNvCitnZW5lcmF0ZSB3YXJuaW5ncyBvbiB0aGUgY29uc29sZSB3aGVuIFFF
TVUgc3RhcnRzIHVwLCBvciBpZiBhY3RpdmF0ZWQgdmlhIGEKK21vbml0b3IgY29tbWFuZCwgaG93
ZXZlciwgdGhpcyBpcyBub3QgYSBtYW5kYXRvcnkgcmVxdWlyZW1lbnQuCiAKIFByaW9yIHRvIHRo
ZSAyLjEwLjAgcmVsZWFzZSB0aGVyZSB3YXMgbm8gb2ZmaWNpYWwgcG9saWN5IG9uIGhvdwogbG9u
ZyBmZWF0dXJlcyB3b3VsZCBiZSBkZXByZWNhdGVkIHByaW9yIHRvIHRoZWlyIHJlbW92YWwsIG5v
cgotLSAKMi4yNi4yCgo=


