Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0r-0001iH-5d
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0n-0004SL-5d
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOO0m-0004Qs-TM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:33 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 14:48:29 +0200
Message-Id: <20170623124829.24260-4-kraxel@redhat.com>
In-Reply-To: <20170623124829.24260-1-kraxel@redhat.com>
References: <20170623124829.24260-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] applesmc: fix port i/o access width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Gabriel L. Somlo" <gsomlo@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Gabriel L. Somlo" <gsomlo@gmail.com>

Set access width of all AppleSMC i/o regions to 1 byte, since they
all represent 8-bit-wide ports.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Message-id: 1497639316-22202-4-git-send-email-gsomlo@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/misc/applesmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 0d882e8f42..7896812304 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -316,12 +316,12 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     AppleSMCState *s = APPLE_SMC(dev);
 
     memory_region_init_io(&s->io_data, OBJECT(s), &applesmc_data_io_ops, s,
-                          "applesmc-data", 4);
+                          "applesmc-data", 1);
     isa_register_ioport(&s->parent_obj, &s->io_data,
                         s->iobase + APPLESMC_DATA_PORT);
 
     memory_region_init_io(&s->io_cmd, OBJECT(s), &applesmc_cmd_io_ops, s,
-                          "applesmc-cmd", 4);
+                          "applesmc-cmd", 1);
     isa_register_ioport(&s->parent_obj, &s->io_cmd,
                         s->iobase + APPLESMC_CMD_PORT);
 
-- 
2.9.3
