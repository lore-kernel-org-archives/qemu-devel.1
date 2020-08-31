Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C25C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590C820719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRKhL0n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590C820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmjc-0008PV-DG
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL2-0005y7-MW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:20 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:41198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKz-00067Y-Hl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:20 -0400
Received: by mail-pg1-x534.google.com with SMTP id w186so830342pgb.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OF+n4lfXCPrHMxyBmLfVzNw7xG6DYBX8dPoMcyp+q6s=;
 b=KRKhL0n5xG9u3FfGv8oWHV7PHCBYNHc4vQQiennTSrO78OjSqNY4zecZj132Wjihkb
 rtrM28PSpgcMGK6yOC2/bducQsmL/b2wLVuj4HJd1TC23ZRPb7GTyEPq2QinvYKRmLfS
 s8x1b7+25Y3FmJozgVh2AOMoYoSMflwmdYVO4fS8ocY1qHTbxib8JC5jxw62oU5eH/mu
 36cxQYVEI0Yo8DhPD2IepixuXI8LXyhP3MCe7gyXNe1wuAgx3TBCypAT5Reefw6hRro/
 Y3WfVreQ06e4sO2wlWrjWwTaZOa14Lu3SnlzCzCoMgB177gJW45xJTFJyjb7iUbAdSB2
 56SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OF+n4lfXCPrHMxyBmLfVzNw7xG6DYBX8dPoMcyp+q6s=;
 b=QBac1AGtgV9ncPaaRd3vClLq3dUhVVT5DwiI8h/hwAmX6aENgDxjPBoteSAq9sboSL
 6CmPntK242Kvks1U+MI9ayIvKFi1rQ9UxsDkLH6Cdc9vTDE+GfW15MxrzcGZi5Vzp65f
 jVZOpQQpHgcnSxQRSw7CgmBiWpY4n7P5sUV6s04xv9oOXMVSq55+VpEAAzy1Hj9spfjT
 ZUKJqpjhU/wW7F9G8sH10te1ya5M3UsjsQ+P3ueqT0Ew2CGmmm1E3GVd2ExLqZrs+WiP
 97sRmwKhs7CG0+LbVARGEBkQX+PZj50E3nqdYlog9Ygd+1WB7+j7DzoYWOlTRDUTb3PT
 Fbrg==
X-Gm-Message-State: AOAM532jH3PeEHwC1y7vB/CzcR59+0/Atd1LOnYZ73eVDHwOWw6V8ioK
 LzXkxVBFLIBee9WszPFchRvvlYdoQK3lfQ==
X-Google-Smtp-Source: ABdhPJxXG0wH+nULpzMQ+YDuhs2rnHk+1bSRehNnv+rCzJyXMTDiTcjwmrPtz4ZMQlCeS+ziGA6SYA==
X-Received: by 2002:a62:4e96:: with SMTP id c144mr1738523pfb.27.1598890035310; 
 Mon, 31 Aug 2020 09:07:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/76] target/microblaze: Convert dec_load and dec_store to
 decodetree
Date: Mon, 31 Aug 2020 09:05:38 -0700
Message-Id: <20200831160601.833692-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  32 ++
 target/microblaze/translate.c  | 723 +++++++++++++++++++--------------
 2 files changed, 456 insertions(+), 299 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 87e8f5679b..47b92b9cbc 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -100,6 +100,22 @@ idivu           010010 ..... ..... ..... 000 0000 0010  @typea
 
 imm             101100 00000 00000 imm:16
 
+lbu             110000 ..... ..... ..... 0000 000 0000  @typea
+lbur            110000 ..... ..... ..... 0100 000 0000  @typea
+lbuea           110000 ..... ..... ..... 0001 000 0000  @typea
+lbui            111000 ..... ..... ................     @typeb
+
+lhu             110001 ..... ..... ..... 0000 000 0000  @typea
+lhur            110001 ..... ..... ..... 0100 000 0000  @typea
+lhuea           110001 ..... ..... ..... 0001 000 0000  @typea
+lhui            111001 ..... ..... ................     @typeb
+
+lw              110010 ..... ..... ..... 0000 000 0000  @typea
+lwr             110010 ..... ..... ..... 0100 000 0000  @typea
+lwea            110010 ..... ..... ..... 0001 000 0000  @typea
+lwx             110010 ..... ..... ..... 1000 000 0000  @typea
+lwi             111010 ..... ..... ................     @typeb
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
@@ -123,6 +139,22 @@ rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
 
