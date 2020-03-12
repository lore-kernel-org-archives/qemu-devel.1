Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F8C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC67205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Htm7rd1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC67205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU65-0003Py-4y
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjT-0006C9-1E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjR-0002Ht-JK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjR-0002Ha-Do
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id 37so3558674pgm.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QJvhSRp707cxdamQl0vVDLxpjNb38jwO6L+jNT02qis=;
 b=Htm7rd1qhbD8wYpn5xGztYpEq7moH6Jqt1IzRBbiBRgtuNx6WRyILUK157ppeHE11z
 Ntq3SN/Mx+rNPDIH7aP7HoowgFWkZvaidtuf7SAyJ7gd7Duns+0n9KNCTJAwiAtMlmdT
 P2AuJ8hxcGowmVL0H+ZMvv5REOrgO5E+0vSgMKVTQ5R5LOalwjkw9MYBegqfUdGbvCIx
 n4BUVwtAnUMqp4gwyrr1xJwpWBc3ETjt0+MoXvkZgU41btzfrAD7tH93PxZGikxW/lxJ
 6ViOLGedLDXtWkYtdHM9TsDZHJFfBTarLgN8ssPXDz8enlXnG/uZk1qR8WBYv1Pj98Zi
 Pekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QJvhSRp707cxdamQl0vVDLxpjNb38jwO6L+jNT02qis=;
 b=PB5xaJfuXBZy9zy+gCkhhL5TMgH+Tmjy01k3bTwOaYgVJad7xo1wpe1MpP1WMCBJYH
 KMluabD3g6n9gZTXonn7U9bBoEd6VtKrNVJWdXigYu5bAXlMen82lMwYDV+H7CjMrUDF
 V3vq/VB2Wzz5mYr9JSC5nrOQy0+XLzQIM7tsMnUTxGC3rdJTZRRlqjsYTUKjc0lzGfIc
 +TL/7WTkYdOKqlzPh5vgxqg+h7m1DoDhnpLAfQk2AorHFTkznc5q8eor6Sf3fXutZY9p
 dFjYxr4scgK74xHT+zNF4z1+vSB0XVBBL/bey93TywAen0qXmnuMdDeJrIDYCnRf56Bh
 54uA==
X-Gm-Message-State: ANhLgQ2BOxEVuTXqzhH5LWl/Z3j3C+jadvst4Aj/KwdL1du9G5W2CQRg
 GYPo4K0VgfyCRUhVfRfrVDu0XUYPH1U=
X-Google-Smtp-Source: ADFU+vuTJzcTioii6xrC8Sx0g8tv+L/giG2Iml54SBRGew7tYRXGyHeSXVM1pQghu8G39Rarzzs3VQ==
X-Received: by 2002:a62:16d2:: with SMTP id 201mr7235600pfw.295.1584042180076; 
 Thu, 12 Mar 2020 12:43:00 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 29/42] target/arm: Use mte_checkN for sve unpredicated
 stores
Date: Thu, 12 Mar 2020 12:42:06 -0700
Message-Id: <20200312194219.24406-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index 82ea70cf63..4e71501838 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1124,6 +1124,7 @@ DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, int)
+DEF_HELPER_FLAGS_4(sve_str, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ede72a2989..2396737420 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4191,7 +4191,7 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
 }
 
 /*
- * Load contiguous data, unpredicated.
+ * Load/store contiguous data, unpredicated.
  *
  * Note that unpredicated load/store of vector/predicate registers
  * are defined as a stream of bytes, which equates to little-endian
@@ -4261,6 +4261,67 @@ void HELPER(sve_ldr)(CPUARMState *env, void *vd, target_ulong addr, int size)
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
+        cpu_stq_data_ra(env, addr + i, le_bswap64(val), ra);
+    }
+
+    /* Predicate load length may be any multiple of 2. */
+    if (unlikely(i != size)) {
+        val = *(uint64_t *)(vd + i);
+        if (size & 4) {
+            cpu_stl_data_ra(env, addr + i, le_bswap32(val), ra);
+            i += 4;
+            val >>= 32;
+        }
+        if (size & 2) {
+            cpu_stw_data_ra(env, addr + i, le_bswap16(val), ra);
+        }
+    }
+}
+
 /*
  * Analyse contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e55f8835bb..49d2e68564 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4430,78 +4430,52 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
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
2.20.1


