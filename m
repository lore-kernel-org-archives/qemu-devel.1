Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC5C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59552133D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BY8nIR4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59552133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBZs-0002es-39
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Fd-BK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004xS-6K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvJ-0004gb-WB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id r18so1351444wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GG8+B2YKZAzbtPtKRtN7JHzNyOJ/PV6z6R/XdCaBQE8=;
 b=BY8nIR4+QZBm0/gUj4RmkMPIBhyFVidI/CbukYfiBG8OF8bJu7oL9lqII8cG4jz0ZN
 pd7zKMh8ib10Ws6kO4504O+Fk20BzOGma8JRe8sNvRD6afoYMtkQeZkQJEj6omIBVwKp
 sq9jIezfX9jDnN4aJnZL83Mhb8pDQIoQeXhC5tFfbYkMBEyegqjMX4/dns/Jr4mwOD+0
 TzdsB2rpgr4WrgzFIurusYtM02FlnkU00lZiUmJkQXojG4HEw3EZJLZOkrSR0dvOcJEx
 jFplvSGzO/k8db+Yf4Ul6HZ6YEgjimrpv1HsjLu6c5SonVZ4I6Z7qlMqAfOea+QkjMHu
 auqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GG8+B2YKZAzbtPtKRtN7JHzNyOJ/PV6z6R/XdCaBQE8=;
 b=iYvNLGFzp6+R3/eVGlxZC2XoWChDX7Ved4kYspeLq7aWW9KQTSNi4zGJ1e8mouMJ0F
 Gve9/ildtt+xUWfOrbrUY74RjYoGx2S73O+zgvr3NxorOY3/vUzFHIthZC6FnR0oM0mG
 PDSTYeiP5f+q75rn/L10ohQGsV/9rIKxODMarZcJtd62fSa8Aig9z+kBIknhgkliBbJ4
 cQkP0lntMMJC/z23r6X2rYraVH2p3BMT1PEY9JaD7jJvC41dkLuv4a2ajkVDfOazX8yL
 D27pj0W9J0/btRHFq2RuvzQ6r7DC2S3sgNSWZ8NyCgxZgZYm+b1Pz0s6NlJ7dRTqB8iM
 5iQA==
X-Gm-Message-State: APjAAAXNhp4zKOZhoHc501LDUNow9mFNGw6JFHetN/N1AU5sHBrZ9OXw
 OUE6FlEdVsy3XJUc4qzDGKVk/A==
X-Google-Smtp-Source: APXvYqxgXmga6zHPsQMYGUTNjOai2Z+t4G2Ji/ILvt7jEzotARh4sFkSh92Y626t/ktn1jiS+TfK0Q==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr32615252wrs.105.1559898750930; 
 Fri, 07 Jun 2019 02:12:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 74sm1180468wma.7.2019.06.07.02.12.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:29 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E0C21FFB5;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:29 +0100
Message-Id: <20190607090552.12434-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 30/52] tests/tcg/x86_64: add a PVH crt.o for
 x86_64 system tests
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of doing the full real to 64 bit dance we are attempting to
leverage Xen's PVH boot spec to go from 32 bit to 64 bit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index e1d880f9b5..0a4364868c 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -14,6 +14,7 @@ CRT_OBJS=boot.o
 
 ifeq ($(TARGET_X86_64), y)
 CRT_PATH=$(X64_SYSTEM_SRC)
+CFLAGS=-march=x86-64
 LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 else
diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
new file mode 100644
index 0000000000..205cfbd398
--- /dev/null
+++ b/tests/tcg/x86_64/system/boot.S
@@ -0,0 +1,277 @@
+/*
+ * x86_64 boot and support code
+ *
+ * Copyright 2019 Linaro
+ *
+ * This work is licensed under the terms of the GNU GPL, version 3 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * Unlike the i386 version we instead use Xen's PVHVM booting header
+ * which should drop us automatically into 32 bit mode ready to go. I've
+ * nabbed bits of the Linux kernel setup to achieve this.
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+        .section .head
+
+#define ELFNOTE_START(name, type, flags)	\
+.pushsection .note.name, flags,@note	;	\
+  .balign 4				;	\
+  .long 2f - 1f		/* namesz */	;	\
+  .long 4484f - 3f	/* descsz */	;	\
+  .long type				;	\
+1:.asciz #name				;	\
+2:.balign 4				;	\
+3:
+
+#define ELFNOTE_END				\
+4484:.balign 4				;	\
+.popsection				;
+
+#define ELFNOTE(name, type, desc)		\
+	ELFNOTE_START(name, type, "")		\
+		desc			;	\
+	ELFNOTE_END
+
+#define XEN_ELFNOTE_ENTRY          1
+#define XEN_ELFNOTE_HYPERCALL_PAGE 2
+#define XEN_ELFNOTE_VIRT_BASE      3
+#define XEN_ELFNOTE_PADDR_OFFSET   4
+#define XEN_ELFNOTE_PHYS32_ENTRY  18
+
+#define __ASM_FORM(x)	x
+#define __ASM_FORM_RAW(x)     x
+#define __ASM_FORM_COMMA(x) x,
+#define __ASM_SEL(a,b)           __ASM_FORM(b)
+#define __ASM_SEL_RAW(a,b)      __ASM_FORM_RAW(b)
+#define _ASM_PTR	__ASM_SEL(.long, .quad)
+
+	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
+	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
+	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR _start)    /* entry == virtbase */
+	ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)
+
+       /*
+	* Entry point for PVH guests.
+	*
+	* Xen ABI specifies the following register state when we come here:
+	*
+	* - `ebx`: contains the physical memory address where the loader has placed
+	*          the boot start info structure.
+	* - `cr0`: bit 0 (PE) must be set. All the other writeable bits are cleared.
+	* - `cr4`: all bits are cleared.
+	* - `cs `: must be a 32-bit read/execute code segment with a base of ‘0’
+	*          and a limit of ‘0xFFFFFFFF’. The selector value is unspecified.
+	* - `ds`, `es`: must be a 32-bit read/write data segment with a base of
+	*               ‘0’ and a limit of ‘0xFFFFFFFF’. The selector values are all
+	*               unspecified.
+	* - `tr`: must be a 32-bit TSS (active) with a base of '0' and a limit
+	*         of '0x67'.
+	* - `eflags`: bit 17 (VM) must be cleared. Bit 9 (IF) must be cleared.
+	*             Bit 8 (TF) must be cleared. Other bits are all unspecified.
+	*
+	* All other processor registers and flag bits are unspecified. The OS is in
+	* charge of setting up it's own stack, GDT and IDT.
+	*/
+        .code32
+        .section .text
+
+.global _start
+_start:
+	cld
+        lgdt gdtr
+
+        ljmp $0x8,$.Lloadcs
+.Lloadcs:
+        mov $0x10,%eax
+        mov %eax,%ds
+        mov %eax,%es
+        mov %eax,%fs
+        mov %eax,%gs
+        mov %eax,%ss
+
+	/* Enable PAE mode (bit 5). */
+	mov %cr4, %eax
+	btsl $5, %eax
+	mov %eax, %cr4
+
+#define MSR_EFER		0xc0000080 /* extended feature register */
+
+	/* Enable Long mode. */
+	mov $MSR_EFER, %ecx
+	rdmsr
+	btsl $8, %eax
+	wrmsr
+
+	/* Enable paging */
+	mov $.Lpml4, %ecx
+	mov %ecx, %cr3
+
+	mov %cr0, %eax
+	btsl $31, %eax
+	mov %eax, %cr0
+
+	/* Jump to 64-bit mode. */
+        lgdt gdtr64
+        ljmp $0x8,$.Lenter64
+
+        .code64
+        .section .text
+.Lenter64:
+
+
+	// Setup stack ASAP
+	movq $stack_end,%rsp
+
+        /* don't worry about stack frame, assume everthing is garbage when we return */
+	call main
+
+        /* output any non-zero result in eax to isa-debug-exit device */
+        test %al, %al
+        jz 1f
+        out %ax, $0xf4
+
+1:      /* QEMU ACPI poweroff */
+	mov $0x604,%edx
+	mov $0x2000,%eax
+	out %ax,%dx
+	hlt
+	jmp 1b
+
+        /*
+         * Helper Functions
+         *
+         * x86_64 calling convention is rdi, rsi, rdx, rcx, r8, r9
+         */
+
+        /* Output a single character to serial port */
+        .global __sys_outc
+__sys_outc:
+        pushq %rax
+        mov %rax, %rdx
+	out %al,$0xE9
+        popq %rax
+        ret
+
+	/* Interrupt Descriptor Table */
+
+        .section .data
+        .align 16
+
+idt_00: .int 0, 0
+idt_01: .int 0, 0
+idt_02: .int 0, 0
+idt_03: .int 0, 0
+idt_04: .int 0, 0
+idt_05: .int 0, 0
+idt_06: .int 0, 0 /* intr_6_opcode, Invalid Opcode */
+idt_07: .int 0, 0
+idt_08: .int 0, 0
+idt_09: .int 0, 0
+idt_0A: .int 0, 0
+idt_0B: .int 0, 0
+idt_0C: .int 0, 0
+idt_0D: .int 0, 0
+idt_0E: .int 0, 0
+idt_0F: .int 0, 0
+idt_10: .int 0, 0
+idt_11: .int 0, 0
+idt_12: .int 0, 0
+idt_13: .int 0, 0
+idt_14: .int 0, 0
+idt_15: .int 0, 0
+idt_16: .int 0, 0
+idt_17: .int 0, 0
+idt_18: .int 0, 0
+idt_19: .int 0, 0
+idt_1A: .int 0, 0
+idt_1B: .int 0, 0
+idt_1C: .int 0, 0
+idt_1D: .int 0, 0
+idt_1E: .int 0, 0
+idt_1F: .int 0, 0
+
+
+	/*
+	 * Global Descriptor Table (GDT)
+	 *
+	 * This describes various memory areas (segments) through
+	 * segment descriptors. In 32 bit mode each segment each
+	 * segement is associated with segment registers which are
+	 * implicitly (or explicitly) referenced depending on the
+	 * instruction. However in 64 bit mode selectors are flat and
+	 * segmented addressing isn't used.
+	 */
+gdt:
+        .short 0
+gdtr:
+        .short gdt_en - gdt - 1
+        .int gdt
+
+        // Code cs:
+        .short 0xFFFF
+        .short 0
+        .byte 0
+        .byte 0x9b
+        .byte 0xCF
+        .byte 0
+
+        // Data  ds:, ss:, es:, fs:, and gs:
+        .short 0xFFFF
+        .short 0
+        .byte 0
+        .byte 0x93
+        .byte 0xCF
+        .byte 0
+gdt_en:
+
+gdt64:
+        .short 0
+gdtr64:
+        .short gdt64_en - gdt64 - 1
+        .int gdt64
+
+        // Code
+        .short 0xFFFF
+        .short 0
+        .byte 0
+        .byte 0x9b
+        .byte 0xAF
+        .byte 0
+
+        // Data
+        .short 0xFFFF
+        .short 0
+        .byte 0
+        .byte 0x93
+        .byte 0xCF
+        .byte 0
+gdt64_en:
+
+	.section .bss
+        .align 16
+
+stack: .space 65536
+stack_end:
+
+	.section .data
+
+.align 4096
+.Lpd:
+i = 0
+        .rept 512 * 4
+        .quad 0x1e7 | (i << 21)
+        i = i + 1
+        .endr
+
+.align 4096
+.Lpdp:
+        .quad .Lpd + 7 + 0 * 4096 /* 0-1 GB */
+        .quad .Lpd + 7 + 1 * 4096 /* 1-2 GB */
+        .quad .Lpd + 7 + 2 * 4096 /* 2-3 GB */
+        .quad .Lpd + 7 + 3 * 4096 /* 3-4 GB */
+
+.align 4096
+.Lpml4:
+        .quad .Lpdp + 7 /* 0-512 GB */
diff --git a/tests/tcg/x86_64/system/kernel.ld b/tests/tcg/x86_64/system/kernel.ld
new file mode 100644
index 0000000000..49c12b04ae
--- /dev/null
+++ b/tests/tcg/x86_64/system/kernel.ld
@@ -0,0 +1,33 @@
+PHDRS {
+	text PT_LOAD FLAGS(5);          /* R_E */
+	note PT_NOTE FLAGS(0);          /* ___ */
+}
+
+SECTIONS {
+	. = 0x100000;
+
+	.text : {
+		__load_st = .;
+		*(.head)
+		*(.text)
+	} :text
+
+	.rodata : {
+		*(.rodata)
+	} :text
+
+        /* Keep build ID and PVH notes in same section */
+        .notes :  {
+               *(.note.*)
+        } :note
+
+        .data : {
+		*(.data)
+		__load_en = .;
+	} :text
+
+	.bss : {
+		*(.bss)
+		__bss_en = .;
+	}
+}
-- 
2.20.1


