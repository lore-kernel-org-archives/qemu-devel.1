Received: from eggs.gnu.org ([2001:4830:134:3::10]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebri6-0008Cw-CZ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebri5-0007Kb-MT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:14 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:32 +0100
Message-Id: <20180117174047.6382-4-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/18] s390x/tcg: simplify lookup of flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We can simply search for an object of our common type.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.14.3
