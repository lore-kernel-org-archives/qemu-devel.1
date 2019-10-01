Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56057ECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D96120818
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D96120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49507 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFS3L-0003Lr-Pr
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 19:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrj-00018C-0K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrb-0001Js-FW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRra-0001He-U6; Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlOat053387; Tue, 1 Oct 2019 19:47:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg17160g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:24 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlO5Q053078;
 Tue, 1 Oct 2019 19:47:24 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg171600-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njlt0032690;
 Tue, 1 Oct 2019 23:47:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 2v9y57qb69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlLLu44302728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 306A728059;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D3828058;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/97] iotests: Test commit job start with concurrent I/O
Date: Tue,  1 Oct 2019 18:44:57 -0500
Message-Id: <20191001234616.7825-19-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

This tests that concurrent requests are correctly drained before making
graph modifications instead of running into assertions in
bdrv_replace_node().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit ac6fb43eae1f5029b51e0a3d975fe2111cc8b976)
 Conflicts:
	tests/qemu-iotests/group
*prereq for d81e1efb tests
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/255        | 83 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/255.out    | 16 +++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 10 ++++-
 4 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
new file mode 100755
index 0000000000..c0bb37a9b0
--- /dev/null
+++ b/tests/qemu-iotests/255
@@ -0,0 +1,83 @@
+#!/usr/bin/env python
+#
+# Test commit job graph modifications while requests are active
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import iotests
+from iotests import imgfmt
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+def blockdev_create(vm, options):
+    result = vm.qmp_log('blockdev-create',
+                        filters=[iotests.filter_qmp_testfiles],
+                        job_id='job0', options=options)
+
+    if 'return' in result:
+        assert result['return'] == {}
+        vm.run_job('job0')
+    iotests.log("")
+
+with iotests.FilePath('t.qcow2') as disk_path, \
+     iotests.FilePath('t.qcow2.mid') as mid_path, \
+     iotests.FilePath('t.qcow2.base') as base_path, \
+     iotests.VM() as vm:
+
+    iotests.log("=== Create backing chain and start VM ===")
+    iotests.log("")
+
+    size = 128 * 1024 * 1024
+    size_str = str(size)
+
+    iotests.create_image(base_path, size)
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, mid_path, size_str)
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, disk_path, size_str)
+
+    # Create a backing chain like this:
+    # base <- [throttled: bps-read=4096] <- mid <- overlay
+
+    vm.add_object('throttle-group,x-bps-read=4096,id=throttle0')
+    vm.add_blockdev('file,filename=%s,node-name=base' % (base_path))
+    vm.add_blockdev('throttle,throttle-group=throttle0,file=base,node-name=throttled')
+    vm.add_blockdev('file,filename=%s,node-name=mid-file' % (mid_path))
+    vm.add_blockdev('qcow2,file=mid-file,node-name=mid,backing=throttled')
+    vm.add_drive_raw('if=none,id=overlay,driver=qcow2,file=%s,backing=mid' % (disk_path))
+
+    vm.launch()
+
+    iotests.log("=== Start background read requests ===")
+    iotests.log("")
+
+    def start_requests():
+        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
+        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
+
+    start_requests()
+
+    iotests.log("=== Run a commit job ===")
+    iotests.log("")
+
+    result = vm.qmp_log('block-commit', job_id='job0', auto_finalize=False,
+                        device='overlay', top_node='mid')
+
+    vm.run_job('job0', auto_finalize=False, pre_finalize=start_requests,
+                auto_dismiss=True)
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
new file mode 100644
index 0000000000..9a2d7cbb77
--- /dev/null
+++ b/tests/qemu-iotests/255.out
@@ -0,0 +1,16 @@
+=== Create backing chain and start VM ===
+
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+
+=== Start background read requests ===
+
+=== Run a commit job ===
+
+{"execute": "block-commit", "arguments": {"auto-finalize": false, "device": "overlay", "job-id": "job0", "top-node": "mid"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "job0"}}
+{"return": {}}
+{"data": {"id": "job0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "job0", "len": 134217728, "offset": 134217728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 4cd2fe80a6..19e2bb3aec 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -249,3 +249,4 @@
 247 rw auto quick
 248 rw auto quick
 253 rw auto quick
+255 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 997dc910cb..8b209ea0ee 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -126,6 +126,11 @@ def qemu_img_pipe(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return subp.communicate()[0]
 
+def qemu_img_log(*args):
+    result = qemu_img_pipe(*args)
+    log(result, filters=[filter_testfiles])
+    return result
+
 def img_info_log(filename, filter_path=None, imgopts=False, extra_args=[]):
     args = [ 'info' ]
     if imgopts:
@@ -533,7 +538,8 @@ class VM(qtest.QEMUQtestMachine):
         return result
 
     # Returns None on success, and an error string on failure
-    def run_job(self, job, auto_finalize=True, auto_dismiss=False):
+    def run_job(self, job, auto_finalize=True, auto_dismiss=False,
+                pre_finalize=None):
         error = None
         while True:
             for ev in self.get_qmp_events_filtered(wait=True):
@@ -546,6 +552,8 @@ class VM(qtest.QEMUQtestMachine):
                                 error = j['error']
                                 log('Job failed: %s' % (j['error']))
                     elif status == 'pending' and not auto_finalize:
+                        if pre_finalize:
+                            pre_finalize()
                         self.qmp_log('job-finalize', id=job)
                     elif status == 'concluded' and not auto_dismiss:
                         self.qmp_log('job-dismiss', id=job)
-- 
2.17.1


