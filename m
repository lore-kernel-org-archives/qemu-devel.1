Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fJnb4-00013W-Ih
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fJnb0-0000Hj-IA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:8331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1fJnb0-0000HT-AD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:30 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Sat, 19 May 2018 06:20:46 +0800
Message-Id: <1526682046-17414-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH] contrib/vhost-user-blk: enable protocol
 feature for vhost-user-blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, changpeng.liu@intel.com

This patch reports the protocol feature that is only advertised by
QEMU if the device implements the config ops.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 67dac81..a6a132a 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -311,6 +311,12 @@ vub_get_features(VuDev *dev)
            1ull << VHOST_USER_F_PROTOCOL_FEATURES;
 }
 
+static uint64_t
+vub_get_protocol_features(VuDev *dev)
+{
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+}
+
 static int
 vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
 {
@@ -373,6 +379,7 @@ vub_set_config(VuDev *vu_dev, const uint8_t *data,
 static const VuDevIface vub_iface = {
     .get_features = vub_get_features,
     .queue_set_started = vub_queue_set_started,
+    .get_protocol_features = vub_get_protocol_features,
     .get_config = vub_get_config,
     .set_config = vub_set_config,
 };
-- 
1.9.3
