Received: from eggs.gnu.org ([2001:4830:134:3::10]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMh-0006kT-Tm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMe-0001ZO-2n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVMd-0001Z1-Sg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:36 -0500
Date: Tue, 16 Jan 2018 19:49:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-11-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/34] vhost-user: fix multiple queue
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

The number of queues supported by the slave is queried with
message VHOST_USER_GET_QUEUE_NUM, not with message
VHOST_USER_GET_PROTOCOL_FEATURES.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 0875ef4..9fcf48d 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -228,8 +228,8 @@ Multiple queue is treated as a protocol extension, hence the slave has to
 implement protocol features first. The multiple queues feature is supported
 only when the protocol feature VHOST_USER_PROTOCOL_F_MQ (bit 0) is set.
 
-The max number of queues the slave supports can be queried with message
-VHOST_USER_GET_PROTOCOL_FEATURES. Master should stop when the number of
+The max number of queue pairs the slave supports can be queried with message
+VHOST_USER_GET_QUEUE_NUM. Master should stop when the number of
 requested queues is bigger than that.
 
 As all queues share one connection, the master uses a unique index for each
-- 
MST
