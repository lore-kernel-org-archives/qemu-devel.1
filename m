Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15246C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6AB20DD4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcyU49PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6AB20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEByI-00078A-QS
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBww-00053m-TZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBwt-0005iH-MH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id w2so6137344wmi.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1HD7X9SbhYs6fGl3q12O38vXP04Gsb9f3vmT+04c5ec=;
 b=UcyU49PMY5f+n/yWE3tAx9XDNpB3bI11dI3IN52CocSlwpdwUgc+n6+kPQiHwQEMnf
 aZct18Z2yH3tl5NPIb4lKzEQJErBhiqb9mNEGvppSmdCexq94U8kUyKyk3Tg5S1kgAWl
 P2D+iqhoaCJi/clEPrqFuER+vZlZEWPz8kq7yq/xZjbnR1PrUeCWhc+GKYVDnJLziFsD
 tbD6gCr1ilsyAlSH7+h7u+wzjBwm4FPdFfFpSRojYMQHxJGFKEBFgmfF69I3xzUxyPtg
 BbxtaxzY2rYKofaDYd7EtCIDBpHXew7wCUbrgYjHdL+X7s6mmtFy2qd5Gxl+ui0ix+QO
 ECdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1HD7X9SbhYs6fGl3q12O38vXP04Gsb9f3vmT+04c5ec=;
 b=DLR2hCT7GerZcduO8Gf00Z0ja40fy4pMjBKfEfFs8FsMMJnVbH2Qewcnv2rPdO90Uu
 Tvl2t2venWfSGh9K2QJ5rYEl17REEbw3RMRyZm1nBWITcLHNE7tGgEtXkSBqQaAPUZyv
 QNk+WaB76PRYY7rQRIr7VOLKVPPlECpC7jvA0jbhqkhHSm5HFjU8Zn91XJANmTVssFyG
 2ciBBf+wykajFgHMQWCbr6uIGP6uE/Rn7DV4hWSMf9ii/UIvqDSHJpVgnGxWYRRWe7EX
 VPV91I4q1Yn26+cz+X35QsTVZJ8htTgr5J9xptassBF6Xk90E6oVL6G5QxxQVOuJXwNY
 zBiQ==
X-Gm-Message-State: AOAM5337FsyBbt3zZptE3l+9TSulZlfJZnp5yqFrsBJJE6wEzZSYYGv0
 EhuVfkW4g5hI3lWRpfhc5eyc/g==
X-Google-Smtp-Source: ABdhPJyB29zyFrI4WPILgBh0oUxGr0NO1NT0SkoFeQB/1iRymFWPnGDXhisy1QF/B6T3uqJ+pJpXiQ==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr7730566wmb.170.1599226813982; 
 Fri, 04 Sep 2020 06:40:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h185sm11751475wme.25.2020.09.04.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:40:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F8A31FF8F;
 Fri,  4 Sep 2020 14:40:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/4] plugins: move the more involved plugins to contrib
Date: Fri,  4 Sep 2020 14:40:06 +0100
Message-Id: <20200904134007.4175-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904134007.4175-1-alex.bennee@linaro.org>
References: <20200904134007.4175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have an exploding complexity problem in the testing so lets just
move the more involved plugins into contrib. tests/plugins still exist
for the basic plugins that exercise the API. We restore the old
pre-meson style Makefile for contrib as it also doubles as a guide for
out-of-tree plugin builds.

