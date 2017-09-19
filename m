Received: from eggs.gnu.org ([2001:4830:134:3::10]:38274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duCwa-0001fT-FB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duCwZ-0007lj-Id
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duCwZ-0007lR-DK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 19 Sep 2017 15:27:07 +0800
Message-Id: <20170919072719.11815-2-famz@redhat.com>
In-Reply-To: <20170919072719.11815-1-famz@redhat.com>
References: <20170919072719.11815-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 01/13] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
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
