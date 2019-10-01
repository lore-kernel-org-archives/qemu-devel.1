Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA1FC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFB620815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFB620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTmD-0003Ga-Lj
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRwT-0005mE-7J
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRwR-00074Z-JF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:52:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47096
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRwJ-0006wB-VJ; Tue, 01 Oct 2019 19:52:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NpmTl140377; Tue, 1 Oct 2019 19:52:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4dgx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:52:17 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NmOrc133005;
 Tue, 1 Oct 2019 19:48:24 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4de13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:23 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlOr031629;
 Tue, 1 Oct 2019 23:47:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlL7E44302732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B476B2805E;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9790728058;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:21 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/97] iotests.py: do not use infinite waits
Date: Tue,  1 Oct 2019 18:44:58 -0500
Message-Id: <20191001234616.7825-20-mdroth@linux.vnet.ibm.com>
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
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010204
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Cap waits to 60 seconds so that iotests can fail gracefully if something
goes wrong.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-3-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 8b6f5f8b9f3bec5cbeebefab34bae0102a2581b3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8b209ea0ee..8061f01ade 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -521,7 +521,7 @@ class VM(qtest.QEMUQtestMachine):
             output_list += [key + '=' + obj[key]]
         return ','.join(output_list)
 
-    def get_qmp_events_filtered(self, wait=True):
+    def get_qmp_events_filtered(self, wait=60.0):
         result = []
         for ev in self.get_qmp_events(wait=wait):
             result.append(filter_qmp_event(ev))
@@ -539,10 +539,10 @@ class VM(qtest.QEMUQtestMachine):
 
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=True, auto_dismiss=False,
-                pre_finalize=None):
+                pre_finalize=None, wait=60.0):
         error = None
         while True:
-            for ev in self.get_qmp_events_filtered(wait=True):
+            for ev in self.get_qmp_events_filtered(wait=wait):
                 if ev['event'] == 'JOB_STATUS_CHANGE':
                     status = ev['data']['status']
                     if status == 'aborting':
@@ -633,7 +633,7 @@ class QMPTestCase(unittest.TestCase):
         self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
                          self.vm.flatten_qmp_object(reference))
 
-    def cancel_and_wait(self, drive='drive0', force=False, resume=False):
+    def cancel_and_wait(self, drive='drive0', force=False, resume=False, wait=60.0):
         '''Cancel a block job and wait for it to finish, returning the event'''
         result = self.vm.qmp('block-job-cancel', device=drive, force=force)
         self.assert_qmp(result, 'return', {})
@@ -644,7 +644,7 @@ class QMPTestCase(unittest.TestCase):
         cancelled = False
         result = None
         while not cancelled:
-            for event in self.vm.get_qmp_events(wait=True):
+            for event in self.vm.get_qmp_events(wait=wait):
                 if event['event'] == 'BLOCK_JOB_COMPLETED' or \
                    event['event'] == 'BLOCK_JOB_CANCELLED':
                     self.assert_qmp(event, 'data/device', drive)
@@ -657,10 +657,10 @@ class QMPTestCase(unittest.TestCase):
         self.assert_no_active_block_jobs()
         return result
 
-    def wait_until_completed(self, drive='drive0', check_offset=True):
+    def wait_until_completed(self, drive='drive0', check_offset=True, wait=60.0):
         '''Wait for a block job to finish, returning the event'''
         while True:
-            for event in self.vm.get_qmp_events(wait=True):
+            for event in self.vm.get_qmp_events(wait=wait):
                 if event['event'] == 'BLOCK_JOB_COMPLETED':
                     self.assert_qmp(event, 'data/device', drive)
                     self.assert_qmp_absent(event, 'data/error')
-- 
2.17.1


