Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AADC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C4C2070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C4C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSum-0007k7-Ml
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tX-Cw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsK-0002N5-3K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18732
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsJ-0001pm-CV; Tue, 01 Oct 2019 19:48:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPS4037480; Tue, 1 Oct 2019 19:47:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcer2b36k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:44 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nlio5038437;
 Tue, 1 Oct 2019 19:47:44 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcer2b36a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:44 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlJa006377;
 Tue, 1 Oct 2019 23:47:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 2v9y57ye8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlh6O47382828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67A0F2805C;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C13E28058;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/97] block/backup: simplify
 backup_incremental_init_copy_bitmap
Date: Tue,  1 Oct 2019 18:45:37 -0500
Message-Id: <20191001234616.7825-59-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Simplify backup_incremental_init_copy_bitmap using the function
bdrv_dirty_bitmap_next_dirty_area.

Note: move to job->len instead of bitmap size: it should not matter but
less code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit c2da3413c021398152e98022261bb1643276a2fe)
*prereq for 4a5b91ca
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9988753249..d9f5db18ac 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -403,43 +403,27 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 /* init copy_bitmap from sync_bitmap */
 static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 {
-    BdrvDirtyBitmapIter *dbi;
-    int64_t offset;
-    int64_t end = DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap),
-                               job->cluster_size);
-
-    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
-    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
-        int64_t cluster = offset / job->cluster_size;
-        int64_t next_cluster;
-
-        offset += bdrv_dirty_bitmap_granularity(job->sync_bitmap);
-        if (offset >= bdrv_dirty_bitmap_size(job->sync_bitmap)) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    uint64_t offset = 0;
+    uint64_t bytes = job->len;
 
-        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset,
-                                             UINT64_MAX);
-        if (offset == -1) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
+                                             &offset, &bytes))
+    {
+        uint64_t cluster = offset / job->cluster_size;
+        uint64_t end_cluster = DIV_ROUND_UP(offset + bytes, job->cluster_size);
 
-        next_cluster = DIV_ROUND_UP(offset, job->cluster_size);
-        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster);
-        if (next_cluster >= end) {
+        hbitmap_set(job->copy_bitmap, cluster, end_cluster - cluster);
+
+        offset = end_cluster * job->cluster_size;
+        if (offset >= job->len) {
             break;
         }
-
-        bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
+        bytes = job->len - offset;
     }
 
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
         job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
-
-    bdrv_dirty_iter_free(dbi);
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
-- 
2.17.1


