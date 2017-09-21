Received: from eggs.gnu.org ([2001:4830:134:3::10]:37155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiB-0004Yh-4l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiA-0003tX-7E
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:51 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiA-0003rX-0W
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:50 -0400
Received: by mail-wm0-x243.google.com with SMTP id r136so6436924wmf.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:49 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.16.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:16:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:12 +0200
Message-Id: <1506035800-30509-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/32] atomic: update documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 3ef5d85..048e5f2 100644
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
1.8.3.1
