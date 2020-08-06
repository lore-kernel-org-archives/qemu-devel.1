Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194FA221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0aGN5pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194FA221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mCM-0001F4-5s
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRA-0002sg-2s
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR3-0006sz-Mr
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8k1yyHLHio6bRxrqOQUYtKRyOC7nrPHIGwXSc8gOtw=;
 b=D0aGN5paPsLoIffo53TJ8uyx0IN2fS0zDKiu4RvKfKq4hw60G0B63vEmJkO7NbuckwodWv
 RUxYtMr+60+I0LbzdgGKOY5LW5S9Gx2MAPfxwXRcr2d/vm2CeCNdudBG9RDJtUc6ZJnUvr
 V6UmAvqAOad7OeiZ6pTYij1/QPCR9+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-SYYpCOXuMNKCkrqC4jwnHQ-1; Thu, 06 Aug 2020 15:20:10 -0400
X-MC-Unique: SYYpCOXuMNKCkrqC4jwnHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9722A80183C
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:09 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B075D6179B;
 Thu,  6 Aug 2020 19:20:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 124/143] meson: target
Date: Thu,  6 Aug 2020 21:16:00 +0200
Message-Id: <1596741379-12902-125-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                 |  3 +-
 libdecnumber/Makefile.objs      |  5 ---
 libdecnumber/meson.build        |  7 ++++
 meson.build                     | 11 +++++
 scripts/decodetree.py           |  2 +-
 target/alpha/Makefile.objs      |  4 --
 target/alpha/meson.build        | 18 +++++++++
 target/arm/Makefile.objs        | 89 -----------------------------------------
 target/arm/meson.build          | 62 ++++++++++++++++++++++++++++
 target/avr/Makefile.objs        | 34 ----------------
 target/avr/disas.c              |  2 +-
 target/avr/meson.build          | 20 +++++++++
 target/avr/translate.c          |  2 +-
 target/cris/Makefile.objs       |  3 --
 target/cris/meson.build         | 14 +++++++
 target/hppa/Makefile.objs       | 11 -----
 target/hppa/meson.build         | 19 +++++++++
 target/hppa/translate.c         |  2 +-
 target/i386/Makefile.objs       | 23 -----------
 target/i386/hvf/Makefile.objs   |  2 -
 target/i386/hvf/meson.build     | 12 ++++++
 target/i386/meson.build         | 40 ++++++++++++++++++
 target/lm32/Makefile.objs       |  4 --
 target/lm32/meson.build         | 15 +++++++
 target/m68k/Makefile.objs       |  5 ---
 target/m68k/meson.build         | 17 ++++++++
 target/meson.build              | 22 ++++++++++
 target/microblaze/Makefile.objs |  3 --
 target/microblaze/meson.build   | 14 +++++++
 target/mips/Makefile.objs       |  6 ---
 target/mips/meson.build         | 24 +++++++++++
 target/moxie/Makefile.objs      |  2 -
 target/moxie/meson.build        | 14 +++++++
 target/nios2/Makefile.objs      |  4 --
 target/nios2/meson.build        | 15 +++++++
 target/openrisc/Makefile.objs   | 15 -------
 target/openrisc/disas.c         |  2 +-
 target/openrisc/meson.build     | 23 +++++++++++
 target/openrisc/translate.c     |  2 +-
 target/ppc/Makefile.objs        | 20 ---------
 target/ppc/meson.build          | 37 +++++++++++++++++
 target/riscv/Makefile.objs      | 28 -------------
 target/riscv/meson.build        | 34 ++++++++++++++++
 target/riscv/translate.c        |  4 +-
 target/rx/Makefile.objs         | 11 -----
 target/rx/disas.c               |  2 +-
 target/rx/meson.build           | 16 ++++++++
 target/rx/translate.c           |  2 +-
 target/s390x/Makefile.objs      | 10 -----
 target/s390x/meson.build        | 42 ++++++++++++++++++-
 target/sh4/Makefile.objs        |  3 --
 target/sh4/meson.build          | 14 +++++++
 target/sparc/Makefile.objs      |  7 ----
 target/sparc/meson.build        | 23 +++++++++++
 target/tilegx/Makefile.objs     |  1 -
 target/tilegx/meson.build       | 13 ++++++
 target/tricore/Makefile.objs    |  1 -
 target/tricore/meson.build      | 15 +++++++
 target/unicore32/Makefile.objs  |  8 ----
 target/unicore32/meson.build    | 14 +++++++
 target/xtensa/Makefile.objs     | 16 --------
 target/xtensa/meson.build       | 30 ++++++++++++++
 62 files changed, 595 insertions(+), 328 deletions(-)
 delete mode 100644 libdecnumber/Makefile.objs
 create mode 100644 libdecnumber/meson.build
 delete mode 100644 target/alpha/Makefile.objs
 create mode 100644 target/alpha/meson.build
 delete mode 100644 target/arm/Makefile.objs
 create mode 100644 target/arm/meson.build
 delete mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/meson.build
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
 delete mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/meson.build
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

