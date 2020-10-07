Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CAC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B6520870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B6520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5bO-00041s-0Q
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQ5ap-0003cb-4M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:18:39 -0400
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:24411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQ5am-0006rj-Kf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:18:38 -0400
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 723c_79c3_00477b8b_16cf_40cb_bdfe_da28139454f4;
 Wed, 07 Oct 2020 18:18:27 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 969ABAC00B5
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 18:18:26 +0900 (JST)
Received: from G01JPEXCHYT14.g01.fujitsu.local
 (G01JPEXCHYT14.g01.fujitsu.local [10.128.194.53])
 by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id C1AB946E7B2;
 Wed,  7 Oct 2020 18:18:25 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT14.g01.fujitsu.local (10.128.194.53) with Microsoft SMTP Server id
 14.3.487.0; Wed, 7 Oct 2020 18:18:25 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <qemu-devel@nongnu.org>, <virtio-fs@redhat.com>
Subject: [PATCH] configure: add option for virtiofsd
Date: Wed, 7 Oct 2020 18:29:13 +0900
Message-ID: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Received-SPF: pass client-ip=202.219.69.169;
 envelope-from=misono.tomohiro@fujitsu.com; helo=mgwkm02.jp.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 05:18:29
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

  ERROR: virtiofsd requires libcap-ng devel, seccomp devel, vhost user and tools support

In addition, configuration summary now includes virtiofsd entry:

  build virtiofs daemon: YES/NO

Sidenote: this patch defines CONFIG_VIRTIOFSD for config-host.mak
to avoid duplicate dependency check in tools/meson.build.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 configure         | 22 ++++++++++++++++++++++
 docs/meson.build  |  2 +-
 meson.build       |  1 +
 tools/meson.build |  9 +--------
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index ecc8e90e8b..9d76e73014 100755
--- a/configure
+++ b/configure
@@ -403,6 +403,7 @@ netmap="no"
 sdl="auto"
 sdl_image="auto"
 virtfs=""
+virtiofsd=""
 mpath=""
 vnc="enabled"
 sparse="no"
@@ -1117,6 +1118,10 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
+  --disable-virtiofsd) virtiofsd="no"
+  ;;
+  --enable-virtiofsd) virtiofsd="yes"
+  ;;
   --disable-mpath) mpath="no"
   ;;
   --enable-mpath) mpath="yes"
@@ -1873,6 +1878,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  virtiofsd       build virtiofs daemon (virtiofsd)
   mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
   xen-pci-passthrough    PCI passthrough support for Xen
@@ -6344,6 +6350,15 @@ if test "$softmmu" = yes ; then
       fi
       virtfs=no
     fi
+    if test "$virtiofsd" != no && test "$cap_ng" = yes && test "$seccomp" = yes \
+         && test "$vhost_user" = yes && test "$want_tools" = yes; then
+      virtiofsd=yes
+    else
+      if test "$virtiofsd" = yes; then
+        error_exit "virtiofsd requires libcap-ng devel, seccomp devel, vhost user and tools support"
+      fi
+      virtiofsd=no
+    fi
     if test "$mpath" != no && test "$mpathpersist" = yes ; then
       mpath=yes
     else
@@ -6357,6 +6372,10 @@ if test "$softmmu" = yes ; then
       error_exit "VirtFS is supported only on Linux"
     fi
     virtfs=no
+    if test "$virtiofsd" = yes; then
+      error_exit "virtiofsd is supported only on Linux"
+    fi
+    virtiofsd=no
     if test "$mpath" = yes; then
       error_exit "Multipath is supported only on Linux"
     fi
@@ -6901,6 +6920,9 @@ fi
 if test "$virtfs" = "yes" ; then
   echo "CONFIG_VIRTFS=y" >> $config_host_mak
 fi
+if test "$virtiofsd" = "yes" ; then
+  echo "CONFIG_VIRTIOFSD=y" >> $config_host_mak
+fi
 if test "$mpath" = "yes" ; then
   echo "CONFIG_MPATH=y" >> $config_host_mak
   if test "$mpathpersist_new_api" = "yes"; then
diff --git a/docs/meson.build b/docs/meson.build
index 0340d489ac..6b9b277ef7 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -15,7 +15,7 @@ if build_docs
         'qemu-nbd.8': (have_tools ? 'man8' : ''),
         'qemu-trace-stap.1': (config_host.has_key('CONFIG_TRACE_SYSTEMTAP') ? 'man1' : ''),
         'virtfs-proxy-helper.1': (have_virtfs_proxy_helper ? 'man1' : ''),
-        'virtiofsd.1': (have_virtiofsd ? 'man1' : ''),
+        'virtiofsd.1': (config_host.has_key('CONFIG_VIRTIOFSD') ? 'man1' : ''),
     },
     'system': {
         'qemu.1': 'man1',
diff --git a/meson.build b/meson.build
index 5b586afc38..a4ea961272 100644
--- a/meson.build
+++ b/meson.build
@@ -1336,6 +1336,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
+summary_info += {'build virtiofs daemon': config_host.has_key('CONFIG_VIRTIOFSD')}
 summary_info += {'Multipath support': config_host.has_key('CONFIG_MPATH')}
 summary_info += {'VNC support':       vnc.found()}
 if vnc.found()
diff --git a/tools/meson.build b/tools/meson.build
index 513bd2ff4f..f1241982d6 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -1,10 +1,3 @@
-have_virtiofsd = (have_system and
-    have_tools and
-    'CONFIG_LINUX' in config_host and 
-    'CONFIG_SECCOMP' in config_host and
-    'CONFIG_LIBCAP_NG' in config_host and
-    'CONFIG_VHOST_USER' in config_host)
-
-if have_virtiofsd
+if 'CONFIG_VIRTIOFSD' in config_host
   subdir('virtiofsd')
 endif
-- 
2.25.4


