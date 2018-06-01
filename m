Received: from eggs.gnu.org ([2001:4830:134:3::10]:57242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWY-0005Mx-Ji
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWU-00009E-Mq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:30:58 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWU-00008l-FB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:30:54 -0400
Received: by mail-pl0-x241.google.com with SMTP id 31-v6so4887009plc.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:30:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:17 -0700
Message-Id: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/33] linux-user: Begin splitting do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This function is, as I think everyone will agree, way too large.
This is about a third of the complete change, but I thought I'd
get some feedback on the method and form before I go any farther.


r~


Richard Henderson (33):
  linux-user: Split out do_syscall1
  linux-user: Relax single exit from "break"
  linux-user: Propagate goto ebadf to return
  linux-user: Propagate goto efault to return
  linux-user: Propagate goto unimplemented_nowarn to return
  linux-user: Split out goto unimplemented to do_unimplemented
  linux-user: Propagate goto fail to return
  linux-user: Make syscall number unsigned
  linux-user: Set up infrastructure for table-izing syscalls
  linux-user: Split out brk, close, exit, read, write
  linux-user: Split out execve
  linux-user: Split out open, openat
  linux-user: Split out name_to_handle_at
  linux-user: Split out open_to_handle_at
  linux-user: Split out creat, fork, waitid, waitpid
  linux-user: Split out link, linkat
  linux-user: Split out unlink, unlinkat
  linux-user: Split out chdir, mknod, mknodat, time, chmod
  linux-user: Remove all unimplemented entries
  linux-user: Split out getpid, getxpid, lseek
  linux-user: Split out mount, umount
  linux-user: Split out alarm, pause, stime, utime, utimes
  linux-user: Split out access, faccessat, futimesat, kill, nice, sync,
    syncfs
  linux-user: Split out rename, renameat, renameat2
  linux-user: Split out dup, mkdir, mkdirat, rmdir
  linux-user: Split out acct, pipe, pipe2, times, umount2
  linux-user: Split out ioctl
  linux-user: Split out chroot, dup2, dup3, fcntl, setpgid, umask
  linux-user: Split out getpgrp, getppid, setsid
  linux-user: Split out rt_sigaction, sigaction
  linux-user: Split out rt_sigprocmask, sgetmask, sigprocmask, ssetmask
  linux-user: Split out rt_sigpending, rt_sigsuspend, sigpending,
    sigsuspend
  linux-user: Split out rt_sigqueueinfo, rt_sigtimedwait,
    rt_tgsigqueueinfo

 linux-user/qemu.h    |    2 +-
 linux-user/syscall.c | 4651 ++++++++++++++++++++++--------------------
 2 files changed, 2394 insertions(+), 2259 deletions(-)

-- 
2.17.0
