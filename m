Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4527C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F3E2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TX1Hwu7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F3E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvGp-0000dS-9y
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihura-0008UI-CM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurX-0001BZ-9d
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurW-000176-Qk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUsqlpHqwwxmIckfDRHk13b6nUixXxTxUVyyyck8DZU=;
 b=TX1Hwu7Y+9CZWxHsCDY+98wy7/Lyj9xjU2jEg4+e3ekD7SfTj2/gDbtHuWzrD7IBrkZUf1
 T/DrMzqz1deZbgpn96QXIXmL0/56W0+y8sgORh35TxDIzBI8i/ILaAtISUygOFgMuAJGMk
 NlMQgyT5jQJce+BkcxW6DrWRCTvIlVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Hk1VcQzCPK2yxTfhwEuGpA-1; Thu, 19 Dec 2019 07:25:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943E3DB60
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:59 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 626D160C18;
 Thu, 19 Dec 2019 12:24:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 112/132] Aaaaallelujah!
Date: Thu, 19 Dec 2019 13:23:32 +0100
Message-Id: <1576758232-12439-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Hk1VcQzCPK2yxTfhwEuGpA-1
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
 .gitlab-ci.yml                            |   6 +-
 Makefile                                  |  29 -------
 Makefile.target                           | 124 +-------------------------=
----
 docs/devel/blkverify.txt                  |   4 +-
 docs/devel/testing.rst                    |   4 +-
 docs/interop/live-block-operations.rst    |   4 +-
 meson.build                               |  24 ++++++
 os-posix.c                                |   2 +-
 scripts/device-crash-test                 |   2 +-
 tests/Makefile.include                    |  11 ++-
 tests/acceptance/avocado_qemu/__init__.py |   3 +-
 tests/data/acpi/rebuild-expected-aml.sh   |   2 +-
 tests/libqos/qgraph.h                     |   2 +-
 tests/multiboot/run_test.sh               |   2 +-
 tests/qemu-iotests/check                  |   6 +-
 tests/rtas-test.c                         |   2 +-
 tests/tcg/Makefile.target                 |   6 ++
 17 files changed, 58 insertions(+), 175 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd4c033..2a527db 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -75,9 +75,9 @@ build-tci:
  - make -j2
  - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
  - for tg in $TARGETS ; do
-     export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
+     export QTEST_QEMU_BINARY=3D"./qemu-system-${tg}" ;
      ./tests/boot-serial-test || exit 1 ;
      ./tests/cdrom-test || exit 1 ;
    done
- - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-tes=
t
- - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-test =
-m slow
+ - QTEST_QEMU_BINARY=3D"./qemu-system-x86_64" ./tests/pxe-test
+ - QTEST_QEMU_BINARY=3D"./qemu-system-s390x" ./tests/pxe-test -m slow
diff --git a/Makefile b/Makefile
index 5bdd400..71c3352 100644
--- a/Makefile
+++ b/Makefile
@@ -135,36 +135,10 @@ ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
 endif
=20
-dummy :=3D $(call unnest-vars,, common-obj-y)
-
 include $(SRC_PATH)/tests/Makefile.include
=20
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
=20
-TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t), =
$(TARGET_DIRS)))
-SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
-SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
-
-SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
-$(SOFTMMU_ALL_RULES): $(authz-obj-y)
-$(SOFTMMU_ALL_RULES): $(block-obj-y)
-$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
-$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
-$(SOFTMMU_ALL_RULES): $(io-obj-y)
-$(SOFTMMU_ALL_RULES): $(qom-obj-y)
-$(SOFTMMU_ALL_RULES): config-all-devices.mak
-
-# meson: this is sub-optimal but going away after conversion
-TARGET_DEPS =3D $(patsubst %,%-config-target.h, $(TARGET_DIRS))
-TARGET_DEPS +=3D $(patsubst %,%-config-devices.h, $(filter %-softmmu,$(TAR=
GET_DIRS)))
-TARGET_DEPS +=3D $(patsubst %,libqemu-%.fa, $(TARGET_DIRS))
-
-.PHONY: $(TARGET_DIRS_RULES)
-# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
-# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
-$(TARGET_DIRS_RULES): $(TARGET_DEPS)
-=09$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" $(notdir $@),)
-
 DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D"$(V)=
" LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
 DTC_CPPFLAGS=3D-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libf=
dt
@@ -202,9 +176,6 @@ subdir-dtc: dtc/all
 subdir-capstone: capstone/all
 subdir-slirp: slirp/all
=20
-$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-=09$(qom-obj-y) block.syms qemu.syms
-
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
diff --git a/Makefile.target b/Makefile.target
index 32c0521..8ee4c78 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,43 +6,16 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
=20
-FULL_TARGET_NAME=3D$(TARGET_NAME)-$(if $(CONFIG_SOFTMMU),softmmu,linux-use=
r)
-
-ifdef CONFIG_SOFTMMU
-include ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
-ifdef CONFIG_LINUX
-QEMU_CFLAGS +=3D -I../linux-headers
-endif
-QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH)=
 -DNEED_CPU_H
-
-QEMU_CFLAGS+=3D-iquote $(SRC_PATH)/include
-
-QEMU_CFLAGS +=3D -DCONFIG_TARGET=3D\"../$(FULL_TARGET_NAME)-config-target.=
h\"
-QEMU_CFLAGS +=3D -DCONFIG_DEVICES=3D\"../$(FULL_TARGET_NAME)-config-device=
s.h\"
=20
 ifdef CONFIG_USER_ONLY
 # user emulator name
 QEMU_PROG=3Dqemu-$(TARGET_NAME)
-QEMU_PROG_BUILD =3D $(QEMU_PROG)
 else
 # system emulator name
 QEMU_PROG=3Dqemu-system-$(TARGET_NAME)$(EXESUF)
-ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
-# Terminate program name with a 'w' because the linker builds a windows ex=
ecutable.
-QEMU_PROGW=3Dqemu-system-$(TARGET_NAME)w$(EXESUF)
-$(QEMU_PROG): $(QEMU_PROGW)
-=09$(call quiet-command,$(OBJCOPY) --subsystem console $(QEMU_PROGW) $(QEM=
U_PROG),"GEN","$(TARGET_DIR)$(QEMU_PROG)")
-QEMU_PROG_BUILD =3D $(QEMU_PROGW)
-else
-QEMU_PROG_BUILD =3D $(QEMU_PROG)
-endif
 endif
=20
-LIBQEMU =3D ../libqemu-$(FULL_TARGET_NAME).fa
-PROGS=3D$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=3D
=20
 ifdef CONFIG_TRACE_SYSTEMTAP
@@ -98,96 +71,10 @@ stap:
 endif
 .PHONY: stap
