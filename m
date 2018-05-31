Received: from eggs.gnu.org ([2001:4830:134:3::10]:35032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2k-0007CQ-2w
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2g-0004Bj-Vk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:30 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOF2g-0004Au-GS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:26 -0400
Received: by mail-pf0-x241.google.com with SMTP id h12-v6so162386pfk.11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 21:18:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 30 May 2018 21:18:20 -0700
Message-Id: <20180531041822.5761-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] linux-user openrisc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, shorne@gmail.com

Both of these fixes are required to fix g++ unwinding tests.


r~


Richard Henderson (2):
  linux-user: Implement signals for openrisc
  linux-user: Fix struct sigaltstack for openrisc

 linux-user/openrisc/target_signal.h  |   2 +-
 linux-user/openrisc/target_syscall.h |  23 +--
 linux-user/openrisc/signal.c         | 210 +++++++++++----------------
 linux-user/signal.c                  |   2 +-
 target/openrisc/cpu.c                |   1 +
 5 files changed, 88 insertions(+), 150 deletions(-)

-- 
2.17.0
