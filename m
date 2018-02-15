Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmx-00056E-LH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmw-0005EK-Q7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:59 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmw-0005Dy-L2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:58 -0500
Received: by mail-qk0-x242.google.com with SMTP id f25so1599883qkm.0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:14 -0300
Message-Id: <20180215221325.7611-10-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/20] sdcard: handle CMD54 (SDIO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Linux uses it to poll the bus before polling for a card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b567c44da8..30acd04ad7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1375,9 +1375,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 52:
-    case 53:
-        /* CMD52, CMD53: reserved for SDIO cards
+    case 52 ... 54:
+        /* CMD52, CMD53, CMD54: reserved for SDIO cards
          * (see the SDIO Simplified Specification V2.0)
          * Handle as illegal command but do not complain
          * on stderr, as some OSes may use these in their
-- 
2.16.1
