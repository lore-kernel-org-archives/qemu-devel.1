Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037EB21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037EB21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6Cq-0005Re-7o
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p7-0000Ua-QC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p6-00021T-DY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8890
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5p6-00021I-8M; Tue, 05 Nov 2019 15:53:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpWNf040464; Tue, 5 Nov 2019 15:53:07 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:07 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kr7lG044112;
 Tue, 5 Nov 2019 15:53:07 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:07 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnujQ006011;
 Tue, 5 Nov 2019 20:53:06 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 2w11e7hgct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:06 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr5pl27853122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849C912405B;
 Tue,  5 Nov 2019 20:53:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72B66124052;
 Tue,  5 Nov 2019 20:53:05 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:05 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/55] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Date: Tue,  5 Nov 2019 14:52:20 -0600
Message-Id: <20191105205243.3766-33-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

qcow2_detect_metadata_preallocation() calls qcow2_get_refcount() which
requires s->lock to be taken to protect its accesses to the refcount
table and refcount blocks. However, nothing in this code path actually
took the lock. This could cause the same cache entry to be used by two
requests at the same time, for different tables at different offsets,
resulting in image corruption.

As it would be preferable to base the detection on consistent data (even
though it's just heuristics), let's take the lock not only around the
qcow2_get_refcount() calls, but around the whole function.

This patch takes the lock in qcow2_co_block_status() earlier and asserts
in qcow2_detect_metadata_preallocation() that we hold the lock.

Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
Cc: qemu-stable@nongnu.org
Reported-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 5e9785505210e2477e590e61b1ab100d0ec22b01)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2-refcount.c | 2 ++
 block/qcow2.c          | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index ef965d7895..0d64bf5a5e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3455,6 +3455,8 @@ int qcow2_detect_metadata_preallocation(BlockDriverState *bs)
     int64_t i, end_cluster, cluster_count = 0, threshold;
     int64_t file_length, real_allocation, real_clusters;
 
+    qemu_co_mutex_assert_locked(&s->lock);
+
     file_length = bdrv_getlength(bs->file->bs);
     if (file_length < 0) {
         return file_length;
diff --git a/block/qcow2.c b/block/qcow2.c
index 865839682c..c0f5439dc8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1899,6 +1899,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     unsigned int bytes;
     int status = 0;
 
+    qemu_co_mutex_lock(&s->lock);
+
     if (!s->metadata_preallocation_checked) {
         ret = qcow2_detect_metadata_preallocation(bs);
         s->metadata_preallocation = (ret == 1);
@@ -1906,7 +1908,6 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
 
     bytes = MIN(INT_MAX, count);
-    qemu_co_mutex_lock(&s->lock);
     ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
-- 
2.17.1


