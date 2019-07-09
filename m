Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721BFC73C5C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401D520656
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyntcApD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401D520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkxs1-0006Nc-Ev
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 17:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48075)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hkxnX-0002vh-3F
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hkxnT-0006tI-75
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:37:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hkxnR-0006pB-1W
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:37:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id p74so229463wme.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RXy8Z57iz19jbcENY65M0/IBu7nS3oHPtX9g9yK/Kfs=;
 b=QyntcApDF7dsDjQWc+ZUCWBTYMBEKCQFOSQbkCwACwVjrW4BoUwgmg6augXadB4WE+
 2x2HYej8ThmKiFqUfiuitz2rRGy9Jxq0FVbEDs76uvsbxnIPadyQaFznK1qFpjhtZ1Sz
 Ug90bhI0J5iIj3fPKCNvQ+VhwKSS3Og8pingDrC+1V568YCwF1gl2ZZw40UFPvzuKy6N
 IgnptT5XlgrUhmuZs2enrmheRKcuGAXQfFUjHWLfg5JiWoVcaFwjVUZoydmM2qFPW02e
 HfK0s7PoBHk0Ugi0viPCTvv9voRAhT+xkjo+3Y9G51jwugwKa+OSm2PUIlxgLMXi3T27
 9SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RXy8Z57iz19jbcENY65M0/IBu7nS3oHPtX9g9yK/Kfs=;
 b=BjrmQnDdF6Y9EepCvCc9KNFqAWT/v13KPZiyTQQ1KMWhOFwYGf3P2Aqd3bcGNswww4
 sJ/gWhWGnw+3Z1OFPcdXiqnYNiTm5GUZ5WBjalW+YOpV7OexqGxpEB7o5EpgqUnCv5Ty
 gflFMEV6desx5gNAqZlx3HVdD9x/K+p4V1OYKKYZ/gWURTHcEtNQOhMr0danVBXEyv1v
 Xud+XTeyQBOlMqqoyQiuHkl4uIaMIdr/Lr2nOs/V7p7EF+HS0x4msaGgym1mk+dc1iT9
 2GYc0YN+0x0JVlDPqP5qSPvbaYi+2Lh47t4uthWrVNLaFcoBrPp2lAeN6OmjqCP4iwO+
 SbQw==
X-Gm-Message-State: APjAAAUYo/iMY/zfe19JIDIHOv0RduU2Y5G8SnKFm3eeeeVf6i6z7xEi
 NZdU6STWJVmwVN1KBpLiuFNjklG7ICk=
X-Google-Smtp-Source: APXvYqz4KCBA9pDvYfc/k3+OrqjFQ1S/QunDxxdCHTzNIPgaCIhA6bjkfUVUfr31AmsiTofxOJhx9g==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr1619541wmg.92.1562708227395;
 Tue, 09 Jul 2019 14:37:07 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-209.red.bezeqint.net. [79.178.2.209])
 by smtp.gmail.com with ESMTPSA id c1sm141207wrh.1.2019.07.09.14.37.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 09 Jul 2019 14:37:06 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 00:36:51 +0300
Message-Id: <20190709213651.77315-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190709213651.77315-1-mrolnik@gmail.com>
References: <20190709213651.77315-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v25 7/7] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: imammedo@redhat.com, Sarah Harris <S.E.Harris@kent.ac.uk>,
 richard.henderson@linaro.org, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sarah Harris <S.E.Harris@kent.ac.uk>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  6 ++++++
 arch_init.c                     |  2 ++
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 hw/avr/sample.c                 |  2 +-
 include/disas/dis-asm.h         |  6 ++++++
 include/sysemu/arch_init.h      |  1 +
 qapi/common.json                |  3 ++-
 target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
 target/avr/cpu.c                | 13 ++++---------
 target/avr/cpu.h                |  3 ---
 tests/machine-none-test.c       |  1 +
 12 files changed, 68 insertions(+), 14 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index cc9636b43a..934ad5739b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,12 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target/avr/
+F: hw/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index 74b0708634..413ad7acfd 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,6 +85,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/configure b/configure
index 4983c8b533..ab8ebba100 100755
--- a/configure
+++ b/configure
@@ -7503,6 +7503,10 @@ case "$target_name" in
     target_compiler=$cross_cc_aarch64
     eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
+  avr)
+	gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
     target_compiler=$cross_cc_cris
   ;;
@@ -7780,6 +7784,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..d1e1c28118
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_AVR_SAMPLE=y
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
index e4cb548a33..de97fe4ae7 100644
--- a/hw/avr/sample.c
+++ b/hw/avr/sample.c
@@ -197,7 +197,7 @@ static void sample_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = 1;
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
-    mc->default_cpu_type = AVR_CPU_TYPE_NAME("avr6"); /* ATmega2560. */
+    mc->default_cpu_type = "avr6-avr-cpu"; /* ATmega2560. */
     mc->is_default = 1;
 }
 
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..8bedce17ac 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,12 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1          1
+#define bfd_mach_avr2          2
+#define bfd_mach_avr3          3
+#define bfd_mach_avr4          4
+#define bfd_mach_avr5          5
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..aff57bfe61 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..6866c3e81d 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,11 +183,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: added in 4.1
 #
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..1034d87525
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,33 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2016 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+decode-y = $(SRC_PATH)/target/avr/insn.decode
+
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index ac85508156..f4e3b1956f 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -136,11 +136,6 @@ static void avr_cpu_initfn(Object *obj)
 #endif
 }
 
-static char *avr_cpu_type_name(const char *cpu_model)
-{
-    return g_strdup_printf(AVR_CPU_TYPE_NAME("%s"), cpu_model);
-}
-
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -548,10 +543,10 @@ void avr_cpu_list(void)
 }
 
 #define DEFINE_AVR_CPU_TYPE(model, initfn) \
-    {                                      \
-        .parent = TYPE_AVR_CPU,            \
-        .instance_init = initfn,           \
-        .name = AVR_CPU_TYPE_NAME(model),  \
+    { \
+        .parent = TYPE_AVR_CPU, \
+        .instance_init = initfn, \
+        .name = model "-avr-cpu", \
     }
 
 static const TypeInfo avr_cpu_type_info[] = {
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 3f9a803193..bda810c23e 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -29,9 +29,6 @@
 #define TCG_GUEST_DEFAULT_MO 0
 
 #define TYPE_AVR_CPU "avr-cpu"
-
-#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
-#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_AVR_CPU
 
 /*
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.17.2 (Apple Git-113)


