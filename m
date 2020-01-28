Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27543C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4382467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFVxA4eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4382467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW8I-00022X-Sx
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV81-0004A5-1F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7u-0008LS-Pz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7u-0008Iw-BS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id b2so3601605wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oyj6Hk0UiGPqsuH6G2vn3gRhp2E65whr5iaHzfEIsf4=;
 b=XFVxA4eFajxn2085Nps45XsTSUsh5m8QBh1+OwbCKM0JPGGH3q0VdTKuCuALSy92mT
 +cP02RRkcbMQrLNRBFRfYzp1llOb9NZSMNLMArEMXSTrFP6QHHb9PHZ1ML15Gzd0QneF
 59jdiCzGdgVBDVF67QrB0xoRev30nbNEE9LB8/2KwDQkhaRC/khZaYOOmRiBRtqjuPWW
 DO08qq6W1/+CgwG7d0kX+gFfGahOzu/W5K7evUrIHMYUdxHRhx1d5tHuBuF9rXV2pCqD
 WWZ214s7L2AZxQmUc+Uz9rcm0KC9E7mWkrZh2uUVt6us1EZlcYwiOm/ym8etVHpTYo3p
 /HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oyj6Hk0UiGPqsuH6G2vn3gRhp2E65whr5iaHzfEIsf4=;
 b=kQfp0v9OhBLAMvcCbu6qCnanxrrlIb+uFY13Paqb9o24IJeSrIkQe/UxiXMdjFEag+
 KBPRtGakIYRtBcn5PcHJcPNd39CWwOt1uBQgL/xAjOm0AZAyPpkzf0szn6jmcizDxaoY
 Xlox1OEvZ9YtaWVuH2he3ND/wJohWRRQaSB4OgC87cbjyf7p4fmfOOHHXVGnIKqBYwFK
 KeaR4gA8oZbskmxUMV95dM+lg5cTRQO44+4UAB/s42ndpENwJuhG6DFS7pYb0BOLe6bQ
 ocaBpP4t73BrYUDs8Er9Z0Se6s9tVXfbfyypTT5MoWzocqG/9H9qnQS1sOrNtrkFy6tD
 QJow==
X-Gm-Message-State: APjAAAXfn73VNzrCq80FNKDxHTubz/3HOjukg0HvpNf1HqUbyqLcHhCh
 sNJladbNibiZWRc6yHMRc/wATXVA
X-Google-Smtp-Source: APXvYqx56sKDOODUB/l8pFwElQS7zf5A9Gweb9KIqbrXtQjD6F7U6Y8r26zD1/IRuutUKfP96rGmfg==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr6166246wmi.17.1580234292260; 
 Tue, 28 Jan 2020 09:58:12 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 112/142] meson: target
