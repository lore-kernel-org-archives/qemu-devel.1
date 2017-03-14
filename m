Received: from eggs.gnu.org ([2001:4830:134:3::10]:57492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cntwe-0002oz-2Y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cntwZ-0004sG-34
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:25:28 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com
	([40.107.0.99]:49168
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cntwY-0004rX-NK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:25:23 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:13 +0200
Message-ID: <a86a3716c8980ef62f7194613dfbf10cab447a26.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 6/6] Support "bootonceindex" property for
 SCSI disks.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 hw/scsi/scsi-bus.c       | 3 +++
 include/hw/block/block.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 5940cb1..26e38ab 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -2084,6 +2084,9 @@ static void scsi_dev_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", NULL,
                                   &s->qdev, NULL);
+    device_add_bootonceindex_property(obj, &s->conf.bootonceindex,
+                                      "bootonceindex", NULL,
+                                      &s->qdev, NULL);
 }
 
 static const TypeInfo scsi_device_type_info = {
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df9d207..f3e76c3 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -22,6 +22,7 @@ typedef struct BlockConf {
     uint16_t min_io_size;
     uint32_t opt_io_size;
     int32_t bootindex;
+    int32_t bootonceindex;
     uint32_t discard_granularity;
     /* geometry, not all devices use this */
     uint32_t cyls, heads, secs;
-- 
2.7.4
