Received: from eggs.gnu.org ([2001:4830:134:3::10]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ5-0002Hx-0A
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ0-0005Sl-3M
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:00 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42812
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgPz-0005S6-Sd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:35:56 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:15 +0100
Message-Id: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 00/14] TCX/CG3 adapter cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

This started as part of the work on Gerd's thread-safe display patches
but ended up turning into something a lot more comprehensive. It contains
lots of cleanupm and fixes for display invalidation (particularly on 24-bit
TCX) exposed by testing the thread-safe patchset.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (14):
  cg3: remove TARGET_PAGE_SIZE rounding on dirty page detection
  cg3: fix up size parameter for memory_region_get_dirty()
  cg3: remove unused width and height variables
  cg3: switch to load_image_mr() and remove prom-addr hack
  tcx: alter tcx_set_dirty() to accept address and length parameters
  tcx: ensure tcx_set_dirty() also invalidates the 24-bit plane and
    cplane
  tcx: alter tcx24_check_dirty() to accept address and length
    parameters
  tcx: alter tcx24_reset_dirty() to accept address and length
    parameters
  tcx: remove page24 and cpage from tcx24_update_display()
  tcx: remove TARGET_PAGE_SIZE from tcx_update_display()
  tcx: remove TARGET_PAGE_SIZE from tcx24_update_display()
  tcx: remove primitives for non-32-bit surfaces
  tcx: use tcx_set_dirty() for accelerated ops
  tcx: switch to load_image_mr() and remove prom_addr hack

 hw/display/cg3.c |   23 ++---
 hw/display/tcx.c |  298 +++++++++++-------------------------------------------
 hw/sparc/sun4m.c |    2 -
 3 files changed, 69 insertions(+), 254 deletions(-)

-- 
1.7.10.4
