Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3926EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E815320774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n2EPKhtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E815320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif9r-0001j5-0l
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0r-0006vf-Gx; Tue, 09 Jun 2020 10:14:01 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:27969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0q-0007gx-0Y; Tue, 09 Jun 2020 10:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+urYbJB8V4je8x1nVtfsClZT3e0q4ImGZYhwUqFs/YdDdo4vem/GjbNqrz/VCtVCvb46NYdqQeqmp8qQDdIejN4rW01gMkoC4JTCkkT6mQNLcoeM1L9LiZBswDy4IwhXhrdDuuy8ONvhzZgR4880cU13kJQFou/zdYeIvWS3nor+z1fc9MJsTyTeVxdoRCmSeJDColbu4t72/xSGgl9RdlBYJq7jttqidvAdGNFNxcqqtDKArAKcdt+840PXzGx5kOJ0guYQOFcX+7N6wGtPyvEkugIdcNBJNo3gMHSGlQFa1XUUhNlgIKwnCPu1pxtgeFS2IpzIZtbdwI9Eah0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+d3F4A0xFO02lJNWxruw6tLeIUskt33CWkhSv3cj6Q=;
 b=ggK+EKRV8jqv+k7XZLYd5q2a6ucpzd7xgQwWi4biLuMX0QdBJqq0Q0illz1PE1DArZy8+1TeOGmjnp8HY8eOyMsa4NFSLOT/nrIT2ha6tJAiVYW5KE3bBVShXCPUMtQqbStGEZZscFrDmcUKcApHqqpKsxJmExjLjsoMm5403IizXn2dzE/GPIJy7UATbXWGEa5tcYbc9n0+Zoeilk6hscGFXM1u8HjoqxQ54X/1uOEIxZuFa4BGsZcp7t9ptz27tes3XvJm4llDv0+tZyPM4Wq1az9ZDL1+7nah6EC2wAKldoqbrjNElNGFBOiird1ZarCvf6bcntbbkFIcqkwsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+d3F4A0xFO02lJNWxruw6tLeIUskt33CWkhSv3cj6Q=;
 b=n2EPKhtpPlQKm/G3O1AfLBSZijhjyGNjBHu6VA9sBU9A1NIFVVSdgl5JnRJAS/qIDFEaGSzyf28hRdxDSVX51eEZ7BCgzQS+QgZSJ0aARTApv7Mrv0kAUf3458fM+2fUeNrADw1VGNFvcI8wVG6HTCvSO4kzSI1upkkryz4puXI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 6/7] block: drop bdrv_prwv
Date: Tue,  9 Jun 2020 17:13:28 +0300
Message-Id: <20200609141329.3945-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200609141329.3945-1-vsementsov@virtuozzo.com>
References: <20200609141329.3945-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.180) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 717670a4-2523-459f-0885-08d80c7f568a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54942D54751AB6604E5422BEC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8beSRdC6HsZa/9HEB/B8Kt+AqDb6gKdl+8r2JxzzB5jC9AUdYw58OvFLC6S7tpDMvkTurAzz+Gv7MJJCj1EY+VffT9biSVbBWQPf9PwJ70mxo+/9VFW/S7Ss2V+RaK8jdSoRwdXwJFRxBL9ac0LFCRpRriqf3UhNEM8oHjKtOMr2NQ8s83qNlr7igVF89zzoPUBaiFfdWryMamSe3QkG3t76CfbL1D9CTlf03zzdiu9DBUhiJJnpinANBXaM2Ary5kDfLrIlUSVGV+pg0L5M/WSYiZ4iX9b0rILh25uZ+G8csm+xKSTnLu+a9FoFGNYjHr8uR7Nsuq2zAdZELKdY0ZTt9jQaX9oLkqBMv3PetfWaADV9BuuHTnOi1X3Sy2N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9f1w7xYRVrptUME9JJNTIxIS8GFUFktEmjr7wUTrT4UEFFrvMQDjKi+HoSOdgsWKGGNw8TWk0WrQsbpEhj3xSLirCYShegvVW7qiUn0RoGynoKH3WoSIEaxTSs1q0OrcqLLuYnIehO+aBY5PDMPhWwh2cgNkMKXJ9nmuMy8wuLdClA2wX3Vu2kVFi6OXD9RHGsaHx4K51HaRkOmYMLAWNR+rewAH8fUvO66RJO3RPqxDkNsQGxjBz5aTpcQWAFNRenOBKUsX7w9ZVrkhCtz8v/ZxeqYs8MkhHVF6KaQ11K5viYKgb9WnIad+N/i18uobAkTJTKwJvIYtGpFiIls4FeLIFnSy/L+FNTMTGzpJYHKCwdPBa9Rjf8zlYMCVyJuyFqUt20OzIyw6rSOHo2NIn09rMnlrLtSm2xyzSikSTZ4WDhB1tXTmcDfMayJDQv6Lh+uV0t+1573I7eTMcwr/ZNO/UwT4ObUS7ymBjD5dpRw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717670a4-2523-459f-0885-08d80c7f568a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:52.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAY4dcROqw/zCJyhazbIVLd7+o+pqiHC57tF1yc0H+na4icaktVkf0Uhiv7qCZflu/qA5c4tM1yKbCv5WlTwodGbMGiLNWmBwBKAu6sh4RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we are not maintaining boilerplate code for coroutine
wrappers, there is no more sense in keeping the extra indirection layer
of bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv()
and bdrv_pwritev().

Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
success, auto generated functions will instead return zero, as their
_co_ prototype. Still, it's simple to make the conversion safe: the
only external user of bdrv_pwritev() is test-bdrv-drain, and it is
comfortable enough with bdrv_co_pwritev() instead. So prototypes are
moved to local block/coroutines.h. Next, the only internal use is
bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
success.

