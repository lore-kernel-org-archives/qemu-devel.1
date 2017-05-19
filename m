Received: from eggs.gnu.org ([2001:4830:134:3::10]:56399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dBagv-0000ZJ-4L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dBags-000604-49
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:43:09 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1dBagr-0005zv-U1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:43:06 -0400
Received: by mail-wr0-x229.google.com with SMTP id w50so9393493wrc.0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 22:43:05 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 18 May 2017 22:42:46 -0700
Message-Id: <1495172566-30938-1-git-send-email-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] xtensa semihosting fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following fixes for the target/xtensa.

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170518-xtensa

for you to fetch changes up to 4611d6e7956b4ae7c24ec2a70c3f3f46dcfa59c7:

  target/xtensa: support output to chardev console (2017-05-18 22:10:08 -0700)

----------------------------------------------------------------
target/xtensa semihosting fixes:

- fix read/write simcall mapping flags and return value;
- use -serial option to direct console output of sim machine to QEMU chardev.

----------------------------------------------------------------
Max Filippov (4):
      hw/xtensa: sim: use g_string/g_new
      target/xtensa: fix mapping direction in read/write simcalls
      target/xtensa: fix return value of read/write simcalls
      target/xtensa: support output to chardev console

 hw/xtensa/sim.c             | 14 ++++---
 target/xtensa/cpu.h         |  1 +
 target/xtensa/xtensa-semi.c | 91 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 82 insertions(+), 24 deletions(-)

-- 
Thanks.
-- Max
