Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D7C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBE22133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBE22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTJm-0006sF-Rh
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsq-0002GM-VY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsn-00031g-1a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsi-0002PX-VL; Tue, 01 Oct 2019 19:48:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlUD2053657; Tue, 1 Oct 2019 19:47:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg1716ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:52 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlqhQ054271;
 Tue, 1 Oct 2019 19:47:52 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg1716c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:52 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlC4023568;
 Tue, 1 Oct 2019 23:47:51 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577h0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:51 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlpDJ50725314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:51 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BE2E28058;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E44C42805A;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/97] qcow2: Fix the calculation of the maximum L2 cache size
Date: Tue,  1 Oct 2019 18:45:50 -0500
Message-Id: <20191001234616.7825-72-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

The size of the qcow2 L2 cache defaults to 32 MB, which can be easily
larger than the maximum amount of L2 metadata that the image can have.
For example: with 64 KB clusters the user would need a qcow2 image
with a virtual size of 256 GB in order to have 32 MB of L2 metadata.

Because of that, since commit b749562d9822d14ef69c9eaa5f85903010b86c30
we forbid the L2 cache to become larger than the maximum amount of L2
metadata for the image, calculated using this formula:

    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);

The problem with this formula is that the result should be rounded up
to the cluster size because an L2 table on disk always takes one full
cluster.

For example, a 1280 MB qcow2 image with 64 KB clusters needs exactly
160 KB of L2 metadata, but we need 192 KB on disk (3 clusters) even if
the last 32 KB of those are not going to be used.

However QEMU rounds the numbers down and only creates 2 cache tables
(128 KB), which is not enough for the image.

A quick test doing 4KB random writes on a 1280 MB image gives me
around 500 IOPS, while with the correct cache size I get 16K IOPS.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b70d08205b2e4044c529eefc21df2c8ab61b473b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 840f289a48..c80f48a02b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -831,7 +831,11 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     bool l2_cache_entry_size_set;
     int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
     uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
+    uint64_t max_l2_entries = DIV_ROUND_UP(virtual_disk_size, s->cluster_size);
+    /* An L2 table is always one cluster in size so the max cache size
+     * should be a multiple of the cluster size. */
+    uint64_t max_l2_cache = ROUND_UP(max_l2_entries * sizeof(uint64_t),
+                                     s->cluster_size);
 
     combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
     l2_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
-- 
2.17.1


