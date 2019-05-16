Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741DC04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7362070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MK3DxNZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7362070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRPDW-0003oW-Mu
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:51:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRPCe-0003Qc-Vi
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRPCd-0004SE-Oa
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:50:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRPCd-0004Pe-IG
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:50:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id w22so2261410pgi.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=lnHmR5//rCygp5fbwxrUdzvHGTBTwwZ1bx7Wka2n92Y=;
	b=MK3DxNZ81l8mQsQM1orLHqfTtK3NjVd8p7Yk6lzV9HzExJabA61QE+VT36W2XGdail
	c2UOlZeekRKGRWfqOQWYcg+X943zVM7K8q2A2GcY+DoeCD75YPZ45Lp8xVOkLz/HgzSK
	wPPtsjMYofL8rMZd93kw9jsKf4+cRhLpekU5SMR+yuqPuH3t2PHnMKc8tiPCB/iEqP/+
	juCFXzfBM6u5CemJxNXnFDwYChf9kXIhRn3eC3UhMaSZlJIQPllaa3hnyujTbYQGmo4O
	KVbrxiI2/vH8+7gXJyNosn0zJpgIf3IvLt3pakpbL6cdtyEqPH6Rwt1jF9zBheuFqIUq
	YucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=lnHmR5//rCygp5fbwxrUdzvHGTBTwwZ1bx7Wka2n92Y=;
	b=Vu0QlaLIghx92D93RWFkWVbJzMxA+9ZIMtSEF8baM47vtC6dvK8y+heI0SIHQZ+SSu
	1U/bWSPjwoBTgDQWp6mvyiv7h0HPruOtPwGYUGyYwJ0JauE3hVUMtbH38j48sucrQqze
	RLTz7xIXl+56gsrE/FrDbfKc8vnq4dhUgS+rgsdtpwG4vc7bOe83ux/+Rwmbr0f5bxaY
	g7zbZISXJ5jUM184XulaJ2nK4ZTGoJxWrTTKDSfQxbc3hW7GbxxeA/6TdYWFNIV6gMaD
	UFYEoxzrfCDghynoKppssn51MO1wOI0DR5OTKSXtbss83qQOTh1BqTnEOVKp2zqP3gx7
	cZ4A==
X-Gm-Message-State: APjAAAWFA5dWFiyYjlQfwI/oEt08qpSW1ZMcTcT0I0woKtrKZ+X2D4W+
	6RIabNs1LfoRk53axlxGxGW96dK1NQ0=
X-Google-Smtp-Source: APXvYqyDc6nVawKhRi5AKIttIvmouYcQlr5SP6cOr1fpqoXvwAb6wRIj9kahycHdVQyvOaSW6ocYUw==
X-Received: by 2002:a62:3085:: with SMTP id
	w127mr34474139pfw.170.1558047017380; 
	Thu, 16 May 2019 15:50:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	s18sm11375741pgg.64.2019.05.16.15.50.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 15:50:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 15:50:15 -0700
Message-Id: <20190516225015.9372-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH] tcg/i386: Fix dupi/dupm for avx1 and 32-bit
 hosts
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
Cc: mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VBROADCASTSD instruction only allows %ymm registers as destination.
Rather than forcing VEX.L and writing to the entire 256-bit register,
revert to using MOVDDUP with an %xmm register.  This is sufficient for
an avx1 host since we do not support TCG_TYPE_V256 for that case.

Also fix the 32-bit avx2, which should have used VPBROADCASTW.

Fixes: 1e262b49b533
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