diff --git a/Makefile.target b/Makefile.target
index 28cefba..1ab8773 100644
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
@@ -168,7 +167,7 @@ LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOM
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS := $(LIBS) $(VIRGL_LIBS)
+LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
 
diff --git a/libdecnumber/Makefile.objs b/libdecnumber/Makefile.objs
deleted file mode 100644
index d81db04..0000000
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
index 0000000..4d04139
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
index 03d9876..3e51340 100644
--- a/meson.build
+++ b/meson.build
@@ -623,10 +623,15 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+decodetree = generator(find_program('scripts/decodetree.py'),
+                       output: 'decode-@BASENAME@.inc',
+                       arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
+
 subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
+subdir('libdecnumber')
 subdir('target')
 subdir('dump')
 
@@ -760,6 +765,9 @@ foreach target : target_dirs
   if target.endswith('-softmmu')
     qemu_target_name = 'qemu-system-' + target_name
     target_type='system'
+    t = target_softmmu_arch[arch].apply(config_target, strict: false)
+    arch_srcs += t.sources()
+
     hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
     hw = hw_arch[hw_dir].apply(config_target, strict: false)
     arch_srcs += hw.sources()
@@ -780,6 +788,9 @@ foreach target : target_dirs
     )
   endif
 
+  t = target_arch[arch].apply(config_target, strict: false)
+  arch_srcs += t.sources()
+
   target_common = common_ss.apply(config_target, strict: false)
   objects = common_all.extract_objects(target_common.sources())
 
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 694757b..4cd1e10 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1257,7 +1257,7 @@ def main():
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
index 6366462..0000000
--- a/target/alpha/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += translate.o helper.o cpu.o
-obj-y += int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
-obj-y += gdbstub.o
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
new file mode 100644
index 0000000..1aec55a
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
index 4a177ad..0000000
--- a/target/arm/Makefile.objs
+++ /dev/null
@@ -1,89 +0,0 @@
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
-target/arm/decode-sve.inc: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-neon-shared.inc: $(SRC_PATH)/target/arm/neon-shared.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_shared -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-neon-dp.inc: $(SRC_PATH)/target/arm/neon-dp.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_dp -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-neon-ls.inc: $(SRC_PATH)/target/arm/neon-ls.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_ls -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp.inc: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp-uncond.inc: $(SRC_PATH)/target/arm/vfp-uncond.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-a32.inc: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-a32-uncond.inc: $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-t32.inc: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-t16.inc: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -w 16 --static-decode disas_t16 -o $@ $<,\
-	  "GEN", $(TARGET_DIR)$@)
-
-target/arm/translate-sve.o: target/arm/decode-sve.inc
-target/arm/translate.o: target/arm/decode-neon-shared.inc
-target/arm/translate.o: target/arm/decode-neon-dp.inc
-target/arm/translate.o: target/arm/decode-neon-ls.inc
-target/arm/translate.o: target/arm/decode-vfp.inc
-target/arm/translate.o: target/arm/decode-vfp-uncond.inc
-target/arm/translate.o: target/arm/decode-a32.inc
-target/arm/translate.o: target/arm/decode-a32-uncond.inc
-target/arm/translate.o: target/arm/decode-t32.inc
-target/arm/translate.o: target/arm/decode-t16.inc
-
-obj-y += tlb_helper.o debug_helper.o
-obj-y += translate.o op_helper.o
-obj-y += crypto_helper.o
-obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
-obj-y += m_helper.o
-obj-y += cpu_tcg.o
-
-obj-$(CONFIG_SOFTMMU) += psci.o
-
-obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
-obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
-obj-$(TARGET_AARCH64) += pauth_helper.o
-obj-$(TARGET_AARCH64) += mte_helper.o
diff --git a/target/arm/meson.build b/target/arm/meson.build
new file mode 100644
index 0000000..056223a
--- /dev/null
+++ b/target/arm/meson.build
@@ -0,0 +1,62 @@
+gen = [
+  decodetree.process('sve.decode', extra_args: '--decode=disas_sve'),
+  decodetree.process('neon-shared.decode', extra_args: '--static-decode=disas_neon_shared'),
+  decodetree.process('neon-dp.decode', extra_args: '--static-decode=disas_neon_dp'),
+  decodetree.process('neon-ls.decode', extra_args: '--static-decode=disas_neon_ls'),
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
+  'cpu_tcg.c',
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
+  'mte_helper.c',
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
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
deleted file mode 100644
index 81d9bcd..0000000
--- a/target/avr/Makefile.objs
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-#  QEMU AVR
-#
-#  Copyright (c) 2016-2020 Michael Rolnik
-#
-#  This library is free software; you can redistribute it and/or
-#  modify it under the terms of the GNU Lesser General Public
-#  License as published by the Free Software Foundation; either
-#  version 2.1 of the License, or (at your option) any later version.
-#
-#  This library is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  Lesser General Public License for more details.
-#
-#  You should have received a copy of the GNU Lesser General Public
-#  License along with this library; if not, see
-#  <http://www.gnu.org/licenses/lgpl-2.1.html>
-#
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-decode-y = $(SRC_PATH)/target/avr/insn.decode
-
-target/avr/decode_insn.inc: $(decode-y) $(DECODETREE)
-	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
-	  "GEN", $(TARGET_DIR)$@)
-
-target/avr/translate.o: target/avr/decode_insn.inc
-
-obj-y += translate.o cpu.o helper.o
-obj-y += gdbstub.o
-obj-y += disas.o
-obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/avr/disas.c b/target/avr/disas.c
index c45ab2c..5e20cbb 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -60,7 +60,7 @@ static int append_16(DisasContext *ctx, int x)
 
 /* Include the auto-generated decoder.  */
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
-#include "decode_insn.inc"
+#include "decode-insn.inc"
 
 #define output(mnemonic, format, ...) \
     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
