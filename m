Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUz0-0001uy-Gm
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyx-0000pj-CZ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyx-0000pe-8F
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:15 -0400
Date: Wed, 23 May 2018 17:43:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-19-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 18/28] contrib/vhost-user-blk: enable protocol
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

This patch reports the protocol feature that is only advertised by
QEMU if the device implements the config ops.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
