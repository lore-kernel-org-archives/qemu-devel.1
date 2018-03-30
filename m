Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1jwJ-0004As-OP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1jwG-0007Jp-M8
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:38:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:20619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1f1jwG-0007CU-EB
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:38:48 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Fri, 30 Mar 2018 10:46:16 +0800
Message-Id: <1522377977-29623-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] contrib/libvhost-user: add the protocol
 feature used for SET/GET message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/libvhost-user/libvhost-user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 79f7a53..b27075e 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -50,6 +50,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
     VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
+    VHOST_USER_PROTOCOL_F_CONFIG = 9,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
-- 
1.9.3
