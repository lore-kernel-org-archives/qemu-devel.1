Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93B22467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFzo08nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93B22467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWXe-00062N-Tu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8E-0004Zt-Og
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8B-0000ZZ-Gs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8B-0000X6-3z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:31 -0500
Received: by mail-wr1-x434.google.com with SMTP id z7so17073694wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZdygRL19AevPbL3Pg5vaQk05LgmPC9+ZrGY5kcERy/4=;
 b=YFzo08nAZ652zCtzzQRGpLjgWXSgH1PbmacZeBF9t/FzpS51LBEq26R4Oxvqi4JCR5
 i8evCVymlGxNXJWcxAYcj/zyMF+BqQv6oOO6lJrDMHAgzjSr2Z7M7Y7vWqBaJoFI54+H
 XY/+g7iUns9bJKqth3n79PAlkfz69QVafyW+7lml+A68hQIZyNJCbfoXIewHzvHe8J6M
 n+7EGXBB2hFrBasSkb/dqwy4comK4SP4W2maidZIaeCA+PUVpe6Lr/7Mk/QnbOCi5cBr
 3eTFke03gv/Ek2b4pM1lppjWEKAiWJPq4/PbE3vkRU6wx4lcRLyz5FisCUZPOYifoIfe
 N7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZdygRL19AevPbL3Pg5vaQk05LgmPC9+ZrGY5kcERy/4=;
 b=RBWbGqGOWyH0PHPwQHmOrrp1WVX6FSzo0sR99Ng7A1klLnbPNw40iQJomv4x/hZ1mG
 1T5I9LkHsqrOm/L/640ohOloK2d5KCv7ZENjwMINoTrl0pICCrWEeeqz0TYy0ZOX2oRP
 UXDtNkM/gxe7ZdzEjU8+B7uWXAR5iXsKeRiYHu+lVzCbbz2NiNyZVDK+5lC1EpqxWfgm
 AnHYtoYyVcSvad8Gb0V0f8gpujgUF0LZLmoYc4D3v2XHzEcJHN5uwuJ5SgmQluV45teI
 FF5It+xgNg4nna5lCst2bF0IvBj3RhnV7L4gnh/LO0586Z0m7gacgnXjVqv/hRzQCHlI
 lyog==
X-Gm-Message-State: APjAAAVQKrvEBIWKsuBS/dSS/7VAAtAlIW91dNoPSybVjP6emcCeAdvU
 +etd7FHUl29NkoqwLcJHPd2U4/Wm
X-Google-Smtp-Source: APXvYqwpO5GwMl/NfFw6xtJgEbMsp/5AsLT4hiUN34oUJgm7iNbXwqJpPNTRr3BaqS3OYnkn6AM2NA==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29060922wro.51.1580234309551; 
 Tue, 28 Jan 2020 09:58:29 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 119/142] Aaaaallelujah!
Date: Tue, 28 Jan 2020 18:53:19 +0100
Message-Id: <20200128175342.9066-120-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.yml                            |   6 +-
 Makefile                                  |  20 +---
 Makefile.target                           | 133 +---------------------
 configure                                 |   4 -
 docs/devel/blkverify.txt                  |   4 +-
 docs/devel/testing.rst                    |   4 +-
 docs/interop/live-block-operations.rst    |   4 +-
 meson.build                               |  31 ++++-
 os-posix.c                                |   2 +-
 plugins/meson.build                       |  10 +-
 scripts/device-crash-test                 |   2 +-
 tests/Makefile.include                    |  10 +-
 tests/acceptance/avocado_qemu/__init__.py |   3 +-
 tests/data/acpi/rebuild-expected-aml.sh   |   2 +-
 tests/libqos/qgraph.h                     |   2 +-
 tests/multiboot/run_test.sh               |   2 +-
 tests/qemu-iotests/check                  |   6 +-
 tests/rtas-test.c                         |   2 +-
 tests/tcg/configure.sh                    |   4 +-
 20 files changed, 71 insertions(+), 181 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ebcef0ebe9..9c13ff867d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -89,9 +89,9 @@ build-tci:
  - make -j2
  - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
  - for tg in $TARGETS ; do
-     export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
+     export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
      ./tests/boot-serial-test || exit 1 ;
      ./tests/cdrom-test || exit 1 ;
    done
- - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-test
- - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/pxe-test -m slow
+ - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/pxe-test
+ - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/pxe-test -m slow
diff --git a/Makefile b/Makefile
index 82492fa67c..91fa9025c9 100644
--- a/Makefile
+++ b/Makefile
@@ -106,9 +106,6 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y += target/s390x/gen-features.h
-target/s390x/gen-features.h: Makefile.ninja
-
 generated-files-y += .git-submodule-status
 
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
@@ -168,18 +165,6 @@ SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
-$(SOFTMMU_ALL_RULES): $(authz-obj-y)
-$(SOFTMMU_ALL_RULES): $(block-obj-y)
-$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
-$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
-$(SOFTMMU_ALL_RULES): $(io-obj-y)
-$(SOFTMMU_ALL_RULES): $(qom-obj-y)
-$(SOFTMMU_ALL_RULES): config-all-devices.mak
-
-# meson: this is sub-optimal but going away after conversion
-TARGET_DEPS = $(patsubst %,%-config-target.h, $(TARGET_DIRS))
-TARGET_DEPS += $(patsubst %,%-config-devices.h, $(filter %-softmmu,$(TARGET_DIRS)))
-TARGET_DEPS += $(patsubst %,libqemu-%.fa, $(TARGET_DIRS))
 
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
@@ -228,8 +213,7 @@ subdir-dtc: dtc/all
 subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
-$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) block.syms qemu.syms
+$(filter %/all, $(TARGET_DIRS_RULES)):
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
@@ -251,8 +235,6 @@ Makefile: $(version-obj-y)
 
 ######################################################################
 
-COMMON_LDADDS = libqemuutil.a
-
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
diff --git a/Makefile.target b/Makefile.target
index edc08803db..8ee4c78b3f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,43 +6,16 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
 
-FULL_TARGET_NAME=$(TARGET_NAME)-$(if $(CONFIG_SOFTMMU),softmmu,linux-user)
-
-ifdef CONFIG_SOFTMMU
-include ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
-ifdef CONFIG_LINUX
-QEMU_CFLAGS += -I../linux-headers
-endif
-QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
-
-QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
-
-QEMU_CFLAGS += -DCONFIG_TARGET=\"../$(FULL_TARGET_NAME)-config-target.h\"
-QEMU_CFLAGS += -DCONFIG_DEVICES=\"../$(FULL_TARGET_NAME)-config-devices.h\"
 
 ifdef CONFIG_USER_ONLY
 # user emulator name
 QEMU_PROG=qemu-$(TARGET_NAME)
-QEMU_PROG_BUILD = $(QEMU_PROG)
 else
 # system emulator name
 QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
-ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
-# Terminate program name with a 'w' because the linker builds a windows executable.
-QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
-$(QEMU_PROG): $(QEMU_PROGW)
-	$(call quiet-command,$(OBJCOPY) --subsystem console $(QEMU_PROGW) $(QEMU_PROG),"GEN","$(TARGET_DIR)$(QEMU_PROG)")
-QEMU_PROG_BUILD = $(QEMU_PROGW)
-else
-QEMU_PROG_BUILD = $(QEMU_PROG)
-endif
 endif
 
-LIBQEMU = ../libqemu-$(FULL_TARGET_NAME).fa
-PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
 ifdef CONFIG_TRACE_SYSTEMTAP
@@ -98,105 +71,10 @@ stap:
 endif
 .PHONY: stap
 
-all: $(PROGS) stap
-
-# Dummy command so that make thinks it has done something
-	@true
-
-obj-y += $(LIBQEMU)
-
-obj-y += trace/
-
-#########################################################
-LIBS := $(libs_cpu) $(LIBS)
-
-#########################################################
-# Linux user emulator target
-
-ifdef CONFIG_LINUX_USER
-
-QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
-             -I$(SRC_PATH)/linux-user/host/$(ARCH) \
-             -I$(SRC_PATH)/linux-user
-
-endif #CONFIG_LINUX_USER
-
-#########################################################
-# BSD user emulator target
-
-ifdef CONFIG_BSD_USER
-
-QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
-			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
+all: stap
 
