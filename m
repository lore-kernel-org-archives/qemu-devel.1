Received: from eggs.gnu.org ([2001:4830:134:3::10]:57544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cj69j-0003gs-UQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cj69e-0003k1-6M
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:27:07 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed,  1 Mar 2017 23:26:51 +0800
Message-Id: <20170301152651.16390-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Update 049 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

75cdcd155 improved the error message, which affects the reference
output. Let's sync it up.

Note that previously '1kilobyte' was treated like '1k', but now it's an
error. Looking at the commit in question, this appears to be intended.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/049.out | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 4673b67..17c2eb0 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -95,14 +95,14 @@ qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: Value '-1024' is too large for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: Value '-1k' is too large for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
@@ -110,15 +110,19 @@ qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+qemu-img: Parameter 'size' expects a non-negative number below 2^64
+Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
+and exabytes, respectively.
+qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
 qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a size
-You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and terabytes.
+qemu-img: Parameter 'size' expects a non-negative number below 2^64
+Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
+and exabytes, respectively.
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 == Check correct interpretation of suffixes for cluster size ==
-- 
2.9.3
