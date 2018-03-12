Received: from eggs.gnu.org ([2001:4830:134:3::10]:44526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDQ-0002bY-MA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004ZG-Um
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:44 -0400
Received: from sauhun.de ([88.99.104.3]:53449 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004Yv-OI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:40 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 12 Mar 2018 22:42:30 +0100
Message-Id: <20180312214230.17561-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [PATCH 3/3] nvram: at24c: use a sane default for
 "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Davidsaver <mdavidsaver@gmail.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

0 as "rom-size" doesn't make much sense, let's use the smallest 24cXX
which has 128 byte.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/nvram/eeprom_at24c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index d82710e1df..de988f8d07 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -168,7 +168,7 @@ void at24c_eeprom_reset(DeviceState *state)
 }
 
 static Property at24c_eeprom_props[] = {
-    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
+    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 128),
     DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
     DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
     DEFINE_PROP_END_OF_LIST()
-- 
2.11.0