Date: Tue, 28 Jan 2020 18:53:12 +0100
Message-Id: <20200128175342.9066-113-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 .gitignore                      |  2 +-
 Makefile.target                 |  3 +-
 libdecnumber/Makefile.objs      |  5 ---
 libdecnumber/meson.build        |  7 ++++
 meson.build                     | 11 ++++++
 scripts/decodetree.py           |  2 +-
 target/alpha/Makefile.objs      |  4 --
 target/alpha/meson.build        | 18 +++++++++
 target/arm/Makefile.objs        | 69 ---------------------------------
 target/arm/meson.build          | 57 +++++++++++++++++++++++++++
 target/arm/translate-sve.c      |  2 +-
 target/arm/translate-vfp.inc.c  |  4 +-
 target/arm/translate.c          |  8 ++--
 target/cris/Makefile.objs       |  3 --
 target/cris/meson.build         | 14 +++++++
 target/hppa/Makefile.objs       | 11 ------
 target/hppa/meson.build         | 19 +++++++++
 target/hppa/translate.c         |  2 +-
 target/i386/Makefile.objs       | 22 -----------
 target/i386/hvf/Makefile.objs   |  2 -
 target/i386/hvf/meson.build     | 12 ++++++
 target/i386/meson.build         | 41 ++++++++++++++++++++
 target/lm32/Makefile.objs       |  4 --
 target/lm32/meson.build         | 15 +++++++
 target/m68k/Makefile.objs       |  5 ---
 target/m68k/meson.build         | 17 ++++++++
 target/meson.build              | 20 ++++++++++
 target/microblaze/Makefile.objs |  3 --
 target/microblaze/meson.build   | 14 +++++++
 target/mips/Makefile.objs       |  5 ---
 target/mips/meson.build         | 22 +++++++++++
 target/moxie/Makefile.objs      |  2 -
 target/moxie/meson.build        | 14 +++++++
 target/nios2/Makefile.objs      |  4 --
 target/nios2/meson.build        | 15 +++++++
 target/openrisc/Makefile.objs   | 15 -------
 target/openrisc/disas.c         |  2 +-
 target/openrisc/meson.build     | 23 +++++++++++
 target/openrisc/translate.c     |  2 +-
 target/ppc/Makefile.objs        | 20 ----------
 target/ppc/meson.build          | 37 ++++++++++++++++++
 target/riscv/Makefile.objs      | 28 -------------
 target/riscv/meson.build        | 33 ++++++++++++++++
 target/riscv/translate.c        |  4 +-
 target/s390x/Makefile.objs      | 10 -----
 target/s390x/meson.build        | 42 +++++++++++++++++++-
 target/sh4/Makefile.objs        |  3 --
 target/sh4/meson.build          | 14 +++++++
 target/sparc/Makefile.objs      |  7 ----
 target/sparc/meson.build        | 23 +++++++++++
 target/tilegx/Makefile.objs     |  1 -
 target/tilegx/meson.build       | 13 +++++++
 target/tricore/Makefile.objs    |  1 -
 target/tricore/meson.build      | 14 +++++++
 target/unicore32/Makefile.objs  |  8 ----
 target/unicore32/meson.build    | 14 +++++++
 target/xtensa/Makefile.objs     | 16 --------
 target/xtensa/meson.build       | 30 ++++++++++++++
 58 files changed, 553 insertions(+), 265 deletions(-)
 delete mode 100644 libdecnumber/Makefile.objs
 create mode 100644 libdecnumber/meson.build
 delete mode 100644 target/alpha/Makefile.objs
 create mode 100644 target/alpha/meson.build
 delete mode 100644 target/arm/Makefile.objs
 create mode 100644 target/arm/meson.build
 delete mode 100644 target/cris/Makefile.objs
 create mode 100644 target/cris/meson.build
 delete mode 100644 target/hppa/Makefile.objs
 create mode 100644 target/hppa/meson.build
 delete mode 100644 target/i386/Makefile.objs
 delete mode 100644 target/i386/hvf/Makefile.objs
 create mode 100644 target/i386/hvf/meson.build
 create mode 100644 target/i386/meson.build
 delete mode 100644 target/lm32/Makefile.objs
 create mode 100644 target/lm32/meson.build
 delete mode 100644 target/m68k/Makefile.objs
 create mode 100644 target/m68k/meson.build
 delete mode 100644 target/microblaze/Makefile.objs
 create mode 100644 target/microblaze/meson.build
 delete mode 100644 target/mips/Makefile.objs
 create mode 100644 target/mips/meson.build
 delete mode 100644 target/moxie/Makefile.objs
 create mode 100644 target/moxie/meson.build
 delete mode 100644 target/nios2/Makefile.objs
 create mode 100644 target/nios2/meson.build
 delete mode 100644 target/openrisc/Makefile.objs
 create mode 100644 target/openrisc/meson.build
 delete mode 100644 target/ppc/Makefile.objs
 create mode 100644 target/ppc/meson.build
 delete mode 100644 target/riscv/Makefile.objs
 create mode 100644 target/riscv/meson.build
 delete mode 100644 target/s390x/Makefile.objs
 delete mode 100644 target/sh4/Makefile.objs
 create mode 100644 target/sh4/meson.build
 delete mode 100644 target/sparc/Makefile.objs
 create mode 100644 target/sparc/meson.build
 delete mode 100644 target/tilegx/Makefile.objs
 create mode 100644 target/tilegx/meson.build
 delete mode 100644 target/tricore/Makefile.objs
 create mode 100644 target/tricore/meson.build
 delete mode 100644 target/unicore32/Makefile.objs
 create mode 100644 target/unicore32/meson.build
 delete mode 100644 target/xtensa/Makefile.objs
 create mode 100644 target/xtensa/meson.build

diff --git a/.gitignore b/.gitignore
index 5cce371901..9fada8e46c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -160,4 +160,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
-/target/arm/decode-sve.inc.c
+/target/arm/decode-sve.inc
diff --git a/Makefile.target b/Makefile.target
index 584cfb58c4..675c23acc8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -116,7 +116,6 @@ obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-$(CONFIG_TCG) += fpu/softfloat.o
-obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 LIBS := $(libs_cpu) $(LIBS)
@@ -169,7 +168,7 @@ LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOM
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS := $(LIBS) $(VIRGL_LIBS)
+LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
 
diff --git a/libdecnumber/Makefile.objs b/libdecnumber/Makefile.objs
deleted file mode 100644
index d81db0443a..0000000000
--- a/libdecnumber/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y += decContext.o
-obj-y += decNumber.o
-obj-y += dpd/decimal32.o
-obj-y += dpd/decimal64.o
-obj-y += dpd/decimal128.o
diff --git a/libdecnumber/meson.build b/libdecnumber/meson.build
new file mode 100644
index 0000000000..4d04139af4
--- /dev/null
+++ b/libdecnumber/meson.build
@@ -0,0 +1,7 @@
+libdecnumber = files(
+  'decContext.c',
+  'decNumber.c',
+  'dpd/decimal128.c',
+  'dpd/decimal32.c',
+  'dpd/decimal64.c',
+)
diff --git a/meson.build b/meson.build
index 26ae726779..e24f927f37 100644
--- a/meson.build
+++ b/meson.build
@@ -35,6 +35,10 @@ configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
 
