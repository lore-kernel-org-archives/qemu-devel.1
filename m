Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB3C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF08020B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF08020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFU3V-00050x-Mr
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsz-0002MH-3r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsx-0003Ci-3N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32100
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsv-0002fZ-5A; Tue, 01 Oct 2019 19:48:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmMfp132829; Tue, 1 Oct 2019 19:48:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4ded0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:26 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NmQaS133438;
 Tue, 1 Oct 2019 19:48:26 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdj4de64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkEN027150;
 Tue, 1 Oct 2019 23:47:47 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:47 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlkwx41746920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 733F428058;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57AD52805A;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 63/97] backup: Copy only dirty areas
Date: Tue,  1 Oct 2019 18:45:42 -0500
Message-Id: <20191001234616.7825-64-mdroth@linux.vnet.ibm.com>
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The backup job must only copy areas that the copy_bitmap reports as
dirty.  This is always the case when using traditional non-offloading
backup, because it copies each cluster separately.  When offloading the
copy operation, we sometimes copy more than one cluster at a time, but
we only check whether the first one is dirty.

Therefore, whenever copy offloading is possible, the backup job
currently produces wrong output when the guest writes to an area of
which an inner part has already been backed up, because that inner part
will be re-copied.

Fixes: 9ded4a0114968e98b41494fc035ba14f84cdf700
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190801173900.23851-2-mreitz@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 4a5b91ca024fc6fd87021c54655af76a35f2ef1e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d1b94a6dbe..f67c208cf0 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -204,22 +204,31 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     while (start < end) {
+        int64_t dirty_end;
+
         if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start += job->cluster_size;
             continue; /* already copied */
         }
 
+        dirty_end = hbitmap_next_zero(job->copy_bitmap, start, (end - start));
+        if (dirty_end < 0) {
+            dirty_end = end;
+        }
+
         trace_backup_do_cow_process(job, start);
 
         if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, end, is_write_notifier);
+            ret = backup_cow_with_offload(job, start, dirty_end,
+                                          is_write_notifier);
             if (ret < 0) {
                 job->use_copy_range = false;
             }
         }
         if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, end, is_write_notifier,
+            ret = backup_cow_with_bounce_buffer(job, start, dirty_end,
+                                                is_write_notifier,
                                                 error_is_read, &bounce_buffer);
         }
         if (ret < 0) {
-- 
2.17.1


