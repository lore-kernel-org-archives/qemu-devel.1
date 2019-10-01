Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B4C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2A020818
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2A020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTIS-0004zC-N8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tu-JN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0002Nw-5J
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsJ-0001pz-Bo; Tue, 01 Oct 2019 19:48:11 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlMwx193511; Tue, 1 Oct 2019 19:47:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:46 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlO7L193565;
 Tue, 1 Oct 2019 19:47:46 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:46 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkYJ031624;
 Tue, 1 Oct 2019 23:47:44 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:44 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NliIp47972612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C7F52805E;
 Tue,  1 Oct 2019 23:47:44 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 507472805A;
 Tue,  1 Oct 2019 23:47:44 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:44 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/97] block/backup: refactor and tolerate unallocated cluster
 skipping
Date: Tue,  1 Oct 2019 18:45:39 -0500
Message-Id: <20191001234616.7825-61-mdroth@linux.vnet.ibm.com>
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

Split allocation checking to separate function and reduce nesting.
Consider bdrv_is_allocated() fail as allocated area, as copying more
than needed is not wrong (and we do it anyway) and seems better than
fail the whole job. And, most probably we will fail on the next read,
if there are real problem with source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 9eb5a248f3e50c1f034bc6ff4b2f25c8c56515a5)
*prereq for 110571be4e
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c | 60 +++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 510fc54f98..298e85f1a9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -377,6 +377,22 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
     return false;
 }
 
+static bool bdrv_is_unallocated_range(BlockDriverState *bs,
+                                      int64_t offset, int64_t bytes)
+{
+    int64_t end = offset + bytes;
+
+    while (offset < end && !bdrv_is_allocated(bs, offset, bytes, &bytes)) {
+        if (bytes == 0) {
+            return true;
+        }
+        offset += bytes;
+        bytes = end - offset;
+    }
+
+    return offset >= end;
+}
+
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
@@ -462,49 +478,19 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         for (offset = 0; offset < s->len;
              offset += s->cluster_size) {
             bool error_is_read;
-            int alloced = 0;
 
             if (yield_and_check(s)) {
                 break;
             }
 
-            if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
-                int i;
-                int64_t n;
-
-                /* Check to see if these blocks are already in the
-                 * backing file. */
-
-                for (i = 0; i < s->cluster_size;) {
-                    /* bdrv_is_allocated() only returns true/false based
-                     * on the first set of sectors it comes across that
-                     * are are all in the same state.
-                     * For that reason we must verify each sector in the
-                     * backup cluster length.  We end up copying more than
-                     * needed but at some point that is always the case. */
-                    alloced =
-                        bdrv_is_allocated(bs, offset + i,
-                                          s->cluster_size - i, &n);
-                    i += n;
-
-                    if (alloced || n == 0) {
-                        break;
-                    }
-                }
-
-                /* If the above loop never found any sectors that are in
-                 * the topmost image, skip this backup. */
-                if (alloced == 0) {
-                    continue;
-                }
-            }
-            /* FULL sync mode we copy the whole drive. */
-            if (alloced < 0) {
-                ret = alloced;
-            } else {
-                ret = backup_do_cow(s, offset, s->cluster_size,
-                                    &error_is_read, false);
+            if (s->sync_mode == MIRROR_SYNC_MODE_TOP &&
+                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
+            {
+                continue;
             }
+
+            ret = backup_do_cow(s, offset, s->cluster_size,
+                                &error_is_read, false);
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
                 BlockErrorAction action =
-- 
2.17.1


