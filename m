Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE76C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56DE2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k/PkExUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56DE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA4S-0004Fm-SO
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2o-0001j4-IZ; Mon, 25 May 2020 06:09:18 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:58945 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2n-0003zD-A3; Mon, 25 May 2020 06:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HONP2ErLclXNtBx7mvxEshSYw1A/SHVg9VPp6r1+o23SoS9XLDCxw2/DeZFESOvDmzbPQNtZeJ4rfiBw0sRaZ2IKnCwXFvbmcVQQ0UYW9bvTWdudy6PlD/TB7tQHvQ1rdcIGcagzoGqfHcTF4uBJPH01piQrvVLs8pQZRmHRTQQMYzzyH74tFpy1iw0v9Ml/XlOESMLruL6Q/jldB1ddhGG8gyMAcmULeq0vCnZWMxPW6lNlGN1bxB2rKMpd7klu/UAPCLj+WUBO8VwQwEWxvVeZ1eAcaItD2jT0CmDfkgqHPVtFUw8Af7Gm//hvqV1G0XvdV9lOdiv4e7XNSxA5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MngoYbInMWIY4ehHMSgf3rM/wNm2DvQ45ruocibDZzE=;
 b=haTxIaypAwKVZGAMOtWQBiByxgnwa1N3es5IiV90zLX9Uv8eaIVFb1QHDkkoLV5o0t5J64JUO3p5Glk+CLXQY2F/CTO6Verv3Eub8PNDmiBFAGvjd6bCoOo9uA8+KDYj1kiJaIe1+3vElO51qgENVIPsekMsk6SFry8BH09d2vwVoRQF9UdglonkS1ByrJaI7skjVsBv2P1x/+qms90t6dMD0Tg6wpmybNDaKQUKNlpBJeF2eBqaiLeQG3u9qiH77nFczJOlkuThJUs8njP1uJa2F5JwEV91DWHq7FLnp5ZDxLt4wFuTApbmWX9PXyScKRik0KyDRg6j1blVSyeDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MngoYbInMWIY4ehHMSgf3rM/wNm2DvQ45ruocibDZzE=;
 b=k/PkExUZnPUGrZkxYxfr0gfUj244A6E2Lu1cllrzc/wFqGeCgnIHP4sacRE+t1zfB5YEY1C5OrPvjfO/c+KHK1xGUQf3BIsUPwwHBtz9GryiEmJc8bh32ez+V1Hex+5C48YNnqgh7Lc91zSPVHMzubR33jWXbtuu5MGEjzENX88=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:09:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:09:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/5] block/io: refactor coroutine wrappers
Date: Mon, 25 May 2020 13:07:57 +0300
Message-Id: <20200525100801.13859-2-vsementsov@virtuozzo.com>
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
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:09:10 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4042a46e-f747-4e90-3419-08d80093ab82
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54643E93CB9CA6333C8EF5A3C1B30@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLMBeK8Hq3ibYj0/34rROeldoRjpQCWgJvNnniN1TOEirbxkph4aoAwTsVDeHeqN7M6ErbYrUKsmnrilEL+zy53ocuZx9t4uvXX9ZhSqCW+ppYRYwoHYEIEdxLfMJJvxdTGvGrtmjTN6uTBIxTvwJ6D9XgSUqqVP2V4TJ4g3sFN/4YcQgzotDaARbElysKon8rkjmXgGn3v5CLI/Ce/iULpmpJapaaFVHeKDnOOXoeZzWzj+QBK/mq5uIuN5JPpK1GmHMv1Ur5MGLmxBBIauzWbvlg5ElsVi6/SBcVfW6xZ8mc6ZGgrd4crFlan9pIm3P/CDeJ0yHNW7noU14XiAqiZjAkCv9Pb6vkuX1upWgM2d2WOI7ZJyz3zYKElmeukS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(6666004)(6486002)(1076003)(316002)(52116002)(26005)(69590400007)(6916009)(6512007)(478600001)(107886003)(8676002)(6506007)(2616005)(8936002)(86362001)(16526019)(186003)(36756003)(2906002)(66556008)(66946007)(4326008)(5660300002)(66476007)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e4huy5aPChsyX8v7vgE9O5rHQc7OihapPcXOzTq7nI1/NkeY6CFk6/WXG1zhdvwnzHnFuhdSL2Y6xT8TLh8qyhlC+PtJLJBgS6aMmhMS5U8SpaXUguMp2y97lJA2MrRW/VZ6MJS5t/5JpGaWUJEUL3voHJ8OpQg0sQOUyIDp+ewnYuZwn5sqjtI+naFoe+m8UZOLL6ujQYGQGSHv7QYcuZc0z3hf4ZONtGsybGntx9j4yg9gG1cmC1h6RG9oihrpA1dHmOTn8XYpCca34VUgPiHGZYMXzlPIyCr8LbS20dqWzGngTUifDcnbr9kDFh//G4a4O6uGt8tJh3VYP1rwmlU2GJAubY/bRLebnC2PIc8V7pSDm6WcPXdseXFuHajndo0RzqVqUnj2zjU31rcQscGnaWUM3ld0a8tY8KSnmWwHn4NHoRb4zY6JXN8XstUMqEcYEn4sz8CeB+M38i3Iz44jjtn+ZiGBbyPeYBFvpL7Do7LwWTjd1b3cKuRH+DK4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4042a46e-f747-4e90-3419-08d80093ab82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:09:11.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LNx39syzZ1/KJ5B9241I8Rn32JBhsz5ZOWuFBvQutrpMn+UadZYq9lnG57HZBLeea8P050C+d7MuDbOqMyiYGlR3Qif40UW5+gIb7nAfQ0=
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

