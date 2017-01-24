Received: from eggs.gnu.org ([2001:4830:134:3::10]:58207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cv-0006nV-Uo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cu-0000of-LG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:46 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cW7Cu-0000oK-G3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:44 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so37179580wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:56:44 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 24 Jan 2017 20:55:42 +0100
Message-Id: <1485287742-31374-3-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1485287742-31374-1-git-send-email-atar4qemu@gmail.com>
References: <1485287742-31374-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] niagara: check if a serial port is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, armbru@redhat.com, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

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
