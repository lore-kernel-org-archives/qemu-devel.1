Received: from eggs.gnu.org ([209.51.188.92]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKV6-0000qT-H2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKL2-0002xM-68
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gpKL1-0002oc-GE
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:36 -0500
From: Michael Walle <michael@walle.cc>
Date: Thu, 31 Jan 2019 22:56:11 +0100
Message-Id: <20190131215611.29341-4-michael@walle.cc>
In-Reply-To: <20190131215611.29341-1-michael@walle.cc>
References: <20190131215611.29341-1-michael@walle.cc>
Subject: [Qemu-devel] [RFC PATCH 3/3] tests/tcg/lm32: enable system tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Walle <michael@walle.cc>

Convert the existing to the new common cross build infrastructure.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 tests/tcg/lm32/Makefile                | 106 ---------------------------------
 tests/tcg/lm32/Makefile.include        |   8 +++
 tests/tcg/lm32/Makefile.softmmu-target |  33 ++++++++++
 3 files changed, 41 insertions(+), 106 deletions(-)
 delete mode 100644 tests/tcg/lm32/Makefile
 create mode 100644 tests/tcg/lm32/Makefile.include
 create mode 100644 tests/tcg/lm32/Makefile.softmmu-target

diff --git a/tests/tcg/lm32/Makefile b/tests/tcg/lm32/Makefile
deleted file mode 100644
index 57e7363b2c..0000000000
--- a/tests/tcg/lm32/Makefile
+++ /dev/null
@@ -1,106 +0,0 @@
--include ../../../config-host.mak
-
-CROSS=lm32-elf-
-
-SIM = qemu-system-lm32
-SIMFLAGS = -M lm32-evr -nographic -semihosting -net none -kernel
-
-CC      = $(CROSS)gcc
-AS      = $(CROSS)as
-AS      = $(CC) -x assembler
-SIZE    = $(CROSS)size
-LD      = $(CC)
-OBJCOPY = $(CROSS)objcopy
-
-TSRC_PATH = $(SRC_PATH)/tests/tcg/lm32
-
-LDFLAGS = -T$(TSRC_PATH)/linker.ld
-ASFLAGS += -Wa,-I,$(TSRC_PATH)/
-
-CRT        = crt.o
-HELPER     = helper.o
-TESTCASES += test_add.tst
-TESTCASES += test_addi.tst
-TESTCASES += test_and.tst
-TESTCASES += test_andhi.tst
-TESTCASES += test_andi.tst
-TESTCASES += test_b.tst
-TESTCASES += test_be.tst
-TESTCASES += test_bg.tst
-TESTCASES += test_bge.tst
-TESTCASES += test_bgeu.tst
-TESTCASES += test_bgu.tst
-TESTCASES += test_bi.tst
-TESTCASES += test_bne.tst
-TESTCASES += test_break.tst
-TESTCASES += test_bret.tst
-TESTCASES += test_call.tst
-TESTCASES += test_calli.tst
-TESTCASES += test_cmpe.tst
-TESTCASES += test_cmpei.tst
-TESTCASES += test_cmpg.tst
-TESTCASES += test_cmpgi.tst
-TESTCASES += test_cmpge.tst
-TESTCASES += test_cmpgei.tst
-TESTCASES += test_cmpgeu.tst
-TESTCASES += test_cmpgeui.tst
-TESTCASES += test_cmpgu.tst
-TESTCASES += test_cmpgui.tst
-TESTCASES += test_cmpne.tst
-TESTCASES += test_cmpnei.tst
-TESTCASES += test_divu.tst
-TESTCASES += test_eret.tst
-TESTCASES += test_lb.tst
-TESTCASES += test_lbu.tst
-TESTCASES += test_lh.tst
-TESTCASES += test_lhu.tst
-TESTCASES += test_lw.tst
-TESTCASES += test_modu.tst
-TESTCASES += test_mul.tst
-TESTCASES += test_muli.tst
-TESTCASES += test_nor.tst
-TESTCASES += test_nori.tst
-TESTCASES += test_or.tst
-TESTCASES += test_ori.tst
-TESTCASES += test_orhi.tst
-#TESTCASES += test_rcsr.tst
-TESTCASES += test_ret.tst
-TESTCASES += test_sb.tst
-TESTCASES += test_scall.tst
-TESTCASES += test_sextb.tst
-TESTCASES += test_sexth.tst
-TESTCASES += test_sh.tst
-TESTCASES += test_sl.tst
-TESTCASES += test_sli.tst
-TESTCASES += test_sr.tst
-TESTCASES += test_sri.tst
-TESTCASES += test_sru.tst
-TESTCASES += test_srui.tst
-TESTCASES += test_sub.tst
-TESTCASES += test_sw.tst
-#TESTCASES += test_wcsr.tst
-TESTCASES += test_xnor.tst
-TESTCASES += test_xnori.tst
-TESTCASES += test_xor.tst
-TESTCASES += test_xori.tst
-
-all: build
-
-%.o: $(TSRC_PATH)/%.c
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.o: $(TSRC_PATH)/%.S
-	$(AS) $(ASFLAGS) -c $< -o $@
-
-%.tst: %.o $(TSRC_PATH)/macros.inc $(CRT) $(HELPER)
-	$(LD) $(LDFLAGS) $(NOSTDFLAGS) $(CRT) $(HELPER) $< -o $@
-
-build: $(TESTCASES)
-
-check: $(TESTCASES:test_%.tst=check_%)
-
-check_%: test_%.tst
-	@$(SIM) $(SIMFLAGS) $<
-
-clean:
-	$(RM) -fr $(TESTCASES) $(CRT) $(HELPER)
diff --git a/tests/tcg/lm32/Makefile.include b/tests/tcg/lm32/Makefile.include
new file mode 100644
index 0000000000..f36f23031d
--- /dev/null
+++ b/tests/tcg/lm32/Makefile.include
@@ -0,0 +1,8 @@
+#
+# Makefile.include for all CRIS targets
+#
+
+DOCKER_IMAGE=debian-lm32-cross
+DOCKER_CROSS_COMPILER=lm32-elf-gcc
+DOCKER_CROSS_ASSEMBLER=lm32-elf-as
+DOCKER_CROSS_LINKER=lm32-elf-ld
diff --git a/tests/tcg/lm32/Makefile.softmmu-target b/tests/tcg/lm32/Makefile.softmmu-target
new file mode 100644
index 0000000000..71a1a1802b
--- /dev/null
+++ b/tests/tcg/lm32/Makefile.softmmu-target
@@ -0,0 +1,33 @@
+#
+# lm32 softmmu tests
+#
+
+LM32_SRC = $(SRC_PATH)/tests/tcg/lm32
+LM32_ALL = $(wildcard $(LM32_SRC)/test_*.S)
+LM32_TESTS = $(patsubst $(LM32_SRC)/%.S, %, $(LM32_ALL))
+# Filter out common blobs and broken tests
+LM32_BROKEN_TESTS =
+LM32_USABLE_TESTS = $(filter-out $(LM32_BROKEN_TESTS), $(LM32_TESTS))
+LM32_RUNS = $(patsubst %, run-%, $(LM32_USABLE_TESTS))
+
+# add to the list of tests
+TESTS += $(LM32_USABLE_TESTS)
+VPATH += $(LM32_SRC)
+
+QEMU_OPTS = -M lm32-evr -nographic -semihosting -net none -serial none -monitor none -kernel
+
+INCLUDE_DIRS = $(SRC_PATH)/tests/tcg/lm32
+LM32_INC = $(addprefix -I,$(INCLUDE_DIRS))
+
+LDFLAGS = -T$(SRC_PATH)/tests/tcg/lm32/linker.ld
+
+CRT        = crt.o helper.o
+
+$(LM32_USABLE_TESTS): macros.inc $(CRT) Makefile.softmmu-target
+
+# special rule for common blobs
+%.o: %.S
+	$(AS) $(LM32_INC) $(ASFLAGS) -c $< -o $@
+
+%: %.o
+	$(LD) $(LM32_INC) $< -o $@ $(LDFLAGS) $(CRT)
-- 
2.11.0
