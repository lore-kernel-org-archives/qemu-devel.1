Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10DC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2571420708
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/2V055K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2571420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq4l-0000PP-6A
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppz-0002r0-IN
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpps-0007cj-QT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id b79so3777294wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OYOkhfqBvCVhEmRcsWLQjTvCk1qdHmUTfu79+E6c644=;
 b=f/2V055KITt+0m6Dly97XZvbzuaU4488B2iqSwdmL7qBFTsbwYjLk7Cb4EFUSB0y8m
 Jt6YF/uDwtmXTGlQEgpvxXGCuynbZNoBGIhPea3J85aCniVcz8yIAD4BX188gK98b0Wp
 dKm8wUrCQ8l3MEGsCyYnbHyzSeJkd8WtbkMmscWIUJ+Uwevsh+ZrK2/2Nsq5bvSogrCA
 koZ4ANHJfYnwtIPH4VnaPHp0pHfBTq0PBOnxtEr/F8w189h4B+2v9DTLqZKrFgFiBeOc
 uOrqYOMsqXv5WvY9f/XSYR7xBQVmEtktAiYBEYPQ/PBvfJMDX0gnZBgqyQTfeeyvMM3A
 S3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OYOkhfqBvCVhEmRcsWLQjTvCk1qdHmUTfu79+E6c644=;
 b=iLHdQz/uGbIfrk9DaT3nDTleTl8RbHWInDayoNvZqQBRmaJGdeZbk5/gsgHJIA3dnd
 Q9HngkpM/ciTH8fE3VKLO/r4uU8pQOF1qLLJ/PFlFomhq2BbfsXtfY+sUzDvpG8pvROS
 PTU8yZOx57Xru+daXvBrGnhD5oizD5yZMVV3KKw6l36DRWfMq++z0bSzG/c/tF+p5L4p
 hBnn6P2zXM1sFVTM8Qz7uA491VDMuJOw0w8QzFuYOXV6kidMOkKFrRAUzJFACU9nK7U3
 mpUg9HByvL2pMkZiHuMir583JMgArBAcF1ZWUm+iUkCyqDtMHGpN7hWvwxi9v5b5dxrk
 j2HA==
X-Gm-Message-State: AOAM532MTpr4TfWes/tsefXYS6t6wZAuQGVJ9CN7HkJu9AuhvYZEKLlF
 N0SnVtBhgT+Naxkh24mOLYcbbQ==
X-Google-Smtp-Source: ABdhPJw3EpVECZRcN+jMhpRzl3QD2ed6YyLIdm+b0fgfB1itsjZv3w5cZV55p7V8yBe2MpWQIDVmAQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr3687140wmi.138.1601048435278; 
 Fri, 25 Sep 2020 08:40:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm3455402wma.16.2020.09.25.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99DDD1FF8F;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/15] meson: move libmpathpersist test
Date: Fri, 25 Sep 2020 16:40:15 +0100
Message-Id: <20200925154027.12672-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This is the first compiler/linker test that has been moved to Meson.
Add more section headings to keep things clearer.

[thuth: Add check for mpathpersist.found() before showing mpathpersist_new_api]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200918103430.297167-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure         | 77 +++-----------------------------------------
 meson.build       | 82 ++++++++++++++++++++++++++++++++++++++++++-----
 meson_options.txt |  2 ++
 3 files changed, 80 insertions(+), 81 deletions(-)

diff --git a/configure b/configure
index 48bf437021f6..b81868cf0231 100755
--- a/configure
+++ b/configure
@@ -403,7 +403,7 @@ netmap="no"
 sdl="auto"
 sdl_image="auto"
 virtfs=""
-mpath=""
+mpath="auto"
 vnc="enabled"
 sparse="no"
 vde=""
@@ -1116,9 +1116,9 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
-  --disable-mpath) mpath="no"
+  --disable-mpath) mpath="disabled"
   ;;
-  --enable-mpath) mpath="yes"
+  --enable-mpath) mpath="enabled"
   ;;
   --disable-vnc) vnc="disabled"
   ;;
@@ -3848,57 +3848,6 @@ if test "$modules" = yes; then
     fi
 fi
 
-##########################################
-# libmpathpersist probe
-
-if test "$mpath" != "no" ; then
-  # probe for the new API
-  cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len = 1024;
-int logsink;
-static struct config *multipath_conf;
-extern struct udev *udev;
-extern struct config *get_multipath_config(void);
-extern void put_multipath_config(struct config *conf);
-struct udev *udev;
-struct config *get_multipath_config(void) { return multipath_conf; }
-void put_multipath_config(struct config *conf) { }
-
-int main(void) {
-    udev = udev_new();
-    multipath_conf = mpath_lib_init();
-    return 0;
-}
-EOF
-  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-    mpathpersist=yes
-    mpathpersist_new_api=yes
-  else
-    # probe for the old API
-    cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len = 1024;
-int logsink;
-int main(void) {
-    struct udev *udev = udev_new();
-    mpath_lib_init(udev);
-    return 0;
-}
-EOF
-    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-      mpathpersist=yes
-      mpathpersist_new_api=no
-    else
-      mpathpersist=no
-    fi
-  fi
-else
-  mpathpersist=no
-fi
-
 ##########################################
 # pthread probe
 PTHREADLIBS_LIST="-pthread -lpthread -lpthreadGC2"
@@ -6340,23 +6289,11 @@ if test "$softmmu" = yes ; then
       fi
       virtfs=no
     fi
