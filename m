Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBBC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC22173E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMPtZYwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTKVx-0002ap-G5
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 02:14:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTKTZ-0000f7-Ve
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTKTY-00006S-0o
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTKTX-00005y-Ql
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:11:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id u199so718788oie.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=ReE5oeqA1/M05q4THKe6Ey+GCoNHwlVVghSDMkfAoeo=;
	b=QMPtZYwk8DkZ2Qk/uZtP2pUQm0Y7JKIteguSr4TIBGoBgOvvLW7vbSBNS8GPNKDEAp
	mmDDc9vxGoom6w7a+KINTvcoW0Ba/Ps4hWwG/jKYAkJZfUo1kHEllbd/8ddovR5HXVEV
	sELBhH/6XdmWHZ+23yZQ/GC52Nq4MbeXf22zWd6hlW8elKnZ2UFiR+vTM/RtdvePG/Bx
	fQqI1SjeELNRTkVNFO9cOR79dmcXMp7+zibuRcIwcZ7gCtNIk+ZGsTLEWR/1nJWSZB+R
	m8dcFqO2rjlhclYpZcajGILAtQw7+IFqLlncpwPglymqUrFl9MPIKZunk53qMes6cUhr
	eBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=ReE5oeqA1/M05q4THKe6Ey+GCoNHwlVVghSDMkfAoeo=;
	b=Terl2S1nsY1H0dox4B0UrgGPnucne2K4DEn2UlvVm4Kay/lleWARcrNupwkLcaBVY4
	lDCsH5L6+ZFYoxLHOtsjKoRv9mIaBddA2tvLw9bFqRkxEFq4ClyqFiYDwhiYd5yMv3PL
	4Y/yNzPv0ITRVllOWzu/O0eNxTWJgxrVahMuX+MEuviJr1om6IfRELOsz+X9cUci/w6s
	a+B27OUK9xKkS3munN27rLlrnFiLnTorw0yNQlnZtD2nf2uEKQlilL+0FEyOQA3Gc2cD
	ezySMG25TZygLaDWHj93pyquw7TQuiS1twrmXqpAz0HmT8TdfBUctI3Ce9M4KYnDJLhy
	1bOw==
X-Gm-Message-State: APjAAAUicMs1mT6qc0Ci/WBwLeqG+D8l7jFTgtZ/mdYsnM8SQXSKQfr8
	Q3ja4pyGjqrCbDhoQADxHdSloUCFag5iegdWMT4=
X-Google-Smtp-Source: APXvYqw9uAWvhf/BZ09JwTi8sIQAfNh7HdU3Z4nO+KlAOz7/Bm6IErQnIioCG4X4OZ3x7/GioIWg4McxjY79a0UVGGk=
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr3229314oif.79.1558505502816; 
	Tue, 21 May 2019 23:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 23:11:42
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 23:11:42
	-0700 (PDT)
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 22 May 2019 08:11:42 +0200
Message-ID: <CAL1e-=hd+nuZmKms9AmCn8B4UqJ1M3D8A=WvbaM-UwpumkD4vQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 19, 2019 10:38 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> Based-on: <20190519201953.20161-1-richard.henderson@linaro.org>
> Aka "linux-user: path, clone, sparc, shmat fixes"
>
> Version 6 was
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html
>
> Since v5, I've fixed the ioctl failure that Laurent found, and
> have done a few more syscalls.
>
> I've tried to do more testing with LTP, but it's a really annoying
> testsuite.  There are at least 3 tests that hang forever (before
> and after this patch set), and the host kernel's OOM handler kills
> my login session, ending the test run.  This seems to be different
> behaviour than I was seeing in January, when I did have test runs
> that completed successfully.
>
> OTOH, looking back at the v6 cover letter, I now see that I was
> testing armhf and i386 as guests, whereas this time I was trying
> aarch64 and ppc64 as guests.  32-bit guests unable to trigger the
> host OOM killer?
>
> Laurent, is there anything special that you're doing to see these
> tests run to completion?
>

On surface, this series looks to be a refactoring series. However, this is
not the case: burried in various patches, are removals of some features
visible to the end user. Can you please list all such cases in the cover
letter, so that they can be easier identified and evaluated by reviewers?

Thanks,
Aleksandar