diff --git a/target/avr/meson.build b/target/avr/meson.build
new file mode 100644
index 0000000..7e8e29c
--- /dev/null
+++ b/target/avr/meson.build
@@ -0,0 +1,20 @@
+gen = [
+  decodetree.process('insn.decode', extra_args: [ '--decode', 'decode_insn',
+                                                  '--insnwidth', '16' ])
+]
+
+avr_ss = ss.source_set()
+avr_softmmu_ss = ss.source_set()
+
+avr_ss.add(gen)
+avr_ss.add(files(
+  'translate.c',
+  'helper.c',
+  'cpu.c',
+  'gdbstub.c',
+  'disas.c'))
+
+avr_softmmu_ss.add(files('machine.c'))
+
+target_arch += {'avr': avr_ss}
+target_softmmu_arch += {'avr': avr_softmmu_ss}
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 8deb126..ad5706a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -198,7 +198,7 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
 }
 
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
-#include "decode_insn.inc"
+#include "decode-insn.inc"
 
 /*
  * Arithmetic Instructions
diff --git a/target/cris/Makefile.objs b/target/cris/Makefile.objs
deleted file mode 100644
index 7779227..0000000
--- a/target/cris/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += mmu.o machine.o
diff --git a/target/cris/meson.build b/target/cris/meson.build
new file mode 100644
index 0000000..67c3793
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
index 40dcb86..0000000
--- a/target/hppa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
-obj-y += int_helper.o
-obj-$(CONFIG_SOFTMMU) += machine.o
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-target/hppa/decode.inc: $(SRC_PATH)/target/hppa/insns.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/hppa/translate.o: target/hppa/decode.inc
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
new file mode 100644
index 0000000..8a7ff82
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
index 31e2926..4869999 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -334,7 +334,7 @@ static int expand_shl11(DisasContext *ctx, int val)
 
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc"
+#include "decode-insns.inc"
 
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
deleted file mode 100644
index 0b93143..0000000
--- a/target/i386/Makefile.objs
+++ /dev/null
@@ -1,23 +0,0 @@
-obj-y += helper.o cpu.o gdbstub.o xsave_helper.o
-obj-$(CONFIG_TCG) += translate.o
-obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
-obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
-obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
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
index 927b86b..0000000
--- a/target/i386/hvf/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += hvf.o
-obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
new file mode 100644
index 0000000..c8a4371
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
index 0000000..e0b71ad
--- /dev/null
+++ b/target/i386/meson.build
@@ -0,0 +1,40 @@
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
+  'translate.c'), if_false: files('tcg-stub.c'))
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
index c3e1bd6..0000000
--- a/target/lm32/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-y += lm32-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/lm32/meson.build b/target/lm32/meson.build
new file mode 100644
index 0000000..ef0eef0
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
index ac61948..0000000
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
index 0000000..05cd9fb
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
index e29dd3e..9f0ae93 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -1 +1,23 @@
+subdir('alpha')
+subdir('arm')
+subdir('avr')
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
+subdir('rx')
 subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('tilegx')
+subdir('tricore')
+subdir('unicore32')
+subdir('xtensa')
diff --git a/target/microblaze/Makefile.objs b/target/microblaze/Makefile.objs
deleted file mode 100644
index f3d7b44..0000000
--- a/target/microblaze/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-$(CONFIG_SOFTMMU) += mmu.o
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
new file mode 100644
index 0000000..b8fe4af
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
index b820b3b..0000000
--- a/target/mips/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-y += translate.o cpu.o gdbstub.o helper.o
-obj-y += op_helper.o cp0_helper.o fpu_helper.o
-obj-y += dsp_helper.o lmmi_helper.o msa_helper.o
-obj-$(CONFIG_SOFTMMU) += mips-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
-obj-$(CONFIG_KVM) += kvm.o
diff --git a/target/mips/meson.build b/target/mips/meson.build
new file mode 100644
index 0000000..fa1f024
--- /dev/null
+++ b/target/mips/meson.build
@@ -0,0 +1,24 @@
+mips_ss = ss.source_set()
+mips_ss.add(files(
+  'cp0_helper.c',
+  'cpu.c',
+  'dsp_helper.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'helper.c',
+  'lmmi_helper.c',
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
index 6381d4d..0000000
--- a/target/moxie/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += translate.o helper.o machine.o cpu.o machine.o
-obj-$(CONFIG_SOFTMMU) += mmu.o
diff --git a/target/moxie/meson.build b/target/moxie/meson.build
new file mode 100644
index 0000000..b4beb52
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
index 010de0e..0000000
--- a/target/nios2/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o mmu.o nios2-semi.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
-
-$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
diff --git a/target/nios2/meson.build b/target/nios2/meson.build
new file mode 100644
index 0000000..e643917
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
index 0f2fcff..0000000
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
-target/openrisc/decode.inc: \
-  $(SRC_PATH)/target/openrisc/insns.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/openrisc/translate.o: target/openrisc/decode.inc
-target/openrisc/disas.o: target/openrisc/decode.inc
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 3f75316..d5e0a43 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -25,7 +25,7 @@
 typedef disassemble_info DisasContext;
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc"
+#include "decode-insns.inc"
 
 #define output(mnemonic, format, ...) \
     (info->fprintf_func(info->stream, "%-9s " format, \
diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
new file mode 100644
index 0000000..9774a58
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
index a119be2..ffd268d 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -65,7 +65,7 @@ static inline bool is_user(DisasContext *dc)
 }
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc"
+#include "decode-insns.inc"
 
 static TCGv cpu_sr;
 static TCGv cpu_regs[32];
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
deleted file mode 100644
index e8fa18c..0000000
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
index 0000000..bbfef90
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
index 1a66d8a..0000000
--- a/target/riscv/Makefile.objs
+++ /dev/null
@@ -1,28 +0,0 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o
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
-target/riscv/decode_insn32.inc: $(decode32-y) $(DECODETREE)
-	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
-          $(decode32-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/decode_insn16.inc: $(decode16-y) $(DECODETREE)
-	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
-          --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/translate.o: target/riscv/decode_insn32.inc \
-	target/riscv/decode_insn16.inc
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
new file mode 100644
index 0000000..abd647f
--- /dev/null
+++ b/target/riscv/meson.build
@@ -0,0 +1,34 @@
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
+  'vector_helper.c',
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
index aa7f56d..9be49c4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -583,7 +583,7 @@ static int ex_rvc_shifti(DisasContext *ctx, int imm)
 }
 
 /* Include the auto-generated decoder for 32 bit insn */
