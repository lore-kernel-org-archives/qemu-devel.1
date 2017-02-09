Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbimA-0003FJ-B9
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbim5-000226-Er
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:18 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbim5-00021y-9K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:13 -0500
Received: by mail-it0-x244.google.com with SMTP id e137so1448277itc.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 23:04:13 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  8 Feb 2017 23:04:02 -0800
Message-Id: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 0/2] ide: ahci: fix memory leak in device unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

As the pci ahci can be hotplug and unplug, in the ahci unrealize
function it should free all the resource once allocated in the
realized function. This patchset first add cleanup function in 
core layer and then call it in the ahci unit.

Li Qiang (2):
  ide: core: add cleanup function
  ide: ahci: call cleanup function in ahci unit

 hw/ide/ahci.c             |  8 ++++++++
 hw/ide/core.c             | 21 +++++++++++++++++++++
 include/hw/ide/internal.h |  2 ++
 3 files changed, 31 insertions(+)

-- 
1.8.3.1
