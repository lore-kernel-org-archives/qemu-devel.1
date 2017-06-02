Received: from eggs.gnu.org ([2001:4830:134:3::10]:45694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dGfCr-0004Bf-Sd
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dGfCo-00060N-QY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:33:05 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34996
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dGfCo-0005yT-Iq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:33:02 -0400
Date: Fri, 2 Jun 2017 06:32:49 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170602053249.GB2366@kentang.lan>
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
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Peter,

This request contains the SPARC QOMify work which fell through the cracks during the last release.
Please pull.


ATB,

Mark.


The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f01:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31' into staging (2017-06-01 16:39:16 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 78fb261db18d3e12f68304c0d91a85e0a3bbc757:

  hw/sparc64: QOM'ify sun4u.c (2017-06-02 05:54:43 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
xiaoqiang zhao (8):
      hw/misc: QOM'ify eccmemctl.c
      hw/dma: QOM'ify sparc32_dma.c
      hw/dma: QOM'ify sun4m_iommu.c
      hw/misc: QOM'ify slavio_misc.c
      hw/timer: QOM'ify m48txx_sysbus
      hw/timer: QOM'ify slavio_timer
      hw/sparc: QOM'ify sun4m.c
      hw/sparc64: QOM'ify sun4u.c

 hw/dma/sparc32_dma.c    |   25 +++++++++++++---------
 hw/dma/sun4m_iommu.c    |   12 +++++------
 hw/misc/eccmemctl.c     |   25 ++++++++++++++--------
 hw/misc/slavio_misc.c   |   43 +++++++++++++++----------------------
 hw/sparc/sun4m.c        |   54 +++++++++++++++++------------------------------
 hw/sparc64/sun4u.c      |   20 ++++++++----------
 hw/timer/m48t59.c       |   38 ++++++++++++++++-----------------
 hw/timer/slavio_timer.c |   12 +++++------
 8 files changed, 105 insertions(+), 124 deletions(-)
