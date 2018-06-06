Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuV-0007E0-U4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuV-0007HM-7P
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 11:59:21 -0300
Message-Id: <20180606145921.30606-4-f4bug@amsat.org>
In-Reply-To: <20180606145921.30606-1-f4bug@amsat.org>
References: <20180606145921.30606-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] hw/misc/mos6522: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/mos6522.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 6163cea6ab..49166cb8ad 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -189,12 +189,12 @@ static uint64_t mos6522_get_load_time(MOS6522State *s, MOS6522Timer *ti)
 
 static void mos6522_portA_write(MOS6522State *s)
 {
-    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented");
+    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented\n");
 }
 
 static void mos6522_portB_write(MOS6522State *s)
 {
-    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented");
+    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented\n");
 }
 
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.17.1
