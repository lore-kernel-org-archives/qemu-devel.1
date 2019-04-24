Received: from eggs.gnu.org ([209.51.188.92]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002XI-84
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY4-0006iM-5m
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:57 -0400
Received: from m12-14.163.com ([220.181.12.14]:53821)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY2-0006eH-BK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:56 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 24 Apr 2019 07:06:38 -0700
Message-Id: <20190424140643.62457-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two test
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

In the disscuss of adding reboot timeout test case:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html

Philippe suggested we should uses the only related option for one
specific test. However currently we uses one QTestState for all the
test cases. In order to achieve Philippe's idea, I split the test case
for its own QTestState. As this patchset has changed a lot, I don't bump
the version.

Change since v1:
Add a patch to store the reboot_timeout as little endian
Fix the endian issue per Thomas's review

Li Qiang (5):
  tests: refactor fw_cfg_test
  tests: fw_cfg: add a function to get the fw_cfg file
  fw_cfg: reboot: store reboot-timeout as little endian
  tests: fw_cfg: add reboot_timeout test case
  tests: fw_cfg: add splash time test case

 hw/nvram/fw_cfg.c     |   4 +-
 tests/fw_cfg-test.c   | 125 +++++++++++++++++++++++++++++++++++++++---
 tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
 tests/libqos/fw_cfg.h |   9 +++
 4 files changed, 184 insertions(+), 9 deletions(-)

-- 
2.17.1
