Received: from eggs.gnu.org ([2001:4830:134:3::10]:52007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnA-0001f7-S6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxn7-00048D-PL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxn7-00047g-I6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:45 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:26:59 +0100
Message-Id: <20170824192730.8440-2-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a vu_queue_started method to complement vu_queue_enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 ++++++
 contrib/libvhost-user/libvhost-user.h | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 35fa0c5e56..201b9846e9 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -930,6 +930,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
     return vq->enable;
 }
 
+bool
+vu_queue_started(VuDev *dev, VuVirtq *vq)
+{
+    return vq->started;
+}
+
 static inline uint16_t
 vring_avail_flags(VuVirtq *vq)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 53ef222c0b..acd019876d 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -328,6 +328,15 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable);
 bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
 
 /**
+ * vu_queue_started:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is started.
+ */
+bool vu_queue_started(VuDev *dev, VuVirtq *vq);
+
+/**
  * vu_queue_empty:
  * @dev: a VuDev context
  * @vq: a VuVirtq queue
-- 
2.13.5
