Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wh-00058w-Jp
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oV-0004JO-Q2
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:04 +0100
Message-Id: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/7] mac: generate correct fw paths for macio
 IDE and virtio-blk-pci devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This patchset is the QEMU counterpart to the patches posted on the OpenBIOS
list at https://mail.coreboot.org/pipermail/openbios/2018-August/010422.html
which generate correct fw paths for the Mac Old World and New World machines.

With these patches applied QEMU generates the correct fw paths for both the
in-built macio IDE and virtio-blk-pci devices enabling support for bootindex
and most importantly with an updated OpenBIOS, allowing boot from
virtio-pci-blk devices.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (7):
  macio: move MACIOIDEState type declarations to macio.h
  macio: add macio bus to help with fw path generation
  macio: add addr property to macio IDE object
  grackle: set device fw_name and address for correct fw path generation
  mac_oldworld: implement custom FWPathProvider
  uninorth: add ofw-addr property to allow correct fw path generation
  mac_newworld: implement custom FWPathProvider

 hw/ide/macio.c                 |  2 ++
 hw/misc/macio/macio.c          | 42 ++++++++++++++++++++++--------
 hw/pci-host/grackle.c          | 17 ++++++++++++
 hw/pci-host/uninorth.c         | 16 ++++++++++++
 hw/ppc/mac.h                   | 26 -------------------
 hw/ppc/mac_newworld.c          | 59 +++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/mac_oldworld.c          | 59 +++++++++++++++++++++++++++++++++++++++++-
 include/hw/misc/macio/macio.h  | 37 ++++++++++++++++++++++++++
 include/hw/pci-host/uninorth.h |  1 +
 9 files changed, 220 insertions(+), 39 deletions(-)

-- 
2.11.0
