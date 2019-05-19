Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85065C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D4820644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHkRF6ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D4820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSap-0004It-D5
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:39:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYl-0002hN-Pj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYk-0003KO-Dh
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYk-0003J7-78
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id z26so6167041pfg.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=c7I7VLMb0JYuYLPfzLy2sCHy9ey83VZaUhcy01kbtg0=;
	b=BHkRF6banCqwNVQ/m5QYeWxpFqPcQzFl03d9xkOJpSisiBtv6X0p20X5tUKCRsYR+a
	1N00DUGZdCLk/tQyo+3xU/G40vtmI/l50vTt6WqgXsQnwiH3vz02fFAr6Ju9QF7EstJf
	7a+bmk45eRYpaF+bfIOaXJuoq1mFF9QOeBip7W3lH0WUVmDILjqywTZRhmoCNKwdrrc2
	2gwC/fAJ9m7JSGae8cZXCSIHdIFPzOAnzG3ysoU3/+jLnUZ11AuGGaiSH8O3vxJDN2dU
	YQ1NSH64Rh8y9rfJ354jZil+EpNa5XTd+u3olFJgWl+7MyFs+lmJme1b9n/CzGmKkHe/
	cFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=c7I7VLMb0JYuYLPfzLy2sCHy9ey83VZaUhcy01kbtg0=;
	b=uBmkTiNSv0xLhNF+OfkYsZEWf+u1W6br1DP0YFivcbyT2FsT0PymbWBFPmLzTQDU8Q
	UR3OVADDwGFLEy5I874OwoJ9gKngowCLvgc2+Xi1xB8NXbZbq+MBoqbXCL4Azz6XlnHL
	ZsfK/60zifW9exUG1qQp1d2C47/07Bnrpa0WrsTRzEb/UWbJQj5zKNE/3F+6CX1Wu0z+
	Bpq0T5wT5/pQsIWTQyAkahs60OrMOTJ3MxRU5O1SVD+pDOFwix31cxIXAVdo3jir7AWN
	IH8QX6wA2aKvi7IG6bOTlkRtK4vIdK+5a7kakph0KzbeicBAd+6teoimQ/55dD8HcOSi
	HUqg==
X-Gm-Message-State: APjAAAU1cJwbAPXm4qHcsR0Snmak/TqHHL3W1awdGNgqb9+DNk0sKr+N
	eh6loeml/a+AocX/eVJstIy7iKu7Un0=
X-Google-Smtp-Source: APXvYqwVMQD9/XYX0KDY39yODkvKQOSV7cFWWWQvif0+WlGgz//oSbKs16PGi5ltCbSWu6JQ6ayp8A==
X-Received: by 2002:a62:7796:: with SMTP id
	s144mr19051137pfc.260.1558298248193; 
	Sun, 19 May 2019 13:37:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:12 -0700
Message-Id: <20190519203726.20729-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20190519201953.20161-1-richard.henderson@linaro.org>
Aka "linux-user: path, clone, sparc, shmat fixes"

Version 6 was
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html

Since v5, I've fixed the ioctl failure that Laurent found, and
have done a few more syscalls.

I've tried to do more testing with LTP, but it's a really annoying
testsuite.  There are at least 3 tests that hang forever (before 
and after this patch set), and the host kernel's OOM handler kills
my login session, ending the test run.  This seems to be different
behaviour than I was seeing in January, when I did have test runs
that completed successfully.

OTOH, looking back at the v6 cover letter, I now see that I was
testing armhf and i386 as guests, whereas this time I was trying
aarch64 and ppc64 as guests.  32-bit guests unable to trigger the
host OOM killer?

Laurent, is there anything special that you're doing to see these
tests run to completion?


r~


