Received: from eggs.gnu.org ([2001:4830:134:3::10]:48960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ci7Ky-0008Cz-3Y
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ci7Ku-0000Ak-Ss
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:30:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ci7Ku-0000Ae-Mr
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:30:36 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so10887301wmv.0
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 14:30:36 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 26 Feb 2017 23:29:16 +0100
Message-Id: <1488148156-2036-3-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1488148156-2036-1-git-send-email-atar4qemu@gmail.com>
References: <1488148156-2036-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 2/2] niagara: check if a serial port is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/sparc64/niagara.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index edde86e..9a8d610 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -158,9 +158,10 @@ static void niagara_init(MachineState *machine)
             exit(1);
         }
     }
-    serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
-                   serial_hds[0], DEVICE_BIG_ENDIAN);
-
+    if (serial_hds[0]) {
+        serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
+                       serial_hds[0], DEVICE_BIG_ENDIAN);
+    }
     empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
-- 
2.7.2
