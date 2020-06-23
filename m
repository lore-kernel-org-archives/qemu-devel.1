Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010E02080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiV4ucCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010E02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnp4Q-0003Jk-8b
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojm-0004XB-Cr
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojk-0005p7-DK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so9527931plb.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gKrTT+dRt/uOzYjaOJdvzyZh+nLpblphxozcExWOKo=;
 b=QiV4ucCgx376IdbuX3tT38x2MEQGGEaXNYv1RbG6logpJ3m9JmJL2QCLU2LsLTohMp
 1HD18hycvWno++1TLpPFnlbU9ktqGP4RZUwb2JfMZH3QLW8EtLtipeXHWNtxR9BNuviv
 30WDuF9yfmxWhELMkSBgA1gtk9KQ3LDMFh3CYDF7N6Sl6GRiNOGvQejd+lzZemC0o2cd
 o3aHiHg+FjWPXz2Y5pzKj/foPtgrDu4BnitMtmEBYzSETllvaQyGbdUgIwzFFCkVdNPB
 wMy9pmbECrqC0ulekfIBIDsF/WMk22rO+QNOglG9ovgMuIcGfVYtZ+DmT5PBaI08Hoi9
 K5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gKrTT+dRt/uOzYjaOJdvzyZh+nLpblphxozcExWOKo=;
 b=fhlCGkSqVaD2DWRYrldnLWJc2OMtOWKmUe/gEdLJ61oaxphwIRtAXImcPCbf62f8Ts
 v0nTeLTQ09KWsefLu9qbnvR/c5bPaab4unOM08yR9FC/GBQow5Jda/AY16LR/RKUK+3G
 gMReAmChXcbXc9DPCcOePTP6JW0+MX6SDEIocId+7CN/MCldxNsqn00V4HVYv9g8q4ts
 1D1SeTSK+5f2a2MGCt61aKFMXLmkkqMXom2PhoyszkxsJL32YXIJyDKZ8OtOO8sr+At3
 59fV6oYwj71YV3MIoUVbulsb5nbYKuZpL+/UEale9cddqaAKkw+fV0Kk6Vxyrop79pE4
 27aQ==
X-Gm-Message-State: AOAM5309tkJxfbx2hYCaGrrlBuqToN3QK+JJjaroLt9hQ6AmJMPjE/Et
 j/NbymnWts6cCEpvMNZEzBE3UIDqj90=
X-Google-Smtp-Source: ABdhPJxXyAor+9pvhUsHy32Jp4k9K0mhvn9V8CplKsL/lecjGMTu3rmj7JgeLUHbbUpg6Yq0yKtNVg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr12639763plb.236.1592941058475; 
 Tue, 23 Jun 2020 12:37:38 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 27/45] target/arm: Add helper_mte_check_zva
Date: Tue, 23 Jun 2020 12:36:40 -0700
Message-Id: <20200623193658.623279-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

Use a special helper for DC_ZVA, rather than the more
general mte_checkN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |   1 +
 target/arm/mte_helper.c    | 106 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  16 +++++-
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 005af678c7..5b0b699a50 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -106,6 +106,7 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(mte_check1, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(mte_checkN, TCG_CALL_NO_WG, i64, env, i32, i64)
+DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
 DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index abe6af6b79..4f9bd3add3 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -667,3 +667,109 @@ uint64_t HELPER(mte_checkN)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
     return mte_checkN(env, desc, ptr, GETPC());
 }
+
+/*
+ * Perform an MTE checked access for DC_ZVA.
+ */
+uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
+{
+    uintptr_t ra = GETPC();
+    int log2_dcz_bytes, log2_tag_bytes;
+    int mmu_idx, bit55;
+    intptr_t dcz_bytes, tag_bytes, i;
+    void *mem;
+    uint64_t ptr_tag, mem_tag, align_ptr;
+
+    bit55 = extract64(ptr, 55, 1);
+
+    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
+    if (unlikely(!tbi_check(desc, bit55))) {
+        return ptr;
+    }
+
+    ptr_tag = allocation_tag_from_addr(ptr);
+
+    if (tcma_check(desc, bit55, ptr_tag)) {
+        goto done;
+    }
+
+    /*
+     * In arm_cpu_realizefn, we asserted that dcz > LOG2_TAG_GRANULE+1,
+     * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
+     * sure that we can access one complete tag byte here.
+     */
+    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
+    dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
+    tag_bytes = (intptr_t)1 << log2_tag_bytes;
+    align_ptr = ptr & -dcz_bytes;
+
+    /*
+     * Trap if accessing an invalid page.  DC_ZVA requires that we supply
+     * the original pointer for an invalid page.  But watchpoints require
+     * that we probe the actual space.  So do both.
+     */
+    mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    (void) probe_write(env, ptr, 1, mmu_idx, ra);
+    mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
+                             dcz_bytes, MMU_DATA_LOAD, tag_bytes, ra);
+    if (!mem) {
+        goto done;
+    }
+
+    /*
+     * Unlike the reasoning for checkN, DC_ZVA is always aligned, and thus
+     * it is quite easy to perform all of the comparisons at once without
+     * any extra masking.
+     *
+     * The most common zva block size is 64; some of the thunderx cpus use
+     * a block size of 128.  For user-only, aarch64_max_initfn will set the
+     * block size to 512.  Fill out the other cases for future-proofing.
+     *
+     * In order to be able to find the first miscompare later, we want the
+     * tag bytes to be in little-endian order.
+     */
+    switch (log2_tag_bytes) {
+    case 0: /* zva_blocksize 32 */
+        mem_tag = *(uint8_t *)mem;
+        ptr_tag *= 0x11u;
+        break;
+    case 1: /* zva_blocksize 64 */
+        mem_tag = cpu_to_le16(*(uint16_t *)mem);
+        ptr_tag *= 0x1111u;
+        break;
+    case 2: /* zva_blocksize 128 */
+        mem_tag = cpu_to_le32(*(uint32_t *)mem);
+        ptr_tag *= 0x11111111u;
+        break;
+    case 3: /* zva_blocksize 256 */
+        mem_tag = cpu_to_le64(*(uint64_t *)mem);
+        ptr_tag *= 0x1111111111111111ull;
+        break;
+
+    default: /* zva_blocksize 512, 1024, 2048 */
+        ptr_tag *= 0x1111111111111111ull;
+        i = 0;
+        do {
+            mem_tag = cpu_to_le64(*(uint64_t *)(mem + i));
+            if (unlikely(mem_tag != ptr_tag)) {
+                goto fail;
+            }
+            i += 8;
+            align_ptr += 16 * TAG_GRANULE;
+        } while (i < tag_bytes);
+        goto done;
+    }
+
+    if (likely(mem_tag == ptr_tag)) {
+        goto done;
+    }
+
+ fail:
+    /* Locate the first nibble that differs. */
+    i = ctz64(mem_tag ^ ptr_tag) >> 4;
+    mte_check_fail(env, mmu_idx, align_ptr + i * TAG_GRANULE, ra);
+
+ done:
+    return useronly_clean_ptr(ptr);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5d62aff5d6..7e8263e86f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1857,7 +1857,21 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
+        if (s->mte_active[0]) {
+            TCGv_i32 t_desc;
+            int desc = 0;
+
+            desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
+            desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+            desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+            t_desc = tcg_const_i32(desc);
+
+            tcg_rt = new_tmp_a64(s);
+            gen_helper_mte_check_zva(tcg_rt, cpu_env, t_desc, cpu_reg(s, rt));
+            tcg_temp_free_i32(t_desc);
+        } else {
+            tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
+        }
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
     default:
-- 
2.25.1


