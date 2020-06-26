Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C64C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD6F20709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDVefVrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD6F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofEw-00085N-50
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof64-0008R2-1e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof61-0001rx-Bw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id p3so4364903pgh.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5fYUL4cX+4WQxHc/ZTnx0EOBl/xdpMrdsWF0Wif8Mkw=;
 b=YDVefVrMdDT1pGi50VSX9yT8iQ9bF6PoGPvX21DX+b3Yw16uvEnJc6iYjX6t2/ffGn
 ntnejWW8V7Pgf9EhBok1E740eP/Gxgce9YjTKdZE0WAe4VZbUwG/4EIsjsiJhuiYGAJa
 CJcW1KXpyaLuA+rbYCT/42+vymmNwUIUxJTgSJ7Dkr58qpIJ8MlKDdB62a3SQj5Jq3us
 xtfEfnTssqRBfddVLLDRmYTA465jLLiDENgwPeg+fEe8vZK3dQVoafRptw0sPZsfKptN
 077rycjuP4836/P6tEO+ky18Gpg0J52YsbD5XOO7y1VagezV02noE623eUW67oGxh7rQ
 quIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5fYUL4cX+4WQxHc/ZTnx0EOBl/xdpMrdsWF0Wif8Mkw=;
 b=sttiwWyrEUKNGH+YWWvM8pSxOoRGVtrtsEOW3ELMoMisrPun/ZrRnW82esOO4w6fB7
 vJhu/x+AC0hF7ooH2UZmkBHNbuNMFZ1Z77s0gwe5ynXVdDAaQL51ogxy6SkNdK7LbIlw
 asdxxU1kHHy/uqeGudQQr4jQSWuKteitltebAZc1QDjanZ2QsbKDlct1M+DBOM6Tdgzr
 MH4ZP3cZWM4x+FcjOb32BrUSFcqqILZ9CCgSk05AT2IXMQStVn30ki6LHAX6LEmRNwt1
 XJ8ADd4hV/Y89piJAo6bK4MWgECB8cYBec5yjVIOK8SW/o/JpKWSqukANuPC+bHeHy1W
 7Pzg==
X-Gm-Message-State: AOAM531WMxFXqLURAypEsWP3a1ZtSS3/u6TkfXRBs9VNHJinZ8RcwKYo
 6XQhBXTn6W8naVGhtIx93VtCp2QJ228=
X-Google-Smtp-Source: ABdhPJxFXtNjxmlB8bZg0VToJds7aGOuy4eWV7stnQ8QrqcnkwihV8E2vrOyHhWmNWhPvPpm/cSs4g==
X-Received: by 2002:a62:1c8a:: with SMTP id c132mr860339pfc.69.1593142327662; 
 Thu, 25 Jun 2020 20:32:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 16/46] target/arm: Implement the STGP instruction
Date: Thu, 25 Jun 2020 20:31:14 -0700
Message-Id: <20200626033144.790098-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Handle atomicity, require pre-cleaned address.
v6: Fix constant offset shift, non-checked address, use pre-computed ata.
---
 target/arm/translate-a64.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 436191c15c..e2295a371b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2690,7 +2690,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2715,6 +2715,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2727,6 +2728,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
     if (is_vector) {
         size = 2 + opc;
+    } else if (opc == 1 && !is_load) {
+        /* STGP */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = 3;
+        set_tag = true;
     } else {
         size = 2 + extract32(opc, 1, 1);
         is_signed = extract32(opc, 0, 1);
@@ -2767,7 +2776,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         return;
     }
 
-    offset <<= size;
+    offset <<= (set_tag ? LOG2_TAG_GRANULE : size);
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
@@ -2777,8 +2786,22 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     if (!postindex) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
 
+    if (set_tag) {
+        if (!s->ata) {
+            /*
+             * TODO: We could rely on the stores below, at least for
+             * system mode, if we arrange to add MO_ALIGN_16.
+             */
+            gen_helper_stg_stub(cpu_env, dirty_addr);
+        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+        } else {
+            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
+        }
+    }
+
+    clean_addr = clean_data_tbi(s, dirty_addr);
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
-- 
2.25.1


