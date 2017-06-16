Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP8-0004UL-QT
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP7-0006Ym-W5
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1dLwP7-0006Y6-SZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:33 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so12311685qtc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:55:33 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 16 Jun 2017 14:55:16 -0400
Message-Id: <1497639316-22202-4-git-send-email-gsomlo@gmail.com>
In-Reply-To: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
References: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/3] applesmc: fix port i/o access width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

Set access width of all AppleSMC i/o regions to 1 byte, since they
all represent 8-bit-wide ports.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
 hw/misc/applesmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 0d882e8..7896812 100644
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
2.7.4
