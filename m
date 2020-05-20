Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84A6207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B7d7ihJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84A6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKDW-0002qm-Va
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCc-0000jC-R6; Wed, 20 May 2020 04:35:50 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCb-0005RQ-Oi; Wed, 20 May 2020 04:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1FEZVRlPvzjqEyC70xsm9hVp/pMxtyL8hiSJ5ndInSuQzfScOJVLyEUaSr8kuRG3eJBH5g1bIlg+8iJmkRjre9R3tMAR/XgyRx4HmptXJu4DpyqbxgYKA/rKv0zX5VRk8SSHvp3CUC3eXg2yE2JWpAntL438yu9k2m4gC35/D96in4/EiNZK9d+bUQzhssLmifwb7SdQmOXlFeg/9FAxd0JDclPj1x1zrK70wp8ldn0Vo1wxfLTrNxLN6MF11QeYIDDMrX1G9fQW/cLKjlQJUJp1j6ulZ9PPxKbf2iaVdWGoAr/QBW5z4NOucHQoOXIKwk3jLgVYo1eUEA6kHHi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXhYterO8igpjdw0h384k3lZzozrmhtfxItY0AkNfsA=;
 b=WOv2nPRpBzQ8hl6huJhw6XhRC7TfARXTrJr39aFGHEnt4K6Gt4OGxYRpjHXsFeXVAsxLSNRr35TWGoBU9Ce8DB8ODbrSH9EjaP71KfidMA6CkKkU1mko5IvOD/p+eTZ1X7sUPHCppso2f6em/z/pbO5Ymeo6ZUwymzAXhiNKm8FVwLoHi4c9cbOl9NjhcBR5LnNUrZYhQz8fxBsrsi7Zn0KlE0mfWGwJsHvJFAhJFcKwU9KpAmdPKiH10fLhfTl+DmBpZOZEM+d+ypiaT/Fm+pwF7vnUTumCjl+yTK2BMvzM35dehd6RXusunXEJV/j81EckKHJNqTX2GRILvQVAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXhYterO8igpjdw0h384k3lZzozrmhtfxItY0AkNfsA=;
 b=B7d7ihJigCsrAQNZn8uFnbf9rOU+z4+MUOx36U3iSWF67tbJKwhp5XelufeepqMlGb7MRx6x31pYUHCLbGuP2ShoOwIGRXn4uo7XQISUEx5hgvUINvuQeSGvbIbkj926SkycM76F8Q2zO0nv6xcCPKdyuR5KHELspj6uFR17G2E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Wed, 20 May 2020 11:35:17 +0300
Message-Id: <20200520083520.25793-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200520083520.25793-1-vsementsov@virtuozzo.com>
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53105c0f-e249-455b-bce8-08d7fc98c964
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448381D3E03743DAACBC1E0C1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ergRpN8HKSVleYOb2ge78A+lESQj0sAJHez8jpirQr5AAy+XwN/EYpQCuU3+AdQQU8Su23bzichyxkIVxS/0GgszgA/wA4npBJl3TFlzAVD593SXoXYNGdIR6ZBfqH8POevLWHS+NEInmdVymd0grkG/oom00k4lUcnUcpese2WoPj1WZW77HWlfqHq9Bm2z1ij/95dp9+phAKvrQjYk616xf1YYolQqQc1XGSr1GUpK+FoybkRNhtQwGydJQqwEbKDvcf1CYwa6Gevq7d2AgK0qdNyhmvahyeRzv3HRjwgVoDrB4bHzyWmtNCrsepubIiC9aUqguDrQeWDSiabb9S45oeRiuLzFnRzIr2jSvDPvo2qxPYDrvplP/c/Ebjn2ZSV+KaI4lXqJjZL6KCs5rueUQTRSGx5bY2rrMJzKXCGFG6QuptpeH1BReomAqBuMgl+GvDKvEBwjDsCVVZL4DiKoNUGymLF51Kk0kuuD34N7KemdqW4rRv3UwTzDDb8L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8z0TJLHyvtBmFiIhvm2eixQmYCy02fI9k+ibWQ8OGHMP5URFEN9V0aa3patwkNls/yOKk2dPb/yK16sk0V+cXn5u8u6p/Sss2146zsD9hJn++/HS6sp9v1LB2AXYLY7Iq+vX6QlKoT3V51jJZ3lhadUO3+uBkTVhJ86tw/OLTC5bnnNIbTTT20VidxM0nSotkOnuo0TXp6Eu1mCjSJGdjaNREuGpsqDjlVarT6vN2ToNEHvxilxdoC0UazgATsRdYE9USBEKVA3QQKT95xa5/5Pj1ihNQeBCPKxAiDXIVwftqqljloSMuSANL7+LR6OhLEyhj0PgrrXxAHbYPG+16iWA7SIKcK8gTSkzz6CnBV2d02RFsF6Av4FjAiscw2Lt+DLhg4lyiAGMYO8O8hj5kTQl6cITG+d3EAf4eB0XUUX3lmVBe4K9mLdzL09pSGu0qutZvd4O7eJxST9DCnEfXP6mRenASb4kpcAel5oDD1W2PwAXVdSWooqnO3U8p2ej
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53105c0f-e249-455b-bce8-08d7fc98c964
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:44.1838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8NsGMI7LXn6I+vsv9SQysB/yDUKmKdVa3hT8EUG+CXQYstygdWwoJ7Qb42j4NT2JwcRgn+cGzMGRKFrUzOEuX5ZyZTkDrTTLngP8apZORg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above, let's support include_base parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 412b91b08f..ae1c806720 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2223,6 +2223,7 @@ int bdrv_flush_all(void)
 typedef struct BdrvCoBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
+    bool include_base;
     bool want_zero;
     int64_t offset;
     int64_t bytes;
@@ -2445,6 +2446,7 @@ early_out:
 
 static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                                    BlockDriverState *base,
+                                                   bool include_base,
                                                    bool want_zero,
                                                    int64_t offset,
                                                    int64_t bytes,
@@ -2456,8 +2458,8 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    assert(include_base || bs != base);
+    for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2496,6 +2498,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 
         /* [offset, pnum] unallocated on this layer, which could be only
          * the first part of [offset, bytes].  */
+
+        if (p == base) {
+            break;
+        }
+
         assert(*pnum <= bytes);
         bytes = *pnum;
         first = false;
@@ -2510,7 +2517,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
     BdrvCoBlockStatusData *data = opaque;
 
     data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->include_base, data->want_zero,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->file);
     data->done = true;
@@ -2524,6 +2531,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
  */
 static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           BlockDriverState *base,
+                                          bool include_base,
                                           bool want_zero, int64_t offset,
                                           int64_t bytes, int64_t *pnum,
                                           int64_t *map,
@@ -2533,6 +2541,7 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
+        .include_base = include_base,
         .want_zero = want_zero,
         .offset = offset,
         .bytes = bytes,
@@ -2557,7 +2566,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2574,7 +2583,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
-- 
2.21.0


