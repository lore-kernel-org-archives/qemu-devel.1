Received: from eggs.gnu.org ([2001:4830:134:3::10]:36580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3R-0000Bg-NR
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3M-0008Om-PS
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1cfV3M-0008Nu-HU
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:40 -0500
Message-Id: <f4e117af10b1a6c1e8f29a921b46bc6df1ca36c8.1487522123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 19 Feb 2017 17:35:23 +0100
Subject: [Qemu-devel] [PATCH 05/10] sm501: Add missing arbitration control
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index e966896..9091bb5 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -474,6 +474,7 @@ typedef struct SM501State {
     uint32_t gpio_31_0_control;
     uint32_t gpio_63_32_control;
     uint32_t dram_control;
+    uint32_t arbitration_control;
     uint32_t irq_mask;
     uint32_t misc_timing;
     uint32_t power_mode_control;
@@ -757,6 +758,9 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
     case SM501_DRAM_CONTROL:
         ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
         break;
+    case SM501_ARBTRTN_CONTROL:
+        ret = s->arbitration_control;
+        break;
     case SM501_IRQ_MASK:
         ret = s->irq_mask;
         break;
@@ -809,6 +813,9 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         /* TODO : check validity of size change */
         s->dram_control |=  value & 0x7FFFFFC3;
         break;
+    case SM501_ARBTRTN_CONTROL:
+        s->arbitration_control =  value & 0x37777777;
+        break;
     case SM501_IRQ_MASK:
         s->irq_mask = value;
         break;
-- 
2.7.4
