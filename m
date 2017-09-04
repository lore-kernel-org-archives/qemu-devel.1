Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dovXN-0003ZP-5r
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dovXI-0002f8-BX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:51:53 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41269
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dovXI-0002a8-4Q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:51:48 -0400
Date: Mon, 4 Sep 2017 18:51:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170904175101.GA27187@kentang.lan>
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

Here is the first patchset in preparation for updating the sun4u machine PCI topology. Please pull.


ATB,

Mark.
 

The following changes since commit 2b483739791b33c46e6084b51edcf62107058ae1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170904-2' into staging (2017-09-04 17:21:24 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to e5fd1eb05ec918e9877640d85ec45680cf106632:

  apb: add busA qdev property to PBM PCI bridge (2017-09-04 18:41:01 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (6):
      sun4u: pass PCIDevice into pci_ebus_init() instead of PCIBus
      sun4u: switch to using qdev to instantiate fw_cfg interface
      sun4u: expose fw_cfg and NVRAM on ebus PCI IO address space
      apb: fix up PCI bus nomenclature
      apb: fix endianness for APB and PCI config accesses
      apb: add busA qdev property to PBM PCI bridge

 hw/pci-host/apb.c  |   62 +++++++++++++++++++++++++++++++++++++---------------
 hw/sparc64/sun4u.c |   27 ++++++++++++++---------
 2 files changed, 61 insertions(+), 28 deletions(-)
