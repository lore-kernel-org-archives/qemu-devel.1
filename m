Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA862C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FCD206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOgmZdCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FCD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYii-0008Jd-Od
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:25:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhJ-0007Nt-45
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhH-0008Se-FP
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYhH-0008Rg-7E
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id t5so2942286wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4Ee9ZhjKvcfYmapaxJyez6mkhczGkE7VcynuJt1VLRI=;
	b=fOgmZdCaTt/IPqEiu4Dw+C37H5TCTU/B7tL5NCxpNDnydA9wAF3bG9c4781r5KH5Xz
	3zehgWqV7CBUWFVyqKmL+JkmeKRfWp7lIwFcWrL/tzcAlXz+0QzFtiVxpaGyoxQa28Og
	Cql1HxFEYxyNOhqv2ev+hBjvkwKbeNRp2JEn2rtXLvrNTkx+lyHK37/Np8AhZSj5PzXq
	N/Mtjs/BlWDSXIJ5biH1plwl04h/kBWqFLqJfjoshGLXMBamZS8Vzvb6lxxm+hLvXvmp
	uv9JWr1JGY3o5LW/blzRNcMChmBF++dYf/S520VnDe+k5MZfnzmO3wacxFm5gD75vpXV
	sxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4Ee9ZhjKvcfYmapaxJyez6mkhczGkE7VcynuJt1VLRI=;
	b=SlYg2UKCcdz2LkBt0sS5puI4bIdndza4Rf0ol4hZSPFqrBMVXKFvs0ZRh7chwfiVpj
	vfGyNhOh43BwRB7h7UajN3Gddo9GjdffZ6sjQ29+4VIKoRkTWpdXhnTQbbvzvrOf3afR
	0t+BCYPW60BHRL1Ltz01fWEb6gJOIb2nFdspn1cd3AvM2B8kMBEkHw/p+zHslEZcZJ22
	J1wVAIHE/Pf5GTlNSepYw7S3gRNfg9XEtarOVihwC1xzLvD62cqaZky3m2cc5X0x7ClQ
	sH+m9SUGKwPWyelrpa3YU2J3WmJSsSA8gsxCjHeOHX7yNCYA6HJ2QZfozXwTQiNs/LfR
	9hrQ==
X-Gm-Message-State: APjAAAVdQo7KjSJaaTC4OPDlWuM/MUMidSJ5QdyM7UEjPfhJY3KcDpMv
	y4tpKfqA9ejGHIJu73eCC12Utg==
X-Google-Smtp-Source: APXvYqwCiQoosq+I1lbFSnbIO+nwA1SohK83+lk6iEFgLU26V+d8mBlxC0rZE7TeHM5k3vCJOrefxw==
X-Received: by 2002:a05:600c:254b:: with SMTP id
	e11mr21303578wma.171.1559751810019; 
	Wed, 05 Jun 2019 09:23:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y2sm33717141wra.58.2019.06.05.09.23.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E906F1FF91;
	Wed,  5 Jun 2019 17:23:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 17:23:26 +0100
Message-Id: <20190605162326.13896-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605162326.13896-1-alex.bennee@linaro.org>
References: <20190605162326.13896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 4/4] tests/tcg/x86_64: add a PVHVM crt.o for
 x86_64 system tests
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of doing the full real to 64 bit dance we are attempting to
leverage Xen's PVHVM boot spec to go from 32 bit to 64 bit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.softmmu-target |   1 +
 tests/tcg/x86_64/system/boot.S         | 277 +++++++++++++++++++++++++
 tests/tcg/x86_64/system/kernel.ld      |  33 +++
 3 files changed, 311 insertions(+)
 create mode 100644 tests/tcg/x86_64/system/boot.S
 create mode 100644 tests/tcg/x86_64/system/kernel.ld

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


