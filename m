Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA1C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2DB2239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2DB2239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyF3-0003q8-Fl
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBE-0007TZ-AS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBC-00062R-5s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16318
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyBA-0005ob-4C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NH25VM048740
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:08 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx61fghbd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:06 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:29 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:27 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1QuV60555624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCECBE062;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8D50BE058;
 Tue, 23 Jul 2019 17:01:25 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:25 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:01:02 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-0004-0000-0000-0000152DB9B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0005-0000-0000-00008C9463C7
Message-Id: <20190723170104.4327-35-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 34/36] block/file-posix: Unaligned O_DIRECT
 block-status
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Currently, qemu crashes whenever someone queries the block status of an
unaligned image tail of an O_DIRECT image:
$ echo > foo
$ qemu-img map --image-opts driver=file,filename=foo,cache.direct=on
Offset          Length          Mapped to       File
qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
failed.

This is because bdrv_co_block_status() checks that the result returned
by the driver's implementation is aligned to the request_alignment, but
file-posix can fail to do so, which is actually mentioned in a comment
there: "[...] possibly including a partial sector at EOF".

Fix this by rounding up those partial sectors.

There are two possible alternative fixes:
(1) We could refuse to open unaligned image files with O_DIRECT
    altogether.  That sounds reasonable until you realize that qcow2
    does necessarily not fill up its metadata clusters, and that nobody
    runs qemu-img create with O_DIRECT.  Therefore, unpreallocated qcow2
    files usually have an unaligned image tail.

(2) bdrv_co_block_status() could ignore unaligned tails.  It actually
    throws away everything past the EOF already, so that sounds
    reasonable.
    Unfortunately, the block layer knows file lengths only with a
    granularity of BDRV_SECTOR_SIZE, so bdrv_co_block_status() usually
    would have to guess whether its file length information is inexact
    or whether the driver is broken.

Fixing what raw_co_block_status() returns is the safest thing to do.

There seems to be no other block driver that sets request_alignment and
does not make sure that it always returns aligned values.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 9c3db310ff0b7473272ae8dce5e04e2f8a825390)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/file-posix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bbdab953..df467f510b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2461,6 +2461,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     off_t data = 0, hole = 0;
     int ret;
 
+    assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+
     ret = fd_open(bs);
     if (ret < 0) {
         return ret;
@@ -2486,6 +2488,20 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         /* On a data extent, compute bytes to the end of the extent,
          * possibly including a partial sector at EOF. */
         *pnum = MIN(bytes, hole - offset);
+
+        /*
+         * We are not allowed to return partial sectors, though, so
+         * round up if necessary.
+         */
+        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
+            int64_t file_length = raw_getlength(bs);
+            if (file_length > 0) {
+                /* Ignore errors, this is just a safeguard */
+                assert(hole == file_length);
+            }
+            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
+        }
+
         ret = BDRV_BLOCK_DATA;
     } else {
         /* On a hole, compute bytes to the beginning of the next extent.  */
-- 
2.17.1


