Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500ACC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C654020759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2nmI33V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjFk-0000Gi-JK
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj0A-0003Ul-Hw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj02-0006Ub-Vz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so813189wme.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eZilmCoTEUwUIRJHegLI6wDNSXk+HaCJru/l+G4hcvQ=;
 b=I2nmI33VYZJUzNi3m5HCCtbYIqg6Nv2Jw9/bpcdnlQbNpscVU2UB8gYQ+l1lfiGlxo
 HMryDwGryJygk/a8KxBpQG6/y6T7R1hWX1KAsIomvn0fs1GvQnKvVfF0WTU6KffUddSb
 aQVsa/7qHSQNBSK2xJepZC5C8NwbXX+7g+szYSzOerSksi+rKWqEuMW+1mx0gjX4b+d7
 3gPwkLS4W45sAZGVEowENymSs8f8gQ6wLY0edmqh1Okk6JyXzbzK1V8/l6DIVDikv0jo
 Pvr2923XO7kLhqKP6t7+JyDqXPxBEzlnf7shum5B5BJgomXFjJkV+z+x/BulI6K8ijXP
 Afhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eZilmCoTEUwUIRJHegLI6wDNSXk+HaCJru/l+G4hcvQ=;
 b=f8KMOcwiq4/kMViAv8X74KRVVL2YzJWMUsgKjsOj/Y2Hj7mwRXcLYApYgstxyn9gkb
 UMST2Z1V2odsO34/HfhZ2T7fyPu7c7NM6fH63uBzK+Mt91pXpFehFuGj3PuHdrK2zwFe
 xC1Vq5uQGHR6SmYau22HYlbf7I8zd6pqL8uXSRePI3dvVHL2PMs/4vCwbXeGX3xMC/eG
 zlHYivhWytemaTQNjE0qdRQQbSy3uVDfpECJbe7VwQs8Fk2ZWq6TERy68q11RiOgkbY5
 p2AhTpYi0dxDBqD6N6To8kAid13uVlx8ysajKJ8lmheW5EL7CbHMQh+SjCnvGB+4/L11
 t5iQ==
X-Gm-Message-State: AOAM532v7IDWMkehrt1PtWuphvEZG21hBNTlwakeWSX6HcwBILAE5pSa
 Kxil5X8IAAfNFcI7ZLk3iBaSF8HfE9pHzw==
X-Google-Smtp-Source: ABdhPJwziJuRTyoOoLVNiY8/XlF9OqVsfu6UO8lSSPi+p2Cqt2TcUy/S+UHtCnNZRDRORD7mIqwEeg==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4898998wmd.95.1601498811663; 
 Wed, 30 Sep 2020 13:46:51 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:51 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 13/14] arc: Add support for ARCv2
Date: Wed, 30 Sep 2020 21:46:03 +0100
Message-Id: <20200930204604.20663-14-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shahab Vahedi <shahab@synopsys.com>

Add remaining bits of the Synopsys ARCv2 (EM/HS) support into QEMU,
configure bits, arch_init and configuration files for softmmu (hardware
emulation).

Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
---
 configure                       |  5 +++++
 default-configs/arc-softmmu.mak |  5 +++++
 disas.c                         |  2 ++
 disas/meson.build               |  1 +
 hw/meson.build                  |  1 +
 include/disas/dis-asm.h         | 10 +++++++++-
 include/elf.h                   |  3 +++
 include/exec/poison.h           |  2 ++
 include/sysemu/arch_init.h      |  1 +
 meson.build                     |  3 ++-
 softmmu/arch_init.c             |  2 ++
 target/meson.build              |  1 +
 12 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/arc-softmmu.mak

diff --git a/configure b/configure
index ecc8e90e8b..65862d8371 100755
--- a/configure
+++ b/configure
@@ -7570,6 +7570,9 @@ case "$target_name" in
     mttcg="yes"
     TARGET_SYSTBL_ABI=common
   ;;
+  arc)
+    gdb_xml_files="arc-core-v2.xml arc-aux-minimal.xml arc-aux-other.xml"
+  ;;
   arm|armeb)
     TARGET_ARCH=arm
     TARGET_SYSTBL_ABI=common,oabi
@@ -7852,8 +7855,10 @@ DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios"
 DIRS="$DIRS contrib/plugins/"
+#DIRS="$DIRS tests/tcg/arc"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile"
+#LINKS="$LINKS tests/tcg/arc/Makefile.target"
 LINKS="$LINKS tests/tcg/Makefile.target"
 LINKS="$LINKS pc-bios/optionrom/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
diff --git a/default-configs/arc-softmmu.mak b/default-configs/arc-softmmu.mak
new file mode 100644
index 0000000000..4300a90c93
--- /dev/null
+++ b/default-configs/arc-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for arc-softmmu
+
+CONFIG_VIRTIO_MMIO=y
+CONFIG_SERIAL=y
+CONFIG_OPENCORES_ETH=y
diff --git a/disas.c b/disas.c
index c1397d3933..41aabbca63 100644
--- a/disas.c
+++ b/disas.c
@@ -671,6 +671,8 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
     print_insn = print_insn_s390;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
