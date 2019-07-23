Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDDC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE642239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE642239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyEU-0001X2-84
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAX-0004wU-4D
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAU-0005NN-As
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27330
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAU-0005Et-27
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkh5g066494
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:27 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60s8n6j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:27 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:26 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:24 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1NMO30736704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FD6DBE051;
 Tue, 23 Jul 2019 17:01:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A3E0BE053;
 Tue, 23 Jul 2019 17:01:23 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:23 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:57 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-0012-0000-0000-000017557611
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0013-0000-0000-0000582F964A
Message-Id: <20190723170104.4327-30-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 29/36] block: Fix AioContext switch for bs->drv
 == NULL
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

Even for block nodes with bs->drv == NULL, we can't just ignore a
bdrv_set_aio_context() call. Leaving the node in its old context can
mean that it's still in an iothread context in bdrv_close_all() during
shutdown, resulting in an attempted unlock of the AioContext lock which
we don't hold.

This is an example stack trace of a related crash:

 #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
 #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
 #2  0x0000555555b97b1e in error_exit (err=<optimized out>, msg=msg@entry=0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:36
 #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=mutex@entry=0x5555568002f0, file=file@entry=0x555555d378df "util/async.c", line=line@entry=507) at util/qemu-thread-posix.c:97
 #4  0x0000555555b92f55 in aio_context_release (ctx=ctx@entry=0x555556800290) at util/async.c:507
 #5  0x0000555555b05cf8 in bdrv_prwv_co (child=child@entry=0x7fffc80012f0, offset=offset@entry=131072, qiov=qiov@entry=0x7fffffffd4f0, is_write=is_write@entry=true, flags=flags@entry=0)
         at block/io.c:833
 #6  0x0000555555b060a9 in bdrv_pwritev (qiov=0x7fffffffd4f0, offset=131072, child=0x7fffc80012f0) at block/io.c:990
 #7  0x0000555555b060a9 in bdrv_pwrite (child=0x7fffc80012f0, offset=131072, buf=<optimized out>, bytes=<optimized out>) at block/io.c:990
 #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568cc740, i=i@entry=0) at block/qcow2-cache.c:51
 #9  0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568cc740) at block/qcow2-cache.c:248
 #10 0x0000555555ae15de in qcow2_cache_flush (bs=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
 #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=0x5555568a1700, c=0x5555568a1700, bs=0x555556810680) at block/qcow2-cache.c:194
 #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568a1700, i=i@entry=0) at block/qcow2-cache.c:194
 #13 0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568a1700) at block/qcow2-cache.c:248
 #14 0x0000555555ae15de in qcow2_cache_flush (bs=bs@entry=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
 #15 0x0000555555ad242c in qcow2_inactivate (bs=bs@entry=0x555556810680) at block/qcow2.c:2124
 #16 0x0000555555ad2590 in qcow2_close (bs=0x555556810680) at block/qcow2.c:2153
 #17 0x0000555555ab0c62 in bdrv_close (bs=0x555556810680) at block.c:3358
 #18 0x0000555555ab0c62 in bdrv_delete (bs=0x555556810680) at block.c:3542
 #19 0x0000555555ab0c62 in bdrv_unref (bs=0x555556810680) at block.c:4598
 #20 0x0000555555af4d72 in blk_remove_bs (blk=blk@entry=0x5555568103d0) at block/block-backend.c:785
 #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.c:483
 #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
 #23 0x00005555557f9796 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4776

The reproducer I used is a qcow2 image on gluster volume, where the
virtual disk size (4 GB) is larger than the gluster volume size (64M),
so we can easily trigger an ENOSPC. This backend is assigned to a
virtio-blk device using an iothread, and then from the guest a
'dd if=/dev/zero of=/dev/vda bs=1G count=1' causes the VM to stop
because of an I/O error. qemu_gluster_co_flush_to_disk() sets
bs->drv = NULL on error, so when virtio-blk stops the dataplane, the
block nodes stay in the iothread AioContext. A 'quit' monitor command
issued from this paused state crashes the process.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1631227
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
(cherry picked from commit 1bffe1ae7a7b707c3a14ea2ccd00d3609d3ce4d8)
*drop context dependency on e64f25f30b8
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 1ec4512d1e..3405a652a3 100644
--- a/block.c
+++ b/block.c
@@ -5056,10 +5056,6 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
     BdrvAioNotifier *baf, *baf_tmp;
     BdrvChild *child;
 
-    if (!bs->drv) {
-        return;
-    }
-
     assert(!bs->walking_aio_notifiers);
     bs->walking_aio_notifiers = true;
     QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
@@ -5074,7 +5070,7 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
      */
     bs->walking_aio_notifiers = false;
 
-    if (bs->drv->bdrv_detach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_detach_aio_context) {
         bs->drv->bdrv_detach_aio_context(bs);
     }
     QLIST_FOREACH(child, &bs->children, next) {
@@ -5090,16 +5086,12 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     BdrvAioNotifier *ban, *ban_tmp;
     BdrvChild *child;
 
-    if (!bs->drv) {
-        return;
-    }
-
     bs->aio_context = new_context;
 
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_attach_aio_context(child->bs, new_context);
     }
-    if (bs->drv->bdrv_attach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_attach_aio_context) {
         bs->drv->bdrv_attach_aio_context(bs, new_context);
     }
 
-- 
2.17.1


