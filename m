Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E892C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376AE218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4KqTGre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376AE218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv1f-0004oM-1j
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurO-0008D6-DQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurI-0000HL-U2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurH-0000Dq-0a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7p6CsNf36RV2pEl5d2Wfr1jzcofXYk0f3MxvYkhmYI=;
 b=Y4KqTGreIvsBoCmZSKF4We7CqFoek71L2q65nv6Res0x0mlwN1WqWkRqBECPmDFTa8IhET
 qgLpLCgz7+7vVYf08ZVlU4toZUZ9BaM7jIRfmDxt1U3S/wiupWUOcswmrWGXNZxdaJok/9
 hvIOqNSRdRJeae9q8Jm9+GReWr0jFm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-CxBu_yi1OJqYmzpXLHxyVA-1; Thu, 19 Dec 2019 07:24:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BCCE184BEE9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:43 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64FE360C18;
 Thu, 19 Dec 2019 12:24:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 106/132] meson: target
Date: Thu, 19 Dec 2019 13:23:26 +0100
Message-Id: <1576758232-12439-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CxBu_yi1OJqYmzpXLHxyVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target                 |  3 +--
 libdecnumber/Makefile.objs      |  5 ----
 libdecnumber/meson.build        |  7 ++++++
 meson.build                     |  5 ++++
 scripts/decodetree.py           |  2 +-
 target/alpha/Makefile.objs      |  4 ----
 target/alpha/meson.build        | 18 ++++++++++++++
 target/arm/Makefile.objs        | 45 ----------------------------------
 target/arm/meson.build          | 53 +++++++++++++++++++++++++++++++++++++=
++++
 target/arm/translate-sve.c      |  2 +-
 target/arm/translate-vfp.inc.c  |  4 ++--
 target/cris/Makefile.objs       |  3 ---
 target/cris/meson.build         | 14 +++++++++++
 target/hppa/Makefile.objs       | 11 ---------
 target/hppa/meson.build         | 19 +++++++++++++++
 target/hppa/translate.c         |  2 +-
 target/i386/Makefile.objs       | 22 -----------------
 target/i386/hvf/Makefile.objs   |  2 --
 target/i386/hvf/meson.build     | 12 ++++++++++
 target/i386/meson.build         | 41 +++++++++++++++++++++++++++++++
 target/lm32/Makefile.objs       |  4 ----
 target/lm32/meson.build         | 15 ++++++++++++
 target/m68k/Makefile.objs       |  5 ----
 target/m68k/meson.build         | 17 +++++++++++++
 target/meson.build              | 20 ++++++++++++++++
 target/microblaze/Makefile.objs |  3 ---
 target/microblaze/meson.build   | 14 +++++++++++
 target/mips/Makefile.objs       |  5 ----
 target/mips/meson.build         | 22 +++++++++++++++++
 target/moxie/Makefile.objs      |  2 --
 target/moxie/meson.build        | 14 +++++++++++
 target/nios2/Makefile.objs      |  4 ----
 target/nios2/meson.build        | 15 ++++++++++++
 target/openrisc/Makefile.objs   | 15 ------------
 target/openrisc/disas.c         |  2 +-
 target/openrisc/meson.build     | 23 ++++++++++++++++++
 target/openrisc/translate.c     |  2 +-
 target/ppc/Makefile.objs        | 20 ----------------
 target/ppc/meson.build          | 37 ++++++++++++++++++++++++++++
 target/riscv/Makefile.objs      | 23 ------------------
 target/riscv/meson.build        | 30 +++++++++++++++++++++++
 target/riscv/translate.c        |  4 ++--
 target/s390x/Makefile.objs      | 10 --------
 target/s390x/meson.build        | 42 +++++++++++++++++++++++++++++++-
 target/sh4/Makefile.objs        |  3 ---
 target/sh4/meson.build          | 14 +++++++++++
 target/sparc/Makefile.objs      |  7 ------
 target/sparc/meson.build        | 23 ++++++++++++++++++
 target/tilegx/Makefile.objs     |  1 -
 target/tilegx/meson.build       | 13 ++++++++++
 target/tricore/Makefile.objs    |  1 -
 target/tricore/meson.build      | 14 +++++++++++
 target/unicore32/Makefile.objs  |  8 -------
 target/unicore32/meson.build    | 14 +++++++++++
 target/xtensa/Makefile.objs     | 16 -------------
 target/xtensa/meson.build       | 30 +++++++++++++++++++++++
 56 files changed, 535 insertions(+), 231 deletions(-)
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

