Received: from eggs.gnu.org ([2001:4830:134:3::10]:56978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyni-0003KA-MT
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynh-0006X6-TJ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:34 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynh-0006Wi-OQ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:33 -0500
Received: by mail-qk0-x243.google.com with SMTP id j137so35734192qke.10
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:06 -0300
Message-Id: <20171229174933.1781-16-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/42] sdhci: Implement write method of
 ACMD12ERRSTS register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ae84af46da..a47ed61248 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1135,6 +1135,9 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
+    case SDHC_ACMD12ERRSTS:
+        MASKED_WRITE(s->acmd12errsts, mask, value);
+        break;
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.15.1
