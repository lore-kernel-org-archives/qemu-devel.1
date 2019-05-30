Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57812C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1671F26093
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcFwWecR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1671F26093
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQUC-00027L-Bi
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 15:13:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQPC-0006Vy-3T
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQPA-0007FG-M2
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:08:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hWQPA-0007Ek-Ea
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:08:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so1402892wme.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NChLzNXhY7ydvjEawMkdPp3Dr7YO8RUiKwuSwBBtLuY=;
	b=rcFwWecRbD83lvmUJ9qWc38CkLFS0UHXJwngdONU04+KhmF8+CLV0dmYexuccbMvJE
	tGRUjfB4lUNnzLMkcw9XRdMNKwyZHOfzy5WgAZvCXsWRM8jGmFykh4sfl/Weg/CPPjwl
	tmgV/IyxxS7R6494PKnJiiIlGtHfuNOXJ3u5vtp7mlSYWddjOzzar7AIyKpWlj2ndWVC
	MVndCNJMrFfM1YSzsKXukZaUxw7zdxLE6HiOgFJU06iN/E3tT4mPA068GknT5ZzMdMBa
	oSY1fQHrtSH8YMC+luTMytgKjd2cxB1UAjazx+wKy/tt/jviYqzkF1kXO7jjTPL44GwN
	8L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NChLzNXhY7ydvjEawMkdPp3Dr7YO8RUiKwuSwBBtLuY=;
	b=RZpG3R8ytKsTFzeGKFAe8KeXQc5pDebd96XQ1xSX0HBflzBu8g7nW6VyWj2tnH10aL
	/jcfRif1wM959nuN3nDJpy/jDegfdGNTMbHTQQ1n6SsvKCK7MAE90iEwoAs6o1fFOiKs
	lSKXlgyi6j3wiqNo5kK1JXvJwXcXYo24xA+V50htOTJ5pS9cGTOaUCfzTzIxdgyRj0Pp
	yFSE1J7/EM5GTdWmJzShWOkif0s24rQufAeaZG5Gk4MtqiV/ijYX45F4HD6YXqTyxFfQ
	dcJXrI7HYIn4MBvxzapA5jtuYX0SELbSMpS4BJLP9djVfpMlW3sc4OsF0Nyl3LZ8AT1G
	+MQw==
X-Gm-Message-State: APjAAAV3mU5cKPZAqDbKO81JszsQVNgP10QEqHhDYu4VN1NNa9xWKErX
	bYmSMayaZb7ixb1HZNM39ynPsnJT1ko=
X-Google-Smtp-Source: APXvYqwi/YIxDHerdmIx1l9Lt3eSftmFiyq2IsYmPmW0gLi8ACpJFqniuGG/p/ItwtEvIp+ZKnlWNw==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr2966137wml.159.1559243279105; 
	Thu, 30 May 2019 12:07:59 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-65-68-81.red.bezeqint.net.
	[109.65.68.81])
	by smtp.gmail.com with ESMTPSA id u9sm8711230wme.48.2019.05.30.12.07.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 12:07:58 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 22:07:38 +0300
Message-Id: <20190530190738.22713-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190530190738.22713-1-mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH RFC v20 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sarah Harris <S.E.Harris@kent.ac.uk>

Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  6 +++++
 arch_init.c                     |  2 ++
 configure                       |  6 +++++
 default-configs/avr-softmmu.mak |  5 +++++
 include/disas/dis-asm.h         |  6 +++++
 include/sysemu/arch_init.h      |  1 +
 qapi/common.json                |  2 +-
 target/avr/Makefile.objs        | 40 +++++++++++++++++++++++++++++++++
 tests/machine-none-test.c       |  1 +
 9 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f5f8b7a2c..4bad81f974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -162,6 +162,12 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Odd Fixes
+F: target/avr/
+F: hw/avr/
+
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..184cdca6dd 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -86,6 +86,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/configure b/configure
index 528b9ff705..933c166b02 100755
--- a/configure
+++ b/configure
@@ -7484,6 +7484,9 @@ case "$target_name" in
     target_compiler=$cross_cc_aarch64
     eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
+  avr)
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
     target_compiler=$cross_cc_cris
   ;;
@@ -7759,6 +7762,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
index 9240ec32c2..a7d230ba66 100644
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
index 99d313ef3b..eeacd0e3c2 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -187,7 +187,7 @@
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
index 0000000000..9ceddf1fdb
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,40 @@
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
+decode32-y = $(SRC_PATH)/target/avr/insn32.decode
+decode16-y = $(SRC_PATH)/target/avr/insn16.decode
+
+target/avr/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn32.inc.c \
+	target/avr/decode_insn16.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 4c6d470798..361927bb76 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.18.0


