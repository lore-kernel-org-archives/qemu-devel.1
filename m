Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F8AC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A9521849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeXrEt/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A9521849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoOFK-0006RH-99
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50335)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hoOEP-0002pT-G2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hoOEN-0003by-WB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:09 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hoOEN-0003bT-Px
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id n9so6287731wrr.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pn/UGkcEMVIOIirDHHOeqSkhXnkdT3hSdsEfyC7tBbY=;
 b=EeXrEt/B8lVeGMgsZ9d377YPTSFxM3YftHHYlDE5E1Oz20bRig/xwCfrvG0L0wYLiI
 PDMOnAoDjNaypZ4B537LpLLh60yFjevCapWPcHIBYTm4npX5dqVytJ7OEBnNZpmxP8KD
 29f8bNXBQzIg5UP2pXDWDCGeIRG02PQ5ddGXysYZuL9uGKThjqe6yyqjuz/lX8PFpewe
 8HagJ73XwqVh+jojPxWB7lNbzPjcxnZeArHpm25oaS6d94GN6B73uFlRh+ir19OvRE0o
 qBzQq24DAHBFPRyzWrERKKG1IHkjucWJSr8XSxv0KapFv7A58JMsOQxmX/7HcxSnvBcs
 V8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pn/UGkcEMVIOIirDHHOeqSkhXnkdT3hSdsEfyC7tBbY=;
 b=Go2pc5v5BZXls+MJm38wZRoEI0PDYWxCo2k+GBvO07u9qsnJOJr2qM0+aFewwUCEpI
 XzFwPrjxqzqVZaM6UEAeW53dBPu+7kHSYX+2sDNG12eFZ5Ytrh5l/MqpnzBdvstV0N99
 08544Ed+N15m6SxJQ81WOwmOyAgLtDu17AcVkdduqCbrYkAkNA7mSvA5M/dfIAVq/ARE
 vPXNteGaypiGtgxHhVUYPDkqCIvWqT5hqjveBEKz39bUXgHcDiUCIFXPiHkxs8Oc+uVq
 9JvmV1ePidMs4gx2ZpEt0k31zQ48H9jdeNrMjWknsHulSNiqZGThLm7uAXKZMq4S21zd
 P3GQ==
X-Gm-Message-State: APjAAAVe7t5n7vC/QBKviXwoAoixzfjypAQOJTeFS8InNY20Ed2QUQR4
 0Fz7eKr8Sx9+gz2clfJF20CqHX7CTYQ=
X-Google-Smtp-Source: APXvYqxmsLQ3ycNZMP+8SgW5BZSv+6EVaooXwlc0KmRATzp4idhAjoLhRshdAqvmp4rGWOwWJBaLyg==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr54225387wru.195.1563524826403; 
 Fri, 19 Jul 2019 01:27:06 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-177-34-186.red.bezeqint.net. [79.177.34.186])
 by smtp.gmail.com with ESMTPSA id v15sm29720696wrt.25.2019.07.19.01.27.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 19 Jul 2019 01:27:05 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 11:26:46 +0300
Message-Id: <20190719082647.18113-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190719082647.18113-1-mrolnik@gmail.com>
References: <20190719082647.18113-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH v27 7/8] target/avr: Register AVR support with
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
Cc: philmd@redhat.com, richard.henderson@linaro.org,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  6 ++++++
 arch_init.c                     |  2 ++
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 include/disas/dis-asm.h         |  6 ++++++
 include/sysemu/arch_init.h      |  1 +
 qapi/common.json                |  3 ++-
 target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
 tests/machine-none-test.c       |  1 +
 9 files changed, 63 insertions(+), 1 deletion(-)
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
index eb635c3b9a..7a93a774b9 100755
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
index 0000000000..2976affd95
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,33 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2019 Michael Rolnik
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


