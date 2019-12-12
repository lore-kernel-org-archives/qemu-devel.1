Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF546C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B2621655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbCW1a05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B2621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOM4-00071n-H9
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyW-0003lZ-Hq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyU-00072E-Lr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyU-00070d-DY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id b6so2660299wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PDS3sRtQt9ex0lZCsWKH5I9q43dgFGB5z0KrGLDuW6I=;
 b=bbCW1a05pHvJnTpaXeRCcdgvaxIF03U+nM4O5mRstdSUqEYHM5cyzx0MsCtOfLLuyq
 TB3/NGHQUVEtudCc5PZZ4uCMkiRyEFyGF1GzXOi+klCpJ7t4ZUhsbZHsBHeUdGm2zYAY
 2QnKJiKC7fF2Aa4cjQKOt3kzn5jFzY9qw1qvYBXehH10q7f+wQltB1Xk0QXyUAv0JQ8G
 DsPJGS8C0GfjzO4QmmMm/FS63IOoARwB7ogsUEjQhK3Ie8JqS+Wi3VaFaCxZ4CxKGbDI
 KM/HA2cwsMsjMKrK9Mh+IyRh9/t+rxK+rGRFaxAz/GAmcA/fVWAJv4DJjpwbhEulJeAT
 TVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PDS3sRtQt9ex0lZCsWKH5I9q43dgFGB5z0KrGLDuW6I=;
 b=LGaigIznVkaoSFhE7VaVw9VEPrMOh7qeCs7NP0N84O8QpwsDWm3YzqDZ+a8c70td8k
 R+FDb5lbktCnWUyxdeh3f8P2Cap/ftgXxGV5DX9B3v3TtJY91BNpS9RyImCTUufLd3da
 YXYJidxozJx96vA6RQQrejjjSpFxIzcZz+I11FgLhz3TYNSFDmxwJAi4VrxNTc+stRFP
 Li+TeqUCe+AcbyFoCKI6CfDM0vKjVMuIWPQ8zz+9n1qpREcn/f/NntS3J+vnjvyIeq6R
 61OfRTgX83lHQBjqmu09TSN8jm+YMc3OtHUCbtGCTVxxWJTv9ngqGeIuAyBcGqUf5Zpf
 6B4g==
X-Gm-Message-State: APjAAAWzHR2KnrSchnwqOMEy1kKamzF62BlVhujbkMT4IwlEV1yMTl29
 ap/AUT4aUzYGZqP3Ozd8kWJtef+F
X-Google-Smtp-Source: APXvYqyYAFPF1DGorRZtk3C8ONhVjL/YvxbTOpl79FrHSErzBn+FqUw4XlEKks/KXwYfWNk9f2RXiA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr6369819wrs.213.1576155225014; 
 Thu, 12 Dec 2019 04:53:45 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 047/132] meson: convert audio directory to Meson
Date: Thu, 12 Dec 2019 13:51:31 +0100
Message-Id: <1576155176-2464-48-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       |  8 ++++++--
 Makefile.target     |  6 ++++--
 audio/Makefile.objs | 31 -------------------------------
 audio/meson.build   | 30 ++++++++++++++++++++++++++++++
 configure           | 12 ++++++++++++
 meson.build         | 25 ++++++++++++++++++++++++-
 6 files changed, 76 insertions(+), 36 deletions(-)
 delete mode 100644 audio/Makefile.objs
 create mode 100644 audio/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 8d14390..cea6f9a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -36,6 +36,7 @@ qom-obj-y = qom/libqom.fa
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
+
 common-obj-y += bootdevice.o iothread.o
 common-obj-y += dump/
 common-obj-y += job-qmp.o
@@ -49,6 +50,11 @@ common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += migration/
 
+common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
+
 common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
 common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
 common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
@@ -59,8 +65,6 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
-common-obj-y += audio/
-common-obj-m += audio/
 common-obj-y += hw/
 
 common-obj-y += replay/
diff --git a/Makefile.target b/Makefile.target
index 702e6f8..65f1312 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -165,9 +165,11 @@ LIBS := $(libs_softmmu) $(LIBS)
 # Temporary until emulators are linked by Meson
 LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
