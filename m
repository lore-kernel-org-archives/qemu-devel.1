Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10374C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BA321852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwXOU1lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmru-0000uo-3H
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF8-0007Nx-JV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF5-0003gv-4H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so2192572pfx.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lbdpcwTYmgpU8he3rVaw+eBkj+/8hQMw1WvfVbQlj1w=;
 b=hwXOU1ljPxNp2HJw3jR6CEa5NiMyi5wUzVjTjTQbtxibWEC+FBE003kZQDPAq7TyU9
 BtgVqT+x4Y9tSE0d3vb1t5baPy63A0vj8bikxIK53QFOhLr2qpND9z2Hb2wB4ph3AuQj
 P0ZF/f6FGUPav/kRJRcSpN8l6ghQVo5DTZpFAH43dmFjVsj4uTPV9XCDF8kktKL7hoLa
 uzc09XZD4vt+9fcCLlhH/DIXbbOHrvIixRIdvw9a4vsB867mioaU+pe/ofC5sM4HX0LS
 YNVc8vorL9vRVRelWLLIrG8XKcDs1QWsSJNnPVsCBoua4I2YOtMnz9saUiGRSlFnfAM5
 CESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lbdpcwTYmgpU8he3rVaw+eBkj+/8hQMw1WvfVbQlj1w=;
 b=NscFnU7nQnlMscPZAwuylj/if0E7c0M+yZpBQDBvjJ4QArQATWvUc4JZFioqn81Ygb
 b2hS+pe/H3nqUiuweDvd1BmH43gsJq+gGYnWtSASffjCz4xO5Lsx+i7dNpJhOsADB/5u
 PMzAV3KjgTCwp8aUmKCjy9DPWP0P36Kl1+WmeT4j3Ij83CKh6Gqbviis7k/va08p4a4O
 A+BRvSM1Cq1qZqwgR+w+OAwJVy1qKTsqlxeZds85m609E4aW1zbcFfAqixCC6eN4rP8g
 36WdkwFM39oyjOTuRAb5AzaPTWI2asNE2wIMrUP7bcWIGZsCYVMfLkIdgNP4T+CFD/F1
 OymQ==
X-Gm-Message-State: AOAM530ktLT23joq5R7jXjD5vncW5b4oslPXjctbX7rbeouSt9ZjnwvH
 e2Mj3LiVeKCNNR75KpSBAgrAlOv/3dU=
X-Google-Smtp-Source: ABdhPJylgiSdiYzzUh0JAh8r7v5/ti1Wz67Tlf+0UlLQ9eHeTxUxLulEwKBy97J/xIXFOoaiSEyQCg==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr1827845pgp.160.1592454811977; 
 Wed, 17 Jun 2020 21:33:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q22sm1288212pfg.192.2020.06.17.21.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:33:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 097/100] target/arm: Implement SVE2 LD1RO
Date: Wed, 17 Jun 2020 21:26:41 -0700
Message-Id: <20200618042644.1685561-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  4 ++
 target/arm/translate-sve.c | 95 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6808ff4194..e0d093c5d7 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1119,11 +1119,15 @@ LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_load_msz
 # SVE load and broadcast quadword (scalar plus scalar)
 LD1RQ_zprr      1010010 .. 00 ..... 000 ... ..... ..... \
                 @rprr_load_msz nreg=0
+LD1RO_zprr      1010010 .. 01 ..... 000 ... ..... ..... \
+                @rprr_load_msz nreg=0
 
 # SVE load and broadcast quadword (scalar plus immediate)
 # LD1RQB, LD1RQH, LD1RQS, LD1RQD
 LD1RQ_zpri      1010010 .. 00 0.... 001 ... ..... ..... \
                 @rpri_load_msz nreg=0
+LD1RO_zpri      1010010 .. 01 0.... 001 ... ..... ..... \
+                @rpri_load_msz nreg=0
 
 # SVE 32-bit gather prefetch (scalar plus 32-bit scaled offsets)
 PRF             1000010 00 -1 ----- 0-- --- ----- 0 ----
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6bdff5ceca..6b4a05a76d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5469,6 +5469,101 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
     return true;
 }
 
+static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned vsz_r32;
+    TCGv_ptr t_pg;
+    TCGv_i32 t_desc;
+    int desc, poff, doff;
+
+    if (vsz < 32) {
+        /*
+         * Note that this UNDEFINED check comes after CheckSVEEnabled()
+         * in the ARM pseudocode, which is the sve_access_check() done
+         * in our caller.  We should not now return false from the caller.
+         */
+        unallocated_encoding(s);
+        return;
+    }
+
+    /* Load the first octaword using the normal predicated load helpers.  */
+
+    poff = pred_full_reg_offset(s, pg);
+    if (vsz > 32) {
+        /*
+         * Zero-extend the first 32 bits of the predicate into a temporary.
+         * This avoids triggering an assert making sure we don't have bits
+         * set within a predicate beyond VQ, but we have lowered VQ to 2
+         * for this load operation.
+         */
+        TCGv_i64 tmp = tcg_temp_new_i64();
+#ifdef HOST_WORDS_BIGENDIAN
+        poff += 4;
+#endif
+        tcg_gen_ld32u_i64(tmp, cpu_env, poff);
+
+        poff = offsetof(CPUARMState, vfp.preg_tmp);
+        tcg_gen_st_i64(tmp, cpu_env, poff);
+        tcg_temp_free_i64(tmp);
+    }
+
+    t_pg = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(t_pg, cpu_env, poff);
+
+    desc = simd_desc(32, 32, zt);
+    t_desc = tcg_const_i32(desc);
+
+    ldr_fns[s->be_data == MO_BE][dtype][0](cpu_env, t_pg, addr, t_desc);
+
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(t_desc);
+
+    /*
+     * Replicate that first octaword.
+     * The replication happens in units of 32; if the full vector size
+     * is not a multiple of 32, the final bits are zeroed.
+     */
+    doff = vec_full_reg_offset(s, zt);
+    vsz_r32 = QEMU_ALIGN_DOWN(vsz, 32);
+    if (vsz >= 64) {
+        tcg_gen_gvec_dup_mem(5, doff + 32, doff, vsz_r32 - 32, vsz - 32);
+    } else if (vsz > vsz_r32) {
+        /* Nop move, with side effect of clearing the tail. */
+        tcg_gen_gvec_mov(MO_64, doff, doff, vsz_r32, vsz);
+    }
+}
+
+static bool trans_LD1RO_zprr(DisasContext *s, arg_rprr_load *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    if (a->rm == 31) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        TCGv_i64 addr = new_tmp_a64(s);
+        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
+        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+        do_ldro(s, a->rd, a->pg, addr, a->dtype);
+    }
+    return true;
+}
+
+static bool trans_LD1RO_zpri(DisasContext *s, arg_rpri_load *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        TCGv_i64 addr = new_tmp_a64(s);
+        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), a->imm * 32);
+        do_ldro(s, a->rd, a->pg, addr, a->dtype);
+    }
+    return true;
+}
+
 /* Load and broadcast element.  */
 static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 {
-- 
2.25.1


