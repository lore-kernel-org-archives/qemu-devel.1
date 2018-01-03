Received: from eggs.gnu.org ([2001:4830:134:3::10]:47931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTF-0000kI-O0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTF-000788-0P
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:57 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTE-000784-RV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:56 -0500
Received: by mail-qk0-x244.google.com with SMTP id a8so2565484qkb.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:08:03 -0300
Message-Id: <20180103180805.18140-16-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 15/17] sdhci: Implement write method of
 ACMD12ERRSTS register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0aed8512c3..a688c6db46 100644
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
