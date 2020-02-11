Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B6C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA420733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dRO+1fcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jer-0006Mq-06
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-0000yN-Gx
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbq-0004xO-RZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:04 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbq-0004qc-Ec
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381662; x=1612917662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MC1SEBGpm/yv01knW9N91nqMszaqrmn3EVDP/ruP7Ik=;
 b=dRO+1fcHwYjJYoa/wvoS0svbI61HHEg1uIUS9T+Z+k+R4FdzVXuZGco8
 aTVEE/1tJ/7QJmWoM/xnh6tm5/mo0pEqLZ1L7Z+Yrjw0ZIyH88opGtSgC
 PAjS7ue3+WH8hUVJJihe1/YpJAie1qdq+tyWLX20gungtv5XL4Aa6ZmeV 0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:57 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 51F3D1B5B; Mon, 10 Feb 2020 18:40:57 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/66] Hexagon register names
Date: Mon, 10 Feb 2020 18:39:42 -0600
Message-Id: <1581381644-13678-5-git-send-email-tsimpson@quicinc.com>
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

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2hleF9yZWdzLmggfCA5NyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYmExYWUxMAotLS0gL2Rldi9udWxs
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTAsMCArMSw5NyBAQAorLyoKKyAq
ICBDb3B5cmlnaHQgKGMpIDIwMTkgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxs
IFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQor
ICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhl
IExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAq
CisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2ls
bCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2Vp
dmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3
aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNl
cy8+LgorICovCisKKyNpZm5kZWYgSEVYX1JFR1NfSAorI2RlZmluZSBIRVhfUkVHU19ICisKKyNk
ZWZpbmUgSEVYX1JFR19SMDAgMAorI2RlZmluZSBIRVhfUkVHX1IwMSAxCisjZGVmaW5lIEhFWF9S
RUdfUjAyIDIKKyNkZWZpbmUgSEVYX1JFR19SMDMgMworI2RlZmluZSBIRVhfUkVHX1IwNCA0Cisj
ZGVmaW5lIEhFWF9SRUdfUjA1IDUKKyNkZWZpbmUgSEVYX1JFR19SMDYgNgorI2RlZmluZSBIRVhf
UkVHX1IwNyA3CisjZGVmaW5lIEhFWF9SRUdfUjA4IDgKKyNkZWZpbmUgSEVYX1JFR19SMDkgOQor
I2RlZmluZSBIRVhfUkVHX1IxMCAxMAorI2RlZmluZSBIRVhfUkVHX1IxMSAxMQorI2RlZmluZSBI
RVhfUkVHX1IxMiAxMgorI2RlZmluZSBIRVhfUkVHX1IxMyAxMworI2RlZmluZSBIRVhfUkVHX1Ix
NCAxNAorI2RlZmluZSBIRVhfUkVHX1IxNSAxNQorI2RlZmluZSBIRVhfUkVHX1IxNiAxNgorI2Rl
ZmluZSBIRVhfUkVHX1IxNyAxNworI2RlZmluZSBIRVhfUkVHX1IxOCAxOAorI2RlZmluZSBIRVhf
UkVHX1IxOSAxOQorI2RlZmluZSBIRVhfUkVHX1IyMCAyMAorI2RlZmluZSBIRVhfUkVHX1IyMSAy
MQorI2RlZmluZSBIRVhfUkVHX1IyMiAyMgorI2RlZmluZSBIRVhfUkVHX1IyMyAyMworI2RlZmlu
ZSBIRVhfUkVHX1IyNCAyNAorI2RlZmluZSBIRVhfUkVHX1IyNSAyNQorI2RlZmluZSBIRVhfUkVH
X1IyNiAyNgorI2RlZmluZSBIRVhfUkVHX1IyNyAyNworI2RlZmluZSBIRVhfUkVHX1IyOCAyOAor
I2RlZmluZSBIRVhfUkVHX1IyOSAyOQorI2RlZmluZSBIRVhfUkVHX1NQIDI5CisjZGVmaW5lIEhF
WF9SRUdfRlAgMzAKKyNkZWZpbmUgSEVYX1JFR19SMzAgMzAKKyNkZWZpbmUgSEVYX1JFR19MUiAz
MQorI2RlZmluZSBIRVhfUkVHX1IzMSAzMQorI2RlZmluZSBIRVhfUkVHX1NBMCAzMgorI2RlZmlu
ZSBIRVhfUkVHX0xDMCAzMworI2RlZmluZSBIRVhfUkVHX1NBMSAzNAorI2RlZmluZSBIRVhfUkVH
X0xDMSAzNQorI2RlZmluZSBIRVhfUkVHX1AzXzAgMzYKKyNkZWZpbmUgSEVYX1JFR19NMCAzOAor
I2RlZmluZSBIRVhfUkVHX00xIDM5CisjZGVmaW5lIEhFWF9SRUdfVVNSIDQwCisjZGVmaW5lIEhF
WF9SRUdfUEMgNDEKKyNkZWZpbmUgSEVYX1JFR19VR1AgNDIKKyNkZWZpbmUgSEVYX1JFR19HUCA0
MworI2RlZmluZSBIRVhfUkVHX0NTMCA0NAorI2RlZmluZSBIRVhfUkVHX0NTMSA0NQorI2RlZmlu
ZSBIRVhfUkVHX1VQQ1lDTEVMTyA0NgorI2RlZmluZSBIRVhfUkVHX1VQQ1lDTEVISSA0NworI2Rl
ZmluZSBIRVhfUkVHX0ZSQU1FTElNSVQgNDgKKyNkZWZpbmUgSEVYX1JFR19GUkFNRUtFWSA0OQor
I2RlZmluZSBIRVhfUkVHX1BLVENOVExPIDUwCisjZGVmaW5lIEhFWF9SRUdfUEtUQ05USEkgNTEK
Ky8qIFVzZSByZXNlcnZlZCBjb250cm9sIHJlZ2lzdGVycyBmb3IgcWVtdSBleGVjdXRpb24gY291
bnRzICovCisjZGVmaW5lIEhFWF9SRUdfUUVNVV9QS1RfQ05UIDUyCisjZGVmaW5lIEhFWF9SRUdf
UUVNVV9JTlNOX0NOVCA1MworI2RlZmluZSBIRVhfUkVHX1FFTVVfSFZYX0NOVCA1NAorI2RlZmlu
ZSBIRVhfUkVHX1VUSU1FUkxPIDYyCisjZGVmaW5lIEhFWF9SRUdfVVRJTUVSSEkgNjMKKworI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIEhFWF9SRUdfU0dQMCA2NAorI2RlZmluZSBI
RVhfUkVHX1NHUDEgNjUKKyNkZWZpbmUgSEVYX1JFR19TVElEIDY2CisjZGVmaW5lIEhFWF9SRUdf
RUxSIDY3CisjZGVmaW5lIEhFWF9SRUdfQkFEVkEwIDY4CisjZGVmaW5lIEhFWF9SRUdfQkFEVkEx
IDY5CisjZGVmaW5lIEhFWF9SRUdfU1NSIDcwCisjZGVmaW5lIEhFWF9SRUdfQ0NSIDcxCisjZGVm
aW5lIEhFWF9SRUdfSFRJRCA3MgorI2RlZmluZSBIRVhfUkVHX0JBRFZBIDczCisjZGVmaW5lIEhF
WF9SRUdfSU1BU0sgNzQKKyNkZWZpbmUgSEVYX1JFR19HRVZCIDc1CisjZW5kaWYKKworI2VuZGlm
Ci0tIAoyLjcuNAoK

