Received: from eggs.gnu.org ([2001:4830:134:3::10]:35734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvg-00071J-Da
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvf-0004va-Ha
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:32 -0500
Received: from mail.kernel.org ([198.145.29.136]:56180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvf-0004u0-AQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:31 -0500
Date: Thu, 19 Jan 2017 23:07:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484859998-25074-2-git-send-email-mst@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484859998-25074-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] compiler: drop ; after BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

All users include the trailing ; anyway, let's require that -
it seems cleaner.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