While we are at it add some examples to the documentation and a
specific plugins build target.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/tcg-plugins.rst                    | 142 ++++++++++++++++++
 configure                                     |   2 +
 Makefile                                      |  11 ++
 {tests/plugin => contrib/plugins}/hotblocks.c |   0
 {tests/plugin => contrib/plugins}/hotpages.c  |   0
 {tests/plugin => contrib/plugins}/howvec.c    |   0
 {tests/plugin => contrib/plugins}/lockstep.c  |   0
 MAINTAINERS                                   |   1 +
 contrib/plugins/Makefile                      |  42 ++++++
 tests/Makefile.include                        |   2 +-
 tests/plugin/meson.build                      |   4 +-
 tests/tcg/Makefile.target                     |   3 +-
 12 files changed, 202 insertions(+), 5 deletions(-)
 rename {tests/plugin => contrib/plugins}/hotblocks.c (100%)
 rename {tests/plugin => contrib/plugins}/hotpages.c (100%)
 rename {tests/plugin => contrib/plugins}/howvec.c (100%)
 rename {tests/plugin => contrib/plugins}/lockstep.c (100%)
 create mode 100644 contrib/plugins/Makefile

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index a05990906cc..e079695caf9 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -134,3 +134,145 @@ longer want to instrument the code. This operation is asynchronous
 which means callbacks may still occur after the uninstall operation is
 requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
