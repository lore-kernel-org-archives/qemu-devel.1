Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyC-0003cJ-27
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyB-0002Go-94
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:24 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyB-0002G0-37
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:23 -0400
Received: by mail-wr0-x22e.google.com with SMTP id o44so5582984wrf.11
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:11 +0200
Message-Id: <1508343141-31835-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/29] kvm: fix error message when failing to
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

"overlapping" is a leftover, let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-5-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f5fa3e2..559c544 100644
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
1.8.3.1
