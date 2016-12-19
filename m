Received: from eggs.gnu.org ([2001:4830:134:3::10]:56643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvml-0003NM-3m
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmf-0001bB-NO
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:17693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIvmf-0001Zz-Ep
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:09 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 19:05:53 +0800
Message-Id: <1482145554-88823-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
References: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/3] spec/vhost-user: add
 VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
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

The VHOST_USER_PROTOCOL_F_SET_DEVICE_ID protocol feature indicates
that the slave side implementation supports different types of devices.
The master tells the slave what type of device to create by sending
a VHOST_USER_SET_DEVICE_ID message.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 docs/specs/vhost-user.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 18e49d0..80dcfc1 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -267,6 +267,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_RARP           2
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
 #define VHOST_USER_PROTOCOL_F_VHOST_PCI      4
+#define VHOST_USER_PROTOCOL_F_SET_DEVICE_ID  5
 
 Message types
 -------------
@@ -479,6 +480,16 @@ Message types
       The first 6 bytes of the payload contain the mac address of the guest to
       allow the vhost user backend to construct and broadcast the fake RARP.
 
+ * VHOST_USER_SET_DEVICE_ID
+      Id: 20
+      Equivalent ioctl: N/A
+      Master payload: u64
+
+      The master sends the virtio device id to the slave. The virtio device id
+      indicates the device type of the master device.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
+      has been negotiated.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
-- 
2.7.4
