Received: from eggs.gnu.org ([2001:4830:134:3::10]:43942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutP-0005KU-Bw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutL-0001wc-Dp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKutL-0001wG-7v
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 20:06:24 -0300
Message-Id: <20170613230627.17942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] device-crash-test: New mode for testing
 -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

This series extends the device-crash-test script so it can test
backend objects, too.  The new mode can be enabled using the "-O"
option.

The script already found a crash using the following command-line:

  $ qemu-system-x86_64 -S -machine none -object colo-compare,id=test-object
  (qemu-system-x86_64:3812): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop != NULL' failed
  Segmentation fault (core dumped)

Eduardo Habkost (3):
  scripts/qmp: Accept timeout parameter on accept()
  scripts/qemu: Catch QEMU exit while waiting for QMP client
  device-crash-test: Mode for testing -object

 scripts/qemu.py           |  14 ++++++-
 scripts/qmp/qmp.py        |   4 +-
 scripts/device-crash-test | 101 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 89 insertions(+), 30 deletions(-)

-- 
2.11.0.259.g40922b1
