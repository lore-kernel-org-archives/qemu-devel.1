Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXQ-0004vB-4O
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXN-0007C2-3d
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:56 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:44558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXM-0007BM-Rf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:53 -0400
Received: by mail-pl0-x22b.google.com with SMTP id z9-v6so13317337plk.11
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:26 -1000
Message-Id: <20180612005145.3375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/19] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

Version 3 does not attempt the whole thing in one go,
and does attempt to incorporate strace into the reorg.

Thoughts?


r~


Richard Henderson (19):
  linux-user/alpha: Fix epoll syscalls
  linux-user/hppa: Fix typo in mknodat syscall
  linux-user/microblaze: Fix typo in accept4 syscall
  linux-user/sparc64: Add inotify_rm_watch and tee syscalls
  linux-user: Remove DEBUG
  linux-user: Split out do_syscall1
  linux-user: Relax single exit from "break"
  linux-user: Propagate goto efault to return
  linux-user: Propagate goto unimplemented_nowarn to return
  linux-user: Propagate goto unimplemented to default
  linux-user: Propagate goto fail to return
  linux-user: Setup split syscall infrastructure
  linux-user: Split out close, open, openat, read, write
  linux-user: Split out preadv, pwritev, readv, writev
  linux-user: Split out pread64, pwrite64
  linux-user: Split out name_to_handle_at, open_by_handle_at
  linux-user: Split out ipc syscalls
  linux-user: Split out memory syscalls
  linux-user: Split out some process syscalls

 linux-user/alpha/syscall_nr.h      |    6 +-
 linux-user/hppa/syscall_nr.h       |    2 +-
 linux-user/microblaze/syscall_nr.h |    2 +-
 linux-user/sparc64/syscall_nr.h    |    4 +-
 linux-user/syscall.h               |  389 +++
 linux-user/strace.c                |  600 ++---
 linux-user/syscall.c               | 4015 ++++------------------------
 linux-user/syscall_file.c          |  669 +++++
 linux-user/syscall_ipc.c           | 1095 ++++++++
 linux-user/syscall_mem.c           |  190 ++
 linux-user/syscall_proc.c          |  914 +++++++
 linux-user/Makefile.objs           |   17 +-
 linux-user/gen_syscall_list.py     |  160 ++
 linux-user/strace.list             |  264 --
 14 files changed, 4300 insertions(+), 4027 deletions(-)
 create mode 100644 linux-user/syscall.h
 create mode 100644 linux-user/syscall_file.c
 create mode 100644 linux-user/syscall_ipc.c
 create mode 100644 linux-user/syscall_mem.c
 create mode 100644 linux-user/syscall_proc.c
 create mode 100644 linux-user/gen_syscall_list.py

-- 
2.17.1
