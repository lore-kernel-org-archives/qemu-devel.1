Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4427C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ECE2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsGXO/XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ECE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIBX-00048a-Pe
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyh-0004Zk-9j
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyg-0003eV-Bc
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id 185so529575pgb.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uyR9T9oGRaQ7j6mqreds6AjvFFxk3QgOhv9SfFUw7cA=;
 b=wsGXO/XY41ZrbUG+OMMBSYVNXWVkXfimq3NIwi4b97AUZJblU8SLzcNJSGgGZnBPiD
 FxD6ecT+9Z8vOrXsGYHhwRd/YnKHc62hOIe+ygzjh5uLxmXwsx42hflX1t5uLi8X9JKH
 cCtMKPmnhAcDihnGs6DK5CfsAfFLDHK4HmuGFYMCAa3LDmSy05iLJ+8Kc0sK+zG61gvw
 sLqbtnu01tL4MumIvExJ3bAgpe7Rn87Pm+k9uJPwYiSfDVAlH29agAlnf7tpexb+QiLs
 8GTtwhJwFCEL8M1HtCpGHvGiecRSJcjcJuEGFn7L/aDACom6YU9CF8kihAwX4D5tCRH4
 4ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uyR9T9oGRaQ7j6mqreds6AjvFFxk3QgOhv9SfFUw7cA=;
 b=uKR1EusC2UAmWl28aHwiyCI7BKCB3TKWGzodMvaiqb0UZTH9VPP+tPfrH4BJyDu2uN
 SpdnhkPWY3pA+cdBegwtgR6yhpImnsBfgee6kEX+88BXGokW2NUqPPXRZ+OOEEl3Kvh6
 QGKpSTFxyIRH4Yr34LNCZs0Tnf4OxioHkuPB7XUWvT7pIuMHgNsJUDmEZtSiBpjLl4Zj
 J16fv6EQsngIWmE7iRNkJ1Ghe2gWve0+EWO632N+AAPouNwKCfg59XUELzQ34Bp3amzK
 kNwpELDRSbd19CqOW+hy3sjfco8xyC5xy690ZGexyHjahEkb1Qa383Sdq0k2QyYUCndU
 O/9g==
X-Gm-Message-State: AOAM533hsequ6dbGHVriqqUzv11i9O09MdDJJ7k8Wp/ro6jbh0cnQEp6
 n7I0BLmT85822IAwCCtXxLuJdrgWvQE=
X-Google-Smtp-Source: ABdhPJxXvukZrAnfT4SONmnuu50kFg8kC6QrQ2sABkjctQVpshrXJA476djFtDj0AFOjpufHKjxX1A==
X-Received: by 2002:a17:90a:5a07:: with SMTP id
 b7mr2247945pjd.130.1591146836561; 
 Tue, 02 Jun 2020 18:13:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 29/42] target/arm: Use mte_checkN for sve unpredicated
 stores
Date: Tue,  2 Jun 2020 18:13:04 -0700
Message-Id: <20200603011317.473934-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  1 +
 target/arm/sve_helper.c    | 63 ++++++++++++++++++++++++++-
 target/arm/translate-sve.c | 88 ++++++++++++++------------------------
 3 files changed, 94 insertions(+), 58 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 550ae7f7e6..197cd72999 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1139,6 +1139,7 @@ DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, int)
