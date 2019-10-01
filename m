Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DCC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497B420842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497B420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTUU-0000YK-Rj
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsw-0002JN-OR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRst-00038f-AR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14740
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsq-0002XJ-WC; Tue, 01 Oct 2019 19:48:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmMYk132876; Tue, 1 Oct 2019 19:48:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4dec6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:23 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NmMLQ132902;
 Tue, 1 Oct 2019 19:48:22 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4de60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:22 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlKs027161;
 Tue, 1 Oct 2019 23:47:46 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:46 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlj7E55443938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 701E328059;
 Tue,  1 Oct 2019 23:47:45 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 546D528058;
 Tue,  1 Oct 2019 23:47:45 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:45 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/97] block/backup: unify different modes code path
Date: Tue,  1 Oct 2019 18:45:40 -0500
Message-Id: <20191001234616.7825-62-mdroth@linux.vnet.ibm.com>
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

Do full, top and incremental mode copying all in one place. This
unifies the code path and helps further improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-5-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit c334e897d08eea1f5a3a95f6a2208afe6757c103)
*prereq for 110571be4e
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 298e85f1a9..b54386b699 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -393,15 +393,23 @@ static bool bdrv_is_unallocated_range(BlockDriverState *bs,
     return offset >= end;
 }
 
-static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
+static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
     int64_t offset;
     HBitmapIter hbi;
+    BlockDriverState *bs = blk_bs(job->common.blk);
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((offset = hbitmap_iter_next(&hbi)) != -1) {
+        if (job->sync_mode == MIRROR_SYNC_MODE_TOP &&
+            bdrv_is_unallocated_range(bs, offset, job->cluster_size))
+        {
+            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            continue;
+        }
+
         do {
             if (yield_and_check(job)) {
                 return 0;
@@ -446,7 +454,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
@@ -471,38 +478,8 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
              * notify callback service CoW requests. */
             job_yield(job);
         }
-    } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        ret = backup_run_incremental(s);
     } else {
-        /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset = 0; offset < s->len;
-             offset += s->cluster_size) {
-            bool error_is_read;
-
-            if (yield_and_check(s)) {
-                break;
-            }
-
-            if (s->sync_mode == MIRROR_SYNC_MODE_TOP &&
-                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
-            {
-                continue;
-            }
-
-            ret = backup_do_cow(s, offset, s->cluster_size,
-                                &error_is_read, false);
-            if (ret < 0) {
-                /* Depending on error action, fail now or retry cluster */
-                BlockErrorAction action =
-                    backup_error_action(s, error_is_read, -ret);
-                if (action == BLOCK_ERROR_ACTION_REPORT) {
-                    break;
-                } else {
-                    offset -= s->cluster_size;
-                    continue;
-                }
-            }
-        }
+        ret = backup_loop(s);
     }
 
     notifier_with_return_remove(&s->before_write);
-- 
2.17.1


