Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646FC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E4C24683
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E4C24683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXmw-0002oH-KN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-00011R-29
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002nv-S5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlD-0002gf-5c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MplLZ-1jO7l82WDd-00qBoC; Thu, 23 Jan 2020 09:22:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] linux-user: Add support for FS_IOC32_<GET|SET>FLAGS
 ioctls
Date: Thu, 23 Jan 2020 09:22:14 +0100
Message-Id: <20200123082227.2037994-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eUWuUMDAVRWaHN3nTmOWiEuJiOsj+shrFkYHJqyp7VZeoVJ/yLz
 6VAYO1KZHx8E3lvnRW03Bu91CtkhvIVNgxwo6RO7ckRmH1ViwYadRXALnxNPP3bmzXy5OLV
 qvLOTmirg+dnwtCqRP74r3OoieM0g+cFBwq5s+gYObDbBuapxFlO95gS1WqgcXrueZ7secU
 0tLEXIgR4rrzx78Tws4yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+l9JbOgRqAk=:A8E4aF8hslYpT17kUBlTj3
 mUCVUM8ZR38V7YaK3uhVjRwI1ZXpUcgFulcSou9E+2UMnXJVQqqUMoBIUaTaq6q1WrZVodIZK
 WmR7MBsHKRD5W2q7b/opfFqqa5/sf5GhOjbbuxRBmygsrgBPJJIG2bZ7GZVWc9UbTkcWh1yqq
 PFT7YIuVzntRGLHydITRNYMgcdhz0Hkv7QW0sdItJP8vZlQ0Dbds8TuleTOWRKSg3274DXfQ0
 F1e10EpJPvos9LyhXbWkDzEccvvpjf2CCnXMOq9A7/jLzLj6yn0ymi1FSsG31SG9OunYBj9Nz
 xKJZG/fNU6OpetFnioz74lftrGg4Gba5Riuzg5LQprirudgjP3CulY1C0++xKmxklVcm+Goiy
 UJ/IvZgRH28ULcrbR1cZhqvPbsGf4t+pxoOSsIwMblLFURuFFWlEfA2J8MCP0YlmqdN8vs+/D
 7eoKAx2hs9aYJMF9/op/s2P2tuLaRDlg60Rp8qm6KOBMmEfKQUwDIwifJNYCUqC1QSrxbMwrf
 8sKnTKOEle2zUwO9FYVV0t0JgVi/f6UDslWQtkUP/gUGdP1s+KKt7tpTBIs+TqQnD2wUgqNEa
 ouQfCsY9iCv6JVbFvAFoyAvjsrJQAbQq3Jqw1nZPIjeXEYlLW4fXV7f6JHy2WzfwwDxSs2H+S
 oD1dX/xv3cTPrMZMzd7bm35/PEw0/LL9o9ng6Jg9TMDZjyOEOmmZfXuMB6vy4MunFEtOyDRug
 1RmTKLpyfzbfAxDjAHg7YsPgO47EZfupuBje14MSrZxug5jF0NZJq3+SmHbyq3bhzoXhtwCwJ
 P3NWRFSnfPT2TZtDkCV2hCIXQi1OtGNCewinpO3wsvAVMVQjLw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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

These FS_IOC32_<GET|SET>FLAGS ioctls are identical to
FS_IOC_<GET|SET>FLAGS ioctls, but without the anomaly of their
number defined as if their third argument is of type long, while
it is treated internally in kernel as is of type int.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c44f42eaf4e7..4fd693984e6a 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -140,6 +140,8 @@
      IOCTL(FS_IOC_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f68a8b6e8e18..964b2b458dd5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -920,6 +920,8 @@ struct target_pollfd {
 #define TARGET_FS_IOC_GETVERSION TARGET_IOR('v', 1, abi_long)
 #define TARGET_FS_IOC_SETVERSION TARGET_IOW('v', 2, abi_long)
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
+#define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
+#define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.24.1


