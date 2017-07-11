Received: from eggs.gnu.org ([2001:4830:134:3::10]:56318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36J-0001JU-Ew
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36G-0005Ln-D4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35120
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36G-0005LE-5E
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:19 +0100
Message-Id: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] sun4u: change PCI topology to better match
 a real Ultra 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

The aim of this patchset is to bring the sun4u machine in line with a real Ultra 5
in order to resolve issues related to PCI bridge windows and interrupt routing.

The majority of the changes are designed to accommodate the simba PCI bridges on
the root PCI bus, moving the on-board devices behind busA (as well as making the NIC
a fixed on-board multi-function device as per a real Ultra 5).

Finally we mark unavailable PCI bus slots as reserved on all 3 PCI buses to ensure
that correct interrupt routing is maintained, regardless of how the command line is
configure with -device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Depends-on: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01994.html <20170707213052.13087-1-ehabkost@redhat.com>
Depends-on: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02996.html <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Depends-on: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03034.html <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (8):
  sun4u: pass PCIDevice into pci_ebus_init() instead of PCIBus
  sun4u: switch to using qdev to instantiate fw_cfg interface
  sun4u: expose fw_cfg and NVRAM on ebus PCI IO address space
  apb: fix up PCI bus nomenclature
  apb: fix endianness for APB and PCI config accesses
  apb: add busA qdev property to PBM PCI bridge
  sun4u: create single default onboard ne2k_pci NIC for machine
  sun4u: move in-built devices behind PCI bridge A

 hw/pci-host/apb.c  |   93 ++++++++++++++++++++++++++++++++++++++--------------
 hw/sparc64/sun4u.c |   52 +++++++++++++++++++++--------
 2 files changed, 107 insertions(+), 38 deletions(-)

-- 
1.7.10.4
