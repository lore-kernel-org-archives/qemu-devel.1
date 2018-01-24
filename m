Received: from eggs.gnu.org ([2001:4830:134:3::10]:32872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eeRCN-0007x1-TT
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eeRCK-0002K3-SE
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:59:07 -0500
Received: from chuckie.co.uk ([82.165.15.123]:54745
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eeRCK-0002Ii-Ju
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:59:04 -0500
Date: Wed, 24 Jan 2018 19:58:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180124195843.dk7efcmdwoba2jtw@kentang.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

Hi Peter,

Here are the latest updates for SPARC. Please pull.


ATB,

Mark.


The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:

  Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 9a323c89102f741e3a91a42906c26186a43f379e:

  sun4u: implement power device (2018-01-24 19:46:10 +0000)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Jean-Christophe Dubois (1):
      sparc/leon3 irqmp: fix IRQ software ack

Mark Cave-Ayland (11):
      apb: split simba PCI bridge into hw/pci-bridge/simba.c
      simba: rename PBMPCIBridge and QOM types to reflect simba naming
      apb: rename APB functions to use sabre prefix
      apb: change pbm_pci_host prefix functions to use sabre_pci prefix
      apb: QOMify sabre PCI host bridge
      apb: rename QOM type from TYPE_APB to TYPE_SABRE
      sun4u: rename apb variables and constants
      apb: rename apb.c to sabre.c
      sabre: convert from SABRE_DPRINTF macro to trace-events
      sparc64: convert hw/sparc64/sparc64.c from DPRINTF macros to trace events
      sun4u: implement power device

 Makefile.objs                          |   1 +
 default-configs/sparc64-softmmu.mak    |   3 +-
 hw/intc/grlib_irqmp.c                  |  17 ++-
 hw/pci-bridge/Makefile.objs            |   2 +
 hw/pci-bridge/simba.c                  | 101 ++++++++++++
 hw/pci-host/Makefile.objs              |   2 +-
 hw/pci-host/{apb.c => sabre.c}         | 270 ++++++++++++---------------------
 hw/pci-host/trace-events               |  11 ++
 hw/sparc64/sparc64.c                   |  85 +++++------
 hw/sparc64/sun4u.c                     | 109 ++++++++++---
 hw/sparc64/trace-events                |  18 +++
 include/hw/pci-bridge/simba.h          |  38 +++++
 include/hw/pci-host/{apb.h => sabre.h} |  26 ++--
 13 files changed, 416 insertions(+), 267 deletions(-)
 create mode 100644 hw/pci-bridge/simba.c
 rename hw/pci-host/{apb.c => sabre.c} (62%)
 create mode 100644 hw/pci-host/trace-events
 create mode 100644 include/hw/pci-bridge/simba.h
 rename include/hw/pci-host/{apb.h => sabre.h} (69%)
