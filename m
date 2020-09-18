Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8140C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387AB20795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX6f/voL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387AB20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJ6T-0003cx-7T
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIrA-0001Sl-Ci; Fri, 18 Sep 2020 12:03:32 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:46540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr6-00022V-SQ; Fri, 18 Sep 2020 12:03:27 -0400
Received: by mail-pg1-x530.google.com with SMTP id 34so3715979pgo.13;
 Fri, 18 Sep 2020 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PObA7qDGq61ijr7OJQ2hN5JLm532x4zIpGeZLkEIZQA=;
 b=kX6f/voLwJOw0o2dwrI/hSRiRr0e70gkxbESJRPqMdP72YaiVpEbRuqAkEwILl030R
 StzMxjQzwPojyBH/KHQG8Onw+0C4mpH4NT0fH/CkceU+BITzwr6HXheV2Ks/hQbrji4B
 kyUdprsRQJhbjcrQOnsQr3VMI5fFlMd2JwbawlBqIukEGc6auTDCv8Jlt/QBUeb7CcD9
 5Chxg7OHzN1GbWfzRMnb7iFYcOBa0n1/teKUn4vgJ/7CjJJ+bmFkVDCBC8T2OKQdU0O3
 DKxWzMmdmPIbnHclORYdzFY5xN/ZKAB45wT9KZB9mIownfmk3oylcH/cAcXMLudT8NXr
 1slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PObA7qDGq61ijr7OJQ2hN5JLm532x4zIpGeZLkEIZQA=;
 b=BquUohqCkNpLbVVSaKeYRpLWnZgycwkAMekEz1I7BEFmCTuW20HVBAPUkg+YyMKis1
 K+kYh6aKCnNt2sGDO692Z2dY6wMjd5nyox7KLGaoRPjJvztb4DEaIvkPydbdDGOSV+Zm
 u7rkznwPcHEL6FbP5j44X9GZuT1YvMtlmu9/tujJkGZC1mibvwLtKQ68EVjgiecT07hR
 XI1zca3kLpwZ/33zkfUXXpjD7fI9UuJTysyBcZ8WDqcJUQMxZj9H+uN5WtXE5Y87aUPB
 11otRaG+zkcZ/ET+YudmphkyiWWXjKpZLpgWt4k05Lul8Cp19cJKDhQkrlmAQdH9akml
 Hy+A==
X-Gm-Message-State: AOAM533D1/RGCugjGvA/RDb57vZIjUeV9cdJJt+RKGd6AtMAxQVHEudF
 m+a2dV6NtkZO3ld7r/WGYpmApAo4nFG0Tg==
X-Google-Smtp-Source: ABdhPJznQLSEJA67dSUaA/DWNICyBJExQtHOSWK7WtSskwsNl9tws4GTTVLi4TVkAW6xsyaFmuY7pQ==
X-Received: by 2002:a63:1226:: with SMTP id h38mr26912298pgl.196.1600445002486; 
 Fri, 18 Sep 2020 09:03:22 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z22sm16889012pjq.2.2020.09.18.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:03:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/4] configure: Fixes ncursesw detection under msys2/mingw
 by convert them to meson
Date: Sat, 19 Sep 2020 00:02:50 +0800
Message-Id: <20200918160250.1141-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200918160250.1141-1-luoyonggang@gmail.com>
References: <20200918160250.1141-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mingw pkg-config are showing following absolute path and contains : as the separator,

-D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lncursesw
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lcursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure         | 121 +++-------------------------------------------
 meson.build       |  80 +++++++++++++++++++++++++-----
 meson_options.txt |   4 ++
 ui/meson.build    |   2 +-
 4 files changed, 80 insertions(+), 127 deletions(-)

diff --git a/configure b/configure
index 21c010140c..2ddb034aa5 100755
--- a/configure
+++ b/configure
@@ -396,7 +396,8 @@ unset target_list_exclude
 
 brlapi=""
 curl=""
-curses=""
+iconv="auto"
+curses="auto"
 docs=""
 fdt=""
 netmap="no"
@@ -1285,13 +1286,13 @@ for opt do
   ;;
   --disable-safe-stack) safe_stack="no"
   ;;
-  --disable-curses) curses="no"
+  --disable-curses) curses="disabled"
   ;;
