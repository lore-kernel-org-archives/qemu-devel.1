Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C568C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEC720672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gMxggRh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEC720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsHo-000497-T9
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iXsDM-0004To-G0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iXsDK-0004vy-Uk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:34:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:50387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iXsDK-0004vB-Gp
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574364835;
 bh=JzP4tzFp+NnxOPqwU1k56WNBiud9q7zQLHgxgyFc/Eo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=gMxggRh3BTWVv7oje+z+8sFicpNwEUNSF+ixrsDEQ82JD9ZmqH22febLds+r7INfv
 4NK0YzE0LUAxsu9RPl86h69KWK3DHH2pVSYQSKoJXJWxg0e8PqDNJM9rYdqxFNzUdI
 mkHVVbgFuU4Fon+QPl9MphCjZT4TXN+XokmYIwqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.156.18]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1hhhMq2ujP-00vAGC; Thu, 21
 Nov 2019 20:33:55 +0100
Date: Thu, 21 Nov 2019 20:33:51 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: [PATCH v3] linux-user/strace: Improve output of various syscalls
Message-ID: <20191121193351.GA31821@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:+BYJB7rON8105Rb22Xx0uUl/TGqVnWQYE8oXHHq8TGYdRtaWVcY
 aLdeRYalx8rQghgOkDwd4Bv8ZS+KwBG6ccuPuJ6Uj15mQBlODBnoTwC9mDqdypsmTqQYH7i
 sBEUodrYc5Gb1qZOcwX/OrM1A5p6WjKZN3FdouAuyMsDqIqhT32+LEXLqje1OdzZ8Y962Uk
 Vyl5FlWKHR93ZHP8PajGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w6Jgr7WaTFM=:tY4e+PcWRM0HFxfxwvW6FV
 838TM1u8w9XemyZ4N/mgXMXQPIGFI2aSOAiUVRSwTU84ZWGDyVKklvXKAfcJCiZWP5Gevvq58
 EfEonzmGFVHhSD1VufothVUw3Oi7ARp30bkMcokDXaHQJ/LQZnsdBBGeAUc02jZ51a8NWgg+l
 Sh2P2RgITxImvWQ8enpkkmMHfOOCYFfnaulitmwZaXeaA9lbozXXNvOLxCw6s7wCA6zdL+CNS
 uzRiS889Qi7bOKOXDOmc3IyDhjYQlz8krTmj1lKwE7mUJA05rKEHYg+Q/ZiVHHSuqxRFL0s9i
 yOaEV1DBOl/eD3YCcv1NiKUqvxLKlTOnHNoIvSC0riqyfV5OdP+nzlYoPDK+RC5lfekOJQqSD
 A8OPpaULngiaGK1ZnDJ182hL1EKtGa9rcZxKj2vNOfMuS6BxqdesVq2eLlhZOxDOOPeqNyO+A
 fLKsWg+LF5n03MUniV5XGKmPQ1veXJoiknREBJb+BXNMyFMOu/G6ArVfA44cPOAI9sFAYkayO
 5z0VOXZCrogrtR/UlNowqIcmLomTv5Jfw6+qNy0Hh+5UzmQFaCGBr1BsPiatnVwNyq6nOhK/r
 T5twxFgvuSItLu8gfVuZYXe9DxUO1HFqq1SPcqLPGaC/M7kfb9ZOWcqPhctVZltQrkAret7lg
 TUvIdjafe5Ivf296wmkZbzKUEa1LrHKdGj06XtNFQ7zRHTggpNFuFrunCvluDxU9OYscW2g7L
 nGOCLbkEOY0h1jjQjk9Ywk06xA/qHwU9VLbJG++R6oPerGIJ4h1wyAVmOqMiV6emBLt3pEEGC
 HvzjD/UaQA0zYHEO0RR9+PzA9/GflzMsYwilTVAirhDfR/LaOmG2yk04eeBRSHl80NnIpZ6KP
 awz9yToKKq7vWAxM7rzgbupN2GuXam2y+qe4LnYc6Q2EmRMbUqh2rmSOo4DBkHlRQrSH6mB6Q
 oTkoCT4D/52tJM+ZfJ+DekNDt4cBXctMzEJUjRdslD4DLJnBtfU8ASTYDqBxgMkE8I49E2GmX
 NK0XYfTUiBtbR2mB7TVXXbzol7k/jSkOTY0C7Yw7pbrTHuMNt2U82RmUuW7truEGQkglpHfcs
 rAl9s2kD9yxLxCbzj7XIiolq4hcRMe7l0U+sJj3/xlTHlu8PVq41gnwvGI7doOaDq+TjdZSaB
 TNks2vQNAbo9bBEPwFYYh/75czy7xQcR65msAAKU2BhL+JdwL++CvazSAl9zWeH5cA29A7tMo
 oS5F3O7mo3dVfVrVHGEYvrwsnwFZE9LLANi+LdQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve strace output of various syscalls which either have none
or only int-type parameters.

Signed-off-by: Helge Deller <deller@gmx.de>

---
Changes in v3:
    fixed alarm()
    added epoll_create(), epoll_create1(), eventfd(), eventfd2()

Changes in v2:
    fixed ioctl()


diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1de4319dcf..d49a1e92a8 100644
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

