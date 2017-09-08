Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0a-0007lG-7r
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0V-0004SW-Sa
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG0V-0004RT-MC
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:36 +0800
Message-Id: <20170908095506.13594-9-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 08/38] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905021201.25684-2-famz@redhat.com>
---
 .gitignore       | 1 +
 tests/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index cf65316863..40acfcb9e2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 /vscclient
 /vhost-user-scsi
 /fsdev/virtfs-proxy-helper
+*.tmp
 *.[1-9]
 *.a
 *.aux
diff --git a/tests/.gitignore b/tests/.gitignore
index fed0189a5a..cf6d99c91e 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -95,3 +95,4 @@ test-filter-mirror
 test-filter-redirector
 *-test
 qapi-schema/*.test.*
+vm/*.img
-- 
2.13.5
