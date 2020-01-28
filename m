Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5913C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E366207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcrRAFzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E366207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVlH-0008C9-L7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5j-0000bN-Ve
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5h-00038J-UY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5h-00036F-Lb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so17105256wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WF3vmzZwKpjUlVEK4MzWD8XjLu3RcG5SfaH1ELKlW2o=;
 b=jcrRAFzUGz+LL3IjuMXkY5aaBkz82gOnMfWmEb68RiaVj3XWuJ24PWPa/j/ofb5kgb
 3XA/6wwHku8ixOHc5fda48WyyWbMTVEc9v3jCde2vTMc1OFvEgdJrXymV9jRFC2E1ohG
 fJSNiyzGjSGWpmtJZAlshTQ7QwsIojoYUJ+OgaqMtpd4JeoXSnHWjilki66ZRJU9Ma0R
 bG+Zn/1RnGR4rOw33N4xI9+X8cLvlApvs7F/vZSyezVmImjJ0qChLnP1B5pxg9/1fziY
 KpU/0uLxhDiVCDH65HkwWDnGozSGrzHstOiq7Th7oD4EkRT9KECPDpxRLeHxTc2n1I5N
 dYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WF3vmzZwKpjUlVEK4MzWD8XjLu3RcG5SfaH1ELKlW2o=;
 b=Q2kBUbvwWARkkqecVaBRNGDwPSm5uahFjiC5QFYTYQ+yX5wUPAXiqjByhd7OELZLOi
 m1zKlq2i7r8GPac+q57fLU10S6RmfsgFNz1S/IBoDvwnIZiWXmod4ddmr/6/umItHzlp
 7p8EXZ3729yRImBxZ3Ta11olU3L9qpLVcdEzU3LCou0VRY+Q/jTKFg/OL1M1dtQDWQXr
 6bVqpGG+dUyL35SKxlqacl7fG42ZX4YesdFFuYqwkYK5w+ZLnVmrH03qGGkoWNqLoCIP
 zwoynklRGVNk4QsFucaQfxsZuJhf5jAPdjZQzdi12jiGovldVRUq7ILXzqKBtORV65q5
 /Smw==
X-Gm-Message-State: APjAAAVvJpTefw8DXPdjX6idbxtqw/zmh/DDFbSs55GhPs3HRnp8sZ1g
 uKmnq2UbE1RhnOl9bBJpMDb3LXhZ
X-Google-Smtp-Source: APXvYqwNZTRtUDKWOGklTndcauZXS0waLMXiXJ3c2if8pDqw7ddXh4ZuOZOZVzYHLsLWqr5vD8xfEA==
X-Received: by 2002:adf:f244:: with SMTP id b4mr28613963wrp.88.1580234156421; 
 Tue, 28 Jan 2020 09:55:56 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 054/142] meson: convert ui directory to Meson
Date: Tue, 28 Jan 2020 18:52:14 +0100
Message-Id: <20200128175342.9066-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Makefile         |  4 +--
 Makefile.objs    |  8 +++--
 Makefile.target  |  8 ++---
 configure        |  6 ++++
 meson.build      | 50 +++++++++++++++++++++++++++++++
 ui/Makefile.objs | 70 --------------------------------------------
 ui/meson.build   | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 ui/shader.c      |  6 ++--
 8 files changed, 145 insertions(+), 83 deletions(-)
 delete mode 100644 ui/Makefile.objs

diff --git a/Makefile b/Makefile
index 25eb7336cc..3706b6d142 100644
--- a/Makefile
+++ b/Makefile
@@ -157,9 +157,7 @@ ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
 endif
 
