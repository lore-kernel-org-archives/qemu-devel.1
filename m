Received: from eggs.gnu.org ([2001:4830:134:3::10]:44865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=IsLg=ZJ=redhat.com=mst@kernel.org>)
	id 1cX9Mx-0004Ck-35
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=IsLg=ZJ=redhat.com=mst@kernel.org>)
	id 1cX9Mw-0007Qp-At
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:27:23 -0500
Date: Fri, 27 Jan 2017 18:27:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485534415-20887-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 1/3] arm: better stub version for MISMATCH_CHECK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

stub version of MISMATCH_CHECK is empty so it's easy to misuse for
people not building kvm on arm.  Use QEMU_BUILD_BUG_ON similar to the
non-stub version to make it easier to catch bugs.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/arm/kvm-consts.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index a2c9518..06b6c92 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -21,7 +21,9 @@
 #define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(X != Y)
 
 #else
-#define MISMATCH_CHECK(X, Y)
+
+#define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(0)
+
 #endif
 
 #define CP_REG_SIZE_SHIFT 52
-- 
MST
