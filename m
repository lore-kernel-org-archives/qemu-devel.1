Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA09EC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC8124125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXpc-0006qu-4P
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlM-00014t-3i
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlK-00032G-KT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:51 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlK-00030m-Al
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:50 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6bPS-1jgTgr0XQk-017zXj; Thu, 23 Jan 2020 09:22:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] linux-user: Add support for FS_IOC_<GET|SET>VERSION
 ioctls
Date: Thu, 23 Jan 2020 09:22:13 +0100
Message-Id: <20200123082227.2037994-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5+e8ly+M64AP+Fd9RcIlIR0MmRTynLhSFtzn9DW9MCwhG6dhmn6
 I17Lmp0tzxas//xawK8xcJ2OLzZe62iDbN863PfFuKIJbZcvKzb3QY5vGhxQDBWRabmfnfH
 O4aIRxAZwApOXikf56dc47MHGcYHxLeAaUEdLG7Av2c+WcDDb6sPfgyYCVR44Yi8mTpop9C
 Mr7DtaDCC4J9ykSrWWsZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGKMKVesmio=:RfR4q6OYN579CSUuJI9+1W
 agBD2kYKoeZ9NAEtq9sfB/6OeSVPY3urhw9YYxpcuxNv9I0CJ5gYoxDej3/WolAh610gvUSjD
 ADXHZQNRDlyefen3Xv6XYOuZGhEy+VC/iI9C1BEtSaeWz2MJ3YOgWWc2gqj7ShqheYmuraGXX
 Mphu6eWzna6XZnUh5Qd4y/RhoPRVO+f+niB0YeN4/aPe0dk3v8RH9l2MVllR4H4Yii43HOxUT
 7I32kcLHDh9b264bUUTGJRrt6at4knC/jrDDm6E+rRy2vYypTQbl9cEQeAZxen4g6P79lWj2D
 5TAibfnpDv3nR/RZGqJs3MJuKQv936WYEJEZarYR2OfFmDJmqB+zzwoA/TLLj8cBJs1sNV7gS
 tYBfBlV8kSPhPViHl6O2w48pQz2dM1iCxeqeW6UXT0WdO7su8OHmbYHE3q8DMP+PE/FeA3EOq
 m77oy8BwwqeT0tZPORp6G64Q8ymo8bl3rzv1/IO3FqQXKnfcIBRc/9bKC26FvWzG1tYSYkh4b
 AjbcBam6Qt5t1kmus6lLbGDSCes/5EyhH5uZwsE36PZWLreRvGJJezwd85Zr3EXbtJkTzWZ6t
 PB9VUOHjA7Bpdeb41Jk/eVM/F2gwCjO94S7nZir0cc4ssEckCzlX/V5UmLf123Hs2DSRr/kPF
 rB3LUVC9R0g08nmLnQQfJMjedxiwi6VWYxHWdBzjp5uku+OG8nbNSohmZ3gJVIUHsG8y77Y6r
 8Bht39nWsyK0rYogCRAhEjL4+qOw2Wk0yE9mqGag3AbP9AZuDH1j0NJD2QLevOeZjw5BQB3Dw
 yxIDVFsOatbXc2cSwLTBZ2JG2Y5QLKiud64OsVytiYp3wjH1Jk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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

A very specific thing for these two ioctls is that their code
implies that their third argument is of type 'long', but the
kernel uses that argument as if it is of type 'int'. This anomaly
is recognized also in commit 6080723 (linux-user: Implement
FS_IOC_GETFLAGS and FS_IOC_SETFLAGS ioctls).

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c6b9d6ad6653..c44f42eaf4e7 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -138,6 +138,8 @@
 
      IOCTL(FS_IOC_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 98c2119de9c1..f68a8b6e8e18 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -911,12 +911,14 @@ struct target_pollfd {
 #define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
 #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
 
-/* Note that the ioctl numbers claim type "long" but the actual type
- * used by the kernel is "int".
+/*
+ * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
+ * claim type "long" but the actual type used by the kernel is "int".
  */
 #define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, abi_long)
 #define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, abi_long)
-
+#define TARGET_FS_IOC_GETVERSION TARGET_IOR('v', 1, abi_long)
+#define TARGET_FS_IOC_SETVERSION TARGET_IOW('v', 2, abi_long)
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 
 /* usb ioctls */
-- 
2.24.1


