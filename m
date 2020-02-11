Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891DC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0571E20733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mc5z8msb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jev-0006ZB-4I
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbu-0000yQ-DU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-00056I-3g
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbr-0004qc-50
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381663; x=1612917663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Se7/hcenAB1IBo/3miuwzBNQvWOYjY+LQgj0E0kiZrk=;
 b=Mc5z8msbCIDHYMcCwfX4erXXNdDTsWvry+8zCdoUlYrrqoYPGD/V7rPm
 M6xvKJp7H5lROssdac6pPF+ASiBs8SLWviZs2a4v5xTMJdV+KQgEpzVhY
 Oz8nAyjKTsIFtOyKtl+47uQ6e/oOtyLFs3voSa3+f0jirtMbBgN36VVbq U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id B23681BB0; Mon, 10 Feb 2020 18:40:57 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/66] Hexagon GDB Stub
Date: Mon, 10 Feb 2020 18:39:45 -0600
Message-Id: <1581381644-13678-8-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Y3B1LmMKaW5kZXggN2E3ZmM4OS4uMjZiZjk4NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTI3MCw2ICsyNzAsOSBAQCBzdGF0
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
L2dkYnN0dWIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mMDdjYjlhCi0t
LSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCkBAIC0wLDAgKzEsNDkg
QEAKKy8qCisgKiAgQ29weXJpZ2h0IChjKSAyMDE5IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVy
LCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJs
aXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisg
KiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5v
cmcvbGljZW5zZXMvPi4KKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUg
InFlbXUtY29tbW9uLmgiCisjaW5jbHVkZSAiZXhlYy9nZGJzdHViLmgiCisjaW5jbHVkZSAiY3B1
LmgiCisjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKworaW50IGhleGFnb25fZ2RiX3JlYWRfcmVnaXN0
ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikKK3sKKyAgICBIZXhhZ29u
Q1BVICpjcHUgPSBIRVhBR09OX0NQVShjcyk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSAm
Y3B1LT5lbnY7CisKKyAgICBpZiAobiA8IFRPVEFMX1BFUl9USFJFQURfUkVHUykgeworICAgICAg
ICByZXR1cm4gZ2RiX2dldF9yZWdsKG1lbV9idWYsIGVudi0+Z3ByW25dKTsKKyAgICB9CisKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiAwOworfQorCitpbnQgaGV4YWdv
bl9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQg
bikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhBR09OX0NQVShjcyk7CisgICAgQ1BVSGV4
YWdvblN0YXRlICplbnYgPSAmY3B1LT5lbnY7CisKKyAgICBpZiAobiA8IFRPVEFMX1BFUl9USFJF
QURfUkVHUykgeworICAgICAgICBlbnYtPmdwcltuXSA9IGxkdHVsX3AobWVtX2J1Zik7CisgICAg
ICAgIHJldHVybiBzaXplb2YodGFyZ2V0X3Vsb25nKTsKKyAgICB9CisKKyAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIHJldHVybiAwOworfQotLSAKMi43LjQKCg==

