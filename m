Received: from eggs.gnu.org ([2001:4830:134:3::10]:39201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7b-0001N3-LW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7a-0006zG-Rv
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7a-0006z6-MV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:31 +0800
Message-Id: <1490945793-21276-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1490945793-21276-1-git-send-email-peterx@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 3/5] util: propagate error for
 device_func_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

We have error_propagate(). Use it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index b97b32a..b18bde7 100644
--- a/vl.c
+++ b/vl.c
@@ -2304,7 +2304,7 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
     dev = qdev_device_add(opts, &err);
     if (!dev) {
-        error_report_err(err);
+        error_propagate(errp, err);
         return -1;
     }
     object_unref(OBJECT(dev));
-- 
2.7.4
