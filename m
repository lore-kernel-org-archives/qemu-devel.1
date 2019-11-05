Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C7C5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0ED2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0ED2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5ym-0003PD-Hy
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p6-0000SH-IW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p5-00020Z-2j
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5p4-0001zw-Q1; Tue, 05 Nov 2019 15:53:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpXQB027479; Tue, 5 Nov 2019 15:53:06 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgk8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:05 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KpcRZ027758;
 Tue, 5 Nov 2019 15:53:05 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgk7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:05 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnvDO025654;
 Tue, 5 Nov 2019 20:53:03 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02wdc.us.ibm.com with ESMTP id 2w11e797x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:03 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr3Kx15466832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:03 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F36124054;
 Tue,  5 Nov 2019 20:53:03 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5483012405C;
 Tue,  5 Nov 2019 20:53:03 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:03 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/55] blockjob: update nodes head while removing all bdrv
Date: Tue,  5 Nov 2019 14:52:17 -0600
Message-Id: <20191105205243.3766-30-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
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
Cc: qemu-stable@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

block_job_remove_all_bdrv() iterates through job->nodes, calling
bdrv_root_unref_child() for each entry. The call to the latter may
reach child_job_[can_]set_aio_ctx(), which will also attempt to
traverse job->nodes, potentially finding entries that where freed
on previous iterations.

To avoid this situation, update job->nodes head on each iteration to
ensure that already freed entries are no longer linked to the list.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1746631
Signed-off-by: Sergio Lopez <slp@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190911100316.32282-1-mreitz@redhat.com
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit d876bf676f5e7c6aa9ac64555e48cba8734ecb2f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 blockjob.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 20b7f557da..74abb97bfd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -186,14 +186,23 @@ static const BdrvChildRole child_job = {
 
 void block_job_remove_all_bdrv(BlockJob *job)
 {
-    GSList *l;
-    for (l = job->nodes; l; l = l->next) {
+    /*
+     * bdrv_root_unref_child() may reach child_job_[can_]set_aio_ctx(),
+     * which will also traverse job->nodes, so consume the list one by
+     * one to make sure that such a concurrent access does not attempt
+     * to process an already freed BdrvChild.
+     */
+    while (job->nodes) {
+        GSList *l = job->nodes;
         BdrvChild *c = l->data;
+
+        job->nodes = l->next;
+
         bdrv_op_unblock_all(c->bs, job->blocker);
         bdrv_root_unref_child(c);
+
+        g_slist_free_1(l);
     }
-    g_slist_free(job->nodes);
-    job->nodes = NULL;
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
-- 
2.17.1


