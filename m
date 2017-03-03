Received: from eggs.gnu.org ([2001:4830:134:3::10]:47102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgjR-0002c5-Ip
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgjO-0003c7-Ff
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:30:25 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 17:30:07 +1100
Message-Id: <20170303063009.21580-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, thuth@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/submodule-update-20170303

for you to fetch changes up to 125a9cb8e386980d04a1ac8e04fe9e5c0e826c6f:

  Update dtc submodule to v1.4.3 (2017-03-03 17:25:32 +1100)

----------------------------------------------------------------
submodule updates (SLOF & dtc) 2017-03-03

This set of patches updates the SLOF and dtc submodules for qemu-2.9.

The SLOF update could have gone in my ppc pull request earlier today,
but I forgot it.  It should be safe to apply in either order with that
set though.

The dtc (and libfdt) update brings us up to dtc 1.4.3 which includes
some things that will be useful in future.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

David Gibson (1):
      Update dtc submodule to v1.4.3

 dtc              |   2 +-
 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 898232 -> 902120 bytes
 roms/SLOF        |   2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
