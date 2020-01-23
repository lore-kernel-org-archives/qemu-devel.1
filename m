Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3316C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7855024655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7855024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXwl-0008IL-IX
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlW-0001PC-IW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlV-0003BT-3d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:02 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003An-Qd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:01 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MekrN-1jUhKH0B5Z-00apiu; Thu, 23 Jan 2020 09:22:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] linux-user: Add support for enabling/disabling RTC
 features using ioctls
Date: Thu, 23 Jan 2020 09:22:22 +0100
Message-Id: <20200123082227.2037994-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yMaEdQCad1FXyGHRpRa+gp1D7Uui/C8UVGYJSUGzDfxUAS98y45
 ujZTAmNxh/jHTNZZJG5vvpKdR9k/Nxvqd2Bx8E7HX8Qw5PLVj0xXz3VKCmknn9w3jaNE7n/
 4pa1+l04lasGinjmhBmJkfpp+YO7rgKZoG8ouiLek5+e2sb+obNP/t1HCqv5G60qPWHyDK9
 zFzdSpE9RMbPZqT574uhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ek035P64zII=:OjM9J4c4kGEQ9wMy/dK/gV
 ub23KNP6TYYC1KQCG93nTSlWyMDa+hASRusS0/egghSm7wavROUgS3h1IO9R2eoGpPSDFAuHf
 p5CQrpuR42oJr48y2s1FfTIMAGAejzrW4Hh8YfyzhqBx2SW/p8P/QcU60Oqffqn14jb/KTPi6
 sCxX6uKX4JQonDbduYFk83yWcKx3UpDTsWd47NpJwB1IDszVYKllMzmgtks2MGivVks3ZR6aM
 HakpTi6O5YoQPoF3hFNTGVlXFQ91ZCl7wWgjtHTxHGV5wwUvAohcZqS+hEflqhVxVVSS/oU3i
 fKKhu7aMwMP26EhassctD8KA/btw3p7M3CZf138xfJwxhy+cU/FHmQNV4LS7rMDUaOC8mF08F
 XrqfW8MBbwkIQNKnPYaomukn0m4ObJa9lqpSH0GK+IhuKre9UAhYw+DMYw8LJ4LzWv9P+dVQq
 TGMAVPYY+LJLmekq/R+VZ+UWefnveVIavRGd/X7qW9l8NTP0kQYqXNi5ROEzn8GJP8QuYY8ql
 u6EVdsCjdBEXiGG055Y5X31UsIAu5FKNQnhf872Q4Y9gM9BhNp+jncUFQqZMR+6IXjWkFW556
 ul0CuC2TGDdO9DYL86seFevpro571FqUUSD1nghIxRPHVFWnpbWFf1S9hGyOrGP++9DfLvsbN
 JAfXRwl7I4KEjm/H/RkvYKMrp50TnNJhBb/G31JJMQ3WkFNwZitdSa9P7meZGpcstCfg1SGVS
 hzaI4Y7XWdd7ZkUxkA1LTwgJJn/o8sgrznGGYi7cGs8N3ZLqkVv0ljnrmyBr5KXxE+vELPnwK
 6/TkbbjpKdesk5s8wBbnEI7UaWZ0FxCaO5tVmZQ+alI9AxSTcaazJpFOhuJQxdpNp4n+6g6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch implements functionalities of following ioctls:

RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enabling on/off

    Enable or disable the alarm interrupt, for RTCs that support
    alarms.  The third ioctl's argument is ignored.

RTC_UIE_ON, RTC_UIE_OFF - Update interrupt enabling on/off

    Enable or disable the interrupt on every clock update, for
    RTCs that support this once-per-second interrupt. The third
    ioctl's argument is ignored.

RTC_PIE_ON, RTC_PIE_OFF - Periodic interrupt enabling on/off

    Enable or disable the periodic interrupt, for RTCs that sup‐
    port these periodic interrupts. The third ioctl's argument
    is ignored. Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can enable the periodic interrupt
    if the frequency is currently set above the value specified in
    /proc/sys/dev/rtc/max-user-freq.

RTC_WIE_ON, RTC_WIE_OFF - Watchdog interrupt enabling on/off

    Enable or disable the Watchdog interrupt, for RTCs that sup-
    port this Watchdog interrupt. The third ioctl's argument is
    ignored.

Implementation notes:

    Since all of involved ioctls have NULL as their third argument,
    their implementation was straightforward.

    The line '#include <linux/rtc.h>' was added to recognize
    preprocessor definitions for these ioctls. This needs to be
    done only once in this series of commits. Also, the content
    of this file (with respect to ioctl definitions) remained
    unchanged for a long time, therefore there is no need to
    worry about supporting older Linux kernel version.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-2-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       |  9 +++++++++
 linux-user/syscall.c      |  1 +
 linux-user/syscall_defs.h | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 23f6d3feb5db..55ad47186dc0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -69,6 +69,15 @@
      IOCTL(KDSETLED, 0, TYPE_INT)
      IOCTL_SPECIAL(KDSIGACCEPT, 0, do_ioctl_kdsigaccept, TYPE_INT)
 
+     IOCTL(RTC_AIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_AIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_UIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_UIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_PIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
+
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(BLKRRPART, 0, TYPE_NULL)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bd2436b31007..d60142f0691c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -110,6 +110,7 @@
 #include <netpacket/packet.h>
 #include <linux/netlink.h>
 #include <linux/if_alg.h>
+#include <linux/rtc.h>
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fb8318d12185..fc3d79ab9762 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -763,6 +763,16 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
+/* real time clock ioctls */
+#define TARGET_RTC_AIE_ON           TARGET_IO('p', 0x01)
+#define TARGET_RTC_AIE_OFF          TARGET_IO('p', 0x02)
+#define TARGET_RTC_UIE_ON           TARGET_IO('p', 0x03)
+#define TARGET_RTC_UIE_OFF          TARGET_IO('p', 0x04)
+#define TARGET_RTC_PIE_ON           TARGET_IO('p', 0x05)
+#define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
+#define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
+#define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
+
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
 #define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
-- 
2.24.1


