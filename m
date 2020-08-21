Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81077C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4426520656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI3jvaAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4426520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94g0-0002sC-Gc
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E1-0002bY-AB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dt-0001gC-JB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SCqAi82ObMhl1SJg7t3ay/JMkiOBP7HjkklKHmVHYc=;
 b=PI3jvaAUgJZo0iSkPI5hb9BS+rJDsXsEQmhi1eZbdCZfijDsviYcxQblc1sT3WStAcYaVh
 KVzc6u5+NCcN6AhNGk5aAY9LbcsvmWjzM+XSkSQcu0q4Z4C4XrKDOrDIw27NNWLa6Qm7vz
 s9JHdmqZ0ASicG4UZv0Ky7H58cwZo1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-abe-wyPSMV-AV3CgqFqs-A-1; Fri, 21 Aug 2020 06:24:32 -0400
X-MC-Unique: abe-wyPSMV-AV3CgqFqs-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8802D191E2A0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 702195C1D7;
 Fri, 21 Aug 2020 10:24:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 071/152] meson: convert audio directory to Meson
Date: Fri, 21 Aug 2020 06:22:08 -0400
Message-Id: <20200821102329.29777-72-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index 8109ac027e..396472b332 100755
--- a/configure
+++ b/configure
@@ -3763,6 +3763,8 @@ for drv in $audio_drv_list; do
     alsa | try-alsa)
     if $pkg_config alsa --exists; then
         alsa_libs=$($pkg_config alsa --libs)
+        alsa_cflags=$($pkg_config alsa --cflags)
+        alsa=yes
         if test "$drv" = "try-alsa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa/alsa/')
         fi
@@ -3778,7 +3780,9 @@ for drv in $audio_drv_list; do
 
     pa | try-pa)
     if $pkg_config libpulse --exists; then
+        libpulse=yes
         pulse_libs=$($pkg_config libpulse --libs)
+        pulse_cflags=$($pkg_config libpulse --cflags)
         if test "$drv" = "try-pa"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa/pa/')
         fi
@@ -3821,6 +3825,7 @@ for drv in $audio_drv_list; do
 
     jack | try-jack)
     if $pkg_config jack --exists; then
+        libjack=yes
         jack_libs=$($pkg_config jack --libs)
         if test "$drv" = "try-jack"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-jack/jack/')
@@ -7032,11 +7037,22 @@ for drv in $audio_drv_list; do
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
index 99daa91666..e1e70d4b48 100644
--- a/meson.build
+++ b/meson.build
@@ -147,6 +147,20 @@ if 'CONFIG_XKBCOMMON' in config_host
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
@@ -217,6 +231,18 @@ liblzfse = not_found
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
@@ -518,6 +544,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
-- 
2.26.2