+sb              110100 ..... ..... ..... 0000 000 0000  @typea
+sbr             110100 ..... ..... ..... 0100 000 0000  @typea
+sbea            110100 ..... ..... ..... 0001 000 0000  @typea
+sbi             111100 ..... ..... ................     @typeb
+
+sh              110101 ..... ..... ..... 0000 000 0000  @typea
+shr             110101 ..... ..... ..... 0100 000 0000  @typea
+shea            110101 ..... ..... ..... 0001 000 0000  @typea
+shi             111101 ..... ..... ................     @typeb
+
+sw              110110 ..... ..... ..... 0000 000 0000  @typea
+swr             110110 ..... ..... ..... 0100 000 0000  @typea
+swea            110110 ..... ..... ..... 0001 000 0000  @typea
+swx             110110 ..... ..... ..... 1000 000 0000  @typea
+swi             111110 ..... ..... ................     @typeb
+
 sext8           100100 ..... ..... 00000 000 0110 0000  @typea0
 sext16          100100 ..... ..... 00000 000 0110 0001  @typea0
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a55e110171..d2baa7db0e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -105,6 +105,17 @@ static inline void t_sync_flags(DisasContext *dc)
     }
 }
 
+static inline void sync_jmpstate(DisasContext *dc)
+{
+    if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
+        if (dc->jmp == JMP_DIRECT) {
+            tcg_gen_movi_i32(cpu_btaken, 1);
+        }
+        dc->jmp = JMP_INDIRECT;
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
+    }
+}
+
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
     TCGv_i32 tmp = tcg_const_i32(index);
