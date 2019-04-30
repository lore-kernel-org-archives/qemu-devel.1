Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C248C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018AE2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNkDXDry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018AE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW9J-0001g5-8G
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:02:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2G-00048Z-QX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzj-0000h4-9f
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzj-0000eF-1n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so4633424wmh.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+yEjKlsJwKF3hEXc9nK8fe/qlKiVoemDI5/tX+ia1Pc=;
	b=KNkDXDryalQaUVk8kBf3RZ5IBHM6bzB1UHB+Crasgc/srA5RwQoJYIt56dn5MEiPmF
	/N7ZKdYTd3RQ1zLtqi0GJDL6UdBMoW7yAdxjEfkLntyCQGuxUBjz+WjZTBNEDx4ju18u
	Dad02m/wH4E/Tk3nDh+3EgWeROZWw7RSSjvmfOY+4w/oSLCsiOGVoJ8rmQ13waA1A7Oz
	qdl9uv4Hu08m+IwLEV5NJkXzn0v8dlvAZP6folAfdoWahROle26KSVLTs8y3/JZ4q8df
	fMWEMH9h+obQd/dnY84j8RZ1MIIjd8gEaL7DhXJdTaXPdil82win+J0eb6msW8oYryhN
	iP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+yEjKlsJwKF3hEXc9nK8fe/qlKiVoemDI5/tX+ia1Pc=;
	b=BPonSp0HanQvC32bytEnHmeE5k3butPK2NNwWGThxOLoOHRVWrrvE32aAYOyq0O9qj
	DWm5qR32WKTs90F+AkOk4TZehomGM4y/qkZq0J/qji5+Z53oAWcH8dyBhLxcyk3tssj/
	1DTpgXdxD4RQ/GJVxbnH5upt1UYqzSTxXf0SkM3+lZPUVX43DXuNMtfhZqvEcd9H0K6o
	Vipz3AoQUwTRf0NC4F4CP8gERDoINKpVYN2tqMZAPcQdzfbJL3ugPv7C3bNkWcHlsIlX
	F+B08rm4Gew6WMmK2D7eql9pWDOfYqdXJI01N871U+C6HEXLynhEWPEIEgtBOZkKGNCY
	nXkg==
X-Gm-Message-State: APjAAAVPoWR/dxIYdVdSWLr7TnVlU9Ek/iMfENYFrIL74oIq5TYSyp8E
	OTiA0Zw0wgeAnxe1js0i4kRBZA==
X-Google-Smtp-Source: APXvYqyDxeqbXwhHfSOG+ZkGxHH5Nm+HcV6DGzwmhirVKuSrnGw4O6V4ijhe6Noiw+II/oZEEr7lzw==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr3843425wmj.0.1556643157838;
	Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b11sm5439488wmh.29.2019.04.30.09.52.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A3EA91FF90;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:22 +0100
Message-Id: <20190430165234.32272-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v5 03/15] tests/tcg/aarch64: add system boot.S
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165222.UuGtw--KilFSWi6uJxCCxgAT3zMgVDIiSZR3DwK1tAM@z>

