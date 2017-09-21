Received: from eggs.gnu.org ([2001:4830:134:3::10]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duwH4-00083j-B4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duwGz-0007ec-G6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:51:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60788
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1duwGz-0007eN-8r
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:51:49 -0400
Date: Thu, 21 Sep 2017 08:51:34 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170921075134.GB19099@kentang.lan>
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

This contains the code for the new Sun HME (Happy Meal Ethernet) card and switches the sun4u machine
over to use it as the default. Please pull.


ATB,

Mark.


The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 8d9329719cc0996e5837fb466ca4d7be8030f8c9:

  sun4u: use sunhme as default on-board NIC (2017-09-21 08:38:42 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (2):
      net: add Sun HME (Happy Meal Ethernet) on-board NIC
      sun4u: use sunhme as default on-board NIC

 default-configs/sparc64-softmmu.mak |    1 +
 hw/net/Makefile.objs                |    1 +
 hw/net/sunhme.c                     |  978 +++++++++++++++++++++++++++++++++++
 hw/net/trace-events                 |   29 ++
 hw/sparc64/sun4u.c                  |   25 +-
 include/hw/net/mii.h                |    4 +
 include/hw/pci/pci_ids.h            |    1 +
 7 files changed, 1035 insertions(+), 4 deletions(-)
 create mode 100644 hw/net/sunhme.c