-#include "decode_insn32.inc"
+#include "decode-insn32.inc"
 
 static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
                              void (*func)(TCGv, TCGv, target_long))
@@ -728,7 +728,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_privileged.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
-#include "decode_insn16.inc"
+#include "decode-insn16.inc"
 
 static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
deleted file mode 100644
index eddc62a..0000000
--- a/target/rx/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
-
-DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-
-target/rx/decode.inc: \
-  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
-	$(call quiet-command,\
-	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/rx/translate.o: target/rx/decode.inc
-target/rx/disas.o: target/rx/decode.inc
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 6450892..6584509 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -100,7 +100,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 }
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc"
+#include "decode-insns.inc"
 
 static void dump_bytes(DisasContext *ctx)
 {
diff --git a/target/rx/meson.build b/target/rx/meson.build
new file mode 100644
index 0000000..8de0ad4
--- /dev/null
+++ b/target/rx/meson.build
@@ -0,0 +1,16 @@
+gen = [
+  decodetree.process('insns.decode', extra_args: [ '--varinsnwidth', '32' ])
+]
+
+rx_ss = ss.source_set()
+rx_ss.add(gen)
+rx_ss.add(files(
+  'translate.c',
+  'op_helper.c',
+  'helper.c',
+  'cpu.c',
+  'gdbstub.c',
+  'disas.c'))
+
+target_arch += {'rx': rx_ss}
+target_softmmu_arch += {'rx': ss.source_set()}
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 272619c..d688c9d 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -124,7 +124,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 }
 
 /* Include the auto-generated decoder. */