This provides the bootstrap and low level helper functions for an
aarch64 kernel. We use semihosting to handle test output and exiting
the emulation. semihosting's parameter passing is a little funky so we
end up using the stack and pointing to that as the parameter block.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |  32 ++++
 tests/tcg/aarch64/system/boot.S           | 200 ++++++++++++++++++++++
 tests/tcg/aarch64/system/kernel.ld        |  22 +++
 3 files changed, 254 insertions(+)
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
new file mode 100644
index 0000000000..e6aee856c8
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
+QEMU_OPTS+=-M virt -cpu max -display none -semihosting -kernel
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
new file mode 100644
index 0000000000..03d319e07f
--- /dev/null
+++ b/tests/tcg/aarch64/system/boot.S
@@ -0,0 +1,200 @@
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
+#define SYS_WRITEC      0x03    /* character to debug channel */
+#define SYS_WRITE0      0x04    /* string to debug channel */
+#define SYS_EXIT        0x18
+
+	.align	12
+
+        .macro	ventry	label
+        .align	7
+        b	\label
+        .endm
+
+vector_table:
+	/* Current EL with SP0.  */
+	ventry	curr_sp0_sync		/* Synchronous  */
+	ventry	curr_sp0_irq		/* Irq/vIRQ  */
+	ventry	curr_sp0_fiq		/* Fiq/vFIQ  */
+	ventry	curr_sp0_serror		/* SError/VSError  */
+
+	/* Current EL with SPx.  */
+	ventry	curr_spx_sync		/* Synchronous  */
+	ventry	curr_spx_irq		/* IRQ/vIRQ  */
+	ventry	curr_spx_fiq		/* FIQ/vFIQ  */
+	ventry	curr_spx_serror		/* SError/VSError  */
+
+	/* Lower EL using AArch64.  */
+	ventry	lower_a64_sync		/* Synchronous  */
+	ventry	lower_a64_irq		/* IRQ/vIRQ  */
+	ventry	lower_a64_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a64_serror	/* SError/VSError  */
+
+	/* Lower EL using AArch32.  */
+	ventry	lower_a32_sync		/* Synchronous  */
+	ventry	lower_a32_irq		/* IRQ/vIRQ  */
+	ventry	lower_a32_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a32_serror	/* SError/VSError  */
+
+        .text
+	.align 4
+
+        /* Common vector handling for now */
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
+        semihosting_call
+	mov	x0, SYS_EXIT
+        mov     x1, 1
+        semihosting_call
+        /* never returns */
+
+.error:
+	.string "Terminated by exception.\n"
+
+        .align 4
+        .global __start
+__start:
+        /* Installs a table of exception vectors to catch and handle all
+           exceptions by terminating the process with a diagnostic.  */
+	adr	x0, vector_table
+	msr	vbar_el1, x0
+
+        /* Page table setup (identity mapping).  */
+	adrp	x0, ttb
+	add	x0, x0, :lo12:ttb
+	msr	ttbr0_el1, x0
+
+        /* Create some (big) pages */
+	adr	x1, .				/* phys address */
+	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */
+
+        add	x2, x0, x1, lsr #(30 - 3)	/* page offset in l1 page table */
+
+	mov	x3, #0x401			/* page table attributes (AF, block) */
+	orr	x1, x1, x3
+
+	str	x1, [x2], #8			/* 1st GB */
+
+	mov	x3, #(1 << 30)			/* 1GB block */
+	add	x1, x1, x3
+
+        str	x1, [x2]			/* 2nd GB */
+
+	/* Setup/enable the MMU.  */
+
+	/*
+         * TCR_EL1 - Translation Control Registers
+         *
+         * IPS[34:32] = 40-bit PA, 1TB
+         * ORGN0[11:10] = Outer: Normal, Outer Write-Back Read-Allocate No Write-Allocate Cacheable
+         * IRGN0[9:8] = Inner: Normal, Inner Write-Back Read-Allocate No Write-Allocate Cacheable.
+         * T0SZ[5:0]  = 2^(64 - 25)
+         */
+	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
+	msr	tcr_el1, x0
+
+	mov	x0, #0xee			/* Inner/outer cacheable WB */
+	msr	mair_el1, x0
+	isb
+
+        /*
+         * SCTLR_EL1 - System Control Register
+         *
+         * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
+         * I[12] = Instruction cachability control
+         * SA[3] = SP alignment check
+         * C[2] = Data cachability control
+         * M[0] = 1, enable stage 1 address translation for EL0/1
+         */
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
+        /*
+         * Enable FP registers. The standard C pre-amble will be
+	 * saving these and A-profile compilers will use AdvSIMD
+	 * registers unless we tell it not to.
+        */
+        mrs     x0, cpacr_el1
+        orr     x0, x0, #(3 << 20)
+        msr     cpacr_el1, x0
+
+        /* Setup some stack space and enter the test code.
+         * Assume everthing except the return value is garbage when we
+	 * return, we won't need it.
+         */
+	adrp	x0, stack
+	add	x0, x0, :lo12:stack
+
+        mov      sp, x0
+        bl      main
+
+        /* pass return value to sys exit */
+        mov    x1, x0
+        ldr    x0, =0x20026 /* ADP_Stopped_ApplicationExit */
+        stp    x0, x1, [sp, #-16]!
+        mov    x1, sp
+	mov    x0, SYS_EXIT
+        semihosting_call
+        /* never returns */
+
+        /*
+         * Helper Functions
+         */
+
+        /* Output a single character to serial port */
+        .global __sys_outc
+__sys_outc:
+        stp x0, x1, [sp, #-16]!
+        /* pass address of c on stack */
+        mov x1, sp
+        mov x0, SYS_WRITEC
+        semihosting_call
+        ldp x0, x1, [sp], #16
+        ret
+
+	.data
+	.align	12
+ttb:
+	.space	4096, 0
+
+        .align  12
+stack:
+        .space 65536, 0
+stack_end:
diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
new file mode 100644
index 0000000000..73d75cae64
--- /dev/null
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -0,0 +1,22 @@
+ENTRY(__start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 1gb */
+    . = (1 << 30);
+    .text : {
+        *(.text)
+    }
+    .data : {
+        *(.data)
+    }
+    .rodata : {
+        *(.rodata)
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


