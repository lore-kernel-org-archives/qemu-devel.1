Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1FC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638FC20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="zoUQYiT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638FC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JwR-0000Xc-Hf
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 20:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jcq-0002aq-1q
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jco-0002sm-NP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:03 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jco-0004uE-Ch
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381722; x=1612917722;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o6rZHNhUim9nKuHayVFthHBL5v9WUS/mdf9B4FQu3yo=;
 b=zoUQYiT5g6mrIdbBoFqoUCuUmtjaeEYv/CaBpGbR0T7g/3kWrXVp8kCk
 2s2/VGAwXW8hHZEdNQCG6oLW18uSpzvhCGvBEZ4NL/2kmoHTYqhF/07GI
 RO9egqrTbeKCC0G0EY9/LnKSaTU1dSVI1F6SHa9620ev9Koq5oIFiz9uq 0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:41:04 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:04 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id F073F1B76; Mon, 10 Feb 2020 18:41:03 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 66/66] Hexagon HVX build infrastructure
Date: Mon, 10 Feb 2020 18:40:44 -0600
Message-Id: <1581381644-13678-67-git-send-email-tsimpson@quicinc.com>
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
IHRhcmdldC9oZXhhZ29uL01ha2VmaWxlLm9ianMgfCAxMiArKysrKysrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vTWFrZWZpbGUub2JqcyBiL3RhcmdldC9oZXhhZ29uL01ha2VmaWxlLm9ianMK
aW5kZXggZWZjZjUxMC4uM2ZmNTllNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vTWFrZWZp
bGUub2JqcworKysgYi90YXJnZXQvaGV4YWdvbi9NYWtlZmlsZS5vYmpzCkBAIC0xMSw3ICsxMSw5
IEBAIG9iai15ICs9IFwKICAgICBwcmludGluc24ubyBcCiAgICAgYXJjaC5vIFwKICAgICBmbWFf
ZW11Lm8gXAotICAgIGNvbnZfZW11Lm8KKyAgICBjb252X2VtdS5vIFwKKyAgICBtbXZlYy9kZWNv
ZGVfZXh0X21tdmVjLm8gXAorICAgIG1tdmVjL3N5c3RlbV9leHRfbW12ZWMubwogCiAjCiAjICBT
dGVwIDEKQEAgLTI5LDEwICszMSwxNCBAQCBJREVGX0ZJTEVTID0gXAogICAgICQoU1JDX1BBVEgp
L3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21weS5pZGVmIFwKICAgICAkKFNSQ19QQVRIKS90YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9zaGlmdC5pZGVmIFwKICAgICAkKFNSQ19QQVRIKS90YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9zdWJpbnNucy5pZGVmIFwKLSAgICAkKFNSQ19QQVRIKS90YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgorICAgICQoU1JDX1BBVEgpL3RhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmIFwKKyAgICAkKFNSQ19QQVRIKS90YXJnZXQvaGV4YWdv
bi9pbXBvcnRlZC9hbGxleHQuaWRlZiBcCisgICAgJChTUkNfUEFUSCkvdGFyZ2V0L2hleGFnb24v
aW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYKIERFRl9GSUxFUyA9IFwKICAgICAkKFNSQ19QQVRIKS90
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9hbGxpZGVmcy5kZWYgXAotICAgICQoU1JDX1BBVEgpL3Rh
cmdldC9oZXhhZ29uL2ltcG9ydGVkL21hY3Jvcy5kZWYKKyAgICAkKFNSQ19QQVRIKS90YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9tYWNyb3MuZGVmIFwKKyAgICAkKFNSQ19QQVRIKS90YXJnZXQvaGV4
YWdvbi9pbXBvcnRlZC9hbGxleHRfbWFjcm9zLmRlZiBcCisgICAgJChTUkNfUEFUSCkvdGFyZ2V0
L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvbWFjcm9zLmRlZgogCiAkKEdFTl9TRU1BTlRJQ1MpOiAk
KEdFTl9TRU1BTlRJQ1NfU1JDKSAkKElERUZfRklMRVMpICQoREVGX0ZJTEVTKQogCSQoQ0MpICQo
Q0ZMQUdTKSAkKEdFTl9TRU1BTlRJQ1NfU1JDKSAtbyAkKEdFTl9TRU1BTlRJQ1MpCi0tIAoyLjcu
NAoK

