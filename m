Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrH-000119-V2
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoE-00058i-JL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:23 -0400
Received: from m12-14.163.com ([220.181.12.14]:59355)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoD-00055m-W7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:22 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 03:00:52 -0700
Message-Id: <20190420100056.116305-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/4] fw_cfg_test refactor and add two test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

In the disscuss of adding reboot timeout test case:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html

Philippe suggested we should uses the only related option for one
specific test. However currently we uses one QTestState for all the
test cases. In order to achieve Philippe's idea, I split the test case
for its own QTestState. As this patchset has changed a lot, I don't bump
the version.


Li Qiang (4):
  tests: refactor fw_cfg_test
  tests: fw_cfg: add a function to get the fw_cfg file
  tests: fw_cfg: add reboot_timeout test case
  tests: fw_cfg: add splash time test case

 tests/fw_cfg-test.c   | 122 +++++++++++++++++++++++++++++++++++++++---
 tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
 tests/libqos/fw_cfg.h |   9 ++++
 3 files changed, 178 insertions(+), 8 deletions(-)

-- 
2.17.1
