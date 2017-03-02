Received: from eggs.gnu.org ([2001:4830:134:3::10]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNf0-0003Wv-8A
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNet-0007eN-NR
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:32 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cjNet-0007dw-Hr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:27 -0500
Received: by mail-pf0-x243.google.com with SMTP id x66so6337257pfb.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:08:26 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  2 Mar 2017 02:08:10 -0800
Message-Id: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 0/3] ide: ahci: fix memory leak in device unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

As the pci ahci can be hotplug and unplug, in the ahci unrealize
function it should free all the resource once allocated in the
realized function. This patchset first add cleanup function in
core layer and then call it in the ahci unit.

Li Qiang (3):
  ide: qdev: register ide bus unrealize function
  ide: core: add cleanup function
  ide: ahci: call cleanup function in ahci unit

 hw/ide/ahci.c             | 12 ++++++++++++
 hw/ide/core.c             |  8 ++++++++
 hw/ide/qdev.c             | 12 ++++++------
 include/hw/ide/internal.h |  1 +
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
1.8.3.1
