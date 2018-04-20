Received: from eggs.gnu.org ([2001:4830:134:3::10]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsZ-0004f4-2a
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsW-0007IS-18
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f9NsV-0007He-SX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:31 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Apr 2018 12:42:12 +0800
Message-Id: <20180420044212.28765-4-peterx@redhat.com>
In-Reply-To: <20180420044212.28765-1-peterx@redhat.com>
References: <20180420044212.28765-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] configure: enable debug-mutex if debug
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>, peterx@redhat.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index a80af735b2..87453edd88 100755
--- a/configure
+++ b/configure
@@ -1005,6 +1005,7 @@ for opt do
   --enable-debug)
       # Enable debugging options that aren't excessively noisy
       debug_tcg="yes"
+      debug_mutex="yes"
       debug="yes"
       strip_opt="no"
       fortify_source="no"
-- 
2.14.3