-  --enable-curses) curses="yes"
+  --enable-curses) curses="enabled"
   ;;
-  --disable-iconv) iconv="no"
+  --disable-iconv) iconv="disabled"
   ;;
-  --enable-iconv) iconv="yes"
+  --enable-iconv) iconv="enabled"
   ;;
   --disable-curl) curl="no"
   ;;
@@ -3581,105 +3582,6 @@ EOF
   fi
 fi
 
-##########################################
-# iconv probe
-if test "$iconv" != "no" ; then
-  cat > $TMPC << EOF
-#include <iconv.h>
-int main(void) {
-  iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
-  return conv != (iconv_t) -1;
-}
-EOF
-  iconv_prefix_list="/usr/local:/usr"
-  iconv_lib_list=":-liconv"
-  IFS=:
-  for iconv_prefix in $iconv_prefix_list; do
-    IFS=:
-    iconv_cflags="-I$iconv_prefix/include"
-    iconv_ldflags="-L$iconv_prefix/lib"
-    for iconv_link in $iconv_lib_list; do
-      unset IFS
-      iconv_lib="$iconv_ldflags $iconv_link"
-      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >> config.log
-      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
-        iconv_found=yes
-        break
-      fi
-    done
-    if test "$iconv_found" = yes ; then
-      break
-    fi
-  done
-  if test "$iconv_found" = "yes" ; then
-    iconv=yes
-  else
-    if test "$iconv" = "yes" ; then
-      feature_not_found "iconv" "Install iconv devel"
-    fi
-    iconv=no
-  fi
-fi
-
-##########################################
-# curses probe
-if test "$iconv" = "no" ; then
-  # curses will need iconv
-  curses=no
-fi
-if test "$curses" != "no" ; then
-  if test "$mingw32" = "yes" ; then
-    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
-    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-lpdcurses"
-  else
-    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr/include/ncursesw:"
-    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw:-lcursesw"
-  fi
-  curses_found=no
-  cat > $TMPC << EOF
-#include <locale.h>
-#include <curses.h>
-#include <wchar.h>
-#include <langinfo.h>
-int main(void) {
-  const char *codeset;
-  wchar_t wch = L'w';
-  setlocale(LC_ALL, "");
-  resize_term(0, 0);
-  addwstr(L"wide chars\n");
-  addnwstr(&wch, 1);
-  add_wch(WACS_DEGREE);
-  codeset = nl_langinfo(CODESET);
-  return codeset != 0;
-}
-EOF
-  IFS=:
-  for curses_inc in $curses_inc_list; do
-    # Make sure we get the wide character prototypes
-    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
-    IFS=:
-    for curses_lib in $curses_lib_list; do
-      unset IFS
-      if compile_prog "$curses_inc" "$curses_lib" ; then
-        curses_found=yes
-        break
-      fi
-    done
-    if test "$curses_found" = yes ; then
-      break
-    fi
-  done
-  unset IFS
-  if test "$curses_found" = "yes" ; then
-    curses=yes
-  else
-    if test "$curses" = "yes" ; then
-      feature_not_found "curses" "Install ncurses devel"
-    fi
-    curses=no
-  fi
-fi
-
 ##########################################
 # curl probe
 if test "$curl" != "no" ; then
@@ -6527,16 +6429,6 @@ if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
-if test "$iconv" = "yes" ; then
-  echo "CONFIG_ICONV=y" >> $config_host_mak
-  echo "ICONV_CFLAGS=$iconv_cflags" >> $config_host_mak
-  echo "ICONV_LIBS=$iconv_lib" >> $config_host_mak
-fi
-if test "$curses" = "yes" ; then
-  echo "CONFIG_CURSES=y" >> $config_host_mak
-  echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
-  echo "CURSES_LIBS=$curses_lib" >> $config_host_mak
-fi
 if test "$pipe2" = "yes" ; then
   echo "CONFIG_PIPE2=y" >> $config_host_mak
 fi
@@ -7816,6 +7708,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
+        -Diconv=$iconv -Dcurses=$curses \
         -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
         -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
         -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
diff --git a/meson.build b/meson.build
index ace15dc8c0..3088566ff4 100644
--- a/meson.build
+++ b/meson.build
@@ -340,6 +340,71 @@ if targetos == 'linux' and not get_option('mpath').disabled()
   endif
 endif
 
