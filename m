Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92033C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160312225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160312225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUNgc-0008Ez-UK
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 01:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaT-0003xg-2I; Mon, 19 Oct 2020 01:20:01 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaQ-0005Br-EU; Mon, 19 Oct 2020 01:19:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id gm14so4689946pjb.2;
 Sun, 18 Oct 2020 22:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BSAY3BBfuSoJgvkHbulnaO1HHfawNG7tKCA76XQhj5M=;
 b=LX5bpQd/urkf6xMesMriq5IDCED0uq7lstYPWVOzFVkYmSxXqIH97yKqknm5H8raUi
 kBSG/pB0+v4Yez+jFOakPTytiSmsleqxLRI3FmyRqttk9dRadeHs2ZoWGPkCLT97HNid
 E3TgeKiQeO1O5jqJcB/MqIjc39UkdZO9ncUsvQ4W4ye7amkGpPBQApBv2DyxI5vDi0Ua
 pm06bZePfFSnls+hQrmMkW7tqViavScPtQfDqWsnNyDLHZ2+fzbFdnR7aMfOWIlmm2hk
 PfJV+XDdYTEpk2KZXFpPAa+LKDkzA9VCfFUWCVhB5njtqoe7Mksrx+oe6pwCMGXrT2bc
 iHww==
X-Gm-Message-State: AOAM5332SZBeSpqgtzIWxO8uGR2liZJkRuBafOi26R8996LuwQh0AMmW
 sZDBHn5Mo+5VDh8Ac2+1C/Qi1LoMBHCbjQ==
X-Google-Smtp-Source: ABdhPJyoxevtk84Ss5+msxEqctQ8dHB1vV75RvEW0e3mDNDHgibWO4aIXqkJti5YaX2Xlj+PtWo+iA==
X-Received: by 2002:a17:90a:5d17:: with SMTP id
 s23mr16894747pji.170.1603084796735; 
 Sun, 18 Oct 2020 22:19:56 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.253])
 by smtp.gmail.com with ESMTPSA id p6sm10673904pjd.1.2020.10.18.22.19.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 22:19:56 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 1/9] configure: option to disable host block devices
Date: Sun, 18 Oct 2020 22:19:45 -0700
Message-Id: <20201019051953.90107-2-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019051953.90107-1-j@getutm.app>
References: <20201019051953.90107-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.65; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:19:57
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
index f498a37f9a..ea1753c117 100755
--- a/configure
+++ b/configure
@@ -447,6 +447,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+host_block_device_support="yes"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -5969,6 +5970,9 @@ if test "$default_devices" = "yes" ; then
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
index 2c6169fab0..75967914dc 100644
--- a/meson.build
+++ b/meson.build
@@ -2080,6 +2080,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
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


