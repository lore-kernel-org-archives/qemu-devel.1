Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB32BC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898F42076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I1/cp/3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898F42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Fx-0000yZ-My
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78T-0006zq-QI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76x-0005G8-Mb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:45 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75n-0003SE-7L; Thu, 30 Apr 2020 07:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytt3M3h8kH7dXTP3iJAhp0vOsXNL7r7O3wnGtWYK7MnVUiTIEXbY9MicMOzYmDOglhqJKdmTtgbJIk9/3oEhw7mF1xQZyXpm5sqEoYNvKMFdaWjpOSte+vBvg05HRzIvJnh5CMI3/9go9HSC2Pvr5kPuljUTtLXXR3AXn3D2tHu3gOoK5HIr6jw/DDk4pMh9oJb2/x4jopjkEM4pkQ+qkZisPVBP+Iq4aHyMTQiRYnN8hZqXZPfb8xOIfJDtWof1ltCdvO+TewJBbfWji6zFArdvBNgDY1y2HUrt1ob9TJJ+HIApvQLNspnoQjvhggb28L81JCi6M3FWD5IbeqnZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQLHfkrzAIN4DFGRA0i6kTfYA/424J/RhqUISyzuxUw=;
 b=djObvAaagqqurE/Yo4zfW0qRTTMmTiiLxTUnlckcYH3nvFNk1nV0oixOb2UJhVF7zw6r+B4ETPSTuiJBzTNQGl9eSBHOMwhkBK1Kyf14mgtHv6kg0WX6b1XadcOpU3D25Vd9hAI+EFQ15lVYEdS3hVirMA4lWAP9tq/iZVs1JGSA9d3JBKk0bj+iDxEJN4ZGxBltLOfdwYky4I0BSpT/lXvWioBuPsoXvOy2ryvyS1BrWvcu3mrzsPVkWI8EVfxIhxKTsBVjB2pqNHRl99Y1ScSf3W1IHi6m3qEjzJkOYDGHwNbtR3MjZ5w/GesCnuS+cLnrdU1OfyMk/2dVVx5EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQLHfkrzAIN4DFGRA0i6kTfYA/424J/RhqUISyzuxUw=;
 b=I1/cp/3PwgjpewMfqthnw3JDuK4X/BN3B5mZJY3XN3qxRyPQNb2k6TzGJro+Bo0NgXQlKEFTSa/3qd5ewDthM8WpIeeR2N/eABxi2OSoJF1EXhXqMR0z/rA/eijMJtdBiPoRI4RhFvis08d6Mk26B0Ol5oha9hj2ADQAt5IEg4o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
