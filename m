Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F98C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5920B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOaM2cN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYtO-0005hu-Ei
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:59:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkE-0006PD-GR
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkC-0000Fe-LZ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYkC-0000ED-FI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so2081281wma.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gs/MZPP07Uk1YwonADDRXbResLLSvRO48g8gHzEWeTY=;
	b=KOaM2cN+EBDKcnFwXsHMFCUhnjFU+3/cC9Oxn5eEyA9UTqNdjvLEBUxLJmB7kc+R48
	E5du212W96JJUi6kVA6k2k5glbGgxrFLmVG3Y9xcCHojwWa/7imILXfCPxeNDPKgLQvy
	6w579QDN6fdHWp912XoL5utQTpoBMtL5uA1I1XukkK4t0CTiYsPz/m5U9AGYnH6VY1Au
	3hvi6Sx+ESpmBxSJPJHkK8uXANVGVdpfioZhdt/lIh7pvGWM4EEckvWbIJTXbL9I28VC
	yqyOPEpKbIhCFxIAOjH427sccSqtNbFTMXQ94+VizgsXfqCpXKWFp5atFGNrYwn1BD0Y
	rtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gs/MZPP07Uk1YwonADDRXbResLLSvRO48g8gHzEWeTY=;
	b=cajyUEfwgkiaSn5ylDPopn7gmTYAAlGwLmQidSC1T92ssKJmMogVlDBFtJ3eRgVWUS
	uEffQ2p/+/roOZzla9t0BGNBTfMk6V0deqqgZ+EprMuyGsBDLIHFtyRNEXuWgbNrzodY
	pKNeJ5RtInkiCpGwmsu/if3x+SovvBtqUb4FI93GWf5i/XrPILLs39x5ANEer/gyxSFL
	wuBtOoFxKhQzF6YqEuCqf2hEFgPiTzOG8wLXkn/fTbGuJs2k46Bci9n2Vb6SIG4xwABM
	gJ8UFkoWlnpDUB7Jk8l/+0EJLas2hVSvIb7u8B5SFgZxUxIl9y9nA93p6gWTbgOGhjiQ
	scfQ==
X-Gm-Message-State: APjAAAXxM5DaywRCmu2imbNEecMVqbkSFxv4u+cBTUUZGZ3HxdbXd8rF
	O89mAMPMbGQ++spdqTqf5/F5Pg==
X-Google-Smtp-Source: APXvYqwEYtZMOZzHWmKDStAb8cZXBqXdcdcihuI50fXxms9naC+15VJnEEEaVZU63O37BoavKHtZQA==
X-Received: by 2002:a05:600c:10d2:: with SMTP id
	l18mr2532304wmd.174.1559037007353; 
	Tue, 28 May 2019 02:50:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id h8sm6125436wmf.5.2019.05.28.02.50.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:50:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id ED9491FF8C;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:42 +0100
Message-Id: <20190528094953.14898-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 17/28] tests/tcg/aarch64: add system boot.S
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"open list:ARM" <qemu-arm@nongnu.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides the bootstrap and low level helper functions for an
aarch64 kernel. We use semihosting to handle test output and exiting
the emulation. semihosting's parameter passing is a little funky so we
end up using the stack and pointing to that as the parameter block.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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


