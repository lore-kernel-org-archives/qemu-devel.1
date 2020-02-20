Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05DFC11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A7820801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A7820801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i4F-0000WJ-Oz
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1c-0004H3-RQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1b-0008CK-Al
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:38279)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1b-0008Bk-0r
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:39 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9WBG-1j81PJ2DOW-005cH8; Thu, 20 Feb 2020 10:21:05 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] linux-user: Add support for getting/setting selected
 alsa timer parameters using ioctls
Date: Thu, 20 Feb 2020 10:20:52 +0100
Message-Id: <20200220092053.1510215-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YC7Edye/1tSifxL9BebyDM5r4Z+nReCzXjFzOuWf1X4JVxXv/Ni
 JvEc7FwZidhGlM0tb/25QTl9ZczfZNkXAfVyOw7IZCdzzxyv1W0wl2WCePTCYr6OWtGxJLj
 McEeSG744FvGdqPYCRG10qzaFLQt8bJju5WmHhYksMTs3MT0UccnLYEtRIdYbY6xh3mtcTn
 D9xvlfKpKPGDv4JfwMzrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/nfo+gjX2o=:Np9yU4Upovr5odYO5fXnKt
 JJJ5XTMNIJHq1AUFeX+0J90iUpXC/4z93k++u0M/ocqysQJYOmrgefpHaueqMMZepXwcJmKRI
 DpXqvgKWfpKXU3m0Oc4HH/9/N/E2ZcwY2kC1kAcLC7PE9rGAk+vLK9TonXF/cZf69xrCzUHfo
 6jdrOv80SNac++fiqXXDly+cT+RHWDtuilRWqgdYwwx+pzlcCzHcFDBIBbcK94Mx2WxGPlDMs
 mf5L9GX47mMiVwMOtafveDKxlYBmgw5hcl3IyXWxYlaMrcVwjIiqvtESMzgGuw04UDagFzDGO
 yUVtfbc+gTeCmhusfo590YBAsBsGA6BTcB373H57Nm1qXz1lt0i3uY5kXroiUpe55FsOEBcBG
 yqG2bdbROiGVtmFUzMF3tjTmGJuXSIE5O5+9RWrPjcLg6qNukMtDS41QNI/c6iqBGnWCPPNaf
 92EMkSZqTwyGOs0I68KESaG5R5lu+Ie1Y33B3IHBMl6K+pKizv332Ocna20VRvALR/uXENxhs
 BdTiyBDWRmBwSZKm1oaLRavmuhBrt2gJvWiantdR+Eh4Fay410b75GscmMi5jGPcFhGpfUqrx
 50zhphjkeOg66YJVcprkIFNVqvJnT0uhLcsPyUNeh/1kdY/UjQCGuNtEpmYi9dI9etT8gruFR
 xs0P+L3GqZiDghFUbx2/b5DNp8VldLQXnslItz6UqNkF7XuRIQ8nYozc1aF1z5V1ijZAUYoRP
 lYqyfogk2Km4EZmyDK5s7fIGqH0UCmW+Jo35pvqYa+mXqJL0W4UoeE3UO5A6t9xfiLsGy1Eyu
 GZyQpuQdPmlIUfGrLiaR3mmZqk3mYTgySjlZPJVCSsL934L9GsCarX5H/PBmcVM5FKJnG0O
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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

SNDRV_TIMER_IOCTL_INFO - Getting information about selected timer

    Read information about the selected timer. The information is returned in
    the following structure:

    struct snd_timer_info {
        unsigned int flags;         /* timer flags - SNDRV_TIMER_FLG_* */
        int card;                   /* card number */
        unsigned char id[64];       /* timer identificator */
        unsigned char name[80];     /* timer name */
        unsigned long reserved0;    /* reserved for future use */
        unsigned long resolution;   /* average period resolution in ns */
        unsigned char reserved[64]; /* reserved for future use */
    };

    A pointer to this structure should be passed as the third ioctl's argument.
    Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
    called first to select the timer which information is to be obtained. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape") is
    returned.

SNDRV_TIMER_IOCTL_PARAMS - Setting parameters for selected timer

    Sets parameters for the selected timer. The paramaters are set in the
    following structure:

    struct snd_timer_params {
        unsigned int flags;         /* flags - SNDRV_TIMER_PSFLG_* */
        unsigned int ticks;         /* requested resolution in ticks */
        unsigned int queue_size;    /* total size of queue (32-1024) */
        unsigned int reserved0;     /* reserved, was: failure locations */
        unsigned int filter;        /* event filter */
        unsigned char reserved[60]; /* reserved */
    };

    A pointer to this structure should be passed as the third ioctl's argument.
    Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
    called first to select the timer which parameters are to be set. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape") is
    returned.

