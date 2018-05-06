Received: from eggs.gnu.org ([2001:4830:134:3::10]:41923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWd-0004q2-FB
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWY-0008MM-CH
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  6 May 2018 15:20:01 +0100
Message-Id: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/4] uninorth/macio: minor fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here is another set of uninorth/macio fixups from various working branches
in my QEMU git repository.

Patch 1 adds min_access_size/max_access_size to unin_ops as suggested by
David when reviewing my last set of uninorth patches.

Patch 2 adds trace-events to the macio timer device in order to help debug
some timer issues I've been working on.

In a similar manner to patch 1, patch 3 adds the same min_access_size/max_access_size
fields to the macio timer device (this agrees with a similar change in Ben's PMU
branch).

Finally patch 4 removes the uninorth token register hack, replacing it instead
with a single read-only version register as determined from looking at various
Darwin/Linux/BSD sources.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (4):
  uninorth: add impl min_access_size and max_access_size to unin_ops
  macio: add trace-events to timer device
  macio: add impl min_access_size and max_access_size to timer_ops
  uninorth: remove token register from uninorth device

 hw/misc/macio/macio.c          |  7 +++++++
 hw/misc/macio/trace-events     |  4 ++++
 hw/pci-host/uninorth.c         | 15 +++++++++------
 include/hw/pci-host/uninorth.h |  4 +++-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.11.0
