Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E09C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E4320801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E4320801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i6l-0006Ja-RO
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1e-0004JT-Tp
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1d-0008DR-Kc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:42 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1c-0008CW-PP
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:41 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhToz-1jiBN53l3r-00efmD; Thu, 20 Feb 2020 10:21:05 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] linux-user: Add support for selecting alsa timer using
 ioctl
Date: Thu, 20 Feb 2020 10:20:51 +0100
Message-Id: <20200220092053.1510215-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VrObjhoNrIFwaIgz/64Qicb2frRIBmdftNNWFBXMbhJJqs6E4j+
 G5IqYaOyYpFrmRaM8OlkOisCSSuIK+LSgSP4WhKXCq6GnsFfvsHK1TzqfllKe44BePP8Fo8
 MdXt0ydQRKEkwdVeL/WZI2csBtrPQ05iCgiNjbxZTSaGUrZ5En9d/BrGTHvEm046hgtT9qK
 792teOxHskLFwRrMdGw6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4SJrr0qnfYE=:uxYkYYVdOsEFrRcrBxBRHU
 zHyy0W2HtzSrROR3JOX86HhAxZKaCVdMdQtTxJtPu9Q0w9xVBuY1+atv5ew1EkIiC/V7whD4y
 0kG3iMvyHMNsYKiG5UnHRegY+2AR8IdtxZaKxprZKXqKwwXm3LUBtOK22VBkYAzm1ZYdLX0WU
 TQVMhYn9O1QWPoCNJQw1UellmJqUmMfNEfSo0J4V89rTRpn5IdR8ylVEBW1WmKfZWL+gR1++D
 0vxvv0sF8Zo0GsXqAFP89WjJKKjtjQR9A67IFhOCMuffm+cll2CKEZOwr6xIzD/KZW3Y34lkR
 Qu2gaYEjpf8tzvrL3Y/IC86Rui/CEObRp/d9ADwJmq64WK//+b84MuWxgQV3553I9PDb5vzlK
 xMMTj+A4uow1dwl4AwotFJ8c3+HBIv1CiAPeuKKwwdGT4irmk2Vb9mqSIKhL05n+/2sH4JeiS
 pwS5MPAjp+4b/MSjs4MVb85IixGC24Se6wW5WkZFklXiZ45jqpV9s/9fe9lMZUijLAjrkzL2M
 qLcwTq1lLihFPLabU6OHkw8l+djK8hKT7kkmz5iBVtcOO4JWtYG25vvXFd6TGSO/Rv0q2Qy5T
 x+qfxQSvnWIjrKqBEY7n1cDsh1FKF7u0hEjCmx+rWkVejooWWWzVehCv7vafUGgVA5oTQkozP
 uvcKhSGnNnVNiQbvUGk+sDFje/aZXbqlGrGWnd62Nzo6n12M0v30uI23CM6HGOPbhDhJDTCzF
 ccqnwuBtQlaJTl1gIa6j4387Ap/AAs+C1+DWEX30V2NHhnwA1y5RY9cu6a2WOq7TDR/PbX7oy
 Ja5nvS9sXTFcJgASei7Dz7BCJQpLexKCKcEsXlxWWzwmMUlT0ie19OuJUMwQN9gvzMLOmZS
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

This patch implements functionality of following ioctl:

SNDRV_TIMER_IOCTL_SELECT - Selecting timer

    Selects the timer which id is specified. The timer id is specified in the
    following strcuture:

    struct snd_timer_select {
        struct snd_timer_id id;         /* timer ID */
        unsigned char reserved[32];     /* reserved */
    };

    A pointer to this structure should be passed as the third ioctl's argument.
    Before calling the ioctl, the field "tid" should be initialized with the id
    information for the timer which is to be selected. If there is no timer
    device with the specified id, the error ENODEV ("No such device") is
    returned.

Implementation notes:

    Ioctl implemented in this patch has a pointer to a
    'struct snd_timer_select' as its third argument.
    That is the reason why a corresponding definition
    was added in 'linux-user/syscall_types.h'. The rest
    of the implementation was straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-11-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 2 ++
 linux-user/syscall_defs.h  | 7 +++++++
 linux-user/syscall_types.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 150aa680b018..8313af3672c6 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -470,6 +470,8 @@
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_gparams)))
   IOCTL(SNDRV_TIMER_IOCTL_GSTATUS, IOC_RW,
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_gstatus)))
+  IOCTL(SNDRV_TIMER_IOCTL_SELECT, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_snd_timer_select)))
 
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index c714e8b67b6e..cac9228a37d0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2474,6 +2474,11 @@ struct target_snd_timer_gstatus {
     unsigned char reserved[32];
 };
 
+struct target_snd_timer_select {
+    struct target_snd_timer_id id;
+    unsigned char reserved[32];
+};
+
 /* alsa timer ioctls */
 #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
 #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,           \
@@ -2484,6 +2489,8 @@ struct target_snd_timer_gstatus {
                                                 struct target_snd_timer_gparams)
 #define TARGET_SNDRV_TIMER_IOCTL_GSTATUS      TARGET_IOWR('T', 0x05,           \
                                                 struct target_snd_timer_gstatus)
+#define TARGET_SNDRV_TIMER_IOCTL_SELECT       TARGET_IOW('T', 0x10,            \
+                                                struct target_snd_timer_select)
 
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index adcfa2822468..81bc71938241 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -116,6 +116,10 @@ STRUCT(snd_timer_gstatus,
        TYPE_ULONG, /* resolution_den */
        MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
 
+STRUCT(snd_timer_select,
+       MK_STRUCT(STRUCT_snd_timer_id), /* id */
+       MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
+
 /* loop device ioctls */
 STRUCT(loop_info,
        TYPE_INT,                 /* lo_number */
-- 
2.24.1


