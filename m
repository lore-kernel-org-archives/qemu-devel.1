Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1cTroB-0006MD-ID
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1cTro8-0003cY-B7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:05:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1cTro8-0003bt-5Q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:05:52 -0500
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 18 Jan 2017 16:05:48 +0100
Message-Id: <1484751948-21387-1-git-send-email-christian.ehrhardt@canonical.com>
Subject: [Qemu-devel] [PATCH] configure: allow enabling seccomp on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org

Allow enabling seccomp support on s390x if sufficient build
dependencies are provided.

Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 86f5214..5056ba9 100755
--- a/configure
+++ b/configure
@@ -1927,6 +1927,9 @@ if test "$seccomp" != "no" ; then
     ppc|ppc64)
         libseccomp_minver="2.3.0"
         ;;
+    s390|s390x)
+        libseccomp_minver="2.3.0"
+        ;;
     *)
         libseccomp_minver=""
         ;;
-- 
2.7.4
