Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E5C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F202075E
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOCwZ+vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F202075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYkDy-0008Qu-41
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 00:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3G-0003eu-5U
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3E-0007Z1-QA
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:14 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iYk3E-0007Yf-K0
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id b11so2259645wmj.4
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 21:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PevYNAEW2/rbU2HD9RmLzQ+eiZqSSbUKhGGl3bsW4n4=;
 b=kOCwZ+vWIdrmuEDqWr05BSqO660lZKLcrX3q9avPLDhYXccOwOyv+HEJz+SuVuBlso
 TrpmRscg26zCjVV66h1Ycor6225k5Km1MELxFmXIPUhy+jViSYHL8d7WhHV9nik2eaVh
 uNQuRFZ3UmTJTV67EKgVqCePG/Ze4iW41YJ3ijyBcaOaSlTMZNlre2SQmVTry0ZoOp1j
 aRe/J+c98FUjj1eeOnLsq+AwtLjL9gW7XzdYp2Jjk1S2qZnNfAHNBHZ1M3O4VIuf10AN
 vUclzVc5vgpE/X88dN8xEKuA/DBR/fxeI9mq+nH3PN1kJl5pMWYUs8ndB9NydQ8/Zaqg
 EXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PevYNAEW2/rbU2HD9RmLzQ+eiZqSSbUKhGGl3bsW4n4=;
 b=cp+Uk8CNrS0l1jLylSJgQuYlmsArtdsmEMk75efxzudMpYy1NtbT1clEWInLmlNXUo
 ddwZarY4jxIlpw5lOeV/CDXXWIt/B9xJ+/eTqgm8U9NVaX2lt0o+5B2bKQDwnSKMmnWO
 DXjALws8HWaSRx79LikwYULjPPeFwf0X5WA6TTY9n2/fiTQNWnx6CZ11loluYkduOfqM
 qeeTBJQL6bvnmweCC+DwykZvuI3hfQVPp3P/ms+N53ZENvdMpoDY3Es6ZGFa/u13x9Vm
 mmIcFEMcbKLbmfuKFcSrL9tg5UaH1toMe5l+4Sv0uY7rOAbJoD8+VFQQkVfTCB7tjt+N
 sRpw==
X-Gm-Message-State: APjAAAX23fSa+Wx9wAUHtjrBucipjpyTPCUAkBvuHzb46v8yVn4dI4dO
 zST5queuwymqUPYxAjkNOhmSC73fSZkEsA3U
X-Google-Smtp-Source: APXvYqyIBnB0dpG98DiJiRXpKscqz/x3zvhz7POlCkw3guxyfacDE1uMw0eIdoOsEl+4p1IjsmY6RQ==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10mr24627449wme.0.1574571791253; 
 Sat, 23 Nov 2019 21:03:11 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-10-38.red.bezeqint.net. [79.178.10.38])
 by smtp.gmail.com with ESMTPSA id t185sm4173976wmf.45.2019.11.23.21.03.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 23 Nov 2019 21:03:10 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v36 08/17] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Sun, 24 Nov 2019 07:02:16 +0200
Message-Id: <20191124050225.30351-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191124050225.30351-1-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
index f2ec2e2d2f..30ba13bdd7 100644
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
@@ -2618,3 +2727,68 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
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


