Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D2C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC52720661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iahpMOvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC52720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT544-00071D-SB
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v8-0008GE-EJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v5-0007lY-N0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:42 -0400
Received: from mail-eopbgr40124.outbound.protection.outlook.com
 ([40.107.4.124]:49833 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v2-0007iT-IO; Mon, 27 Apr 2020 10:39:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaGiq1hvFR483fjKru53lCl9xT3zDWwx5HyuPT20YZ4xrwHs5jjlLuapOKqX2ond2BcJtWU6VdxU7BrpKlU/lfgtLekEbUmQEJYpV7wVqh2QqeSqtu+TPnD0kUxY61oCrrUWyq8DIXTgX3vggbVwM7gE8SUJY3lbtgVkMIIXAEjEZIlLoQDutP887qhVUsdwzGFuntNpjaeQIw9PhL8b5RckyDhMBv4CS9fsDIwtgJzWF0/D6i/VhuWZn7h2P0bN7ZkVbJsNzO10PEEVB/K1BSbW7Cj0Je4UIXx7zJWm3JuXYkXlTt7edIi5C79PRfQRqx0obiD4X/HdXvNjcEyj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ihRWiLKIJVJgQeWrd0GmjsDZuY3P9UqMYNUt5RqTKw=;
 b=ZJLrWjRXrwTh1pVFNosHmV41yqboxPpQvIaqOGWttyF58Z84g/jUKAwDVorSJJyi1/UG/wEwt9PvtA2ZOaBvKEJZJMdaMK1ZgDQjtCxNgTa07W1Zq/nawZLvYRTe26QJ4s4QN8rbp3eMnImonAOZntY1n4BAs2H6L4JltrqAYTSwv7dsOrnmeH3GVpoq7INk6NEihxeQQKz1n59GNslt4b+8Tmh7czsPFFkfJT2j17DrBKR2vsSVPVqfJMQPXH7I+gvd3gKg/1/cSbc1UaFjcmtBTUvp/EzDJtwuzODBCTeecqlZs38ErGx3aOKWjZ+Rmd8MSMTwh2TekejsF8UBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ihRWiLKIJVJgQeWrd0GmjsDZuY3P9UqMYNUt5RqTKw=;
 b=iahpMOvMVPG4FxTyCbmsvck9AD6ydIbQaOn+OwythTPnjiGDDBDwUeYqg1IgoZDwgyIsct/Sr4J+35OtvtMCz+b8sfmEw7T1rS9uyx6jxeoxv9M4w6C9YRzsVzpyrOGDX7CDP11/mFL5UmMhyi+S0G9vt/JGm2BZ2sYpFYlAr3E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/9] block/io: move bdrv_rw_co_entry and friends down
