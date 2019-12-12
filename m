Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85082C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4F0214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrQ2qq7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4F0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifObO-0003Xx-Nd
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyY-0003nj-05
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyW-00076v-GW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyW-000755-81
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id c14so2607563wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1/txV5t0S8rd0wKFy5mj47On35zo/mSGxOA86LohxE=;
 b=mrQ2qq7PGoCLzw7NTkVIhmAdYKBCFHnylM6srNq9OCfZq2k/3p3NR5igAY1MBFrKip
 OhFdWMC2mJ956HfUeNwo3+j2DXWYTzSJ7S/o8eUIUd3nbc2w2JiXZJfgH3xLeXFx70T8
 LVeEaXGhXJaXtNilK2hukTHzLL/KKCGeSvRmvHycjTBk6KL+b+IYO8U5KOJK16WROkwB
 99LibKb+nrSj3s2LD4qoYZfAz5b6p5GeWWbtGcQ+cL0lejDdJeo5wXIivC4+Ex9Ae7Ka
 lPtzWr5F5vzqlGqPVeBHvZz8n1Q7dsA8uR2cGuSvUewowOdEnKhWUv+yCiMvbR5tq9Px
 LlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w1/txV5t0S8rd0wKFy5mj47On35zo/mSGxOA86LohxE=;
 b=k1W45e7toolnS7o4YDNVyc/B6Xy3/uNMk9FWcqH0FmTxqfoJsiAt7B0Ye2awCaxiep
 B+YVIaflDt26wCzr2lAg+Yr8mormh0ZSDdNTNNdGDCeomxWjzY54Hd1nYpn5mqwJGJck
 JHM/da0w19j7mH78DGBhoiE8EB28yf3uHXvYvdSysnL1LQFpTSdsmh/a2XVsGYBZH0s4
 yy6IeB25GonZu0T0yyaJ72O/AFcMN+oxb7RcqY+TOYsQKrPkA+lxZcoQCL347FN5m6Ag
 XDEs1MCcF97TxQvOTQh5R8Uy2rgpWabb8/Mbp7wKsi1xMdbw53vQHBe+Ph/wXPlafAO9
 sdLA==
X-Gm-Message-State: APjAAAVn9ezbiR1SMWoIWn0zv17W1/RDD0B8D+DTaz2xe3QR6Vx3vLPW
 NLS81GKXHMH3S+Mlsisjyg2fIwXj
X-Google-Smtp-Source: APXvYqzGA9Rz2Wb/hdgJ3ZJge/5CBAg06nqkPIKwfYTID+Xss1soFpiRfmazDkBUeI7Moe1V8/+S+w==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr6326220wrr.306.1576155226982; 
 Thu, 12 Dec 2019 04:53:46 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 049/132] meson: convert root directory to Meson
Date: Thu, 12 Dec 2019 13:51:33 +0100
Message-Id: <1576155176-2464-50-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Makefile.objs   | 29 ++---------------------------
 Makefile.target |  2 +-
 configure       |  3 +++
 meson.build     | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 1319ba2..307e27c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,19 +35,11 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o block/
-
-common-obj-y += bootdevice.o iothread.o
+common-obj-y = block/
 common-obj-y += dump/
-common-obj-y += job-qmp.o
 common-obj-y += monitor/
 common-obj-y += net/
-common-obj-y += qdev-monitor.o device-hotplug.o
-common-obj-$(CONFIG_WIN32) += os-win32.o
-common-obj-$(CONFIG_POSIX) += os-posix.o
-
 common-obj-$(CONFIG_LINUX) += fsdev/
-
 common-obj-y += migration/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
@@ -71,30 +63,13 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-
 common-obj-y += replay/
-
-common-obj-y += bt-host.o bt-vhci.o
-bt-host.o-cflags := $(BLUEZ_CFLAGS)
-
-common-obj-y += dma-helpers.o
-common-obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
-common-obj-$(CONFIG_TPM) += tpm.o
-
 common-obj-y += backends/
-
-common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
-qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-qemu-seccomp.o-libs := $(SECCOMP_LIBS)
-
-common-obj-$(CONFIG_FDT) += device_tree.o
-
 endif
 
 #######################################################################
 # Target-independent parts used in system and user emulation
-common-obj-y += cpus-common.o
+
 common-obj-y += hw/
 common-obj-y += qom/
 common-obj-y += disas/
diff --git a/Makefile.target b/Makefile.target
index 265b596..bad50ce 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,7 +168,7 @@ ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
diff --git a/configure b/configure
index a18fe24..c4b50a7 100755
--- a/configure
+++ b/configure
@@ -6771,6 +6771,7 @@ fi
 if test "$bluez" = "yes" ; then
   echo "CONFIG_BLUEZ=y" >> $config_host_mak
   echo "BLUEZ_CFLAGS=$bluez_cflags" >> $config_host_mak
+  echo "BLUEZ_LIBS=$bluez_libs" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
   echo "CONFIG_GTK=m" >> $config_host_mak
@@ -6891,6 +6892,8 @@ if test "$preadv" = "yes" ; then
 fi
 if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
+  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
+  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index cb164e0..cb60aac 100644
--- a/meson.build
+++ b/meson.build
@@ -37,6 +37,7 @@ configure_file(input: files('scripts/ninjatool.py'),
 
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
+winmm = []
 socket = []
 version_res = []
 coref = []
@@ -45,6 +46,7 @@ cocoa = []
 hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
@@ -248,6 +250,21 @@ if 'CONFIG_VNC_SASL' in config_host
   sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
                             link_args: config_host['SASL_LIBS'].split())
 endif
+bluez = declare_dependency()
+if 'CONFIG_BLUEZ' in config_host
+  bluez = declare_dependency(compile_args: config_host['BLUEZ_CFLAGS'].split(),
+                             link_args: config_host['BLUEZ_LIBS'].split())
+endif
+seccomp = declare_dependency()
+if 'CONFIG_SECCOMP' in config_host
+  seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
+                               link_args: config_host['SECCOMP_LIBS'].split())
+endif
+fdt = declare_dependency()
+if 'CONFIG_FDT' in config_host
+  fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
+                           link_args: config_host['FDT_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -542,6 +559,28 @@ subdir('nbd')
 subdir('scsi')
 subdir('block')
 
+softmmu_ss.add(files(
+  'blockdev-nbd.c',
+  'blockdev.c',
+  'bootdevice.c',
+  'device-hotplug.c',
+  'dma-helpers.c',
+  'iothread.c',
+  'job-qmp.c',
+  'qdev-monitor.c',
+  'vl.c',
+), sdl)
+
+softmmu_ss.add(files('bt-host.c', 'bt-vhci.c'), bluez)
+
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c'), winmm])
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
+softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
+
+common_ss.add(files('cpus-common.c'))
+
 mods = []
 block_mods = []
 softmmu_mods = []
-- 
1.8.3.1



