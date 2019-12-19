Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3CCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7B620716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/+gMEiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7B620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvIw-0004SI-IW
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihure-00009R-P4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurc-0001gu-VG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurc-0001cl-OV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTp3AFdVG+9DbuSB4ysWaPGf33poJXFBs+GyAx0PFd8=;
 b=A/+gMEiFh4WvH6M1cAcwyEUciRoYtD3yabdm0DNox+HM7NN3PhM3z0Mtwd5np4qgUJ2NN2
 0VQwpgEPNosSjaywY3QpDFpF6lc0b3wzIPxBbFm4xLN/X+47qCnsxsxoLW2k6Dm+nXhcEv
 sIJycdL7BqPjXk8+H0Qhtfp4/Qv7wgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-6dzoZy3lNq-EPnkSd5cKUw-1; Thu, 19 Dec 2019 07:25:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3687184BEC0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:05 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7959460C18;
 Thu, 19 Dec 2019 12:25:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 115/132] remove Makefile.target
Date: Thu, 19 Dec 2019 13:23:35 +0100
Message-Id: <1576758232-12439-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6dzoZy3lNq-EPnkSd5cKUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile        | 32 +++-----------------------------
 Makefile.objs   | 27 ---------------------------
 Makefile.target | 13 -------------
 configure       |  2 --
 meson.build     |  9 ---------
 5 files changed, 3 insertions(+), 80 deletions(-)
 delete mode 100644 Makefile.target

diff --git a/Makefile b/Makefile
index afb5e26..f2152ce 100644
--- a/Makefile
+++ b/Makefile
@@ -184,10 +184,9 @@ $(ROM_DIRS_RULES):
 =09$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))" $(notdir =
$@),)
=20
 .PHONY: recurse-all recurse-clean recurse-install
-recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-install: $(addsuffix /install, $(TARGET_DIRS))
-$(addsuffix /install, $(TARGET_DIRS)): all
+recurse-all: $(ROM_DIRS)
+recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
+recurse-install:
=20
 ######################################################################
=20
@@ -265,9 +264,6 @@ distclean: clean
 =09$(call clean-manual,devel)
 =09$(call clean-manual,interop)
 =09$(call clean-manual,specs)
-=09for d in $(TARGET_DIRS); do \
-=09rm -rf $$d || exit 1 ; \
-        done
 =09rm -Rf .sdk
 =09if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
=20
@@ -419,9 +415,6 @@ endif
 =09set -e; for x in $(KEYMAPS); do \
 =09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_da=
tadir)/keymaps"; \
 =09done
-=09for d in $(TARGET_DIRS); do \
-=09$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; \
-        done
=20
 .PHONY: ctags
 ctags:
@@ -525,20 +518,6 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-re=
f.html \
=20
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
=20
-# Reports/Analysis
-
-%/coverage-report.html:
-=09@mkdir -p $*
-=09$(call quiet-command,\
-=09=09gcovr -r $(SRC_PATH) \
-=09=09$(foreach t, $(TARGET_DIRS), --object-directory $(BUILD_DIR)/$(t)) \
-=09=09 --object-directory $(BUILD_DIR) \
-=09=09-p --html --html-details -o $@, \
-=09=09"GEN", "coverage-report.html")
-
-.PHONY: coverage-report
-coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-
 ifdef CONFIG_WIN32
=20
 INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
@@ -622,11 +601,6 @@ endif
 =09@echo  '  ctags/TAGS      - Generate tags file for editors'
 =09@echo  '  cscope          - Generate cscope index'
 =09@echo  ''
-=09@$(if $(TARGET_DIRS), \
-=09=09echo 'Architecture specific targets:'; \
-=09=09$(foreach t, $(TARGET_DIRS), \
-=09=09printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \
-=09=09echo '')
 =09@echo  'Cleaning targets:'
 =09@echo  '  clean           - Remove most generated files but keep the co=
nfig'
 =09@echo  '  distclean       - Remove all generated files'
diff --git a/Makefile.objs b/Makefile.objs
index 9fd3932..654667f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -28,30 +28,3 @@ crypto-obj-y =3D crypto/libcrypto.fa
 io-obj-y =3D io/libio.fa
=20
 qom-obj-y =3D qom/libqom.fa
-
-######################################################################
-# Target independent part of system emulation. The long term path is to
-# suppress *all* target specific code in case of system emulation, i.e. a
-# single QEMU executable should support all CPUs and machines.
-
-ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-$(CONFIG_AUDIO_ALSA) +=3D audio-alsa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_OSS) +=3D audio-oss$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_PA) +=3D audio-pa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_SDL) +=3D audio-sdl$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURSES),m) +=3D ui-curses$(DSOSUF)
-common-obj-$(if $(CONFIG_GTK),m) +=3D ui-gtk$(DSOSUF)
-common-obj-$(if $(CONFIG_SDL),m) +=3D ui-sdl$(DSOSUF)
-common-obj-$(if $(CONFIG_SPICE),m) +=3D ui-spice-app$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURL),m) +=3D block-curl$(DSOSUF)
-common-obj-$(if $(CONFIG_GLUSTERFS),m) +=3D block-gluster$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBISCSI),m) +=3D block-iscsi$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBNFS),m) +=3D block-nfs$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBSSH),m) +=3D block-ssh$(DSOSUF)
-common-obj-$(if $(CONFIG_RBD),m) +=3D block-rbd$(DSOSUF)
-
-common-obj-$(if $(CONFIG_LZFSE),m) +=3D block-dmg-lzfse$(DSOSUF)
-common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) +=3D block-dmg-bz2=
$(DSOSUF)
-endif
diff --git a/Makefile.target b/Makefile.target
deleted file mode 100644
index 4f72a89..0000000
--- a/Makefile.target
+++ /dev/null
@@ -1,13 +0,0 @@
-# -*- Mode: makefile -*-
-
-BUILD_DIR?=3D$(CURDIR)/..
-
-include ../config-host.mak
-include config-target.mak
-include $(SRC_PATH)/rules.mak
-
-all:
-clean:
-install: all
-=09
-.PHONY: all clean install
diff --git a/configure b/configure
index ad36082..f6e3b0a 100755
--- a/configure
+++ b/configure
@@ -7597,8 +7597,6 @@ if [ "$TARGET_BASE_ARCH" =3D "" ]; then
   TARGET_BASE_ARCH=3D$TARGET_ARCH
 fi
=20
-symlink "$source_path/Makefile.target" "$target_dir/Makefile"
-
 upper() {
     echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'
 }
diff --git a/meson.build b/meson.build
index 4fb3bdc..55ccb79 100644
--- a/meson.build
+++ b/meson.build
@@ -823,15 +823,6 @@ foreach target : target_dirs
                               command: [create_config, '@INPUT@'])
=20
   target_specific =3D specific_ss.apply(config_target, strict: false)
-  static_library('qemu-' + target,
-                 sources: target_specific.sources() + arch_srcs + [config_=
target_h],
-                 dependencies: target_specific.dependencies() + arch_deps =
+ deps,
-                 objects: objects,
-                 include_directories: target_inc,
-                 c_args: ['-DNEED_CPU_H',
-                          '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format=
(target),
-                          '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.form=
at(target)],
-                 name_suffix: 'fa')
=20
   execs =3D [{'postfix': '', 'gui': false}]
   if sdlwindows
--=20
1.8.3.1



