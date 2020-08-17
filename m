Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7D32054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXdeI2d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7go6-0005g2-66
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHg-0005WH-7D
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHd-0006Gc-Lx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id p14so13425854wmg.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iF22jc7yBxBhWIXE4smsSOGpHxtCBg0En2HKApL02yo=;
 b=aXdeI2d1RnhH+jmWZKAKI9IOweU83PQ2N2e/0IoV8CGyzbHiYlUFokBSQpYi43tK4I
 /azC3s5X1rNGpnSZnWbFS5EHasxWd6ho8F/iJwhWCj9z0qMuA4NN6db8f0Te8VFgjdpv
 pIAkjMMcRvuma397QQdSZrrTpdtx9jrBbh+//0Z4baDTZOC6mu9YNzKvnMZubTguibx0
 c5EcwsKAi3Z2D+ZBgCjwSGujBm6hihsDZ7MDf4MZbr4112ci6t+xQhSo4Rc7j4qjnDob
 /J+Dabidzwuk0WyGBEn6ci1eY6AlTGad9YL8cCGFeQOSSVuC2wmZ36uWYvyVqaAYeVi0
 Hm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iF22jc7yBxBhWIXE4smsSOGpHxtCBg0En2HKApL02yo=;
 b=Pa93UH3IKSTAUgU+388Mtaocn01cMH/MKFZv7QzbdOhs/4JiE/ACNC0oA/ih1sJ9YH
 HbDIA7bCwgaPfmWeOqj8j/6VzugW0R6MfdgDektRnstcFmB1QnTf4qY+sBQ0A70hhTGy
 fkINeRmHCooWKJk1DMYZZmV4tde1zgQXIEewryIBt43YQ5LAJJYs65YFC9YsXD+f8F0H
 nkmQ3ho+29QrqHOPPk25QUqjTv0LI3ekvt6Zzm28FKIuEy1geQvjAqEttFLSF3qFtgBo
 s1kWoJklTq1JxfJRHdc9tn20FVyDb7YjYZba6Kq1b4oyly4yQWBmUqtCPbiIIPjmB59X
 pkwQ==
X-Gm-Message-State: AOAM531fYYTGAiaeL5x9a0INHAx0/U0fGYCADNaHoHovb4bl3D+wK7Pm
 d8MH4G8LElJbY+ISfEc6vTl/THQq8HU=
X-Google-Smtp-Source: ABdhPJzEeFRkZKORb/I6T/OQebzTe11oXoMjMtj/PNcaLkQ9RPKyp6kmtq7xbASbqRVZs56rYnPlBw==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr14468194wmc.156.1597675123933; 
 Mon, 17 Aug 2020 07:38:43 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 079/150] meson: convert net directory to Meson
Date: Mon, 17 Aug 2020 16:36:12 +0200
Message-Id: <20200817143723.343284-80-pbonzini@redhat.com>
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
 net/meson.build       | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 57 insertions(+), 36 deletions(-)
 delete mode 100644 net/Makefile.objs
 delete mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/meson.build
 create mode 100644 net/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 9d0a82d82a..f2700442a4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -39,8 +39,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = net/
-common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_LINUX) = fsdev/
 
 common-obj-y += accel/
 
diff --git a/Makefile.target b/Makefile.target
index 4d912df3a3..bf3fda92c1 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,6 +168,7 @@ LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
+LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/meson.build b/meson.build
index dc9ce85689..207a47cf07 100644
--- a/meson.build
+++ b/meson.build
@@ -145,6 +145,15 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+slirp = not_found
+if config_host.has_key('CONFIG_SLIRP')
+  slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
+                             link_args: config_host['SLIRP_LIBS'].split())
+endif
+vde = not_found
+if config_host.has_key('CONFIG_VDE')
+  vde = declare_dependency(link_args: config_host['VDE_LIBS'].split())
+endif
 pulse = not_found
 if 'CONFIG_LIBPULSE' in config_host
   pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
@@ -657,6 +666,7 @@ common_ss.add(files('cpus-common.c'))
 subdir('softmmu')
 subdir('migration')
 subdir('monitor')
+subdir('net')
 subdir('replay')
 
 # needed for fuzzing binaries
diff --git a/net/Makefile.objs b/net/Makefile.objs
deleted file mode 100644
index 5ab45545db..0000000000
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
-common-obj-$(CONFIG_VHOST_NET_VDPA) += vhost-vdpa.o
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
index 0000000000..6c2ec47dd5
--- /dev/null
+++ b/net/meson.build
@@ -0,0 +1,40 @@
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
+softmmu_ss.add(when: 'CONFIG_VHOST_NET_VDPA', if_true: files('vhost-vdpa.c'))
+
+subdir('can')
-- 
2.26.2



