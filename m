Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C17C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E836B206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6Mtf98z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E836B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8CY-0004at-2u
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Ae-0002CL-3c
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:45:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Ac-0002GG-AW
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:44:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ci23so131110pjb.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qsO/9sXqwRSwBfPxHSybMyV+N/D8mtOlkRGqDKN7wNE=;
 b=J6Mtf98zDEByOuycBy49MnF6Nx9ObfUnlI/WGLchNZQPvVJ0flVJq8SQI5L7T3rZrB
 DZjytPrPkz/91b/rr5Ha7a4W5+N2dKOjDPfwOqH2Z8mCgRe5vGG4a5OuC5ilHYEDEYYm
 382SiCt/u3ioWtJzcJGJHlTWb0hQI2hs9Deb3du6bGLmXnBBRc7Oqjrt27HzldbZkg6S
 1ftfKhwWstfrQ4sbk+U7WQB+tabrtdHzZMr1P33M0vBSVUKXDkFhgAGhFZIObcAvyqTK
 qgW+cKDGB72ZmdCqv7zQwT2VHqyEERzzrFqET0cqVGWFGRf6YCj25dVNCJnBAA0BIQsX
 DHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsO/9sXqwRSwBfPxHSybMyV+N/D8mtOlkRGqDKN7wNE=;
 b=isIxB0MlDT8MEXVK09a18rlktk5YvuKAiB/Sc+M9vM01h5a1/8K+A7uecwKduEs0uc
 50dNzfxNJ3f5SlsRuTm1RBV4eZ64bCjoPISrc+2axVvD/JNT3mBjBqIsQRhxSXSKxx7J
 aO82bCqZtD4yrxmsbysUJy7KqkbouLehGftcjnvXhJweUe4IhY//M5nr5jzXA8lS6IY6
 VmaElfP7iLfH1Z9LTPkWFoQ9i+7uXJSRAFIqFhNB6Y5uUDEDwHK/a0FrUvlkk6noHe4P
 Bqs1FlTvV4OQqFsJ9Ly1XypZwY+Lk9tg+TGIDnlVk9H7sKE3NWAqTLvozgBQ8VDtrekG
 eXTA==
X-Gm-Message-State: AOAM530ppg6wuwYhOwGcCxWEQMI8OjYoXqBPCUyG2oQ9gusLpJc+Wubd
 bJN9BpsvEDmHbLFiwWhgY3xKoGDulVk=
X-Google-Smtp-Source: ABdhPJxC47ADwnfPthg73793fbO6o9IK5XsU42LT2Bhs0lxAldo8Yj03a8OKeRmvSQJiI4yFau61xw==
X-Received: by 2002:a17:902:bd09:: with SMTP id
 p9mr1085330pls.214.1589917496205; 
 Tue, 19 May 2020 12:44:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm285744pjj.33.2020.05.19.12.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 12:44:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Build vdso for x64.
Date: Tue, 19 May 2020 12:44:51 -0700
Message-Id: <20200519194452.9009-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519194452.9009-1-richard.henderson@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

... Well, sortof.  The Makefile bits are broken.
Patch to load the vdso into the running program to follow.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 Makefile                  |   4 +-
 pc-bios/Makefile          |   5 ++
 pc-bios/vdso-linux-x64.S  | 115 ++++++++++++++++++++++++++++++++++++++
 pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++++++++++++++
 pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
 5 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/vdso-linux-x64.S
 create mode 100644 pc-bios/vdso-linux-x64.ld
 create mode 100755 pc-bios/vdso-linux-x64.so

diff --git a/Makefile b/Makefile
index 40e4f7677b..73e380ac6a 100644
--- a/Makefile
+++ b/Makefile
@@ -848,8 +848,8 @@ qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
 opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
-
+opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin \
+vdso-linux-x64.so
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
 60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
diff --git a/pc-bios/Makefile b/pc-bios/Makefile
index 315288df84..70e2485e2e 100644
--- a/pc-bios/Makefile
+++ b/pc-bios/Makefile
@@ -15,5 +15,10 @@ all: $(TARGETS)
 %.dtb: %.dts
 	dtc -I dts -O dtb -o $@ $<
 
+vdso-linux-x64.so: vdso-linux-x64.o vdso-linux-x64.ld
+	$(CC) -nostdlib -shared -Wl,-T,vdso-linux-x64.ld \
+	  -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=both \
+	  vdso-linux-x64.o -o $@
+
 clean:
 	rm -f $(TARGETS) *.o *~