Date: Mon, 27 Apr 2020 17:39:02 +0300
Message-Id: <20200427143907.5710-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ec3f310-36f2-459f-b11a-08d7eab8cd4c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336AEDFF864632F2620CEE0C1AF0@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(478600001)(52116002)(6916009)(2616005)(956004)(4326008)(8676002)(36756003)(107886003)(6666004)(5660300002)(2906002)(316002)(66476007)(6486002)(66946007)(6512007)(8936002)(69590400007)(186003)(6506007)(66556008)(16526019)(26005)(86362001)(1076003)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz3wntPHU6kNhlmNTUKfofIA0jh7LM55vkKeNQQMKXlm5ZptByKcE9FjripJLyBLxJpttZbIyljaagiwsNIjZMtEoN1dU+3MRhtkqOVuuQpf0eL1RiXVpgtpOnfSzV0PE09Puizg1w2RRZ345fwwnBIy2i8oR5JkXjRnxEsOdgPclZBZCQIlveK+Az6wzqyFDVuYaSXYia/xkuHQvYi6avjXs+Tq0N5ue4ENW/7+bF6RSJW/qOY//HxUvNMy84NqNhCrYwnz5q6CtPzdpS1JOI/I2BkjQo+TH++CqdxnQp7e0a0xGcvyPYEZPT0EADTJm3Rfw99tkYQM8FjGr7XewbsuVzjWnSjikTKQRS7E3NYi5RleoU/V7e9ln9lAqUeYQuEV6+FWvAyCcKNPxUkgp4DhR9UYX23SqgD4GpT3LYBKdYI2ktjPwd4tcCF/oJyXQCChfvypsbeWkcfF+49MiDWQq/C4ABm/CfW1216/vip47nPznhzXey52MKYFHxT8
X-MS-Exchange-AntiSpam-MessageData: RVueGdoIEr5xfkTqq5L2IV6Ll2uHqj0kZxEbJoe7Qemn+f9cQsLl2sSRGmlJGQrhssPPzthHQ55NO87oy8S5Laps9Ftd8uqQgoshnIBtEetY99pUGWazpiB6hzQjzKS461oetuwJz+z26piPN5CAQe7JFJiiJQt4HASWWRWN616QOaNzu0wiaVt5aa8X5xg6g3vPV79KUOYM0bZ2oBzat6ctYgf/TReMGrLIrbnjNE38W0vtVFOHpgfY+atcjEbbK3LgiFDtF0TRi6VPkQ0lRO9K/xfXpFq0Q8LBrF0ZLyiXk12w/dafX5z5CsfDjDwvBwoowYl0vTOG/pkAKgy/ycpXS2Zenk+ZQiijRrvgmzbkescd6XAfgRuu43ZmhwCG502IokhgYSbJd1rTNpyjTUsIuYSHBsd7t5YxMe1tgoO8pN3Pfn7zrDopMSiBNiONiMOCxlEkY5sV/+wQB+acs5POft+ReQJY98oZ8b5KIN8c3qwAVdwRp0g1TIlUM4XJbxEeR65RDBfz16N2sk+eNkqL32PilspMC+NFxayY/cYGhBHsNuxFvLGTjYUQ1I9ZvyOOtCUxwXVlCFNGBU+kum8LOnhPuO5jIXPTWwHkMnXR+IEFQK4rBrltZlnCmOYOg8BMGMj7EBuwMt7lR/zuksyMLolNyJSB5mAkTmKWSH1r0KsArTWiKQTjqfTbkB6vy7yPe7r0U89EQ1y6nC5Njz260JiwB3vWa0UlTXXQQPS0TyuFfzjQ8dwmuveP1WDJY9eN5mK6jI+yozJV2biuCbf9ZQn8Nk04i4KjMSZCL9I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec3f310-36f2-459f-b11a-08d7eab8cd4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:33.7721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aweXqm4nqMIOtj9JvRcs2VkvAWv3mWeDZP55MxGEJA0osL4L3CVQgeiGOyL+69a+NS/gWmkFENkPtEW19qpehxFmHb7/K/wXmh5HIU/NmEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.4.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.124
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use bdrv_co_pwritev_part and bdrv_co_preadv_part in
bdrv_rw_co_entry, so move it down.

Note: Comment formatting was changed to conform to coding style and
function order was changed. Otherwise the code is unmodified.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 361 +++++++++++++++++++++++++++--------------------------
 1 file changed, 181 insertions(+), 180 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1134f8144a..061f3f2590 100644
