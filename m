Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBE-0000wf-2S
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBA-0002p6-1i
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:43 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40025
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fvGB9-0002oy-RO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:39 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 30 Aug 2018 07:11:27 +0100
Message-Id: <20180830061129.4157-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] sun4u: generate correct fw paths for
 cmd646 IDE and virtio-blk-pci devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This patchset is the QEMU counterpart to the patches posted on the OpenBIOS
list at https://mail.coreboot.org/pipermail/openbios/2018-August/010422.html
which generate correct fw paths for the sun4u machine.

With these patches applied QEMU generates the correct fw paths for both the
in-built cmd646 IDE and virtio-blk-pci devices enabling support for bootindex
and most importantly with an updated OpenBIOS, allowing boot from
virtio-pci-blk devices.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (2):
  sabre: generate correct fw path for sabre PCI host bridge
  sun4u: implement custom FWPathProvider

 hw/pci-host/sabre.c | 12 +++++++++++
 hw/sparc64/sun4u.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
2.11.0
