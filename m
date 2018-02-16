Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmx-0005g7-S5
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmw-0002eY-V9
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:15 -0500
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmw-0002eO-QA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:14 -0500
Received: by mail-vk0-x242.google.com with SMTP id w201so1067617vkw.0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:30:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 23:29:31 -0300
Message-Id: <20180216022933.10945-7-f4bug@amsat.org>
In-Reply-To: <20180216022933.10945-1-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/7] hw/sd: make sd_data_ready() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

It belongs to the legacy API (the last user has been converted).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index bf1eb0713c..4491db98de 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -138,7 +138,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
 void sd_write_data(SDState *sd, uint8_t value);
 uint8_t sd_read_data(SDState *sd);
 void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert);
-bool sd_data_ready(SDState *sd);
 /* sd_enable should not be used -- it is only used on the nseries boards,
  * where it is part of a broken implementation of the MMC card slot switch
  * (there should be two card slots which are multiplexed to a single MMC
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9ac9b63ff8..72d32f7845 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1885,7 +1885,7 @@ uint8_t sd_read_data(SDState *sd)
     return ret;
 }
 
-bool sd_data_ready(SDState *sd)
+static bool sd_data_ready(SDState *sd)
 {
     return sd->state == sd_sendingdata_state;
 }
-- 
2.16.1
