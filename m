Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F11C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AD820815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AD820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFT93-0004SL-Ih
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tW-Do
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0002PB-MM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsK-0001uH-7Z; Tue, 01 Oct 2019 19:48:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlRGL086518; Tue, 1 Oct 2019 19:47:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat8108-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:51 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nloh2087187;
 Tue, 1 Oct 2019 19:47:50 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat80yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:50 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlTH022434;
 Tue, 1 Oct 2019 23:47:49 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 2v9y57yd7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlnOD35520934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF6528058;
 Tue,  1 Oct 2019 23:47:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E501A2805A;
 Tue,  1 Oct 2019 23:47:48 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:48 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/97] iotests: Test unaligned blocking mirror write
Date: Tue,  1 Oct 2019 18:45:47 -0500
Message-Id: <20191001234616.7825-69-mdroth@linux.vnet.ibm.com>
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190805113526.20319-1-mreitz@redhat.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 19ba4651fe2d17cc49adae29acbb4a8cc29db8d1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/151     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 1bb74d67c4..ad7359fc8d 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -114,6 +114,31 @@ class TestActiveMirror(iotests.QMPTestCase):
     def testActiveIOFlushed(self):
         self.doActiveIO(True)
 
+    def testUnalignedActiveIO(self):
+        # Fill the source image
+        result = self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
+
+        # Start the block job (very slowly)
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             filter_node_name='mirror-node',
+                             device='source-node',
+                             target='target-node',
+                             sync='full',
+                             copy_mode='write-blocking',
+                             buf_size=(1048576 // 4),
+                             speed=1)
+        self.assert_qmp(result, 'return', {})
+
+        # Start an unaligned request to a dirty area
+        result = self.vm.hmp_qemu_io('source', 'write -P 2 %i 1' % (1048576 + 42))
+
+        # Let the job finish
+        result = self.vm.qmp('block-job-set-speed', device='mirror', speed=0)
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait(drive='mirror')
+
+        self.potential_writes_in_flight = False
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.17.1


