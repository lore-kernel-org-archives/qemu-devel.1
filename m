Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RY-Jo
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp7-0007jJ-Pa
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp7-0007j3-MY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5956640FB655
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:25 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:10 +0100
Message-Id: <20180216172910.8549-6-maxime.coquelin@redhat.com>
In-Reply-To: <20180216172910.8549-1-maxime.coquelin@redhat.com>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 5/5] vhost-user-scsi: send virtio status to the
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 9389ed48e0..da36a3b7f5 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -58,6 +58,8 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     } else {
         vhost_scsi_common_stop(vsc);
     }
+
+    vhost_dev_set_virtio_status(&vsc->dev, status);
 }
 
 static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-- 
2.14.3
