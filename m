Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48263FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D41F205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D41F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiYC-0002Kq-8L
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mkysel@tachyum.com>) id 1iKdoH-0001Lu-9h
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mkysel@tachyum.com>) id 1iKdoG-0007d6-3H
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:33:29 -0400
Received: from mail.tachyum.com ([66.160.133.170]:48174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mkysel@tachyum.com>) id 1iKdoF-0007cl-UD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:33:28 -0400
Received: from THQ-IP-EX1.tachyum.com (relayhost.tachyum.com [10.7.1.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tachyum.com (Postfix) with ESMTPS id BEEA919F;
 Wed, 16 Oct 2019 00:36:30 -0700 (PDT)
Received: from tachyum-sk-server.tachyum.com (10.7.241.13) by
 THQ-IP-EX1.tachyum.com (10.7.1.6) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1779.2; Wed, 16
 Oct 2019 00:33:24 -0700
From: Matus Kysel <mkysel@tachyum.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] Added hardfloat conversion from float32 to float64
Date: Wed, 16 Oct 2019 09:32:40 +0200
Message-ID: <20191016073240.12473-1-mkysel@tachyum.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.241.13]
X-ClientProxiedBy: THQ-IP-EX1.tachyum.com (10.7.1.6) To THQ-IP-EX1.tachyum.com
 (10.7.1.6)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.160.133.170
X-Mailman-Approved-At: Wed, 16 Oct 2019 08:35:10 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reintroduce float32_to_float64 that was removed here:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00455.html

 - nbench test it not actually calling this function at all
 - SPECS 2006 significat number of tests impoved their runtime, just
   few of them showed small slowdown

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
---
 fpu/softfloat.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0638c9f4e0..e28ea3f933 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1920,13 +1920,26 @@ float16 float32_to_float16(float32 a, bool ieee, float_status *s)
     return float16a_round_pack_canonical(pr, s, fmt16);
 }
 
-float64 float32_to_float64(float32 a, float_status *s)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float32_to_float64(float32 a, float_status *s)
 {
     FloatParts p = float32_unpack_canonical(a, s);
     FloatParts pr = float_to_float(p, &float64_params, s);
     return float64_round_pack_canonical(pr, s);
 }
 
+float64 float32_to_float64(float32 a, float_status *status)
+{
+    if (unlikely(!float32_is_normal(a))) {
+        return soft_float32_to_float64(a, status);
+    } else if (float32_is_zero(a)) {
+        return float64_set_sign(float64_zero, float32_is_neg(a));
+    } else {
+        double r = *(float *)&a;
+        return *(float64 *)&r;
+    }
+}
+
 float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-- 
2.17.1


