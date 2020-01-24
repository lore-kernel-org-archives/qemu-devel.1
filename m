Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1950AC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2222071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWP2Lf/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2222071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunEv-0006bS-VV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCc-0001tO-FG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCa-0005DE-Dy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:02 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCa-0005CQ-6L; Thu, 23 Jan 2020 19:52:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so143347wmi.1;
 Thu, 23 Jan 2020 16:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=koloXujSIMwkBDqf7/bqwlM8WyJoYMUnOkY2/nKOfMQ=;
 b=CWP2Lf/3rMQM4RUbiTDb+FyB9IarCzBafcGVDDnqB/wfriD/rctgl0RGgpaDaB+MMt
 DjKRJQ6zNka5Mq8pn3HmY8/E8CaNWNOwgb8xjw9UluwHHRza+hPw3KJq5RAqFYLnSl4D
 MfRNwfHrSA4sxkM7d74j8sWXIPNQLxA1wm70CvxTnHS6c+y+ooA85kjH6x4NKKQHPiFP
 lT9r6ATBO04GI1kjDrr9JMdO366wrZ27WEm2WJNVjz3wnWAJYz0RNaaKMEoX2Q2X+hu0
 wSJ4n7fnatBoHkNU1M/4bYq8GW8HOmRfWhZZcBPKo9XpywLug8lCAh3LN6s/RjVfI14M
 j8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=koloXujSIMwkBDqf7/bqwlM8WyJoYMUnOkY2/nKOfMQ=;
 b=oY5WSIXPRNraKc2Dw0Wyx9VtmEfDDRzU347lyqbubcRi7uCMUybc9XqeDPWJhYuGX0
 yjD5eKSDuaKTDxfgVhzVtZAR7Do8gAP5X1RZ8ij1b7ME16r9tFgH9HGtvitZ2ehEwNRj
 2QR3prEC0vBQgx2OV2gcfLFy2kXIkud/boSm9CB0JV1tSrJWCAMpdATrxIVDu4ZtXvgN
 scMS07IbHngMCe1pbnTDUgj+VDUMFh7Xaf1j1o7FQF+ZMN7B2pC4ue0SdJcom6bkeNcJ
 BKtD8in0Ww9mJ8FceIxqe8X0QbkbYDkpkHamuL6f64OH4Plqb1Zp4rAHQFJsx5C23G8l
 x5nw==
X-Gm-Message-State: APjAAAUixTSqcnGEzDGABcQ0bj/mqxd2sGAJtDKNkqckmvFUkiklgKid
 ukFcw6lTIiwaaN116kAsPNjPow+a
X-Google-Smtp-Source: APXvYqwqBwbV0Hy3Q6gnNEeT3xWT5NayhLtArQsixa2aZ0s1h0O7lfp0vhEtUBDe//YVteya8+1T4Q==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr544126wmi.119.1579827118746; 
 Thu, 23 Jan 2020 16:51:58 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:51:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 10/25] target/avr: Add instruction disassembly function
Date: Fri, 24 Jan 2020 01:51:16 +0100
Message-Id: <20200124005131.16276-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Provide function disassembles executed instruction when `-d in_asm` is
provided

Example:
`./avr-softmmu/qemu-system-avr -bios free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf -d in_asm` will produce something like the following

```
    ...
    IN:
    0x0000014a:  CALL      0x3808

    IN: main
    0x00003808:  CALL      0x4b4

    IN: vParTestInitialise
    0x000004b4:  LDI       r24, 255
    0x000004b6:  STS       r24, 0
    0x000004b8:  MULS      r16, r20
    0x000004ba:  OUT       $1, r24
    0x000004bc:  LDS       r24, 0
    0x000004be:  MULS      r16, r20
    0x000004c0:  OUT       $2, r24
    0x000004c2:  RET
    ...
```

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-11-mrolnik@gmail.com>
[rth: Fix spacing and const mnemonic arrays]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h       |   1 +
 target/avr/cpu.c       |   2 +-
 target/avr/disas.c     | 246 +++++++++++++++++++++++++++++++++++++++++
 target/avr/translate.c |  12 ++
 4 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 target/avr/disas.c

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index b74bcf01ae..af89b6611e 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -160,6 +160,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_print_insn(bfd_vma addr, disassemble_info *info);
 
 static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
 {
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index c74c5106fe..fa51f771c0 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -84,7 +84,7 @@ static void avr_cpu_reset(CPUState *cs)
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_avr;
-    info->print_insn = NULL;
+    info->print_insn = avr_print_insn;
 }
 
 static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/avr/disas.c b/target/avr/disas.c
