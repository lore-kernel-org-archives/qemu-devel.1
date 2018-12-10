Received: from eggs.gnu.org ([2001:4830:134:3::10]:55442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOEK-0001OL-74
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOEB-0001on-Ap
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1gWOE9-0001mZ-8W
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:15 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon, 10 Dec 2018 11:15:46 -0500
Message-Id: <1544458548-5986-2-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH 1/3] virtio_net: Add VIRTIO_NET_F_STANDBY
 feature bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

This feature bit can be used by a hypervisor to indicate to the virtio_net
device that it can act as a standby for another device with the same MAC
address.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 385b1a0..411f8fb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
+                      false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
