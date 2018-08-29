Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBj-0005f2-7s
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwz2-0002Wr-Mb
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:41:53 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:25 +0200
Message-Id: <20180829094143.2102-2-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/19] tests/tcg: add a simple s390x test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Cornelia Huck <cohuck@redhat.com>

From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Copied from alpha.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Message-Id: <20180821025104.19604-2-pavel.zbitskiy@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                     | 1 +
 tests/tcg/s390x/Makefile.target | 3 +++
 tests/tcg/s390x/hello-s390x.c   | 7 +++++++
 3 files changed, 11 insertions(+)
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/hello-s390x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d12518c08f..fd1bce176f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -253,6 +253,7 @@ S: Maintained
 F: target/s390x/
 F: hw/s390x/
 F: disas/s390.c
+F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
new file mode 100644
index 0000000000..9f4076901f
--- /dev/null
+++ b/tests/tcg/s390x/Makefile.target
@@ -0,0 +1,3 @@
+VPATH+=$(SRC_PATH)/tests/tcg/s390x
+CFLAGS+=-march=zEC12 -m64
+TESTS+=hello-s390x
diff --git a/tests/tcg/s390x/hello-s390x.c b/tests/tcg/s390x/hello-s390x.c
new file mode 100644
index 0000000000..3dc0a05f2b
--- /dev/null
+++ b/tests/tcg/s390x/hello-s390x.c
@@ -0,0 +1,7 @@
+#include <unistd.h>
+
+int main(void)
+{
+    write(1, "hello\n", 6);
+    return 0;
+}
-- 
2.14.4
