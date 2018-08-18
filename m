Received: from eggs.gnu.org ([2001:4830:134:3::10]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TY-0005En-F6
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TT-00074D-Gd
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:45481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6TT-00073R-2w
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id i26-v6so4875300pfo.12
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:02 -0700
Message-Id: <20180818190118.12911-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/16] linux-user: Split do_syscall
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

Version 4 continues the split into multiple files, but for
inclusion rather than separate compilation.  This allows us
to get warnings if there are mistakes in the switch statement
that looks up the structures.


r~


Richard Henderson (16):
  linux-user: Remove DEBUG
  linux-user: Split out do_syscall1
  linux-user: Relax single exit from "break"
  linux-user: Propagate goto efault to return
  linux-user: Propagate goto unimplemented_nowarn to return
  linux-user: Propagate goto unimplemented to default
  linux-user: Propagate goto fail to return
  configure: Use -Wunused-const-variable
  linux-user: Setup split syscall infrastructure
  linux-user: Split out some simple file syscalls
  linux-user: Split out preadv, pwritev, readv, writev
  linux-user: Split out pread64, pwrite64
  linux-user: Split out name_to_handle_at, open_by_handle_at
  linux-user: Split out ipc syscalls
  linux-user: Split out memory syscalls
  linux-user: Split out some process syscalls

 linux-user/syscall.h          |  200 ++
 linux-user/strace.c           |  629 +++--
 linux-user/syscall-file.inc.c |  678 ++++++
 linux-user/syscall-ipc.inc.c  | 1085 +++++++++
 linux-user/syscall-mem.inc.c  |  185 ++
 linux-user/syscall-proc.inc.c |  909 ++++++++
 linux-user/syscall.c          | 4060 +++++++--------------------------
 configure                     |    4 +-
 linux-user/strace.list        |  261 ---
 9 files changed, 4127 insertions(+), 3884 deletions(-)
 create mode 100644 linux-user/syscall.h
 create mode 100644 linux-user/syscall-file.inc.c
 create mode 100644 linux-user/syscall-ipc.inc.c
 create mode 100644 linux-user/syscall-mem.inc.c
 create mode 100644 linux-user/syscall-proc.inc.c

-- 
2.17.1
