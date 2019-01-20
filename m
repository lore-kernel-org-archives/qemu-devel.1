Received: from eggs.gnu.org ([209.51.188.92]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Jj-0004f2-AW
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Ji-0004Ny-Lu
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:51 -0500
Received: from m12-15.163.com ([220.181.12.15]:59391)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Jh-0004LT-4b
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:50 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 19 Jan 2019 23:13:35 -0800
Message-Id: <20190120071337.55595-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/2] tests: fw_cfg: add reboot-timeout test case
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

The first patch adds a util function to get 
the fw_cfg file entry.
And second adds a reboot-timeout test case.

Li Qiang (2):
  tests: fw_cfg: add a function to get the fw_cfg file entry
  tests: fw_cfg: add reboot_timeout test case

 tests/fw_cfg-test.c   | 13 ++++++++++++-
 tests/libqos/fw_cfg.c | 33 +++++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 3 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.17.1