Date: Thu, 30 Apr 2020 14:10:22 +0300
Message-Id: <20200430111033.29980-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba11a18-38ab-4867-73b3-08d7ecf727e8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53992E08783704F3A961EFA8C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd2OqrVcuv1RcgdlNUhAhFoHmnZ2yzXWcpao75gHgwRG55DCk5CjQvnMjRJMSYvfxHSl23oIfc49Wqn57uGli5CjgemdpKxOsDisSc4VlvhXwsV5nmkAdik4HhRwkYk5nnaDHMsizm8Doz8kpkjjl7LPFX3c/6Qc/JM5A7pGp+rXiSvjN24e7d4IOs0uEICzuQLXXEZzYAjun4io9UP2V1nBxlJUxfVoqbUJnJkTEwFUi8w1gBUCIMNVx+C7zN36pm27+AxMOk145dtH3s1T9yXqk+0eAWa6d61YEqN+CU6tp3nNDn3tVdJxlCP7kM0UsulxprEvRYhWXKMhY6tfkCCkXGHxZCSC2ibL6jlISIMwVJXvrZTfpQYUZFhpEHzonBsCGY2qlBqR76L2RXSgQXwPfXpeULDf+l+LVOUMaBjJzZncjVT4r4iFURovXQv1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q/NBX88CEPOMwp6B5z3SDRQ1tA6cxNUq6xBsvIxgsQRXAx3bRCtzqs+jYvq+d7A15P3+UdwyQGyY2oQva+wL6p1qdhko2s6RD4enYhvhDLdtM0O6KxSOX8DwxY1ucTN2Y17rsJQdNFLgAcQ80XrMWTcGtkcIRSRu2I4R867OF1NCGAt4XJkG0c7mhL8loS8WyhOxx3FLtCTBxOVsbrvXP5aoxDVI+5yaZSLgBa2qXDcwUiQ3WC/d4cs6rJZ0EQW5jFmdsFrd2tNbfS12C0VEmLM8ZwPjEUZm98tKEh8kYl6JMDH6nY+UooOFsGx0KUXR3HXFv1dgvQXBl21oeTAA2N3DqA3krAPCrJNB+KB5duzA+68nF/f6wc6dhZExWfUI+PqTfNIVi49NBpLH9VRHhQJtEGrrg9lpLPGjiKmFnWaHslJZ75o8M3slE7tSlKUpc7ZkOTnd5yxjv5jututrWhZdMBr1ciLjB4mKaICB+l3RmORH2D3N/4wo1kHcEgD01aMf3ygvBO0O0u4reGgIw+XJAD2BGk8GWXCy4RPcU0u0mxqkd8HVeJXrMfxX1XPPqpXZWQ8/yZ9HMOC7gAxQ/sxO/yBHabHeAl6Csac0VA9DjARJ7cvLz5pvbeErcpOunM+7wCgYJsB8K+3hTyA2ObyDI3ktfGwb4mLSfWn7hw+KWG58CpfZ8n0ATOObFE5e+Ux9chEqtz0iT2EK/NYb2j2EhUvenJBLGrZ6CajtoDU7cxLNvlDyNQrB9t3a8WaFPw1K6brJPrA/XZPS5vMNaOga1a8yQxtG9l2i4LklvHE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba11a18-38ab-4867-73b3-08d7ecf727e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:56.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXIji1iZ2qcpwxJvDVTnyKYv+7BXTJQszQOUYyW/e08Bgh7UK2K8jremcq3T/00+9wovACVXvAPELwHD3kdZislJM5/ICqSTb5PhPdnSY10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:10:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, prepare bdrv_aligned_pwritev() now and convert the dependencies:
bdrv_co_write_req_prepare() and bdrv_co_write_req_finish() to signed
type bytes.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index b83749cc50..8bb4ea6285 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1686,12 +1686,11 @@ fail:
 }
 
 static inline int coroutine_fn
-bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
+bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs = child->bs;
     bool waited;
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
 
     if (bs->read_only) {
         return -EPERM;
@@ -1716,8 +1715,10 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     }
 
     assert(req->overlap_offset <= offset);
+    assert(offset <= INT64_MAX - bytes);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
-    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
+    assert(offset + bytes <= bs->total_sectors * BDRV_SECTOR_SIZE ||
+           child->perm & BLK_PERM_RESIZE);
 
     switch (req->type) {
     case BDRV_TRACKED_WRITE:
@@ -1738,7 +1739,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
 }
 
 static inline void coroutine_fn
-bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
+bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
@@ -1780,14 +1781,14 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
  * after possibly fragmenting it.
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     int ret;
 
-    uint64_t bytes_remaining = bytes;
+    int64_t bytes_remaining = bytes;
     int max_transfer;
 
     if (!drv) {
@@ -1799,6 +1800,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
 
     assert(is_power_of_2(align));
+    assert(offset >= 0);
+    assert(bytes >= 0);
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || qiov_offset + bytes <= qiov->size);
@@ -1899,7 +1902,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes >= align) {
         /* Write the aligned part in the middle. */
-        uint64_t aligned_bytes = bytes & ~(align - 1);
+        int64_t aligned_bytes = bytes & ~(align - 1);
         ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
                                    NULL, 0, flags);
         if (ret < 0) {
-- 
2.21.0


