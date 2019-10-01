Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8BC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6F020842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6F020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSLT-0000yH-JV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrq-0001F3-Jf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrn-0001YW-29
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5626
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrm-0001Ob-LX; Tue, 01 Oct 2019 19:47:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlTdQ179519; Tue, 1 Oct 2019 19:47:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpncr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:29 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlROn179470;
 Tue, 1 Oct 2019 19:47:29 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpncqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:29 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njm5p023587;
 Tue, 1 Oct 2019 23:47:28 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577gxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:28 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlSmv49742256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41B802805C;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 251DA28058;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/97] qcow2: Add errp to preallocate_co()
Date: Tue,  1 Oct 2019 18:44:41 -0500
Message-Id: <20191001234616.7825-3-mdroth@linux.vnet.ibm.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

We'll add a bdrv_co_truncate() call in the next patch which can return
an Error that we don't want to discard. So add an errp parameter to
preallocate_co().

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 360bd07471dfd1830246e8403ffdc9ba9d82f9d4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dfac74c264..b4f9f5a240 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2721,7 +2721,7 @@ static int qcow2_set_up_encryption(BlockDriverState *bs,
  * Returns: 0 on success, -errno on failure.
  */
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t new_length)
+                                       uint64_t new_length, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
@@ -2738,6 +2738,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Allocating clusters failed");
             return ret;
         }
 
@@ -2746,6 +2747,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
 
             ret = qcow2_alloc_cluster_link_l2(bs, meta);
             if (ret < 0) {
+                error_setg_errno(errp, -ret, "Mapping clusters failed");
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
                 return ret;
@@ -2775,6 +2777,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
         ret = bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Writing to EOF failed");
             return ret;
         }
     }
@@ -3748,9 +3751,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         break;
 
     case PREALLOC_MODE_METADATA:
-        ret = preallocate_co(bs, old_length, offset);
+        ret = preallocate_co(bs, old_length, offset, errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Preallocation failed");
             goto fail;
         }
         break;
@@ -3766,9 +3768,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
-            ret = preallocate_co(bs, old_length, offset);
+            ret = preallocate_co(bs, old_length, offset, errp);
             if (ret < 0) {
-                error_setg_errno(errp, -ret, "Preallocation failed");
                 goto fail;
             }
             break;
-- 
2.17.1


