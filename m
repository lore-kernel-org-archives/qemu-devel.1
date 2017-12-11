Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORq-0004y6-6g
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORi-00089T-9W
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:40 +0100
Message-Id: <20171211134740.8235-16-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 15/15] configure: s390x supports
 mttcg now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

s390x is ready. Most likely we are missing some pieces, but it should
already be in pretty good shape now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 0c6e7572db..1e593b6fab 100755
--- a/configure
+++ b/configure
@@ -6508,6 +6508,7 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
+    mttcg=yes
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
   ;;
   tilegx)
-- 
2.14.3