+
+Example Plugins
+===============
+
+There are a number of plugins included with QEMU and you are
+encouraged to contribute them upstream. There is a `contrib/plugins`
+directory where they can go.
+
+- tests/plugins
+
+These are some basic plugins that are used to test and exercise the
+API during the `make check-tcg` target.
+
+- contrib/plugins/hotblocks.c
+
+The hotblocks plugin allows you to examine the where hot paths of
+execution are in your program. Once the program has finished you will
+get a sorted list of blocks reporting the starting PC, translation
+count, number of instructions and execution count. This will work best
+with linux-user execution as system emulation tends to generate
+re-translations as blocks from different programs get swapped in and
+out of system memory.
+
+If your program is single-threaded you can use the `inline` option for
+slightly faster (but not thread safe) counters.
+
+Example::
+
+  ./aarch64-linux-user/qemu-aarch64 -plugin contrib/plugins/libhotblocks.so -d plugin ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  collected 903 entries in the hash table
+  pc, tcount, icount, ecount
+  0x0000000041ed10, 1, 5, 66087
+  0x000000004002b0, 1, 4, 66087
+  ...
+
+- contrib/plugins/hotpages.c
+
+Similar to hotblocks but this time tracks memory accesses::
+
+  ./aarch64-linux-user/qemu-aarch64 -plugin contrib/plugins/libhotpages.so -d plugin ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  Addr, RCPUs, Reads, WCPUs, Writes
+  0x000055007fe000, 0x0001, 31747952, 0x0001, 8835161
+  0x000055007ff000, 0x0001, 29001054, 0x0001, 8780625
+  0x00005500800000, 0x0001, 687465, 0x0001, 335857
+  0x0000000048b000, 0x0001, 130594, 0x0001, 355
+  0x0000000048a000, 0x0001, 1826, 0x0001, 11
+
+- contrib/plugins/howvec.c
+
+This is an instruction classifier so can be used to count different
+types of instructions. It has a number of options to refine which get
+counted. You can give an argument for a class of instructions to break
+it down fully, so for example to see all the system registers
+accesses::
+
+  ./aarch64-softmmu/qemu-system-aarch64 $(QEMU_ARGS) \
+    -append "root=/dev/sda2 systemd.unit=benchmark.service" \
+    -smp 4 -plugin ./contrib/plugins/libhowvec.so,arg=sreg -d plugin
+
+which will lead to a sorted list after the class breakdown::
+
+  Instruction Classes:
+  Class:   UDEF                   not counted
+  Class:   SVE                    (68 hits)
+  Class:   PCrel addr             (47789483 hits)
+  Class:   Add/Sub (imm)          (192817388 hits)
+  Class:   Logical (imm)          (93852565 hits)
+  Class:   Move Wide (imm)        (76398116 hits)
+  Class:   Bitfield               (44706084 hits)
+  Class:   Extract                (5499257 hits)
+  Class:   Cond Branch (imm)      (147202932 hits)
+  Class:   Exception Gen          (193581 hits)
+  Class:     NOP                  not counted
+  Class:   Hints                  (6652291 hits)
+  Class:   Barriers               (8001661 hits)
+  Class:   PSTATE                 (1801695 hits)
+  Class:   System Insn            (6385349 hits)
+  Class:   System Reg             counted individually
+  Class:   Branch (reg)           (69497127 hits)
+  Class:   Branch (imm)           (84393665 hits)
+  Class:   Cmp & Branch           (110929659 hits)
+  Class:   Tst & Branch           (44681442 hits)
+  Class:   AdvSimd ldstmult       (736 hits)
+  Class:   ldst excl              (9098783 hits)
+  Class:   Load Reg (lit)         (87189424 hits)
+  Class:   ldst noalloc pair      (3264433 hits)
+  Class:   ldst pair              (412526434 hits)
+  Class:   ldst reg (imm)         (314734576 hits)
+  Class: Loads & Stores           (2117774 hits)
+  Class: Data Proc Reg            (223519077 hits)
+  Class: Scalar FP                (31657954 hits)
+  Individual Instructions:
+  Instr: mrs x0, sp_el0           (2682661 hits)  (op=0xd5384100/  System Reg)
+  Instr: mrs x1, tpidr_el2        (1789339 hits)  (op=0xd53cd041/  System Reg)
+  Instr: mrs x2, tpidr_el2        (1513494 hits)  (op=0xd53cd042/  System Reg)
+  Instr: mrs x0, tpidr_el2        (1490823 hits)  (op=0xd53cd040/  System Reg)
+  Instr: mrs x1, sp_el0           (933793 hits)   (op=0xd5384101/  System Reg)
+  Instr: mrs x2, sp_el0           (699516 hits)   (op=0xd5384102/  System Reg)
+  Instr: mrs x4, tpidr_el2        (528437 hits)   (op=0xd53cd044/  System Reg)
+  Instr: mrs x30, ttbr1_el1       (480776 hits)   (op=0xd538203e/  System Reg)
+  Instr: msr ttbr1_el1, x30       (480713 hits)   (op=0xd518203e/  System Reg)
+  Instr: msr vbar_el1, x30        (480671 hits)   (op=0xd518c01e/  System Reg)
+  ...
+
+To find the argument shorthand for the class you need to examine the
+source code of the plugin at the moment, specifically the `*opt`
+argument in the InsnClassExecCount tables.
+
+- contrib/plugins/lockstep.c
+
+This is a debugging tool for developers who want to find out when and
+where execution diverges after a subtle change to TCG code generation.
+It is not an exact science and results are likely to be mixed once
+asynchronous events are introduced. While the use of -icount can
+introduce determinism to the execution flow it doesn't always follow
+the translation sequence will be exactly the same. Typically this is
+caused by a timer firing to service the GUI causing a block to end
+early. However in some cases it has proved to be useful in pointing
+people at roughly where execution diverges. The only argument you need
+for the plugin is a path for the socket the two instances will
+communicate over::
+
+
+  ./sparc-softmmu/qemu-system-sparc -monitor none -parallel none \
+    -net none -M SS-20 -m 256 -kernel day11/zImage.elf \
+    -plugin ./contrib/plugins/liblockstep.so,arg=lockstep-sparc.sock \
+  -d plugin,nochain
+
+which will eventually report::
+
+  qemu-system-sparc: warning: nic lance.0 has no peer
+  @ 0x000000ffd06678 vs 0x000000ffd001e0 (2/1 since last)
+  @ 0x000000ffd07d9c vs 0x000000ffd06678 (3/1 since last)
+  Δ insn_count @ 0x000000ffd07d9c (809900609) vs 0x000000ffd06678 (809900612)
+    previously @ 0x000000ffd06678/10 (809900609 insns)
+    previously @ 0x000000ffd001e0/4 (809900599 insns)
+    previously @ 0x000000ffd080ac/2 (809900595 insns)
+    previously @ 0x000000ffd08098/5 (809900593 insns)
+    previously @ 0x000000ffd080c0/1 (809900588 insns)
+
diff --git a/configure b/configure
index f555923311f..2e4d3898012 100755
--- a/configure
+++ b/configure
@@ -8073,6 +8073,7 @@ DIRS="$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgraph"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios"
+DIRS="$DIRS contrib/plugins/"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
@@ -8084,6 +8085,7 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/acceptance tests/data"
 LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
