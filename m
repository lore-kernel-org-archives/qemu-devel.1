Received: from eggs.gnu.org ([2001:4830:134:3::10]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVn-0004Td-1s
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVj-0007dl-R8
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:51 -0500
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:38848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVj-0007YY-IR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:47 -0500
Received: by mail-lf0-x22b.google.com with SMTP id c188so4190589lfd.5
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:46 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:28 +0200
Message-Id: <cover.1511212753.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/15] late linux-user fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@linaro.org>

From: Riku Voipio <riku.voipio@linaro.org>

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://git.linaro.org/people/riku.voipio/qemu.git tags/pull-linux-user-20171120

for you to fetch changes up to f516511ea84d8bb3395d6ea95a7c7b80dc2a05e9:

  linux-user: Fix calculation of auxv length (2017-11-20 16:15:41 +0200)

----------------------------------------------------------------
late linux-user fixes for Qemu 2.11

----------------------------------------------------------------
Emilio G. Cota (1):
      linux-user: fix 'finshed' typo in comment

Helge Deller (5):
      linux-user/hppa: Fix TARGET_SA_* defines
      linux-user/hppa: Fix typo for TARGET_NR_epoll_wait
      linux-user/hppa: Fix TARGET_MAP_TYPE
      linux-user/hppa: Fix TARGET_F_RDLCK, TARGET_F_WRLCK, TARGET_F_UNLCK
      linux-user: Handle TARGET_MAP_STACK and TARGET_MAP_HUGETLB

James Clarke (1):
      linux-user/syscall.c: Handle SH4's exceptional alignment for p{read, write}64

James Cowgill (1):
      linux-user: return EINVAL from prctl(PR_*_SECCOMP)

Peter Maydell (5):
      linux-user/s390x: Mask si_addr for SIGSEGV
      linux-user/ppc: Report correct fault address for data faults
      linux-user/sparc: Put address for data faults where linux-user expects it
      linux-user: Handle rt_sigaction correctly for SPARC
      linux-user: Fix calculation of auxv length

Richard Henderson (2):
      linux-user: Restrict usage of sa_restorer
      linux-user/hppa: Fix cpu_clone_regs

 linux-user/elfload.c         |  11 +++++++--
 linux-user/hppa/syscall_nr.h |   2 +-
 linux-user/hppa/target_cpu.h |   4 ++++
 linux-user/main.c            |   8 +++++--
 linux-user/signal.c          |   4 ++--
 linux-user/syscall.c         | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 linux-user/syscall_defs.h    |  40 ++++++++++++++++++++++++++++++++-
 target/sparc/mmu_helper.c    |   8 +++++++
 8 files changed, 144 insertions(+), 35 deletions(-)
