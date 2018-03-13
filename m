Received: from eggs.gnu.org ([2001:4830:134:3::10]:55173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoT-0008MT-KE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoR-0007fp-0x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:13 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnoQ-0007ej-O0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:37 +0100
Message-Id: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 00/18] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac44:

  memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-03-09 15:55:20 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 8c17d862b3cefed23a62c4e09d4b3f1f04a38631:

  linux-user: init_guest_space: Add a comment about search strategy (2018-03-13 15:04:01 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (1):
  linux-user: allows to use "--systemd ALL" with qemu-binfmt-conf.sh

Luke Shumaker (9):
  linux-user: Use #if to only call validate_guest_space for 32-bit ARM
    target
  linux-user: Rename validate_guest_space => init_guest_commpage
  linux-user: init_guest_space: Clean up if we can't initialize the
    commpage
  linux-user: init_guest_space: Correctly handle guest_start in commpage
    initialization
  linux-user: init_guest_space: Clarify page alignment logic
  linux-user: init_guest_commpage: Add a comment about size check
  linux-user: init_guest_space: Clean up control flow a bit
  linux-user: init_guest_space: Don't try to align if we'll reject it
  linux-user: init_guest_space: Add a comment about search strategy

Max Filippov (5):
  linux-user: fix mmap/munmap/mprotect/mremap/shmat
  linux-user: fix assertion in shmdt
  linux-user: fix target_mprotect/target_munmap error return values
  linux-user: drop unused target_msync function
  qemu-binfmt-conf.sh: add qemu-xtensa

Peter Maydell (2):
  linux-user: Drop unicore32 code
  linux-user: Remove the unused "not implemented" signal handling stubs

Shea Levy (1):
  linux-user: Support f_flags in statfs when available.

 include/exec/cpu-all.h                |   6 +-
 include/exec/cpu_ldst.h               |  16 +-
 linux-user/elfload.c                  | 168 ++++++---------
 linux-user/main.c                     |  99 +--------
 linux-user/mmap.c                     |  43 ++--
 linux-user/qemu.h                     |   6 +-
 linux-user/signal.c                   |  32 +--
 linux-user/syscall.c                  |  18 +-
 linux-user/syscall_defs.h             |  47 ++---
 linux-user/unicore32/syscall_nr.h     | 371 ----------------------------------
 linux-user/unicore32/target_cpu.h     |  27 ---
 linux-user/unicore32/target_elf.h     |  14 --
 linux-user/unicore32/target_signal.h  |  30 ---
 linux-user/unicore32/target_structs.h |  58 ------
 linux-user/unicore32/target_syscall.h |  62 ------
 linux-user/unicore32/termbits.h       |   2 -
 scripts/qemu-binfmt-conf.sh           |  37 ++--
 17 files changed, 161 insertions(+), 875 deletions(-)
 delete mode 100644 linux-user/unicore32/syscall_nr.h
 delete mode 100644 linux-user/unicore32/target_cpu.h
 delete mode 100644 linux-user/unicore32/target_elf.h
 delete mode 100644 linux-user/unicore32/target_signal.h
 delete mode 100644 linux-user/unicore32/target_structs.h
 delete mode 100644 linux-user/unicore32/target_syscall.h
 delete mode 100644 linux-user/unicore32/termbits.h

-- 
2.14.3