Most of our coroutine wrappers already follow this convention:

We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
the core function, and a wrapper 'bdrv_<something>(<same argument
list>)' which does a polling loop.

The only outsiders are the bdrv_prwv_co and
bdrv_common_block_status_above wrappers. Let's refactor them to behave
as the others, it simplifies further conversion of coroutine wrappers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 61 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..bd00a70b47 100644
--- a/block/io.c
+++ b/block/io.c
@@ -900,28 +900,32 @@ typedef struct RwCo {
     BdrvRequestFlags flags;
 } RwCo;
 
+static int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
+                                     QEMUIOVector *qiov, bool is_write,
+                                     BdrvRequestFlags flags)
+{
+    if (is_write) {
+        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
+    } else {
+        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
+    }
+}
+
 static void coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
-    if (!rwco->is_write) {
-        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
-                                   rwco->flags);
-    } else {
-        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
-                                    rwco->flags);
-    }
+    rwco->ret = bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
+                             rwco->is_write, rwco->flags);
     aio_wait_kick();
 }
 
 /*
  * Process a vectored synchronous request using coroutines
  */
-static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
-                        QEMUIOVector *qiov, bool is_write,
-                        BdrvRequestFlags flags)
+static int bdrv_prwv(BdrvChild *child, int64_t offset,
+                     QEMUIOVector *qiov, bool is_write,
+                     BdrvRequestFlags flags)
 {
     Coroutine *co;
     RwCo rwco = {
@@ -949,8 +953,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
-    return bdrv_prwv_co(child, offset, &qiov, true,
-                        BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -999,7 +1002,7 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, false, 0);
+    ret = bdrv_prwv(child, offset, qiov, false, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1023,7 +1026,7 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, true, 0);
+    ret = bdrv_prwv(child, offset, qiov, true, 0);
     if (ret < 0) {
         return ret;
     }
@@ -2443,14 +2446,15 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
-                                                   BlockDriverState *base,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **file)
+static int coroutine_fn
+bdrv_co_common_block_status_above(BlockDriverState *bs,
+                                  BlockDriverState *base,
+                                  bool want_zero,
+                                  int64_t offset,
+                                  int64_t bytes,
+                                  int64_t *pnum,
+                                  int64_t *map,
+                                  BlockDriverState **file)
 {
     BlockDriverState *p;
     int ret = 0;
@@ -2488,10 +2492,11 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
 
-    data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
-                                           data->offset, data->bytes,
-                                           data->pnum, data->map, data->file);
+    data->ret = bdrv_co_common_block_status_above(data->bs, data->base,
+                                                  data->want_zero,
+                                                  data->offset, data->bytes,
+                                                  data->pnum, data->map,
+                                                  data->file);
     data->done = true;
     aio_wait_kick();
 }
-- 
2.21.0