-endif #CONFIG_BSD_USER
-
-#########################################################
-# System emulator target
-ifdef CONFIG_SOFTMMU
-LIBS := $(libs_softmmu) $(LIBS)
-
-# Temporary until emulators are linked by Meson
-LIBS := $(LIBS) @../block.syms @../qemu.syms
-ifneq ($(CONFIG_MODULES),y)
-LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
-LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
-endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
-LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
-LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
-LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
-
-ifeq ($(CONFIG_PLUGIN),y)
-ifdef CONFIG_HAS_LD_DYNAMIC_LIST
-LIBS += -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
-else
-ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
-LIBS += -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
-endif
-endif
-
-generated-files-y += hmp-commands.h hmp-commands-info.h
-
-endif # CONFIG_SOFTMMU
-
-dummy := $(call unnest-vars,,obj-y)
-all-obj-y := $(obj-y)
-
-include $(SRC_PATH)/Makefile.objs
-dummy := $(call fix-paths,../,, \
-              authz-obj-y \
-              block-obj-y \
-              chardev-obj-y \
-              crypto-obj-y \
-              io-obj-y \
-              qom-obj-y)
-dummy := $(call unnest-vars,..,common-obj-y)
-
-all-obj-y += $(common-obj-y)
-all-obj-y += $(qom-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
-
-ifdef CONFIG_SOFTMMU
-$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
-COMMON_LDADDS = ../libqemuutil.a
-
-# build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $(filter-out %.mak, $^))
-ifdef CONFIG_DARWIN
-	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
-	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
-endif
-
-clean: clean-target
-	rm -f *.a *~ $(PROGS)
+clean:
+	rm -f *.a *~
 	rm -f $(shell find . -name '*.[od]')
 	rm -f hmp-commands.h gdbstub-xml.c
 	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
@@ -205,9 +83,6 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 
 install: all
-ifneq ($(PROGS),)
-	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
 	$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG).stp"
@@ -215,4 +90,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
 endif
 
-Makefile: $(generated-files-y)
+.PHONY: all clean install
diff --git a/configure b/configure
index 5c6217e7e6..e39d7ac2d1 100755
--- a/configure
+++ b/configure
@@ -314,7 +314,6 @@ audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
 host_cc="cc"
-libs_cpu=""
 libs_softmmu=""
 libs_tools=""
 audio_win_int=""
@@ -5124,7 +5123,6 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
     capstone_libs="-L$PWD/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
@@ -5133,7 +5131,6 @@ case "$capstone" in
     capstone_libs="$($pkg_config --libs capstone)"
     capstone_cflags="$($pkg_config --cflags capstone)"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
-    libs_cpu="$($pkg_config --libs capstone) $libs_cpu"
     ;;
 
   no)
@@ -6660,7 +6657,6 @@ echo "qemu_helperdir=$libexecdir" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
-echo "libs_cpu=$libs_cpu" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
diff --git a/docs/devel/blkverify.txt b/docs/devel/blkverify.txt
index d556dc4e6d..aca826c51c 100644
--- a/docs/devel/blkverify.txt
+++ b/docs/devel/blkverify.txt
@@ -62,8 +62,8 @@ A more realistic scenario is verifying the installation of a guest OS:
 
     $ ./qemu-img create raw.img 16G
     $ ./qemu-img create -f qcow2 test.qcow2 16G
-    $ x86_64-softmmu/qemu-system-x86_64 -cdrom debian.iso \
-                                        -drive file=blkverify:raw.img:test.qcow2
+    $ ./qemu-system-x86_64 -cdrom debian.iso \
+          -drive file=blkverify:raw.img:test.qcow2
 
 If the installation is aborted when blkverify detects corruption, use qemu-io
 to explore the contents of the disk image at the sector in question.
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 053ce37da2..d775488dfc 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -711,7 +711,7 @@ the following approaches:
 1) Set ``qemu_bin``, and use the given binary
 
 2) Do not set ``qemu_bin``, and use a QEMU binary named like
-   "${arch}-softmmu/qemu-system-${arch}", either in the current
+   "qemu-system-${arch}", either in the current
    working directory, or in the current source tree.
 
 The resulting ``qemu_bin`` value will be preserved in the
@@ -778,7 +778,7 @@ like the following:
 
 .. code::
 
