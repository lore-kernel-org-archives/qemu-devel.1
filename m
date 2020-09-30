Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1AEC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8AD20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/PzAud+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8AD20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNiIH-0008Jn-GU
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFd-0006Hg-EZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFb-000790-J1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id w5so3130104wrp.8
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W6Lam4OFe7gO57Je+OnMrr6I7gK609J1eHhN01o9JRw=;
 b=R/PzAud+eR5WyPIfAAKak6esb8X6XfS4qlCrKpF3dpsUqszxyW1GSr96SQw56VApKU
 9gWmSmEl+/1lT+Acbjy+OFZEH8d/1eHHDtUYOKEhEM3KHDktdjyjKRtdThaiqGtfVQs4
 NYfSitEimRDCrnyxIkw4HRdoTLkRfKaPHj1W9VfPrOC0OwChpQdu8qBztIiAzgOQx2k4
 Xei+B1TC7sO+cXoF8VG8GWXAt+S6wzeYRNkC6J6zVFSMjDPDdsUwYEzQesbVewS0AsEg
 PmRkG0M9Az4AXeLFEjzv4Xyl45sU/Vd51s1RmgP47ly6nflXriaF450OdQO4Gs7CySkc
 orMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W6Lam4OFe7gO57Je+OnMrr6I7gK609J1eHhN01o9JRw=;
 b=hW7ZsLb/WMuJEOnaESFwD8cS/r+oPOx7eXM3jSOQmglTPKre9hudKzlQF9VJdDlMJI
 6LjRfGJ2Pdp7x7ATnwvUtb5HOjta2ph1qGnbSWDDnNbngSwojd6LWgVh77XXfZUwuE16
 gv/wpZLGRgK0Mw8UYoWZ0h2YsB7QuQf+pz/znefY8NT6Pc3tJFX/sWJGt7nqAVJNzrfx
 RUu+wD28x4lgdbOczm08oHQ/EQYax5qy/IZXTxBLY3nNtcaAUwVT8nm0tTbsp5YD3KBx
 aFuWskBkyinKkxdwLCR98aGg8MURzzZqMdPzEreumK/o3BifgonPnV+6viRKMu/QQ1X9
 hKDw==
X-Gm-Message-State: AOAM5333qjwbpigFbDKa+EphG9ihw6AW4YYB1pHbdDRB1bKNDTuudYJC
 PCW8bugS1Deg6mXls+zNA6QbQDqanCc=
X-Google-Smtp-Source: ABdhPJwzuQh2VjbZh8ddKRn6+dQk9TjsGwVPK4HRAMWYxmgblrIqji1pyS3Ux+WHzWo3LWnhvDaUBw==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr4661491wrn.238.1601495933000; 
 Wed, 30 Sep 2020 12:58:53 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id
 b64sm4824204wmh.13.2020.09.30.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 12:58:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/86] meson: move libmpathpersist test
Date: Wed, 30 Sep 2020 21:58:49 +0200
Message-Id: <20200930195850.278104-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930195850.278104-1-pbonzini@redhat.com>
References: <20200930195850.278104-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first compiler/linker test that has been moved to Meson.
Add more section headings to keep things clearer.

This also fixes static linking to libmpathpersist, which has a
dependency on libmultipath but no pkg-config file to describe it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 77 +++-----------------------------------------
 meson.build       | 81 +++++++++++++++++++++++++++++++++++++++++++----
 meson_options.txt |  2 ++
 3 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/configure b/configure
index 6f2599f99f..aade6eb285 100755
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
@@ -3852,57 +3852,6 @@ if test "$modules" = yes; then
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
@@ -6337,23 +6286,11 @@ if test "$softmmu" = yes ; then
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
 
@@ -6894,12 +6831,6 @@ fi
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
@@ -7988,7 +7919,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dsdl=$sdl -Dsdl_image=$sdl_image \
+	-Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
diff --git a/meson.build b/meson.build
index cd3d1ee260..8e9cd67235 100644
--- a/meson.build
+++ b/meson.build
@@ -86,6 +86,14 @@ if 'SPARSE_CFLAGS' in config_host
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
@@ -117,6 +125,11 @@ elif targetos == 'haiku'
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
@@ -223,10 +236,6 @@ if 'CONFIG_SPICE' in config_host
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
@@ -258,8 +267,64 @@ if 'CONFIG_CURL' in config_host
 endif
 libudev = not_found
 if targetos == 'linux' and (have_system or have_tools)
-  libudev = dependency('libudev', static: enable_static)
+  libudev = dependency('libudev',
+                       required: get_option('mpath').enabled(),
+                       static: enable_static)
+endif
+
+mpathpersist = not_found
+mpathpersist_new_api = false
+if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
+  mpath_test_source_new = '''
+    #include <libudev.h>
+    #include <mpath_persist.h>
+    unsigned mpath_mx_alloc_len = 1024;
+    int logsink;
+    static struct config *multipath_conf;
+    extern struct udev *udev;
+    extern struct config *get_multipath_config(void);
+    extern void put_multipath_config(struct config *conf);
+    struct udev *udev;
+    struct config *get_multipath_config(void) { return multipath_conf; }
+    void put_multipath_config(struct config *conf) { }
+    int main(void) {
+        udev = udev_new();
+        multipath_conf = mpath_lib_init();
+        return 0;
+    }'''
+  mpath_test_source_old = '''
+      #include <libudev.h>
+      #include <mpath_persist.h>
+      unsigned mpath_mx_alloc_len = 1024;
+      int logsink;
+      int main(void) {
+          struct udev *udev = udev_new();
+          mpath_lib_init(udev);
+          return 0;
+      }'''
+  libmultipath = cc.find_library('multipath',
+                                 required: get_option('mpath'),
+                                 static: enable_static)
+  libmpathpersist = cc.find_library('mpathpersist',
+                                    required: get_option('mpath'),
+                                    static: enable_static)
+  if libmultipath.found() and libmpathpersist.found() and libudev.found()
+    mpathlibs = [libmultipath, libmpathpersist, libudev]
+    if cc.links(mpath_test_source_new, dependencies: mpathlibs)
+      mpathpersist = declare_dependency(dependencies: mpathlibs)
+      mpathpersist_new_api = true
+    elif cc.links(mpath_test_source_old, dependencies: mpathlibs)
+      mpathpersist = declare_dependency(dependencies: mpathlibs)
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
@@ -441,6 +506,8 @@ has_gettid = cc.has_function('gettid')
 # Create config-host.h
 
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
+config_host_data.set('CONFIG_MPATH', mpathpersist.found())
+config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1205,7 +1272,7 @@ if have_tools
 
     executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
-                              libcap_ng, libudev, libmpathpersist],
+                              libcap_ng, mpathpersist],
                install: true)
   endif
 
@@ -1342,7 +1409,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
-summary_info += {'Multipath support': config_host.has_key('CONFIG_MPATH')}
+summary_info += {'Multipath support': mpathpersist.found()}
 summary_info += {'VNC support':       vnc.found()}
 if vnc.found()
   summary_info += {'VNC SASL support':  sasl.found()}
diff --git a/meson_options.txt b/meson_options.txt
index 543cf70043..b38a6ae92a 100644
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
2.26.2



