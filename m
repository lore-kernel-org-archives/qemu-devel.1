Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754D8204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTSljtP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754D8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gjH-0004OU-Lj
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHY-0005CO-LM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHU-0006EG-Ha
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id a5so15259763wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXdjHqDn7Dx5PCb35bX2WOyvYxDDE/R6Ug79m5dFQdc=;
 b=FTSljtP6QQzBCvBVePRrLHxknzFAhwVLzYODcQv97uFXYoaVNXpU/lCril8f9enlL/
 Kn2DikM+Q9ugDlZIpaUBDLdDCudDKbZeRERDssHhowhshuw60f34OgpVOxMgCrGwhEHu
 eWWafHGYFHgpIhMYWipqyeW/tnb2+Yli1n2z5dSs5fMydnrGxuASgRCeWhdJtihlGn7B
 qngo8AI7+DWWLSwIheKhxqO6lWbFIB4aBliMNXdwmFKCdKODv1RvjkSga6jsKvASYb7R
 xCAHjRcezGdw7nqzFpSTzc1SxdgqyyehWnvN5z6DIVugW4Suv/ElfzZOzGctdZu/r7bK
 3qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aXdjHqDn7Dx5PCb35bX2WOyvYxDDE/R6Ug79m5dFQdc=;
 b=S5vi7JlkQiwVEop5NvcpsPuzwFhZAchuySHEtwGQnFLGK4a9njZ5nyuXaDdNnMXe/I
 AudYdrhWi7tMk36z+syUDYZ2pVgFLdwXuyFTOjFquKHkwh+KlOQR6RFHVE/mNr30Otjt
 POlAvivVAjvtpwPR9fU44OQg4vgxwulk0oVyhPzpcbNNwp9pDNOO/XWDRgTYX6UV2sgi
 g9EZs5q//D1/egcN7bvWotJwCMnIWGOKajD1P3a3wjfytLlSvYlD0lV4bTe7FnXr1NYh
 n8RlwOTR1YAdmUCw6WFU2MLcczgWW1OrSsP0SvyYcDQQb6RX5jSN1VDODk2Jbndf1Ywf
 Q+2Q==
X-Gm-Message-State: AOAM531nBDWPmapB2fsIzji1dh5n3KUse7gkXtNenERDYt8E2bsi7GQ3
 gKB+D2nyw3Og44NToYiTFTKG6tx8XFU=
X-Google-Smtp-Source: ABdhPJzEbwTQyUGGizfh3vPeEC1ISgEDQ9JQdH+64zZw/fr1L6Md7MAEjWKHGPQ8rvuUT7eIXwablg==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr15504446wrq.422.1597675114348; 
 Mon, 17 Aug 2020 07:38:34 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 069/150] meson: convert audio directory to Meson
Date: Mon, 17 Aug 2020 16:36:02 +0200
Message-Id: <20200817143723.343284-70-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       |  7 +++++--
 Makefile.target     |  3 ++-
 audio/Makefile.objs | 35 -----------------------------------
 audio/meson.build   | 30 ++++++++++++++++++++++++++++++
 configure           | 16 ++++++++++++++++
 meson.build         | 27 +++++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 38 deletions(-)
 delete mode 100644 audio/Makefile.objs
 create mode 100644 audio/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index e43526fe5f..ec7627a4c6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -63,6 +63,11 @@ common-obj-$(CONFIG_LINUX) += fsdev/
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
@@ -73,8 +78,6 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
-common-obj-y += audio/
-common-obj-m += audio/
 common-obj-y += hw/
 common-obj-m += hw/
 