=20
-all: $(PROGS) stap
-
-# Dummy command so that make thinks it has done something
-=09@true
-
-obj-y +=3D $(LIBQEMU)
-
-obj-y +=3D trace/
-
-#########################################################
-LIBS :=3D $(libs_cpu) $(LIBS)
-
-#########################################################
-# Linux user emulator target
-
-ifdef CONFIG_LINUX_USER
+all: stap
=20
-QEMU_CFLAGS+=3D-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
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
-QEMU_CFLAGS+=3D-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_=
DIR) \
-=09=09=09 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
-
-endif #CONFIG_BSD_USER
-
-#########################################################
-# System emulator target
-ifdef CONFIG_SOFTMMU
-LIBS :=3D $(libs_softmmu) $(LIBS)
-
-# Temporary until emulators are linked by Meson
-LIBS :=3D $(LIBS) @../block.syms @../qemu.syms
-ifneq ($(CONFIG_MODULES),y)
-LIBS :=3D $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
-LIBS :=3D $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICO=
NV_LIBS) $(GIO_LIBS)
-endif
-LIBS :=3D $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) =
$(SECCOMP_LIBS)
-LIBS :=3D $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
-LIBS :=3D $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
-LIBS :=3D $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS :=3D $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
-
-generated-files-y +=3D hmp-commands.h hmp-commands-info.h
-
-endif # CONFIG_SOFTMMU
-
-dummy :=3D $(call unnest-vars,,obj-y)
-all-obj-y :=3D $(obj-y)
-
-include $(SRC_PATH)/Makefile.objs
-dummy :=3D $(call fix-paths,../,, \
-              authz-obj-y \
-              block-obj-y \
-              chardev-obj-y \
-              crypto-obj-y \
-              io-obj-y \
-              qom-obj-y)
-dummy :=3D $(call unnest-vars,.., \
-               common-obj-y)
-all-obj-y +=3D $(common-obj-y)
-all-obj-y +=3D $(qom-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
-
-ifdef CONFIG_SOFTMMU
-$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
-COMMON_LDADDS =3D ../libqemuutil.a
-
-# build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
-=09$(call LINK, $(filter-out %.mak, $^))
-ifdef CONFIG_DARWIN
-=09$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"R=
EZ","$(TARGET_DIR)$@")
-=09$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
-endif
-
-clean: clean-target
-=09rm -f *.a *~ $(PROGS)
+clean:
+=09rm -f *.a *~
 =09rm -f $(shell find . -name '*.[od]')
 =09rm -f hmp-commands.h gdbstub-xml.c
 =09rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
@@ -196,9 +83,6 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
=20
 install: all
-ifneq ($(PROGS),)
-=09$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
 =09$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/.=
./systemtap/tapset/$(QEMU_PROG).stp"
@@ -206,4 +90,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 =09$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../syst=
emtap/tapset/$(QEMU_PROG)-log.stp"
 endif
=20
-Makefile: $(generated-files-y)
+.PHONY: all clean install
diff --git a/docs/devel/blkverify.txt b/docs/devel/blkverify.txt
index d556dc4..aca826c 100644
--- a/docs/devel/blkverify.txt
+++ b/docs/devel/blkverify.txt
@@ -62,8 +62,8 @@ A more realistic scenario is verifying the installation o=
f a guest OS:
=20
     $ ./qemu-img create raw.img 16G
     $ ./qemu-img create -f qcow2 test.qcow2 16G
-    $ x86_64-softmmu/qemu-system-x86_64 -cdrom debian.iso \
-                                        -drive file=3Dblkverify:raw.img:te=
st.qcow2
+    $ ./qemu-system-x86_64 -cdrom debian.iso \
+          -drive file=3Dblkverify:raw.img:test.qcow2
=20
 If the installation is aborted when blkverify detects corruption, use qemu=
-io
 to explore the contents of the disk image at the sector in question.
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index c81ed35..b26f240 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -707,7 +707,7 @@ the following approaches:
 1) Set ``qemu_bin``, and use the given binary
=20
 2) Do not set ``qemu_bin``, and use a QEMU binary named like
-   "${arch}-softmmu/qemu-system-${arch}", either in the current
+   "qemu-system-${arch}", either in the current
    working directory, or in the current source tree.
=20
 The resulting ``qemu_bin`` value will be preserved in the
@@ -763,7 +763,7 @@ like the following:
=20
 .. code::
=20
-  PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-system-x=
86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
+  PARAMS (key=3Dqemu_bin, path=3D*, default=3D./qemu-system-x86_64) =3D> '=
./qemu-system-x86_64
=20
 arch
 ~~~~
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-blo=
ck-operations.rst
index 48afdc7..e13f5a2 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -129,7 +129,7 @@ To show some example invocations of command-line, we wi=
ll use the
 following invocation of QEMU, with a QMP server running over UNIX
 socket::
=20
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=3Dnode-A,driver=3Dqcow2,file.driver=3Dfile,fil=
e.node-name=3Dfile,file.filename=3D./a.qcow2 \
         -device virtio-blk,drive=3Dnode-A,id=3Dvirtio0 \
