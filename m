Received: from eggs.gnu.org ([2001:4830:134:3::10]:57335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGJ-0002zy-IS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGI-00030v-AA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGI-00030P-5C
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:30 -0400
Date: Thu, 3 May 2018 22:51:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-50-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 49/67] kvm_XXX: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/kvm_arm.h   | 1 +
 include/kvm_i386.h  | 1 +
 include/kvm_mips.h  | 1 +
 include/kvm_ppc.h   | 1 +
 include/kvm_s390x.h | 1 +
 5 files changed, 5 insertions(+)
 create mode 100644 include/kvm_arm.h
 create mode 100644 include/kvm_i386.h
 create mode 100644 include/kvm_mips.h
 create mode 100644 include/kvm_ppc.h
 create mode 100644 include/kvm_s390x.h

diff --git a/include/kvm_arm.h b/include/kvm_arm.h
new file mode 100644
index 0000000..3a57d37
--- /dev/null
+++ b/include/kvm_arm.h
@@ -0,0 +1 @@
+#include_next "../target/arm/kvm_arm.h"
diff --git a/include/kvm_i386.h b/include/kvm_i386.h
new file mode 100644
index 0000000..e43c259
--- /dev/null
+++ b/include/kvm_i386.h
@@ -0,0 +1 @@
+#include_next "../target/i386/kvm_i386.h"
diff --git a/include/kvm_mips.h b/include/kvm_mips.h
new file mode 100644
index 0000000..d5acbfe
--- /dev/null
+++ b/include/kvm_mips.h
@@ -0,0 +1 @@
+#include_next "../target/mips/kvm_mips.h"
diff --git a/include/kvm_ppc.h b/include/kvm_ppc.h
new file mode 100644
index 0000000..d5baf60
--- /dev/null
+++ b/include/kvm_ppc.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/kvm_ppc.h"
diff --git a/include/kvm_s390x.h b/include/kvm_s390x.h
new file mode 100644
index 0000000..e2d7230
--- /dev/null
+++ b/include/kvm_s390x.h
@@ -0,0 +1 @@
+#include_next "../target/s390x/kvm_s390x.h"
-- 
MST