>
> r~
>
>
> Richard Henderson (74):
>   linux-user: Setup split syscall infrastructure
>   linux-user: Split out open, open_at
>   linux-user: Share more code for open and openat
>   linux-user: Tidy do_openat loop over fakes
>   linux-user: Split out readlink, readlinkat
>   linux-user: Split out close
>   linux-user: Split out read, write
>   linux-user: Reduce regpairs_aligned & target_offset64 ifdefs
>   linux-user: Split out readv, writev
>   linux-user: Split out pread64, pwrite64
>   linux-user: Split out preadv, pwritev
>   linux-user: Split out name_to_handle_at, open_by_handle_at
>   linux-user: Split out ipc syscalls
>   linux-user: Split out memory syscalls
>   linux-user: Split out exit
>   linux-user: Split out brk
>   linux-user: Split out clone, fork, vfork
>   linux-user: Split out wait4, waitid, waitpid
>   linux-user: Implement rusage argument to waitid
>   linux-user: Split out creat
>   linux-user: Split out link, linkat
>   linux-user: Split out unlink, unlinkat, rmdir
>   linux-user: Split out execve
>   linux-user: Implement execveat
>   linux-user: Split out chdir
>   linux-user: Split out time
>   linux-user: Split out mknod, mknodat
>   linux-user: Split out chmod, fchmod, fchmodat
>   linux-user: Split out lseek, llseek
>   linux-user: Split out getpid, getppid, getxpid
>   linux-user: Split out mount
>   linux-user: Split out umount, umount2
>   linux-user: Split out stime
>   linux-user: Split out alarm, pause
>   linux-user: Split out utime, utimes, futimesat
>   linux-user: Split out access, faccessat
>   linux-user: Split out nice
>   linux-user: Split out sync, syncfs
>   linux-user: Split out kill
>   linux-user: Split out rename, renameat, renameat2
>   linux-user: Split out mkdir, mkdirat
>   linux-user: Split out dup, dup2, dup3
>   linux-user: Split out pipe, pipe2
>   linux-user: Split out times
>   linux-user: Split out acct
>   linux-user: Move syscall_init to the end
>   linux-user: Split out ioctl
>   linux-user: Fix types in ioctl logging
>   linux-user: Remove sentinel from ioctl_entries
>   linux-user: Split out fcntl, fcntl64
>   linux-user: Split out setpgid
>   linux-user: Split out umask
>   linux-user: Split out chroot
>   linux-user: Split out getpgid, getpgrp
>   linux-user: Split out getsid, setsid
>   linux-user: Split out sigaction, rt_sigaction
>   linux-user: Split out sgetmask, ssetmask
>   linux-user: Split out sigprocmask, rt_sigprocmask
>   linux-user: Split out sigpending, rt_sigpending
>   linux-user: Split out sigsuspend, rt_sigsuspend
>   linux-user: Split out rt_sigtimedwait
>   linux-user: Split out rt_sigqueueinfo, rt_tgsigqueueinfo
>   linux-user: Split out sigreturn, rt_sigreturn
>   linux-user: Split out gethostname, sethostname
>   linux-user: Split out getrlimit, setrlimit
>   linux-user: Split out getrusage
>   linux-user: Split out gettimeofday, settimeofday
>   linux-user: Split out select, _newselect
>   linux-user: Split out pselect6
>   linux-user: Split out symlink, symlinkat
>   linux-user: Split out swapon, swapoff
>   linux-user: Split out reboot
>   linux-user: Split out truncate, truncate64, ftruncate, ftruncate64
>   linux-user: Split out getpriority, setpriority
>
>  linux-user/syscall-defs.h      |  338 +++
>  linux-user/syscall.h           |  103 +
>  linux-user/strace.c            | 1569 +++-------
>  linux-user/syscall-fcntl.inc.c |  322 ++
>  linux-user/syscall-file.inc.c  | 1526 ++++++++++
>  linux-user/syscall-ioctl.inc.c |  873 ++++++
>  linux-user/syscall-ipc.inc.c   | 1088 +++++++
>  linux-user/syscall-mem.inc.c   |  244 ++
>  linux-user/syscall-proc.inc.c  |  758 +++++
>  linux-user/syscall-sig.inc.c   |  549 ++++
>  linux-user/syscall-time.inc.c  |   77 +
>  linux-user/syscall.c           | 5045 ++------------------------------
>  configure                      |   20 -
>  linux-user/strace.list         |  414 ---
>  14 files changed, 6512 insertions(+), 6414 deletions(-)
>  create mode 100644 linux-user/syscall-defs.h
>  create mode 100644 linux-user/syscall.h
>  create mode 100644 linux-user/syscall-fcntl.inc.c
>  create mode 100644 linux-user/syscall-file.inc.c
>  create mode 100644 linux-user/syscall-ioctl.inc.c
>  create mode 100644 linux-user/syscall-ipc.inc.c
>  create mode 100644 linux-user/syscall-mem.inc.c
>  create mode 100644 linux-user/syscall-proc.inc.c
>  create mode 100644 linux-user/syscall-sig.inc.c
>  create mode 100644 linux-user/syscall-time.inc.c
>
> --
> 2.17.1
>
>
