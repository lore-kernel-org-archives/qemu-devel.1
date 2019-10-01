Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB362C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0E720842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0E720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSqy-0003uO-An
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tQ-AQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0002O7-5W
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56160
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsJ-0001rk-Ba; Tue, 01 Oct 2019 19:48:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlOgJ098927; Tue, 1 Oct 2019 19:47:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9v2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:49 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nlnhw099831;
 Tue, 1 Oct 2019 19:47:49 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9v2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:49 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlrD001420;
 Tue, 1 Oct 2019 23:47:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03wdc.us.ibm.com with ESMTP id 2v9y56yf88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlmTC11076576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0256C2805A;
 Tue,  1 Oct 2019 23:47:48 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA63228059;
 Tue,  1 Oct 2019 23:47:47 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:47 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/97] iotests: Test incremental backup after truncation
Date: Tue,  1 Oct 2019 18:45:45 -0500
Message-Id: <20191001234616.7825-67-mdroth@linux.vnet.ibm.com>
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
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190805152840.32190-1-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 8a9cb864086269af14bbd13f395472703cf99f8c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/124     | 38 ++++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/124.out |  4 ++--
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 80b356f7bb..3440f54781 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -212,25 +212,28 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         return bitmap
 
 
-    def prepare_backup(self, bitmap=None, parent=None):
+    def prepare_backup(self, bitmap=None, parent=None, **kwargs):
         if bitmap is None:
             bitmap = self.bitmaps[-1]
         if parent is None:
             parent, _ = bitmap.last_target()
 
         target, _ = bitmap.new_target()
-        self.img_create(target, bitmap.drive['fmt'], parent=parent)
+        self.img_create(target, bitmap.drive['fmt'], parent=parent,
+                        **kwargs)
         return target
 
 
     def create_incremental(self, bitmap=None, parent=None,
-                           parentFormat=None, validate=True):
+                           parentFormat=None, validate=True,
+                           target=None):
         if bitmap is None:
             bitmap = self.bitmaps[-1]
         if parent is None:
             parent, _ = bitmap.last_target()
 
-        target = self.prepare_backup(bitmap, parent)
+        if target is None:
+            target = self.prepare_backup(bitmap, parent)
         res = self.do_qmp_backup(job_id=bitmap.drive['id'],
                                  device=bitmap.drive['id'],
                                  sync='incremental', bitmap=bitmap.name,
@@ -572,6 +575,33 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                           'bitmap0', self.drives[0],
                           granularity=64000)
 
+    def test_growing_before_backup(self):
+        '''
+        Test: Add a bitmap, truncate the image, write past the old
+              end, do a backup.
+
+        Incremental backup should not ignore dirty bits past the old
+        image end.
+        '''
+        self.assert_no_active_block_jobs()
+
+        self.create_anchor_backup()
+
+        self.add_bitmap('bitmap0', self.drives[0])
+
+        res = self.vm.qmp('block_resize', device=self.drives[0]['id'],
+                          size=(65 * 1048576))
+        self.assert_qmp(res, 'return', {})
+
+        # Dirty the image past the old end
+        self.vm.hmp_qemu_io(self.drives[0]['id'], 'write 64M 64k')
+
+        target = self.prepare_backup(size='65M')
+        self.create_incremental(target=target)
+
+        self.vm.shutdown()
+        self.check_backups()
+
 
 class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
     '''Incremental backup tests that utilize a BlkDebug filter on drive0.'''
diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
index 281b69efea..fa16b5ccef 100644
--- a/tests/qemu-iotests/124.out
+++ b/tests/qemu-iotests/124.out
@@ -1,5 +1,5 @@
-............
+.............
 ----------------------------------------------------------------------
-Ran 12 tests
+Ran 13 tests
 
 OK
-- 
2.17.1