-dummy := $(call unnest-vars,, \
-                common-obj-y \
-                common-obj-m)
+dummy := $(call unnest-vars,, common-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
 
diff --git a/Makefile.objs b/Makefile.objs
index 68bb44f875..5081994123 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -56,6 +56,11 @@ common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
 
+common-obj-$(if $(CONFIG_CURSES),m) += ui-curses$(DSOSUF)
+common-obj-$(if $(CONFIG_GTK),m) += ui-gtk$(DSOSUF)
+common-obj-$(if $(CONFIG_SDL),m) += ui-sdl$(DSOSUF)
+common-obj-$(if $(CONFIG_SPICE),m) += ui-spice-app$(DSOSUF)
+
 common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
 common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
 common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
@@ -70,9 +75,6 @@ common-obj-y += hw/
 
 common-obj-y += replay/
 
-common-obj-y += ui/
-common-obj-m += ui/
-
 common-obj-y += dma-helpers.o
 common-obj-y += vl.o
 vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index 15157c7684..ae4e494ec6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,8 +168,9 @@ LIBS := $(libs_softmmu) $(LIBS)
 LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
+LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
@@ -194,9 +195,8 @@ dummy := $(call fix-paths,../,, \
               crypto-obj-y \
               io-obj-y \
               qom-obj-y)
-dummy := $(call unnest-vars,.., \
-               common-obj-y \
-               common-obj-m)
+dummy := $(call unnest-vars,..,common-obj-y)
+
 all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
diff --git a/configure b/configure
index 434c24f0f0..80a7c0f069 100755
--- a/configure
+++ b/configure
@@ -6788,12 +6788,18 @@ fi
 if test "$vnc_sasl" = "yes" ; then
   echo "CONFIG_VNC_SASL=y" >> $config_host_mak
 fi
+echo "SASL_CFLAGS=$vnc_sasl_cflags" >> $config_host_mak
+echo "SASL_LIBS=$vnc_sasl_libs" >> $config_host_mak
 if test "$vnc_jpeg" = "yes" ; then
   echo "CONFIG_VNC_JPEG=y" >> $config_host_mak
 fi
+echo "JPEG_CFLAGS=$vnc_jpeg_cflags" >> $config_host_mak
+echo "JPEG_LIBS=$vnc_jpeg_libs" >> $config_host_mak
 if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
+echo "PNG_CFLAGS=$vnc_png_cflags" >> $config_host_mak
+echo "PNG_LIBS=$vnc_png_libs" >> $config_host_mak
 if test "$xkbcommon" = "yes" ; then
   echo "CONFIG_XKBCOMMON=y" >> $config_host_mak
   echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
diff --git a/meson.build b/meson.build
index d66d49152b..6fb86e4bd3 100644
--- a/meson.build
+++ b/meson.build
@@ -202,6 +202,56 @@ coreaudio = declare_dependency()
 if 'CONFIG_AUDIO_COREAUDIO' in config_host
   coreaudio = declare_dependency(link_args: config_host['COREAUDIO_LIBS'].split())
 endif
+opengl = declare_dependency()
+if 'CONFIG_OPENGL' in config_host
+  opengl = declare_dependency(link_args: config_host['OPENGL_LIBS'].split())
+else
+endif
+gtk = declare_dependency()
+if 'CONFIG_GTK' in config_host
+  gtk = declare_dependency(compile_args: config_host['GTK_CFLAGS'].split(),
+                              link_args: config_host['GTK_LIBS'].split())
+endif
+vte = declare_dependency()
+if 'CONFIG_VTE' in config_host
+  vte = declare_dependency(compile_args: config_host['VTE_CFLAGS'].split(),
+                           link_args: config_host['VTE_LIBS'].split())
+endif
+x11 = declare_dependency()
+if 'CONFIG_X11' in config_host
+  x11 = declare_dependency(compile_args: config_host['X11_CFLAGS'].split(),
+                           link_args: config_host['X11_LIBS'].split())
+endif
+curses = declare_dependency()
+if 'CONFIG_CURSES' in config_host
+  curses = declare_dependency(compile_args: config_host['CURSES_CFLAGS'].split(),
+                              link_args: config_host['CURSES_LIBS'].split())
+endif
+iconv = declare_dependency()
+if 'CONFIG_ICONV' in config_host
+  iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
+                             link_args: config_host['ICONV_LIBS'].split())
+endif
+gio = declare_dependency()
+if 'CONFIG_GIO' in config_host
+  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
+                           link_args: config_host['GIO_LIBS'].split())
+endif
+png = declare_dependency()
+if 'CONFIG_VNC_PNG' in config_host
+  png = declare_dependency(compile_args: config_host['PNG_CFLAGS'].split(),
+                           link_args: config_host['PNG_LIBS'].split())
+endif
+jpeg = declare_dependency()
+if 'CONFIG_VNC_JPEG' in config_host
+  jpeg = declare_dependency(compile_args: config_host['JPEG_CFLAGS'].split(),
+                            link_args: config_host['JPEG_LIBS'].split())
+endif
+sasl = declare_dependency()
+if 'CONFIG_VNC_SASL' in config_host
+  sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
+                            link_args: config_host['SASL_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
deleted file mode 100644
index e6da6ff047..0000000000
--- a/ui/Makefile.objs
+++ /dev/null
@@ -1,70 +0,0 @@
-vnc-obj-y += vnc.o
-vnc-obj-y += vnc-enc-zlib.o vnc-enc-hextile.o
-vnc-obj-y += vnc-enc-tight.o vnc-palette.o
-vnc-obj-y += vnc-enc-zrle.o
-vnc-obj-y += vnc-auth-vencrypt.o
-vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o
-vnc-obj-y += vnc-ws.o
-vnc-obj-y += vnc-jobs.o
-
-common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
-common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
-common-obj-y += input-barrier.o
-common-obj-$(CONFIG_LINUX) += input-linux.o
-common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_COCOA) += cocoa.o
-common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
-common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
-
-# ui-sdl module
-common-obj-$(CONFIG_SDL) += sdl.mo
-sdl.mo-objs := sdl2.o sdl2-input.o sdl2-2d.o
-ifeq ($(CONFIG_OPENGL),y)
-sdl.mo-objs += sdl2-gl.o
-endif
-sdl.mo-cflags := $(SDL_CFLAGS)
-sdl.mo-libs := $(SDL_LIBS)
-
-# ui-gtk module
-common-obj-$(CONFIG_GTK) += gtk.mo
-gtk.mo-objs := gtk.o
-gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
-ifeq ($(CONFIG_OPENGL),y)
-gtk.mo-objs += gtk-egl.o
-gtk.mo-libs += $(OPENGL_LIBS)
-ifeq ($(CONFIG_GTK_GL),y)
-gtk.mo-objs += gtk-gl-area.o
-endif
-endif
-
-ifeq ($(CONFIG_X11),y)
-sdl.mo-objs += x_keymap.o
-gtk.mo-objs += x_keymap.o
-x_keymap.o-cflags := $(X11_CFLAGS)
-x_keymap.o-libs := $(X11_LIBS)
-endif
-
-common-obj-$(CONFIG_CURSES) += curses.mo
-curses.mo-objs := curses.o
-curses.mo-cflags := $(CURSES_CFLAGS) $(ICONV_CFLAGS)
-curses.mo-libs := $(CURSES_LIBS) $(ICONV_LIBS)
-
-ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
-common-obj-$(if $(CONFIG_MODULES),m,y) += spice-app.mo
-endif
-spice-app.mo-objs := spice-app.o
-spice-app.mo-cflags := $(GIO_CFLAGS)
-spice-app.mo-libs := $(GIO_LIBS)
-
-common-obj-$(CONFIG_OPENGL) += shader.o
-common-obj-$(CONFIG_OPENGL) += console-gl.o
-common-obj-$(CONFIG_OPENGL) += egl-helpers.o
-common-obj-$(CONFIG_OPENGL) += egl-context.o
-common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
-
-shader.o-libs += $(OPENGL_LIBS)
-console-gl.o-libs += $(OPENGL_LIBS)
-egl-helpers.o-libs += $(OPENGL_LIBS)
-egl-context.o-libs += $(OPENGL_LIBS)
-egl-headless.o-libs += $(OPENGL_LIBS)
diff --git a/ui/meson.build b/ui/meson.build
index 81577546e0..95ffde3f9a 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,3 +1,77 @@
+softmmu_ss.add(files(
+  'console.c',
+  'cursor.c',
+  'input-keymap.c',
+  'input-legacy.c',
+  'input-barrier.c',
+  'input.c',
+  'kbd-state.c',
+  'keymaps.c',
+  'qemu-pixman.c',
+))
+softmmu_ss.add(pixman)
+
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
+softmmu_ss.add(when: 'CONFIG_SPICE', if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
+softmmu_ss.add(when: [cocoa, 'CONFIG_COCOA'], if_true: files('cocoa.m'))
+
+vnc_ss = ss.source_set()
+vnc_ss.add(files(
+  'vnc.c',
+  'vnc-enc-zlib.c',
+  'vnc-enc-hextile.c',
+  'vnc-enc-tight.c',
+  'vnc-palette.c',
+  'vnc-enc-zrle.c',
+  'vnc-auth-vencrypt.c',
+  'vnc-ws.c',
+  'vnc-jobs.c',
+))
+vnc_ss.add(zlib)
+vnc_ss.add(when: 'CONFIG_VNC_SASL', if_true: [files('vnc-auth-sasl.c'), sasl])
+softmmu_ss.add_all(when: 'CONFIG_VNC', if_true: vnc_ss)
+softmmu_ss.add(when: 'CONFIG_VNC', if_false: files('vnc-stubs.c'))
+softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
+softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL_DMABUF'], if_true: files('egl-headless.c'))
+softmmu_ss.add(when: 'CONFIG_VNC_PNG', if_true: png)
+softmmu_ss.add(when: 'CONFIG_VNC_JPEG', if_true: jpeg)
+
+ui_modules = []
+
+if config_host.has_key('CONFIG_CURSES')
+  ui_modules += [['curses', files('curses.c'), [curses, iconv]]]
+endif
+
+if config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')
+  gtk_ss = ss.source_set()
+  gtk_ss.add(gtk, vte, files('gtk.c'))
+  gtk_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
+  gtk_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('gtk-egl.c'))
+  gtk_ss.add(when: [opengl, 'CONFIG_GTK_GL'], if_true: files('gtk-gl-area.c'))
+  gtk_ss = gtk_ss.apply(config_host, strict: false)
+  ui_modules += [['gtk', gtk_ss.sources(), gtk_ss.dependencies()]]
+endif
+
+if config_host.has_key('CONFIG_SDL')
+  sdl_ss = ss.source_set()
+  sdl_ss.add([sdl, pixman, glib], files(
+    'sdl2-2d.c',
+    'sdl2-input.c',
+    'sdl2.c',
+  ))
+  sdl_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('sdl2-gl.c'))
+  sdl_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
+  sdl_ss = sdl_ss.apply(config_host, strict: false)
+  ui_modules += [['sdl', sdl_ss.sources(), sdl_ss.dependencies()]]
+endif
+
+if config_host.has_key('CONFIG_SPICE') and config_host.has_key('CONFIG_GIO')
+  spice_ss = ss.source_set()
+  spice_ss.add(spice, gio, files('spice-app.c'))
+  spice_ss = spice_ss.apply(config_host, strict: false)
+  ui_modules += [['spice-app', spice_ss.sources(), spice_ss.dependencies()]]
+endif
+
 keymap_gen = find_program('keycodemapdb/tools/keymap-gen')
 
 keymaps = [
@@ -34,3 +108,5 @@ foreach e : keymaps
 endforeach
 
 subdir('shader')
+
+modules += {'ui': ui_modules}
diff --git a/ui/shader.c b/ui/shader.c
index d78829f43b..e8b8d321b7 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -27,9 +27,9 @@
 #include "qemu/osdep.h"
 #include "ui/shader.h"
 
-#include "shader/texture-blit-vert.h"
-#include "shader/texture-blit-flip-vert.h"
-#include "shader/texture-blit-frag.h"
+#include "ui/shader/texture-blit-vert.h"
+#include "ui/shader/texture-blit-flip-vert.h"
+#include "ui/shader/texture-blit-frag.h"
 
 struct QemuGLShader {
     GLint texture_blit_prog;
-- 
2.21.0



