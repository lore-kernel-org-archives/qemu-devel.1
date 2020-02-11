Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DC9C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3A320733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kZmOLSGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3A320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jds-0004C1-8j
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbv-0000yk-8y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbt-0005Cl-IV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:07 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbs-0004qc-Vl
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381665; x=1612917665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ix28IJ3If3N2mQnG/AFL7EExLSh0OOk09IVbupEHcXo=;
 b=kZmOLSGLtNU7TwsZL3Ob5b3RBdik0ilDqlnywrlJpQa0NNZ348x6q6HU
 xV9exi2XrtgJiBD2vlS8Oelbo+OwCRoge8jdERg0YxOdYEWnSDKh9pRBz
 H8+KRZSqdR0G1Wh1OtQCuGoR9s9/920L4yf+0VznHvaOTKkzESiDiCwm7 k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id AFCFF1BB2; Mon, 10 Feb 2020 18:40:59 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 23/66] Hexagon generator phase 2 - opcodes_def_generated.h
Date: Mon, 10 Feb 2020 18:40:01 -0600
Message-Id: <1581381644-13678-24-git-send-email-tsimpson@quicinc.com>
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

R2l2ZXMgYSBsaXN0IG9mIGFsbCB0aGUgb3Bjb2RlcwoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNp
bXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2RvX3FlbXUu
cHkgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weSBiL3RhcmdldC9oZXhhZ29uL2Rv
X3FlbXUucHkKaW5kZXggNDNhY2RkNy4uNTQzOTk2NCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vZG9fcWVtdS5weQorKysgYi90YXJnZXQvaGV4YWdvbi9kb19xZW11LnB5CkBAIC03ODUsMyAr
Nzg1LDE1IEBAIHJlYWxmLndyaXRlKGYuZ2V0dmFsdWUoKSkKIHJlYWxmLmNsb3NlKCkKIGYuY2xv
c2UoKQogCisjIworIyMgR2VuZXJhdGUgdGhlIG9wY29kZXNfZGVmX2dlbmVyYXRlZC5oIGZpbGUK
KyMjICAgICBHaXZlcyBhIGxpc3Qgb2YgYWxsIHRoZSBvcGNvZGVzCisjIworZiA9IFN0cmluZ0lP
KCkKK2ZvciB0YWcgaW4gdGFnczoKKyAgICBmLndyaXRlICggIk9QQ09ERSglcyksXG4iICUgKHRh
ZykgKQorcmVhbGYgPSBvcGVuKCdvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaCcsICd3dCcpCityZWFs
Zi53cml0ZShmLmdldHZhbHVlKCkpCityZWFsZi5jbG9zZSgpCitmLmNsb3NlKCkKKwotLSAKMi43
LjQKCg==

