Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490142173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hhm0veeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490142173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmaH-0000yX-Fy
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:11:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOE-00075l-2e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOC-0004xL-8O
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmOC-0004wY-1i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id j187so4086958wmj.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=r55nf64rXTYonXxnBwdRPnRpArKhgZe9MpWloO32Vxg=;
	b=Hhm0veeBIE/ZX5O9Xv0p8XloLTPr2TejMXnt2lGqWJBm4522NKGvWyU6JY9BBeGfiO
	IosZYRP6nKB48LfzFw0y5Of+AtK9jdzED3OveNSmX2XoUXlCnseQjPqyV22IIDqwvWJS
	/kIGcazT/hcgXlsEXoaLYJCy++BFPttUJddaR4r7CtwF0p5mf8hWMWYWd5OdVfn0Tmmw
	Rx25cgIMMltoMG4SUHm2P/YEWtS9LkjXX+Jgy3moBeXbsNFOx0SLp2n40pUPr1LmAQ0p
	DEfbVn4roowNPN0nDg7NB7lGxpFrzVTMk5cYEm0MrdkwHscMb0EbNhR+2z25S7uMkgQd
	JhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=r55nf64rXTYonXxnBwdRPnRpArKhgZe9MpWloO32Vxg=;
	b=GSkOVT+bmBhn6Am5CXfZtgrn8ansyijDHd9WBUBaSc0nQ0ab1b09GNhv8Pu4ydMmLt
	ugXIiNR318i3vKJUtZlHCtQOQEDhfszx74uTIb53VTbVo+x/Ka0mSCBjcDGY9a2W9l4I
	4EdBzqwL0gper0uLYjClwgYgBf4JwHK7V15/J8YfUfZvTQnOyuHd89+8uZfKSFDTsUWG
	0Va6kq0zzq+JRCLlLuV2hDaskIDoBAFpG+x8eW0WjqUorjM/1To+kSK27feUlj1WEFut
	p2MONjcxWfZAEEiE0tvNNyi2wjB4cStcviMhNHosNlmb040z/e5NrTLvoLOayLdk5g5w
	AK6g==
X-Gm-Message-State: APjAAAUPSqhYT65QJnnw0QqH8WZMj/8Lv6DQW9rVKI5S9FkCWuyXbYsk
	JxBygQRNL/aUYFs+ukbTuzqgiw==
X-Google-Smtp-Source: APXvYqwmd2ZEaBKTxdq7YYG3MA70dc3UxnmiFbEY6NKnHDFYMjWPw6AzLWynt/Ukpw24zem0Xq8Xgw==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr3906011wmj.22.1557421162955;
	Thu, 09 May 2019 09:59:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a4sm4293424wmf.45.2019.05.09.09.59.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9EE0A1FF96;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:55 +0100
Message-Id: <20190509165912.10512-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 07/23] tests/tcg/aarch64: add system boot.S
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides the bootstrap and low level helper functions for an
aarch64 kernel. We use semihosting to handle test output and exiting
the emulation. semihosting's parameter passing is a little funky so we
end up using the stack and pointing to that as the parameter block.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix tabs
  - 2 stage table lookup with ro and nx sections
  - set stack to back
  - moar comments