+decodetree = generator(find_program('scripts/decodetree.py'),
+                       output: 'decode-@BASENAME@.inc',
+                       arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
+
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 winmm = []
@@ -607,6 +611,7 @@ subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
+subdir('libdecnumber')
 subdir('target')
 subdir('dump')
 
@@ -724,6 +729,9 @@ foreach target : target_dirs
   if target.endswith('-softmmu')
     qemu_target_name = 'qemu-system-' + target_name
     target_type='system'
+    t = target_softmmu_arch[arch].apply(config_target, strict: false)
+    arch_srcs += t.sources()
+
     hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
     hw = hw_arch[hw_dir].apply(config_target, strict: false)
     arch_srcs += hw.sources()
@@ -744,6 +752,9 @@ foreach target : target_dirs
     )
   endif
 
+  t = target_arch[arch].apply(config_target, strict: false)
+  arch_srcs += t.sources()
+
   target_common = common_ss.apply(config_target, strict: false)
   objects = common_all.extract_objects(target_common.sources())
 
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index d8c59cab60..1ff4878cea 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1198,7 +1198,7 @@ def main():
     long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
                  'static-decode=', 'varinsnwidth=']
     try:
-        (opts, args) = getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
+        (opts, args) = getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_opts)
     except getopt.GetoptError as err:
         error(0, err)
     for o, a in opts:
diff --git a/target/alpha/Makefile.objs b/target/alpha/Makefile.objs
deleted file mode 100644
index 63664629f6..0000000000
--- a/target/alpha/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += translate.o helper.o cpu.o
-obj-y += int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
-obj-y += gdbstub.o
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
new file mode 100644
index 0000000000..1aec55abb4
--- /dev/null
+++ b/target/alpha/meson.build
@@ -0,0 +1,18 @@
+alpha_ss = ss.source_set()
+alpha_ss.add(files(
+  'cpu.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'sys_helper.c',
+  'translate.c',
+  'vax_helper.c',
+))
+
+alpha_softmmu_ss = ss.source_set()
+alpha_softmmu_ss.add(files('machine.c'))
+
+target_arch += {'alpha': alpha_ss}
+target_softmmu_arch += {'alpha': alpha_softmmu_ss}
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
deleted file mode 100644
index cf26c16f5f..0000000000
--- a/target/arm/Makefile.objs
+++ /dev/null
@@ -1,69 +0,0 @@
-obj-$(CONFIG_TCG) += arm-semi.o
-obj-y += helper.o vfp_helper.o
-obj-y += cpu.o gdbstub.o
-obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
-
-obj-$(CONFIG_SOFTMMU) += machine.o arch_dump.o monitor.o
-obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
-
-obj-$(CONFIG_KVM) += kvm.o
-obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
-obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp.inc.c: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-a32-uncond.inc.c: $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-t16.inc.c: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -w 16 --static-decode disas_t16 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-target/arm/translate.o: target/arm/decode-vfp.inc.c
-target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
-target/arm/translate.o: target/arm/decode-a32.inc.c
-target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
-target/arm/translate.o: target/arm/decode-t32.inc.c
-target/arm/translate.o: target/arm/decode-t16.inc.c
-
-obj-y += tlb_helper.o debug_helper.o
-obj-y += translate.o op_helper.o
-obj-y += crypto_helper.o
-obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
-obj-y += m_helper.o
-
-obj-$(CONFIG_SOFTMMU) += psci.o
-
-obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
-obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
-obj-$(TARGET_AARCH64) += pauth_helper.o
diff --git a/target/arm/meson.build b/target/arm/meson.build
new file mode 100644
index 0000000000..2b7d2147ea
--- /dev/null
+++ b/target/arm/meson.build
@@ -0,0 +1,57 @@
+gen = [
+  decodetree.process('sve.decode', extra_args: '--decode=disas_sve'),
+  decodetree.process('vfp.decode', extra_args: '--static-decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--static-decode=disas_vfp_uncond'),
+  decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
+  decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
+  decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
+  decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
+]
+
+arm_ss = ss.source_set()
+arm_ss.add(gen)
+arm_ss.add(files(
+  'cpu.c',
+  'crypto_helper.c',
+  'debug_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'iwmmxt_helper.c',
+  'm_helper.c',
+  'neon_helper.c',
+  'op_helper.c',
+  'tlb_helper.c',
+  'translate.c',
+  'vec_helper.c',
+  'vfp_helper.c',
+))
+arm_ss.add(zlib)
+
+arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
+
+kvm_ss = ss.source_set()
+kvm_ss.add(when: 'TARGET_AARCH64', if_true: 'kvm64.c', if_false: 'kvm32.c')
+arm_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
+arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c',
+  'helper-a64.c',
+  'pauth_helper.c',
+  'sve_helper.c',
+  'translate-a64.c',
+  'translate-sve.c',
+))
+
+arm_softmmu_ss = ss.source_set()
+arm_softmmu_ss.add(files(
+  'arch_dump.c',
+  'arm-powerctl.c',
+  'machine.c',
+  'monitor.c',
+  'psci.c',
+))
+
+target_arch += {'arm': arm_ss}
+target_softmmu_arch += {'arm': arm_softmmu_ss}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5d7edd0907..28a0127309 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -100,7 +100,7 @@ static inline int msz_dtype(DisasContext *s, int msz)
  * Include the generated decoder.
  */
 
