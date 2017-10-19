Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e54nX-0007fM-QB
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e54nU-0001mt-LT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:59:19 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45339
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e54nU-0001cN-FF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:59:16 -0400
Date: Thu, 19 Oct 2017 07:58:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20171019065854.GB17401@kentang.lan>
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

Here are my sun4u patches for 2.11. Note that because of the machine changes
there is an openbios-sparc64 binary update included in the first patch to 
maintain bisectability. There will be a follow-up patch for OpenBIOS which will
update binaries for all architectures to the latest and update the submodule 
shortly.


ATB,

Mark.  


The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to bcf9e2c2f2b7a610efaafc4bd6d0bee9181c2345:

  sun4u: fix assert when adding NICs which aren't the in-built model (2017-10-19 07:45:35 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (2):
      sun4u: update PCI topology to include simba PCI bridges
      sun4u: fix assert when adding NICs which aren't the in-built model

 hw/pci-host/apb.c        |   47 +++++++++++++++++++++++++++---------
 hw/sparc64/sun4u.c       |   60 +++++++++++++++++++++++++++++++++-------------
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 3 files changed, 79 insertions(+), 28 deletions(-)
