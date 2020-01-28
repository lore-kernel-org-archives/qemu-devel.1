Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDFD2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+D8JiSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDFD2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW5R-0007NX-Sp
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV68-0001IT-Ds
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV65-000498-UB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:24 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV65-000460-Gs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id g17so17093344wro.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jwPNTWSRuJEifivMRLEkLif5DqoqN42PTC3/6WoOGhU=;
 b=E+D8JiSPHL2O5terGKRd4bUPvcLo1PkuUsvVtJPWV9+Izmy+jWunuQhVrR2TW0dTYy
 WawRPUVC8o3J3uCvnh1jsDF0owemh1BWuMxitn082kQbnw2yijUpK2/CGhoB8ZYMtG1j
 K0KRHjs6cbReQDBSwWNew3YZEKVeBStybL7p6kihpivCTbt2Orhvofb+VqObqPkr0QyB
 OSjVRl9ep0c7aY0Vc1oa+7QFrRW28BdJev2hTBng8M6Vs6pJTRIneZm6djsGOeJs8SsR
 C/Z/7D18vnFKdERR8Hsk4CXyt3QvQ8Dhfbg12dvvvsZbKlc75Oy7c6ozeCKYVjl0tgkp
 rYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jwPNTWSRuJEifivMRLEkLif5DqoqN42PTC3/6WoOGhU=;
 b=LPK835Ma2haFJ+P4d9fMS+yjVJHxNMwLivtkVOp+83cJJl739bC0PiR2F4iwXaxiTp
 taspEBebIcoaUpSIQEYMqf6k3jAZ72VrJc0+KAh9CSEDll4AD/e/Un1qjKOcXMaiuB7F
 UHy26wQCMsPIJuacGJI6a/xV/Izy7dtNb4pf5ij2j8ebN/36E6fQPmaS/h3Q/yKTK5tm
 be4L4CuZ1DainToH8/bOgciZm5e5Hfw+89s5FDvRE3MK2hXW/Sti/iyYtswtcAVdkX+0
 kZK6ymIsXANLbPNMgvjmv7zYI2HyLWDwMIBOs5Ozg+bseY6U6QLO8/fVqII4iFze1yzY
 yTBQ==
X-Gm-Message-State: APjAAAV/ERHtJauCdsMskbDTHPA/BgnlTK8tSsdi9nY80TImdKi7tCgv
 EtknBXg4TtGdUjgh9OnIykEPNIZP
X-Google-Smtp-Source: APXvYqyOipEHkeEQXzSZwUpWV/U2ZFkaY7GyrgldgDyZQlpv07svaLmF1H2TAEQtXnzAiBS9tQf4sg==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29052164wro.51.1580234180207; 
 Tue, 28 Jan 2020 09:56:20 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 064/142] meson: convert net directory to Meson
Date: Tue, 28 Jan 2020 18:52:24 +0100
Message-Id: <20200128175342.9066-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         |  3 +--
 Makefile.target       |  1 +
 meson.build           | 10 ++++++++++
 net/Makefile.objs     | 32 --------------------------------
 net/can/Makefile.objs |  2 --
 net/can/meson.build   |  5 +++++
 net/meson.build       | 39 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 56 insertions(+), 36 deletions(-)
 delete mode 100644 net/Makefile.objs
 delete mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/meson.build
 create mode 100644 net/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index fc2868f1bf..2b68f487a3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = net/
-common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_LINUX) = fsdev/
 
 common-obj-y += accel/
 
diff --git a/Makefile.target b/Makefile.target
index 3587da499e..1a7102c27c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,6 +169,7 @@ LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
+LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/meson.build b/meson.build
index 40411f0960..713aca221e 100644
--- a/meson.build
+++ b/meson.build
@@ -113,6 +113,15 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+slirp = declare_dependency()
+if config_host.has_key('CONFIG_SLIRP')
+  slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
+                             link_args: config_host['SLIRP_LIBS'].split())
+endif
+vde = declare_dependency()
+if config_host.has_key('CONFIG_VDE')
+  vde = declare_dependency(link_args: config_host['VDE_LIBS'].split())
+endif
 pulse = declare_dependency()
 if 'CONFIG_LIBPULSE' in config_host
   pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
@@ -611,6 +620,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('migration')
 subdir('monitor')