diff --git a/pc-bios/vdso-linux-x64.S b/pc-bios/vdso-linux-x64.S
new file mode 100644
index 0000000000..090d82c26a
--- /dev/null
+++ b/pc-bios/vdso-linux-x64.S
@@ -0,0 +1,115 @@
+/*
+ *  x86-64 linux replacement vdso.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <asm/unistd.h>
+
+	.globl	__vdso_clock_gettime
+	.type	__vdso_clock_gettime, @function
+	.balign	16
+	.cfi_startproc
+__vdso_clock_gettime:
+	mov	$__NR_clock_gettime, %eax
+	syscall
+	ret
+	.cfi_endproc
+	.size	__vdso_clock_gettime, . - __vdso_clock_gettime
+
+clock_gettime = __vdso_clock_gettime
+	.weak	clock_gettime
+
+
+	.globl	__vdso_gettimeofday
+	.type	__vdso_gettimeofday, @function
+	.balign	16
+	.cfi_startproc
+__vdso_gettimeofday:
+	mov	$__NR_gettimeofday, %eax
+	syscall
+	ret
+	.cfi_endproc
+	.size	__vdso_gettimeofday, . - __vdso_gettimeofday
+
+gettimeofday = __vdso_gettimeofday
+	.weak	gettimeofday
+
+
+	.globl	__vdso_time
+	.type	__vdso_time, @function
+	.balign	16
+	.cfi_startproc
+__vdso_time:
+	mov	$__NR_time, %eax
+	syscall
+	ret
+	.cfi_endproc
+	.size	__vdso_time, . - __vdso_time
+
+time = __vdso_time
+	.weak	time
+
+
+	.globl	__vdso_getcpu
+	.type	__vdso_getcpu, @function
+	.balign	16
+	.cfi_startproc
+__vdso_getcpu:
+	/* ??? There is no syscall number for this allocated on x64.
+	   We can handle this several ways:
+
+	   (1) Invent a syscall number for use within qemu.
+               It should be easy enough to pick a number that
+               is well out of the way of the kernel numbers.
+
+           (2) Force the emulated cpu to support the rdtscp insn,
+	       and initialize the TSC_AUX value the appropriate value.
+
+	   (3) Pretend that we're always running on cpu 0.
+
+	   This last is the one that's implemented here, with the
+	   tiny bit of extra code to support rdtscp in place.  */
+
+	xor	%ecx, %ecx		/* rdtscp w/ tsc_aux = 0 */
+
+	/* if (cpu != NULL) *cpu = (ecx & 0xfff); */
+	test	%rdi, %rdi
+	jz	1f
+	mov	%ecx, %eax
+	and	$0xfff, %eax
+	mov	%eax, (%rdi)
+
+	/* if (node != NULL) *node = (ecx >> 12); */
+1:	test	%rsi, %rsi
+	jz	2f
+	shr	$12, %ecx
+	mov	%ecx, (%rsi)
+
+2:	xor	%eax, %eax
+	ret
+	.cfi_endproc
+	.size	__vdso_getcpu, . - __vdso_getcpu
+
+getcpu = __vdso_getcpu
+	.weak	getcpu
+
+/* ??? Perhaps add elf notes.  E.g.
+
+   #include <linux/elfnote.h>
+   ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+   ELFNOTE_END
+
+   but what version number would we set for QEMU?  */
diff --git a/pc-bios/vdso-linux-x64.ld b/pc-bios/vdso-linux-x64.ld
new file mode 100644
index 0000000000..2ef21fbcab
--- /dev/null
+++ b/pc-bios/vdso-linux-x64.ld
@@ -0,0 +1,81 @@
+/*
+ * Linker script for linux x64 replacement vdso.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+VERSION {
+	LINUX_2.6 {
+	global:
+		clock_gettime;
+		__vdso_clock_gettime;
+		gettimeofday;
+		__vdso_gettimeofday;
+		getcpu;
+		__vdso_getcpu;
+		time;
+		__vdso_time;
+	local: *;
+	};
+}
+
+PHDRS {
+	phdr		PT_PHDR		FLAGS(4) PHDRS;
+	data		PT_LOAD		FLAGS(6) FILEHDR PHDRS;
+	text		PT_LOAD		FLAGS(5);
+	dynamic		PT_DYNAMIC	FLAGS(4);
+	note		PT_NOTE		FLAGS(4);
+	/* ??? Various versions of ld don't know PT_GNU_EH_FRAME. */
+	eh_frame_hdr	0x6474e550;
+}
+
+SECTIONS {
+	/* ??? We can't really prelink to any address without knowing
+	   something about the virtual memory space of the host, since
+	   that leaks over into the available memory space of the guest.  */
+	. = SIZEOF_HEADERS;
+
+	/* The following, including the FILEHDRS and PHDRS, are modified
+	   when we relocate the binary.  We want them to be initially
+	   writable for the relocation; we'll force them read-only after.  */
+	.dynamic	: { *(.dynamic) }	:data :dynamic
+	.dynsym		: { *(.dynsym) }	:data
+	.data		: {
+		/* There ought not be any real read-write data.
+		   But since we manipulated the segment layout,
+		   we have to put these sections somewhere.  */
+		*(.data*)
+		*(.sdata*)
+		*(.got.plt) *(.got)
+		*(.gnu.linkonce.d.*)
+		*(.bss*)
+		*(.dynbss*)
+		*(.gnu.linkonce.b.*)
+	}
+
+	. += 4096;
+	.hash		: { *(.hash) }		:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+	.note		: { *(.note*) }		:text :note
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+	.eh_frame	: { *(.eh_frame) }	:text
+	.rodata		: { *(.rodata) }
+
+	. = ALIGN(0x100);
+	.text		: { *(.text*) }		:text	=0x90909090
+}
diff --git a/pc-bios/vdso-linux-x64.so b/pc-bios/vdso-linux-x64.so
new file mode 100755
index 0000000000000000000000000000000000000000..07cba76a4ab52b9bc5be22e2a6e2fe8295691717
GIT binary patch
literal 7500
zcmeHMO=w(I6h4zlnxv*p>K|&V4$_uV>LZaN1%F7|CQa!iDVksv@pYP+W<rx0O<u}G
zBvLVIR3wWof(t?1xGLEQS!tyxR$O%H#+^SXC<>aDI-c*n^G)a7Ok9bAyqnzl?)}a=
z_uYHmeKU{mzBrH_Y)YksB`uFi*t<Pq`pj_M`snt_VcDjiozkHw(j0QIz!nwaDI1#D
zW_Hks-KwmnBMVU^6B3AP(Yks|*xiI5G(|j-aiB5J6`PNX(W2GC?3^cJP_N&r9}RF%
zL<<qVD5t&&@@W5RaV{PVy+nwN+iCnUL-JhjZ+}+HFnww3M=nq@b{*z)#qzK{GRrfD
zHyPex_<J=PZ`I=eu)c-M&(>cwyM_HHke2pZJ~;v0r~5=#W&4x&4c(iS?{fIN&EMq@
zn19Cc?=^py$2P(E?sdnM-zC3P6=LN<?ZLmt#>YHR9?^>VyL@O&K9US18AvjaWFW~v
zl7S=xNd}S(BpFCDkYpgqK$3y~bp{}RL92nj0}ZHEYki^40euHr4Rs&HwQB`}hfV?8
z#X~)*!Gc_*FX9)+zj{tS?_PW5<kGi0-n!?dOO<zCxbwZErPmL9x^Lgw*}}}}SF7Ut
z7xHsue`2~kao(RS1i{oyfuwcI=kmD)a*loC*?F0sD$Q5!$1tA$_e%D}$oOgh0S}r8
zX6gQcP1)bOAN{lg($j9O)Woo+Cbe(OUrtk&g6@KXT!F*-kB^MY+sl2U-gjTDoNwCu
z<K<7@_@VN|hxt@@`l0>i+o6MD+}(;#D;`t~6dzW6Q<3ARo_|bIm9A8GM{66jL-3f>
z6|KA%+6?(ait7#dta57&_`GuOYo#Wn&3~<|f3275Y`NNb@5|ve*UvcpYw>>XwV|bI
z(7ycH-fE}Fa_i92M$q!{_Z`bSd#_v-Z*E~G$emRTW+N=Jm0u|3W~L^@(}sG9H(8qZ
zin+OB#00YubD=OhH&rghI(}ZfQaLDyS19`DW^*$IznE8l_QVSc72LFcpmggPcwVr7
zP`1*Esk`#tcSY`@4vgoP`YCl-Vw>(A6vV@a@zi5`>TKHFq;L0u)WY!@-yG4Qp1h%&
zE$!5ai9_Z`JL8QOJd^zH0GF``fJhyg{<a);_4GibT6cZw#zd1pYxCzkh$l538Z`UV
zrHO~_N^br*fv2>A?@GqIy8RwH8ZvLB&u9Z{V*FORJ^kJIk`te~E%GE*7-;C`A9h@y
z-{;hqiNj7j_Z{h7+Th+L2OPG<FV>UVcJE*P+Us3c?uvT*EipK!K;`_ofBD-}AB*-n
zzAUv|ilFxCUcY8&&`9fS`8?K}(|Wh~e8u^6?fHrG&9(EBINws+?{R*caR0{nR^h&k
z^KG^BqBy_#`~vp0Y!~j2xc`mw1@g!jejD99;5{H!+qLu-$!N3D`G}`{qjL&8UyaU9
z@Y~hs`~uG##&^$CCXIK`O{R@^&pYO9eC~7ZtJjQo#}WV7lOz4ZCyt7LJUe=%KkJVU
r4n96G=8yFs$qx7ue_y%r#$m5Bjow_8!`n*C6u!-v;qTsrLchNN5$+*|

literal 0
HcmV?d00001

-- 
2.20.1