Richard Henderson (74):
  linux-user: Setup split syscall infrastructure
  linux-user: Split out open, open_at
  linux-user: Share more code for open and openat
  linux-user: Tidy do_openat loop over fakes
  linux-user: Split out readlink, readlinkat
  linux-user: Split out close
  linux-user: Split out read, write
  linux-user: Reduce regpairs_aligned & target_offset64 ifdefs
  linux-user: Split out readv, writev
  linux-user: Split out pread64, pwrite64
  linux-user: Split out preadv, pwritev
  linux-user: Split out name_to_handle_at, open_by_handle_at
  linux-user: Split out ipc syscalls
  linux-user: Split out memory syscalls
  linux-user: Split out exit
  linux-user: Split out brk
  linux-user: Split out clone, fork, vfork
  linux-user: Split out wait4, waitid, waitpid
  linux-user: Implement rusage argument to waitid
  linux-user: Split out creat
  linux-user: Split out link, linkat
  linux-user: Split out unlink, unlinkat, rmdir
  linux-user: Split out execve
  linux-user: Implement execveat
  linux-user: Split out chdir
  linux-user: Split out time
  linux-user: Split out mknod, mknodat
  linux-user: Split out chmod, fchmod, fchmodat
  linux-user: Split out lseek, llseek
  linux-user: Split out getpid, getppid, getxpid
  linux-user: Split out mount
  linux-user: Split out umount, umount2
  linux-user: Split out stime
  linux-user: Split out alarm, pause
  linux-user: Split out utime, utimes, futimesat
  linux-user: Split out access, faccessat
  linux-user: Split out nice
  linux-user: Split out sync, syncfs
  linux-user: Split out kill
  linux-user: Split out rename, renameat, renameat2
  linux-user: Split out mkdir, mkdirat
  linux-user: Split out dup, dup2, dup3
  linux-user: Split out pipe, pipe2
  linux-user: Split out times
  linux-user: Split out acct
  linux-user: Move syscall_init to the end
  linux-user: Split out ioctl
  linux-user: Fix types in ioctl logging
  linux-user: Remove sentinel from ioctl_entries
  linux-user: Split out fcntl, fcntl64
  linux-user: Split out setpgid
  linux-user: Split out umask
  linux-user: Split out chroot
  linux-user: Split out getpgid, getpgrp
  linux-user: Split out getsid, setsid
  linux-user: Split out sigaction, rt_sigaction
  linux-user: Split out sgetmask, ssetmask
  linux-user: Split out sigprocmask, rt_sigprocmask
  linux-user: Split out sigpending, rt_sigpending
  linux-user: Split out sigsuspend, rt_sigsuspend
  linux-user: Split out rt_sigtimedwait
  linux-user: Split out rt_sigqueueinfo, rt_tgsigqueueinfo
  linux-user: Split out sigreturn, rt_sigreturn
  linux-user: Split out gethostname, sethostname
  linux-user: Split out getrlimit, setrlimit
  linux-user: Split out getrusage
  linux-user: Split out gettimeofday, settimeofday
  linux-user: Split out select, _newselect
  linux-user: Split out pselect6
  linux-user: Split out symlink, symlinkat
  linux-user: Split out swapon, swapoff
  linux-user: Split out reboot
  linux-user: Split out truncate, truncate64, ftruncate, ftruncate64
  linux-user: Split out getpriority, setpriority

 linux-user/syscall-defs.h      |  338 +++
 linux-user/syscall.h           |  103 +
 linux-user/strace.c            | 1569 +++-------
 linux-user/syscall-fcntl.inc.c |  322 ++
 linux-user/syscall-file.inc.c  | 1526 ++++++++++
 linux-user/syscall-ioctl.inc.c |  873 ++++++
 linux-user/syscall-ipc.inc.c   | 1088 +++++++
 linux-user/syscall-mem.inc.c   |  244 ++
 linux-user/syscall-proc.inc.c  |  758 +++++
 linux-user/syscall-sig.inc.c   |  549 ++++
 linux-user/syscall-time.inc.c  |   77 +
 linux-user/syscall.c           | 5045 ++------------------------------
 configure                      |   20 -
 linux-user/strace.list         |  414 ---
 14 files changed, 6512 insertions(+), 6414 deletions(-)
 create mode 100644 linux-user/syscall-defs.h
 create mode 100644 linux-user/syscall.h
 create mode 100644 linux-user/syscall-fcntl.inc.c
 create mode 100644 linux-user/syscall-file.inc.c
 create mode 100644 linux-user/syscall-ioctl.inc.c
 create mode 100644 linux-user/syscall-ipc.inc.c
 create mode 100644 linux-user/syscall-mem.inc.c
 create mode 100644 linux-user/syscall-proc.inc.c
 create mode 100644 linux-user/syscall-sig.inc.c
 create mode 100644 linux-user/syscall-time.inc.c

-- 
2.17.1