@@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted ear=
lier, for
 simplicity's sake, the destination QEMU is started on the same host, but
 it could be located elsewhere)::
=20
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=3Dnode-TargetDisk,driver=3Dqcow2,file.driver=
=3Dfile,file.node-name=3Dfile,file.filename=3D./target-disk.qcow2 \
         -device virtio-blk,drive=3Dnode-TargetDisk,id=3Dvirtio0 \
diff --git a/meson.build b/meson.build
index 655571c..ab53b62 100644
--- a/meson.build
+++ b/meson.build
@@ -170,10 +170,12 @@ brlapi =3D declare_dependency()
 if 'CONFIG_BRLAPI' in config_host
   brlapi =3D declare_dependency(link_args: config_host['BRLAPI_LIBS'].spli=
t())
 endif
+sdlwindows =3D false
 sdl =3D declare_dependency()
 if 'CONFIG_SDL' in config_host
   sdl =3D declare_dependency(compile_args: config_host['SDL_CFLAGS'].split=
(),
                            link_args: config_host['SDL_LIBS'].split())
+  sdlwindows =3D config_host['SDL_LIBS'].contains('-mwindows')
 endif
 rbd =3D declare_dependency()
 if 'CONFIG_RBD' in config_host
@@ -754,6 +756,7 @@ foreach target : target_dirs
   arch =3D config_target['TARGET_BASE_ARCH']
   arch_srcs =3D []
   arch_deps =3D []
+  link_args =3D []
=20
   target_inc =3D [include_directories('target' / config_target['TARGET_BAS=
E_ARCH'])]
   if host_machine.system() =3D=3D 'linux'
@@ -774,6 +777,7 @@ foreach target : target_dirs
     arch_srcs +=3D hw.sources()
     arch_srcs +=3D target_devices_h[target]
     arch_deps +=3D hw.dependencies()
+    link_args =3D ['@block.syms', '@qemu.syms']
   else
     target_type=3D'user'
     qemu_target_name =3D 'qemu-' + target_name
@@ -827,6 +831,26 @@ foreach target : target_dirs
                           '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format=
(target),
                           '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.form=
at(target)],
                  name_suffix: 'fa')
+
+  execs =3D [{'postfix': '', 'gui': false}]
+  if sdlwindows
+    execs +=3D [{'postfix': 'w', 'gui': true}]
+  endif
+  foreach exe: execs
+    exe_name =3D qemu_target_name + exe['postfix']
+    executable(exe_name,
+               install: true,
+               sources: target_specific.sources() + arch_srcs + [config_ta=
rget_h],
+               dependencies: [qom, qemuutil] + target_specific.dependencie=
s() + arch_deps + deps,
+               link_depends: [block_syms, qemu_syms],
+               link_args: link_args,
+               objects: objects,
+               gui_app: exe['gui'],
+               include_directories: target_inc,
+               c_args: ['-DNEED_CPU_H',
+                        '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format(t=
arget),
+                        '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.format=
(target)])
+  endforeach
 endforeach
=20
 # Other build targets
diff --git a/os-posix.c b/os-posix.c
index 3cd52e1..b2c6ae7 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -93,7 +93,7 @@ char *os_find_datadir(void)
     exec_dir =3D qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir !=3D NULL, NULL);
=20
-    dir =3D g_build_filename(exec_dir, "..", "pc-bios", NULL);
+    dir =3D g_build_filename(exec_dir, "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
     }
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 15f213a..3add052 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -384,7 +384,7 @@ def binariesToTest(args, testcase):
     if args.qemu:
         r =3D args.qemu
     else:
-        r =3D glob.glob('./*-softmmu/qemu-system-*')
+        r =3D glob.glob('./qemu-system-*')
     return r
=20
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 659f087..7bab8e5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -896,9 +896,9 @@ define do_test_tap
 endef
=20
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
-$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/a=
ll $(check-qtest-y)
+$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qte=
st-y)
 =09$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
