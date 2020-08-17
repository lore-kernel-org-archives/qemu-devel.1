Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F50C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD090204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt71JZwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD090204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gkS-000750-0n
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHZ-0005DD-3R
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHW-0006Eb-Cu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id k8so14102535wma.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cvvT2/vw466fLHIR+D+5HdwpIyUGKe8k5YxqXSy62yI=;
 b=Rt71JZwECrVE04j9ayhj/2pg2s2bMFLDbKTpI8G2bvDz0/OE0rDolB0Y8KHY+XtwbM
 3/MWS45rf2gd2PHHG6fjbl2tSJF7e+qZRNw+ut/GggRHwkUQEkpUd79V6EiO9tSgEyMi
 eHPuhBtRuvBoHY87fRdJLPnllw9sj2+z4opXdoixL5OCwb4X0cJkLwr+OuLyFHstCAMb
 CRi7rlqsx6693Tb2HtUO9tDL7YfeD7S0N10y/ISjhVwRuaMCpRcZcZcPg8APgYAqz5WU
 lIUp+UvmaK3o84jMvjpJdpKUy2RowdBSHsNym+9uODsqAmNshT6wEOf50HD4aAj6Mjpn
 2E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cvvT2/vw466fLHIR+D+5HdwpIyUGKe8k5YxqXSy62yI=;
 b=T58cOmzfFgq9p8K845m3Q1Ete+c6iyHi8PVr+UfpTvp8xiIHO3WBIwGX1erRgahanF
 iWY9A+n6kshda75xOLLuGOeQedBAXHsbXCNkijEy/QSK8dXh7pistw1lHtjOOxY3FWwd
 +55IjetLfgWLciZzFat4y/z9HMWQ4QabyDNLumwoALgSzgaadBkthajiEYMdPn9Ntoiz
 Eroj2gSC8ASf9m7ZNoldQXMNh7rmeXS1aKad08up2XURVWjmU/R/AD/wKGWM7JJlwCmG
 gMGED0YjAh43h1Dw01cR7HDDVitpbyIL4MkvEh3SimF1fVDQvE9rgtTOMKcuLNhDXtjt
 Rjmg==
X-Gm-Message-State: AOAM532p8NGhcCZQTMwTkez5ns8/X8InUKr4kTXACr6Yr7WTekwuQOgS
 A8nP55TAISMKrKWRyNH4LOWXOduxiOY=
X-Google-Smtp-Source: ABdhPJxZwphPDh2Z6u3wj+Kcb+9NAmXwMm/rWSFdK2722VgAzPrJG/r9TrHSMcOlXMSNfrwN0KMczg==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr14678369wmg.75.1597675116250; 
 Mon, 17 Aug 2020 07:38:36 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 071/150] meson: convert root directory to Meson
Date: Mon, 17 Aug 2020 16:36:04 +0200
Message-Id: <20200817143723.343284-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x330.google.com
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
 Makefile.objs   | 21 ++-------------------
 Makefile.target |  2 +-
 configure       |  2 ++
 meson.build     | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 72e935023d..ec15ebc4b4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -48,16 +48,9 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o
-common-obj-y += bootdevice.o iothread.o
-common-obj-y += dump/
-common-obj-y += job-qmp.o
+common-obj-y = dump/
 common-obj-y += monitor/
 common-obj-y += net/
-common-obj-y += qdev-monitor.o
-common-obj-$(CONFIG_WIN32) += os-win32.o
-common-obj-$(CONFIG_POSIX) += os-posix.o
-
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -87,25 +80,15 @@ common-obj-y += hw/
 common-obj-m += hw/
 
 common-obj-y += replay/
-
-common-obj-y += dma-helpers.o
-common-obj-$(CONFIG_TPM) += tpm.o
-
 common-obj-y += backends/
 
-common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
-qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-qemu-seccomp.o-libs := $(SECCOMP_LIBS)
-
-common-obj-$(CONFIG_FDT) += device_tree.o
-
 common-obj-y += qapi/
 
 endif # CONFIG_SOFTMMU
 
 #######################################################################
 # Target-independent parts used in system and user emulation
-common-obj-y += cpus-common.o
+
 common-obj-y += hw/
 common-obj-y += qom/
 common-obj-y += disas/
diff --git a/Makefile.target b/Makefile.target
index 16f1e781e9..5f926e5bfa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,7 +169,7 @@ ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
diff --git a/configure b/configure
index 9ff9502621..8711e33f21 100755
--- a/configure
+++ b/configure
@@ -7331,6 +7331,8 @@ if test "$preadv" = "yes" ; then
 fi
 if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
+  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
+  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 899826f611..a9e52e56c7 100644
--- a/meson.build
+++ b/meson.build
@@ -47,6 +47,7 @@ targetos = host_machine.system()
 
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
+winmm = []
 socket = []
 version_res = []
 coref = []
@@ -55,6 +56,7 @@ cocoa = []
 hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
@@ -289,6 +291,11 @@ if 'CONFIG_VNC_SASL' in config_host
   sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
                             link_args: config_host['SASL_LIBS'].split())
 endif
+fdt = not_found
+if 'CONFIG_FDT' in config_host
+  fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
+                           link_args: config_host['FDT_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -455,6 +462,7 @@ util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 block_ss = ss.source_set()
+blockdev_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -608,6 +616,31 @@ subdir('nbd')
 subdir('scsi')
 subdir('block')
 
+blockdev_ss.add(files(
+  'blockdev.c',
+  'blockdev-nbd.c',
+  'iothread.c',
+  'job-qmp.c',
+), sdl)
+
+# os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
+# os-win32.c does not
+blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
+
+softmmu_ss.add_all(blockdev_ss)
+softmmu_ss.add(files(
+  'bootdevice.c',
+  'dma-helpers.c',
+  'qdev-monitor.c',
+), sdl)
+
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
+softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
+
+common_ss.add(files('cpus-common.c'))
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
-- 
2.26.2



