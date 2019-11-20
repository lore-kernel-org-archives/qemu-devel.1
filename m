Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4308C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4A220726
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO9joMdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXX4R-0007w5-MN
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 15:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXX34-0006vK-FE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 15:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXX33-0003A6-0E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 15:58:02 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXX32-00039a-RI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 15:58:00 -0500
Received: by mail-ot1-x341.google.com with SMTP id l14so855963oti.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 12:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wxz9Yi5NIG16+pke0/+MmorHJlRg09lNJmYmK4j8EAs=;
 b=DO9joMdbs3Jjq7HwYK6+W/YK7gfIRlNKfsJDkNY+fjB9UdPJKFuA7KUj+GccK17Rdc
 zJogHTS4ekd+JJcqpHlpGhjLV6ONpB7yjESvBqsQO8oAvE3JyuVsjh8ClSpLC2VmxG9p
 AAfwyjXzi8ztn9XFrJfpzF7DJeI1mNT12sBCKbX/zovzjV+5ETWPHVfMfdgfNZDMsET2
 fpyo9O+1LdJj0clYAk8/vXnoGnaKR+f1L2Kfh+67iKe8l3gF4JBBOkdF2FBe41UMz8C/
 D+6JfqYbLiZ5tmrRt0ep4QQaqqFK9M6XBstuV/LQtv0kIklqGNvO0g9HJrmhEVMYGPXV
 4dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wxz9Yi5NIG16+pke0/+MmorHJlRg09lNJmYmK4j8EAs=;
 b=j3PkDc5CInhTrIhoUka1PzHKCL8O1nuAOgKcQsjcPhiG/p9HkkE89+FAsSX4pFM3K4
 AtIH9y3X4HovgBq/6XNmp/7ZPVMw/kV1BwRK9c9YbtlcMJohiyzdhmvl1UrDu13oS3kk
 XN9cp3/eIxkP3mnnVgbvuVoEqc2q1FzSmrcnTI+MbpOULcDtlZIL6wRAm+EpGOm0CpJR
 9cZgUYClxiJ+MDYDkqsAETCsTlDd0Rchl33px+9px9CUzLY2sRTm9sFW4fRt0vzKweFs
 iJMHyPZ8bsTUKqXSkXWZ7PGCL6Axu5ph+MSAo/KUknnS8HVrD/J+ucwLo16h0vjHdor4
 Q9mg==
X-Gm-Message-State: APjAAAVeVDtI7+/HQJVPa+bT0DB+0PPKV8pt/g3P8el1bWE/whH4/cq8
 h0hLyQzr4hEEiJTT83wk9S++EMFSRhCtl9VxCLQ=
X-Google-Smtp-Source: APXvYqwCF8pDX46NC+3kcAS1rrpewkqEXX/aKq8VagmUHsB7yhaotRfVyvbnc1zAu2cheM/CaymO9qnZPOxn/Rz2Y9s=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr3873529otc.295.1574283479983; 
 Wed, 20 Nov 2019 12:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20191119190405.GA23854@ls3530.fritz.box>
In-Reply-To: <20191119190405.GA23854@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 20 Nov 2019 21:57:48 +0100
Message-ID: <CAL1e-=h588BpwjRmqwfcMcPa95T5JrBC2VdKiq-u1Xyi28DwuQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 8:05 PM Helge Deller <deller@gmx.de> wrote:
>
> Improve strace output of various syscalls which either have none
> or only int-type parameters.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>

A very good patch!

It would be even better if it covered ALL syscalls either without
parameter or with all int-like parameters.

I believe this table can be very useful to you, for the purpose
of identifying such syscalls, and completing your patch:

https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

Regards,
Aleksandar


> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 1de4319dcf..5163717087 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -26,7 +26,7 @@
>  { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_alarm
> -{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
> +{ TARGET_NR_alarm, "alarm" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_aplib
>  { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
> @@ -116,13 +116,13 @@
>  { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup
> -{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
> +{ TARGET_NR_dup, "dup" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup2
> -{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
> +{ TARGET_NR_dup2, "dup2" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup3
> -{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
> +{ TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_create
>  { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
> @@ -191,7 +191,7 @@
>  { TARGET_NR_fanotify_mark, "fanotify_mark" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fchdir
> -{ TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
> +{ TARGET_NR_fchdir, "fchdir" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fchmod
>  { TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
> @@ -287,7 +287,7 @@
>  { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getegid
> -{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
> +{ TARGET_NR_getegid, "getegid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getegid32
>  { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
> @@ -299,7 +299,7 @@
>  { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getgid
> -{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getgid, "getgid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getgid32
>  { TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
> @@ -329,10 +329,10 @@
>  { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpgid
> -{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgid, "getpgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpgrp
> -{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgrp, "getpgrp" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpid
>  { TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
> @@ -432,7 +432,7 @@
>  { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ioctl
> -{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
> +{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x,%#x,%#x,%#x)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_io_destroy
>  { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
> @@ -1257,22 +1257,22 @@
>  { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsgid
> -{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid, "setfsgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsgid32
> -{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid32, "setfsgid32" , "%s(%u)" , NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsuid
> -{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsuid, "setfsuid" , "%s(%u)" , NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsuid32
>  { TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgid
> -{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid, "setgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgid32
> -{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid32, "setgid32" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgroups
>  { TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
> @@ -1296,7 +1296,7 @@
>  { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setpgid
> -{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setpgid, "setpgid" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setpgrp
>  { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
> @@ -1311,22 +1311,22 @@
>  { TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresgid
> -{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresgid, "setresgid" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresgid32
>  { TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresuid
> -{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid, "setresuid" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresuid32
> -{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid32, "setresuid32" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setreuid
> -{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid, "setreuid" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setreuid32
> -{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid32, "setreuid32" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setrlimit
>  { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
> @@ -1335,7 +1335,7 @@
>  { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setsid
> -{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
> +{ TARGET_NR_setsid, "setsid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setsockopt
>  { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
>

