Received: from eggs.gnu.org ([2001:4830:134:3::10]:43648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6m-0006LO-Sb
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6h-0007qN-Vq
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:28 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1d9K6h-0007p1-Nj
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:23 -0400
Received: by mail-lf0-x243.google.com with SMTP id q70so1189958lfi.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:36:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 May 2017 16:36:01 -0700
Message-Id: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] target/xtensa semihosting fixes
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

this series fixes two issues in xtensa semihosting read/write calls:
incorrect direction flags used to map physical memory and incorrect
return value for requests crossing page boundary, and allows using
QEMU chardev for stdout and stderr output in semihosting mode.

Max Filippov (3):
  target/xtensa: fix mapping direction in read/write simcalls
  target/xtensa: fix return value of read/write simcalls
  target/xtensa: support output to chardev console

 hw/xtensa/sim.c             |  4 ++
 target/xtensa/cpu.h         |  1 +
 target/xtensa/xtensa-semi.c | 91 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 77 insertions(+), 19 deletions(-)

-- 
2.1.4
