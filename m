Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74194204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW2OfgK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74194204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ghE-0007gR-IO
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHS-00059B-Ug
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHR-0006Df-DZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id x5so13422357wmi.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ye+eN0K6SwtiPkKz7oTowsHX3twAyqMhNNP/Wn9Nzu8=;
 b=NW2OfgK9tuMqHkMofuDzhtIgOCUBd9nX5GoI9MjnhYljWG/5kaHLzq9RAcU03EeLO5
 XtojwnoEPvGxe9nVbzBImMIVJ863HEqo/4vxRU0UGa5yO9gbCAB6R9pLfeag7AYoKvJ1
 wWc2i+8tYS7yCsAVRPZ0QVdX+GQs3vrCT9oIIxSIMUrixs3mftU2feS1KVsfZ+zTFon6
 JDEeH9YlSbso39W9BoCAxsVOE+BEa22gOKXhvpdeuiczqc4Q9TiZEdIPM49b0mB52E8W
 86SQ/YQqf8xsD0+RGr61/pwfzPgfo7OrkIIy3BnlNlCEF57bFQfA3nFzJWghrUmKTS6Z
 cEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ye+eN0K6SwtiPkKz7oTowsHX3twAyqMhNNP/Wn9Nzu8=;
 b=G1v762XLrERgWw+dnXdpT75RRbb7SuT+R7R5vsI+aGLNy7jTMJSD5uepGU4swUTmnY
 3SeP/6TTrmJg2AxkkPl+GEA2bt+VHWKs2HjAYQ40icpDoqvd18/rZ7RcIIWbfGZh3zAv
 3h3boDmp9sHCmEH5x7lAwUrIQcGyz0gC/OQKiQLlMOROvOk7e+ykWqLdlxQHL4uRE9jC
 QQluvC+dzh0PloufC5Mw1dmgzl6c5iK1TA5/6eQaKxZCTqN0mB/RjWSAKFWftMFoXbFP
 9o5BBFtyQ3xiqExstC8hQiOP2V8zxCpcdPsD0qpegoe8J/bSpp+HlzD/Shrc1dsdL5xd
 Mk8w==
X-Gm-Message-State: AOAM533FFch3KMqYrVdEg/iGeEe0xeUIexI97d3QnXUGtEc3RRQvAbY3
 79utV/DR0wqDiSrP/tg4qBShZ/VTStI=
X-Google-Smtp-Source: ABdhPJw0U2VEVvdWQouh2QGOxI2Ys2UnzWF6tGwg8Koxu+KNT3K5dcer07F1OEqKoxPtnf9Q+Whp+g==
X-Received: by 2002:a1c:3285:: with SMTP id
 y127mr14870025wmy.104.1597675111692; 
 Mon, 17 Aug 2020 07:38:31 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 067/150] meson: convert chardev directory to Meson (emulator
 part)
Date: Mon, 17 Aug 2020 16:36:00 +0200
Message-Id: <20200817143723.343284-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x335.google.com
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
 Makefile.objs         |  2 --
 Makefile.target       |  2 ++
 chardev/Makefile.objs | 10 ----------
 chardev/meson.build   | 13 +++++++++++++
 configure             |  2 ++
 meson.build           | 14 ++++++++++++++
 6 files changed, 31 insertions(+), 12 deletions(-)
 delete mode 100644 chardev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index eeaa0cfa82..e43526fe5f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -87,8 +87,6 @@ common-obj-y += dma-helpers.o
 common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += backends/
-common-obj-y += chardev/
-common-obj-m += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index c0575da132..c8c4b70162 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -104,6 +104,7 @@ all: $(PROGS) stap
 	@true
 
 obj-y += $(LIBQEMU)
+
 obj-y += trace/
 
 #########################################################
@@ -167,6 +168,7 @@ LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS)
 endif
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
deleted file mode 100644
index 6662d0df41..0000000000
--- a/chardev/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-chardev-obj-$(CONFIG_SOFTMMU) += chardev-sysemu.o
-common-obj-$(CONFIG_SOFTMMU) += msmouse.o wctablet.o testdev.o
-
-ifeq ($(CONFIG_BRLAPI),y)
-common-obj-m += baum.o
-baum.o-cflags := $(SDL_CFLAGS)
-baum.o-libs := $(BRLAPI_LIBS)
-endif
-
-common-obj-$(CONFIG_SPICE) += spice.o
diff --git a/chardev/meson.build b/chardev/meson.build
index a2e671ddfc..f79efaaf09 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -30,3 +30,16 @@ libchardev = static_library('chardev', chardev_ss.sources(),
                             build_by_default: false)
 
 chardev = declare_dependency(link_whole: libchardev)
+
+softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
+softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
+
+chardev_modules = {}
+
+if config_host.has_key('CONFIG_BRLAPI') and config_host.has_key('CONFIG_SDL')
+  module_ss = ss.source_set()
+  module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
+  chardev_modules += { 'brlapi': module_ss }
+endif
+
+modules += { 'chardev': chardev_modules }
diff --git a/configure b/configure
index a77177f4e2..50e74b1e79 100755
--- a/configure
+++ b/configure
@@ -7344,6 +7344,8 @@ if test "$zlib" != "no" ; then
 fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/meson.build b/meson.build
index 92f2da51e5..c20b379b4d 100644
--- a/meson.build
+++ b/meson.build
@@ -143,6 +143,11 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+spice = not_found
+if 'CONFIG_SPICE' in config_host
+  spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
+                             link_args: config_host['SPICE_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libmpathpersist = not_found
 if config_host.has_key('CONFIG_MPATH')
@@ -177,6 +182,15 @@ libudev = not_found
 if 'CONFIG_LIBUDEV' in config_host
   libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
 endif
+brlapi = not_found
+if 'CONFIG_BRLAPI' in config_host
+  brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
+endif
+sdl = not_found
+if 'CONFIG_SDL' in config_host
+  sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
+                           link_args: config_host['SDL_LIBS'].split())
+endif
 rbd = not_found
 if 'CONFIG_RBD' in config_host
   rbd = declare_dependency(link_args: config_host['RBD_LIBS'].split())
-- 
2.26.2