-#include "decode-sve.inc.c"
+#include "decode-sve.inc"
 
 /*
  * Implement all of the translator functions referenced by the decoder.
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index bf90ac0e5b..623a906a50 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -27,8 +27,8 @@
  */
 
 /* Include the generated VFP decoder */
-#include "decode-vfp.inc.c"
-#include "decode-vfp-uncond.inc.c"
+#include "decode-vfp.inc"
+#include "decode-vfp-uncond.inc"
 
 /*
  * The imm8 encodes the sign bit, enough bits to represent an exponent in
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf..ada05176b1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7518,10 +7518,10 @@ static int t16_pop_list(DisasContext *s, int x)
  * Include the generated decoders.
  */
 
-#include "decode-a32.inc.c"
-#include "decode-a32-uncond.inc.c"
-#include "decode-t32.inc.c"
-#include "decode-t16.inc.c"
+#include "decode-a32.inc"
+#include "decode-a32-uncond.inc"
+#include "decode-t32.inc"
+#include "decode-t16.inc"
 
 /* Helpers to swap operands for reverse-subtract.  */
 static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
diff --git a/target/cris/Makefile.objs b/target/cris/Makefile.objs
deleted file mode 100644
index 7779227fc4..0000000000
--- a/target/cris/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += mmu.o machine.o
diff --git a/target/cris/meson.build b/target/cris/meson.build
new file mode 100644
index 0000000000..67c3793c85
--- /dev/null
+++ b/target/cris/meson.build
@@ -0,0 +1,14 @@
+cris_ss = ss.source_set()
+cris_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+cris_softmmu_ss = ss.source_set()
+cris_softmmu_ss.add(files('mmu.c', 'machine.c'))
+
+target_arch += {'cris': cris_ss}
+target_softmmu_arch += {'cris': cris_softmmu_ss}
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
deleted file mode 100644
index 174f50a96c..0000000000
--- a/target/hppa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
-obj-y += int_helper.o
-obj-$(CONFIG_SOFTMMU) += machine.o
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-target/hppa/decode.inc.c: $(SRC_PATH)/target/hppa/insns.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/hppa/translate.o: target/hppa/decode.inc.c
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
new file mode 100644
index 0000000000..8a7ff82efc
--- /dev/null
+++ b/target/hppa/meson.build
@@ -0,0 +1,19 @@
+gen = decodetree.process('insns.decode')
+
+hppa_ss = ss.source_set()
+hppa_ss.add(gen)
+hppa_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+hppa_softmmu_ss = ss.source_set()
+hppa_softmmu_ss.add(files('machine.c'))
+
+target_arch += {'hppa': hppa_ss}
+target_softmmu_arch += {'hppa': hppa_softmmu_ss}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f8d407a82..a3f3926f6c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -334,7 +334,7 @@ static int expand_shl11(DisasContext *ctx, int val)
 
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
 
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
deleted file mode 100644
index 48e0c28434..0000000000
--- a/target/i386/Makefile.objs
+++ /dev/null
@@ -1,22 +0,0 @@
-obj-y += helper.o cpu.o gdbstub.o xsave_helper.o
-obj-$(CONFIG_TCG) += translate.o
-obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
-obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-ifeq ($(CONFIG_SOFTMMU),y)
-obj-y += machine.o arch_memory_mapping.o arch_dump.o monitor.o
-obj-$(CONFIG_KVM) += kvm.o
-obj-$(CONFIG_HYPERV) += hyperv.o
-obj-$(call lnot,$(CONFIG_HYPERV)) += hyperv-stub.o
-ifeq ($(CONFIG_WIN32),y)
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
-endif
-ifeq ($(CONFIG_POSIX),y)
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
-endif
-obj-$(CONFIG_HVF) += hvf/
-obj-$(CONFIG_WHPX) += whpx-all.o
-endif
-obj-$(CONFIG_SEV) += sev.o
-obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
deleted file mode 100644
index 927b86bc67..0000000000
--- a/target/i386/hvf/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += hvf.o
-obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
new file mode 100644
index 0000000000..c8a43717ee
--- /dev/null
+++ b/target/i386/hvf/meson.build
@@ -0,0 +1,12 @@
+i386_softmmu_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+  'hvf.c',
+  'x86.c',
+  'x86_cpuid.c',
+  'x86_decode.c',
+  'x86_descr.c',
+  'x86_emu.c',
+  'x86_flags.c',
+  'x86_mmu.c',
+  'x86_task.c',
+  'x86hvf.c',
+))
diff --git a/target/i386/meson.build b/target/i386/meson.build
new file mode 100644
index 0000000000..58a70da6b3
--- /dev/null
+++ b/target/i386/meson.build
@@ -0,0 +1,41 @@
+i386_ss = ss.source_set()
+i386_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'xsave_helper.c',
+))
+i386_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'bpt_helper.c',
+  'cc_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'misc_helper.c',
+  'mpx_helper.c',
+  'seg_helper.c',
+  'smm_helper.c',
+  'svm_helper.c',
+  'translate.c',
+))
+i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+i386_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-stub.c'))
+
+i386_softmmu_ss = ss.source_set()
+i386_softmmu_ss.add(files(
+  'arch_dump.c',
+  'arch_memory_mapping.c',
+  'machine.c',
+  'monitor.c',
+))
+i386_softmmu_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
+i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
+i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files('whpx-all.c'))
+i386_softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_HAX'], if_true: files('hax-all.c', 'hax-mem.c', 'hax-posix.c'))
+i386_softmmu_ss.add(when: ['CONFIG_WIN32', 'CONFIG_HAX'], if_true: files('hax-all.c', 'hax-mem.c', 'hax-windows.c'))
+
+subdir('hvf')
+
+target_arch += {'i386': i386_ss}
+target_softmmu_arch += {'i386': i386_softmmu_ss}
diff --git a/target/lm32/Makefile.objs b/target/lm32/Makefile.objs
deleted file mode 100644
index c3e1bd6bd6..0000000000
--- a/target/lm32/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-y += lm32-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/lm32/meson.build b/target/lm32/meson.build
new file mode 100644
index 0000000000..ef0eef07f1
--- /dev/null
+++ b/target/lm32/meson.build
@@ -0,0 +1,15 @@
+lm32_ss = ss.source_set()
+lm32_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'lm32-semi.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+lm32_softmmu_ss = ss.source_set()
+lm32_softmmu_ss.add(files('machine.c'))
+
+target_arch += {'lm32': lm32_ss}
+target_softmmu_arch += {'lm32': lm32_softmmu_ss}
diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
deleted file mode 100644
index ac61948676..0000000000
--- a/target/m68k/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y += m68k-semi.o
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += fpu_helper.o softfloat.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
diff --git a/target/m68k/meson.build b/target/m68k/meson.build
new file mode 100644
index 0000000000..05cd9fbd1e
--- /dev/null
+++ b/target/m68k/meson.build
@@ -0,0 +1,17 @@
+m68k_ss = ss.source_set()
+m68k_ss.add(files(
+  'cpu.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'm68k-semi.c',
+  'op_helper.c',
+  'softfloat.c',
+  'translate.c',
+))
+
+m68k_softmmu_ss = ss.source_set()
+m68k_softmmu_ss.add(files('monitor.c'))
+
+target_arch += {'m68k': m68k_ss}
+target_softmmu_arch += {'m68k': m68k_softmmu_ss}
diff --git a/target/meson.build b/target/meson.build
index e29dd3e01f..d98d276459 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -1 +1,21 @@
+subdir('alpha')
+subdir('arm')
+subdir('cris')
+subdir('hppa')
+subdir('i386')
+subdir('lm32')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips')
+subdir('moxie')
+subdir('nios2')
+subdir('openrisc')
+subdir('ppc')
+subdir('riscv')
 subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('tilegx')
