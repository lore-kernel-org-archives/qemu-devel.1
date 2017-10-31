Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3c-0002LT-SF
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3Y-00053V-13
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:16 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3X-00051q-Q0
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:11 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so22384556wmc.1
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:51 +0100
Message-Id: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/7] linux-user fixes, mostly for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

I believe these were last posted back in March.
I must claim responsibility for not pinging earlier.


r~


Helge Deller (5):
  linux-user/hppa: Fix TARGET_SA_* defines
  linux-user/hppa: Fix typo for TARGET_NR_epoll_wait
  linux-user/hppa: Fix TARGET_MAP_TYPE
  linux-user/hppa: Fix TARGET_F_RDLCK, TARGET_F_WRLCK, TARGET_F_UNLCK
  linux-user: Handle TARGET_MAP_STACK and TARGET_MAP_HUGETLB

Richard Henderson (2):
  linux-user: Restrict usage of sa_restorer
  linux-user/hppa: Fix cpu_clone_regs

 linux-user/hppa/syscall_nr.h |  2 +-
 linux-user/hppa/target_cpu.h |  4 ++++
 linux-user/syscall_defs.h    | 40 +++++++++++++++++++++++++++++++++++++++-
 linux-user/signal.c          |  4 ++--
 linux-user/syscall.c         | 31 ++++++++++++++++++++-----------
 5 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.13.6