-LIBS := $(LIBS)
+LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
+LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
+
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
@@ -193,7 +195,7 @@ dummy := $(call fix-paths,../,, \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                common-obj-y \
-               common-obj-m)
+	       common-obj-m)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
deleted file mode 100644
index dca87f6..0000000
--- a/audio/Makefile.objs
+++ /dev/null
@@ -1,31 +0,0 @@
-common-obj-y = audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
-common-obj-$(CONFIG_SPICE) += spiceaudio.o
-common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
-common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
-common-obj-$(CONFIG_AUDIO_PT_INT) += audio_pt_int.o
-common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
-common-obj-y += wavcapture.o
-
-coreaudio.o-libs := $(COREAUDIO_LIBS)
-dsoundaudio.o-libs := $(DSOUND_LIBS)
-
-# alsa module
-common-obj-$(CONFIG_AUDIO_ALSA) += alsa.mo
-alsa.mo-objs = alsaaudio.o
-alsa.mo-libs := $(ALSA_LIBS)
-
-# oss module
-common-obj-$(CONFIG_AUDIO_OSS) += oss.mo
-oss.mo-objs = ossaudio.o
-oss.mo-libs := $(OSS_LIBS)
-
-# pulseaudio module
-common-obj-$(CONFIG_AUDIO_PA) += pa.mo
-pa.mo-objs = paaudio.o
-pa.mo-libs := $(PULSE_LIBS)
-
-# sdl module
-common-obj-$(CONFIG_AUDIO_SDL) += sdl.mo
-sdl.mo-objs = sdlaudio.o
-sdl.mo-cflags := $(SDL_CFLAGS)
-sdl.mo-libs := $(SDL_LIBS)
diff --git a/audio/meson.build b/audio/meson.build
new file mode 100644
index 0000000..e58a936
--- /dev/null
+++ b/audio/meson.build
@@ -0,0 +1,30 @@
+softmmu_ss.add(files(
+  'audio.c',
+  'audio_legacy.c',
+  'mixeng.c',
+  'noaudio.c',
+  'wavaudio.c',
+  'wavcapture.c',
+))
+
+softmmu_ss.add(when: [spice, 'CONFIG_SPICE'], if_true: files('spiceaudio.c'))
+softmmu_ss.add(when: [coreaudio, 'CONFIG_AUDIO_COREAUDIO'], if_true: files('coreaudio.c'))
+softmmu_ss.add(when: [dsound, 'CONFIG_AUDIO_DSOUND'], if_true: files('dsoundaudio.c'))
+softmmu_ss.add(when: ['CONFIG_AUDIO_PT_INT'], if_true: files('audio_pt_int.c'))
+softmmu_ss.add(when: ['CONFIG_AUDIO_WIN_INT'], if_true: files('audio_win_int.c'))
+
+audio_modules = []
+if 'CONFIG_AUDIO_ALSA' in config_host
+  audio_modules += [['alsa', files('alsaaudio.c'), alsa]]
+endif
+if 'CONFIG_AUDIO_OSS' in config_host
+  audio_modules += [['oss', files('ossaudio.c'), oss]]
+endif
+if 'CONFIG_AUDIO_PA' in config_host
+  audio_modules += [['pa', files('paaudio.c'), pulse]]
+endif
+if 'CONFIG_AUDIO_SDL' in config_host
+  audio_modules += [['sdl', files('sdlaudio.c'), sdl]]
+endif
+
+modules += {'audio': audio_modules}
diff --git a/configure b/configure
index 9d33df3..0be0735 100755
--- a/configure
+++ b/configure
@@ -3396,6 +3396,8 @@ for drv in $audio_drv_list; do
     alsa | try-alsa)
     if $pkg_config alsa --exists; then
         alsa_libs=$($pkg_config alsa --libs)
+        alsa_cflags=$($pkg_config alsa --cflags)
+        alsa=yes
         if test "$drv" = "try-alsa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa/alsa/')
         fi
@@ -3411,7 +3413,9 @@ for drv in $audio_drv_list; do
 
     pa | try-pa)
     if $pkg_config libpulse --exists; then
+        libpulse=yes
         pulse_libs=$($pkg_config libpulse --libs)
+        pulse_cflags=$($pkg_config libpulse --cflags)
         audio_pt_int="yes"
         if test "$drv" = "try-pa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa/pa/')
@@ -6589,8 +6593,16 @@ for drv in $audio_drv_list; do
 	    echo "$def=y" >> $config_host_mak ;;
     esac
 done
+if test "$alsa" = "yes" ; then
+    echo "CONFIG_ALSA=y" >> $config_host_mak
+fi
 echo "ALSA_LIBS=$alsa_libs" >> $config_host_mak
+echo "ALSA_CFLAGS=$alsa_cflags" >> $config_host_mak
+if test "$libpulse" = "yes" ; then
+    echo "CONFIG_LIBPULSE=y" >> $config_host_mak
+fi
 echo "PULSE_LIBS=$pulse_libs" >> $config_host_mak
+echo "PULSE_CFLAGS=$pulse_cflags" >> $config_host_mak
 echo "COREAUDIO_LIBS=$coreaudio_libs" >> $config_host_mak
 echo "DSOUND_LIBS=$dsound_libs" >> $config_host_mak
 echo "OSS_LIBS=$oss_libs" >> $config_host_mak
diff --git a/meson.build b/meson.build
index df16b58..90a15ad 100644
--- a/meson.build
+++ b/meson.build
@@ -107,6 +107,16 @@ if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
 xkbcommon = dependency('xkbcommon', required: false)
+pulse = declare_dependency()
+if 'CONFIG_LIBPULSE' in config_host
+  pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
+                             link_args: config_host['PULSE_LIBS'].split())
+endif
+alsa = declare_dependency()
+if 'CONFIG_ALSA' in config_host
+  alsa = declare_dependency(compile_args: config_host['ALSA_CFLAGS'].split(),
+                            link_args: config_host['ALSA_LIBS'].split())
+endif
 spice = declare_dependency()
 if 'CONFIG_SPICE' in config_host
   spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
@@ -176,6 +186,18 @@ liblzfse = declare_dependency()
 if 'CONFIG_LZFSE' in config_host
   liblzfse = declare_dependency(link_args: config_host['LZFSE_LIBS'].split())
 endif
+oss = declare_dependency()
+if 'CONFIG_AUDIO_OSS' in config_host
+  oss = declare_dependency(link_args: config_host['OSS_LIBS'].split())
+endif
+dsound = declare_dependency()
+if 'CONFIG_AUDIO_DSOUND' in config_host
+  dsound = declare_dependency(link_args: config_host['DSOUND_LIBS'].split())
+endif
+coreaudio = declare_dependency()
+if 'CONFIG_AUDIO_COREAUDIO' in config_host
+  coreaudio = declare_dependency(link_args: config_host['COREAUDIO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -453,6 +475,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
@@ -481,7 +504,7 @@ foreach d, list : modules
       else
         softmmu_mods += sl
       endif
-      mods += {'dir': d, 'name': m[0], 'lib': sl, 'deps': m[2]}
+      mods += {'dir': d, 'name': m[0], 'lib': [sl, libmodulecommon], 'deps': m[2]}
     else
       if d == 'block'
         block_ss.add(when: m[2], if_true: m[1])
-- 
1.8.3.1



