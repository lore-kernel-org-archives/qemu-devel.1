Received: from eggs.gnu.org ([2001:4830:134:3::10]:54508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30B-0006yo-5X
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG307-00027j-65
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50662 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gG306-0001ET-UO
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:11 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 16:21:01 +0200
Message-Id: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/6] target/mips: Add support for prctl()
 PR_GET_FP_MODE and PR_SET_FP_MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

This series includes support for prctl() PR_GET_FP_MODE and PR_SET_FP_MODE. This requires
extracting MIPS.abiflags section from ELF file and fp_abi value handling.

Stefan Markovic (6):
  Define MIPS_ABI_FP_UNKNOWN macro
  Extend image_info struct with MIPS specific fp_abi and    
    interp_fp_abi fields
  Extract MIPS abiflags from ELF file
  Read and set FP ABI value from MIPS abiflags
  Determine the desired FPU mode
  Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE implementations

 include/elf.h                      |  2 +
 linux-user/elfload.c               | 37 +++++++++++++++++++
 linux-user/mips/cpu_loop.c         | 75 ++++++++++++++++++++++++++++++++++++++
 linux-user/mips/target_syscall.h   |  2 +
 linux-user/mips64/target_syscall.h |  2 +
 linux-user/qemu.h                  |  4 ++
 linux-user/syscall.c               | 62 +++++++++++++++++++++++++++++--
 7 files changed, 180 insertions(+), 4 deletions(-)

-- 
1.9.1
