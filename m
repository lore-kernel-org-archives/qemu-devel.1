Received: from eggs.gnu.org ([2001:4830:134:3::10]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv4KQ-0007SO-1j
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv4KL-0000bX-R1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv4KL-0000bF-LO
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:27:49 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Sep 2017 18:27:46 +0200
Message-Id: <20170921162746.11761-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] atomic: update documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 3ef5d85b1b..048e5f23cb 100644
--- a/docs/devel/atomics.txt
+++ b/docs/devel/atomics.txt
@@ -63,11 +63,22 @@ operations:
     typeof(*ptr) atomic_fetch_sub(ptr, val)
     typeof(*ptr) atomic_fetch_and(ptr, val)
     typeof(*ptr) atomic_fetch_or(ptr, val)
+    typeof(*ptr) atomic_fetch_xor(ptr, val)
     typeof(*ptr) atomic_xchg(ptr, val)
     typeof(*ptr) atomic_cmpxchg(ptr, old, new)
 
 all of which return the old value of *ptr.  These operations are
-polymorphic; they operate on any type that is as wide as an int.
+polymorphic; they operate on any type that is as wide as a pointer.
+
+Similar operations return the new value of *ptr:
+
+    typeof(*ptr) atomic_inc_fetch(ptr)
+    typeof(*ptr) atomic_dec_fetch(ptr)
+    typeof(*ptr) atomic_add_fetch(ptr, val)
+    typeof(*ptr) atomic_sub_fetch(ptr, val)
+    typeof(*ptr) atomic_and_fetch(ptr, val)
+    typeof(*ptr) atomic_or_fetch(ptr, val)
+    typeof(*ptr) atomic_xor_fetch(ptr, val)
 
 Sequentially consistent loads and stores can be done using:
 
-- 
2.13.5
