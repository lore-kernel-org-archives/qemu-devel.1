Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562CCECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275222133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275222133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFRup-0003wu-8x
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 19:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrd-00017Q-Oy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrb-0001KJ-Lc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrb-0001I5-2Q; Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlQ5X053544; Tue, 1 Oct 2019 19:47:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg17161u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlPsr053508;
 Tue, 1 Oct 2019 19:47:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg17160s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlKX027161;
 Tue, 1 Oct 2019 23:47:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:24 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlNuP43188590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1CD828059;
 Tue,  1 Oct 2019 23:47:23 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 952F728058;
 Tue,  1 Oct 2019 23:47:23 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:23 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/97] iotests.py: rewrite run_job to be pickier
Date: Tue,  1 Oct 2019 18:45:01 -0500
Message-Id: <20191001234616.7825-23-mdroth@linux.vnet.ibm.com>
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Don't pull events out of the queue that don't belong to us;
be choosier so that we can use this method to drive jobs that
were launched by transactions that may have more jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-5-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit d6a79af0e641806d6bd6a42a4920e294b5db179c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/iotests.py | 48 +++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index fa00b61892..a7006662ff 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -540,27 +540,37 @@ class VM(qtest.QEMUQtestMachine):
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=True, auto_dismiss=False,
                 pre_finalize=None, wait=60.0):
+        match_device = {'data': {'device': job}}
+        match_id = {'data': {'id': job}}
+        events = [
+            ('BLOCK_JOB_COMPLETED', match_device),
+            ('BLOCK_JOB_CANCELLED', match_device),
+            ('BLOCK_JOB_ERROR', match_device),
+            ('BLOCK_JOB_READY', match_device),
+            ('BLOCK_JOB_PENDING', match_id),
+            ('JOB_STATUS_CHANGE', match_id)
+        ]
         error = None
         while True:
-            for ev in self.get_qmp_events_filtered(wait=wait):
-                if ev['event'] == 'JOB_STATUS_CHANGE':
-                    status = ev['data']['status']
-                    if status == 'aborting':
-                        result = self.qmp('query-jobs')
-                        for j in result['return']:
-                            if j['id'] == job:
-                                error = j['error']
-                                log('Job failed: %s' % (j['error']))
-                    elif status == 'pending' and not auto_finalize:
-                        if pre_finalize:
-                            pre_finalize()
-                        self.qmp_log('job-finalize', id=job)
-                    elif status == 'concluded' and not auto_dismiss:
-                        self.qmp_log('job-dismiss', id=job)
-                    elif status == 'null':
-                        return error
-                else:
-                    log(ev)
+            ev = filter_qmp_event(self.events_wait(events))
+            if ev['event'] != 'JOB_STATUS_CHANGE':
+                log(ev)
+                continue
+            status = ev['data']['status']
+            if status == 'aborting':
+                result = self.qmp('query-jobs')
+                for j in result['return']:
+                    if j['id'] == job:
+                        error = j['error']
+                        log('Job failed: %s' % (j['error']))
+            elif status == 'pending' and not auto_finalize:
+                if pre_finalize:
+                    pre_finalize()
+                self.qmp_log('job-finalize', id=job)
+            elif status == 'concluded' and not auto_dismiss:
+                self.qmp_log('job-dismiss', id=job)
+            elif status == 'null':
+                return error
 
     def node_info(self, node_name):
         nodes = self.qmp('query-named-block-nodes')
-- 
2.17.1