diff --git a/Makefile.target b/Makefile.target
index a8e5902..bc5a019 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -116,7 +116,6 @@ obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) +=3D disas/tci.o
 obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
-obj-y +=3D target/$(TARGET_BASE_ARCH)/
 obj-y +=3D disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
 LIBS :=3D $(libs_cpu) $(LIBS)
@@ -167,7 +166,7 @@ LIBS :=3D $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LI=
BS) $(OPENGL_LIBS) $(SECCOM
 LIBS :=3D $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS :=3D $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS :=3D $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS :=3D $(LIBS) $(VIRGL_LIBS)
+LIBS :=3D $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
=20
 generated-files-y +=3D hmp-commands.h hmp-commands-info.h
=20
diff --git a/libdecnumber/Makefile.objs b/libdecnumber/Makefile.objs
deleted file mode 100644
index d81db04..0000000
--- a/libdecnumber/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y +=3D decContext.o
-obj-y +=3D decNumber.o
-obj-y +=3D dpd/decimal32.o
-obj-y +=3D dpd/decimal64.o
-obj-y +=3D dpd/decimal128.o
diff --git a/libdecnumber/meson.build b/libdecnumber/meson.build
new file mode 100644
index 0000000..4d04139
--- /dev/null
+++ b/libdecnumber/meson.build
@@ -0,0 +1,7 @@
+libdecnumber =3D files(
+  'decContext.c',
+  'decNumber.c',
+  'dpd/decimal128.c',
+  'dpd/decimal32.c',
+  'dpd/decimal64.c',
+)
diff --git a/meson.build b/meson.build
index 378d2c0..c8428c0 100644
--- a/meson.build
+++ b/meson.build
@@ -35,6 +35,10 @@ configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
=20
+decodetree =3D generator(find_program('scripts/decodetree.py'),
+                       output: 'decode-@BASENAME@.inc',
+                       arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTP=
UT@'])
+
 m =3D cc.find_library('m', required: false)
 util =3D cc.find_library('util', required: false)
 winmm =3D []
@@ -639,6 +643,7 @@ subdir('monitor')
 subdir('net')
 subdir('replay')
 subdir('hw')
+subdir('libdecnumber')
 subdir('target')
=20
 mods =3D []
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index d8c59ca..1ff4878 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1198,7 +1198,7 @@ def main():
     long_opts =3D ['decode=3D', 'translate=3D', 'output=3D', 'insnwidth=3D=
',
                  'static-decode=3D', 'varinsnwidth=3D']
     try:
-        (opts, args) =3D getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
+        (opts, args) =3D getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_opt=
s)
     except getopt.GetoptError as err:
         error(0, err)
     for o, a in opts:
diff --git a/target/alpha/Makefile.objs b/target/alpha/Makefile.objs
deleted file mode 100644
index 6366462..0000000
--- a/target/alpha/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_SOFTMMU) +=3D machine.o
-obj-y +=3D translate.o helper.o cpu.o
-obj-y +=3D int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.=
o
-obj-y +=3D gdbstub.o
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
new file mode 100644
index 0000000..1aec55a
--- /dev/null
+++ b/target/alpha/meson.build
@@ -0,0 +1,18 @@
+alpha_ss =3D ss.source_set()
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
+alpha_softmmu_ss =3D ss.source_set()
+alpha_softmmu_ss.add(files('machine.c'))
+
+target_arch +=3D {'alpha': alpha_ss}
+target_softmmu_arch +=3D {'alpha': alpha_softmmu_ss}
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
deleted file mode 100644
index 5cafc1e..0000000
--- a/target/arm/Makefile.objs
+++ /dev/null
@@ -1,45 +0,0 @@
-obj-$(CONFIG_TCG) +=3D arm-semi.o
-obj-y +=3D helper.o vfp_helper.o
-obj-y +=3D cpu.o gdbstub.o
-obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
-
-obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_dump.o monitor.o
-obj-$(CONFIG_SOFTMMU) +=3D arm-powerctl.o
-
-obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32.o
-obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
-
-DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
-
-target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETRE=
E)
-=09$(call quiet-command,\
-=09  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
-=09  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp.inc.c: $(SRC_PATH)/target/arm/vfp.decode $(DECODETRE=
E)
-=09$(call quiet-command,\
-=09  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
-=09  "GEN", $(TARGET_DIR)$@)
-
-target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.deco=
de $(DECODETREE)
-=09$(call quiet-command,\
-=09  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
-=09  "GEN", $(TARGET_DIR)$@)
-
-target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-target/arm/translate.o: target/arm/decode-vfp.inc.c
-target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
-
-obj-y +=3D tlb_helper.o debug_helper.o
-obj-y +=3D translate.o op_helper.o
-obj-y +=3D crypto_helper.o
-obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
-obj-y +=3D m_helper.o
-
-obj-$(CONFIG_SOFTMMU) +=3D psci.o
-
-obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
-obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
-obj-$(TARGET_AARCH64) +=3D pauth_helper.o
diff --git a/target/arm/meson.build b/target/arm/meson.build
new file mode 100644
index 0000000..7a612d9
--- /dev/null
+++ b/target/arm/meson.build
@@ -0,0 +1,53 @@
+gen =3D [
+  decodetree.process('sve.decode', extra_args: '--decode=3Ddisas_sve'),
+  decodetree.process('vfp.decode', extra_args: '--static-decode=3Ddisas_vf=
p'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--static-decode=3Dd=
isas_vfp_uncond'),
+]
+
+arm_ss =3D ss.source_set()
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
+kvm_ss =3D ss.source_set()
+kvm_ss.add(when: 'TARGET_AARCH64', if_true: 'kvm64.c', if_false: 'kvm32.c'=
)
+arm_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
+arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('k=
vm-stub.c'))
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
+arm_softmmu_ss =3D ss.source_set()
+arm_softmmu_ss.add(files(
+  'arch_dump.c',
+  'arm-powerctl.c',
+  'machine.c',
+  'monitor.c',
+  'psci.c',
+))
+
+target_arch +=3D {'arm': arm_ss}
+target_softmmu_arch +=3D {'arm': arm_softmmu_ss}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fa068b0..f8acb26 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -100,7 +100,7 @@ static inline int msz_dtype(DisasContext *s, int msz)
  * Include the generated decoder.
  */
=20
-#include "decode-sve.inc.c"
+#include "decode-sve.inc"
=20
 /*
  * Implement all of the translator functions referenced by the decoder.
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.=
c
index 3e8ea80..c0f92ad 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -27,8 +27,8 @@
  */
=20
 /* Include the generated VFP decoder */
-#include "decode-vfp.inc.c"
-#include "decode-vfp-uncond.inc.c"
+#include "decode-vfp.inc"
+#include "decode-vfp-uncond.inc"
=20
 /*
  * The imm8 encodes the sign bit, enough bits to represent an exponent in
diff --git a/target/cris/Makefile.objs b/target/cris/Makefile.objs
deleted file mode 100644
index 7779227..0000000
--- a/target/cris/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D gdbstub.o
-obj-$(CONFIG_SOFTMMU) +=3D mmu.o machine.o
diff --git a/target/cris/meson.build b/target/cris/meson.build
new file mode 100644
index 0000000..67c3793
--- /dev/null
+++ b/target/cris/meson.build
@@ -0,0 +1,14 @@
+cris_ss =3D ss.source_set()
+cris_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+cris_softmmu_ss =3D ss.source_set()
+cris_softmmu_ss.add(files('mmu.c', 'machine.c'))
+
+target_arch +=3D {'cris': cris_ss}
+target_softmmu_arch +=3D {'cris': cris_softmmu_ss}
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
deleted file mode 100644
index 174f50a..0000000
--- a/target/hppa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-obj-y +=3D translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
-obj-y +=3D int_helper.o
-obj-$(CONFIG_SOFTMMU) +=3D machine.o
-
-DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
-
-target/hppa/decode.inc.c: $(SRC_PATH)/target/hppa/insns.decode $(DECODETRE=
E)
-=09$(call quiet-command,\
-=09  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/hppa/translate.o: target/hppa/decode.inc.c
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
new file mode 100644
index 0000000..8a7ff82
--- /dev/null
+++ b/target/hppa/meson.build
@@ -0,0 +1,19 @@
+gen =3D decodetree.process('insns.decode')
+
+hppa_ss =3D ss.source_set()
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
+hppa_softmmu_ss =3D ss.source_set()
+hppa_softmmu_ss.add(files('machine.c'))
+
+target_arch +=3D {'hppa': hppa_ss}
+target_softmmu_arch +=3D {'hppa': hppa_softmmu_ss}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8c61895..2f17259 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -334,7 +334,7 @@ static int expand_shl11(DisasContext *ctx, int val)
=20
=20
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
=20
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
deleted file mode 100644
index 48e0c28..0000000
--- a/target/i386/Makefile.objs
+++ /dev/null
@@ -1,22 +0,0 @@
-obj-y +=3D helper.o cpu.o gdbstub.o xsave_helper.o
-obj-$(CONFIG_TCG) +=3D translate.o
-obj-$(CONFIG_TCG) +=3D bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o mpx_helper.=
o
-obj-$(CONFIG_TCG) +=3D seg_helper.o smm_helper.o svm_helper.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
-ifeq ($(CONFIG_SOFTMMU),y)
-obj-y +=3D machine.o arch_memory_mapping.o arch_dump.o monitor.o
-obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(CONFIG_HYPERV) +=3D hyperv.o
-obj-$(call lnot,$(CONFIG_HYPERV)) +=3D hyperv-stub.o
-ifeq ($(CONFIG_WIN32),y)
-obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-windows.o
-endif
-ifeq ($(CONFIG_POSIX),y)
-obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
-endif
-obj-$(CONFIG_HVF) +=3D hvf/
-obj-$(CONFIG_WHPX) +=3D whpx-all.o
-endif
-obj-$(CONFIG_SEV) +=3D sev.o
-obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
deleted file mode 100644
index 927b86b..0000000
--- a/target/i386/hvf/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y +=3D hvf.o
-obj-y +=3D x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.=
o x86_mmu.o x86hvf.o x86_task.o
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
index 0000000..58a70da
--- /dev/null
+++ b/target/i386/meson.build
@@ -0,0 +1,41 @@
+i386_ss =3D ss.source_set()
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
+i386_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('=
sev-stub.c'))
+
+i386_softmmu_ss =3D ss.source_set()
+i386_softmmu_ss.add(files(
+  'arch_dump.c',
+  'arch_memory_mapping.c',
+  'machine.c',
+  'monitor.c',
+))
+i386_softmmu_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_=
false: files('hyperv-stub.c'))
+i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
+i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files('whpx-all.c'))
+i386_softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_HAX'], if_true: files('=
hax-all.c', 'hax-mem.c', 'hax-posix.c'))
+i386_softmmu_ss.add(when: ['CONFIG_WIN32', 'CONFIG_HAX'], if_true: files('=
hax-all.c', 'hax-mem.c', 'hax-windows.c'))
+
+subdir('hvf')
+
+target_arch +=3D {'i386': i386_ss}
+target_softmmu_arch +=3D {'i386': i386_softmmu_ss}
diff --git a/target/lm32/Makefile.objs b/target/lm32/Makefile.objs
deleted file mode 100644
index c3e1bd6..0000000
--- a/target/lm32/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D gdbstub.o
-obj-y +=3D lm32-semi.o
-obj-$(CONFIG_SOFTMMU) +=3D machine.o
diff --git a/target/lm32/meson.build b/target/lm32/meson.build
new file mode 100644
index 0000000..ef0eef0
--- /dev/null
+++ b/target/lm32/meson.build
@@ -0,0 +1,15 @@
+lm32_ss =3D ss.source_set()
+lm32_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'lm32-semi.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+lm32_softmmu_ss =3D ss.source_set()
+lm32_softmmu_ss.add(files('machine.c'))
+
+target_arch +=3D {'lm32': lm32_ss}
+target_softmmu_arch +=3D {'lm32': lm32_softmmu_ss}
diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
deleted file mode 100644
index ac61948..0000000
--- a/target/m68k/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y +=3D m68k-semi.o
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D fpu_helper.o softfloat.o
-obj-y +=3D gdbstub.o
-obj-$(CONFIG_SOFTMMU) +=3D monitor.o
diff --git a/target/m68k/meson.build b/target/m68k/meson.build
new file mode 100644
index 0000000..05cd9fb
--- /dev/null
+++ b/target/m68k/meson.build
@@ -0,0 +1,17 @@
+m68k_ss =3D ss.source_set()
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
+m68k_softmmu_ss =3D ss.source_set()
+m68k_softmmu_ss.add(files('monitor.c'))
+
+target_arch +=3D {'m68k': m68k_ss}
+target_softmmu_arch +=3D {'m68k': m68k_softmmu_ss}
diff --git a/target/meson.build b/target/meson.build
index e29dd3e..d98d276 100644
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
diff --git a/target/microblaze/Makefile.objs b/target/microblaze/Makefile.o=
bjs
deleted file mode 100644
index f3d7b44..0000000
--- a/target/microblaze/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D gdbstub.o
-obj-$(CONFIG_SOFTMMU) +=3D mmu.o
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
new file mode 100644
index 0000000..b8fe4af
--- /dev/null
+++ b/target/microblaze/meson.build
@@ -0,0 +1,14 @@
+microblaze_ss =3D ss.source_set()
+microblaze_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+microblaze_softmmu_ss =3D ss.source_set()
+microblaze_softmmu_ss.add(files('mmu.c'))
+
+target_arch +=3D {'microblaze': microblaze_ss}
+target_softmmu_arch +=3D {'microblaze': microblaze_softmmu_ss}
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
deleted file mode 100644
index 3448ad5..0000000
--- a/target/mips/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.=
o
-obj-y +=3D gdbstub.o msa_helper.o
-obj-$(CONFIG_SOFTMMU) +=3D mips-semi.o
-obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
-obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/mips/meson.build b/target/mips/meson.build
new file mode 100644
index 0000000..ad35f00
--- /dev/null
+++ b/target/mips/meson.build
@@ -0,0 +1,22 @@
+mips_ss =3D ss.source_set()
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
+mips_softmmu_ss =3D ss.source_set()
+mips_softmmu_ss.add(files(
+  'cp0_timer.c',
+  'machine.c',
+  'mips-semi.c',
+))
+
+target_arch +=3D {'mips': mips_ss}
+target_softmmu_arch +=3D {'mips': mips_softmmu_ss}
diff --git a/target/moxie/Makefile.objs b/target/moxie/Makefile.objs
deleted file mode 100644
index 6381d4d..0000000
--- a/target/moxie/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y +=3D translate.o helper.o machine.o cpu.o machine.o
-obj-$(CONFIG_SOFTMMU) +=3D mmu.o
diff --git a/target/moxie/meson.build b/target/moxie/meson.build
new file mode 100644
index 0000000..b4beb52
--- /dev/null
+++ b/target/moxie/meson.build
@@ -0,0 +1,14 @@
+moxie_ss =3D ss.source_set()
+moxie_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'machine.c',
+  'machine.c',
+  'translate.c',
+))
+
+moxie_softmmu_ss =3D ss.source_set()
+moxie_softmmu_ss.add(files('mmu.c'))
+
+target_arch +=3D {'moxie': moxie_ss}
+target_softmmu_arch +=3D {'moxie': moxie_softmmu_ss}
diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
deleted file mode 100644
index 010de0e..0000000
--- a/target/nios2/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o mmu.o nios2-semi.o
-obj-$(CONFIG_SOFTMMU) +=3D monitor.o
-
-$(obj)/op_helper.o: QEMU_CFLAGS +=3D $(HELPER_CFLAGS)
diff --git a/target/nios2/meson.build b/target/nios2/meson.build
new file mode 100644
index 0000000..e643917
--- /dev/null
+++ b/target/nios2/meson.build
@@ -0,0 +1,15 @@
+nios2_ss =3D ss.source_set()
+nios2_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'mmu.c',
+  'nios2-semi.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+nios2_softmmu_ss =3D ss.source_set()
+nios2_softmmu_ss.add(files('monitor.c'))
+
+target_arch +=3D {'nios2': nios2_ss}
+target_softmmu_arch +=3D {'nios2': nios2_softmmu_ss}
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
deleted file mode 100644
index b5432f4..0000000
--- a/target/openrisc/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-obj-$(CONFIG_SOFTMMU) +=3D machine.o
-obj-y +=3D cpu.o exception.o interrupt.o mmu.o translate.o disas.o
-obj-y +=3D exception_helper.o fpu_helper.o \
-         interrupt_helper.o sys_helper.o
-obj-y +=3D gdbstub.o
-
-DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
-
-target/openrisc/decode.inc.c: \
-  $(SRC_PATH)/target/openrisc/insns.decode $(DECODETREE)
-=09$(call quiet-command,\
-=09  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
-
-target/openrisc/translate.o: target/openrisc/decode.inc.c
-target/openrisc/disas.o: target/openrisc/decode.inc.c
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 7091832..4014518 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -25,7 +25,7 @@
 typedef disassemble_info DisasContext;
=20
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
=20
 #define output(mnemonic, format, ...) \
     (info->fprintf_func(info->stream, "%-9s " format, \
diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
new file mode 100644
index 0000000..9774a58
--- /dev/null
+++ b/target/openrisc/meson.build
@@ -0,0 +1,23 @@
+gen =3D decodetree.process('insns.decode')
+
+openrisc_ss =3D ss.source_set()
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
+openrisc_softmmu_ss =3D ss.source_set()
+openrisc_softmmu_ss.add(files('machine.c'))
+
+target_arch +=3D {'openrisc': openrisc_ss}
+target_softmmu_arch +=3D {'openrisc': openrisc_softmmu_ss}
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4360ce4..9add656 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -60,7 +60,7 @@ static inline bool is_user(DisasContext *dc)
 }
=20
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode-insns.inc"
=20
 static TCGv cpu_sr;
 static TCGv cpu_R[32];
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
deleted file mode 100644
index e8fa18c..0000000
--- a/target/ppc/Makefile.objs
+++ /dev/null
@@ -1,20 +0,0 @@
-obj-y +=3D cpu-models.o
-obj-y +=3D cpu.o
-obj-y +=3D translate.o
-ifeq ($(CONFIG_SOFTMMU),y)
-obj-y +=3D machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
-obj-$(TARGET_PPC64) +=3D mmu-hash64.o mmu-book3s-v3.o compat.o
-obj-$(TARGET_PPC64) +=3D mmu-radix64.o
-endif
-obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
-obj-y +=3D dfp_helper.o
-obj-y +=3D excp_helper.o
-obj-y +=3D fpu_helper.o
-obj-y +=3D int_helper.o
-obj-y +=3D timebase_helper.o
-obj-y +=3D misc_helper.o
-obj-y +=3D mem_helper.o
-obj-y +=3D ../../libdecnumber/
-obj-$(CONFIG_USER_ONLY) +=3D user_only_helper.o
-obj-y +=3D gdbstub.o
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
new file mode 100644
index 0000000..bbfef90
--- /dev/null
+++ b/target/ppc/meson.build
@@ -0,0 +1,37 @@
+ppc_ss =3D ss.source_set()
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
+ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('k=
vm-stub.c'))
+ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
+
+ppc_softmmu_ss =3D ss.source_set()
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
+target_arch +=3D {'ppc': ppc_ss}
+target_softmmu_arch +=3D {'ppc': ppc_softmmu_ss}
diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
deleted file mode 100644
index b1c79bc..0000000
--- a/target/riscv/Makefile.objs
+++ /dev/null
@@ -1,23 +0,0 @@
-obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o g=
dbstub.o pmp.o
-
-DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
-
-decode32-y =3D $(SRC_PATH)/target/riscv/insn32.decode
-decode32-$(TARGET_RISCV64) +=3D $(SRC_PATH)/target/riscv/insn32-64.decode
-
-decode16-y =3D $(SRC_PATH)/target/riscv/insn16.decode
-decode16-$(TARGET_RISCV32) +=3D $(SRC_PATH)/target/riscv/insn16-32.decode
-decode16-$(TARGET_RISCV64) +=3D $(SRC_PATH)/target/riscv/insn16-64.decode
-
-target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
-=09$(call quiet-command, \
-=09  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
-          $(decode32-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
-=09$(call quiet-command, \
-=09  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
-          --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
-
-target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
-=09target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
new file mode 100644
index 0000000..1a7ad20
--- /dev/null
+++ b/target/riscv/meson.build
@@ -0,0 +1,30 @@
+# FIXME extra_args should accept files()
+dir =3D meson.current_source_dir()
+gen32 =3D [
+  decodetree.process('insn16.decode', extra_args: [dir / 'insn16-32.decode=
', '--static-decode=3Ddecode_insn16', '--insnwidth=3D16']),
+  decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
+]
+
+gen64 =3D [
+  decodetree.process('insn16.decode', extra_args: [dir / 'insn16-64.decode=
', '--static-decode=3Ddecode_insn16', '--insnwidth=3D16']),
+  decodetree.process('insn32.decode', extra_args: [dir / 'insn32-64.decode=
', '--static-decode=3Ddecode_insn32']),
+]
+
+riscv_ss =3D ss.source_set()
+riscv_ss.add(when: 'TARGET_RISCV32', if_true: gen32)
+riscv_ss.add(when: 'TARGET_RISCV64', if_true: gen64)
+riscv_ss.add(files(
+  'cpu.c',
+  'cpu_helper.c',
+  'csr.c',
+  'fpu_helper.c',
+  'gdbstub.c',
+  'op_helper.c',
+  'pmp.c',
+  'translate.c',
+))
+
+riscv_softmmu_ss =3D ss.source_set()
+
+target_arch +=3D {'riscv': riscv_ss}
+target_softmmu_arch +=3D {'riscv': riscv_softmmu_ss}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb8..b4fdc68 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -566,7 +566,7 @@ static int ex_rvc_shifti(DisasContext *ctx, int imm)
 }
=20
 /* Include the auto-generated decoder for 32 bit insn */
-#include "decode_insn32.inc.c"
+#include "decode-insn32.inc"
=20
 static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
                              void (*func)(TCGv, TCGv, target_long))
@@ -709,7 +709,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_privileged.inc.c"
=20
 /* Include the auto-generated decoder for 16 bit insn */
-#include "decode_insn16.inc.c"
+#include "decode-insn16.inc"
=20
 static void decode_opc(DisasContext *ctx)
 {
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
deleted file mode 100644
index 9b9accc..0000000
--- a/target/s390x/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-obj-y +=3D cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.=
o
-obj-$(CONFIG_TCG) +=3D translate.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o crypto_help=
er.o
-obj-$(CONFIG_TCG) +=3D vec_helper.o vec_int_helper.o vec_string_helper.o
-obj-$(CONFIG_TCG) +=3D vec_fpu_helper.o
-obj-$(CONFIG_SOFTMMU) +=3D machine.o ioinst.o arch_dump.o mmu_helper.o dia=
g.o
-obj-$(CONFIG_SOFTMMU) +=3D sigp.o
-obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
-obj-$(call lnot,$(CONFIG_TCG)) +=3D tcg-stub.o
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 980f67c..4757e58 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -1,3 +1,30 @@
+s390x_ss =3D ss.source_set()
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
+s390x_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files(=
'kvm-stub.c'))
+
 gen_features =3D executable('gen-features', 'gen-features.c', native: true=
)
=20
 gen_features_h =3D custom_target('gen-features.h',
@@ -5,4 +32,17 @@ gen_features_h =3D custom_target('gen-features.h',
                                capture: true,
                                command: gen_features)
=20
-specific_ss.add(gen_features_h)
+s390x_ss.add(gen_features_h)
+
+s390x_softmmu_ss =3D ss.source_set()
+s390x_softmmu_ss.add(files(
+  'arch_dump.c',
+  'diag.c',
+  'ioinst.c',
+  'machine.c',
+  'mmu_helper.c',
+  'sigp.c',
+))
+
+target_arch +=3D {'s390x': s390x_ss}
+target_softmmu_arch +=3D {'s390x': s390x_softmmu_ss}
diff --git a/target/sh4/Makefile.objs b/target/sh4/Makefile.objs
deleted file mode 100644
index 2c25d96..0000000
--- a/target/sh4/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) +=3D monitor.o
-obj-y +=3D gdbstub.o
diff --git a/target/sh4/meson.build b/target/sh4/meson.build
new file mode 100644
index 0000000..56a5757
--- /dev/null
+++ b/target/sh4/meson.build
@@ -0,0 +1,14 @@
+sh4_ss =3D ss.source_set()
+sh4_ss.add(files(
+  'cpu.c',
+  'gdbstub.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+
+sh4_softmmu_ss =3D ss.source_set()
+sh4_softmmu_ss.add(files('monitor.c'))
+
+target_arch +=3D {'sh4': sh4_ss}
+target_softmmu_arch +=3D {'sh4': sh4_softmmu_ss}
diff --git a/target/sparc/Makefile.objs b/target/sparc/Makefile.objs
deleted file mode 100644
index ec90569..0000000
--- a/target/sparc/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-obj-$(CONFIG_SOFTMMU) +=3D machine.o monitor.o
-obj-y +=3D translate.o helper.o cpu.o
-obj-y +=3D fop_helper.o cc_helper.o win_helper.o mmu_helper.o ldst_helper.=
o
-obj-$(TARGET_SPARC) +=3D int32_helper.o
-obj-$(TARGET_SPARC64) +=3D int64_helper.o
-obj-$(TARGET_SPARC64) +=3D vis_helper.o
-obj-y +=3D gdbstub.o
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
new file mode 100644
index 0000000..a3638b9
--- /dev/null
+++ b/target/sparc/meson.build
@@ -0,0 +1,23 @@
+sparc_ss =3D ss.source_set()
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
+sparc_ss.add(when: 'TARGET_SPARC64', if_true: files('int64_helper.c', 'vis=
_helper.c'))
+
+sparc_softmmu_ss =3D ss.source_set()
+sparc_softmmu_ss.add(files(
+  'machine.c',
+  'monitor.c',
+))
+
+target_arch +=3D {'sparc': sparc_ss}
+target_softmmu_arch +=3D {'sparc': sparc_softmmu_ss}
diff --git a/target/tilegx/Makefile.objs b/target/tilegx/Makefile.objs
deleted file mode 100644
index 0db778f..0000000
--- a/target/tilegx/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y +=3D cpu.o translate.o helper.o simd_helper.o
diff --git a/target/tilegx/meson.build b/target/tilegx/meson.build
new file mode 100644
index 0000000..6785904
--- /dev/null
+++ b/target/tilegx/meson.build
@@ -0,0 +1,13 @@
+tilegx_ss =3D ss.source_set()
+tilegx_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'simd_helper.c',
+  'translate.c',
+))
+tilegx_ss.add(zlib)
+
+tilegx_softmmu_ss =3D ss.source_set()
+
+target_arch +=3D {'tilegx': tilegx_ss}
+target_softmmu_arch +=3D {'tilegx': tilegx_softmmu_ss}
diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
deleted file mode 100644
index 7a05670..0000000
--- a/target/tricore/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y +=3D translate.o helper.o cpu.o op_helper.o fpu_helper.o
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
new file mode 100644
index 0000000..d7db446
--- /dev/null
+++ b/target/tricore/meson.build
@@ -0,0 +1,14 @@
+tricore_ss =3D ss.source_set()
+tricore_ss.add(files(
+  'cpu.c',
+  'fpu_helper.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+))
+tricore_ss.add(zlib)
+
+tricore_softmmu_ss =3D ss.source_set()
+
+target_arch +=3D {'tricore': tricore_ss}
+target_softmmu_arch +=3D {'tricore': tricore_softmmu_ss}
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.obj=
s
deleted file mode 100644
index 35d8bf5..0000000
--- a/target/unicore32/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D ucf64_helper.o
-
-obj-$(CONFIG_SOFTMMU) +=3D softmmu.o
-
-# Huh? Uses curses directly instead of using ui/console.h interfaces ...
-helper.o-cflags :=3D $(CURSES_CFLAGS)
-helper.o-libs :=3D $(CURSES_LIBS)
diff --git a/target/unicore32/meson.build b/target/unicore32/meson.build
new file mode 100644
index 0000000..0fa7877
--- /dev/null
+++ b/target/unicore32/meson.build
@@ -0,0 +1,14 @@
+unicore32_ss =3D ss.source_set()
+unicore32_ss.add(files(
+  'cpu.c',
+  'helper.c',
+  'op_helper.c',
+  'translate.c',
+  'ucf64_helper.c',
+), curses)
+
+unicore32_softmmu_ss =3D ss.source_set()
+unicore32_softmmu_ss.add(files('softmmu.c'))
+
+target_arch +=3D {'unicore32': unicore32_ss}
+target_softmmu_arch +=3D {'unicore32': unicore32_softmmu_ss}
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
deleted file mode 100644
index c7e7fe6..0000000
--- a/target/xtensa/Makefile.objs
+++ /dev/null
@@ -1,16 +0,0 @@
-obj-y +=3D core-dc232b.o
-obj-y +=3D core-dc233c.o
-obj-y +=3D core-de212.o
-obj-y +=3D core-fsf.o
-obj-y +=3D core-sample_controller.o
-obj-y +=3D core-test_kc705_be.o
-obj-y +=3D core-test_mmuhifi_c3.o
-obj-$(CONFIG_SOFTMMU) +=3D monitor.o xtensa-semi.o
-obj-y +=3D xtensa-isa.o
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) +=3D dbg_helper.o
-obj-y +=3D exc_helper.o
-obj-y +=3D fpu_helper.o
-obj-y +=3D gdbstub.o
-obj-$(CONFIG_SOFTMMU) +=3D mmu_helper.o
-obj-y +=3D win_helper.o
diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
new file mode 100644
index 0000000..27e453e
--- /dev/null
+++ b/target/xtensa/meson.build
@@ -0,0 +1,30 @@
+xtensa_ss =3D ss.source_set()
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
+xtensa_softmmu_ss =3D ss.source_set()
+xtensa_softmmu_ss.add(files(
+  'dbg_helper.c',
+  'mmu_helper.c',
+  'monitor.c',
+  'xtensa-semi.c',
+))
+
+target_arch +=3D {'xtensa': xtensa_ss}
+target_softmmu_arch +=3D {'xtensa': xtensa_softmmu_ss}
--=20
1.8.3.1



