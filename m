Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C1A20709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvJ/p01T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C1A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofIT-00072N-DJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6H-0000XX-TE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:25 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6G-0001z2-1P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id u5so4057632pfn.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t6HI4aoB3cLZJNWMSCpZ8ckTVshtbgUW+lD663JKJXM=;
 b=mvJ/p01TpaggEkt2JgzEazB8Xc0MzESXHS7zQtMptUNS0zY3b89x+jqHkpJNfc0Rjk
 vLC5kTpqA0d+1DfhZI4NIc70Rik4NlKVAMfOSBDWDru+8cETQtxulspMAYgz8+uFXaHd
 P6f6bR74rphVkok9RCzm7rNAOojxfGksnkqsc0i7770ackFRDnoMiu6sNw8kiRisnKq7
 Bsy6z5Zs5fhZF7PMIOJlq5uO6R1apxhiNUnuUiIKZS021OwHmD//1iDeI3OxQ4J0MmiY
 6D6AuZw7Y+CLTqChYJwG25NPop7jjjhZxkNEGJ5xy2G7kLanR91CKFBM7j4Ea2fdCLOt
 7Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t6HI4aoB3cLZJNWMSCpZ8ckTVshtbgUW+lD663JKJXM=;
 b=MJVt/hPWwOwv5PujW36n4DMGhAiv+G1WCF0a5tGlSdQhDclFuw7kEJTZkTNyIjchaY
 RciDZBsRdRKPBcmH1VBAA2SpI3avbB0miBOE7p5cGYMniP4hpxETcndj41ZH5d9PV8eS
 LNvl6iqV4FhEydAD6dqUnbgr0I3e11I41zyMzh+hoBsG2PkTqCklilw4h91kI79A3Rkx
 sY85dRF+hsfSLxQ8rnZAHipMSZK2sPESPY+szRa4E+kSaUt1ZurQf1WPAD7Iajexa2ak
 VY1yEpTCz077R3xvYo7xF/ngm0841qd76jODqJNKnazjFS9bvdRUpGCk3adcqNd6AMzo
 9P0Q==
X-Gm-Message-State: AOAM533aA9odWVhDNV3emHrWnyTNO/lBq7TZmeC5GXh1zTFSBx/cyDEa
 fICxmjLpek5cbBuuOFXXEQ7euhuFegk=
X-Google-Smtp-Source: ABdhPJzRq0HP0s8F5a25SIJrGeUZNMqdZMXlSuonax7u6dz3qI67FYZTF+4DgqDNfUdGlvCA6H6+3A==
X-Received: by 2002:a63:1c65:: with SMTP id c37mr948632pgm.118.1593142342274; 
 Thu, 25 Jun 2020 20:32:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 27/46] target/arm: Add helper_mte_check_zva
Date: Thu, 25 Jun 2020 20:31:25 -0700
Message-Id: <20200626033144.790098-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
index 52be0400d7..a2a8280010 100644
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


