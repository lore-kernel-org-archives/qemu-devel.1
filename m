Received: from eggs.gnu.org ([2001:4830:134:3::10]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqch-0001VH-8w
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqce-00035M-6T
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:31 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqcd-000358-TV
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:28 -0400
Received: by mail-pf0-x236.google.com with SMTP id y5-v6so7582693pfn.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:32 -1000
Message-Id: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 000/108] linux-user: Split do_syscall
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

* Changed the table into a switch, for the reason documented.
  Use macros to actually enter the syscall into the switch.
* Finish the split.
* Fix some bugs along the way.

I know it's a huge patch set, but I guess it was always going
to be in order to finish -- it was a stupidly large function.


r~


Richard Henderson (108):
  linux-user: Remove DEBUG
  linux-user: Split out do_syscall1
  linux-user: Relax single exit from "break"
  linux-user: Propagate goto efault to return
  linux-user: Propagate goto unimplemented_nowarn to return
  linux-user: Propagate goto unimplemented to default
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
  linux-user: Split out rt_sigreturn, sethostname, setrlimit, sigreturn
  linux-user: Split out getrlimit, getrusage, gettimeofday, settimeofday
  linux-user: Split out select, pselect6, newselect
  linux-user: Split out symlink, symlinkat
  linux-user: Split out readlink, readlinkat
  linux-user: Split out mmap, mmap2, reboot, swapon
  linux-user: Split out mprotect, mremap, msync, munmap
  linux-user: Split out mlock, mlockall, munlock, munlockall
  linux-user: Split out fchmod, fchmodat, ftruncate, truncate
  linux-user: Split out fstatfs, fstatfs64, statfs, statfs64
  linux-user: Split out getpriority, setpriority
  linux-user: Split out socketcall
  linux-user: Split out accept, accept4, bind, connect
  linux-user: Split out 7 syscalls
  linux-user: Split out recvmmsg, send, sendmmsg, sendmsg, sendto
  linux-user: Split out getrandom, shutdown, setsockopt, socket,
    socketpair
  linux-user: Fix stub gettid
  linux-user: Split out getitimer, setitimer, syslog
  linux-user: Split out fstat, lstat, stat
  linux-user: Unwrap TARGET_NR_syscall early
  linux-user: Split out swapoff, sysinfo, vhangup, wait4
  linux-user: Split out ipc
  linux-user: Split out ipc syscalls
  linux-user: Split out clone, exit_group, fsync
  linux-user: Split out modify_ldt, setdomainname, uname
  linux-user: Split out adjtimex, clock_adjtime, vm86
  linux-user: Split out fchdir, getpgid, llseek, personality
  linux-user: Split out getdents, getdents64
  linux-user: Split out poll, ppoll
  linux-user: Split out flock, preadv, pwritev, readv, writev
  linux-user: Split out fdatasync, getsid, _sysctl
  linux-user: Split out sched syscalls
  linux-user: Split out getcpu, nanosleep, prctl
  linux-user: Split out arch_prctl
  linux-user: Split out getcwd, pread64, pwrite64, sigaltstack
  linux-user: Split out capget, capset
  linux-user: Split out sendfile, sendfile64
  linux-user: Split out ftruncate64, truncate64, ugetrlimit, vfork
  linux-user: Split out fstat64, fstatat64, newfstatat, lstat64, stat64
  linux-user: Split out getegid, geteuid, getgid, getuid, lchown
  linux-user: Split out getgroups, setgroups, setregid, setreuid
  linux-user: Split out fchown, fchownat, setresgid, setresuid
  linux-user: Split out chown, getresgid, getresuid
  linux-user: Split out setfsgid, setfsuid, setgid, setuid
  linux-user: Split out getuid32, getxgid, getxuid, lchown32
  linux-user: Split out osf_getsysinfo, osf_setsysinfo, osf_sigprocmask
  linux-user: Split out getegid32, geteuid32, getgid32, setregid32,
    setreuid32
  linux-user: Split out fchown32, getgroups32, setgroups32
  linux-user: Split out getresgid32, getresuid32, setresgid32,
    setresuid32
  linux-user: Split out chown32, setfsgid32, setfsuid32, setgid32,
    setuid32
  linux-user: Split out mincore
  linux-user: Split out fadvise64, fadvise64_64
  linux-user: Split out cacheflush, fcntl64, getpagesize, madvise
  linux-user: Split out gettid, readahead
  linux-user: Split out xattr syscalls
  linux-user: Split out getdomainname, get_thread_area, set_thread_area
  linux-user: Split out clock syscalls
  linux-user: Fix clock_nanosleep
  linux-user: Split out set_tid_address, tgkill, tkill
  linux-user: Split out futex, utimensat
  linux-user: Remove sys_futex
  linux-user: Split out inotify syscalls
  linux-user: Split out mq syscalls
  linux-user: Split out splice, tee, vmsplice
  linux-user: Split out eventfd, eventfd2
  linux-user: Split out fallocate, sync_file_range/2
  linux-user: Split out signalfd, signalfd4
  linux-user: Split out epoll syscalls
  linux-user: Split out prlimit64
  linux-user: Split out atomic_barrier, gethostname
  linux-user: Split out atomic_cmpxchg_32
  linux-user: Split out timer syscalls
  linux-user: Split out timerfd syscalls
  linux-user: Split out ioprio_get, ioprio_set, kcmp
  linux-user: Split out setns, unshare
  linux-user: Fold away do_syscall1

 linux-user/qemu.h    |     2 +-
 linux-user/syscall.c | 11826 +++++++++++++++++++++++------------------
 2 files changed, 6526 insertions(+), 5302 deletions(-)

-- 
2.17.1
