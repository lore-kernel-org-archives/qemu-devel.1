Received: from eggs.gnu.org ([2001:4830:134:3::10]:43270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wC-0001rq-5X
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wB-0005w8-Cm
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:44 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:24:59 +0100
Message-Id: <20180209092524.31348-5-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/29] s390x/tcg: simplify lookup of flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can simply search for an object of our common type.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-4-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index fc244fe775..ba1aa40eba 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -27,11 +27,9 @@ S390FLICState *s390_get_flic(void)
     static S390FLICState *fs;
 
     if (!fs) {
-        fs = S390_FLIC_COMMON(object_resolve_path(TYPE_KVM_S390_FLIC, NULL));
-        if (!fs) {
-            fs = S390_FLIC_COMMON(object_resolve_path(TYPE_QEMU_S390_FLIC,
-                                                      NULL));
-        }
+        fs = S390_FLIC_COMMON(object_resolve_path_type("",
+                                                       TYPE_S390_FLIC_COMMON,
+                                                       NULL));
     }
     return fs;
 }
-- 
2.13.6
