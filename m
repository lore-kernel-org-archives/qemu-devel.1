Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB718ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBC020854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgMlSlf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Gc-0003QM-Ea
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iK34N-0006bP-7r
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iK34H-0007aB-Lw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iK34H-0007Zz-CG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so20447732wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SMsddy6aZ63CgsEepIUcm6WyV0wXdBfVOcMIs69xOFY=;
 b=fgMlSlf9RP6uuh5FTf0nJgK6ou6aeP2SvK3kT0FIxAa8ZwNgW7rC4rj2TdYKm1llcH
 XSw4OGUXHkppwSYrfX/dKue7w2urfEolr4FhEKXFT3zVShgugc9Qnbw3jYVpwP1maUmX
 YN88cAyuOm48HlZLmVbhyn4RFhLigTPQ0+SxDoE9PugiugXbqJbgk4KMD01iXb1l77mk
 jyz+CKzUqXFnZqI2I7gKmZau7v2QlCUBxEL1BEGoyIlyFtq9abfxmiwNHxuDAybJO2DI
 9wRZTzOq3gh7u6Qt9wazIErXZdCf+cxejg1W0z6bHNUzQB+t0LM4K/YRpi50K66jT3Bm
 +tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SMsddy6aZ63CgsEepIUcm6WyV0wXdBfVOcMIs69xOFY=;
 b=MKzEdnqBr11cOiOsFm9jh531NpXWBxk7kwNSikwnR0yvdz226aEOWHeF0JyqiAkGho
 OGPM7w1VAFI61XnBATY6SZQCdFg6Ps/UFu5Yuij/ALD9TceRkvoB4keTC5Pu4xCK4Jv6
 a1CLj11nd81URxcVygtmEoV+2IJn9sa1Ap4i4qIAa7/e400gbIZkV8Ii7Me7LjjXMLMl
 AGxVD63VtUg5glnqGtAByWQAEsmGfOFRxFITXSXVtTn/Hx+DsSU8KjqJ1+o4T8rBaaFC
 hVGPOkQMwruUOxAf7edk3u5dRVH3rhUsUkWcAIGceNXLDVNNP0J130KO2hps07x1N5Yq
 QyWA==
X-Gm-Message-State: APjAAAW0YOSy153Zp8jfIgA4y+lKbl8Lkaxmr8uZ/z+pTbue9lNR3Pla
 uCS5pp+KQ+z9h2Z8BVEDglh/DUhPQ5U=
X-Google-Smtp-Source: APXvYqylgnNM/+ELhRqYA6NdMZi1MEzv2hV5A9BPiMNyJ8BXA5sas59d24rmcczAhulGdgNlpJgnOQ==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr26770677wrn.207.1571069972019; 
 Mon, 14 Oct 2019 09:19:32 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-11-117.red.bezeqint.net. [79.178.11.117])
 by smtp.gmail.com with ESMTPSA id c132sm28050861wme.27.2019.10.14.09.19.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Oct 2019 09:19:31 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 12/13] target/avr: Register AVR support with the rest of
 QEMU, the build system, and the WMAINTAINERS file
Date: Mon, 14 Oct 2019 19:18:42 +0300
Message-Id: <20191014161843.84845-13-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191014161843.84845-1-mrolnik@gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  9 +++++++++
 arch_init.c                     |  2 ++
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 include/disas/dis-asm.h         |  6 ++++++
 include/sysemu/arch_init.h      |  1 +
 qapi/machine.json               |  3 ++-
 target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
 tests/machine-none-test.c       |  1 +
 9 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ca814850e..8c1a616958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,15 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target/avr/
+F: hw/misc/avr_mask.c
+F: hw/char/avr_usart.c
+F: hw/timer/avr_timer16.c
+F: hw/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index 0a1531124c..fb308aa802 100644
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
index 08ca4bcb46..e3b673b8cc 100755
--- a/configure
+++ b/configure
@@ -7444,6 +7444,10 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
   ;;
+  avr)
+    gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
   ;;
   hppa)
@@ -7663,6 +7667,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
index 62c6fe4cf1..893df26ce2 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..1fa2917ba9 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -21,11 +21,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: since 4.2
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


