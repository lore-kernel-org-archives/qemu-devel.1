Received: from eggs.gnu.org ([2001:4830:134:3::10]:57384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMPA-0005R6-9S
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMP7-0004UA-7U
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:04 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Tue, 31 Jul 2018 06:36:33 +0200
Message-Id: <20180731043635.9802-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH 0/2] sam460ex: Improve logicial or'ed PCI-X
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, balaton@eik.bme.hu

The previous change 70a8ff3fd0c27e69a598e7603112de9d0fec5380 fixed
the interrupt connection not properly as the IRQ levels would not
be logcical or'ed. While other PCI cards already have worked with
that change, it didn't model the expected hardware behaviour
close enough.

This patch series is an attempt to fix this remaining problem.
Firtsly, it introduces the num-irqs property to the pci-xbus class
and implements the one common IRQ as a special case. The PCI bus
implementation logic will handle the logical or for us then.

Secondly, it adjust the sam460ex code to take advantage of the
new property.

Tested on the SAM460ex machine (which admittely is the only user
so far).

Sebastian Bauer (2):
  ppc: Allow clients of the 440 pcix bus to specify the number of
    interrupts
  sam460ex: Create the PCI-X bus with only one interrupt

 hw/ppc/ppc440_pcix.c | 28 +++++++++++++++++++++++++---
 hw/ppc/sam460ex.c    | 14 ++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.18.0