-=09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
+=09  QTEST_QEMU_BINARY=3D$(BUILD_DIR)/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
 check-unit: $(check-unit-y)
@@ -909,9 +909,9 @@ check-speed: $(check-speed-y)
=20
 # gtester tests with TAP output
=20
-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qt=
est-%.tap: %-softmmu/all $(check-qtest-y)
+$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qt=
est-%.tap: $(check-qtest-y)
 =09$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
-=09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
+=09  QTEST_QEMU_BINARY=3D$(BUILD_DIR)/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
 check-report-unit.tap: $(check-unit-y)
@@ -1098,8 +1098,7 @@ QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(=
CONFIG_LINUX)) =3D tests/qemu
=20
 .PHONY: check-tests/check-block.sh
 check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
-=09=09qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-=09=09$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
+=09=09qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 =09$<
=20
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index aee5d82..754e4e1 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -39,8 +39,7 @@ def pick_default_qemu_bin(arch=3DNone):
     """
     if arch is None:
         arch =3D os.uname()[4]
-    qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
-                                          "qemu-system-%s" % arch)
+    qemu_bin_relative_path =3D "qemu-system-%s" % arch
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebu=
ild-expected-aml.sh
index f89d462..0193562 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
=20
-qemu_bins=3D"x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system=
-aarch64"
+qemu_bins=3D"./qemu-system-x86_64 ./qemu-system-aarch64"
=20
 if [ ! -e "tests/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this s=
cript."
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index 3a25dda..184b5b4 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -226,7 +226,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void=
 *arg);
  *        my_test <--consumed_by-- my_interface <--produces--+
  *
  * Assuming there the binary is
- * QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
+ * QTEST_QEMU_BINARY=3D./qemu-system-x86_64
  * a valid test path will be:
  * "/x86_64/pc/other_node/my_driver/my_interface/my_test".
  *
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 98df91e..f968bf7 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -20,7 +20,7 @@
 # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N
 # THE SOFTWARE.
=20
-QEMU=3D${QEMU:-"../../x86_64-softmmu/qemu-system-x86_64"}
+QEMU=3D${QEMU:-"../../qemu-system-x86_64"}
=20
 run_qemu() {
     local kernel=3D$1
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index c24874f..a29651c 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -561,11 +561,11 @@ if [ -z "$QEMU_PROG" ]
 then
     if [ -x "$build_iotests/qemu" ]; then
         export QEMU_PROG=3D"$build_iotests/qemu"
-    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}" =
]; then
-        export QEMU_PROG=3D"$build_root/${qemu_arch}-softmmu/qemu-system-$=
{qemu_arch}"
+    elif [ -x "$build_root/qemu-system-${qemu_arch}" ]; then
+        export QEMU_PROG=3D"$build_root/qemu-system-${qemu_arch}"
     else
         pushd "$build_root" > /dev/null
-        for binary in *-softmmu/qemu-system-*
+        for binary in qemu-system-*
         do
             if [ -x "$binary" ]
             then
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index ee88867..c936bec 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -32,7 +32,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
=20
     if (strcmp(arch, "ppc64")) {
-        g_printerr("RTAS requires ppc64-softmmu/qemu-system-ppc64\n");
+        g_printerr("RTAS requires qemu-system-ppc64\n");
         exit(EXIT_FAILURE);
     }
     qtest_add_func("rtas/get-time-of-day", test_rtas_get_time_of_day);
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8808bea..9f5092b 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -63,6 +63,12 @@ CFLAGS=3D
 QEMU_CFLAGS=3D
 LDFLAGS=3D
=20
+# The QEMU for this TARGET
+ifdef CONFIG_USER_ONLY
+QEMU=3D../../qemu-$(TARGET_NAME)
+else
+QEMU=3D../../qemu-system-$(TARGET_NAME)
+endif
 QEMU_OPTS=3D
=20
=20
--=20
1.8.3.1



