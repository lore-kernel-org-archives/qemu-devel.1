Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1e4Z-0001wL-1S
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1e4V-0003ts-UE
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:18:27 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52295
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1e4V-0003td-MT
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:18:23 -0400
Date: Fri, 21 Apr 2017 20:17:51 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170421191751.GB2434@kentang.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] qemu-sparc update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Peter,

Here is the cg3/tcx patchset which includes a lot of tidy-up and fixes several
invalidation bugs for tcx discovered whilst testing Gerd's thread-safe
patches. Please pull.


ATB,

Mark.


The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 749763864208b14f100f1f8319aeb931134430fa:

  tcx: switch to load_image_mr() and remove prom_addr hack (2017-04-21 09:02:04 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (13):
      cg3: remove TARGET_PAGE_SIZE rounding on dirty page detection
      cg3: fix up size parameter for memory_region_get_dirty()
      cg3: switch to load_image_mr() and remove prom-addr hack
      tcx: alter tcx_set_dirty() to accept address and length parameters
      tcx: ensure tcx_set_dirty() also invalidates the 24-bit plane and cplane
      tcx: alter tcx24_check_dirty() to accept address and length parameters
      tcx: alter tcx24_reset_dirty() to accept address and length parameters
      tcx: remove page24 and cpage from tcx24_update_display()
      tcx: remove TARGET_PAGE_SIZE from tcx_update_display()
      tcx: remove TARGET_PAGE_SIZE from tcx24_update_display()
      tcx: remove primitives for non-32-bit surfaces
      tcx: use tcx_set_dirty() for accelerated ops
      tcx: switch to load_image_mr() and remove prom_addr hack

 hw/display/cg3.c |   12 +--
 hw/display/tcx.c |  298 +++++++++++-------------------------------------------
 hw/sparc/sun4m.c |    2 -
 3 files changed, 65 insertions(+), 247 deletions(-)
