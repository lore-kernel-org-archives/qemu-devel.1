Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D793C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3BE206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3BE206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQT3V-0001pO-MG
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQT2m-0001Bh-DE
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:04 -0400
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:20715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQT2i-0003qq-P3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:03 -0400
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by
 mgwym03.jp.fujitsu.com with smtp
 id 3eca_3af1_6dbc38ff_d992_4775_9323_2fe8187539f5;
 Thu, 08 Oct 2020 19:20:48 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id BF868AC011C
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 19:20:46 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id E1F4032880B;
 Thu,  8 Oct 2020 19:20:45 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW14.g01.fujitsu.local (10.0.194.53) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 19:20:45 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <qemu-devel@nongnu.org>, <virtio-fs@redhat.com>, <pbonzini@redhat.com>
Subject: [PATCH v2] configure: add option for virtiofsd
Date: Thu, 8 Oct 2020 19:31:33 +0900
Message-ID: <20201008103133.2722903-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Received-SPF: pass client-ip=211.128.242.42;
 envelope-from=misono.tomohiro@fujitsu.com; helo=mgwym03.jp.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 06:20:53
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently it is unknown whether virtiofsd will be built at
configuration time. It will be automatically built when dependency
is met. Also, required libraries are not clear.

To make this clear, add configure option --{enable,disable}-virtiofsd.
The default is the same as current (enabled if available) like many
other options. When --enable-virtiofsd is given and dependency is not
met, we get:

  ERROR: Problem encountered: virtiofsd requires libcap-ng-devel and seccomp-devel
or
  ERROR: Problem encountered: virtiofsd needs tools and vhost-user support

In addition, configuration summary now includes virtiofsd entry:

  build virtiofs daemon: YES/NO

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
This patch is based on current master branch

v1 ... https://lore.kernel.org/qemu-devel/20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com/
v1 -> v2: Update to follow the current meson build style

 configure         |  8 +++++++-
 meson.build       |  1 +
 meson_options.txt |  2 ++
 tools/meson.build | 17 +++++++++++++++--
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 28df227db5..2bd8419b1f 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ netmap="no"
 sdl="auto"
 sdl_image="auto"
 virtfs=""
+virtiofsd="auto"
 mpath="auto"
 vnc="enabled"
 sparse="auto"
@@ -1004,6 +1005,10 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
+  --disable-virtiofsd) virtiofsd="disabled"
+  ;;
+  --enable-virtiofsd) virtiofsd="enabled"
+  ;;
   --disable-mpath) mpath="disabled"
   ;;
   --enable-mpath) mpath="enabled"
@@ -1761,6 +1766,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  virtiofsd       build virtiofs daemon (virtiofsd)
   mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
   xen-pci-passthrough    PCI passthrough support for Xen
@@ -7215,7 +7221,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f -Dvirtiofsd=$virtiofsd \
 	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         $cross_arg \
         "$PWD" "$source_path"
diff --git a/meson.build b/meson.build
index 17c89c87c6..a087239009 100644
--- a/meson.build
+++ b/meson.build
@@ -1843,6 +1843,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
+summary_info += {'build virtiofs daemon': have_virtiofsd}
 summary_info += {'Multipath support': mpathpersist.found()}
 summary_info += {'VNC support':       vnc.found()}
 if vnc.found()
diff --git a/meson_options.txt b/meson_options.txt
index 1d3c94840a..80637ada63 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -48,6 +48,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
        description: 'SASL authentication for VNC server')
 option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
+option('virtiofsd', type: 'feature', value: 'auto',
+       description: 'build virtiofs daemon (virtiofsd)')
 
 option('capstone', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
diff --git a/tools/meson.build b/tools/meson.build
index 513bd2ff4f..76bf84df52 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -1,10 +1,23 @@
-have_virtiofsd = (have_system and
+have_virtiofsd = (targetos == 'linux' and
     have_tools and
-    'CONFIG_LINUX' in config_host and 
     'CONFIG_SECCOMP' in config_host and
     'CONFIG_LIBCAP_NG' in config_host and
     'CONFIG_VHOST_USER' in config_host)
 
+if get_option('virtiofsd').enabled()
+  if not have_virtiofsd
+    if targetos != 'linux'
+      error('virtiofsd requires Linux')
+    elif 'CONFIG_SECCOMP' not in config_host or 'CONFIG_LIBCAP_NG' not in config_host
+      error('virtiofsd requires libcap-ng-devel and seccomp-devel')
+    elif not have_tools or 'CONFIG_VHOST_USER' not in config_host
+      error('virtiofsd needs tools and vhost-user support')
+    endif
+  endif
+elif get_option('virtiofsd').disabled() or not have_system
+  have_virtiofsd = false
+endif
+
 if have_virtiofsd
   subdir('virtiofsd')
 endif
-- 
2.25.4


