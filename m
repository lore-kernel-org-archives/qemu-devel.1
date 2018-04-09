Received: from eggs.gnu.org ([2001:4830:134:3::10]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzr-00062N-UR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzo-00082x-2f
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f5Xzn-00082S-Ud
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:12 -0400
Date: Mon, 9 Apr 2018 17:42:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523284856-251254-4-git-send-email-mst@redhat.com>
References: <1523284856-251254-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284856-251254-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] contrib/libvhost-user: add the protocol
 feature used for SET/GET message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