+subdir('tricore')
+subdir('unicore32')
+subdir('xtensa')
diff --git a/target/microblaze/Makefile.objs b/target/microblaze/Makefile.objs
deleted file mode 100644
index f3d7b44c89..0000000000
--- a/target/microblaze/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += mmu.o
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
new file mode 100644
index 0000000000..b8fe4afe61
--- /dev/null
+++ b/target/microblaze/meson.build
@@ -0,0 +1,14 @@
+microblaze_ss = ss.source_set()
+microblaze_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+microblaze_softmmu_ss = ss.source_set()
+microblaze_softmmu_ss.add(files('mmu.c'))
+
+target_arch += {'microblaze': microblaze_ss}
+target_softmmu_arch += {'microblaze': microblaze_softmmu_ss}
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
deleted file mode 100644
index 3448ad5e19..0000000000
--- a/target/mips/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
-obj-y += gdbstub.o msa_helper.o
-obj-$(CONFIG_SOFTMMU) += mips-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
-obj-$(CONFIG_KVM) += kvm.o
diff --git a/target/mips/meson.build b/target/mips/meson.build
new file mode 100644
index 0000000000..ad35f00bc6
--- /dev/null
+++ b/target/mips/meson.build
@@ -0,0 +1,22 @@
+mips_ss = ss.source_set()
+mips_ss.add(files(
+  'cpu.c',
+  'dsp_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'lmi_helper.c',
+  'msa_helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+mips_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
+
+mips_softmmu_ss = ss.source_set()
+mips_softmmu_ss.add(files(
+  'cp0_timer.c',
+  'machine.c',
+  'mips-semi.c',
+))
+
+target_arch += {'mips': mips_ss}
+target_softmmu_arch += {'mips': mips_softmmu_ss}
diff --git a/target/moxie/Makefile.objs b/target/moxie/Makefile.objs
deleted file mode 100644
index 6381d4d636..0000000000
--- a/target/moxie/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += translate.o helper.o machine.o cpu.o machine.o
-obj-$(CONFIG_SOFTMMU) += mmu.o
diff --git a/target/moxie/meson.build b/target/moxie/meson.build
new file mode 100644
index 0000000000..b4beb528cc
--- /dev/null
+++ b/target/moxie/meson.build
@@ -0,0 +1,14 @@
+moxie_ss = ss.source_set()
+moxie_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'machine.c',
+  'machine.c',
+  'translate.c',
+))
+
+moxie_softmmu_ss = ss.source_set()
+moxie_softmmu_ss.add(files('mmu.c'))
+
+target_arch += {'moxie': moxie_ss}
+target_softmmu_arch += {'moxie': moxie_softmmu_ss}
diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
deleted file mode 100644
index 010de0e7a6..0000000000
--- a/target/nios2/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o mmu.o nios2-semi.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
-
-$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
diff --git a/target/nios2/meson.build b/target/nios2/meson.build
new file mode 100644
index 0000000000..e643917db1
--- /dev/null
+++ b/target/nios2/meson.build
@@ -0,0 +1,15 @@
+nios2_ss = ss.source_set()
+nios2_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'mmu.c',
+  'nios2-semi.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+nios2_softmmu_ss = ss.source_set()
+nios2_softmmu_ss.add(files('monitor.c'))
+
+target_arch += {'nios2': nios2_ss}
+target_softmmu_arch += {'nios2': nios2_softmmu_ss}
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
deleted file mode 100644
index b5432f4684..0000000000
--- a/target/openrisc/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += cpu.o exception.o interrupt.o mmu.o translate.o disas.o
-obj-y += exception_helper.o fpu_helper.o \
-         interrupt_helper.o sys_helper.o
-obj-y += gdbstub.o
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-target/openrisc/decode.inc.c: \
-  $(SRC_PATH)/target/openrisc/insns.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/openrisc/translate.o: target/openrisc/decode.inc.c
-target/openrisc/disas.o: target/openrisc/decode.inc.c
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index ce112640b9..d5e0a4396c 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -25,7 +25,7 @@
 typedef disassemble_info DisasContext;
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
 
 #define output(mnemonic, format, ...) \
     (info->fprintf_func(info->stream, "%-9s " format, \
diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
new file mode 100644
index 0000000000..9774a58306
--- /dev/null
+++ b/target/openrisc/meson.build
@@ -0,0 +1,23 @@
+gen = decodetree.process('insns.decode')
+
+openrisc_ss = ss.source_set()
+openrisc_ss.add(gen)
+openrisc_ss.add(files(
+  'cpu.c',
+  'disas.c',
+  'exception.c',
+  'exception_helper.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'interrupt.c',
+  'interrupt_helper.c',
+  'mmu.c',
+  'sys_helper.c',
+  'translate.c',
+))
+
+openrisc_softmmu_ss = ss.source_set()
+openrisc_softmmu_ss.add(files('machine.c'))
+
+target_arch += {'openrisc': openrisc_ss}
+target_softmmu_arch += {'openrisc': openrisc_softmmu_ss}
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 8dd28d6cf1..26d9bb7e3c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -65,7 +65,7 @@ static inline bool is_user(DisasContext *dc)
 }
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
 
 static TCGv cpu_sr;
 static TCGv cpu_regs[32];
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
deleted file mode 100644
index e8fa18ce13..0000000000
--- a/target/ppc/Makefile.objs
+++ /dev/null
@@ -1,20 +0,0 @@
-obj-y += cpu-models.o
-obj-y += cpu.o
-obj-y += translate.o
-ifeq ($(CONFIG_SOFTMMU),y)
-obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
-obj-$(TARGET_PPC64) += mmu-hash64.o mmu-book3s-v3.o compat.o
-obj-$(TARGET_PPC64) += mmu-radix64.o
-endif
-obj-$(CONFIG_KVM) += kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-y += dfp_helper.o
-obj-y += excp_helper.o
-obj-y += fpu_helper.o
-obj-y += int_helper.o
-obj-y += timebase_helper.o
-obj-y += misc_helper.o
-obj-y += mem_helper.o
-obj-y += ../../libdecnumber/
-obj-$(CONFIG_USER_ONLY) += user_only_helper.o
-obj-y += gdbstub.o
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
new file mode 100644
index 0000000000..bbfef90e08
--- /dev/null
+++ b/target/ppc/meson.build
@@ -0,0 +1,37 @@
+ppc_ss = ss.source_set()
+ppc_ss.add(files(
+  'cpu-models.c',
+  'cpu.c',
+  'dfp_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'misc_helper.c',
+  'timebase_helper.c',
+  'translate.c',
+))
+
+ppc_ss.add(libdecnumber)
+
+ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
+
+ppc_softmmu_ss = ss.source_set()
+ppc_softmmu_ss.add(files(
+  'arch_dump.c',
+  'machine.c',
+  'mmu-hash32.c',
+  'mmu_helper.c',
+  'monitor.c',
+))
+ppc_softmmu_ss.add(when: 'TARGET_PPC64', if_true: files(
+  'compat.c',
+  'mmu-book3s-v3.c',
+  'mmu-hash64.c',
+  'mmu-radix64.c',
+))
+
+target_arch += {'ppc': ppc_ss}
+target_softmmu_arch += {'ppc': ppc_softmmu_ss}
diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
deleted file mode 100644
index ff651f69f6..0000000000
--- a/target/riscv/Makefile.objs
+++ /dev/null
@@ -1,28 +0,0 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
-obj-$(CONFIG_SOFTMMU) += pmp.o
-
-ifeq ($(CONFIG_SOFTMMU),y)
-obj-y += monitor.o
-endif
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
-decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
-
-decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
-decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
-decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
-
-target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
-	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
-          $(decode32-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
-	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
-          --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
-	target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
new file mode 100644
index 0000000000..219dd744c1
--- /dev/null
+++ b/target/riscv/meson.build
@@ -0,0 +1,33 @@
+# FIXME extra_args should accept files()
+dir = meson.current_source_dir()
+gen32 = [
+  decodetree.process('insn16.decode', extra_args: [dir / 'insn16-32.decode', '--static-decode=decode_insn16', '--insnwidth=16']),
+  decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
+]
+
+gen64 = [
+  decodetree.process('insn16.decode', extra_args: [dir / 'insn16-64.decode', '--static-decode=decode_insn16', '--insnwidth=16']),
+  decodetree.process('insn32.decode', extra_args: [dir / 'insn32-64.decode', '--static-decode=decode_insn32']),
+]
+
+riscv_ss = ss.source_set()
+riscv_ss.add(when: 'TARGET_RISCV32', if_true: gen32)
+riscv_ss.add(when: 'TARGET_RISCV64', if_true: gen64)
+riscv_ss.add(files(
+  'cpu.c',
+  'cpu_helper.c',
+  'csr.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+riscv_softmmu_ss = ss.source_set()
+riscv_softmmu_ss.add(files(
+  'pmp.c',
+  'monitor.c'
+))
+
+target_arch += {'riscv': riscv_ss}
+target_softmmu_arch += {'riscv': riscv_softmmu_ss}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab6a891dc3..dbba004133 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -564,7 +564,7 @@ static int ex_rvc_shifti(DisasContext *ctx, int imm)
 }
 
 /* Include the auto-generated decoder for 32 bit insn */
-#include "decode_insn32.inc.c"
+#include "decode-insn32.inc"
 
 static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
                              void (*func)(TCGv, TCGv, target_long))
@@ -707,7 +707,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_privileged.inc.c"
 
 /* Include the auto-generated decoder for 16 bit insn */
-#include "decode_insn16.inc.c"
+#include "decode-insn16.inc"
 
 static void decode_opc(DisasContext *ctx)
 {
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
deleted file mode 100644
index 9b9accc5fd..0000000000
--- a/target/s390x/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
-obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o crypto_helper.o
-obj-$(CONFIG_TCG) += vec_helper.o vec_int_helper.o vec_string_helper.o
-obj-$(CONFIG_TCG) += vec_fpu_helper.o
-obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
-obj-$(CONFIG_SOFTMMU) += sigp.o
-obj-$(CONFIG_KVM) += kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 980f67cc85..4757e58133 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -1,3 +1,30 @@
+s390x_ss = ss.source_set()
+s390x_ss.add(files(
+  'cpu.c',
+  'cpu_features.c',
+  'cpu_models.c',
+  'gdbstub.c',
+  'helper.c',
+  'interrupt.c',
+))
+
+s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cc_helper.c',
+  'crypto_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'misc_helper.c',
+  'translate.c',
+  'vec_fpu_helper.c',
+  'vec_helper.c',
+  'vec_int_helper.c',
+  'vec_string_helper.c',
+), if_false: 'tcg-stub.c')
+
+s390x_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+
 gen_features = executable('gen-features', 'gen-features.c', native: true)
 
 gen_features_h = custom_target('gen-features.h',
@@ -5,4 +32,17 @@ gen_features_h = custom_target('gen-features.h',
                                capture: true,
                                command: gen_features)
 
-specific_ss.add(gen_features_h)
+s390x_ss.add(gen_features_h)
+
+s390x_softmmu_ss = ss.source_set()
+s390x_softmmu_ss.add(files(
+  'arch_dump.c',
+  'diag.c',
+  'ioinst.c',
+  'machine.c',
+  'mmu_helper.c',
+  'sigp.c',
+))
+
+target_arch += {'s390x': s390x_ss}
+target_softmmu_arch += {'s390x': s390x_softmmu_ss}
diff --git a/target/sh4/Makefile.objs b/target/sh4/Makefile.objs
deleted file mode 100644
index 2c25d96e65..0000000000
--- a/target/sh4/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
-obj-y += gdbstub.o
diff --git a/target/sh4/meson.build b/target/sh4/meson.build
new file mode 100644
index 0000000000..56a57576da
--- /dev/null
+++ b/target/sh4/meson.build
@@ -0,0 +1,14 @@
+sh4_ss = ss.source_set()
+sh4_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+sh4_softmmu_ss = ss.source_set()
+sh4_softmmu_ss.add(files('monitor.c'))
+
+target_arch += {'sh4': sh4_ss}
+target_softmmu_arch += {'sh4': sh4_softmmu_ss}
diff --git a/target/sparc/Makefile.objs b/target/sparc/Makefile.objs
deleted file mode 100644
index ec905698c5..0000000000
--- a/target/sparc/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-obj-$(CONFIG_SOFTMMU) += machine.o monitor.o
-obj-y += translate.o helper.o cpu.o
-obj-y += fop_helper.o cc_helper.o win_helper.o mmu_helper.o ldst_helper.o
-obj-$(TARGET_SPARC) += int32_helper.o
-obj-$(TARGET_SPARC64) += int64_helper.o
-obj-$(TARGET_SPARC64) += vis_helper.o
-obj-y += gdbstub.o
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
new file mode 100644
index 0000000000..a3638b9503
--- /dev/null
+++ b/target/sparc/meson.build
@@ -0,0 +1,23 @@
+sparc_ss = ss.source_set()
+sparc_ss.add(files(
+  'cc_helper.c',
+  'cpu.c',
+  'fop_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'ldst_helper.c',
+  'mmu_helper.c',
+  'translate.c',
+  'win_helper.c',
+))
+sparc_ss.add(when: 'TARGET_SPARC', if_true: files('int32_helper.c'))
+sparc_ss.add(when: 'TARGET_SPARC64', if_true: files('int64_helper.c', 'vis_helper.c'))
+
+sparc_softmmu_ss = ss.source_set()
+sparc_softmmu_ss.add(files(
+  'machine.c',
+  'monitor.c',
+))
+
+target_arch += {'sparc': sparc_ss}
+target_softmmu_arch += {'sparc': sparc_softmmu_ss}
diff --git a/target/tilegx/Makefile.objs b/target/tilegx/Makefile.objs
deleted file mode 100644
index 0db778f407..0000000000
--- a/target/tilegx/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += cpu.o translate.o helper.o simd_helper.o
diff --git a/target/tilegx/meson.build b/target/tilegx/meson.build
new file mode 100644
index 0000000000..678590439c
--- /dev/null
+++ b/target/tilegx/meson.build
@@ -0,0 +1,13 @@
+tilegx_ss = ss.source_set()
+tilegx_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'simd_helper.c',
+  'translate.c',
+))
+tilegx_ss.add(zlib)
+
+tilegx_softmmu_ss = ss.source_set()
+
+target_arch += {'tilegx': tilegx_ss}
+target_softmmu_arch += {'tilegx': tilegx_softmmu_ss}
diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
deleted file mode 100644
index 7a05670718..0000000000
--- a/target/tricore/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
new file mode 100644
index 0000000000..d7db4464f8
--- /dev/null
+++ b/target/tricore/meson.build
@@ -0,0 +1,14 @@
+tricore_ss = ss.source_set()
+tricore_ss.add(files(
+  'cpu.c',
+  'fpu_helper.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+tricore_ss.add(zlib)
+
+tricore_softmmu_ss = ss.source_set()
+
+target_arch += {'tricore': tricore_ss}
+target_softmmu_arch += {'tricore': tricore_softmmu_ss}
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
deleted file mode 100644
index 35d8bf530d..0000000000
--- a/target/unicore32/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += ucf64_helper.o
-
-obj-$(CONFIG_SOFTMMU) += softmmu.o
-
-# Huh? Uses curses directly instead of using ui/console.h interfaces ...
-helper.o-cflags := $(CURSES_CFLAGS)
-helper.o-libs := $(CURSES_LIBS)
diff --git a/target/unicore32/meson.build b/target/unicore32/meson.build
new file mode 100644
index 0000000000..0fa78772eb
--- /dev/null
+++ b/target/unicore32/meson.build
@@ -0,0 +1,14 @@
+unicore32_ss = ss.source_set()
+unicore32_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+  'ucf64_helper.c',
+), curses)
+
+unicore32_softmmu_ss = ss.source_set()
+unicore32_softmmu_ss.add(files('softmmu.c'))
+
+target_arch += {'unicore32': unicore32_ss}
+target_softmmu_arch += {'unicore32': unicore32_softmmu_ss}
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
deleted file mode 100644
index c7e7fe6063..0000000000
--- a/target/xtensa/Makefile.objs
+++ /dev/null
@@ -1,16 +0,0 @@
-obj-y += core-dc232b.o
-obj-y += core-dc233c.o
-obj-y += core-de212.o
-obj-y += core-fsf.o
-obj-y += core-sample_controller.o
-obj-y += core-test_kc705_be.o
-obj-y += core-test_mmuhifi_c3.o
-obj-$(CONFIG_SOFTMMU) += monitor.o xtensa-semi.o
-obj-y += xtensa-isa.o
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) += dbg_helper.o
-obj-y += exc_helper.o
-obj-y += fpu_helper.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += mmu_helper.o
-obj-y += win_helper.o
diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
new file mode 100644
index 0000000000..27e453e1d1
--- /dev/null
+++ b/target/xtensa/meson.build
@@ -0,0 +1,30 @@
+xtensa_ss = ss.source_set()
+xtensa_ss.add(files(
+  'core-dc232b.c',
+  'core-dc233c.c',
+  'core-de212.c',
+  'core-fsf.c',
+  'core-sample_controller.c',
+  'core-test_kc705_be.c',
+  'core-test_mmuhifi_c3.c',
+  'cpu.c',
+  'exc_helper.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+  'win_helper.c',
+  'xtensa-isa.c',
+))
+
+xtensa_softmmu_ss = ss.source_set()
+xtensa_softmmu_ss.add(files(
+  'dbg_helper.c',
+  'mmu_helper.c',
+  'monitor.c',
+  'xtensa-semi.c',
+))
+
+target_arch += {'xtensa': xtensa_ss}
+target_softmmu_arch += {'xtensa': xtensa_softmmu_ss}
-- 
2.21.0



