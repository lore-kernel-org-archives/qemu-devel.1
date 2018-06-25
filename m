Received: from eggs.gnu.org ([2001:4830:134:3::10]:51048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fXS3Z-0001cC-Aa
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fXS3P-0001yf-G4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:01:24 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Jun 2018 23:30:55 +0930
Message-Id: <20180625140055.32223-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This adds Cedric as the maintainer, with Andrew and I as reviewers, for
the ASPEED boards and the peripherals we have developed.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
--
v2: fix includes path
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2874ddce6097..5706cd89a053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -644,6 +644,17 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 S: Maintained
 F: hw/arm/msf2-som.c
 
+ASPEED BMCs
+M: Cédric Le Goater <clg@kaod.org>
+R: Andrew Jeffery <andrew@aj.id.au>
+R: Joel Stanley <joel@jms.id.au>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/*aspeed*
+F: include/hw/*/*aspeed*
+F: hw/net/ftgmac100.c
+F: include/hw/net/ftgmac100.h
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.17.1
