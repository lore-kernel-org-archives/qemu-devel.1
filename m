Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B20C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9582D2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I+cdnQaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9582D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA7O-0001g7-Qb
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2u-0001zI-I8; Mon, 25 May 2020 06:09:24 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:58945 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2t-0003zD-H6; Mon, 25 May 2020 06:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIBuLyTAuBPuCptGfEUhX8Y+MvfvBurDg31qvIWMKRfFSGET4vAnX4fbuRBXO1GDjVScDNDJ2A5LU3M+iPDaviIAAoUWN5uRhTdQWrhGE6rdMG7mMFcicg7Ooo1HVqXAfRHDvS44u5crN0KFevZ2JOpbUcjs+5f4/YMXtnkIu1ivl+7EN4yp5aw2z9KPmMOii+o1IgsvI8HZuWQpg6dSRtHaGYty9iGVBHHSoK0FKnGHvUkob8TEyaOEfcFAGtlTJQvS4YJUIsLJOnTqZZkgcFfJvHWlYS+kP4yBGRFTBhfrFaf0Jsbb+I3jjkfobMQxINiYtnODB/E7AA+nMJN/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIDXlTC6oJx92z3YcqpOVAhp6raRtWpa5HXBjbU3lZw=;
 b=J4AyQrzPgQBWJJmrKnKDrqtr1pCYR9UzbXRgcTPo66W5XdTY8RLPz+Pus9eGo6XJt7y9X5ZkPd/WnjWgO7tKlNyJJqXoYq0YiwvOIHNJ9rn/aPjgboOOE7h0u8RImeuYCQljCpHH5R5Om5kelRr2q9S3DhddXDZuKGjNa0saEjYr8ItaqQ2RCIrJ1rvUeldSk5mFcrUn5lVF3+O5uHRiJp4MOO01cbXUqE41fZO8X0f672Zim3W/R4ncDJRHt0sxWAaLLNxtMaX2mEuDMRRatg3TJhUeDXxL/e8v1TqwwthE5yqsmAi7Sh7Zloj5Ok12zGsJGd7zbTnlFR8NYCbvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIDXlTC6oJx92z3YcqpOVAhp6raRtWpa5HXBjbU3lZw=;
 b=I+cdnQaXJZmLzkF4L6CE8RkCkxYpaA7jMgxpMwKaUyZDIP+RQPP+oTcV1gE25M6wWVvYbRSlZdhj+7qVEstUyxjwdaZ9F7MeVW2jOtERR6+A9gFQXQ1r5P44RnARNOh2HxDxjh5kQ6imwqr5BKPXefsZRn701nQbUq28rLvWl+w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:09:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:09:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 4/5] block: drop bdrv_prwv
Date: Mon, 25 May 2020 13:08:00 +0300
Message-Id: <20200525100801.13859-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200525100801.13859-1-vsementsov@virtuozzo.com>
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:09:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ed49427-ae83-4599-5731-08d80093ad44
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464A973A268AEBD6074EB96C1B30@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rA7MkSd4JSSo1VlCFavZPl7aGN5GelQbWeafESMHPgyB4vlrou+MHjj4A1QoTNG3IZNFn4AvNn0u88ayoFLLgbOmJJdpZ/RzfEtdc4mx0CCUaZ1N8Cta/3GweEXcQgI4rKNQr5PxMKTtw3mlht3mr05x6PIz4g9KFuqCz0xnSVRqqdgkCh3jyHcSvfI5nRvsG7sFwbIetGsLTaTQ6rl2ZFP6KiffkqC9DZJ0IhgK6BpHLx7oc1ivfoBs9Xb9pttQiwHRta7s6xbLFNmk91DoaBt3W9/G+NXMht/ThoA9lDZXwT3R3M70jI9VG5FxNp03AirUPvBt6P5FqOYHc/pLBM23X03LSJW8aFE+BTi9FhOnBDU6TqHC14R25K8kjSQj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(6666004)(6486002)(1076003)(316002)(52116002)(26005)(69590400007)(6916009)(6512007)(478600001)(107886003)(8676002)(6506007)(2616005)(8936002)(86362001)(16526019)(186003)(36756003)(2906002)(66556008)(66946007)(4326008)(5660300002)(66476007)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: clP2xFiaZdeDd58ZVgP6a5PTr49QfTFdsgBxTA9acNBxhHhaBu6QJkyHjWpL0jOz4ZNikRpUxHnjM3g3zvRbAILwroFCveKIQlWFiYkXWaSFEXJBBy27DBk/dvE828ato7U+7DvND62V+0Q2MPKj9pTO05dI2PFpCr3nXEzDygJQChJ/MM2Fn5wi2UV+H85a+a8R1bgl/Q5a861dT04iilqwTBTmNXAR4xAJA03ZHH6tFtKXtcophCP3Tc4ppStFLmHEO+FMGwXpGhebGE380v+epTUFEevTFvJ4YMXjuRnkdBu/cPmWBHQMTe2RY6ppzXpme4cBGH2AlYyI41hHrMvK42BTwoBVXNfm1o6WoEujIS0bd1OLWMTjVbfGZCnqCPkPpBBaD2OGFG2qWiuLKcwR47RbBWCVaF/WXxvnmTxX2T1498ifHMld7XlSA1LeL76o9YwrdvMopAiVN0uc5fOn1ChFgveAJoKrKfsRToE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed49427-ae83-4599-5731-08d80093ad44
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:09:14.1767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdcIdIzFAH7sjpqRvwTVe/95QGpAQi8Z30oq6dV6GQn5G25kP7JEeXjmV84XpddxhnHE09ScwuJZxmyv1QVgH2FKDtDbfb7Mi5uO5Cijxfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:09:15
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now, when we are not more paying extra code for coroutine wrappers,
there no more sence in extra indirection layer: bdrv_prwv(). Let's drop
it and instead genereate pure bdrv_preadv() and bdrv_pwritev().

Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
success, auto generated functions will instead return zero, as their
_co_ prototype. Still, it's simple to make the conversion safe: the
only external user of bdrv_pwritev() is test-bdrv-drain, and it is
comfortable enough with bdrv_co_pwritev() instead. So prototypes are
moved to local block/coroutines.h. Next, the only internal use is
bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
success.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h      | 10 ++++-----
 include/block/block.h   |  2 --
 block/io.c              | 49 ++++++++---------------------------------
 tests/test-bdrv-drain.c |  2 +-
 4 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index e2047697d6..233b8b3694 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -32,12 +32,12 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
 void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 
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
index aed6ffcc4f..dce99f8453 100644
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
index f9700cc897..305ee7219a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -892,23 +892,11 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
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
@@ -952,41 +940,19 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
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
@@ -997,13 +963,16 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
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