-  PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
+  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
 
 arch
 ~~~~
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 48afdc7927..e13f5a21f8 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -129,7 +129,7 @@ To show some example invocations of command-line, we will use the
 following invocation of QEMU, with a QMP server running over UNIX
 socket::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./a.qcow2 \
         -device virtio-blk,drive=node-A,id=virtio0 \
@@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted earlier, for
 simplicity's sake, the destination QEMU is started on the same host, but
 it could be located elsewhere)::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
         -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
diff --git a/meson.build b/meson.build
index f924d69185..456d2c1eb8 100644
--- a/meson.build
+++ b/meson.build
@@ -174,10 +174,12 @@ brlapi = declare_dependency()
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
+sdlwindows = false
 sdl = declare_dependency()
 if 'CONFIG_SDL' in config_host
   sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
                            link_args: config_host['SDL_LIBS'].split())
+  sdlwindows = config_host['SDL_LIBS'].contains('-mwindows')
 endif
 rbd = declare_dependency()
 if 'CONFIG_RBD' in config_host
@@ -758,11 +760,15 @@ common_all = static_library('common',
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
 
+emulators = []
 foreach target : target_dirs
   config_target = target_config[target]
   target_name = config_target['TARGET_NAME']
   arch = config_target['TARGET_BASE_ARCH']
   arch_srcs = []
+  arch_deps = []
+  link_args = []
+  deps = [authz, block, chardev, crypto, io, qom, qemuutil]
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
   if host_machine.system() == 'linux'
@@ -773,12 +779,15 @@ foreach target : target_dirs
     target_type='system'
     t = target_softmmu_arch[arch].apply(config_target, strict: false)
     arch_srcs += t.sources()
+    arch_deps += t.dependencies()
 
     hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
     hw = hw_arch[hw_dir].apply(config_target, strict: false)
     arch_srcs += hw.sources()
+    arch_deps += hw.dependencies()
 
     arch_srcs += target_devices_h[target]
+    link_args = ['@block.syms', '@qemu.syms']
   else
     target_type='user'
     qemu_target_name = 'qemu-' + target_name
@@ -810,9 +819,11 @@ foreach target : target_dirs
 
   t = target_arch[arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
+  arch_deps += t.dependencies()
 
   target_common = common_ss.apply(config_target, strict: false)
   objects = common_all.extract_objects(target_common.sources())
+  deps += target_common.dependencies()
 
   # TODO: Change to generator once obj-y goes away
   config_target_h = custom_target(target + '-config-target.h',
@@ -823,15 +834,33 @@ foreach target : target_dirs
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
+  arch_deps += target_specific.dependencies()
 
-  static_library('qemu-' + target,
+  lib = static_library('qemu-' + target,
                  sources: arch_srcs + [config_target_h],
                  objects: objects,
                  include_directories: target_inc,
                  c_args: ['-DNEED_CPU_H',
                           '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
                           '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)],
+                 build_by_default: false,
                  name_suffix: 'fa')
+
+  execs = [{'postfix': '', 'gui': false}]
+  if sdlwindows
+    execs += [{'postfix': 'w', 'gui': true}]
+  endif
+  foreach exe: execs
+    exe_name = qemu_target_name + exe['postfix']
+    emulators += executable(exe_name,
+               install: true,
+               objects: lib.extract_all_objects(recursive: true),
+               dependencies: arch_deps + deps,
+               link_language: 'cpp',
+               link_depends: [block_syms, qemu_syms],
+               link_args: link_args,
+               gui_app: exe['gui'])
+  endforeach
 endforeach
 
 # Other build targets
diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e70..b2c6ae7438 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -93,7 +93,7 @@ char *os_find_datadir(void)
     exec_dir = qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir != NULL, NULL);
 
-    dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
+    dir = g_build_filename(exec_dir, "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
     }
diff --git a/plugins/meson.build b/plugins/meson.build
index 9608e5293f..e77723010e 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,5 +1,13 @@
+if 'CONFIG_HAS_LD_DYNAMIC_LIST' in config_host
+  plugin_ldflags = ['-Wl,--dynamic-list=' + (meson.build_root() / 'qemu-plugins-ld.symbols')]
+elif 'CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST' in config_host
+  plugin_ldflags = ['-Wl,-exported_symbols_list,' + (meson.build_root() / 'qemu-plugins-ld64.symbols')]
+else
+  plugin_ldflags = []
+endif
+
 specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
   'loader.c',
   'core.c',
   'api.c',
-)])
+), declare_dependency(link_args: plugin_ldflags)])
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 15f213a6cd..3add0528ac 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -384,7 +384,7 @@ def binariesToTest(args, testcase):
     if args.qemu:
         r = args.qemu
     else:
