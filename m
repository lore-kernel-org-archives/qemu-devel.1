Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E0CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80B021A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B021A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5uF-0006k2-M7
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p1-0000Iw-CP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p0-0001w5-2l
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5oz-0001vQ-QZ; Tue, 05 Nov 2019 15:53:02 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpWjc144523; Tue, 5 Nov 2019 15:53:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuha5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:00 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kpvb6145777;
 Tue, 5 Nov 2019 15:53:00 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuha51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:00 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5Knuo0000940;
 Tue, 5 Nov 2019 20:52:59 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 2w11e79fg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:52:59 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KqwgV13763472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:52:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE426124058;
 Tue,  5 Nov 2019 20:52:58 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B1D1124052;
 Tue,  5 Nov 2019 20:52:58 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:52:58 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/55] dma-helpers: ensure AIO callback is invoked after
 cancellation
Date: Tue,  5 Nov 2019 14:51:49 -0600
Message-Id: <20191105205243.3766-2-mdroth@linux.vnet.ibm.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

dma_aio_cancel unschedules the BH if there is one, which corresponds
to the reschedule_dma case of dma_blk_cb.  This can stall the DMA
permanently, because dma_complete will never get invoked and therefore
nobody will ever invoke the original AIO callback in dbs->common.cb.

Fix this by invoking the callback (which is ensured to happen after
a bdrv_aio_cancel_async, or done manually in the dbs->bh case), and
add assertions to check that the DMA state machine is indeed waiting
for dma_complete or reschedule_dma, but never both.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20190729213416.1972-1-pbonzini@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 539343c0a47e19d5dd64d846d64d084d9793681f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 dma-helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d35e..d3871dc61e 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -90,6 +90,7 @@ static void reschedule_dma(void *opaque)
 {
     DMAAIOCB *dbs = (DMAAIOCB *)opaque;
 
+    assert(!dbs->acb && dbs->bh);
     qemu_bh_delete(dbs->bh);
     dbs->bh = NULL;
     dma_blk_cb(dbs, 0);
@@ -111,15 +112,12 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
 {
     trace_dma_complete(dbs, ret, dbs->common.cb);
 
+    assert(!dbs->acb && !dbs->bh);
     dma_blk_unmap(dbs);
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, ret);
     }
     qemu_iovec_destroy(&dbs->iov);
-    if (dbs->bh) {
-        qemu_bh_delete(dbs->bh);
-        dbs->bh = NULL;
-    }
     qemu_aio_unref(dbs);
 }
 
@@ -179,14 +177,21 @@ static void dma_aio_cancel(BlockAIOCB *acb)
 
     trace_dma_aio_cancel(dbs);
 
+    assert(!(dbs->acb && dbs->bh));
     if (dbs->acb) {
+        /* This will invoke dma_blk_cb.  */
         blk_aio_cancel_async(dbs->acb);
+        return;
     }
+
     if (dbs->bh) {
         cpu_unregister_map_client(dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh = NULL;
     }
+    if (dbs->common.cb) {
+        dbs->common.cb(dbs->common.opaque, -ECANCELED);
+    }
 }
 
 static AioContext *dma_get_aio_context(BlockAIOCB *acb)
-- 
2.17.1


