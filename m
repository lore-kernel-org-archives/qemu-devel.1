Received: from eggs.gnu.org ([2001:4830:134:3::10]:53058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fqMMR-0007jp-5l
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fqMMQ-00066W-HP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:47:03 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fqMMQ-00066F-9r
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:47:02 -0400
Received: by mail-lj1-x243.google.com with SMTP id w16-v6so4312447ljh.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:47:01 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 16 Aug 2018 10:46:43 -0700
Message-Id: <20180816174645.30364-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] target/xtensa: gdbstub fixes
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

this series fixes communication between xtensa gdb and QEMU gdbstub in
the presence of TIE states mapped to user registers in the core
configuration and does a cleanup on top of it.

Max Filippov (2):
  target/xtensa: fix gdbstub register counts
  target/xtensa: clean up gdbstub register handling

 target/xtensa/cpu.h     |  2 ++
 target/xtensa/gdbstub.c | 60 +++++++++++++++++++++++++++++++++++++++----------
 target/xtensa/helper.c  | 10 +--------
 3 files changed, 51 insertions(+), 21 deletions(-)

-- 
2.11.0
