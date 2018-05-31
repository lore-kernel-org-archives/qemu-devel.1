Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNi-00056I-E6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNf-0000jP-A1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:18 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNf-0000iX-3h
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:15 -0400
Received: by mail-pf0-x241.google.com with SMTP id a20-v6so11499441pfo.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:05 -0700
Message-Id: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/6] linux-user: Reorg interp_prefix handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

Changes since v4 (2018-01-28)
  * Protect host fds from guest manipulation.
  * Rename the interp_dirfd macro to TRY_INTERP_FD
  * Add TRY_INTERP_PATH for acct, statfs, inotify_add_watch

Changes since v3 (2017-12-29)
  * Use DO/WHILE as the control construct; wrap it in a macro.
  * Introduce linux_user_path to handle the cases *at syscalls
    do not cover.

Changes since v2 (2017-12-04)
  * Use IF as the control construct instead of SWITCH.

Changes since v1 (2016-11-??)
  * Require interp_dirfd set before trying the *at path.


r~


Richard Henderson (6):
  gdbstub: Return the fd from gdbserver_start
  linux-user: Add host_fds and manipulators
  linux-user: Check is_hostfd in do_syscall
  linux-user: Check contains_hostfd in select syscalls
  linux-user: Check is_hostfd in mmap syscalls
  linux-user: Use *at functions to implement interp_prefix

 linux-user/qemu.h    |  67 ++++++
 gdbstub.c            |   5 +-
 linux-user/elfload.c |   5 +-
 linux-user/main.c    |  53 ++++-
 linux-user/syscall.c | 485 ++++++++++++++++++++++++++++++++++++-------
 5 files changed, 532 insertions(+), 83 deletions(-)

-- 
2.17.0
