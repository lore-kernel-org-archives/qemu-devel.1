Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5039B2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJO33EC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5039B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZkU-00042G-EW
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:30:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZin-0002vp-Pu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZil-0007Ie-T1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:29 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:43922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZil-0007Hc-Ot
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:27 -0400
Received: by mail-yb1-xb44.google.com with SMTP id n145so1485153ybg.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=CNtLSsppNDq+qCEdta/UyzFB0xSoIc+vMFY+eO0LpIo=;
	b=BJO33EC3dc+1GlCW3R0VHfkl3T4pzUvt5KRIQuUjBCwhbwXo0iMvXjFAhgTdIAPYaF
	iCP5cM2ErgGDzfSPCuql6BCogt4SihuPMab9OcKsH/e/4xRJBviFAiqnmqoJnl9ycvij
	IUF4Sl4SoIgb5/3+dIsOif1M0USHSG9WJghQ812MOIM1zrnv3M1rV1oaweaWKZsg8h64
	26kqeMZz0lkOzAQcBGoacwlEl8osbKt1Tteb02wKhxFDOX4ul6vuAB3GadXpVsukf622
	P937WRO3K6VIMRkYjUQBH2HwL/ql+svqA0FtL5Gsnnrs7o0P0Z8OIkV58UdITMCkhcuB
	7adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=CNtLSsppNDq+qCEdta/UyzFB0xSoIc+vMFY+eO0LpIo=;
	b=VYRxOYD5a1vOm0HvrxYtVowalhJpckG6frd+XN+GVw8ZZb7VbKhKacfh72d4B34dSD
	EpHJcOD+SpAPQT5nOWw6XVfbZ3EZnDkAB643gxNrDJXpoL0eFzMwmUqMw1vOPTfg3xJe
	eqRMHhrSq9Y0aHHM5kbSxwLYTujTodAwzssyOY0crjfinjumVyne9YfVkaXgid0+vbUR
	m9T7LGazSgti3cXbvwmsXGx3FghMydB5A8vWzlqZGK6k5wSG//qLZrt+zejxIGtYQ05S
	/YJBwN3f2+cGeakut20ej/inXH8iwnGQ1vn4t1eK5DEWfaC86J7EJQ9ANMdC/8Qc65Pt
	K0kQ==
X-Gm-Message-State: APjAAAVDHkmaG3vDsGRSlKD3B/Rvmol9BXRkB1ifWvD2jIfrQ3cAIvlH
	ufcuw0Gt34/MOaYY9Yeg8ccGeRk+WwI=
X-Google-Smtp-Source: APXvYqzTUGwKas+/XnQLZVFo8PtmkSP6ZFQkRiPeHCg56JpbkSOOLUUa+D+DoQfVAu7mlg3wuOqUUA==
X-Received: by 2002:a25:e04d:: with SMTP id x74mr17250123ybg.511.1558564105372;
	Wed, 22 May 2019 15:28:25 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:06 -0400
Message-Id: <20190522222821.23850-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [PULL 01/16] tcg/i386: Fix dupi/dupm for avx1 and
 32-bit hosts
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VBROADCASTSD instruction only allows %ymm registers as destination.
Rather than forcing VEX.L and writing to the entire 256-bit register,
revert to using MOVDDUP with an %xmm register.  This is sufficient for
an avx1 host since we do not support TCG_TYPE_V256 for that case.

Also fix the 32-bit avx2, which should have used VPBROADCASTW.

Fixes: 1e262b49b533
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index aafd01cb49..b3601446cd 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -358,6 +358,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
 #define OPC_MOVD_VyEy   (0x6e | P_EXT | P_DATA16)
 #define OPC_MOVD_EyVy   (0x7e | P_EXT | P_DATA16)
+#define OPC_MOVDDUP     (0x12 | P_EXT | P_SIMDF2)
 #define OPC_MOVDQA_VxWx (0x6f | P_EXT | P_DATA16)
 #define OPC_MOVDQA_WxVx (0x7f | P_EXT | P_DATA16)
 #define OPC_MOVDQU_VxWx (0x6f | P_EXT | P_SIMDF3)
@@ -921,7 +922,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     } else {
         switch (vece) {
         case MO_64:
-            tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSD, r, 0, base, offset);
+            tcg_out_vex_modrm_offset(s, OPC_MOVDDUP, r, 0, base, offset);
             break;
         case MO_32:
             tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSS, r, 0, base, offset);
@@ -963,12 +964,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else if (have_avx2) {
             tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD, ret);
+            tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
         }
         new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
     } else {
         if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD + vex_l, ret);
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
         } else {
             tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
         }
-- 
2.17.1