-    if test "$mpath" != no && test "$mpathpersist" = yes ; then
-      mpath=yes
-    else
-      if test "$mpath" = yes; then
-        error_exit "Multipath requires libmpathpersist devel"
-      fi
-      mpath=no
-    fi
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
     fi
     virtfs=no
-    if test "$mpath" = yes; then
-      error_exit "Multipath is supported only on Linux"
-    fi
-    mpath=no
   fi
 fi
 
@@ -6897,12 +6834,6 @@ fi
 if test "$virtfs" = "yes" ; then
   echo "CONFIG_VIRTFS=y" >> $config_host_mak
 fi
-if test "$mpath" = "yes" ; then
-  echo "CONFIG_MPATH=y" >> $config_host_mak
-  if test "$mpathpersist_new_api" = "yes"; then
-    echo "CONFIG_MPATH_NEW_API=y" >> $config_host_mak
-  fi
-fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
@@ -7992,7 +7923,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dsdl=$sdl -Dsdl_image=$sdl_image \
+	-Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
diff --git a/meson.build b/meson.build
index 48724988972d..c09d869f9b02 100644
--- a/meson.build
+++ b/meson.build
@@ -81,6 +81,14 @@ if 'SPARSE_CFLAGS' in config_host
                        'compile_commands.json'])
 endif
 
+###########################################
+# Target-specific checks and dependencies #
+###########################################
+
+if targetos != 'linux' and get_option('mpath').enabled()
+  error('Multipath is supported only on Linux')
+endif
+
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 winmm = []
@@ -112,6 +120,11 @@ elif targetos == 'haiku'
             cc.find_library('network'),
             cc.find_library('bsd')]
 endif
+
+################
+# Dependencies #
+################
+
 # The path to glib.h is added to all compilation commands.  This was
 # grandfathered in from the QEMU Makefiles.
 add_project_arguments(config_host['GLIB_CFLAGS'].split(),
@@ -218,10 +231,6 @@ if 'CONFIG_SPICE' in config_host
                              link_args: config_host['SPICE_LIBS'].split())
 endif
 rt = cc.find_library('rt', required: false)
-libmpathpersist = not_found
-if config_host.has_key('CONFIG_MPATH')
-  libmpathpersist = cc.find_library('mpathpersist')
-endif
 libdl = not_found
 if 'CONFIG_PLUGIN' in config_host
   libdl = cc.find_library('dl', required: true)
@@ -252,9 +261,62 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if target_os == 'linux'
-  libudev = dependency('libudev', static: enable_static)
+if targetos == 'linux'
+  libudev = dependency('libudev',
+                       required: get_option('mpath'),
+                       static: enable_static)
+endif
+
+mpathpersist = not_found
+if targetos == 'linux' and not get_option('mpath').disabled()
+  libmultipath = cc.find_library('multipath',
+                                 required: get_option('mpath'),
+                                 static: enable_static)
+  libmpathpersist = cc.find_library('mpathpersist',
+                                    required: get_option('mpath'),
+                                    static: enable_static)
+  if libmultipath.found() and libmpathpersist.found() and libudev.found()
+    if cc.links('''
+      #include <libudev.h>
+      #include <mpath_persist.h>
+      unsigned mpath_mx_alloc_len = 1024;
+      int logsink;
+      static struct config *multipath_conf;
+      extern struct udev *udev;
+      extern struct config *get_multipath_config(void);
+      extern void put_multipath_config(struct config *conf);
+      struct udev *udev;
+      struct config *get_multipath_config(void) { return multipath_conf; }
+      void put_multipath_config(struct config *conf) { }
+      int main(void) {
+          udev = udev_new();
+          multipath_conf = mpath_lib_init();
+          return 0;
+      }''', dependencies: [libmultipath, libmpathpersist, libudev])
+      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
+      mpathpersist_new_api = true
+    elif cc.links('''
+      #include <libudev.h>
+      #include <mpath_persist.h>
+      unsigned mpath_mx_alloc_len = 1024;
+      int logsink;
+      int main(void) {
+          struct udev *udev = udev_new();
+          mpath_lib_init(udev);
+          return 0;
+      }''', dependencies: [libmultipath, libmpathpersist, libudev])
+      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
+      mpathpersist_new_api = false
+    else
+      if get_option('mpath').enabled()
+        error('Cannot detect libmpathpersist API')
+      else
+        warning('Cannot detect libmpathpersist API, disabling')
+      endif
+    endif
+  endif
 endif
+
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
@@ -436,6 +498,10 @@ has_gettid = cc.has_function('gettid')
 # Create config-host.h
 
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
+config_host_data.set('CONFIG_MPATH', mpathpersist.found())
+if mpathpersist.found()
+  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
+endif
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1185,7 +1251,7 @@ if have_tools
 
     executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
-                              libcap_ng, libudev, libmpathpersist],
+                              libcap_ng, mpathpersist],
                install: true)
   endif
 
@@ -1407,7 +1473,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
-summary_info += {'Multipath support': config_host.has_key('CONFIG_MPATH')}
+summary_info += {'Multipath support': mpathpersist.found()}
 summary_info += {'VNC support':       vnc.found()}
 if vnc.found()
   summary_info += {'VNC SASL support':  sasl.found()}
diff --git a/meson_options.txt b/meson_options.txt
index 543cf70043a2..b38a6ae92a92 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,8 @@ option('docdir', type : 'string', value : 'doc',
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
 
+option('mpath', type : 'feature', value : 'auto',
+       description: 'Multipath persistent reservation passthrough')
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
-- 
2.20.1