+iconv = not_found
+if not get_option('iconv').disabled()
+  libiconv = cc.find_library('iconv', static: enable_static)
+  if libiconv.found()
+    if cc.links('''
+      #include <iconv.h>
+      int main(void) {
+        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
+        return conv != (iconv_t) -1;
+      }''', dependencies: [libiconv])
+      iconv = declare_dependency(dependencies: [libiconv])
+    endif
+  endif
+endif
+if get_option('iconv').enabled() and not iconv.found()
+  error('Cannot detect iconv API')
+endif
+
+curses = not_found
+if iconv.found() and not get_option('curses').disabled()
+  curses_libname_list = ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
+  foreach curses_libname : curses_libname_list
+      libcurses = dependency(curses_libname,
+                             required: false,
+                             method: 'pkg-config',
+                             static: enable_static)
+
+      if not libcurses.found()
+        dirs = ['/usr/include/ncursesw']
+        if targetos == 'windows'
+          dirs = []
+        endif
+        libcurses = cc.find_library(curses_libname,
+                                    required: false,
+                                    dirs: dirs,
+                                    static: enable_static)
+      endif
+      if libcurses.found()
+        if cc.links('''
+          #include <locale.h>
+          #include <curses.h>
+          #include <wchar.h>
+          int main(void) {
+            wchar_t wch = L'w';
+            setlocale(LC_ALL, "");
+            resize_term(0, 0);
+            addwstr(L"wide chars\n");
+            addnwstr(&wch, 1);
+            add_wch(WACS_DEGREE);
+            return 0;
+          }''', compile_args: '-DNCURSES_WIDECHAR', dependencies: [libcurses])
+          curses = declare_dependency(compile_args: '-DNCURSES_WIDECHAR', dependencies: [libcurses])
+          break
+        endif
+      endif
+  endforeach
+endif
+if get_option('curses').enabled() and not curses.found()
+  if not iconv.found()
+    error('Cannot detect iconv API')
+  else
+    error('Cannot detect curses API')
+  endif
+endif
+
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
@@ -418,16 +483,6 @@ if 'CONFIG_X11' in config_host
   x11 = declare_dependency(compile_args: config_host['X11_CFLAGS'].split(),
                            link_args: config_host['X11_LIBS'].split())
 endif
-curses = not_found
-if 'CONFIG_CURSES' in config_host
-  curses = declare_dependency(compile_args: config_host['CURSES_CFLAGS'].split(),
-                              link_args: config_host['CURSES_LIBS'].split())
-endif
-iconv = not_found
-if 'CONFIG_ICONV' in config_host
-  iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
-                             link_args: config_host['ICONV_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
@@ -544,6 +599,7 @@ config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
+config_host_data.set('CONFIG_CURSES', curses.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1521,8 +1577,8 @@ if config_host.has_key('CONFIG_NETTLE')
 endif
 summary_info += {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
 summary_info += {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}
-summary_info += {'iconv support':     config_host.has_key('CONFIG_ICONV')}
-summary_info += {'curses support':    config_host.has_key('CONFIG_CURSES')}
+summary_info += {'iconv support':     iconv.found()}
+summary_info += {'curses support':    curses.found()}
 # TODO: add back version
 summary_info += {'virgl support':     config_host.has_key('CONFIG_VIRGL')}
 summary_info += {'curl support':      config_host.has_key('CONFIG_CURL')}
diff --git a/meson_options.txt b/meson_options.txt
index 46ea1d889a..a5d155a535 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -15,6 +15,10 @@ option('cocoa', type : 'feature', value : 'auto',
        description: 'Cocoa user interface (macOS only)')
 option('mpath', type : 'feature', value : 'auto',
        description: 'Multipath persistent reservation passthrough')
+option('iconv', type : 'feature', value : 'auto',
+       description: 'Font glyph conversion support')
+option('curses', type : 'feature', value : 'auto',
+       description: 'curses UI')
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
diff --git a/ui/meson.build b/ui/meson.build
index 8a080c38e3..78ad792ffb 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -39,7 +39,7 @@ specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: opengl)
 
 ui_modules = {}
 
-if config_host.has_key('CONFIG_CURSES')
+if curses.found()
   curses_ss = ss.source_set()
   curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'), pixman])
   ui_modules += {'curses' : curses_ss}
-- 
2.28.0.windows.1