+#elif defined(__arc__)
+    print_insn = print_insn_arc;
 #endif
 
     if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, note)) {
diff --git a/disas/meson.build b/disas/meson.build
index bde8280c73..47ff300d0f 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -4,6 +4,7 @@ subdir('libvixl')
 common_ss.add(when: 'CONFIG_ALPHA_DIS', if_true: files('alpha.c'))
 common_ss.add(when: 'CONFIG_ARM_A64_DIS', if_true: files('arm-a64.cc'))
 common_ss.add_all(when: 'CONFIG_ARM_A64_DIS', if_true: libvixl_ss)
+common_ss.add(when: 'CONFIG_ARC_DIS', if_true: files('arc.c'))
 common_ss.add(when: 'CONFIG_ARM_DIS', if_true: files('arm.c'))
 common_ss.add(when: 'CONFIG_CRIS_DIS', if_true: files('cris.c'))
 common_ss.add(when: 'CONFIG_HPPA_DIS', if_true: files('hppa.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 010de7219c..e2b14a9ed8 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -43,6 +43,7 @@ subdir('xen')
 subdir('xenpv')
 
 subdir('alpha')
+subdir('arc')
 subdir('arm')
 subdir('avr')
 subdir('cris')
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 9856bf7921..621164c510 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -206,7 +206,14 @@ enum bfd_architecture
   bfd_arch_v850,       /* NEC V850 */
 #define bfd_mach_v850          0
   bfd_arch_arc,        /* Argonaut RISC Core */
-#define bfd_mach_arc_base 0
+#define bfd_mach_arc_a4        0
+#define bfd_mach_arc_a5        1
+#define bfd_mach_arc_arc600    2
+#define bfd_mach_arc_arc601    4
+#define bfd_mach_arc_arc700    3
+#define bfd_mach_arc_arcv2     5
+#define bfd_mach_arc_arcv2em   6
+#define bfd_mach_arc_arcv2hs   7
   bfd_arch_m32r,       /* Mitsubishi M32R/D */
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
@@ -460,6 +467,7 @@ int print_insn_xtensa           (bfd_vma, disassemble_info*);
 int print_insn_riscv32          (bfd_vma, disassemble_info*);
 int print_insn_riscv64          (bfd_vma, disassemble_info*);
 int print_insn_rx(bfd_vma, disassemble_info *);
+int print_insn_arc              (bfd_vma, disassemble_info*);
 
 #if 0
 /* Fetch the disassembler for a given BFD, if that support is available.  */
diff --git a/include/elf.h b/include/elf.h
index c117a4d1ab..5f6165da37 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -201,6 +201,9 @@ typedef struct mips_elf_abiflags_v0 {
 
 #define EM_TILEGX   191 /* TILE-Gx */
 
+#define EM_ARC_COMPACT  93  /* Synopsys ARCompact */
+#define EM_ARC_COMPACT2 195 /* Synopsys ARCompact V2 */
+
 #define EM_MOXIE           223     /* Moxie processor family */
 #define EM_MOXIE_OLD       0xFEED
 
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 7b9ac361dc..635ccc66a1 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -9,6 +9,7 @@
 #pragma GCC poison TARGET_X86_64
 #pragma GCC poison TARGET_AARCH64
 #pragma GCC poison TARGET_ALPHA
+#pragma GCC poison TARGET_ARC
 #pragma GCC poison TARGET_ARM
 #pragma GCC poison TARGET_CRIS
 #pragma GCC poison TARGET_HPPA
@@ -70,6 +71,7 @@
 
 #pragma GCC poison CONFIG_ALPHA_DIS
 #pragma GCC poison CONFIG_ARM_A64_DIS
+#pragma GCC poison CONFIG_ARC_DIS
 #pragma GCC poison CONFIG_ARM_DIS
 #pragma GCC poison CONFIG_CRIS_DIS
 #pragma GCC poison CONFIG_HPPA_DIS
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 54f069d491..5fbedebcb0 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -26,6 +26,7 @@ enum {
     QEMU_ARCH_RISCV = (1 << 19),
     QEMU_ARCH_RX = (1 << 20),
     QEMU_ARCH_AVR = (1 << 21),
+    QEMU_ARCH_ARC = (1 << 22),
 
     QEMU_ARCH_NONE = (1 << 31),
 };
diff --git a/meson.build b/meson.build
index 5b586afc38..81f42b7429 100644
--- a/meson.build
+++ b/meson.build
@@ -36,7 +36,7 @@ python = import('python').find_installation()
 
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
+  'arc', 'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
 
 cpu = host_machine.cpu_family()
 targetos = host_machine.system()
@@ -482,6 +482,7 @@ config_target_mak = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
+  'arc' : ['CONFIG_ARC_DIS'],
   'arm' : ['CONFIG_ARM_DIS'],
   'avr' : ['CONFIG_AVR_DIS'],
   'cris' : ['CONFIG_CRIS_DIS'],
diff --git a/softmmu/arch_init.c b/softmmu/arch_init.c
index 7fd5c09b2b..27faed5edd 100644
--- a/softmmu/arch_init.c
+++ b/softmmu/arch_init.c
@@ -92,6 +92,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_XTENSA
 #elif defined(TARGET_AVR)
 #define QEMU_ARCH QEMU_ARCH_AVR
+#elif defined(TARGET_ARC)
+#define QEMU_ARCH QEMU_ARCH_ARC
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/target/meson.build b/target/meson.build
index 9f0ae93b75..f4a3a6425c 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -1,4 +1,5 @@
 subdir('alpha')
+subdir('arc')
 subdir('arm')
 subdir('avr')
 subdir('cris')
-- 
2.20.1


