Received: from eggs.gnu.org ([2001:4830:134:3::10]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMg-0006pV-Tf
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMa-0002Ej-3r
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:21 -0400
Received: from m12-12.163.com ([220.181.12.12]:34756)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMX-00027R-Pz
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:14 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sun, 28 Oct 2018 05:40:02 -0700
Message-Id: <20181028124004.30494-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/2] test: fw_cfg: add reboot-timeout test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: philmd@redhat.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

This patchset is the test case for the following patch:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05254.html

Li Qiang (2):
  tests: fw_cfg: add a function to get the fw_cfg file entry
  tests: fw_cfg: add reboot_timeout test case

 tests/fw_cfg-test.c   | 13 ++++++++++++-
 tests/libqos/fw_cfg.c | 30 ++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.17.1