-#include "decode.inc"
+#include "decode-insns.inc"
 
 void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
deleted file mode 100644
index 9b9accc..0000000
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
index 980f67c..4757e58 100644
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
index 2c25d96..0000000
--- a/target/sh4/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
-obj-y += gdbstub.o
diff --git a/target/sh4/meson.build b/target/sh4/meson.build
new file mode 100644
index 0000000..56a5757
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
index ec90569..0000000
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
index 0000000..a3638b9
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
index 0db778f..0000000
--- a/target/tilegx/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += cpu.o translate.o helper.o simd_helper.o
diff --git a/target/tilegx/meson.build b/target/tilegx/meson.build
new file mode 100644
index 0000000..6785904
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
index 281b55f..0000000
--- a/target/tricore/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o gdbstub.o
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
new file mode 100644
index 0000000..0ccc829
--- /dev/null
+++ b/target/tricore/meson.build
@@ -0,0 +1,15 @@
+tricore_ss = ss.source_set()
+tricore_ss.add(files(
+  'cpu.c',
+  'fpu_helper.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+  'gdbstub.c',
+))
+tricore_ss.add(zlib)
+
+tricore_softmmu_ss = ss.source_set()
+
+target_arch += {'tricore': tricore_ss}
+target_softmmu_arch += {'tricore': tricore_softmmu_ss}
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
deleted file mode 100644
index 35d8bf5..0000000
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
index 0000000..0fa7877
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
index c7e7fe6..0000000
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
index 0000000..27e453e
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
1.8.3.1



