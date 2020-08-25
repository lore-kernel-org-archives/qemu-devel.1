Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B47C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37512075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtk02l45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37512075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kASLC-0003gP-UT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kASJh-0002MP-TZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kASJf-0002a1-Au
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598336417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGTPTmoPKzRsP17keVIz+Uz5RFhbByT3EmOjh1h6epY=;
 b=Vtk02l45SE2Mc1G9LHZKrVMshEEX+/OiMbgWRGGY8PYnL6AdOhXh74iYf29dfEFsYz51bd
 BQ1sRwp+FYZ/NQwfOVLRM25qWpgd9s0+0JSV9HUR9NhEQms+O5YRO7pC46gvX4+UjgUI6C
 LdVTbH9htR+3bMfcfQF8Wrl7CjA/Uu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-lIgeAlI6N5erxNIQp4LmEg-1; Tue, 25 Aug 2020 02:20:13 -0400
X-MC-Unique: lIgeAlI6N5erxNIQp4LmEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99B2180EDA3;
 Tue, 25 Aug 2020 06:20:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C7F6FDBB;
 Tue, 25 Aug 2020 06:20:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 645979A8F; Tue, 25 Aug 2020 08:20:08 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] meson: move xkbcommon to meson
Date: Tue, 25 Aug 2020 08:20:07 +0200
Message-Id: <20200825062008.6502-3-kraxel@redhat.com>
In-Reply-To: <20200825062008.6502-1-kraxel@redhat.com>
References: <20200825062008.6502-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: laurent@vivier.eu, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20200824152430.1844159-2-laurent@vivier.eu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure         | 29 ++++-------------------------
 meson_options.txt |  1 +
 meson.build       | 11 ++++++-----
 ui/meson.build    |  2 +-
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/configure b/configure
index 377aafa2acd5..b1e11397a827 100755
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
@@ -8251,7 +8230,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson_options.txt b/meson_options.txt
index e5f45243ce78..c55f9cd94cb2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -5,3 +5,4 @@ option('vnc', type : 'feature', value : 'enabled')
 option('vnc_jpeg', type : 'feature', value : 'auto')
 option('vnc_png', type : 'feature', value : 'auto')
 option('vnc_sasl', type : 'feature', value : 'auto')
+option('xkbcommon', type : 'feature', value : 'auto')
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
2.27.0