new file mode 100644
index 0000000000..23bd9919ed
--- /dev/null
+++ b/target/avr/disas.c
@@ -0,0 +1,246 @@
+/*
+ * AVR disassembler
+ *
+ * Copyright (c) 2019 Richard Henderson <rth@twiddle.net>
+ * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+typedef struct {
+    disassemble_info *info;
+    uint16_t next_word;
+    bool next_word_used;
+} DisasContext;
+
+static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 16);
+}
+
+static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 8);
+}
+
+static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
+{
+    return 24 + (indx % 4) * 2;
+}
+
+static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
+{
+    return (indx % 16) * 2;
+}
+
+static uint16_t next_word(DisasContext *ctx)
+{
+    ctx->next_word_used = true;
+    return ctx->next_word;
+}
+
+static int append_16(DisasContext *ctx, int x)
+{
+    return x << 16 | next_word(ctx);
+}
+
+
+/* Include the auto-generated decoder.  */
+static bool decode_insn(DisasContext *ctx, uint16_t insn);
+#include "decode_insn.inc.c"
+
+#define output(mnemonic, format, ...) \
+    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
+                        mnemonic, ##__VA_ARGS__))
+
+int avr_print_insn(bfd_vma addr, disassemble_info *info)
+{
+    DisasContext ctx;
+    DisasContext *pctx = &ctx;
+    bfd_byte buffer[4];
+    uint16_t insn;
+    int status;
+
+    ctx.info = info;
+
+    status = info->read_memory_func(addr, buffer, 4, info);
+    if (status != 0) {
+        info->memory_error_func(status, addr, info);
+        return -1;
+    }
+    insn = bfd_getl16(buffer);
+    ctx.next_word = bfd_getl16(buffer + 2);
+    ctx.next_word_used = false;
+
+    if (!decode_insn(&ctx, insn)) {
+        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
+    }
+
+    return ctx.next_word_used ? 4 : 2;
+}
+
+
+#define INSN(opcode, format, ...)                                   \
+static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
+{                                                                       \
+    output(#opcode, format, ##__VA_ARGS__);                             \
+    return true;                                                        \
+}
+
+#define INSN_MNEMONIC(opcode, mnemonic, format, ...)                \
+static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
+{                                                                       \
+    output(mnemonic, format, ##__VA_ARGS__);                            \
+    return true;                                                        \
+}
+
+/*
+ *   C       Z       N       V       S       H       T       I
+ *   0       1       2       3       4       5       6       7
+ */
+static const char brbc[][5] = {
+    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
+};
+
+static const char brbs[][5] = {
+    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
+};
+
+static const char bset[][4] = {
+    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
+};
+
+static const char bclr[][4] = {
+    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
+};
+
+/*
+ * Arithmetic Instructions
+ */
+INSN(ADD,    "r%d, r%d", a->rd, a->rr)
+INSN(ADC,    "r%d, r%d", a->rd, a->rr)
+INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
+INSN(SUB,    "r%d, r%d", a->rd, a->rr)
+INSN(SUBI,   "r%d, %d", a->rd, a->imm)
+INSN(SBC,    "r%d, r%d", a->rd, a->rr)
+INSN(SBCI,   "r%d, %d", a->rd, a->imm)
+INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
+INSN(AND,    "r%d, r%d", a->rd, a->rr)
+INSN(ANDI,   "r%d, %d", a->rd, a->imm)
+INSN(OR,     "r%d, r%d", a->rd, a->rr)
+INSN(ORI,    "r%d, %d", a->rd, a->imm)
+INSN(EOR,    "r%d, r%d", a->rd, a->rr)
+INSN(COM,    "r%d", a->rd)
+INSN(NEG,    "r%d", a->rd)
+INSN(INC,    "r%d", a->rd)
+INSN(DEC,    "r%d", a->rd)
+INSN(MUL,    "r%d, r%d", a->rd, a->rr)
+INSN(MULS,   "r%d, r%d", a->rd, a->rr)
+INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
+INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
+INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
+INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
+INSN(DES,    "%d", a->imm)
+
+/*
+ * Branch Instructions
+ */
+INSN(RJMP,   ".%+d", a->imm * 2)
+INSN(IJMP,   "")
+INSN(EIJMP,  "")
+INSN(JMP,    "0x%x", a->imm * 2)
+INSN(RCALL,  ".%+d", a->imm * 2)
+INSN(ICALL,  "")
+INSN(EICALL, "")
+INSN(CALL,   "0x%x", a->imm * 2)
+INSN(RET,    "")
+INSN(RETI,   "")
+INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
+INSN(CP,     "r%d, r%d", a->rd, a->rr)
+INSN(CPC,    "r%d, r%d", a->rd, a->rr)
+INSN(CPI,    "r%d, %d", a->rd, a->imm)
+INSN(SBRC,   "r%d, %d", a->rr, a->bit)
+INSN(SBRS,   "r%d, %d", a->rr, a->bit)
+INSN(SBIC,   "$%d, %d", a->reg, a->bit)
+INSN(SBIS,   "$%d, %d", a->reg, a->bit)
+INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
+INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
+
+/*
+ * Data Transfer Instructions
+ */
+INSN(MOV,    "r%d, r%d", a->rd, a->rr)
+INSN(MOVW,   "r%d:r%d, r%d:r%d", a->rd + 1, a->rd, a->rr + 1, a->rr)
+INSN(LDI,    "r%d, %d", a->rd, a->imm)
+INSN(LDS,    "r%d, %d", a->rd, a->imm)
+INSN(LDX1,   "r%d, X", a->rd)
+INSN(LDX2,   "r%d, X+", a->rd)
+INSN(LDX3,   "r%d, -X", a->rd)
+INSN(LDY2,   "r%d, Y+", a->rd)
+INSN(LDY3,   "r%d, -Y", a->rd)
+INSN(LDZ2,   "r%d, Z+", a->rd)
+INSN(LDZ3,   "r%d, -Z", a->rd)
+INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
+INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
+INSN(STS,    "r%d, %d", a->rd, a->imm)
+INSN(STX1,   "r%d, X", a->rr)
+INSN(STX2,   "r%d, X+", a->rr)
+INSN(STX3,   "r%d, -X", a->rr)
+INSN(STY2,   "r%d, Y+", a->rd)
+INSN(STY3,   "r%d, -Y", a->rd)
+INSN(STZ2,   "r%d, Z+", a->rd)
+INSN(STZ3,   "r%d, -Z", a->rd)
+INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
+INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
+INSN(LPM1,   "")
+INSN(LPM2,   "r%d, Z", a->rd)
+INSN(LPMX,   "r%d, Z+", a->rd)
+INSN(ELPM1,  "")
+INSN(ELPM2,  "r%d, Z", a->rd)
+INSN(ELPMX,  "r%d, Z+", a->rd)
+INSN(SPM,    "")
+INSN(SPMX,   "Z+")
+INSN(IN,     "r%d, $%d", a->rd, a->imm)
+INSN(OUT,    "$%d, r%d", a->imm, a->rd)
+INSN(PUSH,   "r%d", a->rd)
+INSN(POP,    "r%d", a->rd)
+INSN(XCH,    "Z, r%d", a->rd)
+INSN(LAC,    "Z, r%d", a->rd)
+INSN(LAS,    "Z, r%d", a->rd)
+INSN(LAT,    "Z, r%d", a->rd)
+
+/*
+ * Bit and Bit-test Instructions
+ */
+INSN(LSR,    "r%d", a->rd)
+INSN(ROR,    "r%d", a->rd)
+INSN(ASR,    "r%d", a->rd)
+INSN(SWAP,   "r%d", a->rd)
+INSN(SBI,    "$%d, %d", a->reg, a->bit)
+INSN(CBI,    "%d, %d", a->reg, a->bit)
+INSN(BST,    "r%d, %d", a->rd, a->bit)
+INSN(BLD,    "r%d, %d", a->rd, a->bit)
+INSN_MNEMONIC(BSET,  bset[a->bit], "")
+INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
+
+/*
+ * MCU Control Instructions
+ */
+INSN(BREAK,  "")
+INSN(NOP,    "")
+INSN(SLEEP,  "")
+INSN(WDR,    "")
diff --git a/target/avr/translate.c b/target/avr/translate.c
index af88bb2e5a..064eee0ffb 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2976,6 +2976,18 @@ done_generating:
 
     tb->size = (ctx.npc - pc_start) * 2;
     tb->icount = num_insns;
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
+        && qemu_log_in_addr_range(tb->pc)) {
+        FILE *fd;
+        fd = qemu_log_lock();
+        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+        log_target_disas(cs, tb->pc, tb->size);
+        qemu_log("\n");
+        qemu_log_unlock(fd);
+    }
+#endif
 }
 
 void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
-- 
2.21.1


