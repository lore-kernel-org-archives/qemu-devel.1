Received: from eggs.gnu.org ([2001:4830:134:3::10]:59538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZo-0003vR-8y
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZn-0002xR-EJ
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  2 Jun 2018 21:08:24 -0300
Message-Id: <20180603000827.30872-6-f4bug@amsat.org>
In-Reply-To: <20180603000827.30872-1-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/8] hw/sd/ssi-sd: Force cards connected in SPI
 mode to use Spec v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/ssi-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index ae04b6641b..c62fdc871c 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -253,6 +253,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    object_property_set_uint(OBJECT(carddev),
+                             SD_PHY_SPECv1_10_VERS, "spec_version", &err);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
     }
-- 
2.17.1
