Received: from eggs.gnu.org ([2001:4830:134:3::10]:50383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpto-00031k-1B
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejptk-0006eL-04
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:22:16 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 14:22:00 -0300
Message-Id: <20180208172202.9984-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] aspeed: simplify using the 'unimplemented
 device' for aspeed_soc.io
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

The diffstat prooves it :)

Philippe Mathieu-Daudé (2):
  hw/arm/aspeed: directly map the serial device to the system address space
  hw/arm/aspeed: simplify using the 'unimplemented device' for aspeed_soc.io

 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed_soc.c         | 34 ++++------------------------------
 2 files changed, 4 insertions(+), 31 deletions(-)

-- 
2.16.1
