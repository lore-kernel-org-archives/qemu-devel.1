Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUD2-000269-Rk
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCz-0006PJ-CY
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34611
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCz-0006Oi-4e
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E7ZK043799
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:44 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpf0j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:44 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:44 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:42 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-8-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/79] iotests/051: Add test for empty filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 42dc10f17a7f1754d419e715114c37f5c5fde12f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/051        | 1 +
 tests/qemu-iotests/051.out    | 3 +++
 tests/qemu-iotests/051.pc.out | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 630cb7a..4fe6760 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -231,6 +231,7 @@ echo === Leaving out required options ===
 echo
 
 run_qemu -drive driver=file
+run_qemu -drive driver=file,filename=
 run_qemu -drive driver=nbd
 run_qemu -drive driver=raw
 run_qemu -drive file.driver=file
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 7524c62..57bee08 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -221,6 +221,9 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive driver=file
 QEMU_PROG: -drive driver=file: The 'file' block driver requires a file name
 
+Testing: -drive driver=file,filename=
+QEMU_PROG: -drive driver=file,filename=: The 'file' block driver requires a file name
+
 Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index c6f4eef..19426e5 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -319,6 +319,9 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive driver=file
 QEMU_PROG: -drive driver=file: The 'file' block driver requires a file name
 
+Testing: -drive driver=file,filename=
+QEMU_PROG: -drive driver=file,filename=: The 'file' block driver requires a file name
+
 Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
-- 
2.7.4
