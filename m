Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB431C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C7820897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C7820897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdFF-0003CX-8a
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDR-0001QS-Ig; Sun, 08 Nov 2020 00:26:13 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDP-0004tw-Cz; Sun, 08 Nov 2020 00:26:13 -0500
Received: by mail-pj1-f66.google.com with SMTP id ie6so1528686pjb.0;
 Sat, 07 Nov 2020 21:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bscmMwY4Zssj6aPfsBCqE7bxrqB1fahSzU0ekRzQJRo=;
 b=WVirQvv6y0dlSvrtqFavtH+QYFAlMZ7VfkCSPXj9KDKWKlGLJVSNq200IOf6l9LBQn
 zQ4si2wPwcVTTeIYZ1EdXtvo5zizkZmcX5FAY3NV8Ne3UfDle4XAvbmR5cEhBWCxsQ45
 qWK9OE/QSbldkittuv/fCKzpFlqhC5Wf1pYkddzv4J7xjAHSWho8fZhn7x24PrQvOlbN
 2rAC4SGQRbM9quDNCqt/oZRU52cDXYxl9HA3gq7tyjUh9UENMzlAW6lPDmwkHyiq74X8
 ajsJeXw1S60OaezH4e6Lh0p0Fg27zHsh+LMDOWW4I5csnUFu1aTAWmyziln4wKPvTwlT
 WVlw==
X-Gm-Message-State: AOAM530CNUa5JhqI63CebZ8lZDJf5TXSh/7kxB6A1JOqsy7SH9wcJNox
 6leKxS9JkxPD7sXO6KdK3Ao77fIeQ3E=
X-Google-Smtp-Source: ABdhPJxXtn5fcQ/8A5Z4Eaulp0E6SRZZgmFu3/L7WZdVDJmD81ucbIfB+JiXe8p7ynW7Vmh1tY74Jg==
X-Received: by 2002:a17:90a:aa89:: with SMTP id l9mr6790299pjq.0.1604813169226; 
 Sat, 07 Nov 2020 21:26:09 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:08 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/7] configure: option to disable host block devices
Date: Sat,  7 Nov 2020 21:25:59 -0800
Message-Id: <20201108052605.45840-2-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.66; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:raw" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some hosts (iOS) have a sandboxed filesystem and do not provide low-level
APIs for interfacing with host block devices.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure            | 4 ++++
 meson.build          | 1 +
 qapi/block-core.json | 4 +++-
 block/file-posix.c   | 8 +++++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 2c3c69f118..97a879808d 100755
--- a/configure
+++ b/configure
@@ -448,6 +448,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+host_block_device_support="yes"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -5907,6 +5908,9 @@ if test "$default_devices" = "yes" ; then
 else
   echo "CONFIG_MINIKCONF_MODE=--allnoconfig" >> $config_host_mak
 fi
+if test "$host_block_device_support" = "yes" ; then
+  echo "CONFIG_HOST_BLOCK_DEVICE=y" >> $config_host_mak
+fi
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 39ac5cf6d8..fd822346e7 100644
--- a/meson.build
+++ b/meson.build
@@ -2166,6 +2166,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
 summary_info += {'qed support':       config_host.has_key('CONFIG_QED')}
 summary_info += {'parallels support': config_host.has_key('CONFIG_PARALLELS')}
 summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
+summary_info += {'host block dev support': config_host.has_key('CONFIG_HOST_BLOCK_DEVICE')}
 summary_info += {'capstone':          capstone_opt == 'disabled' ? false : capstone_opt}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1b8b4156b4..ddcb61b8e8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2848,7 +2848,9 @@
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
             'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
-            'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
+            'gluster', 'host_cdrom',
+            {'name': 'host_device', 'if': 'defined(CONFIG_HOST_BLOCK_DEVICE)' },
+            'http', 'https', 'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
             'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
diff --git a/block/file-posix.c b/block/file-posix.c
index c63926d592..52f7c20525 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -41,7 +41,7 @@
 #include "scsi/pr-manager.h"
 #include "scsi/constants.h"
 
-#if defined(__APPLE__) && (__MACH__)
+#if defined(CONFIG_HOST_BLOCK_DEVICE) && defined(__APPLE__) && (__MACH__)
 #include <paths.h>
 #include <sys/param.h>
 #include <IOKit/IOKitLib.h>
@@ -3247,6 +3247,8 @@ BlockDriver bdrv_file = {
 /***********************************************/
 /* host device */
 
+#if defined(CONFIG_HOST_BLOCK_DEVICE)
+
 #if defined(__APPLE__) && defined(__MACH__)
 static kern_return_t GetBSDPath(io_iterator_t mediaIterator, char *bsdPath,
                                 CFIndex maxPathSize, int flags);
@@ -3872,6 +3874,8 @@ static BlockDriver bdrv_host_cdrom = {
 };
 #endif /* __FreeBSD__ */
 
+#endif /* CONFIG_HOST_BLOCK_DEVICE */
+
 static void bdrv_file_init(void)
 {
     /*
@@ -3879,6 +3883,7 @@ static void bdrv_file_init(void)
      * registered last will get probed first.
      */
     bdrv_register(&bdrv_file);
+#if defined(CONFIG_HOST_BLOCK_DEVICE)
     bdrv_register(&bdrv_host_device);
 #ifdef __linux__
     bdrv_register(&bdrv_host_cdrom);
@@ -3886,6 +3891,7 @@ static void bdrv_file_init(void)
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
     bdrv_register(&bdrv_host_cdrom);
 #endif
+#endif /* CONFIG_HOST_BLOCK_DEVICE */
 }
 
 block_init(bdrv_file_init);
-- 
2.28.0


