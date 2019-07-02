Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B97C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D47206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D47206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKef-0007ZI-32
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMa-0005M2-Ur
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMY-000814-Pp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:32 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMW-0007x0-Kk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEVqu-1hjvrD0O3W-00G06r; Tue, 02 Jul 2019 17:05:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:41 +0200
Message-Id: <20190702150545.1872-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WK8GzMOzuu7ZumYWYKMbijZeysgQ9adw2JnZv0538E96Ct/A1RY
 y/lFXI6iSDGUCmqV1pjEW7ZFBHNQSqUd7aEtbzQsD49pG329j7m7vdaYN6w3CsUN7revIpA
 INNqqChDHH8Ygn/oAItveIvdcn5Z59PD3PuD8RT7f3eu5ykhtxDDIPVi5q1iJArXL2FSQ7i
 LW62UnzgWiuurlePSwEiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YBjUpnuuTto=:TrE3IbLKhViCag4t6cuXrw
 g0THmM7DOp1knZqUwHmkWSk/2yyIwpf4C5Wt6wV/fEOttxG5AbR6iaPhLetSg6v53Cr/wSxbD
 MfPPmGO+yyi3QwbIPzGCNuK+DUWOw0If9TACasaG2RI5DRdYvpGaNrL8zSUpdihDfrbqTXYwA
 VLbI2XbfBIf9cDi01LOtUSLANUB5T+zhjwfBNA6BpTAe7/QljKZdxBLSbOMqvzzqBkuo/Mkop
 MNFNeSE31lvlMuOtnrZatUBBghmlpJEnfGD+qaNlpjt4S26xy3Oi+QGWJ93ChCZL4XiQju/9b
 fwbfQkMEEhj9+QCeq+XemvsrZQwbJcNnCRx8UZYDE/P/IdZ1MlIofXt7lUb2nmq6cHH+l+f1a
 frlkmdhnDJNfJL3cr7mV8BqU2IjEJEPV9n3wD2CtDDoexLkBsYGA9M9Wu0llP3aKwHDo1ssk6
 ZSYy/P87Gs609w/ls90vnchCFVp7bWlvqI+u7GI2AevZVuw7Ect8mT8aKxrr7LElBDdB5S0wK
 mlWrnNWqmHojO8WSxCM2e/Am2q7nXM9HnaSCD7JhIASaccbQDqyK17TgTeSv/m236apCdGOFO
 32PH2480oeXti0sqnJjiIsQ+G7K4zYSrYmXQprboby+V+OST21hayu6Q4Mbp5/2dtQFDa0/+U
 SQoZ1VXFJEH7PMBazxeSjPDswShSqo4TLnstz9XYvjepLgPXmTf5hPBqnEXi5ehYaCepXEfDB
 nodjDIgij9LeLFzumMUfx9/HJ0/IYIpEjKn83A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 2/6] linux-user: Add support for strace for
 statx() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jim Wilson <jimw@sifive.com>

All of the flags need to be conditional as old systems don't have
statx support.  Otherwise it works the same as other stat family
syscalls.  This requires the pending patch to add statx support.

Tested on Ubuntu 16.04 (no host statx) and Ubuntu 19.04 (with host
statx) using a riscv32-linux toolchain.

Signed-off-by: Jim Wilson <jimw@sifive.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1561718618-20218-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 86 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  3 ++
 2 files changed, 89 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6f72a74c0918..c80e93b5db8a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -976,6 +976,76 @@ UNUSED static struct flags msg_flags[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags statx_flags[] = {
+#ifdef AT_EMPTY_PATH
+    FLAG_GENERIC(AT_EMPTY_PATH),
+#endif
+#ifdef AT_NO_AUTOMOUNT
+    FLAG_GENERIC(AT_NO_AUTOMOUNT),
+#endif
+#ifdef AT_SYMLINK_NOFOLLOW
+    FLAG_GENERIC(AT_SYMLINK_NOFOLLOW),
+#endif
+#ifdef AT_STATX_SYNC_AS_STAT
+    FLAG_GENERIC(AT_STATX_SYNC_AS_STAT),
+#endif
+#ifdef AT_STATX_FORCE_SYNC
+    FLAG_GENERIC(AT_STATX_FORCE_SYNC),
+#endif
+#ifdef AT_STATX_DONT_SYNC
+    FLAG_GENERIC(AT_STATX_DONT_SYNC),
+#endif
+    FLAG_END,
+};
+
+UNUSED static struct flags statx_mask[] = {
+/* This must come first, because it includes everything.  */
+#ifdef STATX_ALL
+    FLAG_GENERIC(STATX_ALL),
+#endif
+/* This must come second; it includes everything except STATX_BTIME.  */
+#ifdef STATX_BASIC_STATS
+    FLAG_GENERIC(STATX_BASIC_STATS),
+#endif
+#ifdef STATX_TYPE
+    FLAG_GENERIC(STATX_TYPE),
+#endif
+#ifdef STATX_MODE
+    FLAG_GENERIC(STATX_MODE),
+#endif
+#ifdef STATX_NLINK
+    FLAG_GENERIC(STATX_NLINK),
+#endif
+#ifdef STATX_UID
+    FLAG_GENERIC(STATX_UID),
+#endif
+#ifdef STATX_GID
+    FLAG_GENERIC(STATX_GID),
+#endif
+#ifdef STATX_ATIME
+    FLAG_GENERIC(STATX_ATIME),
+#endif
+#ifdef STATX_MTIME
+    FLAG_GENERIC(STATX_MTIME),
+#endif
+#ifdef STATX_CTIME
+    FLAG_GENERIC(STATX_CTIME),
+#endif
+#ifdef STATX_INO
+    FLAG_GENERIC(STATX_INO),
+#endif
+#ifdef STATX_SIZE
+    FLAG_GENERIC(STATX_SIZE),
+#endif
+#ifdef STATX_BLOCKS
+    FLAG_GENERIC(STATX_BLOCKS),
+#endif
+#ifdef STATX_BTIME
+    FLAG_GENERIC(STATX_BTIME),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -2611,6 +2681,22 @@ print_tgkill(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_statx
+static void
+print_statx(const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_at_dirfd(arg0, 0);
+    print_string(arg1, 0);
+    print_flags(statx_flags, arg2, 0);
+    print_flags(statx_mask, arg3, 0);
+    print_pointer(arg4, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index db21ce41779f..63a946642d29 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1650,3 +1650,6 @@
 #ifdef TARGET_NR_atomic_barrier
 { TARGET_NR_atomic_barrier, "atomic_barrier", NULL, NULL, NULL },
 #endif
+#ifdef TARGET_NR_statx
+{ TARGET_NR_statx, "statx", NULL, print_statx, NULL },
+#endif
-- 
2.21.0


