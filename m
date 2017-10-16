Received: from eggs.gnu.org ([2001:4830:134:3::10]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bx-00051a-UI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bt-0005a2-Gu
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46bt-0005Xv-Ae
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:17 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:42:59 +0200
Message-Id: <20171016144302.24284-5-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/7] kvm: fix error message when failing to
 unregister slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joe Clifford <joeclifford@gmail.com>, David Hildenbrand <david@redhat.com>

"overlapping" is a leftover, let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f5fa3e24bd..559c544501 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -734,7 +734,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->memory_size = 0;
         err = kvm_set_user_memory_region(kml, mem);
         if (err) {
-            fprintf(stderr, "%s: error unregistering overlapping slot: %s\n",
+            fprintf(stderr, "%s: error unregistering slot: %s\n",
                     __func__, strerror(-err));
             abort();
         }
-- 
2.13.5
