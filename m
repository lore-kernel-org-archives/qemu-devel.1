Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cWBbK-0007Jo-DN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cWBbH-0005Nd-7n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:38:14 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cWBbH-0005Ki-0j
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:38:11 -0500
Received: by mail-pg0-x244.google.com with SMTP id 194so17936060pgd.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 16:38:09 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 24 Jan 2017 16:37:42 -0800
Message-Id: <1485304662-8202-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 00/14] target/xtensa updates
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

please pull the following batch of updates for target/xtensa.

The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170124-xtensa

for you to fetch changes up to 3a3c9dc4ca2eaa612cbd5d4c85d674b15eadfb02:

  target-xtensa: implement RER/WER instructions (2017-01-16 19:19:03 -0800)

----------------------------------------------------------------
target/xtensa updates:

- refactor CCOUNT/CCOMPARE (use QEMU timers instead of instruction counting);
- support icount; run target/xtensa TCG tests with icount;
- implement SMP prerequisites: static vector selection, RUNSTALL and RER/WER.

----------------------------------------------------------------
Max Filippov (14):
      target/xtensa: add static vectors selection
      target/xtensa: implement RUNSTALL
      target/xtensa: refactor CCOUNT/CCOMPARE
      target/xtensa: support icount
      target/xtensa: don't continue translation after exception
      target/xtensa: tests: run tests with icount
      target/xtensa: tests: fix timer tests
      target/xtensa: tests: replace hardcoded interrupt masks
      target/xtensa: tests: add ccount write tests
      target/xtensa: fix ICACHE/DCACHE options detection
      target/xtensa: implement MEMCTL SR
      target/xtensa: tests: add memctl test
      target/xtensa: tests: clean up interrupt tests
      target-xtensa: implement RER/WER instructions

 hw/xtensa/pic_cpu.c               |  75 +++---------
 target/xtensa/cpu.c               |  12 +-
 target/xtensa/cpu.h               |  60 ++++++++--
 target/xtensa/helper.c            |  13 ++
 target/xtensa/helper.h            |   9 +-
 target/xtensa/op_helper.c         |  73 ++++++++++--
 target/xtensa/overlay_tool.h      |  37 +++++-
 target/xtensa/translate.c         | 245 ++++++++++++++++++++++++++------------
 tests/tcg/xtensa/Makefile         |   2 +-
 tests/tcg/xtensa/test_interrupt.S |  27 +++--
 tests/tcg/xtensa/test_sr.S        |   1 +
 tests/tcg/xtensa/test_timer.S     | 105 +++++++++++-----
 12 files changed, 456 insertions(+), 203 deletions(-)

-- 
2.1.4
