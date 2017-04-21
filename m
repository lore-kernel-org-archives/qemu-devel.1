Received: from eggs.gnu.org ([2001:4830:134:3::10]:58569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgD-0005e1-4R
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgC-0003gA-C1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:48 +0800
Message-Id: <20170421035606.448-3-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 02/20] qapi: Add 'force-shared-write' to
 blockdev-add arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qapi/block-core.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 033457c..b9b8002 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2880,6 +2880,8 @@
 #                 (default: false)
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
+# @force-shared-write: enforce shared write permission on added nodes
+#                      (Since 2.10)
 #
 # Remaining options are determined by the block driver.
 #
@@ -2891,6 +2893,7 @@
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
+            '*force-shared-write': 'bool',
             '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
   'discriminator': 'driver',
   'data': {
-- 
2.9.3