diff --git a/Makefile.target b/Makefile.target
index c8c4b70162..ff0e1b2d10 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -166,9 +166,10 @@ LIBS := $(libs_softmmu) $(LIBS)
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
index b4a4c11f31..0000000000
--- a/audio/Makefile.objs
+++ /dev/null
@@ -1,35 +0,0 @@
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
-
-# jack module
-common-obj-$(CONFIG_AUDIO_JACK) += jack.mo
-jack.mo-objs = jackaudio.o
-jack.mo-libs := $(JACK_LIBS)
diff --git a/audio/meson.build b/audio/meson.build
new file mode 100644
index 0000000000..15c06ba045
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
+softmmu_ss.add(when: ['CONFIG_AUDIO_WIN_INT'], if_true: files('audio_win_int.c'))
+
+audio_modules = {}
+foreach m : [
+  ['CONFIG_AUDIO_ALSA', 'alsa', alsa, 'alsaaudio.c'],
+  ['CONFIG_AUDIO_OSS', 'oss', oss, 'ossaudio.c'],
+  ['CONFIG_AUDIO_PA', 'pa', pulse, 'paaudio.c'],
+  ['CONFIG_AUDIO_SDL', 'sdl', sdl, 'sdlaudio.c'],
+  ['CONFIG_AUDIO_JACK', 'jack', jack, 'jackaudio.c']
+]
+  if config_host.has_key(m[0])
+    module_ss = ss.source_set()
+    module_ss.add(when: m[2], if_true: files(m[3]))
+    audio_modules += {m[1] : module_ss}
+  endif
+endforeach
+
+modules += {'audio': audio_modules}
diff --git a/configure b/configure
index 50e74b1e79..f52556fef4 100755
--- a/configure
+++ b/configure
@@ -3718,6 +3718,8 @@ for drv in $audio_drv_list; do
     alsa | try-alsa)
     if $pkg_config alsa --exists; then
         alsa_libs=$($pkg_config alsa --libs)
+        alsa_cflags=$($pkg_config alsa --cflags)
+        alsa=yes
         if test "$drv" = "try-alsa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa/alsa/')
         fi
@@ -3733,7 +3735,9 @@ for drv in $audio_drv_list; do
 
     pa | try-pa)
     if $pkg_config libpulse --exists; then
+        libpulse=yes
         pulse_libs=$($pkg_config libpulse --libs)
+        pulse_cflags=$($pkg_config libpulse --cflags)
         if test "$drv" = "try-pa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa/pa/')
         fi
@@ -3776,6 +3780,7 @@ for drv in $audio_drv_list; do
 
     jack | try-jack)
     if $pkg_config jack --exists; then
+        libjack=yes
         jack_libs=$($pkg_config jack --libs)
         if test "$drv" = "try-jack"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-jack/jack/')
@@ -6987,11 +6992,22 @@ for drv in $audio_drv_list; do
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
+if test "$libjack" = "yes" ; then
+    echo "CONFIG_LIBJACK=y" >> $config_host_mak
+fi
 echo "JACK_LIBS=$jack_libs" >> $config_host_mak
 if test "$audio_win_int" = "yes" ; then
   echo "CONFIG_AUDIO_WIN_INT=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 06d9287005..9dda687575 100644
--- a/meson.build
+++ b/meson.build
@@ -143,6 +143,20 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+pulse = not_found
+if 'CONFIG_LIBPULSE' in config_host
+  pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
+                             link_args: config_host['PULSE_LIBS'].split())
+endif
+alsa = not_found
+if 'CONFIG_ALSA' in config_host
+  alsa = declare_dependency(compile_args: config_host['ALSA_CFLAGS'].split(),
+                            link_args: config_host['ALSA_LIBS'].split())
+endif
+jack = not_found
+if 'CONFIG_LIBJACK' in config_host
+  jack = declare_dependency(link_args: config_host['JACK_LIBS'].split())
+endif
 spice = not_found
 if 'CONFIG_SPICE' in config_host
   spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
@@ -213,6 +227,18 @@ liblzfse = not_found
 if 'CONFIG_LZFSE' in config_host
   liblzfse = declare_dependency(link_args: config_host['LZFSE_LIBS'].split())
 endif
+oss = not_found
+if 'CONFIG_AUDIO_OSS' in config_host
+  oss = declare_dependency(link_args: config_host['OSS_LIBS'].split())
+endif
+dsound = not_found
+if 'CONFIG_AUDIO_DSOUND' in config_host
+  dsound = declare_dependency(link_args: config_host['DSOUND_LIBS'].split())
+endif
+coreaudio = not_found
+if 'CONFIG_AUDIO_COREAUDIO' in config_host
+  coreaudio = declare_dependency(link_args: config_host['COREAUDIO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -514,6 +540,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
-- 
2.26.2



