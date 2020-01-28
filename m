Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CBBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AE5207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzZFIxF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AE5207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVtE-0005ep-Hx
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5h-0000X4-TZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5g-00035L-8m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5f-000336-OZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:55 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c9so17105148wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eoheQ8HlhGuMbB55vzhA1L21TCFP+rW1Af+5caLX/8s=;
 b=FzZFIxF9wj4nBUsAtUK1/qi8D7pcn2GmKKd6pdlhJPcPs/SMkqNwOTkP0BXBIQdd3u
 TfnrskRVpDpoQbXgaSjiXVHAqb+nBNGK7vk/QWFhQAswQf5nvmFajBARDf6sU4tZd+JC
 qCDCVr76uTHvoBztlZs/dayTZ9x4dxeE9pbudiaV2ctERet8Hfh68uZs+2rI5klSpMt5
 RKuDc3Zgu33yZ1CZ57TYPMdTT/kXDG16ooiuc4O5GVfhyxPkHEE9N7fECRmyerwEqBDt
 Eg5DLIy5QbLPWgU0kp1mZ0rZSt6BCFZabEbVPhNO2+9HXEYAzQYF66xkNpG5G6u/jhxW
 PXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eoheQ8HlhGuMbB55vzhA1L21TCFP+rW1Af+5caLX/8s=;
 b=tChguMcMOxu07Ov7xE2lisyh0l5wjy/96Ji4g02CVxlI0baBhOpwrlRDwnrF/sJVUh
 6RzzHXm/FMlkxTIPbCF55uwHTuZuanefShRuOt2Mub3JITXwHdLB8jFlih/6K+mvuq/a
 c9byzyWiFBOO0/xNt7Q0C/EY1/zerbHcbT3uPFmMPeZd01AmrGisbGnugYgk0ll0hvGN
 4sA48Ql2rmvT/gZWvcxTvYidK1Va8ZS7t55mXBKG4LDjtuepqfyer631J2JTu9O+japJ
 igNT4xz3xo9eqIhCdnvaSB+9T262v7q3lbvN2UYDgJFbDBqJUXFSwYws72xdbVmM3sZI
 4+7Q==
X-Gm-Message-State: APjAAAVb2NX16lk6X8OQa4W2gouTki4900vcMCFoxpK49YCW1hlS8CIV
 bCOLw22G08qmCMOyEWZ6mZNRLbri
X-Google-Smtp-Source: APXvYqx6yvyGdduJUQZ7/bfH4bUhGuMUVHF1NCbbq6fQkh6VQStIRZliY9Qj0VRm8un3ZebfTI8YJQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr29344908wro.310.1580234154273; 
 Tue, 28 Jan 2020 09:55:54 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 053/142] meson: convert audio directory to Meson
Date: Tue, 28 Jan 2020 18:52:13 +0100
Message-Id: <20200128175342.9066-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       |  8 ++++++--
 Makefile.target     |  3 ++-
 audio/Makefile.objs | 30 ------------------------------
 audio/meson.build   | 29 +++++++++++++++++++++++++++++
 configure           | 12 ++++++++++++
 meson.build         | 25 ++++++++++++++++++++++++-
 6 files changed, 73 insertions(+), 34 deletions(-)
 delete mode 100644 audio/Makefile.objs
 create mode 100644 audio/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 32822e3c7e..68bb44f875 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -36,6 +36,7 @@ qom-obj-y = qom/libqom.fa
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
+
 common-obj-y += bootdevice.o iothread.o
 common-obj-y += dump/
 common-obj-y += job-qmp.o
@@ -50,6 +51,11 @@ common-obj-$(CONFIG_LINUX) += fsdev/
 common-obj-y += accel/
 common-obj-y += migration/
 
+common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
+common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
+
 common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
 common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
 common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
@@ -60,8 +66,6 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
-common-obj-y += audio/
-common-obj-m += audio/
 common-obj-y += hw/
 
 common-obj-y += replay/
diff --git a/Makefile.target b/Makefile.target
index d98e956e42..15157c7684 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -167,9 +167,10 @@ LIBS := $(libs_softmmu) $(LIBS)
 # Temporary until emulators are linked by Meson
 LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
-LIBS := $(LIBS)
+LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
+LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
deleted file mode 100644
index d7490a379f..0000000000
--- a/audio/Makefile.objs
+++ /dev/null
@@ -1,30 +0,0 @@
-common-obj-y = audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
-common-obj-$(CONFIG_SPICE) += spiceaudio.o
-common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
-common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
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
index 0000000000..5146dbd87c
--- /dev/null
+++ b/audio/meson.build
@@ -0,0 +1,29 @@
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
index 1dd48e4f8b..434c24f0f0 100755
--- a/configure
+++ b/configure
@@ -3505,6 +3505,8 @@ for drv in $audio_drv_list; do
     alsa | try-alsa)
     if $pkg_config alsa --exists; then
         alsa_libs=$($pkg_config alsa --libs)
+        alsa_cflags=$($pkg_config alsa --cflags)
+        alsa=yes
         if test "$drv" = "try-alsa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa/alsa/')
         fi
@@ -3520,7 +3522,9 @@ for drv in $audio_drv_list; do
 
     pa | try-pa)
     if $pkg_config libpulse --exists; then
+        libpulse=yes
         pulse_libs=$($pkg_config libpulse --libs)
+        pulse_cflags=$($pkg_config libpulse --cflags)
         if test "$drv" = "try-pa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa/pa/')
         fi
@@ -6760,8 +6764,16 @@ for drv in $audio_drv_list; do
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
index 4c42df980f..d66d49152b 100644
--- a/meson.build
+++ b/meson.build
@@ -111,6 +111,16 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
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
@@ -180,6 +190,18 @@ liblzfse = declare_dependency()
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
@@ -469,6 +491,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
@@ -498,7 +521,7 @@ foreach d, list : modules
       else
         softmmu_mods += sl
       endif
-      mods += {'dir': d, 'name': m[0], 'lib': sl, 'deps': m[2]}
+      mods += {'dir': d, 'name': m[0], 'lib': [sl, libmodulecommon], 'deps': m[2]}
     else
       if d == 'block'
         block_ss.add(when: m[2], if_true: m[1])
-- 
2.21.0