---
 tests/tcg/aarch64/Makefile.softmmu-target |  32 +++
 tests/tcg/aarch64/system/boot.S           | 239 ++++++++++++++++++++++
 tests/tcg/aarch64/system/kernel.ld        |  24 +++
 3 files changed, 295 insertions(+)
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
new file mode 100644
index 00000000000..cdb836f7e1e
--- /dev/null
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -0,0 +1,32 @@
+#
+# Aarch64 system tests
+#
+
+AARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/aarch64/system
+VPATH+=$(AARCH64_SYSTEM_SRC)
+
+# These objects provide the basic boot code and helper functions for all tests
+CRT_OBJS=boot.o
+
+AARCH64_TEST_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
+AARCH64_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_SRCS))
+
+CRT_PATH=$(AARCH64_SYSTEM_SRC)
+LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
+LDFLAGS=-Wl,-T$(LINK_SCRIPT)
+TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
+CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
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
+QEMU_OPTS+=-M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
new file mode 100644
index 00000000000..b14e94f332d
--- /dev/null
+++ b/tests/tcg/aarch64/system/boot.S
@@ -0,0 +1,239 @@
+/*
+ * Minimal AArch64 system boot code.
+ *
+ * Copyright Linaro Ltd 2019
+ *
+ * Loosely based on the newlib/libgloss setup stubs. Using semihosting
+ * for serial output and exit functions.
+ */
+
+/*
+ * Semihosting interface on ARM AArch64
+ * See "Semihosting for AArch32 and AArch64 Relase 2.0" by ARM
+ * w0 - semihosting call number
+ * x1 - semihosting parameter
+ */
+#define semihosting_call hlt 0xf000
+#define SYS_WRITEC	0x03	/* character to debug channel */
+#define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_EXIT	0x18
+
+	.align	12
+
+	.macro	ventry	label
+	.align	7
+	b	\label
+	.endm
+
+vector_table:
+	/* Current EL with SP0.	 */
+	ventry	curr_sp0_sync		/* Synchronous	*/
+	ventry	curr_sp0_irq		/* Irq/vIRQ  */
+	ventry	curr_sp0_fiq		/* Fiq/vFIQ  */
+	ventry	curr_sp0_serror		/* SError/VSError  */
+
+	/* Current EL with SPx.	 */
+	ventry	curr_spx_sync		/* Synchronous	*/
+	ventry	curr_spx_irq		/* IRQ/vIRQ  */
+	ventry	curr_spx_fiq		/* FIQ/vFIQ  */
+	ventry	curr_spx_serror		/* SError/VSError  */
+
+	/* Lower EL using AArch64.  */
+	ventry	lower_a64_sync		/* Synchronous	*/
+	ventry	lower_a64_irq		/* IRQ/vIRQ  */
+	ventry	lower_a64_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a64_serror	/* SError/VSError  */
+
+	/* Lower EL using AArch32.  */
+	ventry	lower_a32_sync		/* Synchronous	*/
+	ventry	lower_a32_irq		/* IRQ/vIRQ  */
+	ventry	lower_a32_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a32_serror	/* SError/VSError  */
+
+	.text
+	.align 4
+
+	/* Common vector handling for now */
+curr_sp0_sync:
+curr_sp0_irq:
+curr_sp0_fiq:
+curr_sp0_serror:
+curr_spx_sync:
+curr_spx_irq:
+curr_spx_fiq:
+curr_spx_serror:
+lower_a64_sync:
+lower_a64_irq:
+lower_a64_fiq:
+lower_a64_serror:
+lower_a32_sync:
+lower_a32_irq:
+lower_a32_fiq:
+lower_a32_serror:
+	mov	x0, SYS_WRITE0
+	adr	x1, .error
+	semihosting_call
+	mov	x0, SYS_EXIT
+	mov	x1, 1
+	semihosting_call
+	/* never returns */
+
+	.section .rodata
+.error:
+	.string "Terminated by exception.\n"
+
+	.text
+	.align 4
+	.global __start
+__start:
+	/* Installs a table of exception vectors to catch and handle all
+	   exceptions by terminating the process with a diagnostic.  */
+	adr	x0, vector_table
+	msr	vbar_el1, x0
+
+	/* Page table setup (identity mapping). */
+	adrp	x0, ttb
+	add	x0, x0, :lo12:ttb
+	msr	ttbr0_el1, x0
+
+	/*
+	 * Setup a flat address mapping page-tables. Stage one simply
+	 * maps RAM to the first Gb. The stage2 tables have two 2mb
+	 * translation block entries covering a series of adjacent
+	 * 4k pages.
+	*/
+
+	/* Stage 1 entry: indexed by IA[38:30] */
+	adr	x1, .				/* phys address */
+	bic	x1, x1, #(1 << 30) - 1		/* 1GB alignment*/
+	add	x2, x0, x1, lsr #(30 - 3)	/* offset in l1 page table */
+
+	/* point to stage 2 table [47:12] */
+	adrp	x0, ttb_stage2
+	orr 	x1, x0, #3 			/* ptr to stage 2 */
+	str	x1, [x2]
+
+	/* Stage 2 entries: indexed by IA[29:21] */
+	ldr	x5, =(((1 << 9) - 1) << 21)
+
+	/* First block: .text/RO/execute enabled */
+	adr	x1, .				/* phys address */
+	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment	*/
+	and	x4, x1, x5			/* IA[29:21] */
+	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
+	ldr	x3, =0x401			/* attr(AF, block) */
+	orr	x1, x1, x3
+	str	x1, [x2]			/* 1st 2mb (.text & rodata) */
+
+	/* Second block: .data/RW/no execute */
+	adrp	x1, .data
+	add	x1, x1, :lo12:.data
+	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment */
+	and	x4, x1, x5			/* IA[29:21] */
+	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
+	ldr	x3, =(3 << 53) | 0x401		/* attr(AF, NX, block) */
+	orr	x1, x1, x3
+	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
+
+	/* Setup/enable the MMU.  */
+
+	/*
+	 * TCR_EL1 - Translation Control Registers
+	 *
+	 * IPS[34:32] = 40-bit PA, 1TB
+	 * TG0[14:15] = b00 => 4kb granuale
+	 * ORGN0[11:10] = Outer: Normal, WB Read-Alloc No Write-Alloc Cacheable
+	 * IRGN0[9:8] = Inner: Normal, WB Read-Alloc No Write-Alloc Cacheable
+	 * T0SZ[5:0]  = 2^(64 - 25)
+	 *
+	 * The size of T0SZ controls what the initial lookup level. It
+	 * would be nice to start at level 2 but unfortunatly for a
+	 * flat-mapping on the virt machine we need to handle IA's
+	 * with at least 1gb range to see RAM. So we start with a
+	 * level 1 lookup.
+	 */
+	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
+	msr	tcr_el1, x0
+
+	mov	x0, #0xee			/* Inner/outer cacheable WB */
+	msr	mair_el1, x0
+	isb
+
+	/*
+	 * SCTLR_EL1 - System Control Register
+	 *
+	 * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
+	 * I[12] = Instruction cachability control
+	 * SA[3] = SP alignment check
+	 * C[2] = Data cachability control
+	 * M[0] = 1, enable stage 1 address translation for EL0/1
+	 */
+	mrs	x0, sctlr_el1
+	ldr	x1, =0x100d			/* bits I(12) SA(3) C(2) M(0) */
+	bic	x0, x0, #(1 << 1)		/* clear bit A(1) */
+	bic	x0, x0, #(1 << 19)		/* clear WXN */
+	orr	x0, x0, x1			/* set bits */
+
+	dsb	sy
+	msr	sctlr_el1, x0
+	isb
+
+	/*
+	 * Enable FP registers. The standard C pre-amble will be
+	 * saving these and A-profile compilers will use AdvSIMD
+	 * registers unless we tell it not to.
+	*/
+	mrs	x0, cpacr_el1
+	orr	x0, x0, #(3 << 20)
+	msr	cpacr_el1, x0
+
+	/* Setup some stack space and enter the test code.
+	 * Assume everthing except the return value is garbage when we
+	 * return, we won't need it.
+	 */
+	adrp	x0, stack_end
+	add	x0, x0, :lo12:stack_end
+	mov	sp, x0
+	bl	main
+
+	/* pass return value to sys exit */
+	mov    x1, x0
+	ldr    x0, =0x20026 /* ADP_Stopped_ApplicationExit */
+	stp    x0, x1, [sp, #-16]!
+	mov    x1, sp
+	mov    x0, SYS_EXIT
+	semihosting_call
+	/* never returns */
+
+	/*
+	 * Helper Functions
+	*/
+
+	/* Output a single character to serial port */
+	.global __sys_outc
+__sys_outc:
+	stp x0, x1, [sp, #-16]!
+	/* pass address of c on stack */
+	mov x1, sp
+	mov x0, SYS_WRITEC
+	semihosting_call
+	ldp x0, x1, [sp], #16
+	ret
+
+	.data
+	.align	12
+
+	/* Translation table
+	 * @4k granuale: 9 bit lookup, 512 entries
+	*/
+ttb:
+	.space	4096, 0
+
+	.align	12
+ttb_stage2:
+	.space	4096, 0
+
+	.align	12
+stack:
+	.space 65536, 0
+stack_end:
diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
new file mode 100644
index 00000000000..7b3a76dcbf3
--- /dev/null
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -0,0 +1,24 @@
+ENTRY(__start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 1gb */
+    . = (1 << 30);
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    /* align r/w section to next 2mb */
+    . = ALIGN(1 << 21);
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+    /DISCARD/ : {
+        *(.ARM.attributes)
+    }
+}
-- 
2.20.1


