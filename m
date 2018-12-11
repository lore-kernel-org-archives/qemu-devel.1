Received: from eggs.gnu.org ([2001:4830:134:3::10]:41085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYRw-0003Nb-4n
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYRv-0005Vs-G0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:08 -0500
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 11 Dec 2018 13:40:42 +1030
Message-Id: <20181211031044.27628-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] arm: aspeed: Allow the guest to exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This series adds a feature to the ASPEED machine that allows the guest
to cause itself to exit. It was tested with romulus-bmc and palmetto-bmc
with a Linux kernel as the guest.

To test:

 cd linux
 $ export ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
 $ make aspeed_g4_defconfig
 $ ./scripts/config -e CONFIG_POWER_RESET_SYSCON_POWEROFF -e CONFIG_POWER_RESET
 $ make -j$(nproc)
 $ qemu-system-arm -M palmetto-bmc -nographic \
    -kernel arch/arm/boot/zImage \
    -dtb arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dtb \
    -initrd ~/buildroot-arm.cpio.xz

Joel Stanley (2):
  aspeed: Add syscon-poweroff to guest device tree
  aspeed/scu: Implement power off register

 hw/arm/aspeed.c      | 33 +++++++++++++++++++++++++++++++++
 hw/misc/aspeed_scu.c |  5 +++++
 2 files changed, 38 insertions(+)

-- 
2.19.1
