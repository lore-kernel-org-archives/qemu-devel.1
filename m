Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N2-0007dR-PE
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N0-0000Ur-4q
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 10 Sep 2017 15:37:31 +0100
Message-Id: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/4] ppc: migration fixes for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, lvivier@redhat.com

This is a rebase of my outstanding patches to fix migration for the Mac
g3beige and mac99 machines when using TCG. Some discussion on previous
versions of these patches can be found at:

https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00544.html
https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01114.html
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01489.html

With this patchset applied, I've been able to repeatedly execute
savevm/loadvm commands from the console when installing Darwin on g3beige
and whilst using MacOS 9.2 on mac99 with no apparent ill effects.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (4):
  ppc: change CPUPPCState access_type from int to uint8_t
  ppc: add CPU IRQ state to PPC VMStateDescription
  ppc: add CPU access_type into the migration stream
  ppc: ensure we update the decrementer value during migration

 target/ppc/cpu.h     |    4 ++--
 target/ppc/machine.c |   14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.7.10.4
