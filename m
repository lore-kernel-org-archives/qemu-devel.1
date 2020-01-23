Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDDC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF2624125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2624125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXmv-0002lL-7s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-00011Q-0b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002o8-Tj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:46 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002hi-Jq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MS43X-1j1OAp0ytf-00TSBm; Thu, 23 Jan 2020 09:22:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] linux-user: Add support for FS_IOC32_<GET|SET>VERSION
 ioctls
Date: Thu, 23 Jan 2020 09:22:15 +0100
Message-Id: <20200123082227.2037994-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gADahtYlfl4hprY4xyq4f2nsq+4iPSHC+rkl+9yB9X/no2DySL7
 lc43L4h64kQZRax8uTCq/WXFnl1AUSor3RfaXMc5gvY3mUFo+0Ob1orAtk3t00J9K7Au6yj
 T7+FnZo0CYR3kcTGFG1ZvAyNqK6Uoer+Ru3bN2TcbTfzbNS61pkmu7KZdcaNXsDFtYvhPX2
 I6uN/8uq9zC5Nqx6GhCtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ugM7vGuRw2M=:2vSXN+4leZhkZmGBH9uBWT
 ndFJGK0L80hu8/BZVEIpERCuUe3WezvxYqFpsJB7OeTy1KAXJC6CS0gs7zJHpCiW/jz2y/hXJ
 bdPLGRARRbiQB11QPJB91DhVf4F9ePHxHB3iic7ehwXTaJhdPOU8sKuIji6lqoT+eZzCg+lzI
 QrumpCeGxCNT/fJvBLmTXuEMeoaXI2DwEaAMsiKomCjxK7RzB/Bno0t8coWE66pcsFJofoVYm
 wM7cqFQi2Vhbp+YOHLYzPzIp+0O0FiPN8+Onn0+/D1Qynr426yxfAhEBYNqQbtNf9u6mAhYqZ
 ttX4N5l0LSUWnBjiK2EG8sJOTC3KGbHBOdlVl8fHRtNOPBmfDKLM1wrMZ1acNEDLijXKoD4W7
 vPqEOaLlfxEkmko6eZFB9PYBfgPLIgPPtHE88+er0OB5dUKO7Xhso871emgnN+ysJbd4PsETd
 MatedhuKrN6czZRMrg+jqa28wwMUoeb8X68ztjeliRnStRRlF/45LBCHU29yidp+6sHGpydqP
 Lg5Be6xB3AlJzNNL7VbIywskVNE8fqr0pXAZZMSsCAjjU+WyCuK0uPvnDCCfNIN2pYmPEDzA9
 BIaIK1XB2VIx8+xqzyuMdDTtgfWQXI/K2BVCXnGXyM4jWXv2bcByz2qwjnGqXuUcK4F1bTmag
 NUfCgTVsLw79F9AeL91rAeP1APuB6ybxVmYWXLN8mgQcI093/O2QcPo1Hcv7LKzAqmxMZrEdn
 Ji3NBYXlol2Pc05ETzTP5eitDIP9V7+BG2aLTg1v0dq/8zXtwLEC+WSyWCcPKbl4ICh+NVYF1
 BLrDlbpiVhg8bRYfGG9Vs6DZ2zSSZ28Hmq0NwMNOO45JBPgxzI=
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

These FS_IOC32_<GET|SET>VERSION ioctls are identical to
FS_IOC_<GET|SET>VERSION ioctls, but without the anomaly of their
number defined as if their third argument is of type long, while
it is treated internally in kernel as is of type int.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 4fd693984e6a..3affd8814a86 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -142,6 +142,8 @@
      IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 964b2b458dd5..a73cc3d06790 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -922,6 +922,8 @@ struct target_pollfd {
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 #define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
 #define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
+#define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
+#define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.24.1