Of course, it would be great to convert bdrv_pread() and bdrv_pwrite()
to return 0 on success. But this requires audit (and probably
conversion) of all their users, let's leave it for another day
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h      | 10 ++++-----
 include/block/block.h   |  2 --
 block/io.c              | 49 ++++++++---------------------------------
 tests/test-bdrv-drain.c |  2 +-
 4 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 145a2d2645..56c0be6f8f 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -32,12 +32,12 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
 int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 
-int coroutine_fn
-bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-             bool is_write, BdrvRequestFlags flags);
 int generated_co_wrapper
-bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-          bool is_write, BdrvRequestFlags flags);
+bdrv_preadv(BdrvChild *child, int64_t offset, unsigned int bytes,
+            QEMUIOVector *qiov, BdrvRequestFlags flags);
+int generated_co_wrapper
+bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
+             QEMUIOVector *qiov, BdrvRequestFlags flags);
 
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
diff --git a/include/block/block.h b/include/block/block.h
index 46c8b7816e..dadb6e796f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -379,9 +379,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
                      const void *buf, int count);
 /*
diff --git a/block/io.c b/block/io.c
index 36fbf9e1fa..3060c7e6ed 100644
--- a/block/io.c
+++ b/block/io.c
@@ -890,23 +890,11 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
-                              QEMUIOVector *qiov, bool is_write,
-                              BdrvRequestFlags flags)
-{
-    if (is_write) {
-        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
-    } else {
-        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
-    }
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
-
-    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_pwritev(child, offset, bytes, NULL,
+                        BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -950,41 +938,19 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     }
 }
 
-/* return < 0 if error. See bdrv_pwrite() for the return codes */
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret = bdrv_prwv(child, offset, qiov, false, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
 /* See bdrv_pwrite() for the return codes */
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_preadv(child, offset, &qiov);
-}
-
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
+    ret = bdrv_preadv(child, offset, bytes, &qiov,  0);
 
-    ret = bdrv_prwv(child, offset, qiov, true, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
+    return ret < 0 ? ret : bytes;
 }
 
 /* Return no. of bytes on success or < 0 on error. Important errors are:
@@ -995,13 +961,16 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 */
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_pwritev(child, offset, &qiov);
+    ret = bdrv_pwritev(child, offset, bytes, &qiov, 0);
+
+    return ret < 0 ? ret : bytes;
 }
 
 /*
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 1107271840..1595bbc92e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1872,7 +1872,7 @@ static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs,
         }
         s->io_co = NULL;
 
-        ret = bdrv_preadv(bs->backing, offset, qiov);
+        ret = bdrv_co_preadv(bs->backing, offset, bytes, qiov, 0);
         s->has_read = true;
 
         /* Wake up drain_co if it runs */
-- 
2.21.0


