Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418EAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E2C21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E2C21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKBv-0002Gm-ID
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK98-0000PL-R4; Sun, 18 Oct 2020 21:39:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK97-0008Lc-Bf; Sun, 18 Oct 2020 21:39:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id x13so5042572pfa.9;
 Sun, 18 Oct 2020 18:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pA3JS5ltTojVY03QZXz0vHL1bh6hAxmcWgrH//xXb7I=;
 b=NOLicvUSRGBZkjkYIV2vbsKQp1yIbzfG9hxi06piSWPhO2b/BLJiYc790ge5L21O8z
 +9ADpXCuH8glKCSILCaFH0umhiyA+dAX0lxrCW+PbdI3yO4Z4oUG6VRcBMJw75ytE+eM
 Zf3/NYKQqyrTsLGBEo26BUiyLJwBS45eCN/xBU4rSxBambyGe7r4gEIOmXterNOJw+yI
 6tvF6fc4qoPT2LOZ5O/0apRtoyCyV0DnquWk/FK7jN2OHFpoeiY0tsVkDK/UXI9yY6jM
 /EddPgqThF3v1TzHRjFowP0xT6WwnRE7CW8oUEQ9j3MUrobEHfNe/oiMP3numgBFvwd3
 OOJA==
X-Gm-Message-State: AOAM533AsguPvbzU0JlvAJFuxuVck+OlCV2Zz/FMFbAnkAblYyrlzCDB
 OeqM+k6kYVcJK1qZjx5NcZCFZG7nurc=
X-Google-Smtp-Source: ABdhPJxz11+6cVgKjxb/qpaveyGB84KeVJLGUCnxKN24G7rQi8JvX5YBN8k/iNlRqJfExgJN2b0Lyg==
X-Received: by 2002:a63:ff01:: with SMTP id k1mr12660590pgi.141.1603071571553; 
 Sun, 18 Oct 2020 18:39:31 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.115])
 by smtp.gmail.com with ESMTPSA id p8sm2446607pgs.34.2020.10.18.18.39.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 18:39:31 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] configure: option to disable host block devices
Date: Sun, 18 Oct 2020 18:39:20 -0700
Message-Id: <20201019013928.72770-2-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019013928.72770-1-j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.195;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 21:39:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

Some hosts (iOS) have a sandboxed filesystem and do not provide low-level
APIs for interfacing with host block devices.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure          | 4 ++++
 meson.build        | 1 +
 block/file-posix.c | 8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index b553288c5e..3c63879750 100755
--- a/configure
+++ b/configure
@@ -446,6 +446,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+host_block_device_support="yes"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -6098,6 +6099,9 @@ if test "$default_devices" = "yes" ; then
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
index 17c89c87c6..5d3a47784b 100644
--- a/meson.build
+++ b/meson.build
@@ -1947,6 +1947,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
 summary_info += {'qed support':       config_host.has_key('CONFIG_QED')}
 summary_info += {'parallels support': config_host.has_key('CONFIG_PARALLELS')}
 summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
+summary_info += {'host block dev support': config_host.has_key('CONFIG_HOST_BLOCK_DEVICE')}
 summary_info += {'capstone':          capstone_opt == 'disabled' ? false : capstone_opt}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
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
2.24.3 (Apple Git-128)


