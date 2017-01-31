Received: from eggs.gnu.org ([2001:4830:134:3::10]:54058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetK-0003kz-Mi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetI-0004Fk-CM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:52328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetI-0004Fc-6g
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:00 -0500
Date: Tue, 31 Jan 2017 22:18:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485893872-26524-2-git-send-email-mst@redhat.com>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485893872-26524-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v5 01/22] compiler: drop ; after BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

All users include the trailing ; anyway, let's require that -
it seems cleaner.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/compiler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 157698b..7512082 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -86,7 +86,8 @@
 #define type_check(t1,t2) ((t1*)0 - (t2*)0)
 
 #define QEMU_BUILD_BUG_ON(x) \
-    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused));
+    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
+        __attribute__((unused))
 
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
-- 
MST
