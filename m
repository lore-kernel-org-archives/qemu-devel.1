Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmm-0003Ok-Qt
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmh-0001de-Q1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:47005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIvmh-0001c9-Ee
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:11 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 19:05:54 +0800
Message-Id: <1482145554-88823-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
References: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/3] spec/vhost-user: add the
 VHOST_USER_SET_VHOST_PCI message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

The VHOST_USER_SET_VHOST_PCI message is introduced to start/stop
the vhost-pci based inter-VM communiaction by the master.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 docs/specs/vhost-user.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 80dcfc1..4e2ce60 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -490,6 +490,18 @@ Message types
       This request should be sent only when VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
       has been negotiated.
 
+ * VHOST_USER_SET_VHOST_PCI
+
+      Id: 21
+      Equivalent ioctl: N/A
+      Master payload: u64
+
+      The master requests the slave to start or stop the vhost-pci device for
+      the inter-VM communication.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_VHOST_PCI has
+      been negotiated.
+
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
-- 
2.7.4
