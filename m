Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNKAL-0000br-I0
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNKAK-0007MX-Q5
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:02:17 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Dec 2017 15:02:05 +0000
Message-Id: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] hw/arm/virt: Add another UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhao@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>

This patchset adds a second UART to the ARM virt board, which
can be useful in some cases where you'd like a second comms
channel but don't want have to deal with PCI to get it.

Patch 3 attempts to add it to the ACPI tables, but this is
entirely untested and pure guesswork, since I don't really
know anything about ACPI. That patch needs review from
somebody who does know ACPI :-)

thanks
-- PMM

Peter Maydell (3):
  hw/arm/virt: Add virt-2.12 machine type
  hw/arm/virt: Add another UART to the virt board
  hw/arm/virt-acpi-build: Add second UART to ACPI tables

 include/hw/arm/virt.h    |  2 ++
 include/hw/compat.h      |  3 +++
 hw/arm/virt-acpi-build.c |  5 +++++
 hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++-----
 4 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.7.4
