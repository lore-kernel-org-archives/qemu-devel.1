Received: from eggs.gnu.org ([2001:4830:134:3::10]:49971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bi-0001fq-L2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bg-0000OW-5T
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dz6Bf-0000Nm-Vf
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C2F14ACBB
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 19:15:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  2 Oct 2017 20:15:18 +0100
Message-Id: <20171002191521.15748-2-dgilbert@redhat.com>
In-Reply-To: <20171002191521.15748-1-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] libvhost-user: vu_queue_started
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
List-ID: <qemu-devel.nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a vu_queue_started method to complement vu_queue_enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 ++++++
 contrib/libvhost-user/libvhost-user.h | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d27d6303db..5ee8483a32 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -943,6 +943,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
     return vq->enable;
 }
 
+bool
+vu_queue_started(const VuDev *dev, const VuVirtq *vq)
+{
+    return vq->started;
+}
+
 static inline uint16_t
 vring_avail_flags(VuVirtq *vq)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 4021f1124e..94d7cc8fbd 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -335,6 +335,15 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable);
 bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
 
 /**
+ * vu_queue_started:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is started.
+ */
+bool vu_queue_started(const VuDev *dev, const VuVirtq *vq);
+
+/**
  * vu_queue_empty:
  * @dev: a VuDev context
  * @vq: a VuVirtq queue
-- 
2.13.6
