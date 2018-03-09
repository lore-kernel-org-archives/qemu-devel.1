Received: from eggs.gnu.org ([2001:4830:134:3::10]:50149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd3-0008Ej-PZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd2-0006mz-Up
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOd2-0006mm-P4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:36 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:21 -0300
Message-Id: <20180309202827.12085-3-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] device-crash-test: Add examples to script
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

Add simple examples for common use cases.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index c6a7875357..364c779cdb 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -22,6 +22,25 @@
 """
 Run QEMU with all combinations of -machine and -device types,
 check for crashes and unexpected errors.
+
+Example usage:
+
+Test all QEMU binaries found in the current directory, with all
+machine-type/device combinations, but skip the combinations that are expected to
+fail:
+
+    device-crash-test
+
+Test all QEMU binaries found in the current directory, with all
+machine-type/device combinations, including the combinations that are expected
+to fail:
+
+    device-crash-test -F
+
+Test a single QEMU binary:
+
+    device-crash-test /path/to/qemu/binary
+
 """
 
 import sys
-- 
2.14.3
