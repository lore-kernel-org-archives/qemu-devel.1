Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0336BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEDD205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgkINLD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEDD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF4T-0000Ie-RA
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkj-0003iM-Ny
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEki-0005zy-Qd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id w19so18169172wmc.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=khtYLesfntqxGwgjt4r8RE8kHiKfsBiasF1UZsQAzKM=;
 b=zgkINLD2Jx/J2lxLeVLzr+MxyQQ56T0vUOg4Kngh5fsZ4pzk48RCGmpHeCKxW4EIZ1
 ZYQPOcEPfpdewINkzcLcu2qlYNDS1MLkGkV7qH92e8tiRedzLw7VphHWNCdCCT96IWYa
 e/R32aPHpqCpM7gEZpM702Y+fsmwQUSo7SA5ZU9BgqP0oLBQbcUYSHglsYZSN13G9fp9
 biNjpx1zLCgQrMlRghPsbdJOeJql42/yHGlgiBlKqFiuypG9HhpGZzx08poP2vAvE1mi
 yuatyvucEQJGRm/Tev6M9TpuadF3VVQKxJoswvE029YyA7i6Hbrj3XNt7sFvHxIytsNM
 tmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=khtYLesfntqxGwgjt4r8RE8kHiKfsBiasF1UZsQAzKM=;
 b=Ih93D2XfLuWCzuvVicGRpMYPpTUGagPROI5pkl9WumGypu7RNz7DH8tt9cGS6tjpCo
 m0DAWhuJJlWDANxBBfXiiKtlEicCDb8fkL3QP2lfBNvXgjwRgWwe04IAygUF+YLRTJcO
 PB2fNcAQWmVlFIwwI7w4mxDqrfCFO2MuA95rKEvcNzFGhY8i48NYgZ+7SG6f6QZ/cUVn
 o09zXXVygew8AhW8B7xs5mwpt8ZmiKTrHQRTrvf91jiigtznHcW1GibCJYiXCI0Exmxg
 Z4UxD1wFTMUapJmaCYcLdYaSZdpbKEIGNCa4ERvT4Vy8W9G2SQLmu5KTcedTe/ett2+C
 jFIA==
X-Gm-Message-State: AGi0PuYFa5Y2kHLCR+AL/QEhtV7d6P3s1ubHx3oQef4tlX4YiD5o2dtz
 DapzXdTwQwkU/LfNtf554/XI4iRmnQZHIQ==
X-Google-Smtp-Source: APiQypK/OqbdUUuRUMlwprWts3/1gSX7ywU0ajEnvwZrqwYfZj74ll9ylARXLGSgxRgLGs7YLHU5vQ==
X-Received: by 2002:a05:600c:40d:: with SMTP id
 q13mr39377437wmb.69.1589466143184; 
 Thu, 14 May 2020 07:22:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/45] target/arm: Convert Neon VABA/VABD 3-reg-same to
 decodetree
Date: Thu, 14 May 2020 15:21:26 +0100
Message-Id: <20200514142138.20875-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VABA and VABD insns in the 3-reg-same group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-6-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  6 ++++++
 target/arm/translate-neon.inc.c |  4 ++++
 target/arm/translate.c          | 22 ++--------------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 8120d8d5f2d..00a909a8884 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -101,6 +101,12 @@ VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
 VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
 
+VABD_S_3s        1111 001 0 0 . .. .... .... 0111 . . . 0 .... @3same
+VABD_U_3s        1111 001 1 0 . .. .... .... 0111 . . . 0 .... @3same
+
+VABA_S_3s        1111 001 0 0 . .. .... .... 0111 . . . 1 .... @3same
+VABA_U_3s        1111 001 1 0 . .. .... .... 0111 . . . 1 .... @3same
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0418a84a7de..20f0f2c8d83 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -641,6 +641,10 @@ DO_3SAME_NO_SZ_3(VMUL, tcg_gen_gvec_mul)
 DO_3SAME_NO_SZ_3(VMLA, gen_gvec_mla)
 DO_3SAME_NO_SZ_3(VMLS, gen_gvec_mls)
 DO_3SAME_NO_SZ_3(VTST, gen_gvec_cmtst)
+DO_3SAME_NO_SZ_3(VABD_S, gen_gvec_sabd)
+DO_3SAME_NO_SZ_3(VABA_S, gen_gvec_saba)
+DO_3SAME_NO_SZ_3(VABD_U, gen_gvec_uabd)
+DO_3SAME_NO_SZ_3(VABA_U, gen_gvec_uaba)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8d856ccfe96..2c842df4451 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5421,26 +5421,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             /* VQRDMLSH : handled by decodetree */
             return 1;
 
-        case NEON_3R_VABD:
-            if (u) {
-                gen_gvec_uabd(size, rd_ofs, rn_ofs, rm_ofs,
-                              vec_size, vec_size);
-            } else {
-                gen_gvec_sabd(size, rd_ofs, rn_ofs, rm_ofs,
-                              vec_size, vec_size);
-            }
-            return 0;
-
-        case NEON_3R_VABA:
-            if (u) {
-                gen_gvec_uaba(size, rd_ofs, rn_ofs, rm_ofs,
-                              vec_size, vec_size);
-            } else {
-                gen_gvec_saba(size, rd_ofs, rn_ofs, rm_ofs,
-                              vec_size, vec_size);
-            }
-            return 0;
-
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
@@ -5455,6 +5435,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VSHL:
         case NEON_3R_SHA:
         case NEON_3R_VHADD:
+        case NEON_3R_VABD:
+        case NEON_3R_VABA:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


