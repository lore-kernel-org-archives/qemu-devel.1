Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EAC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D3214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YZUFu2UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTO6-00080e-Ss
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1izTNQ-0007A9-4n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1izTNO-0007yX-LB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:42:31 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1izTNO-0007en-AS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580942550; x=1612478550;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1nIkVSKYZdj95UxlxIfwKbiLoTM4iCuAfng4IMBPWjY=;
 b=YZUFu2UYDLcVotGIr4Kof49Cog4d8iBXAniNzgIX9gH7E2/ZmAFGBnyN
 52s4o6ffyySH5M9+KjLX7KZCtYQIH6TanFCA14CgBhH1Fqonfrct7Fg/x
 UXlYWsVOoggeJbQK70plgwWvbiZgEQhZwO9O+zdZe94OnvI1tU23i6j+d g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Feb 2020 14:42:27 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 05 Feb 2020 14:42:27 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id A9A87B4D; Wed,  5 Feb 2020 16:42:26 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Add support for a helper with 7 arguments
Date: Wed,  5 Feb 2020 16:41:50 -0600
Message-Id: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q3VycmVudGx5LCBoZWxwZXJzIGNhbiBvbmx5IHRha2UgdXAgdG8gNiBhcmd1bWVudHMuICBUaGlz
IHBhdGNoIGFkZHMgdGhlCmNhcGFiaWxpdHkgZm9yIHVwIHRvIDcgYXJndW1lbnRzLiAgSSBoYXZl
IHRlc3RlZCBpdCB3aXRoIHRoZSBIZXhhZ29uIHBvcnQKdGhhdCBJIGFtIHByZXBhcmluZyBmb3Ig
c3VibWlzc2lvbi4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT4KLS0tCiBpbmNsdWRlL2V4ZWMvaGVscGVyLWdlbi5oICAgfCAxMyArKysrKysrKysr
KysrCiBpbmNsdWRlL2V4ZWMvaGVscGVyLWhlYWQuaCAgfCAgMiArKwogaW5jbHVkZS9leGVjL2hl
bHBlci1wcm90by5oIHwgIDYgKysrKysrCiBpbmNsdWRlL2V4ZWMvaGVscGVyLXRjZy5oICAgfCAg
NyArKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2V4ZWMvaGVscGVyLWdlbi5oIGIvaW5jbHVkZS9leGVjL2hlbHBlci1nZW4uaApp
bmRleCAyMzZmZjQwLi4yOWMwMmY4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2V4ZWMvaGVscGVyLWdl
bi5oCisrKyBiL2luY2x1ZGUvZXhlYy9oZWxwZXItZ2VuLmgKQEAgLTY2LDYgKzY2LDE4IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBnbHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbChy
ZXQpICAgICAgICAgIFwKICAgdGNnX2dlbl9jYWxsTihIRUxQRVIobmFtZSksIGRoX3JldHZhcihy
ZXQpLCA2LCBhcmdzKTsgICAgICAgICAgICAgICAgIFwKIH0KIAorI2RlZmluZSBERUZfSEVMUEVS
X0ZMQUdTXzcobmFtZSwgZmxhZ3MsIHJldCwgdDEsIHQyLCB0MywgdDQsIHQ1LCB0NiwgdDcpXAor
c3RhdGljIGlubGluZSB2b2lkIGdsdWUoZ2VuX2hlbHBlcl8sIG5hbWUpKGRoX3JldHZhcl9kZWNs
KHJldCkgICAgICAgICAgXAorICAgIGRoX2FyZ19kZWNsKHQxLCAxKSwgIGRoX2FyZ19kZWNsKHQy
LCAyKSwgZGhfYXJnX2RlY2wodDMsIDMpLCAgICAgICAgXAorICAgIGRoX2FyZ19kZWNsKHQ0LCA0
KSwgZGhfYXJnX2RlY2wodDUsIDUpLCBkaF9hcmdfZGVjbCh0NiwgNiksICAgICAgICAgXAorICAg
IGRoX2FyZ19kZWNsKHQ3LCA3KSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAoreyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICBUQ0dUZW1wICphcmdzWzddID0geyBk
aF9hcmcodDEsIDEpLCBkaF9hcmcodDIsIDIpLCBkaF9hcmcodDMsIDMpLCAgICAgXAorICAgICAg
ICAgICAgICAgICAgICAgZGhfYXJnKHQ0LCA0KSwgZGhfYXJnKHQ1LCA1KSwgZGhfYXJnKHQ2LCA2
KSwgICAgICAgXAorICAgICAgICAgICAgICAgICAgICAgZGhfYXJnKHQ3LCA3KSB9OyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICB0Y2dfZ2VuX2NhbGxOKEhFTFBFUihuYW1l
KSwgZGhfcmV0dmFyKHJldCksIDcsIGFyZ3MpOyAgICAgICAgICAgICAgICAgXAorfQorCiAjaW5j
bHVkZSAiaGVscGVyLmgiCiAjaW5jbHVkZSAidHJhY2UvZ2VuZXJhdGVkLWhlbHBlcnMuaCIKICNp
bmNsdWRlICJ0cmFjZS9nZW5lcmF0ZWQtaGVscGVycy13cmFwcGVycy5oIgpAQCAtNzksNiArOTEs
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2x1ZShnZW5faGVscGVyXywgbmFtZSkoZGhfcmV0dmFy
X2RlY2wocmV0KSAgICAgICAgICBcCiAjdW5kZWYgREVGX0hFTFBFUl9GTEFHU180CiAjdW5kZWYg
REVGX0hFTFBFUl9GTEFHU181CiAjdW5kZWYgREVGX0hFTFBFUl9GTEFHU182CisjdW5kZWYgREVG
X0hFTFBFUl9GTEFHU183CiAjdW5kZWYgR0VOX0hFTFBFUgogCiAjZW5kaWYgLyogSEVMUEVSX0dF
Tl9IICovCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvaGVscGVyLWhlYWQuaCBiL2luY2x1ZGUv
ZXhlYy9oZWxwZXItaGVhZC5oCmluZGV4IGYyNTE5YzkuLjMwOTRjNzkgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvZXhlYy9oZWxwZXItaGVhZC5oCisrKyBiL2luY2x1ZGUvZXhlYy9oZWxwZXItaGVhZC5o
CkBAIC0xNDgsNiArMTQ4LDggQEAKICAgICBERUZfSEVMUEVSX0ZMQUdTXzUobmFtZSwgMCwgcmV0
LCB0MSwgdDIsIHQzLCB0NCwgdDUpCiAjZGVmaW5lIERFRl9IRUxQRVJfNihuYW1lLCByZXQsIHQx
LCB0MiwgdDMsIHQ0LCB0NSwgdDYpIFwKICAgICBERUZfSEVMUEVSX0ZMQUdTXzYobmFtZSwgMCwg
cmV0LCB0MSwgdDIsIHQzLCB0NCwgdDUsIHQ2KQorI2RlZmluZSBERUZfSEVMUEVSXzcobmFtZSwg
cmV0LCB0MSwgdDIsIHQzLCB0NCwgdDUsIHQ2LCB0NykgXAorICAgIERFRl9IRUxQRVJfRkxBR1Nf
NyhuYW1lLCAwLCByZXQsIHQxLCB0MiwgdDMsIHQ0LCB0NSwgdDYsIHQ3KQogCiAvKiBNQVhfT1BD
X1BBUkFNX0lBUkdTIG11c3QgYmUgc2V0IHRvIG4gaWYgbGFzdCBlbnRyeSBpcyBERUZfSEVMUEVS
X0ZMQUdTX24uICovCiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9oZWxwZXItcHJvdG8uaCBi
L2luY2x1ZGUvZXhlYy9oZWxwZXItcHJvdG8uaAppbmRleCAxYzRiYTliLi5hMGE4ZDlhIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2V4ZWMvaGVscGVyLXByb3RvLmgKKysrIGIvaW5jbHVkZS9leGVjL2hl
bHBlci1wcm90by5oCkBAIC0zMCw2ICszMCwxMSBAQCBkaF9jdHlwZShyZXQpIEhFTFBFUihuYW1l
KSAoZGhfY3R5cGUodDEpLCBkaF9jdHlwZSh0MiksIGRoX2N0eXBlKHQzKSwgXAogZGhfY3R5cGUo
cmV0KSBIRUxQRVIobmFtZSkgKGRoX2N0eXBlKHQxKSwgZGhfY3R5cGUodDIpLCBkaF9jdHlwZSh0
MyksIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkaF9jdHlwZSh0NCksIGRoX2N0eXBl
KHQ1KSwgZGhfY3R5cGUodDYpKTsKIAorI2RlZmluZSBERUZfSEVMUEVSX0ZMQUdTXzcobmFtZSwg
ZmxhZ3MsIHJldCwgdDEsIHQyLCB0MywgdDQsIHQ1LCB0NiwgdDcpIFwKK2RoX2N0eXBlKHJldCkg
SEVMUEVSKG5hbWUpIChkaF9jdHlwZSh0MSksIGRoX2N0eXBlKHQyKSwgZGhfY3R5cGUodDMpLCBc
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGhfY3R5cGUodDQpLCBkaF9jdHlwZSh0NSks
IGRoX2N0eXBlKHQ2KSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRoX2N0eXBlKHQ3
KSk7CisKICNpbmNsdWRlICJoZWxwZXIuaCIKICNpbmNsdWRlICJ0cmFjZS9nZW5lcmF0ZWQtaGVs
cGVycy5oIgogI2luY2x1ZGUgInRjZy1ydW50aW1lLmgiCkBAIC00Miw1ICs0Nyw2IEBAIGRoX2N0
eXBlKHJldCkgSEVMUEVSKG5hbWUpIChkaF9jdHlwZSh0MSksIGRoX2N0eXBlKHQyKSwgZGhfY3R5
cGUodDMpLCBcCiAjdW5kZWYgREVGX0hFTFBFUl9GTEFHU180CiAjdW5kZWYgREVGX0hFTFBFUl9G
TEFHU181CiAjdW5kZWYgREVGX0hFTFBFUl9GTEFHU182CisjdW5kZWYgREVGX0hFTFBFUl9GTEFH
U183CiAKICNlbmRpZiAvKiBIRUxQRVJfUFJPVE9fSCAqLwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL2hlbHBlci10Y2cuaCBiL2luY2x1ZGUvZXhlYy9oZWxwZXItdGNnLmgKaW5kZXggNTczYzJj
ZS4uMjc4NzA1MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9leGVjL2hlbHBlci10Y2cuaAorKysgYi9p
bmNsdWRlL2V4ZWMvaGVscGVyLXRjZy5oCkBAIC01Miw2ICs1MiwxMiBAQAogICAgIHwgZGhfc2l6
ZW1hc2sodDIsIDIpIHwgZGhfc2l6ZW1hc2sodDMsIDMpIHwgZGhfc2l6ZW1hc2sodDQsIDQpIFwK
ICAgICB8IGRoX3NpemVtYXNrKHQ1LCA1KSB8IGRoX3NpemVtYXNrKHQ2LCA2KSB9LAogCisjZGVm
aW5lIERFRl9IRUxQRVJfRkxBR1NfNyhOQU1FLCBGTEFHUywgcmV0LCB0MSwgdDIsIHQzLCB0NCwg
dDUsIHQ2LCB0NykgXAorICB7IC5mdW5jID0gSEVMUEVSKE5BTUUpLCAubmFtZSA9IHN0cihOQU1F
KSwgLmZsYWdzID0gRkxBR1MsIFwKKyAgICAuc2l6ZW1hc2sgPSBkaF9zaXplbWFzayhyZXQsIDAp
IHwgZGhfc2l6ZW1hc2sodDEsIDEpIFwKKyAgICB8IGRoX3NpemVtYXNrKHQyLCAyKSB8IGRoX3Np
emVtYXNrKHQzLCAzKSB8IGRoX3NpemVtYXNrKHQ0LCA0KSBcCisgICAgfCBkaF9zaXplbWFzayh0
NSwgNSkgfCBkaF9zaXplbWFzayh0NiwgNikgfCBkaF9zaXplbWFzayh0NywgNykgfSwKKwogI2lu
Y2x1ZGUgImhlbHBlci5oIgogI2luY2x1ZGUgInRyYWNlL2dlbmVyYXRlZC1oZWxwZXJzLmgiCiAj
aW5jbHVkZSAidGNnLXJ1bnRpbWUuaCIKQEAgLTY1LDUgKzcxLDYgQEAKICN1bmRlZiBERUZfSEVM
UEVSX0ZMQUdTXzQKICN1bmRlZiBERUZfSEVMUEVSX0ZMQUdTXzUKICN1bmRlZiBERUZfSEVMUEVS
X0ZMQUdTXzYKKyN1bmRlZiBERUZfSEVMUEVSX0ZMQUdTXzcKIAogI2VuZGlmIC8qIEhFTFBFUl9U
Q0dfSCAqLwotLSAKMi43LjQKCg==