+LINKS="$LINKS contrib/plugins/Makefile "
 UNLINK="pc-bios/keymaps"
 for bios_file in \
     $source_path/pc-bios/*.bin \
diff --git a/Makefile b/Makefile
index ed354c43b0b..2f1b18327dc 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,12 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 # Force configure to re-run if the API symbols are updated
 ifeq ($(CONFIG_PLUGIN),y)
 config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
+
+.PHONY: plugins
+plugins:
+	$(call quiet-command,\
+		$(MAKE) $(SUBDIR_MAKEFLAGS) -C contrib/plugins V="$(V)", \
+		"BUILD", "example plugins")
 endif
 
 else
@@ -276,6 +282,11 @@ help:
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
+ifeq ($(CONFIG_PLUGIN),y)
+	@echo  'Plugin targets:'
+	$(call print-help,plugins,Build the example TCG plugins)
+	@echo  ''
+endif
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/tests/plugin/hotblocks.c b/contrib/plugins/hotblocks.c
similarity index 100%
rename from tests/plugin/hotblocks.c
rename to contrib/plugins/hotblocks.c
diff --git a/tests/plugin/hotpages.c b/contrib/plugins/hotpages.c
similarity index 100%
rename from tests/plugin/hotpages.c
rename to contrib/plugins/hotpages.c
diff --git a/tests/plugin/howvec.c b/contrib/plugins/howvec.c
similarity index 100%
rename from tests/plugin/howvec.c
rename to contrib/plugins/howvec.c
diff --git a/tests/plugin/lockstep.c b/contrib/plugins/lockstep.c
similarity index 100%
rename from tests/plugin/lockstep.c
rename to contrib/plugins/lockstep.c
diff --git a/MAINTAINERS b/MAINTAINERS
index b233da2a737..8d8eeac61f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2746,6 +2746,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/plugin
+F: contrib/plugins
 
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
new file mode 100644
index 00000000000..7801b08b0d6
--- /dev/null
+++ b/contrib/plugins/Makefile
@@ -0,0 +1,42 @@
+# -*- Mode: makefile -*-
+#
+# This Makefile example is fairly independent from the main makefile
+# so users can take and adapt it for their build. We only really
+# include config-host.mak so we don't have to repeat probing for
+# cflags that the main configure has already done for us.
+#
+
+BUILD_DIR := $(CURDIR)/../..
+
+include $(BUILD_DIR)/config-host.mak
+
+VPATH += $(SRC_PATH)/contrib/plugins
+
+NAMES :=
+NAMES += hotblocks
+NAMES += hotpages
+NAMES += howvec
+NAMES += lockstep
+
+SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+
+# The main QEMU uses Glib extensively so it's perfectly fine to use it
+# in plugins (which many example do).
+CFLAGS = $(GLIB_CFLAGS)
+CFLAGS += -fPIC
+CFLAGS += $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
+CFLAGS += -I$(SRC_PATH)/include/qemu
+
+all: $(SONAMES)
+
+%.o: %.c
+	$(CC) $(CFLAGS) -c -o $@ $<
+
+lib%.so: %.o
+	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+
+clean:
+	rm -f *.o *.so *.d
+	rm -Rf .libs
+
+.PHONY: all clean
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a6..5a961d366e5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -439,7 +439,7 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 
-build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),test-plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index dbbdcbaa670..1eacfa6e355 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,7 +1,7 @@
 t = []
-foreach i : ['bb', 'empty', 'insn', 'mem', 'hotblocks', 'howvec', 'hotpages', 'lockstep']
+foreach i : ['bb', 'empty', 'insn', 'mem']
   t += shared_module(i, files(i + '.c'),
                      include_directories: '../../include/qemu',
                      dependencies: glib)
 endforeach
-alias_target('plugins', t)
+alias_target('test-plugins', t)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 4b2b696fcee..2ae86776cdc 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -129,8 +129,7 @@ ifeq ($(CONFIG_PLUGIN),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/plugin
 PLUGIN_LIB=../../plugin
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(filter-out liblockstep.so,\
-		$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
+PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
-- 
2.20.1


