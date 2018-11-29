Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSTSs-000629-VY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSTSo-0001dz-Oa
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:03:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50090
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gSTSo-0001XE-I1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:03:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATKwoUX045685
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:03:08 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p2qcmrubf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:03:08 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 29 Nov 2018 21:03:07 -0000
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 29 Nov 2018 16:03:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <faeb4b80-e191-d670-d057-28eb4ac11d11@linux.ibm.com>
Subject: [Qemu-devel] qemu-iotests 232 fails when running the test as root
 user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

I am seeing a failure of the qemu-iotest number 232 when running the 
test as a root user. Is this the expected behavior?

Here is the output of the failure:

sudo ./check -qcow2 232

QEMU          -- 
"/home/alifm/kvmdev/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" 
-nodefaults -machine accel=qtest
QEMU_IMG      -- 
"/home/alifm/kvmdev/qemu/tests/qemu-iotests/../../qemu-img"
QEMU_IO       -- 
"/home/alifm/kvmdev/qemu/tests/qemu-iotests/../../qemu-io"  --cache 
writeback -f qcow2
QEMU_NBD      -- 
"/home/alifm/kvmdev/qemu/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 alifm-ThinkPad-T470p 4.10.0-40-generic
TEST_DIR      -- /home/alifm/kvmdev/qemu/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- 
/home/alifm/kvmdev/qemu/tests/qemu-iotests/socket_scm_helper

232 1s ... - output mismatch (see 232.out.bad)
--- /home/alifm/kvmdev/qemu/tests/qemu-iotests/232.out	2018-11-26 
11:45:58.368023999 -0500
+++ /home/alifm/kvmdev/qemu/tests/qemu-iotests/232.out.bad	2018-11-29 
15:58:41.768561694 -0500
@@ -21,13 +21,13 @@
  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)

-QEMU_PROG: -drive 
driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: 
Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-
-QEMU_PROG: -drive 
driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not 
open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)

  === -blockdev with read-write image: read-only/auto-read-only 
combinations ===

@@ -49,11 +49,11 @@
  node0: TEST_DIR/t.IMGFMT (file, read-only)
  node0: TEST_DIR/t.IMGFMT (file, read-only)

-QEMU_PROG: -blockdev 
driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off,auto-read-only=off: 
Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-QEMU_PROG: -blockdev 
driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off: 
Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)

-QEMU_PROG: -blockdev 
driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,auto-read-only=off: 
Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-QEMU_PROG: -blockdev 
driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0: Could not open 
'TEST_DIR/t.IMGFMT': Permission denied
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
  *** done
Failures: 232
Failed 1 of 1 tests


Thank you
Farhan
