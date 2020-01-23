Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0473C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85A524125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85A524125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXpu-0007MQ-Fx
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-00011l-Id
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002ne-Rw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:48 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlD-0002h1-5b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVe1U-1j4P740RjI-00RW7J; Thu, 23 Jan 2020 09:22:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] linux-user: Add support for KCOV_<ENABLE|DISABLE> ioctls
Date: Thu, 23 Jan 2020 09:22:19 +0100
Message-Id: <20200123082227.2037994-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zNfPndWnTfyMu8W8Zt6FV95lB+oI0aYtu0oTtxqSMeEEo8Hymj8
 5v7iyn5KuJoof1XG5fipPYK4b0f+h3zXxOckDsGEFybjoRxfQWtjG9dxOXnP7SHaIIU4xAv
 8l+p6aSxxmWEp1dnM8UBKPJCbEm74KJnEGX0t72NKKIWli4f174SAUtB/5vFBHpxlbcu3O7
 7xNG0R2ocXmqsEKr1zxMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfN7sH84tDQ=:BAk6VId1vOw+vrviRC0Zxv
 GO1H58GuhGT7rvlVEwTVG3ZKDHkEpraLIvwImOzNInJNfFQmkFR913hPyi4nRL82N5j1bdFCF
 eGsAM3xvr29fQ8NXVFBvW9CF7SE88L+jH0VGBtBNntyTvkJP3KFGVF2MBy3qnIXLWA2WWsXLc
 lJEMs03ACp1CW4HNvFZjaUW4J78IfWR9l271ett7fauDr1Pj/fxer3w1lKcsfCmxef80dhOMS
 6ebsPnpfmoYc/Gt+AV/ooBLbJStHv8lSTTz4OstJi0d2MKrhCZ4SxZ1EhP23thpkOBn+kN0BN
 ArQ1JEPWogL9NL0GRFDxrVVryjewHJHahoN5NtOGYGVrNcfChwJmx5AjPxYrXboXWF6DEJ0vV
 ai/U9X5zSLwRLc1SWEua8FfIXCnYeQVEJ2IMIafdsM+HiYP14sr3koGnQfUkqj1iMtD6zHbkE
 xnreMK5yh72AC2kBs1WKfhdKrX7GR3cExeG5R1pkasOONmR7wJJ5KgFzU75Sn2HcsXG3inQOS
 qVBT9pD5Dz8At4yySrAjVD04lXtLzXNmioLEeuZinoHnWmhHNUaYVVGY9GCdZaTT7EfZ/zg0A
 PqD+uv8VgUHS6p75F88mB/nJ5KSFYFmsRN2mScbsn2vbJmeV0XW2Gr3Ich27EjhsgERWqPLPB
 Pg01Z19Xu1FQYuqNeGHbZo+hJd4Ymj/bbGKiBof5ZrmoI2ARpQ7pDjBJ3xMTgGXeBVHGXr0t+
 7EPgpKfQzw6s91rNnfF9e7+9JteGBGCackXJeUKP2E0J5fCb7wdOwX/Rc8k/Uwi0n/ZZxIWLX
 fyOg3+bGwadqF6BM4d6n2FpYKDc7jzKtICUkqn+zAIgvggN+7o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

KCOV_ENABLE and KCOV_DISABLE play the role in kernel coverage
tracing. These ioctls do not use the third argument of ioctl()
system call and are straightforward to implement in QEMU.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-12-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 5 +++++
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 29969e2f2f27..6220dd8cf791 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -534,3 +534,8 @@
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
 #endif
+
+#ifdef CONFIG_KCOV
+  IOCTL(KCOV_ENABLE, 0, TYPE_NULL)
+  IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 249e4b95fc9f..c5bda60b45de 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -73,6 +73,9 @@
 #ifdef CONFIG_SENDFILE
 #include <sys/sendfile.h>
 #endif
+#ifdef CONFIG_KCOV
+#include <sys/kcov.h>
+#endif
 
 #define termios host_termios
 #define winsize host_winsize
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index b3acf85a6b23..7b0b60d253d9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2434,6 +2434,10 @@ struct target_mtpos {
 #define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct target_mtget)
 #define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct target_mtpos)
 
+/* kcov ioctls */
+#define TARGET_KCOV_ENABLE     TARGET_IO('c', 100)
+#define TARGET_KCOV_DISABLE    TARGET_IO('c', 101)
+
 struct target_sysinfo {
     abi_long uptime;                /* Seconds since boot */
     abi_ulong loads[3];             /* 1, 5, and 15 minute load averages */
-- 
2.24.1


