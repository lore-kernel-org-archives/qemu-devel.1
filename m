Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2AAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397A32243D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kWsOr/3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397A32243D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX8rW-00016l-6t
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iX8na-0008Se-9E
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iX8nR-000727-JR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:04:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:57643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iX8nO-0006yr-AX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574190249;
 bh=kLkzahoNHeHZ91perOywNEZmiiXZ7dKAGGbAAivh8og=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=kWsOr/3J2kWtkPJZAJGtLQt6pxQUI1LHRny9J2HTP2rGAxGApEBtMzmIxPoFfjW9R
 /72v5Oj+iJS+CBuJS8tvJf13bYhOtNlA9Sgm1ab9cfbItY+BQqcOFf8u5c+h8lwA92
 pHvUO4lH1Kn8qqmwwK2lRt1GyVZwK0TPn66Lm8k0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.148.64]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1iJgPW0vZP-00Wk5A; Tue, 19
 Nov 2019 20:04:09 +0100
Date: Tue, 19 Nov 2019 20:04:05 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: [PATCH] linux-user/strace: Improve output of various syscalls
Message-ID: <20191119190405.GA23854@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:kV3noUZi/+Bp5dhb/1ytgEcrmt5T2XuKsziZHuPrFzpT/G8krBt
 8W9ukjsQKQkFyr2MWxMfxnffLD9UXh0wtbgotNp8k4/4frZRNK8ulSY77FIYb4gltNmjgZL
 mEf5datZ96QUxaMtfXPHZGoAXGXDGKlT2GHbJZIVxr1yYCvveEA0QjoSpDuvPaR7H3Kt+Av
 VoklLG3P75UaULeUbhpoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:atmQCM3ZSw4=:SYSp0BLWzXlNp/6wA2R+Da
 L5xSjgGYi/QGVGZ6ic/3ixOEJEPBZkCVkTMcRO3q7fMlCwl+f4IKfykQpRTzG+obEw3q650Z4
 b7Wo7RKoI0UPIVm922szx+dDq1/a0oAQRC1vOdyJRIh7AVcF5v8QLGFiJ/yhrsasHhHECc1El
 eRQykPS9DpwmhCuNqw3fCvyo4jfJ4nZjKv79WvSnHQcuDSsT6yxlns6aajhc61dm+fpthb6Ki
 FPmESXaagueV6GPmFVLw/uro6Elg5zN8LG4DpdU17NZpd5SMZTczBocqtK/jkICg28iAQ2cJ9
 eiU6wKSMKEUNGLglIZSI278jPFGqMOw7TaNwYO7xck13Ij2Dn9QdbxJ+sRHgCnnjLRYkAZN+D
 LtRQN2rvVi5TQR6+gnhv+ATz1SGNiFsv9jeP8spmyckdHh3Qa4Dbs/E8P0AsSO+IEijwcQv4Z
 Zm5IFWwi52woNCGNDSsRj4VgEQpSfaOaOMnC3dvu0w1RzdzRoqnFMFeylbdBjtrhhBqvWFMvw
 EWuFFdITalJRqsrnW9ZcOCYJmF5jzt6WVP33wJzPC+gLh66wwHD+CsqbupQ2oozTK60a8VHpy
 Dt1j7eSm6LNAI72FFMaSzRA5Y8yji6Wn6wmEl5u80QT1yEJCsedSdycKEE5w7Maik3BtlcWvW
 N4zclf8JGDxp9w2c9P3Tngsfd2CDwYfdtG16m6jMIlvqh1He1I3mNV2bXNP6mOnRx5+jYo2RK
 8omhoMGfHwBUGbsiVP4BV3WDH1PKiNqxZRBWWcN6fcZfGrbn1so78zIdA0iFP0fAPvGcWUkOU
 F7+vDab60oyO7ZrCtsDsxlXgzwSSoHfDIBYIfiTr+IzFsUt5bW7+iKabuZnnTMtNS72ECcv0E
 J9hwRWApTBeYGEA6rWEc2Beyjn41LDHwtyD5NDIiMuqYdVRDdYa109ZQ0fmC+JEUt/N1xW0Dh
 wxzyy8adeZ9l8/+8jJeTfSi8jSuVcRHsfBTE+PFWKbcXP1Iy2ZmcWAXukK242gGENJyIC/r01
 x6adtlko7JWndl8pjOYHAS9qa0hpIVZYb/SHHYa0XoZhFH7qgk3e9+jRnRqe9qQRRjw+9vsSl
 jLDHj01VN6ERWYHxlFgcjbFa0i/A2Sc9AgloMGHiypztMWSFbE/LKwEXQoEilEdOEz6UQOqbK
 DYvY75xWkN5wtWlJilTY6okrEkkJoREFhaM+XcJ9H5tsroD0QMb9PF4BMxup12jRSOTMaegu7
 Y8rOPoDRnhQy7/zpre/FNmwKA8kcasLcps+0ZnQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve strace output of various syscalls which either have none
or only int-type parameters.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1de4319dcf..5163717087 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -26,7 +26,7 @@
 { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_alarm
-{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
+{ TARGET_NR_alarm, "alarm" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_aplib
 { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
@@ -116,13 +116,13 @@
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
 { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
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
+{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x,%#x,%#x,%#x)", NULL, NULL },
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

