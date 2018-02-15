Received: from eggs.gnu.org ([2001:4830:134:3::10]:55355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emNmX-000881-AA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emNmW-0000de-H3
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:57:17 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 17:57:03 +0000
Message-Id: <20180215175707.15491-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Arm: honour CPU address space for image
 loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset makes the Arm code for loading kernels, initrds,
etc etc honour the CPU's address space rather than loading
everything via the system address space. This makes a difference
when the image is being loaded to memory or via an alias memory
region which is implemented by an SoC container object (and
which therefore doesn't appear in the system address space).

I needed this in particular for M profile, but I'd written all
the boot.c changes before I remembered that M profile doesn't
use that code at all :-)

thanks
-- PMM

Peter Maydell (3):
  loader: Add new load_ramdisk_as()
  hw/arm/boot: Honour CPU's address space for image loads
  hw/arm/armv7m: Honour CPU's address space for image loads

 include/hw/loader.h |  12 +++++-
 hw/arm/armv7m.c     |  17 ++++++--
 hw/arm/boot.c       | 119 +++++++++++++++++++++++++++++++++-------------------
 hw/core/loader.c    |   8 +++-
 4 files changed, 108 insertions(+), 48 deletions(-)

-- 
2.16.1
