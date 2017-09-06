Received: from eggs.gnu.org ([2001:4830:134:3::10]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpew0-00046m-9p
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpevq-0006F8-Js
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:20:20 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  6 Sep 2017 19:19:54 +0100
Message-Id: <1504721995-22267-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 0/1] net: Add SunGEM device emulation as
 found on Apple UniNorth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

This is a reworking of Ben's original implementation of the SunGEM device
from last year: https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg02571.html.

The reason for implenting this device is that it allows out-of-the-box
networking for most MacOS 9 and MacOS X OSs running under qemu-system-ppc without
having to obtain any external vendor drivers.

The main changes I've made to Ben's original patch are listed below:
    - Remove sungem.h file, moving constants into sungem.c as required
    - Switch to using tracepoints for debugging
    - Split register blocks into separate memory regions
    - Use arrays in SunGEMState to hold register values
    - Add state-saving support

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2
- Fix tracepoints for trace backends outside of QEMU
- Introduce PCI_BASE_ADDRESS_SPACE_MEMORY instead of using the value 0 directly


Benjamin Herrenschmidt (1):
  net: Add SunGEM device emulation as found on Apple UniNorth

 default-configs/ppc-softmmu.mak |    1 +
 hw/net/Makefile.objs            |    1 +
 hw/net/sungem.c                 | 1447 +++++++++++++++++++++++++++++++++++++++
 hw/net/trace-events             |   44 ++
 hw/pci/pci.c                    |    2 +
 include/hw/pci/pci_ids.h        |    1 +
 6 files changed, 1496 insertions(+)
 create mode 100644 hw/net/sungem.c

-- 
1.7.10.4