+subdir('net')
 subdir('replay')
 
 mods = []
diff --git a/net/Makefile.objs b/net/Makefile.objs
deleted file mode 100644
index c5d076d19c..0000000000
--- a/net/Makefile.objs
+++ /dev/null
@@ -1,32 +0,0 @@
-common-obj-y = net.o queue.o checksum.o util.o hub.o
-common-obj-y += socket.o
-common-obj-y += dump.o
-common-obj-y += eth.o
-common-obj-y += announce.o
-common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
-common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) += vhost-user.o
-common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOST_NET_USER)) += vhost-user-stub.o
-common-obj-$(CONFIG_ALL) += vhost-user-stub.o
-common-obj-$(CONFIG_SLIRP) += slirp.o
-slirp.o-cflags := $(SLIRP_CFLAGS)
-slirp.o-libs := $(SLIRP_LIBS)
-common-obj-$(CONFIG_VDE) += vde.o
-common-obj-$(CONFIG_NETMAP) += netmap.o
-common-obj-y += filter.o
-common-obj-y += filter-buffer.o
-common-obj-y += filter-mirror.o
-common-obj-y += colo-compare.o
-common-obj-y += colo.o
-common-obj-y += filter-rewriter.o
-common-obj-y += filter-replay.o
-
-tap-obj-$(CONFIG_LINUX) = tap-linux.o
-tap-obj-$(CONFIG_BSD) = tap-bsd.o
-tap-obj-$(CONFIG_SOLARIS) = tap-solaris.o
-tap-obj-y ?= tap-stub.o
-common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
-common-obj-$(CONFIG_WIN32) += tap-win32.o
-
-vde.o-libs = $(VDE_LIBS)
-
-common-obj-$(CONFIG_CAN_BUS) += can/
diff --git a/net/can/Makefile.objs b/net/can/Makefile.objs
deleted file mode 100644
index 9f35dc5c87..0000000000
--- a/net/can/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-y += can_core.o can_host.o
-common-obj-$(CONFIG_LINUX) += can_socketcan.o
diff --git a/net/can/meson.build b/net/can/meson.build
new file mode 100644
index 0000000000..f53d9ec54f
--- /dev/null
+++ b/net/can/meson.build
@@ -0,0 +1,5 @@
+can_ss = ss.source_set()
+can_ss.add(files('can_core.c', 'can_host.c'))
+can_ss.add(when: 'CONFIG_LINUX', if_true: files('can_socketcan.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_CAN_BUS', if_true: can_ss)
diff --git a/net/meson.build b/net/meson.build
new file mode 100644
index 0000000000..a67f5af44a
--- /dev/null
+++ b/net/meson.build
@@ -0,0 +1,39 @@
+softmmu_ss.add(files(
+  'announce.c',
+  'checksum.c',
+  'colo-compare.c',
+  'colo.c',
+  'dump.c',
+  'eth.c',
+  'filter-buffer.c',
+  'filter-mirror.c',
+  'filter-replay.c',
+  'filter-rewriter.c',
+  'filter.c',
+  'hub.c',
+  'net.c',
+  'queue.c',
+  'socket.c',
+  'util.c',
+))
+
+softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
+softmmu_ss.add(when: ['CONFIG_SLIRP', slirp], if_true: files('slirp.c'))
+softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
+softmmu_ss.add(when: 'CONFIG_NETMAP', if_true: files('netmap.c'))
+vhost_user_ss = ss.source_set()
+vhost_user_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
+softmmu_ss.add_all(when: 'CONFIG_VHOST_NET_USER', if_true: vhost_user_ss)
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-user-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('tap-linux.c'))
+softmmu_ss.add(when: 'CONFIG_BSD', if_true: files('tap-bsd.c'))
+softmmu_ss.add(when: 'CONFIG_SOLARIS', if_true: files('tap-solaris.c'))
+tap_posix = ['tap.c']
+if not config_host.has_key('CONFIG_LINUX') and not config_host.has_key('CONFIG_BSD') and not config_host.has_key('CONFIG_SOLARIS')
+  tap_posix += 'tap-stub.c'
+endif
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files(tap_posix))
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('tap-win32.c'))
+
+subdir('can')
-- 
2.21.0



