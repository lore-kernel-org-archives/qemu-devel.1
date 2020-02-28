Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C43C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F06246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="yQOZ5i5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F06246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jFC-0002mK-2e
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikb-0002mK-Ek
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikZ-0005W3-Ms
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:33 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikZ-0005V5-Dt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908271; x=1614444271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f1wurEAOGurKqRzrZ3zioPMbTJWRw9gHRkOaVFN0r5c=;
 b=yQOZ5i5UQTSstF5VRaSQtTEUbfZaLCTJuvAJD9WqrvfC2qk+AnedlG7M
 S1nZNTu0PSk+tM8btxoE4iaB6G6+f8J1eR0pIHeXScI2QexE4bjN9atFp
 Pxrd1LCkD4FUbeUaKCxdtiOlI6LUV4kncSkc5NdWN/MuX8WVEKyeT5FRo s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:28 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:27 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9C8A7F0B; Fri, 28 Feb 2020 10:44:27 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 08/67] Hexagon GDB Stub
Date: Fri, 28 Feb 2020 10:43:04 -0600
Message-Id: <1582908244-304-9-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Taylor Simpson <tsimpson@quicinc.com>, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

R0RCIHJlZ2lzdGVyIHJlYWQgYW5kIHdyaXRlIHJvdXRpbmVzCgpTaWduZWQtb2ZmLWJ5OiBUYXls
b3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1
LmMgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgfCA0OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2dkYnN0
dWIuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKaW5kZXggOThkNmJkYy4uNTc2YzU2NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTI4OCw2ICsyODgsOSBAQCBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCB2b2lkICpkYXRh
KQogICAgIGNjLT5kdW1wX3N0YXRlID0gaGV4YWdvbl9kdW1wX3N0YXRlOwogICAgIGNjLT5zZXRf
cGMgPSBoZXhhZ29uX2NwdV9zZXRfcGM7CiAgICAgY2MtPnN5bmNocm9uaXplX2Zyb21fdGIgPSBo
ZXhhZ29uX2NwdV9zeW5jaHJvbml6ZV9mcm9tX3RiOworICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKKyAgICBjYy0+Z2RiX3JlYWRfcmVnaXN0ZXIgPSBoZXhh
Z29uX2dkYl9yZWFkX3JlZ2lzdGVyOworICAgIGNjLT5nZGJfd3JpdGVfcmVnaXN0ZXIgPSBoZXhh
Z29uX2dkYl93cml0ZV9yZWdpc3RlcjsKICAgICBjYy0+Z2RiX251bV9jb3JlX3JlZ3MgPSBUT1RB
TF9QRVJfVEhSRUFEX1JFR1M7CiAgICAgY2MtPmdkYl9zdG9wX2JlZm9yZV93YXRjaHBvaW50ID0g
dHJ1ZTsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29uX2NwdV9kaXNhc19zZXRfaW5m
bzsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyBiL3RhcmdldC9oZXhhZ29u
L2dkYnN0dWIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5lNjc4YWVhCi0t
LSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCkBAIC0wLDAgKzEsNDkg
QEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICog
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMg
cHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZl
cnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRl
ciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhv
cGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7
IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElU
WSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5n
bnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNs
dWRlICJxZW11LWNvbW1vbi5oIgorI2luY2x1ZGUgImV4ZWMvZ2Ric3R1Yi5oIgorI2luY2x1ZGUg
ImNwdS5oIgorI2luY2x1ZGUgImludGVybmFsLmgiCisKK2ludCBoZXhhZ29uX2dkYl9yZWFkX3Jl
Z2lzdGVyKENQVVN0YXRlICpjcywgdWludDhfdCAqbWVtX2J1ZiwgaW50IG4pCit7CisgICAgSGV4
YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIENQVUhleGFnb25TdGF0ZSAqZW52
ID0gJmNwdS0+ZW52OworCisgICAgaWYgKG4gPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpIHsKKyAg
ICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVmLCBlbnYtPmdwcltuXSk7CisgICAgfQor
CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICByZXR1cm4gMDsKK30KKworaW50IGhl
eGFnb25fZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpjcywgdWludDhfdCAqbWVtX2J1Ziwg
aW50IG4pCit7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIENQ
VUhleGFnb25TdGF0ZSAqZW52ID0gJmNwdS0+ZW52OworCisgICAgaWYgKG4gPCBUT1RBTF9QRVJf
VEhSRUFEX1JFR1MpIHsKKyAgICAgICAgZW52LT5ncHJbbl0gPSBsZHR1bF9wKG1lbV9idWYpOwor
ICAgICAgICByZXR1cm4gc2l6ZW9mKHRhcmdldF91bG9uZyk7CisgICAgfQorCisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKKyAgICByZXR1cm4gMDsKK30KLS0gCjIuNy40Cgo=

