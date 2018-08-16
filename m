Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fqJ1o-0006Uk-I4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fqJ1m-0004Lm-NP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:13:32 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 16 Aug 2018 23:43:01 +0930
Message-Id: <20180816141303.20518-2-joel@jms.id.au>
In-Reply-To: <20180816141303.20518-1-joel@jms.id.au>
References: <20180816141303.20518-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH v5 1/3] MAINTAINERS: Add NRF51 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

This contains the NRF51, and the machine that uses it, the BBC
micro:bit.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
  fix spelling of mailing list
  add stefan's reviewed-by
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c48d9271cf15..5a0d2e327d4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -656,6 +656,14 @@ F: include/hw/*/*aspeed*
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 
+NRF51
+M: Joel Stanley <joel@jms.id.au>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/nrf51_soc.c
+F: hw/arm/microbit.c
+F: include/hw/arm/nrf51_soc.h
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.17.1
