Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AE5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AF820706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKWu5Ci7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AF820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqUD-00009V-Hb
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4U-00035i-F6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4S-0006e7-2P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so9850422wrv.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=U8ufgvqYK3hpRYE+4k7AYm9MeUEmx7S8bSgnZErBoqM=;
 b=hKWu5Ci7gMmoPRowGDelLy+TaMhDgiRlZDIfA//8f87Nqk9SWXp847zZYPOgB4C6bS
 1ATjY8w9o7jSXa2P5KwxRTQNjAYjinSu/+5jmYYTGQSw7GRioFkAjP9BucQoQ1WBg9II
 ZDZuoVl2ktMq91wTpnlBcuLR236Vs21ziqHoSOWLLxVDNqaFjaJkSmpSBkzUNN0jpjMV
 XnDU/HsOCem0LgiP66xL7pEmL3eHeU70T0X+9sqhmaF4aU02nVQJqO+ejpMdEerly0gj
 AksyZXR1bgGuY+QNIR/MwjDZe9DcquuBKRDwgTJ0iMRmGLyKrlLkHr99ZHEhEcaiQOUz
 dBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U8ufgvqYK3hpRYE+4k7AYm9MeUEmx7S8bSgnZErBoqM=;
 b=eIk25b5mVxVeeevyzxkxJGXiVBDZqBB7a7uS4vAdDFXVo5BBnHknBxQTAd8c66VFoZ
 ERa1yCWLa+yBw9scLhx93t2PO/ncAQGZpE0yq7pYugL2+ldNqKW8CIAj+30eDSikDZ77
 bfu3PQLs6HWGBuLbVfkAuseBhs2flofOGmX04rSVjryExhiFBTiX/0mkzOvE6o1U8/Am
 giOwFidsFfO9zSlYutIPX/NbYClQ1z60NVhBeFiISLxCuD8Nv8CGGUua4LFmc0BcGdWR
 BHPjn+aQIljkGBy+WVjtE98kvJw4+8IgxITEVshnaaS7P25WgbfCG2FNlTY/AvNOq8nh
 TD8A==
X-Gm-Message-State: AOAM533u1uNmL5nXG2WzLTbsZCSVIXb8pRROwR0KiK3hufyxPIgyz4mb
 K9x5XQAXFTnDsN+pk0zUhXd6Wqen9/E4lA==
X-Google-Smtp-Source: ABdhPJyiOnmOObK63ekVL7Duruni++2EWE+P/tIgH73CcqPpv0DVGMJ0jAsglDLrmM1gDFKQ3RQPMg==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4218476wru.418.1593184513698; 
 Fri, 26 Jun 2020 08:15:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/57] target/arm: Use mte_checkN for sve unpredicated loads
Date: Fri, 26 Jun 2020 16:14:07 +0100
Message-Id: <20200626151424.30117-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ac7b3119e5f..11e0dfc2100 100644
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
2.20.1


