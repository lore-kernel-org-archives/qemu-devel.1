Received: from eggs.gnu.org ([209.51.188.92]:53528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJq-0006mq-2g
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000Ow-AM
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:41 +0000
Message-Id: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 00/17] target/ppc: convert instructions to use
 TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Now that all the pre-requisite patches and bugfixes have been merged, here is
the remainder of Richard's "tcg, target/ppc vector improvements" patchset that
converts various PPC VMX/VSX instructions over to use TCG vector operations.

Compared to the original posted patchset I've made a few minor changes:
  - A fix to the boffs calculation for little-endian hosts in patch 4
    (already reported and fixed on-list)
  - A formatting fix to patch 8 to keep checkpatch happy
  - Added David's A-B tags from the original series

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  target/ppc: convert VMX logical instructions to use vector operations
  target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
    vector operations

Richard Henderson (15):
  target/ppc: convert vspltis[bhw] to use vector operations
  target/ppc: convert vsplt[bhw] to use vector operations
  target/ppc: convert VSX logical operations to vector operations
  target/ppc: convert xxspltib to vector operations
  target/ppc: convert xxspltw to vector operations
  target/ppc: convert xxsel to vector operations
  target/ppc: Pass integer to helper_mtvscr
  target/ppc: Use helper_mtvscr for reset and gdb
  target/ppc: Remove vscr_nj and vscr_sat
  target/ppc: Add helper_mfvscr
  target/ppc: Use mtvscr/mfvscr for vmstate
  target/ppc: Add set_vscr_sat
  target/ppc: Split out VSCR_SAT to a vector field
  target/ppc: convert vadd*s and vsub*s to vector operations
  target/ppc: convert vmin* and vmax* to vector operations

 target/ppc/arch_dump.c              |   3 +-
 target/ppc/cpu.h                    |   6 +-
 target/ppc/helper.h                 |  57 ++------
 target/ppc/int_helper.c             | 129 +++++-------------
 target/ppc/machine.c                |  44 ++++++-
 target/ppc/translate.c              |   1 +
 target/ppc/translate/vmx-impl.inc.c | 251 +++++++++++++++++++-----------------
 target/ppc/translate/vsx-impl.inc.c | 147 +++++++++------------
 target/ppc/translate_init.inc.c     |   7 +-
 9 files changed, 290 insertions(+), 355 deletions(-)

-- 
2.11.0