--- a/block/io.c
+++ b/block/io.c
@@ -891,186 +891,6 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-typedef struct RwCo {
-    BdrvChild *child;
-    int64_t offset;
-    QEMUIOVector *qiov;
-    bool is_write;
-    int ret;
-    BdrvRequestFlags flags;
-} RwCo;
-
-static void coroutine_fn bdrv_rw_co_entry(void *opaque)
-{
-    RwCo *rwco = opaque;
-
-    if (!rwco->is_write) {
-        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
-                                   rwco->flags);
-    } else {
-        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
-                                    rwco->flags);
-    }
-    aio_wait_kick();
-}
-
-/*
- * Process a vectored synchronous request using coroutines
- */
-static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
-                        QEMUIOVector *qiov, bool is_write,
-                        BdrvRequestFlags flags)
-{
-    Coroutine *co;
-    RwCo rwco = {
-        .child = child,
-        .offset = offset,
-        .qiov = qiov,
-        .is_write = is_write,
-        .ret = NOT_DONE,
-        .flags = flags,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-    return rwco.ret;
-}
-
-int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags)
-{
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
-
-    return bdrv_prwv_co(child, offset, &qiov, true,
-                        BDRV_REQ_ZERO_WRITE | flags);
-}
-
-/*
- * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
- * The operation is sped up by checking the block status and only writing
- * zeroes to the device if they currently do not return zeroes. Optional
- * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP,
- * BDRV_REQ_FUA).
- *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
- */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
-{
-    int ret;
-    int64_t target_size, bytes, offset = 0;
-    BlockDriverState *bs = child->bs;
-
-    target_size = bdrv_getlength(bs);
-    if (target_size < 0) {
-        return target_size;
-    }
-
-    for (;;) {
-        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
-        if (bytes <= 0) {
-            return 0;
-        }
-        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret & BDRV_BLOCK_ZERO) {
-            offset += bytes;
-            continue;
-        }
-        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
-        if (ret < 0) {
-            return ret;
-        }
-        offset += bytes;
-    }
-}
-
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret = bdrv_prwv_co(child, offset, qiov, false, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
-/* See bdrv_pwrite() for the return codes */
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
-{
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
-    if (bytes < 0) {
-        return -EINVAL;
-    }
-
-    return bdrv_preadv(child, offset, &qiov);
-}
-
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret = bdrv_prwv_co(child, offset, qiov, true, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
-/* Return no. of bytes on success or < 0 on error. Important errors are:
-  -EIO         generic I/O error (may happen for all errors)
-  -ENOMEDIUM   No media inserted.
-  -EINVAL      Invalid offset or number of bytes
-  -EACCES      Trying to write a read-only device
-*/
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
-{
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
-    if (bytes < 0) {
-        return -EINVAL;
-    }
-
-    return bdrv_pwritev(child, offset, &qiov);
-}
-
-/*
- * Writes to the file and ensures that no writes are reordered across this
- * request (acts as a barrier)
- *
- * Returns 0 on success, -errno in error cases.
- */
-int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count)
-{
-    int ret;
-
-    ret = bdrv_pwrite(child, offset, buf, count);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret = bdrv_flush(child->bs);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return 0;
-}
-
 typedef struct CoroutineIOCompletion {
     Coroutine *coroutine;
     int ret;
@@ -2185,6 +2005,187 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
+typedef struct RwCo {
+    BdrvChild *child;
+    int64_t offset;
+    QEMUIOVector *qiov;
+    bool is_write;
+    int ret;
+    BdrvRequestFlags flags;
+} RwCo;
+
+static void coroutine_fn bdrv_rw_co_entry(void *opaque)
+{
+    RwCo *rwco = opaque;
+
+    if (!rwco->is_write) {
+        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
+                                   rwco->qiov->size, rwco->qiov,
+                                   rwco->flags);
+    } else {
+        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
+                                    rwco->qiov->size, rwco->qiov,
+                                    rwco->flags);
+    }
+    aio_wait_kick();
+}
+
+/*
+ * Process a vectored synchronous request using coroutines
+ */
+static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
+                        QEMUIOVector *qiov, bool is_write,
+                        BdrvRequestFlags flags)
+{
+    Coroutine *co;
+    RwCo rwco = {
+        .child = child,
+        .offset = offset,
+        .qiov = qiov,
+        .is_write = is_write,
+        .ret = NOT_DONE,
+        .flags = flags,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_rw_co_entry(&rwco);
+    } else {
+        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
+        bdrv_coroutine_enter(child->bs, co);
+        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
+    }
+    return rwco.ret;
+}
+
+int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
+                       int bytes, BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
+
+    return bdrv_prwv_co(child, offset, &qiov, true,
+                        BDRV_REQ_ZERO_WRITE | flags);
+}
+
+/* See bdrv_pwrite() for the return codes */
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
+{
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    if (bytes < 0) {
+        return -EINVAL;
+    }
+
+    return bdrv_preadv(child, offset, &qiov);
+}
+
+int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
+{
+    int ret;
+
+    ret = bdrv_prwv_co(child, offset, qiov, true, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return qiov->size;
+}
+
+/*
+ * Return no. of bytes on success or < 0 on error. Important errors are:
+ * -EIO         generic I/O error (may happen for all errors)
+ * -ENOMEDIUM   No media inserted.
+ * -EINVAL      Invalid offset or number of bytes
+ * -EACCES      Trying to write a read-only device
+ */
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
+{
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    if (bytes < 0) {
+        return -EINVAL;
+    }
+
+    return bdrv_pwritev(child, offset, &qiov);
+}
+
+/*
+ * Writes to the file and ensures that no writes are reordered across this
+ * request (acts as a barrier)
+ *
+ * Returns 0 on success, -errno in error cases.
+ */
+int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
+                     const void *buf, int count)
+{
+    int ret;
+
+    ret = bdrv_pwrite(child, offset, buf, count);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = bdrv_flush(child->bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+/*
+ * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
+ * The operation is sped up by checking the block status and only writing
+ * zeroes to the device if they currently do not return zeroes. Optional
+ * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP,
+ * BDRV_REQ_FUA).
+ *
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ */
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+    int64_t target_size, bytes, offset = 0;
+    BlockDriverState *bs = child->bs;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <= 0) {
+            return 0;
+        }
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (ret & BDRV_BLOCK_ZERO) {
+            offset += bytes;
+            continue;
+        }
+        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        if (ret < 0) {
+            return ret;
+        }
+        offset += bytes;
+    }
+}
+
+int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
+{
+    int ret;
+
+    ret = bdrv_prwv_co(child, offset, qiov, false, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return qiov->size;
+}
+
 /*
  * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
  */
-- 
2.21.0


