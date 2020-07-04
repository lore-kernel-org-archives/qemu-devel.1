Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F82C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE96C20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE96C20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl7V-0001fw-2K
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzX-0005Tw-Na
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzQ-0002PP-HT
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:14 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MulyX-1kjJJN21z9-00rnzO; Sat, 04 Jul 2020 18:25:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] linux-user: Add strace support for a group of syscalls
Date: Sat,  4 Jul 2020 18:25:38 +0200
Message-Id: <20200704162545.311133-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qe57hQRhfBDJQOgfjZj7Dgsl40shKE68Jo0N/0JuhK0mjBPtIcy
 rss6qmCcWiImDOp6cKRsP/NbNF3+Q3UMlnGX/5oV9RzmYo7NTWC+cevpxg05lvbd742OrQe
 JeSycWR7c5Ptemwk1yti4MiUZ9Dln4HavW6czkibASrcfYr2uWfxVT7fH4Osf6JtP1MnO39
 XwEfZJlbS9Jk0zxb+T/dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bot2vp0/3eY=:QDiOupgX6JcGXkUGe2ABfn
 R7sDzSOI8hxFevjYrWsINImzd8kW6/bbDxJdl/LhSwRNBN+wmloFyiVTMro4ygqb3+CWFvC3z
 8MEnvUXm6w7MkYGJh0uDgKzenF2ARSE4tDl3zVES88RtmTeRZP8r7BkxPY2zVZ7oELzmDNPgl
 DOWMXYsd/eqrtDsj+p1BpMXRPGS58KhWHoS5Njf67+MHngq5f/l4cBjXqjIwf7nrfL0qDXHci
 sEhMc/sdEH9pTppJ+ECnT2Dz7AeEl/X3RMam8939KeGmmcuTXlnnthEop14eEapt4YOIyC+KE
 20PIcnaX/qGNfl4U4MsX6Sx1SZzqL/LxY84aQtcm4IPOasPtduHyHwPanDhRskN354M58dCsd
 JvMTczHjameAe6rAFgZoYLFxGaJpwCPxov+013RsOT9ftHWH2dloW2fYr9MhH5QIQHn0Y5U43
 vXZYFRkbbS2MZlbW7cKcH+mOooU2U8MfNZs6QxXXADLCLonqBPYsDn+J//Ql+EFTbP9ARHAcJ
 MgkMjSSZHhE9ZCep6NdxdlcZuzbJFONJNd8GRk/PFJESMW/kI1wyWrtkqatNaOQpLxQx97CXv
 wHJejzpLJ3inBEzdMim9qGKVOK8z6fvZPsbOSERuLBehzUxe6YoBqfNKLc5bdj6eRIXMlctmV
 Pn7BO8/ZsrEZjZPYkKJqsmoXmACl8mjjY0TLuwZBy1n0MEI4we/kzj3ur0hAnIGrR4iW0NyJ4
 dgj4pNWyaH3/a0PeXYtX3SOQEP00xMkRzPHNksQ+HiAIsfvBeZTk6Cn66Uqms9ymvLqBpeiZo
 M3F4D/JBVUm/D+VWV87QJmoOxewd/zA9Xw12ZCwhg4k2FxA8PY=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscalls:

    *acct - switch process accounting on or off

        int acct(const char *filename)
        man page: https://www.man7.org/linux/man-pages/man2/acct.2.html

    *fsync, fdatasync - synchronize a file's in-core state with storage device

        int fsync(int fd)
        int fdatasync(int fd)
        man page: https://www.man7.org/linux/man-pages/man2/fsync.2.html

    *listen - listen for connections on a socket

        int listen(int sockfd, int backlog)
        man page: https://www.man7.org/linux/man-pages/man2/listen.2.html

Implementation notes:

    Syscall acct() takes string as its only argument and thus a separate
    print function "print_acct" is stated in file "strace.list". This
    function is defined and implemented in "strace.c" by using an
    existing function used to print string arguments: "print_string()".
    All the other syscalls have only primitive argument types, so the
    rest of the implementation was handled by stating an appropriate
    printing format in file "strace.list".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-3-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 ++++++++++++-
 linux-user/strace.list |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 62117e8555f6..123e022c35bf 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1357,6 +1357,18 @@ print_access(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_acct
+static void
+print_acct(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_brk
 static void
 print_brk(const struct syscallname *name,
@@ -1621,7 +1633,6 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
-
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 9281c0a75828..8a887fc16dcc 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -13,7 +13,7 @@
 { TARGET_NR_access, "access" , NULL, print_access, NULL },
 #endif
 #ifdef TARGET_NR_acct
-{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
+{ TARGET_NR_acct, "acct" , NULL, print_acct, NULL },
 #endif
 #ifdef TARGET_NR_add_key
 { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
@@ -215,7 +215,7 @@
 { TARGET_NR_fcntl64, "fcntl64" , NULL, print_fcntl64, NULL },
 #endif
 #ifdef TARGET_NR_fdatasync
-{ TARGET_NR_fdatasync, "fdatasync" , NULL, NULL, NULL },
+{ TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
 { TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
@@ -251,7 +251,7 @@
 { TARGET_NR_fstatfs64, "fstatfs64" , "%s(%d,%p)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fsync
-{ TARGET_NR_fsync, "fsync" , NULL, NULL, NULL },
+{ TARGET_NR_fsync, "fsync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftime
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
@@ -492,7 +492,7 @@
 { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_listen
-{ TARGET_NR_listen, "listen" , NULL, NULL, NULL },
+{ TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
 { TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
-- 
2.26.2


