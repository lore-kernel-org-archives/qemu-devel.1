Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE98C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B0C24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B0C24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXrU-0001VI-Pb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlK-00013I-D3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlJ-0002zM-41
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:50 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlI-0002wf-Rm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbzhv-1jT3QX2T8x-00dabu; Thu, 23 Jan 2020 09:22:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] linux-user: Add support for KCOV_INIT_TRACE ioctl
Date: Thu, 23 Jan 2020 09:22:20 +0100
Message-Id: <20200123082227.2037994-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hr4ZMo0VmkvhhZ9Wuf/ByxXTOlHeIZCcmCXUKd0fSWtiKPYF70e
 JdfAxdjmeuirhP+Xpv4wxA0WcG6xN3eWcodjEuu/72OVdVnjXIa/iICI45QNgYGEByT8Siv
 QARlg7qr+Xa9pB6+PmF+Zglp2UpCdOf4H0Ik63BqjAsdy8/q205U0OtsxH318Rmdqp5j4FV
 bf/jiGMoMkAohJHg2ON8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:61EkKJ01Mio=:j2eMW1riqemOYwbtVA4I8H
 r7UtOnrU4jnOrQuR09kRCVe/341Vj/GdKYDKP3VItUCkY4/JPAbg35rzykC6ADILlNes/mnCZ
 Bbi+QOi2xIXIFyLSNI5L4BbHkYTewh12StXizpHZqEPGcAN/dBtms1Q8viUThjS9Z8xqfgGlZ
 t+5CG2iquvI+lyrub524G6FwkpDYthkvjb1ETffodyCHqMe0dwuIjeZosV0UDfnxGh6M0pkCZ
 c+zOURC7Sm3TRmVb0cMtz6yOuUo/mfRyajUeO5/k7Yx1JD+yoU4q9YH418uCF1hOoWSM4y+gY
 2P+iEwm594lrQHqZnsDCVKM0PuplKKVmD5CSzrgxwF4Q22RD4gVJm3Tkx0Q2oYvOsNvESRzEG
 FSxcX5ziVHCU2A19+WfBDUTudfMuY9XAqs72hHnhwBgmGBVp7tM+dNGz59rQ/WOnRBVFEO+y+
 2vlXea76ng9OJZbC7TTjzkhVkPegnxdiS3XsI2e2cFGgE7bhfTB/xaaTO/EuutOmcNJFa4ki4
 6FaJcNXui4vjN1HMdp0ra7sX6MDPXx7rI+RnDZsdtlNYV51seNgdfd/PNJOA0k3y0qx+sFKK0
 xoqxFSFB3SUBMKsArUggL+XFb2weNX/wjCf6ISSOyKcAtOmGGsHtEbIOlJuvfEj8VgWRErnMm
 XK9pFHsSZ37Y5xWoQd9p0R3sUhdAmHSk4tZE1mBUw3LKHOC9Z//fdmb0l+xTXCiEG+/rQjUjU
 4YmdI8RxjQdRWaRjn4WdPMMYMnupmLUXeOcL4gzH4uXPyZdJhhWNmpqwvjcMt6NOGaa9T8D8j
 jK5ltTZIpQZ8H16vuGhTytKkGr7nKnx46Gp3RvvlTeo+0Dv5jI=
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

KCOV_INIT_TRACE ioctl plays the role in kernel coverage tracing.
This ioctl's third argument is of type 'unsigned long', and the
implementation in QEMU is straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-13-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 1 +
 linux-user/syscall_defs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 6220dd8cf791..23f6d3feb5db 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -538,4 +538,5 @@
 #ifdef CONFIG_KCOV
   IOCTL(KCOV_ENABLE, 0, TYPE_NULL)
   IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
+  IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7b0b60d253d9..fb8318d12185 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2437,6 +2437,7 @@ struct target_mtpos {
 /* kcov ioctls */
 #define TARGET_KCOV_ENABLE     TARGET_IO('c', 100)
 #define TARGET_KCOV_DISABLE    TARGET_IO('c', 101)
+#define TARGET_KCOV_INIT_TRACE TARGET_IOR('c', 1, abi_ulong)
 
 struct target_sysinfo {
     abi_long uptime;                /* Seconds since boot */
-- 
2.24.1


