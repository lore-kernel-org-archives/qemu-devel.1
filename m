Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxB-00008H-0H
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxA-00060R-Bh
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:52 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gOvxA-0005xI-4Z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:52 -0500
Received: by mail-lf1-x141.google.com with SMTP id p86so253036lfg.5
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 18:39:51 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 19 Nov 2018 18:39:32 -0800
Message-Id: <20181120023934.8552-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] target/xtensa fixes for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

the following two patches fix gdbserver register counting for xtensa-softmmu
and xtensa-linux and drops explicit register counters from DC232B and DC233C
core configurations.

Max Filippov (2):
  target/xtensa: gdbstub fix register counting
  target/xtensa: drop num_[core_]regs from dc232b/dc233c configs

 target/xtensa/core-dc232b.c                |  2 --
 target/xtensa/core-dc232b/gdb-config.inc.c |  1 +
 target/xtensa/core-dc233c.c                |  2 --
 target/xtensa/core-dc233c/gdb-config.inc.c |  1 +
 target/xtensa/gdbstub.c                    | 11 ++++++++---
 5 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.11.0