SNDRV_TIMER_IOCTL_STATUS - Getting status of selected timer

    Read status of the selected timer. The status of the timer is returned in
    the following structure:

    struct snd_timer_status {
        struct timespec tstamp;     /* Timestamp - last update */
        unsigned int resolution;    /* current period resolution in ns */
        unsigned int lost;          /* counter of master tick lost */
        unsigned int overrun;       /* count of read queue overruns */
        unsigned int queue;         /* used queue size */
        unsigned char reserved[64]; /* reserved */
    };

    A pointer to this structure should be passed as the third ioctl's argument.
    Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
    called first to select the timer which status is to be obtained. If no
    timer is selected, the error EBADFD ("File descriptor in bad shape") is
    returned.

Implementation notes:

    All ioctls in this patch have pointer to some kind of a structure
    as their third argument. That is the reason why corresponding
    definitions were added in 'linux-user/syscall_types.h'. Structure
    'snd_timer_status' has field of type 'struct timespec' which is why
    a corresponding definition of that structure was also added in
    'linux-user/syscall_types.h'. All of these strucutures have some
    fields that are of type 'unsigned long'. That is the reason why
    separate target structures were defined in 'linux-user/syscall_defs.h'.
    Structure 'struct timespec' already had a separate target definition
    so that definition was used to define a target structure for
    'snd_timer_status'. The rest of the implementation was straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-12-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  5 +++++
 linux-user/syscall_defs.h  | 25 +++++++++++++++++++++++++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 8313af3672c6..de6948796367 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -472,6 +472,11 @@
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_gstatus)))
   IOCTL(SNDRV_TIMER_IOCTL_SELECT, IOC_W,
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_select)))
+  IOCTL(SNDRV_TIMER_IOCTL_INFO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_snd_timer_info)))
+  IOCTL(SNDRV_TIMER_IOCTL_PARAMS, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_snd_timer_params)))
+  IOCTL(SNDRV_TIMER_IOCTL_STATUS, IOC_R,
+        MK_PTR(MK_STRUCT(STRUCT_snd_timer_status)))
 
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cac9228a37d0..cf34129fc3ac 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2479,6 +2479,25 @@ struct target_snd_timer_select {
     unsigned char reserved[32];
 };
 
+struct target_snd_timer_info {
+    unsigned int flags;
+    int card;
+    unsigned char id[64];
+    unsigned char name[80];
+    abi_ulong reserved0;
+    abi_ulong resolution;
+    unsigned char reserved[64];
+};
+
+struct target_snd_timer_status {
+    struct target_timespec tstamp;
+    unsigned int resolution;
+    unsigned int lost;
+    unsigned int overrun;
+    unsigned int queue;
+    unsigned char reserved[64];
+};
+
 /* alsa timer ioctls */
 #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
 #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,           \
@@ -2491,6 +2510,12 @@ struct target_snd_timer_select {
                                                 struct target_snd_timer_gstatus)
 #define TARGET_SNDRV_TIMER_IOCTL_SELECT       TARGET_IOW('T', 0x10,            \
                                                 struct target_snd_timer_select)
+#define TARGET_SNDRV_TIMER_IOCTL_INFO         TARGET_IOR('T', 0x11,            \
+                                                struct target_snd_timer_info)
+#define TARGET_SNDRV_TIMER_IOCTL_PARAMS       TARGET_IOW('T', 0x12,            \
+                                                struct snd_timer_params)
+#define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,            \
+                                                struct target_snd_timer_status)
 
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 81bc71938241..4e12c1661ea6 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -120,6 +120,35 @@ STRUCT(snd_timer_select,
        MK_STRUCT(STRUCT_snd_timer_id), /* id */
        MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
 
+STRUCT(snd_timer_info,
+       TYPE_INT, /* flags */
+       TYPE_INT, /* card */
+       MK_ARRAY(TYPE_CHAR, 64), /* id */
+       MK_ARRAY(TYPE_CHAR, 80), /* name */
+       TYPE_ULONG, /* reserved0 */
+       TYPE_ULONG, /* resolution */
+       MK_ARRAY(TYPE_CHAR, 64)) /* reserved */
+
+STRUCT(snd_timer_params,
+       TYPE_INT, /* flags */
+       TYPE_INT, /* ticks */
+       TYPE_INT, /* queue_size */
+       TYPE_INT, /* reserved0 */
+       TYPE_INT, /* filter */
+       MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
+
+STRUCT(timespec,
+       TYPE_LONG, /* tv_sec */
+       TYPE_LONG) /* tv_nsec */
+
+STRUCT(snd_timer_status,
+       MK_STRUCT(STRUCT_timespec), /* tstamp */
+       TYPE_INT, /* resolution */
+       TYPE_INT, /* lost */
+       TYPE_INT, /* overrun */
+       TYPE_INT, /* queue */
+       MK_ARRAY(TYPE_CHAR, 64)) /* reserved */
+
 /* loop device ioctls */
 STRUCT(loop_info,
        TYPE_INT,                 /* lo_number */
-- 
2.24.1


