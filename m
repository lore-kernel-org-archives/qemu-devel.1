Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81D020731
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Xvoc17tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81D020731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRU6-0007Hw-QW
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iXRQI-0005jT-1t
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iXRQG-0004pi-J1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:57:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:43339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iXRQG-0004pN-9F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574261848;
 bh=ZMdaDtJ31l1fzOOpTMh47W9VQOjA8vShTS2CmlP1YOc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Xvoc17tAZjD2Lg4Z12mPWfdiZ6vLknk0VyiZPjmz/yH2ID8tSSh92E2eZoRQY9L2S
 nRmWexWGKGQ6CVnolb0iVlIaSVTjrEEEdoAnuhLgawEuopvHHRO/o88q1a1M9ZpY4I
 Tsp8QLs5MAGTaUWC5+GFIMHqFCRhtLGjFdxIUfsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.153.182]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1hxHG01frI-00aTfw; Wed, 20
 Nov 2019 15:57:28 +0100
Date: Wed, 20 Nov 2019 15:57:24 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/strace: Improve output of various syscalls
Message-ID: <20191120145724.GA15677@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:CnBMwen/9UInfXcSBswb6pL2KKVqACkuWs4R0gxcLxrE23bFrtg
 PmS/2m3blWPqheBENM+/Yu0PCR1q42K6h+hQAOR5DZSM2cqUG3d0Su47oqPulTgTmslx7p/
 mmjVO3pXhdQ5TLoXZyCLxWVf9hbb001CaAHPmMT8K9C4sjpAj3AKGw/zpl5F9Mn4Cy6M5Sw
 ebLFGc8aWg/ET97G7ID7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ddd5kg3ZpOY=:7n6fmJSZqGa5gIGHX6XgiJ
 5x36YOaRoxN+x0nmK6+CFgAyX3Rg5X9Pe53M429+vdIkfmfSROIIBDfMweEGhbvEe+T02biy/
 86Da4HYDO2POUWTlwpK0en9Z20z1XyQQMTn0JIIbok3+kbT2Kg3EYxVnUTQxgCA+dWK7Fck5l
 RkseLjm2+TWZtmrai+cUa9LsFi7CjgkTtPuuoKCYL7HDnn2Wual0AL2AL9KJlYKm8RP8kV+cc
 UTwJC8MFyHNRFKTa09PIgzixUW000iKE4l18WD0s5LBYzFeYRcS+fJxFjgXeUggrsdGr55WSE
 k8lQ0DB56b3MIWqj+UAjr97z1quGPRm32eModv9JvNBjyPZZ8DxcLl8o8kw4gbq8abR6iy+Wu
 RT63aNvqu+u6wjmV/V7gmyb8Qp+hvGs2i1+i4WN+z9FNzTGE1nKytv3HOp9YVgxtRlDaaUo3b
 Tdqrn+LBprSYiXjn3IPKkpIDeB5/bIvQPQ/rjz2bsh3jMMiWEb18zxQMldY041W+34/H5gQwy
 xDvHPWDmSwcLTApCImjdrpnlNZpJfHrAOVAW2KLWeBl3kfy0aroigTLxlU7bobC7zeIZvGCUz
 FvHQM+kpoSwbkoViB3L8TSYUaYG4rzJTPvglx4WefCiDqO+CSoOYS+ZpzmcjEfG5lmCXqfy0G
 PQe0ah8KJHHu5bgFkEvxmYKq+S4YwqmERKV7dyiRuFKCKypm9nHYToCJEd4/iiEBJJbMZ6qYm
 bFRiF06GwX6vDy5kKq5yv79iHrsK2nUYvNVaLtwCpQ3M7ondtTNhwIMhX68F0VkXM3g0d/xzF
 jIrql7GGcA5oFnLY5/y5SepG8TNepRq0Gk5M//RyZJj4k9r1nkRoaA0HSMvPKDOv++X+aqipP
 ai+XIMgJNLRlwiB5fURm2jd9xqeHCspUS67g+dyk/il3WiVCOV9tcuEo6nbMgAmuSibqbTds6
 yciv8flGLRbZTnxidzGoP9fqgPPQfxZp+Us74D9MIzfN8BAcD3gav9gDscKf3/RH3w35je6PM
 ywtv9bm/kpeTXx4VfXHNT04QNAqZ0liQg7+gJwpu47np/1sUr5EFxqmXW6qvO81k7ZH2tuvq8
 UXs7pXI+vWn2oUc3WX/d3AtA13zqDjzzvaDxUkKGKrKPDzGF2OOk0K7TVeh/kz4a76QoAjmsf
 9k1DHO6M86/nyctGFlusbq+jK+NZ2SdFvUsjyKbQp8In0Ww+u2Xwr9MFFn6/dkCcvhUg7fgI5
 sCZ/7TBloqwAN2dtp7Yz5adaReAll+FjCihqPNA==
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

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1de4319dcf..add53b1734 100644
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

