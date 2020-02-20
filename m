Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42231C11D07
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B00E20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B00E20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i5h-0003fJ-7m
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1c-0004H0-QS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1b-0008C6-2A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:36411)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1a-0008Ba-P6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:39 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsDe-1jDXhb02Cm-008tX8; Thu, 20 Feb 2020 10:20:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] linux-user/strace: Improve output of various syscalls
Date: Thu, 20 Feb 2020 10:20:44 +0100
Message-Id: <20200220092053.1510215-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7jlKCWT83LjMYf7RMn3RsYkXwIk6Y76XHxJomSuhmLJMMWzDnQK
 ij3Ae0g5UK4xxBpju1TX1RF8kOY8SmL7Rh6bkTJoBsBJkPQJMFETOzOcmW+RMeVrLbLZ4MY
 Jrvl2qzVbiQC+YtUkFnC88nu4r193OY4IwD1ytCAhO6YO0sWz/cPQWdTrdqOW/x9Agau/ax
 zPK/04PvxIOWtE4Uuhh2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p4cvV7Woppo=:Ze8p5NyA//LByydecn4GJ6
 1g9cHMOpBfco2HJWQMNnkbioAiIwPZvL/gVW6fNP83H4Leb6j85AoKAmwsPBdj2s/gty4jptk
 DXwDQAo0pt0O94DxnZ/UnUjyNGIIsvZaazPNht0Kb/qX7rW0+1vacvbu5kMhuy9t7BNLQOq64
 XH8l8SctAuMb7D7+7lkXW4SaGoYn/s0Z417nd229ywAMC7emUQgcpmXOPWX6CtUlyG5LBHPO/
 3ib/CeaylEHEe/Dpr2Yz2CBbBXGUPrvHq0FtfjWswrd2tIYwWO+OY+l2S4dmCd/Vw3r//8SNC
 1BtTDJ+VYLqgKXtBE1UewrklCX5BJGTBgFgU3HnpzO1yyZe90tCnFoIqRa+ztxxhrqMrZfYRf
 es+A4ADFVqPrNZXXAlI2RvelLIzQIWhxqCRXpWcYlYXXozQkMQpzTFZceB6kRSI+bxQ5Yk56r
 EqNWGj1kwOtqqsCcitBFsoa54QhDF7KLvkDumFDgbZwVZiZ51WjDP9t2prGRw8HQ4nQ+3OvUA
 dCBVbGxW8x72RwHbM17yWcW1wqpc6XlhYdUkBPcx8Wi6XtKwQxuBK1j44uj4NLIqFJd8Xrr6j
 2SxWhPPLPNS9BmtV9V8SnpxnAw0RnnnmRTVlDVxkmo0ZARqljkDeOPQGUPHX3Sg+LOK4IYEjd
 qGkYPTwH2O7B6HIJD3x+S/UtQrPaKOmGbxIj1Lb7DuFpFMmZ0JdQuJzsOM39vNzE1T+SWsCAP
 Sg+mN3kpxyLga9cHyvA/c4kQIO6fFIUMKkVY6QvOLhriGzrOS2GwBD40c95y9yxsvd8um73Eu
 XGJDrCp+vM0bSA89leR+HFeg3lgKN9VFIR+tQwKPAIRD6FZGIkQ9yy49jNa3jlS61jhQ01u
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Improve strace output of various syscalls which either have none
or only int-type parameters.

Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191121193351.GA31821@ls3530.fritz.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1de4319dcf87..d49a1e92a80e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -26,7 +26,7 @@
 { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_alarm
-{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
+{ TARGET_NR_alarm, "alarm" , "%s(%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_aplib
 { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
@@ -116,19 +116,19 @@
 { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_dup
-{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
+{ TARGET_NR_dup, "dup" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_dup2
-{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
+{ TARGET_NR_dup2, "dup2" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_dup3
-{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
+{ TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create
-{ TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
+{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create1
-{ TARGET_NR_epoll_create1, "epoll_create1" , NULL, NULL, NULL },
+{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_ctl
 { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
@@ -146,10 +146,10 @@
 { TARGET_NR_epoll_wait_old, "epoll_wait_old" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_eventfd
-{ TARGET_NR_eventfd, "eventfd" , NULL, NULL, NULL },
+{ TARGET_NR_eventfd, "eventfd", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_eventfd2
-{ TARGET_NR_eventfd2, "eventfd2" , NULL, NULL, NULL },
+{ TARGET_NR_eventfd2, "eventfd2" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_execv
 { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
@@ -191,7 +191,7 @@
 { TARGET_NR_fanotify_mark, "fanotify_mark" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_fchdir
-{ TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
+{ TARGET_NR_fchdir, "fchdir" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fchmod
 { TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
@@ -287,7 +287,7 @@
 { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getegid
-{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
+{ TARGET_NR_getegid, "getegid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getegid32
 { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
@@ -299,7 +299,7 @@
 { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getgid
-{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
+{ TARGET_NR_getgid, "getgid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getgid32
 { TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
@@ -329,10 +329,10 @@
 { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getpgid
-{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
+{ TARGET_NR_getpgid, "getpgid" , "%s(%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getpgrp
-{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
+{ TARGET_NR_getpgrp, "getpgrp" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getpid
 { TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
@@ -432,7 +432,7 @@
 { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ioctl
-{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
+{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_io_destroy
 { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
@@ -1257,22 +1257,22 @@
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setfsgid
-{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
+{ TARGET_NR_setfsgid, "setfsgid" , "%s(%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setfsgid32
-{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
+{ TARGET_NR_setfsgid32, "setfsgid32" , "%s(%u)" , NULL, NULL },
 #endif
 #ifdef TARGET_NR_setfsuid
-{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
+{ TARGET_NR_setfsuid, "setfsuid" , "%s(%u)" , NULL, NULL },
 #endif
 #ifdef TARGET_NR_setfsuid32
 { TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setgid
-{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
+{ TARGET_NR_setgid, "setgid" , "%s(%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setgid32
-{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
+{ TARGET_NR_setgid32, "setgid32" , "%s(%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setgroups
 { TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
@@ -1296,7 +1296,7 @@
 { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setpgid
-{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
+{ TARGET_NR_setpgid, "setpgid" , "%s(%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setpgrp
 { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
@@ -1311,22 +1311,22 @@
 { TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setresgid
-{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
+{ TARGET_NR_setresgid, "setresgid" , "%s(%u,%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setresgid32
 { TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setresuid
-{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
+{ TARGET_NR_setresuid, "setresuid" , "%s(%u,%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setresuid32
-{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
+{ TARGET_NR_setresuid32, "setresuid32" , "%s(%u,%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setreuid
-{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
+{ TARGET_NR_setreuid, "setreuid" , "%s(%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setreuid32
-{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
+{ TARGET_NR_setreuid32, "setreuid32" , "%s(%u,%u)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setrlimit
 { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
@@ -1335,7 +1335,7 @@
 { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setsid
-{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
+{ TARGET_NR_setsid, "setsid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_setsockopt
 { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
-- 
2.24.1


