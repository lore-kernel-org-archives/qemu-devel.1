Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E902DC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B265720659
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwI5bEzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJYmW-0004vH-TB
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 03:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcJ-0000qv-Uh
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcI-0008NG-Bg
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iJYcI-0008Mo-4z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so12220332wme.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BGvkLFU66e7VXKZNz1ZYyyXcitOZp+YBucUP/E/zH5s=;
 b=fwI5bEzBQmWqTUeEUnYGToJVEGBi6qMCwl0zy7vlfYb9KMakyd/bQ64YN8kL/Mzhcg
 sEmc/dukUPPp+QHbuH1GC2I+dbPjLRkgrIi+beitekyJ8L+aehdpxrgwg8xK+FjmkMLl
 yrbrVaFFPDZso006kFOcq5q+lAowRnah2oB//stTRVKBuwp3EZlblVlbJYunNE6D0/jW
 BQ3qokN2fPUq2G3+0O6Y3/LDvtDqSn3bzTFjNOs/QcQ6pQx7CyMOp64EYO/8nqSQQToM
 h6cfTu9ycz6oKMGM0BAxP+J83zvrIFO7nYs3KM4o9oHT1tn0ApAnRs5v2lJdDRuICGyt
 GoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BGvkLFU66e7VXKZNz1ZYyyXcitOZp+YBucUP/E/zH5s=;
 b=plZwzROeI/gD9KoDJqKX7ZSRqtUtisRfBm26ZW9W8Nd2P6u5XA5j5FPQZFkV3UYdb/
 uJCYWUkYmMvU5/uqqs45JIF5LBOtRlQZtSXTo7OQAGqCtNuzUBKL8O4k4FnAKhPR+xjw
 XlPCdvbDHVcYdLew4vcWXYRZ2oDSTjEB3UiN0ewuczpaHfd65XYFzI5nC7rBhoFCGkII
 lUqhLZD/9SmSPS9rz3wj7+uLIMjZFMQ4/FGgc+9Lsh98LjK6GtpJe6eL9X/r1T0WFFHL
 8oUeyopQEXzjDCgDYy1PrLsYQPGKPtiCOclWtfS20Zt80A45WxcZ2MK/ppq1VlTqnB5o
 YC+Q==
X-Gm-Message-State: APjAAAW9xSQCA7aK/r4TH5Gpg7pNEit+FMqNEVzTa80H2uxTq+PEsej5
 4KeiOPzwFdNYgIn5aP6/qAs4K/fK2p8=
X-Google-Smtp-Source: APXvYqzOe92JiRC4VdtiD7L9sxzYLdhtFrdXQ3294L4yupQMLEVqkilI691bk6hgmZy7hNVEWphkLw==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr10584179wmd.170.1570952916633; 
 Sun, 13 Oct 2019 00:48:36 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-179-64-109.red.bezeqint.net. [79.179.64.109])
 by smtp.gmail.com with ESMTPSA id u26sm9277532wrd.87.2019.10.13.00.48.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 13 Oct 2019 00:48:36 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 08/13] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Sun, 13 Oct 2019 10:48:01 +0300
Message-Id: <20191013074803.91390-10-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191013074803.91390-1-mrolnik@gmail.com>
References: <20191013074803.91390-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
    - BREAK
    - NOP
    - SLEEP
    - WDR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 174 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 19540634df..21ba6004ee 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -368,6 +368,115 @@ static bool trans_ADC(DisasContext *ctx, arg_ADC *a)
 }
 
 
