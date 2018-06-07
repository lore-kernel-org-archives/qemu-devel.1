Received: from eggs.gnu.org ([2001:4830:134:3::10]:54665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxs-0005Vx-Hl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxo-0001hE-KR
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:52 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQzxo-0001h6-4G
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:48 -0400
Received: by mail-pl0-x233.google.com with SMTP id a7-v6so4192238plp.3
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:48:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Jun 2018 11:48:40 -0700
Message-Id: <20180607184844.30126-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] linux-user: syscall number fixes
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

Found while removing some ifdefs that should have been always true.


r~


Richard Henderson (4):
  linux-user/alpha: Fix epoll syscalls
  linux-user/hppa: Fix typo in mknodat syscall
  linux-user/microblaze: Fix typo in accept4 syscall
  linux-user/sparc64: Add inotify_rm_watch and tee syscalls

 linux-user/alpha/syscall_nr.h      | 6 +++---
 linux-user/hppa/syscall_nr.h       | 2 +-
 linux-user/microblaze/syscall_nr.h | 2 +-
 linux-user/sparc64/syscall_nr.h    | 4 ++--
 linux-user/strace.list             | 9 ---------
 5 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.17.1
