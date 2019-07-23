Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C889C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B542239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B542239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyAv-0005fi-FN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAE-00041K-Ag
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAC-00055V-U5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAC-00054q-Lx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkhp3127141
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:19 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60rgmq2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:19 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:19 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:17 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1GLi40108418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BA41BE053;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2039FBE05D;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:40 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-8235-0000-0000-00000EBD2A9D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-8236-0000-0000-000046842498
Message-Id: <20190723170104.4327-13-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 12/36] block: Fix invalidate_cache error path
 for parent activation
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

bdrv_co_invalidate_cache() clears the BDRV_O_INACTIVE flag before
actually activating a node so that the correct permissions etc. are
taken. In case of errors, the flag must be restored so that the next
call to bdrv_co_invalidate_cache() retries activation.

Restoring the flag was missing in the error path for a failed
parent->role->activate() call. The consequence is that this attempt to
activate all images correctly fails because we still set errp, however
on the next attempt BDRV_O_INACTIVE is already clear, so we return
success without actually retrying the failed action.

An example where this is observable in practice is migration to a QEMU
instance that has a raw format block node attached to a guest device
with share-rw=off (the default) while another process holds
BLK_PERM_WRITE for the same image. In this case, all activation steps
before parent->role->activate() succeed because raw can tolerate other
writers to the image. Only the parent callback (in particular
blk_root_activate()) tries to implement the share-rw=on property and
requests exclusive write permissions. This fails when the migration
completes and correctly displays an error. However, a manual 'cont' will
incorrectly resume the VM without calling blk_root_activate() again.

This case is described in more detail in the following bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=1531888

Fix this by correctly restoring the BDRV_O_INACTIVE flag in the error
path.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 78fc3b3a26c145eebcdee992988644974b243a74)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index 811239ca23..1ec4512d1e 100644
--- a/block.c
+++ b/block.c
@@ -4553,6 +4553,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (parent->role->activate) {
             parent->role->activate(parent, &local_err);
             if (local_err) {
+                bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
                 return;
             }
-- 
2.17.1


