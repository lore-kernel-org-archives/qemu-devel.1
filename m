Received: from eggs.gnu.org ([2001:4830:134:3::10]:35824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqZ-0007Gp-J0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqY-0000pC-P3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:06 +0100
Message-Id: <20180309214611.19122-3-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-1-kwolf@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] qemu-iotests: Enable write tests for
 parallels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Originally we added parallels as a read-only format to qemu-iotests
where we did just some tests with a binary image. Since then, write and
image creation support has been added to the driver, so we can now
enable it in _supported_fmt generic.

The driver doesn't support migration yet, though, so we need to add it
to the list of exceptions in 181.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/181   | 2 +-
 tests/qemu-iotests/check | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 0c91e8f9de..5e767c6195 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 # Formats that do not support live migration
-_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
+_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat parallels
 _supported_proto generic
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e6b6ff7a04..469142cd58 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -284,7 +284,6 @@ testlist options
 
         -parallels)
             IMGFMT=parallels
-            IMGFMT_GENERIC=false
             xpand=false
             ;;
 
-- 
2.13.6
