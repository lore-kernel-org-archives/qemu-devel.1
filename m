Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1224FC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DE524655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DE524655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXuP-00054t-Cp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlK-00013E-C6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-0002wm-Ak
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:50 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlI-0002ul-1O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:48 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4hj5-1je0iJ2zzz-011g10; Thu, 23 Jan 2020 09:22:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] linux-user: Add support for
 FD<SETEMSGTRESH|SETMAXERRS|GETMAXERRS> ioctls
Date: Thu, 23 Jan 2020 09:22:16 +0100
Message-Id: <20200123082227.2037994-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gBkw/jmdz/LtmzTMQt/NU0YwDNRHoYbQ+Zm9Z2cq50ywGcngvF4
 IG0GSEpMp7wC+C8bBVlu9D9KtLjqVKf0lwEbG+IQMnm6UsgHa1SksnCPKO8Qr2d5vrw7NcV
 Jq9lkY/K3BNsjimXi8rljwc+DZBFqQRGve689AkxqeXUAFisAn+JDKnUjaOXbfmyg0z/Nf0
 zjrV0H/YYJEYJ0j0qSb5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JIla6PNb3nY=:FpT59qBYzckyiP7VbCW9CT
 0mOoCoanUH1/xsS9qMPST19zZKueaNN2nZloAi5BKkvlY6jee9axJguEKEMwIrdngZfZoc/1P
 7sdBRrExKSvvQRYT+kPx0x1NZ6lzz0kaX06O1v62lRBvt347rwVIl/pWmHQyXXjNQ36PPWPFQ
 5fXxOuQH/btVONojV8vD2H8kjx+oPcx7livKGMFU2iwJZZkxvSZf0LfLAIijJaP1tByV1KFPI
 L7wYI6BN6hZMYcu7LXnMgT7GSWhOjdSzxQcccrW8huJ2IwX79/yhAa6Mnd3morWx0EXHIcnbY
 +R+WitynK05yPrhteVC/1/lq4AOMbHJnYoDfwvB3r/2ln2Tx4A5jG6DmxysqiKQAUzM70Jv03
 u0OolZLA0SVb3ZdMMk0KpE32GVM/xKDYxySDZGN6iF9AGaerjg7GjAkDWfz7n7Z4vum2FOFer
 6bV2wdEfFHlLNyN3yMl7u0Y1ahqINeA5H0Nfsvns0E2IbkBLnxPCS+bscYvg0Dlwu/YCXUQ1e
 C0z5bsXx2epKKprinmihIQ5vRI8Li0yIlJ4wmtqfXKKxk/eN7hL3XsHE7gKtkJpvPljfgHGbN
 NPqF9EWTeJZoeRo6VJdHuQK7+nt3ZM/iOH5QNlmXH45VpM/rgVb1tZ5GIq6tNrBjokRxHKOPD
 6jU3r+50XHGJm7shCU8wJcE14U5Q6JwMRXCz0GvS3h2na/1JOir1/lBDYKyXfUSP+HJZcbCuR
 J01j/0hI7IgqBiDwz6hTuJQ9uReZRM2+yK1kyPuxMw9bcA/Vall6PNwrXn5ndJFfBhao5rizO
 qISnnFG2U4BUy88d6OafLkiLjW2GcBGTGgVxqgpgItVwANWj44=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
for controlling error reporting of a floppy drive.

FDSETEMSGTRESH's third agrument is a pointer to the structure:

struct floppy_max_errors {
    unsigned int
      abort,      /* number of errors to be reached before aborting */
      read_track, /* maximal number of errors permitted to read an
                   * entire track at once */
      reset,      /* maximal number of errors before a reset is tried */
      recal,      /* maximal number of errors before a recalibrate is
                   * tried */
      /*
       * Threshold for reporting FDC errors to the console.
       * Setting this to zero may flood your screen when using
       * ultra cheap floppies ;-)
       */
      reporting;
};

defined in Linux kernel header <linux/fd.h>.

Since all fields of the structure are of type 'unsigned int', there is
no need to define "target_floppy_max_errors".

FDSETMAXERRS and FDGETMAXERRS ioctls do not use the third argument.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-8-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 3 +++
 linux-user/syscall_types.h | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3affd8814a86..2c3d798842e4 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -114,7 +114,10 @@
 
      IOCTL(FDMSGON, 0, TYPE_NULL)
      IOCTL(FDMSGOFF, 0, TYPE_NULL)
+     IOCTL(FDSETEMSGTRESH, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
+     IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
+     IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
      IOCTL(FDRESET, 0, TYPE_NULL)
      IOCTL(FDRAWCMD, 0, TYPE_NULL)
      IOCTL(FDTWADDLE, 0, TYPE_NULL)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a73cc3d06790..48de76145f0c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -899,7 +899,10 @@ struct target_pollfd {
 
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
+#define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
+#define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c, struct floppy_max_errors)
+#define TARGET_FDGETMAXERRS  TARGET_IOR(2, 0x0e, struct floppy_max_errors)
 #define TARGET_FDRESET        TARGET_IO(2, 0x54)
 #define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
 #define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e3698382629..e4e0429637c5 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -261,6 +261,13 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
 
+STRUCT(floppy_max_errors,
+       TYPE_INT, /* abort */
+       TYPE_INT, /* read_track */
+       TYPE_INT, /* reset */
+       TYPE_INT, /* recal */
+       TYPE_INT) /* reporting */
+
 #if defined(CONFIG_USBFS)
 /* usb device ioctls */
 STRUCT(usbdevfs_ctrltransfer,
-- 
2.24.1