+DEF_HELPER_FLAGS_4(sve_str, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 04340cbe0c..507fba37c9 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4130,7 +4130,7 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
 }
 
 /*
- * Load contiguous data, unpredicated.
+ * Load/store contiguous data, unpredicated.
  *
  * Note that unpredicated load/store of vector/predicate registers
  * are defined as a stream of bytes, which equates to little-endian
@@ -4198,6 +4198,67 @@ void HELPER(sve_ldr)(CPUARMState *env, void *vd, target_ulong addr, int size)
     }
 }
 
+void HELPER(sve_str)(CPUARMState *env, void *vd, target_ulong addr, int size)
+{
+    int mem_idx = cpu_mmu_index(env, false);
+    int in_page = -((int)addr | TARGET_PAGE_MASK);
+    uintptr_t ra = GETPC();
+    uint64_t val;
+    void *host;
+    int i;
+
+    /* Small stores are expanded inline. */
+    tcg_debug_assert(size > 2 * 8);
+
+    if (likely(size <= in_page)) {
+        host = probe_write(env, addr, size, mem_idx, ra);
+        if (likely(host != NULL)) {
+            for (i = 0; i + 8 <= size; i += 8) {
+                stq_le_p(host + i, *(uint64_t *)(vd + i));
+            }
+
+            /* Predicate load length may be any multiple of 2. */
+            if (unlikely(i != size)) {
+                val = *(uint64_t *)(vd + i);
+                if (size & 4) {
+                    stl_le_p(host + i, val);
+                    i += 4;
+                    val >>= 32;
+                }
+                if (size & 2) {
+                    stw_le_p(host + i, val);
+                }
+            }
+            return;
+        }
+    } else {
+        (void)probe_write(env, addr, in_page, mem_idx, ra);
+        (void)probe_write(env, addr + in_page, size - in_page, mem_idx, ra);
+    }
+
+    /*
+     * Note there is no endian-specific target store function, so to handle
+     * aarch64_be-linux-user we need to bswap the big-endian store.
+     */
+    for (i = 0; i + 8 <= size; i += 8) {
+        val = *(uint64_t *)(vd + i);
+        cpu_stq_le_data_ra(env, addr + i, val, ra);
+    }
+
+    /* Predicate load length may be any multiple of 2. */
+    if (unlikely(i != size)) {
+        val = *(uint64_t *)(vd + i);
+        if (size & 4) {
+            cpu_stl_le_data_ra(env, addr + i, val, ra);
+            i += 4;
+            val >>= 32;
+        }
+        if (size & 2) {
+            cpu_stw_le_data_ra(env, addr + i, val, ra);
+        }
+    }
+}
+
 /*
  * Analyse contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 35b979fa13..e515646db2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4410,78 +4410,52 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     int len_remain = len % 8;
     int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
-    TCGv_i64 addr, t0;
+    TCGv_i64 dirty_addr, clean_addr, t0;
+    int i;
+
+    dirty_addr = read_cpu_reg_sp(s, rn, true);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, imm);
+
+    clean_addr = gen_mte_checkN(s, dirty_addr, true, rn != 31, len, MO_8);
+
+    /* Limit tcg code expansion by doing large loads out of line. */
+    if (nparts > 4) {
+        TCGv_ptr t_rd = tcg_temp_new_ptr();
+        TCGv_i32 t_len = tcg_const_i32(len);
+
+        tcg_gen_addi_ptr(t_rd, cpu_env, vofs);
+        gen_helper_sve_str(cpu_env, t_rd, clean_addr, t_len);
+        tcg_temp_free_ptr(t_rd);
+        tcg_temp_free_i32(t_len);
+        return;
+    }
 
-    addr = tcg_temp_new_i64();
     t0 = tcg_temp_new_i64();
-
-    /* Note that unpredicated load/store of vector/predicate registers
-     * are defined as a stream of bytes, which equates to little-endian
-     * operations on larger quantities.  There is no nice way to force
-     * a little-endian store for aarch64_be-linux-user out of line.
-     *
-     * Attempt to keep code expansion to a minimum by limiting the
-     * amount of unrolling done.
-     */
-    if (nparts <= 4) {
-        int i;
-
-        for (i = 0; i < len_align; i += 8) {
-            tcg_gen_ld_i64(t0, cpu_env, vofs + i);
-            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
-        }
-    } else {
-        TCGLabel *loop = gen_new_label();
-        TCGv_ptr t2, i = tcg_const_local_ptr(0);
-
-        gen_set_label(loop);
-
-        t2 = tcg_temp_new_ptr();
-        tcg_gen_add_ptr(t2, cpu_env, i);
-        tcg_gen_ld_i64(t0, t2, vofs);
-
-        /* Minimize the number of local temps that must be re-read from
-         * the stack each iteration.  Instead, re-compute values other
-         * than the loop counter.
-         */
-        tcg_gen_addi_ptr(t2, i, imm);
-        tcg_gen_extu_ptr_i64(addr, t2);
-        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
-        tcg_temp_free_ptr(t2);
-
-        tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
-
-        tcg_gen_addi_ptr(i, i, 8);
-
-        tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
-        tcg_temp_free_ptr(i);
+    for (i = 0; i < len_align; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, vofs + i);
+        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEQ);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
     }
 
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain) {
         tcg_gen_ld_i64(t0, cpu_env, vofs + len_align);
-        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
-
         switch (len_remain) {
-        case 2:
-        case 4:
-        case 8:
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
-            break;
-
         case 6:
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL);
-            tcg_gen_addi_i64(addr, addr, 4);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_shri_i64(t0, t0, 32);
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW);
+            /* fall through */
+        case 2:
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW);
+            break;
+        case 4:
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL);
             break;
-
         default:
             g_assert_not_reached();
         }
     }
-    tcg_temp_free_i64(addr);
     tcg_temp_free_i64(t0);
 }
 
-- 
2.25.1


