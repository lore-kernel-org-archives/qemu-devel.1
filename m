Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD5C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033D220801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033D220801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i8A-0000DD-6D
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1g-0004M3-Fb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1f-0008EN-7z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:44 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1e-0008DV-Ob
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:43 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEVqu-1jFCQ40vDm-00G1LU; Thu, 20 Feb 2020 10:21:06 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] linux-user: Add support for selected alsa timer
 instructions using ioctls
Date: Thu, 20 Feb 2020 10:20:53 +0100
Message-Id: <20200220092053.1510215-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JvK0QtNJZ9KpkuooMB2cdSBLneSIiuwLh8Ash4Di14Y9wtSAnry
 G0Feg9JcNA3ojyXn6GoQ2q1Nt4mGNLt9Xbq/ru3Z3kB0arlQGHsbaaKkZsRiRlaTWoXqH4w
 eaghHI6fuXWW4TM8nPz+23igwPmVHUFDhSWL5EU2GgTZeq+QGyXgGFLKcf5TG//bPsX2QQ6
 TzVpF1Hlp4z6jaLM6X2Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QJWI2yYaMxM=:jxDy3dfsAHLnQa+BgKSvHp
 VI4CmMNnQTnsiUxqB+mkILEOyWYQ9Nws9B9MF8Ii33gGDn5Pqn4ql43oMDYCnrc+10YIjrJ3p
 Toc6zTRj/jn9yDSnRvrlX0VhSBF/e6An1WjHkNt2vVez7QhQW1UX7q8OKx7qDbFTX/sY9uOGN
 SCmq1HREolbkCRoOwW15CmZqk07airUZEzn7NIpkPeGxCV/ZDmLWjrgKGSsIL9Xo7ixfMwNN/
 BhJ8m8dljFclKUX6CRZVHVjCPaoIhhJxoChIGmJ8+gqCIeejlqBLSdeVdC9F1m8FXs2mmQWW1
 4ahj8oe2elaA5wfpYwiI/mS7uBrg7R33tLef6vsBj4imnc7CNvjMDdURXRzGrvIiInlPqywVO
 RWTWicSDBMTrb9JJ95kdNqUYGmMjKteHloR7j2x7hiP1rStAg0uIHYygflNStnAdcjTfc7+17
 uJzAdy7fiINIh1tlaaJjTAbzltj+LmPYkKh382gkhepQlTlOtpyZsakxiv2tU6WJWY7q2gZ9A
 kOak51uvPO7YcjiAR6TMNaMd1wR0RwuRzzyTVK03DnQ1wJgfiDuhwyenNgBL1xJXo4f4Clpxi
 Bb3opcIfecPvxPFEYBtaUnRnKl+lDsWwD3vfoPLw5A1XfbrY/3PVnkzth00PhViWeBTUITp6+
 6GgEnLX/Vfq6px6sue46x0RKB3DAuOXaw5bC+5wk9ccrLbnFEiH6HpmKFuxWexfnmsZvbiUDl
 UQ3znYNGicIKp1W+YW/F5O4PyaU4+nc9rAsD2JaIiSgoAWeSwA7bavhmfVU1IFSc9dgV64Ku1
 S9lPOwAEC1dxoQ5xLyrauYMX0AxwvMlTKYY2nmE1KPergi6rve9rg2GxYawa8VqZTtMTyXq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
 Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch implements functionalities of following ioctls:

SNDRV_TIMER_IOCTL_START - Start selected alsa timer

    Starts the timer device that is selected. The third ioctl's argument is
    ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
    should be called first to select the timer that is to be started. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape")
    is returned.

SNDRV_TIMER_IOCTL_STOP - Stop selected alsa timer

    Stops the timer device that is selected. The third ioctl's argument is
    ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
    should be called first to select the timer that is to be stopped. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape")
    is returned.

SNDRV_TIMER_IOCTL_CONTINUE - Continue selected alsa timer

    Continues the timer device that is selected. The third ioctl's argument is
    ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
    should be called first to select the timer that is to be continued. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape")
    is returned.

SNDRV_TIMER_IOCTL_PAUSE - Pause selected alsa timer

    Pauses the timer device that is selected. The third ioctl's argument is
    ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
    should be called first to select the timer that is to be paused. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape")
    is returned.

Implementation notes:

    Since all of the implemented ioctls have NULL as their third argument,
    their implementation was straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-13-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 4 ++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index de6948796367..0defa1d8c18d 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -477,6 +477,10 @@
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_params)))
   IOCTL(SNDRV_TIMER_IOCTL_STATUS, IOC_R,
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_status)))
+  IOCTL(SNDRV_TIMER_IOCTL_START, 0, TYPE_NULL)
+  IOCTL(SNDRV_TIMER_IOCTL_STOP, 0, TYPE_NULL)
+  IOCTL(SNDRV_TIMER_IOCTL_CONTINUE, 0, TYPE_NULL)
+  IOCTL(SNDRV_TIMER_IOCTL_PAUSE, 0, TYPE_NULL)
 
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cf34129fc3ac..152ec637cba6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2516,6 +2516,10 @@ struct target_snd_timer_status {
                                                 struct snd_timer_params)
 #define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,            \
                                                 struct target_snd_timer_status)
+#define TARGET_SNDRV_TIMER_IOCTL_START        TARGET_IO('T', 0xa0)
+#define TARGET_SNDRV_TIMER_IOCTL_STOP         TARGET_IO('T', 0xa1)
+#define TARGET_SNDRV_TIMER_IOCTL_CONTINUE     TARGET_IO('T', 0xa2)
+#define TARGET_SNDRV_TIMER_IOCTL_PAUSE        TARGET_IO('T', 0xa3)
 
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
-- 
2.24.1


