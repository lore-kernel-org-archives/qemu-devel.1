Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2651B2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2651B2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEMt-0007Dh-Fj
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKw-0004T6-VX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:42 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKu-0003e6-O2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:42 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mi2eP-1knOdP1DI9-00e58E; Mon, 24 Aug 2020 17:24:34 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] meson: move xkbcommon to meson
Date: Mon, 24 Aug 2020 17:24:29 +0200
Message-Id: <20200824152430.1844159-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824152430.1844159-1-laurent@vivier.eu>
References: <20200824152430.1844159-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k5i2OgnE//VPoIRxpa/RiHE+HJcOnXWLM2V8QV9O/H9eCeCq75q
 0QQYbRgh7pQVeOAYdZSvrv5b8rVnPMhtevbMWI8bZqWKlL/BRfyK62vtLrwkV2LMmYoxStF
 BTWkwlqYC24xms893qpScXYDOWubP6AO7AmRJSRbrO158bdomFZghoGkzj5zBe6rVy2wg9O
 AWUX1psORcmlu6cl7HFMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vbzckGlfBnY=:vpTigehA1EXSRWy9TJpDR3
 dZZm/VjGxTu4BTvIq7d2aZkUzv9ibaaOTZzPoB2bfJGQNWqJabRuK/TlucYKI9A/g7kMCrT2d
 69CkxqFyi6ZJab6SQtF/jv5AR/XWM05NupO5XpzBRAB2FhswHIwqxMGBhmVYRphs2ypyCPlCh
 6rVLct8vI8Bne2yig3KKzuCxcSfsVzad8Tuvay3WRKLcYmrLw2ut/qyhp4IuD8MXzkoUJ7RuN
 SWQHt9Uar5fQ+sF7wa+l+zwe3+TjaNJSczR+5wc2Y3jdS/uxmAgfidO9gv5obsaG7yAtWe9b4
 fHAZHuX2fojc754w5Il0nrGjBywxMzkiyYh9rigcw0oCDcuNbrX7eHFkHVI2hm/0jeTWFfwZ5
 fJ3Gw+8cqoTWTVP8LYjcHLd5mJFVDv/fucuTDbkzij5uY6UfbOyj99FIgSXVqTPXUgMMEjUAu
 utFXpAH+gbiqwVAp2/5QJFhQdLxUoVCoWtsZsr2S9L4aZmIpFIcgRSfAb3M/K/mLfMGIzlVKk
 syonLLyMwO1JKSZmjzadg68BEPWiIZGm1ZkagZ9K4kHv94H02ZrexC0m1KcchmUwbUSdORqLd
 QNHmVd9CCR5RNL+GsFyOSwbFSmHez1LEvFRg4eaCPF3sxkwXAOJWpVXyNLkX1ZpA4gCNmJfqB
 Etm4qcBl8b8yPXBMNiq8qt1/aZdPxvlayRsd3VQSBkZ+Ac0PNqVLumPRY7pF44nLv8QZqPJgi
 DJl5eeQBNSf0W6P45nQ8NY7CsH44Skd7AC8WED9DEUTmE24B8Mkp2JBGyz5o3LoKBpc3DxCtW
 r/j1EuK3S88A7NvIlGzHuk7MgkpXuwkeRy5E4Ei84CtDuQduYq1SyvR+tErRey47uW7ZeML
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:24:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure         | 29 ++++-------------------------
 meson.build       | 11 ++++++-----
 meson_options.txt |  1 +
 ui/meson.build    |  2 +-
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/configure b/configure
index 67832e3bab76..dcc4bca5e42e 100755
--- a/configure
+++ b/configure
@@ -432,7 +432,7 @@ vde=""
 vnc_sasl="auto"
 vnc_jpeg="auto"
 vnc_png="auto"
-xkbcommon=""
+xkbcommon="auto"
 xen=""
 xen_ctrl_version=""
 xen_pci_passthrough=""
@@ -1631,9 +1631,9 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
-  --enable-xkbcommon) xkbcommon=yes
+  --enable-xkbcommon) xkbcommon="enabled"
   ;;
-  --disable-xkbcommon) xkbcommon=no
+  --disable-xkbcommon) xkbcommon="disabled"
   ;;
   --enable-plugins) plugins="yes"
   ;;
@@ -3446,22 +3446,6 @@ EOF
     fi
 fi
 
-##########################################
-# xkbcommon probe
-if test "$xkbcommon" != "no" ; then
-  if $pkg_config xkbcommon --exists; then
-    xkbcommon_cflags=$($pkg_config xkbcommon --cflags)
-    xkbcommon_libs=$($pkg_config xkbcommon --libs)
-    xkbcommon=yes
-  else
-    if test "$xkbcommon" = "yes" ; then
-      feature_not_found "xkbcommon" "Install libxkbcommon-devel"
-    fi
-    xkbcommon=no
-  fi
-fi
-
-
 ##########################################
 # xfsctl() probe, used for file-posix.c
 if test "$xfs" != "no" ; then
@@ -6827,11 +6811,6 @@ if test "$audio_win_int" = "yes" ; then
 fi
 echo "CONFIG_BDRV_RW_WHITELIST=$block_drv_rw_whitelist" >> $config_host_mak
 echo "CONFIG_BDRV_RO_WHITELIST=$block_drv_ro_whitelist" >> $config_host_mak
-if test "$xkbcommon" = "yes" ; then
-  echo "CONFIG_XKBCOMMON=y" >> $config_host_mak
-  echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
-  echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
-fi
 if test "$xfs" = "yes" ; then
   echo "CONFIG_XFS=y" >> $config_host_mak
 fi
@@ -8250,7 +8229,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index df5bf728b57a..f6e346af1a69 100644
--- a/meson.build
+++ b/meson.build
@@ -152,10 +152,10 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
-xkbcommon = not_found
-if 'CONFIG_XKBCOMMON' in config_host
-  xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
-                                 link_args: config_host['XKBCOMMON_LIBS'].split())
+xkbcommon = dependency('xkbcommon', required: get_option('xkbcommon'), static: enable_static,
+                       include_type: 'system')
+if xkbcommon.found()
+  xkbcommon = declare_dependency(dependencies: xkbcommon)
 endif
 slirp = not_found
 if config_host.has_key('CONFIG_SLIRP')
@@ -389,6 +389,7 @@ config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_PNG', png.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
+config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -1062,7 +1063,7 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
-if 'CONFIG_XKBCOMMON' in config_host
+if xkbcommon.found()
   # used for the update-keymaps target, so include rules even if !have_tools
   qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
                            dependencies: [qemuutil, xkbcommon], install: have_tools)
diff --git a/meson_options.txt b/meson_options.txt
index e5f45243ce78..c55f9cd94cb2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -5,3 +5,4 @@ option('vnc', type : 'feature', value : 'enabled')
 option('vnc_jpeg', type : 'feature', value : 'auto')
 option('vnc_png', type : 'feature', value : 'auto')
 option('vnc_sasl', type : 'feature', value : 'auto')
+option('xkbcommon', type : 'feature', value : 'auto')
diff --git a/ui/meson.build b/ui/meson.build
index 81fd393432a4..018c5698bf66 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -95,7 +95,7 @@ keymaps = [
   ['osx', 'qcode'],
 ]
 
-if have_system or 'CONFIG_XKBCOMMON' in config_host
+if have_system or xkbcommon.found()
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
-- 
2.26.2


