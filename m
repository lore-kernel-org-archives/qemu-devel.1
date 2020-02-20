Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBCCC11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B712465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B712465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i2g-0005p1-Dc
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1Y-0004Am-NJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1X-00089d-7a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:36 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1W-00088z-VF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:35 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MulVd-1jM6Au2Cdn-00rowL; Thu, 20 Feb 2020 10:21:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] linux-user: Add support for getting alsa timer version
 and id
Date: Thu, 20 Feb 2020 10:20:49 +0100
Message-Id: <20200220092053.1510215-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VktzNMEVk9unQhdlGz6zUqy6vDEkqd15Fku5KPo/cKBbzRZkcBO
 Ya4dzWwBBzO995cnyaY/Pxe+mnI+fWyIRoGol+XwymOvy6eHaR6qo1Lad0cYtA+kDdf38G+
 DaSwe2FktVGu0bUXQH3SrjCddkRt1tuOG0kTFaXjH4sVqM8qwrMZ+qYh7SU94f3o3u/vwtS
 /m9EJy50rMTSDycz6MA/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JPYZZbwfSfE=:QHU43bNIHsGoluuF5/Lj0O
 VfCMIt/6PrmQSuNSBJLPyi5T8KE+HLRUA886IJpcyuBektw5wkCNUZbx+Ucs3Lvbuq+sx2qyi
 BBQM0Sygmah27zBTFuOZsCRnh38O1HmZEAyvdakB/zqN6onjlg8s5Jxb3tPW8yo2FQlkSYYhd
 jMfUWbboCCSV3ORJA8pkOINQOFK+UhgsQsAtpo6gHN0HOR0XDxEVtZjSQoHf/njwlYS0RPjlc
 2MkA9SGtJ8toY1CyNVMo/yxyJg2mXSz2jhArBt0yHy0tkM7zeNbIcw3nLC5Z7sGHjTooq2H2m
 Xf3mYCoxHCGuF/cQrIjHaBo1S4iMQa68kis2wW57tAQPh1OHSPJUVhIWL00yaXs1WJngb9+zX
 VbWScimHcYZ61bSqOgCyYx2Fbw59dTlqmS68BLqkHIJyPPhcsoMBDH+bzChfU8fWyjG4g/Sl0
 N3ftChEbDjzYempu24duLvDZRprrqWIaqhPi2QD5WUiU5W7tQy7OltSgU4xXUhXEqtEXmaXbL
 NsUpH6duSZUDKyuixNxNCpAvcOJ9170Mc78X6SvSD5B9AoBNLgcvjWCDXFKqgXaOLx4xAd++8
 3NYaYktgslewihgDek/AzKGOQ2joif5rHqqih6kJ6AMW2ThR4RqK6RiHRz2xZQDq4ezkEC2nr
 zyjjMk/Vis0RZsNsLP+Wd/V80jxfaOGVrYDwQOovagY72RHJ8I7X/oqR5Dw4f4wyNI5HBLOGz
 9HsCvfNA/aYPuEBeZ6Mxo5YYYPQnBenGlQtPjtTnIvusXgeiAxhafD7uZXrml9qs35xYNBrPP
 FhTiLBl32S82e8aMSjnxlCJirFobDQu9srvkaoLh90ZjvZlDjBsT4+qJ8+VUZPMH3pbI4Cj
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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

SNDRV_TIMER_IOCTL_PVERSION - Getting the sound timer version

    Read the sound timer version. The third ioctl's argument is
    a pointer to an int in which the specified timers version
    is returned.

SNDRV_TIMER_IOCTL_NEXT_DEVICE - Getting id information about next timer

    Read id information about the next timer device from the sound timer
    device list. The id infomration is returned in the following structure:

        struct snd_timer_id {
            int dev_class;    /* timer device class number */
            int dev_sclass;   /* slave device class number (unused) */
            int card;         /* card number */
            int device;       /* device number */
            int subdevice;    /* sub-device number */
        };

    The devices in the sound timer device list are arranged by the fields
    of this structure respectively (first by dev_class number, then by
    card number, ...). A pointer to this structure should be passed as
    the third ioctl's argument. Before calling the ioctl, the parameters
    of this structure should be initialized in relation to the next timer
    device which information is to be obtained. For example, if a wanted
    timer device has the device class number equal to or bigger then 2,
    the field dev_class should be initialized to 2. After the ioctl call,
    the structure fields are filled with values from the next device in
    the sound timer device list. If there is no next device in the list,
    the structure is filled with "zero" id values (in that case all
    fields are filled with value -1).

Implementation notes:

    The ioctl 'SNDRV_TIMER_IOCTL_NEXT_DEVICE' has a pointer to a
    'struct snd_timer_id' as its third argument. That is the reason why
    corresponding definition is added in 'linux-user/syscall_types.h'.
    Since all elements of this structure are of type 'int', the rest of
    the implementation was straightforward.

    The line '#include <linux/rtc.h>' was added to recognize
    preprocessor definitions for these ioctls. This needs to be
    done only once in this series of commits. Also, the content
    of this file (with respect to ioctl definitions) remained
    unchanged for a long time, therefore there is no need to
    worry about supporting older Linux kernel version.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-8-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 4 ++++
 linux-user/syscall.c       | 1 +
 linux-user/syscall_defs.h  | 5 +++++
 linux-user/syscall_types.h | 7 +++++++
 4 files changed, 17 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 73dcc761e642..950e99617dcc 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -461,6 +461,10 @@
   IOCTL(SOUND_MIXER_WRITE_LOUD, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(SOUND_MIXER_WRITE_RECSRC, IOC_W, MK_PTR(TYPE_INT))
 
+  IOCTL(SNDRV_TIMER_IOCTL_PVERSION, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(SNDRV_TIMER_IOCTL_NEXT_DEVICE, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_snd_timer_id)))
+
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_MULTCOUNT, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 274e10e0ee6b..8d27d1080752 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -111,6 +111,7 @@
 #include <linux/netlink.h>
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
+#include <sound/asound.h>
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9b61ae8547dd..eb00358b5437 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2437,6 +2437,11 @@ struct target_statfs64 {
 
 #define TARGET_SOUND_MIXER_WRITE_RECSRC	TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
 
+/* alsa timer ioctls */
+#define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
+#define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,           \
+                                                struct snd_timer_id)
+
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
 #define TARGET_VFAT_IOCTL_READDIR_SHORT   TARGET_IORU('r', 2)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 5ba4155047ba..4c3a65cfc030 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -83,6 +83,13 @@ STRUCT(buffmem_desc,
 STRUCT(mixer_info,
        MK_ARRAY(TYPE_CHAR, 16), MK_ARRAY(TYPE_CHAR, 32), TYPE_INT, MK_ARRAY(TYPE_INT, 10))
 
+STRUCT(snd_timer_id,
+       TYPE_INT, /* dev_class */
+       TYPE_INT, /* dev_sclass */
+       TYPE_INT, /* card */
+       TYPE_INT, /* device */
+       TYPE_INT) /* subdevice */
+
 /* loop device ioctls */
 STRUCT(loop_info,
        TYPE_INT,                 /* lo_number */
-- 
2.24.1