-        r = glob.glob('./*-softmmu/qemu-system-*')
+        r = glob.glob('./qemu-system-*')
     return r
 
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 62b65f409d..d40e666311 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -912,9 +912,9 @@ define do_test_tap
 endef
 
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
-$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
+$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
 	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
-	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
+	  QTEST_QEMU_BINARY=$(BUILD_DIR)/qemu-system-$* \
 	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
 
 check-unit: $(check-unit-y)
@@ -925,9 +925,9 @@ check-speed: $(check-speed-y)
 
 # gtester tests with TAP output
 
-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: %-softmmu/all $(check-qtest-y)
+$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: $(check-qtest-y)
 	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
-	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
+	  QTEST_QEMU_BINARY=$(BUILD_DIR)/qemu-system-$* \
 	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
 
 check-report-unit.tap: $(check-unit-y)
@@ -1123,7 +1123,7 @@ QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu
 .PHONY: check-tests/check-block.sh
 check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
+		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
 	@$<
 
 .PHONY: check-tests/qapi-schema/frontend
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 6618ea67c1..a236322534 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -44,8 +44,7 @@ def pick_default_qemu_bin(arch=None):
     # qemu binary path does not match arch for powerpc, handle it
     if 'ppc64le' in arch:
         arch = 'ppc64'
-    qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
-                                          "qemu-system-%s" % arch)
+    qemu_bin_relative_path = "qemu-system-%s" % arch
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
 
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index f89d4624bc..0193562000 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
+qemu_bins="./qemu-system-x86_64 ./qemu-system-aarch64"
 
 if [ ! -e "tests/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index 3a25dda4b2..184b5b4643 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -226,7 +226,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  *        my_test <--consumed_by-- my_interface <--produces--+
  *
  * Assuming there the binary is
- * QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
+ * QTEST_QEMU_BINARY=./qemu-system-x86_64
  * a valid test path will be:
  * "/x86_64/pc/other_node/my_driver/my_interface/my_test".
  *
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 98df91e6af..f968bf797e 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -20,7 +20,7 @@
 # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 # THE SOFTWARE.
 
-QEMU=${QEMU:-"../../x86_64-softmmu/qemu-system-x86_64"}
+QEMU=${QEMU:-"../../qemu-system-x86_64"}
 
 run_qemu() {
     local kernel=$1
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 90970b0549..406f0c3b65 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -567,11 +567,11 @@ if [ -z "$QEMU_PROG" ]
 then
     if [ -x "$build_iotests/qemu" ]; then
         export QEMU_PROG="$build_iotests/qemu"
-    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}" ]; then
-        export QEMU_PROG="$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}"
+    elif [ -x "$build_root/qemu-system-${qemu_arch}" ]; then
+        export QEMU_PROG="$build_root/qemu-system-${qemu_arch}"
     else
         pushd "$build_root" > /dev/null
-        for binary in *-softmmu/qemu-system-*
+        for binary in qemu-system-*
         do
             if [ -x "$binary" ]
             then
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index 167b42db38..91ac976c0c 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -31,7 +31,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "ppc64")) {
-        g_printerr("RTAS requires ppc64-softmmu/qemu-system-ppc64\n");
+        g_printerr("RTAS requires qemu-system-ppc64\n");
         exit(EXIT_FAILURE);
     }
     qtest_add_func("rtas/get-time-of-day", test_rtas_get_time_of_day);
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 210e68396f..850f17096a 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -184,11 +184,11 @@ for target in $target_list; do
   case $target in
     *-linux-user | *-bsd-user)
       echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/$target/qemu-$arch" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/qemu-$arch" >> $config_target_mak
       ;;
     *-softmmu)
       echo "CONFIG_SOFTMMU=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/$target/qemu-system-$arch" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/qemu-system-$arch" >> $config_target_mak
       ;;
   esac
 
-- 
2.21.0



