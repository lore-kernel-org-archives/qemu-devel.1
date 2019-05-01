Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443B920652
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV+2zF+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443B920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLuD1-0006fA-Eq
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:43:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLuCG-0006Nq-Nw
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLuCE-0006Bz-RY
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:43:12 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:33045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLuCE-0006BR-B6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:43:10 -0400
Received: by mail-pg1-x52d.google.com with SMTP id k19so8668411pgh.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=aSf8uCXWDtL+GCWc8sjKCcUVUcQxixvDcf5HPmbD2YU=;
	b=YV+2zF+EZZ1btXLT9O/MjGybWjcoBB1qwE1J4rCvEL2U5z8xgFAJJdfeAxnjbtcHCs
	WKaHZEUjvNpUrlo6Wg3YF1zJvGpC/Ep80TUw30Q3efEowYXnjz4ncl35g4Zq5na/pWu5
	oJNATk/mEQJTyFFuNyiwvpf67EhEIpKTJoxRkuERSLgP4WmsU2K9SAM1G7s2jh0tVudP
	uZ6OA/CpGsTxv0HdZgAnO+onTBTSis7SE0jxD9+Ev01l8+vL1N0iydz9ZVRAu/RSsGXm
	G4fU033CEbWKnB9mFSA66Ue+6rP0+v73WD/I4gu3j3L0T9qop7gdo2HjalKVx9FtD++s
	EWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=aSf8uCXWDtL+GCWc8sjKCcUVUcQxixvDcf5HPmbD2YU=;
	b=d7WBP0bT/ZKfIlKL4Ae94crqE3KdnNgOcEJGlKMjOKgBPRkxJnpDpcwD7CeViiovnd
	BQRa+vBCkAbdLMS9DgqtD1jS9/h9PvASeEvIbKq01lz0DZKSBIhoIlirrghnMFyltgIT
	+/4rfz/uuy/RmXToi/Elj4Y5C1AzsnLV+p12+S/H3yfb/H8XfCP0ckNFtSVg8Q0EbswA
	JUB0gHFJy8ax42BukBYZ8SQiM5mmEsHGOkfoTDmdbjrXqtTgYIk3CzCMuA/BxKd3JmFp
	wuiWUvsyp3Ti4rw1YGO+swCMw6xlQlsyzPJcYMd8fxkZIHL9QfYvnUqYuwmekakYOKwP
	1AbQ==
X-Gm-Message-State: APjAAAX0BxjloeGo40hfwontqnYFNqljPFOKuQtV6+ttVnD9EoZgC6V9
	D1/vXRS3Zl0HqpHUNdmgekEcbbdM5xw=
X-Google-Smtp-Source: APXvYqwAPUkktuvlLe90qzbMtS6chQVrAgKI4McJvPu4ZXXq+ZYp86O0MPNQdhJSqDCMomk2VmugSQ==
X-Received: by 2002:a63:f147:: with SMTP id o7mr75994952pgk.197.1556736188611; 
	Wed, 01 May 2019 11:43:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	b20sm33779630pff.118.2019.05.01.11.43.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 11:43:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 11:43:06 -0700
Message-Id: <20190501184306.15208-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501184306.R2sbUxi0qXQ__hcb_pl9cmLJnuZsE4Nbn8A5nNy2FI8@z>

This provides the bootstrap and low level helper functions for an
alpha kernel.  We use direct access to the DP264 serial port for
test output, and hard machine halt to exit the emulation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/alpha/Makefile.softmmu-target |  32 ++
 tests/tcg/alpha/system/boot.S           | 511 ++++++++++++++++++++++++
 tests/tcg/alpha/system/kernel.ld        |  30 ++
 3 files changed, 573 insertions(+)
 create mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/boot.S
 create mode 100644 tests/tcg/alpha/system/kernel.ld

diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
new file mode 100644
index 0000000000..9f4b199258
--- /dev/null
+++ b/tests/tcg/alpha/Makefile.softmmu-target
@@ -0,0 +1,32 @@
+#
+# Alpha system tests
+#
+
+ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
+VPATH+=$(ALPHA_SYSTEM_SRC)
+
+# These objects provide the basic boot code and helper functions for all tests
+CRT_OBJS=boot.o
+
+ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
+ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
+
+CRT_PATH=$(ALPHA_SYSTEM_SRC)
+LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
+LDFLAGS=-Wl,-T$(LINK_SCRIPT)
+TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
+CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+
+# building head blobs
+.PRECIOUS: $(CRT_OBJS)
+
+%.o: $(CRT_PATH)/%.S
+	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
+
+# Build and link the tests
+%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+
+# Running
+QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/system/boot.S b/tests/tcg/alpha/system/boot.S
new file mode 100644
index 0000000000..6d7fb36e17
--- /dev/null
+++ b/tests/tcg/alpha/system/boot.S
@@ -0,0 +1,511 @@
+/*
+ * Minimal Alpha system boot code.
+ *
+ * Copyright Linaro Ltd 2019
+ */
+
+	.set	noat
+	.set	nomacro
+	.arch	ev6
+	.text
+
+.macro load_pci_io reg
+	/* For typhoon, this is
+	 *   0xfffffc0000000000  -- kseg identity map
+	 * +      0x10000000000  -- typhoon pio base
+	 * +        0x1fc000000  -- typhoon pchip0 pci base
+	 * = 0xfffffd01fc000000
+	 */
+	ldah	\reg, -3		/* ff..fd0000 */
+	lda	\reg, 0x1fc(\reg)	/* ff..fd01fc */
+	sll	\reg, 24, \reg
+.endm
+
+#define com1Rbr 0x3f8
+#define com1Thr 0x3f8
+#define com1Ier 0x3f9
+#define com1Iir 0x3fa
+#define com1Lcr 0x3fb
+#define com1Mcr 0x3fc
+#define com1Lsr 0x3fd
+#define com1Msr 0x3fe
+#define com1Scr 0x3ff
+#define com1Dll 0x3f8
+#define com1Dlm 0x3f9
+
+#define PAL_halt    0
+#define PAL_wrent  52
+#define PAL_wrkgp  55
+
+	.text
+	.p2align 4
+	.globl	_start
+	.ent	_start
+_start:
+	br	$gp, .+4
+	ldah	$gp, 0($gp)		!gpdisp!1
+	lda	$gp, 0($gp)		!gpdisp!1
+
+	ldah	$sp, $stack_end($gp)	!gprelhigh
+	lda	$sp, $stack_end($gp)	!gprellow
+
+	/* Install kernel gp for exception handlers.  */
+	mov	$gp, $16
+	call_pal PAL_wrkgp
+
+	/* Install exception handlers.  */
+	ldah	$16, entInt($gp)	!gprelhigh
+	lda	$16, entInt($16)	!gprellow
+	lda	$17, 0
+	call_pal PAL_wrent
+
+	ldah	$16, entArith($gp)	!gprelhigh
+	lda	$16, entArith($16)	!gprellow
+	lda	$17, 1
+	call_pal PAL_wrent
+
+	ldah	$16, entMM($gp)		!gprelhigh
+	lda	$16, entMM($16)		!gprellow
+	lda	$17, 2
+	call_pal PAL_wrent
+
+	ldah	$16, entIF($gp)		!gprelhigh
+	lda	$16, entIF($16)		!gprellow
+	lda	$17, 3
+	call_pal PAL_wrent
+
+	ldah	$16, entUna($gp)	!gprelhigh
+	lda	$16, entUna($16)	!gprellow
+	lda	$17, 4
+	call_pal PAL_wrent
+
+	ldah	$16, entSys($gp)	!gprelhigh
+	lda	$16, entSys($16)	!gprellow
+	lda	$17, 5
+	call_pal PAL_wrent
+
+	/*
+	 * Initialize COM1.
+	 */
+	load_pci_io $1
+	lda	$2, 0x87		/* outb(0x87, com1Lcr); */
+	stb	$2, com1Lcr($1)
+	stb	$31, com1Dlm($1)	/* outb(0, com1Dlm); */
+	lda	$2, 3			/* baudconst 3 => 56000 */
+	stb	$2, com1Dll($1)		/* outb(baudconst, com1Dll); */
+	lda	$2, 0x07
+	stb	$2, com1Lcr($1)		/* outb(0x07, com1Lcr) */
+	lda	$2, 0x0f
+	stb	$2, com1Mcr($1)		/* outb(0x0f, com1Mcr) */
+
+	bsr	$26, main		!samegp
+
+	/* fall through to _exit */
+	.end	_start
+
+	.globl	_exit
+	.ent	_exit
+_exit:
+	.frame	$sp, 0, $26, 0
+	.prologue 0
+
+	/* We cannot return an error code.  */
+	call_pal PAL_halt
+	.end	_exit
+
+/*
+ * We have received an exception that we don't handle.  Log and exit.
+ */
+	.ent	log_exit
+log_exit:
+entInt:
+entArith:
+entMM:
+entIF:
+entUna:
+entSys:
+	ldah	$16, $errormsg($gp)	!gprelhigh
+	lda	$16, $errormsg($16)	!gprellow
+	bsr	$26, __sys_outs		!samegp
+	bsr	$26, _exit		!samegp
+	.end	log_exit
+
+	.section .rodata
+$errormsg:
+	.string "Terminated by exception.\n"
+	.previous
+
+	/*
+	 * Helper Functions
+	 */
+
+	/* Output a single character to serial port */
+	.global __sys_outc
+	.ent	__sys_outc
+__sys_outc:
+	.frame	$sp, 0, $26, 0
+	.prologue 0
+
+	load_pci_io $1
+
+	/* 
+	 * while ((inb(com1Lsr) & 0x20) == 0)
+	 *       continue;
+	 */
+1:	ldbu	$0, com1Lsr($1)
+	and	$0, 0x20, $0
+	beq	$0, 1b
+
+	/* outb(c, com1Thr); */
+	stb	$16, com1Thr($1)
+	ret
+	.end	__sys_outc
+
+	/* Output a nul-terminated string to serial port */
+	.global	__sys_outs
+	.ent	__sys_outs
+__sys_outs:
+	.frame	$sp, 0, $26, 0
+	.prologue 0
+
+	load_pci_io $1
+
+	ldbu	$2, 0($16)
+	beq	$2, 9f
+
+	/* 
+	 * while ((inb(com1Lsr) & 0x20) == 0)
+	 *       continue;
+	 */
+1:	ldbu	$0, com1Lsr($1)
+	and	$0, 0x20, $0
+	beq	$0, 1b
+
+	/* outb(c, com1Thr); */
+	stb	$2, com1Thr($1)
+
+	addq	$16, 1, $16
+	ldbu	$2, 0($16)
+	bne	$2, 1b
+
+9:	ret
+	.end	__sys_outs
+
+/*
+ * Division routines that are normally in libc.
+ *
+ * These do not follow the C calling convention.  Arguments are in $24+$25,
+ * the result is in $27.  Register $28 may be clobbered; everything else
+ * must be saved.
+ *
+ * We store the remainder in $28, so that we can share code.
+ *
+ * We do not signal divide by zero.
+ */
+
+/*
+ * Unsigned 64-bit division.
+ */
+
+	.globl	__divqu
+	.ent	__divqu
+__divqu:
+	.frame	$sp, 48, $23
+	subq	$sp, 48, $sp
+	stq	$0, 0($sp)
+	stq	$1, 8($sp)
+	stq	$2, 16($sp)
+	stq	$3, 24($sp)
+	stq	$4, 32($sp)
+	.prologue 0
+
+#define mask     $0
+#define divisor  $1
+#define compare  $2
+#define tmp1     $3
+#define tmp2     $4
+#define quotient $27
+#define modulus  $28
+
+	mov	$24, modulus
+	mov	$25, divisor
+	mov	$31, quotient
+	mov	1, mask
+	beq	$25, 9f
+
+	/* Shift left until divisor >= modulus.  */
+1:	cmpult	divisor, modulus, compare
+	blt	divisor, 2f
+	addq	divisor, divisor, divisor
+	addq	mask, mask, mask
+	bne	compare, 1b
+
+2:	addq	quotient, mask, tmp2
+	srl	mask, 1, mask
+	cmpule	divisor, modulus, compare
+	subq	modulus, divisor, tmp1
+	cmovne	compare, tmp2, quotient
+	srl	divisor, 1, divisor
+	cmovne	compare, tmp1, modulus
+	bne	mask, 2b
+
+9:	ldq	$0, 0($sp)
+	ldq	$1, 8($sp)
+	ldq	$2, 16($sp)
+	ldq	$3, 24($sp)
+	ldq	$4, 32($sp)
+	addq	$sp, 48, $sp
+	ret	$31, ($23), 1
+
+#undef mask
+#undef divisor
+#undef compare
+#undef tmp1
+#undef tmp2
+#undef quotient
+#undef modulus
+
+	.end	__divqu
+
+/*
+ * Unsigned 64-bit remainder.
+ * Note that __divqu above leaves the result in $28.
+ */
+
+	.globl	__remqu
+	.ent	__remqu
+__remqu:
+	.frame	$sp, 16, $23
+	subq	$sp, 16, $sp
+	stq	$23, 0($sp)
+	.prologue 0
+
+	bsr	$23, __divqu
+
+	ldq	$23, 0($sp)
+	mov	$28, $27
+	addq	$sp, 16, $sp
+	ret	$31, ($23), 1
+	.end	__remqu
+
+/*
+ * Signed 64-bit division.
+ */
+
+	.globl	__divqs
+	.ent	__divqs
+__divqs:
+	.prologue 0
+
+	/* Common case: both arguments are positive.  */
+	bis	$24, $25, $28
+	bge	$28, __divqu
+
+	/* At least one argument is negative.  */
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+
+	/* Compute absolute values.  */
+	subq	$31, $24, $28
+	cmovlt	$24, $28, $24
+	subq	$31, $25, $28
+	cmovlt	$25, $28, $25
+
+	bsr	$23, __divqu
+
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+
+	/* -a / b = a / -b = -(a / b) */
+	subq	$31, $27, $23
+	xor	$24, $25, $28
+	cmovlt	$28, $23, $27
+
+	ldq	$23, 0($sp)
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__divqs
+
+/*
+ * Signed 64-bit remainder.
+ */
+
+	.globl	__remqs
+	.ent	__remqs
+__remqs:
+	.prologue 0
+
+	/* Common case: both arguments are positive.  */
+	bis	$24, $25, $28
+	bge	$28, __remqu
+
+	/* At least one argument is negative.  */
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+
+	/* Compute absolute values.  */
+	subq	$31, $24, $28
+	cmovlt	$24, $28, $24
+	subq	$31, $25, $28
+	cmovlt	$25, $28, $25
+
+	bsr	$23, __divqu
+
+	ldq	$23, 0($sp)
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+
+	/* -a % b = -(a % b); a % -b = a % b.  */
+	subq	$31, $28, $27
+	cmovge	$24, $28, $27
+
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__remqs
+
+/*
+ * Unsigned 32-bit division.
+ */
+
+	.globl	__divlu
+	.ent	__divlu
+__divlu:
+	.frame	$sp, 32, $23
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+	.prologue 0
+
+	/* Zero extend and use the 64-bit routine.  */
+	zap	$24, 0xf0, $24
+	zap	$25, 0xf0, $25
+	bsr	$23, __divqu
+
+	addl	$27, 0, $27
+	ldq	$23, 0($sp)
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__divlu
+
+/*
+ * Unsigned 32-bit remainder.
+ */
+
+	.globl	__remlu
+	.ent	__remlu
+__remlu:
+	.frame	$sp, 32, $23
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+	.prologue 0
+
+	/* Zero extend and use the 64-bit routine.  */
+	zap	$24, 0xf0, $24
+	zap	$25, 0xf0, $25
+	bsr	$23, __divqu
+
+	/* Recall that the remainder is returned in $28.  */
+	addl	$28, 0, $27
+	ldq	$23, 0($sp)
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__remlu
+
+/*
+ * Signed 32-bit division.
+ */
+
+	.globl	__divls
+	.ent	__divls
+__divls:
+	.frame	$sp, 32, $23
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+	.prologue 0
+
+	/* Sign extend.  */
+	addl	$24, 0, $24
+	addl	$25, 0, $25
+
+	/* Compute absolute values.  */
+	subq	$31, $24, $28
+	cmovlt	$24, $28, $24
+	subq	$31, $25, $28
+	cmovlt	$25, $28, $25
+
+	bsr	$23, __divqu
+
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+
+	/* Negate the unsigned result, if necessary.  */
+	xor	$24, $25, $28
+	subl	$31, $27, $23
+	addl	$27, 0, $27
+	addl	$28, 0, $28
+	cmovlt	$28, $23, $27
+
+	ldq	$23, 0($sp)
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__divls
+
+/*
+ * Signed 32-bit remainder.
+ */
+
+	.globl	__remls
+	.ent	__remls
+__remls:
+	.frame	$sp, 32, $23
+	subq	$sp, 32, $sp
+	stq	$23, 0($sp)
+	stq	$24, 8($sp)
+	stq	$25, 16($sp)
+	.prologue 0
+
+	/* Sign extend.  */
+	addl	$24, 0, $24
+	addl	$25, 0, $25
+
+	/* Compute absolute values.  */
+	subq	$31, $24, $28
+	cmovlt	$24, $28, $24
+	subq	$31, $25, $28
+	cmovlt	$25, $28, $25
+
+	bsr	$23, __divqu
+
+	ldq	$23, 0($sp)
+	ldq	$24, 8($sp)
+	ldq	$25, 16($sp)
+
+	/* Negate the unsigned result, if necessary.  */
+	subl	$31, $28, $27
+	addl	$28, 0, $28
+	cmovge	$24, $28, $27
+
+	addq	$sp, 32, $sp
+	ret	$31, ($23), 1
+	.end	__remls
+
+	.data
+	.p2align 4
+stack:
+	.skip	65536
+$stack_end:
+	.type	stack,@object
+	.size	stack, . - stack
diff --git a/tests/tcg/alpha/system/kernel.ld b/tests/tcg/alpha/system/kernel.ld
new file mode 100644
index 0000000000..d2ac6ecfeb
--- /dev/null
+++ b/tests/tcg/alpha/system/kernel.ld
@@ -0,0 +1,30 @@
+ENTRY(_start)
+
+SECTIONS
+{
+    /* Linux kernel legacy start address.  */
+    . = 0xfffffc0000310000;
+    _text = .;
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    _etext = .;
+
+    . = ALIGN(8192);
+    _data = .;
+    .got : {
+        *(.got)
+    }
+    .data : {
+	*(.sdata)
+        *(.data)
+    }
+    _edata = .;
+    .bss : {
+        *(.bss)
+    }
+    _end = .;
+}
-- 
2.17.1


