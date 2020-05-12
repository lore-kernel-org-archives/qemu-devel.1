Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8112C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A59205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMMnD5DE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A59205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY0c-0003uX-Ju
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw4-0006Le-K4
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw3-000661-KY
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id l17so2743943wrr.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gZbv4QYcMc4ag+mpEYLSIdSn4AsHk1XrMWDwADXwYkg=;
 b=xMMnD5DEWU3BaUbIVBPyfDy31d3E/yCJj/GqOcmztx/qiVjsvT+9dklvlkwReZs16h
 pg/Ivm9Djal4nzGKl269LMqr/e6KZdxNpr80Jad3FEIaqjw6yk/KRTzxSxLmN7t/Kgsx
 j0/p+RjW+/WB/B1qbuBJQx0twGdf7o0bAo23la1Beip881N0qU+4k7vxC34iALddmfCv
 r30ixA/6EtZz2HHUAule/9kd4qN5oeoQBpUgDPoSFlIREW9cL1b2ykbbL23Fb2vv1EVe
 M2NPASvUcNsHaEJho+fWP5skEmb/TmBz7dDz9Er1/rFSThJh/sn8kr9dLgZp5mMihBW2
 WRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gZbv4QYcMc4ag+mpEYLSIdSn4AsHk1XrMWDwADXwYkg=;
 b=t3wJ00WwuBKXUQobsySNlDS0ITMojjXTIiE0yMiMGgetX956viApYQbADbqQjrryY1
 qdw7/lCz8AaiOBUwbF9vZj++2F7rGTVE1JDFuRYjXaSP/zHUncVD2mHUxa7NvmjmKCpp
 Za5ZdngsUFRplwDIJzimDPW+VgOZmX7cfb5r0DO/38HPcdCqjRzoBqn3GZEiIn1Sfuzr
 +XZC+BfbPcjxRggkOkJLa0KpozWoFXPCOTLO+H4snpX1LO1DCgpQxoO6P7x7j0CMEhTA
 NooHKiP2URoDjwYUlwZJ9b6DlE3DfsQ4NizxrG61MRr5PW4cnHG3Oq+VTypLsP3R3+zi
 Pq1w==
X-Gm-Message-State: AGi0PuZPoobdPDMPDLK/mi8AXGbxkfo6WwFv8Nxb08Ydjek4spmaBjbs
 uwkt+U1AlsSuSMGCtwarUyZMYA==
X-Google-Smtp-Source: APiQypLpTKZ/Px02HZFsIQRf/Yr6ofKjxtIBqNbQXbqr90+nKUFnT/4rJUt7MbApk5cfdyDDGmNHLg==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr15447595wrw.238.1589301554341; 
 Tue, 12 May 2020 09:39:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] target/arm: Convert Neon VABA/VABD 3-reg-same to
 decodetree
Date: Tue, 12 May 2020 17:38:52 +0100
Message-Id: <20200512163904.10918-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VABA and VABD insns in the 3-reg-same group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  6 ++++++
 target/arm/translate-neon.inc.c |  4 ++++
 target/arm/translate.c          | 22 ++--------------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 3432aacfe90..25c08a4170d 100644
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


