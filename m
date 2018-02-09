Received: from eggs.gnu.org ([2001:4830:134:3::10]:33133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VR-0001KS-Co
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VN-0006Av-Fl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:58:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 05:57:53 -0300
Message-Id: <20180209085755.30414-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] aspeed: simplify using the
 'unimplemented device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Since v1:
- corrected buggy UART base address (noticed by Peter)
- tested using openbmc-build provided by Andrew
- added Cédric R-b

tested with:

  $ qemu-system-arm -M romulus-bmc -m 512 \
    -drive file=image-bmc,if=mtd,format=raw -nographic

using this image:

  https://openpower.xyz/job/openbmc-build/1240/distro=ubuntu,target=romulus/artifact/deploy/images/romulus/image-bmc

(which is a good candidate for an Avocado / pyexpect test).

Philippe Mathieu-Daudé (2):
  hw/arm/aspeed: directly map the serial device to the system address
    space
  hw/arm/aspeed: simplify using the 'unimplemented device' for
    aspeed_soc.io

 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed_soc.c         | 35 +++++------------------------------
 2 files changed, 5 insertions(+), 31 deletions(-)

-- 
2.16.1
