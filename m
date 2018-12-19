Received: from eggs.gnu.org ([2001:4830:134:3::10]:51221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTRd-0007vd-MD
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTMG-0006KU-B3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:25 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZTMG-0006IY-18
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:20 -0500
Received: by mail-pf1-x442.google.com with SMTP id u6so9191282pfh.11
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 20:21:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 18 Dec 2018 20:21:05 -0800
Message-Id: <20181219042113.7364-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/8] linux-user: Split do_syscall
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

Version 4 was back in August:
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03745.html

Version 5 continues the file split via inclusion.  This incorporates
Laurent's suggestion to have a "def" file that is included twice to
generate both SyscallDef structures and fill in syscall_table's switch.

Again, this just converts a few syscalls as proof of concept.


r~


Richard Henderson (8):
  linux-user: Setup split syscall infrastructure
  linux-user: Split out some simple file syscalls
  linux-user: Reduce regpairs_aligned & target_offset64 ifdefs
  linux-user: Split out preadv, pwritev, readv, writev, pread64,
    pwrite64
  linux-user: Split out name_to_handle_at, open_by_handle_at
  linux-user: Split out ipc syscalls
  linux-user: Split out memory syscalls
  linux-user: Split out some process syscalls

 linux-user/syscall-defs.h     |  231 +++
 linux-user/syscall.h          |   93 ++
 linux-user/strace.c           |  567 ++++----
 linux-user/syscall-file.inc.c |  638 +++++++++
 linux-user/syscall-ipc.inc.c  | 1086 ++++++++++++++
 linux-user/syscall-mem.inc.c  |  154 ++
 linux-user/syscall-proc.inc.c |  861 ++++++++++++
 linux-user/syscall.c          | 2500 ++-------------------------------
 linux-user/strace.list        |  243 ----
 9 files changed, 3499 insertions(+), 2874 deletions(-)
 create mode 100644 linux-user/syscall-defs.h
 create mode 100644 linux-user/syscall.h
 create mode 100644 linux-user/syscall-file.inc.c
 create mode 100644 linux-user/syscall-ipc.inc.c
 create mode 100644 linux-user/syscall-mem.inc.c
 create mode 100644 linux-user/syscall-proc.inc.c

-- 
2.17.2
