Received: from eggs.gnu.org ([2001:4830:134:3::10]:51861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-00023g-RT
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-0007E1-1s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHD-0007By-Q7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH6-0008Uw-Ed
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:32 +0100
Message-Id: <20180626165658.31394-7-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/32] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

This adds Cedric as the maintainer, with Andrew and I as reviewers, for
the ASPEED boards and the peripherals we have developed.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-id: 20180625140055.32223-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1676b1ba712..8c626f6a079 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -645,6 +645,17 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
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