+static void gen_jmp_ez(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    tcg_gen_or_tl(cpu_pc, cpu_pc, cpu_eind);
+    ctx->bstate = DISAS_LOOKUP;
+}
+
+
+static void gen_jmp_z(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    ctx->bstate = DISAS_LOOKUP;
+}
+
+
+/*
+ *  in the gen_set_addr & gen_get_addr functions
+ *  H assumed to be in 0x00ff0000 format
+ *  M assumed to be in 0x000000ff format
+ *  L assumed to be in 0x000000ff format
+ */
+static void gen_set_addr(TCGv addr, TCGv H, TCGv M, TCGv L)
+{
+
+    tcg_gen_andi_tl(L, addr, 0x000000ff);
+
+    tcg_gen_andi_tl(M, addr, 0x0000ff00);
+    tcg_gen_shri_tl(M, M, 8);
+
+    tcg_gen_andi_tl(H, addr, 0x00ff0000);
+}
+
+
+static void gen_set_xaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+
+static void gen_set_yaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+
+static void gen_set_zaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+
+static TCGv gen_get_addr(TCGv H, TCGv M, TCGv L)
+{
+    TCGv addr = tcg_temp_new_i32();
+
+    tcg_gen_deposit_tl(addr, M, H, 8, 8);
+    tcg_gen_deposit_tl(addr, L, addr, 8, 16);
+
+    return addr;
+}
+
+
+static TCGv gen_get_xaddr(void)
+{
+    return gen_get_addr(cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+
+static TCGv gen_get_yaddr(void)
+{
+    return gen_get_addr(cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+
+static TCGv gen_get_zaddr(void)
+{
+    return gen_get_addr(cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and stores an clear
+ *  the bits in data space specified by the register. The instruction can only
+ *  be used towards internal SRAM.  The data location is pointed to by the Z (16
+ *  bits) Pointer Register in the Register File. Memory access is limited to the
+ *  current data segment of 64KB. To access another data segment in devices with
+ *  more than 64KB data space, the RAMPZ in register in the I/O area has to be
+ *  changed.  The Z-pointer Register is left unchanged by the operation. This
+ *  instruction is especially suited for clearing status bits stored in SRAM.
+ */
+static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullwr(cpu_env, data, addr);
+    } else {
+        tcg_gen_qemu_st8(data, addr, MMU_DATA_IDX); /* mem[addr] = data */
+    }
+}
+
+static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullrd(data, cpu_env, addr);
+    } else {
+        tcg_gen_qemu_ld8u(data, addr, MMU_DATA_IDX); /* data = mem[addr] */
+    }
+}
+
+
 /*
  *  Subtracts an immediate value (0-63) from a register pair and places the
  *  result in the register pair. This instruction operates on the upper four
@@ -2606,3 +2715,68 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
     return true;
 }
+
+
+/*
+ *  The BREAK instruction is used by the On-chip Debug system, and is
+ *  normally not used in the application software. When the BREAK instruction is
+ *  executed, the AVR CPU is set in the Stopped Mode. This gives the On-chip
+ *  Debugger access to internal resources.  If any Lock bits are set, or either
+ *  the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat the BREAK
+ *  instruction as a NOP and will not enter the Stopped mode.  This instruction
+ *  is not available in all devices. Refer to the device specific instruction
+ *  set summary.
+ */
+static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {
+        return true;
+    }
+
+#ifdef BREAKPOINT_ON_BREAK
+    tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
+    gen_helper_debug(cpu_env);
+    ctx->bstate = DISAS_EXIT;
+#else
+    /* NOP */
+#endif
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a single cycle No Operation.
+ */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+
+    /* NOP */
+
+    return true;
+}
+
+
+/*
+ *  This instruction sets the circuit in sleep mode defined by the MCU
+ *  Control Register.
+ */
+static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
+{
+    gen_helper_sleep(cpu_env);
+    ctx->bstate = DISAS_NORETURN;
+    return true;
+}
+
+
+/*
+ *  This instruction resets the Watchdog Timer. This instruction must be
+ *  executed within a limited time given by the WD prescaler. See the Watchdog
+ *  Timer hardware specification.
+ */
+static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
+{
+    gen_helper_wdr(cpu_env);
+
+    return true;
+}
-- 
2.17.2 (Apple Git-113)