@@ -668,6 +679,419 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
+static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
+{
+    TCGv ret = tcg_temp_new();
+
+    /* If any of the regs is r0, set t to the value of the other reg.  */
+    if (ra && rb) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_add_i32(tmp, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_extu_i32_tl(ret, tmp);
+        tcg_temp_free_i32(tmp);
+    } else if (ra) {
+        tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
+    } else if (rb) {
+        tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+    } else {
+        tcg_gen_movi_tl(ret, 0);
+    }
+
+    if ((ra == 1 || rb == 1) && dc->cpu->cfg.stackprot) {
+        gen_helper_stackprot(cpu_env, ret);
+    }
+    return ret;
+}
+
+static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
+{
+    TCGv ret = tcg_temp_new();
+
+    /* If any of the regs is r0, set t to the value of the other reg.  */
+    if (ra) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_addi_i32(tmp, cpu_R[ra], imm);
+        tcg_gen_extu_i32_tl(ret, tmp);
+        tcg_temp_free_i32(tmp);
+    } else {
+        tcg_gen_movi_tl(ret, (uint32_t)imm);
+    }
+
+    if (ra == 1 && dc->cpu->cfg.stackprot) {
+        gen_helper_stackprot(cpu_env, ret);
+    }
+    return ret;
+}
+
+static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
+{
+    int addr_size = dc->cpu->cfg.addr_size;
+    TCGv ret = tcg_temp_new();
+
+    if (addr_size == 32 || ra == 0) {
+        if (rb) {
+            tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+        } else {
+            tcg_gen_movi_tl(ret, 0);
+        }
+    } else {
+        if (rb) {
+            tcg_gen_concat_i32_i64(ret, cpu_R[rb], cpu_R[ra]);
+        } else {
+            tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
+            tcg_gen_shli_tl(ret, ret, 32);
+        }
+        if (addr_size < 64) {
+            /* Mask off out of range bits.  */
+            tcg_gen_andi_i64(ret, ret, MAKE_64BIT_MASK(0, addr_size));
+        }
+    }
+    return ret;
+}
+
+static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+                    int mem_index, bool rev)
+{
+    TCGv_i32 v;
+    MemOp size = mop & MO_SIZE;
+
+    /*
+     * When doing reverse accesses we need to do two things.
+     *
+     * 1. Reverse the address wrt endianness.
+     * 2. Byteswap the data lanes on the way back into the CPU core.
+     */
+    if (rev) {
+        if (size > MO_8) {
+            mop ^= MO_BSWAP;
+        }
+        if (size < MO_32) {
+            tcg_gen_xori_tl(addr, addr, 3 - size);
+        }
+    }
+
+    t_sync_flags(dc);
+    sync_jmpstate(dc);
+
+    /*
+     * Microblaze gives MMU faults priority over faults due to
+     * unaligned addresses. That's why we speculatively do the load
+     * into v. If the load succeeds, we verify alignment of the
+     * address and if that succeeds we write into the destination reg.
+     */
+    v = tcg_temp_new_i32();
+    tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
+
+    /* TODO: Convert to CPUClass::do_unaligned_access.  */
+    if (dc->cpu->cfg.unaligned_exceptions && size > MO_8) {
+        TCGv_i32 t0 = tcg_const_i32(0);
+        TCGv_i32 treg = tcg_const_i32(rd);
+        TCGv_i32 tsize = tcg_const_i32((1 << size) - 1);
+
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
+
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(treg);
+        tcg_temp_free_i32(tsize);
+    }
+
+    if (rd) {
+        tcg_gen_mov_i32(cpu_R[rd], v);
+    }
+
+    tcg_temp_free_i32(v);
+    tcg_temp_free(addr);
+    return true;
+}
+
+static bool trans_lbu(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+}
+
+static bool trans_lbur(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
+}
+
+static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+}
+
+static bool trans_lhu(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+}
+
+static bool trans_lhur(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
+}
+
+static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+}
+
+static bool trans_lw(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+}
+
+static bool trans_lwr(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
+}
+
+static bool trans_lwea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+}
+
+static bool trans_lwx(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+
+    /* lwx does not throw unaligned access errors, so force alignment */
+    tcg_gen_andi_tl(addr, addr, ~3);
+
+    t_sync_flags(dc);
+    sync_jmpstate(dc);
+
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
+    tcg_gen_mov_tl(cpu_res_addr, addr);
+    tcg_temp_free(addr);
+
+    if (arg->rd) {
+        tcg_gen_mov_i32(cpu_R[arg->rd], cpu_res_val);
+    }
+
+    /* No support for AXI exclusive so always clear C */
+    tcg_gen_movi_i32(cpu_msr_c, 0);
+    return true;
+}
+
+static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+                     int mem_index, bool rev)
+{
+    MemOp size = mop & MO_SIZE;
+
+    /*
+     * When doing reverse accesses we need to do two things.
+     *
+     * 1. Reverse the address wrt endianness.
+     * 2. Byteswap the data lanes on the way back into the CPU core.
+     */
+    if (rev) {
+        if (size > MO_8) {
+            mop ^= MO_BSWAP;
+        }
+        if (size < MO_32) {
+            tcg_gen_xori_tl(addr, addr, 3 - size);
+        }
+    }
+
+    t_sync_flags(dc);
+    sync_jmpstate(dc);
+
+    tcg_gen_qemu_st_i32(reg_for_read(dc, rd), addr, mem_index, mop);
+
+    /* TODO: Convert to CPUClass::do_unaligned_access.  */
+    if (dc->cpu->cfg.unaligned_exceptions && size > MO_8) {
+        TCGv_i32 t1 = tcg_const_i32(1);
+        TCGv_i32 treg = tcg_const_i32(rd);
+        TCGv_i32 tsize = tcg_const_i32((1 << size) - 1);
+
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        /* FIXME: if the alignment is wrong, we should restore the value
+         *        in memory. One possible way to achieve this is to probe
+         *        the MMU prior to the memaccess, thay way we could put
+         *        the alignment checks in between the probe and the mem
+         *        access.
+         */
+        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
+
+        tcg_temp_free_i32(t1);
+        tcg_temp_free_i32(treg);
+        tcg_temp_free_i32(tsize);
+    }
+
+    tcg_temp_free(addr);
+    return true;
+}
+
+static bool trans_sb(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+}
+
+static bool trans_sbr(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
+}
+
+static bool trans_sbea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+}
+
+static bool trans_sh(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+}
+
+static bool trans_shr(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
+}
+
+static bool trans_shea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_shi(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
+}
+
+static bool trans_sw(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+}
+
+static bool trans_swr(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
+}
+
+static bool trans_swea(DisasContext *dc, arg_typea *arg)
+{
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+}
+
+static bool trans_swi(DisasContext *dc, arg_typeb *arg)
+{
+    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
+}
+
+static bool trans_swx(DisasContext *dc, arg_typea *arg)
+{
+    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGLabel *swx_done = gen_new_label();
+    TCGLabel *swx_fail = gen_new_label();
+    TCGv_i32 tval;
+
+    t_sync_flags(dc);
+    sync_jmpstate(dc);
+
+    /* swx does not throw unaligned access errors, so force alignment */
+    tcg_gen_andi_tl(addr, addr, ~3);
+
+    /*
+     * Compare the address vs the one we used during lwx.
+     * On mismatch, the operation fails.  On match, addr dies at the
+     * branch, but we know we can use the equal version in the global.
+     * In either case, addr is no longer needed.
+     */
+    tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
+    tcg_temp_free(addr);
+
+    /*
+     * Compare the value loaded during lwx with current contents of
+     * the reserved location.
+     */
+    tval = tcg_temp_new_i32();
+
+    tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
+                               reg_for_write(dc, arg->rd),
+                               dc->mem_index, MO_TEUL);
+
+    tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
+    tcg_temp_free_i32(tval);
+
+    /* Success */
+    tcg_gen_movi_i32(cpu_msr_c, 0);
+    tcg_gen_br(swx_done);
+
+    /* Failure */
+    gen_set_label(swx_fail);
+    tcg_gen_movi_i32(cpu_msr_c, 1);
+
+    gen_set_label(swx_done);
+
+    /*
+     * Prevent the saved address from working again without another ldx.
+     * Akin to the pseudocode setting reservation = 0.
+     */
+    tcg_gen_movi_tl(cpu_res_addr, -1);
+    return true;
+}
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -887,303 +1311,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static inline void sync_jmpstate(DisasContext *dc)
-{
-    if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
-        if (dc->jmp == JMP_DIRECT) {
-            tcg_gen_movi_i32(cpu_btaken, 1);
-        }
-        dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
-    }
-}
-
-static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
-{
-    /* Should be set to true if r1 is used by loadstores.  */
-    bool stackprot = false;
-    TCGv_i32 t32;
-
-    /* All load/stores use ra.  */
-    if (dc->ra == 1 && dc->cpu->cfg.stackprot) {
-        stackprot = true;
-    }
-
-    /* Treat the common cases first.  */
-    if (!dc->type_b) {
-        if (ea) {
-            int addr_size = dc->cpu->cfg.addr_size;
-
-            if (addr_size == 32) {
-                tcg_gen_extu_i32_tl(t, cpu_R[dc->rb]);
-                return;
-            }
-
-            tcg_gen_concat_i32_i64(t, cpu_R[dc->rb], cpu_R[dc->ra]);
-            if (addr_size < 64) {
-                /* Mask off out of range bits.  */
-                tcg_gen_andi_i64(t, t, MAKE_64BIT_MASK(0, addr_size));
-            }
-            return;
-        }
-
-        /* If any of the regs is r0, set t to the value of the other reg.  */
-        if (dc->ra == 0) {
-            tcg_gen_extu_i32_tl(t, cpu_R[dc->rb]);
-            return;
-        } else if (dc->rb == 0) {
-            tcg_gen_extu_i32_tl(t, cpu_R[dc->ra]);
-            return;
-        }
-
-        if (dc->rb == 1 && dc->cpu->cfg.stackprot) {
-            stackprot = true;
-        }
-
-        t32 = tcg_temp_new_i32();
-        tcg_gen_add_i32(t32, cpu_R[dc->ra], cpu_R[dc->rb]);
-        tcg_gen_extu_i32_tl(t, t32);
-        tcg_temp_free_i32(t32);
-
-        if (stackprot) {
-            gen_helper_stackprot(cpu_env, t);
-        }
-        return;
-    }
-    /* Immediate.  */
-    t32 = tcg_temp_new_i32();
-    tcg_gen_addi_i32(t32, cpu_R[dc->ra], dec_alu_typeb_imm(dc));
-    tcg_gen_extu_i32_tl(t, t32);
-    tcg_temp_free_i32(t32);
-
-    if (stackprot) {
-        gen_helper_stackprot(cpu_env, t);
-    }
-    return;
-}
-
-static void dec_load(DisasContext *dc)
-{
-    TCGv_i32 v;
-    TCGv addr;
-    unsigned int size;
-    bool rev = false, ex = false, ea = false;
-    int mem_index = dc->mem_index;
-    MemOp mop;
-
-    mop = dc->opcode & 3;
-    size = 1 << mop;
-    if (!dc->type_b) {
-        ea = extract32(dc->ir, 7, 1);
-        rev = extract32(dc->ir, 9, 1);
-        ex = extract32(dc->ir, 10, 1);
-    }
-    mop |= MO_TE;
-    if (rev) {
-        mop ^= MO_BSWAP;
-    }
-
-    if (trap_illegal(dc, size > 4)) {
-        return;
-    }
-
-    if (trap_userspace(dc, ea)) {
-        return;
-    }
-
-    t_sync_flags(dc);
-    addr = tcg_temp_new();
-    compute_ldst_addr(dc, ea, addr);
-    /* Extended addressing bypasses the MMU.  */
-    mem_index = ea ? MMU_NOMMU_IDX : mem_index;
-
-    /*
-     * When doing reverse accesses we need to do two things.
-     *
-     * 1. Reverse the address wrt endianness.
-     * 2. Byteswap the data lanes on the way back into the CPU core.
-     */
-    if (rev && size != 4) {
-        /* Endian reverse the address. t is addr.  */
-        switch (size) {
-            case 1:
-            {
-                tcg_gen_xori_tl(addr, addr, 3);
-                break;
-            }
-
-            case 2:
-                /* 00 -> 10
-                   10 -> 00.  */
-                tcg_gen_xori_tl(addr, addr, 2);
-                break;
-            default:
-                cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
-                break;
-        }
-    }
-
-    /* lwx does not throw unaligned access errors, so force alignment */
-    if (ex) {
-        tcg_gen_andi_tl(addr, addr, ~3);
-    }
-
-    /* If we get a fault on a dslot, the jmpstate better be in sync.  */
-    sync_jmpstate(dc);
-
-    /* Verify alignment if needed.  */
-    /*
-     * Microblaze gives MMU faults priority over faults due to
-     * unaligned addresses. That's why we speculatively do the load
-     * into v. If the load succeeds, we verify alignment of the
-     * address and if that succeeds we write into the destination reg.
-     */
-    v = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
-
-    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
-        TCGv_i32 t0 = tcg_const_i32(0);
-        TCGv_i32 treg = tcg_const_i32(dc->rd);
-        TCGv_i32 tsize = tcg_const_i32(size - 1);
-
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
-        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(treg);
-        tcg_temp_free_i32(tsize);
-    }
-
-    if (ex) {
-        tcg_gen_mov_tl(cpu_res_addr, addr);
-        tcg_gen_mov_i32(cpu_res_val, v);
-    }
-    if (dc->rd) {
-        tcg_gen_mov_i32(cpu_R[dc->rd], v);
-    }
-    tcg_temp_free_i32(v);
-
-    if (ex) { /* lwx */
-        /* no support for AXI exclusive so always clear C */
-        tcg_gen_movi_i32(cpu_msr_c, 0);
-    }
-
-    tcg_temp_free(addr);
-}
-
-static void dec_store(DisasContext *dc)
-{
-    TCGv addr;
-    TCGLabel *swx_skip = NULL;
-    unsigned int size;
-    bool rev = false, ex = false, ea = false;
-    int mem_index = dc->mem_index;
-    MemOp mop;
-
-    mop = dc->opcode & 3;
-    size = 1 << mop;
-    if (!dc->type_b) {
-        ea = extract32(dc->ir, 7, 1);
-        rev = extract32(dc->ir, 9, 1);
-        ex = extract32(dc->ir, 10, 1);
-    }
-    mop |= MO_TE;
-    if (rev) {
-        mop ^= MO_BSWAP;
-    }
-
-    if (trap_illegal(dc, size > 4)) {
-        return;
-    }
-
-    trap_userspace(dc, ea);
-
-    t_sync_flags(dc);
-    /* If we get a fault on a dslot, the jmpstate better be in sync.  */
-    sync_jmpstate(dc);
-    /* SWX needs a temp_local.  */
-    addr = ex ? tcg_temp_local_new() : tcg_temp_new();
-    compute_ldst_addr(dc, ea, addr);
-    /* Extended addressing bypasses the MMU.  */
-    mem_index = ea ? MMU_NOMMU_IDX : mem_index;
-
-    if (ex) { /* swx */
-        TCGv_i32 tval;
-
-        /* swx does not throw unaligned access errors, so force alignment */
-        tcg_gen_andi_tl(addr, addr, ~3);
-
-        tcg_gen_movi_i32(cpu_msr_c, 1);
-        swx_skip = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_skip);
-
-        /*
-         * Compare the value loaded at lwx with current contents of
-         * the reserved location.
-         */
-        tval = tcg_temp_new_i32();
-
-        tcg_gen_atomic_cmpxchg_i32(tval, addr, cpu_res_val,
-                                   cpu_R[dc->rd], mem_index,
-                                   mop);
-
-        tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_skip);
-        tcg_gen_movi_i32(cpu_msr_c, 0);
-        tcg_temp_free_i32(tval);
-    }
-
-    if (rev && size != 4) {
-        /* Endian reverse the address. t is addr.  */
-        switch (size) {
-            case 1:
-            {
-                tcg_gen_xori_tl(addr, addr, 3);
-                break;
-            }
-
-            case 2:
-                /* 00 -> 10
-                   10 -> 00.  */
-                /* Force addr into the temp.  */
-                tcg_gen_xori_tl(addr, addr, 2);
-                break;
-            default:
-                cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
-                break;
-        }
-    }
-
-    if (!ex) {
-        tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
-    }
-
-    /* Verify alignment if needed.  */
-    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
-        TCGv_i32 t1 = tcg_const_i32(1);
-        TCGv_i32 treg = tcg_const_i32(dc->rd);
-        TCGv_i32 tsize = tcg_const_i32(size - 1);
-
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
-        /* FIXME: if the alignment is wrong, we should restore the value
-         *        in memory. One possible way to achieve this is to probe
-         *        the MMU prior to the memaccess, thay way we could put
-         *        the alignment checks in between the probe and the mem
-         *        access.
-         */
-        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
-
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(treg);
-        tcg_temp_free_i32(tsize);
-    }
-
-    if (ex) {
-        gen_set_label(swx_skip);
-    }
-
-    tcg_temp_free(addr);
-}
-
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
                            TCGv_i32 d, TCGv_i32 a)
 {
@@ -1491,8 +1618,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_LD, dec_load},
-    {DEC_ST, dec_store},
     {DEC_BR, dec_br},
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
-- 
2.25.1


