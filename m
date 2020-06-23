Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC752082F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ha5HGUKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC752082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnp6j-0006r9-7l
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojn-0004ZF-AL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:43 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojl-0005pe-HS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:42 -0400
Received: by mail-pj1-x1042.google.com with SMTP id u14so1913044pjj.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W/rZx6/dQQS4+8bjQVnnd9qMpghesUglRuSwZ7vUtvw=;
 b=Ha5HGUKejv0XFOetYZTmisMG/dkUnI4OXuLRS1tlXDpjS+ilMoT+UaCvcMj/E5McLs
 YFpwhAIgIBLKULTXpURyP0rZ9wNenvLf5mzkIkgK0+4I15jZoPW7MKnKRieAQkAYH9Qm
 8b4TdVM2klWi0iAL1kxoRT/jqw8Rs3S2sBDtmuA44h2zjeJdNiQdTTRRPU0U+7x6gjpY
 bjvl/K1KcAp5NocAo6rn/4se+fZbg0qcVWidqMdWuIui6Q8TkJVY4x0LziKUPWRe4x9M
 8KjN3yePFvNXX4MUpiuXQinIHpDFxxhiLJpNrfcYBkucgMIyP8Nn/iVozsXbaRp2OFvS
 tZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W/rZx6/dQQS4+8bjQVnnd9qMpghesUglRuSwZ7vUtvw=;
 b=apAbPWVyHrJXgt536/TG7WP/6J1M3i6bJeBiHI2X+F3VUqgssJjh8woziUmJDNkejI
 zYLBMZOku3RwOE4ptuJ9XWLL7m5L1jc/aW+dvjNpqywivKtRPxDE5hV0SqU7Dloc1n14
 ngEueeIx4+hL3ux1L0nhaDUqzOuCdyaoVdIxWhRMjMMgSEAJXw+RpTlDtQvJgP51TDVQ
 AeFD9qQtF0OxFaOGaILWbrMxYpdjaklbiYDWbuPdWNxEhe8ilrH+EOwrdx1LOwfgTeIp
 /HrEivFQsrKdLpKZV4MS0PXh0BGzJ78FnKaWBWoL3fNvJOvyfeAIW7upzpirrnHX1YVa
 CzWA==
X-Gm-Message-State: AOAM5326yWLasVweXHjgsAmUdbN3kfFgLpDH67eIdYM3l+b/Y4VY56Va
 DasrBFls1vDu2FlaHDs+GClY7KoD81o=
X-Google-Smtp-Source: ABdhPJxbEuWuJbH/illEEOpaJ3cnquVmP8ahCTHXguYB7U9BHUVQKGhLdZ4+yq57s1/S789WI31+tA==
X-Received: by 2002:a17:902:9b92:: with SMTP id
 y18mr23782189plp.228.1592941059702; 
 Tue, 23 Jun 2020 12:37:39 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 28/45] target/arm: Use mte_checkN for sve unpredicated loads
Date: Tue, 23 Jun 2020 12:36:41 -0700
Message-Id: <20200623193658.623279-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Drop the out-of-line helper (pmm).
---
 target/arm/translate-sve.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ac7b3119e5..11e0dfc210 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4342,71 +4342,76 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     int len_remain = len % 8;
     int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
-    TCGv_i64 addr, t0, t1;
+    TCGv_i64 dirty_addr, clean_addr, t0, t1;
 
-    addr = tcg_temp_new_i64();
-    t0 = tcg_temp_new_i64();
+    dirty_addr = tcg_temp_new_i64();
+    tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
+    tcg_temp_free_i64(dirty_addr);
 
-    /* Note that unpredicated load/store of vector/predicate registers
+    /*
+     * Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
-     * operations on larger quantities.  There is no nice way to force
-     * a little-endian load for aarch64_be-linux-user out of line.
-     *
+     * operations on larger quantities.
      * Attempt to keep code expansion to a minimum by limiting the
      * amount of unrolling done.
      */
     if (nparts <= 4) {
         int i;
 
+        t0 = tcg_temp_new_i64();
         for (i = 0; i < len_align; i += 8) {
-            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEQ);
             tcg_gen_st_i64(t0, cpu_env, vofs + i);
+            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
         }
+        tcg_temp_free_i64(t0);
     } else {
         TCGLabel *loop = gen_new_label();
         TCGv_ptr tp, i = tcg_const_local_ptr(0);
 
+        /* Copy the clean address into a local temp, live across the loop. */
+        t0 = clean_addr;
+        clean_addr = tcg_temp_local_new_i64();
+        tcg_gen_mov_i64(clean_addr, t0);
+        tcg_temp_free_i64(t0);
+
         gen_set_label(loop);
 
-        /* Minimize the number of local temps that must be re-read from
-         * the stack each iteration.  Instead, re-compute values other
-         * than the loop counter.
-         */
+        t0 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEQ);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+
         tp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tp, i, imm);
-        tcg_gen_extu_ptr_i64(addr, tp);
-        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
-
-        tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
-
         tcg_gen_add_ptr(tp, cpu_env, i);
         tcg_gen_addi_ptr(i, i, 8);
         tcg_gen_st_i64(t0, tp, vofs);
         tcg_temp_free_ptr(tp);
+        tcg_temp_free_i64(t0);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
         tcg_temp_free_ptr(i);
     }
 
-    /* Predicate register loads can be any multiple of 2.
+    /*
+     * Predicate register loads can be any multiple of 2.
      * Note that we still store the entire 64-bit unit into cpu_env.
      */
     if (len_remain) {
-        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
-
+        t0 = tcg_temp_new_i64();
         switch (len_remain) {
         case 2:
         case 4:
         case 8:
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
+                                MO_LE | ctz32(len_remain));
             break;
 
         case 6:
             t1 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUL);
-            tcg_gen_addi_i64(addr, addr, 4);
-            tcg_gen_qemu_ld_i64(t1, addr, midx, MO_LEUW);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 4);
+            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW);
             tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
             tcg_temp_free_i64(t1);
             break;
@@ -4415,9 +4420,9 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
             g_assert_not_reached();
         }
         tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
+        tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(addr);
-    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(clean_addr);
 }
 
 /* Similarly for stores.  */
-- 
2.25.1


