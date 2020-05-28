Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE11C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75E220776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uHA6Fm5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75E220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFcY-0003vw-5I
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZN-0006aI-1p; Thu, 28 May 2020 06:15:25 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:28150 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZM-0005Od-40; Thu, 28 May 2020 06:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlr3hDzc30noZrc5Q/1pwNRUg2GuRaYVPXyp5y8irdC0eqslriYPGJRq0AM8YzfRJlpUkceg2KS5Vn2Ve0AJ4ncAF16yG+K94Qp5rq7rXXRGSG7uyiORuZul55SD2JF54pShjcIj6xgINWvJoOB4xnYbnSzy+THUwyYCMr0VgcNa7iJBevY3Sa02JK+4ring5PMzGpB3nUqk58YRgpcgBIGUtjkfd369hp9c0Jb2oMToFoA8CvPC5L8t0ZrTgSMIQn1v2lrLznWcIIIMl54nSl/VJYlF7PA5AtAnO883PtRe7bUivp+YyKzDsSYDbvBde9gn6jJ8RdQ/iATDBBY8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GGo5G9V/mpSszzVku02B85DJgW/tWiIx7B5rbRsB4Y=;
 b=YVivL57FQYYpRrFwA+vd6U8vo+zqJh4x+kHtTH1O63ISODavdQUJ5HAtPIqL/EChBbmPntWOSJvbRVxtfXzmjDlPAFC6cYVAhL7GmH04wD3HurFwagWNRA/h2JyCnt4HWAUBRTA1luGmmGsNS5h/TosWIARmrHwdhIsmWacWubhaW1CfrZw8sv0mS9wn6CjaCpem1QRPxZJgCVDTCeFnVMGduk4Jm2ZC0798n9UsXeMTHMI7149vWmYvcrKv6ir4tzLLo99dLt+pUlE6F/QbPaJ8FKHYlYZC27B8qnLTxxf4qw6uKqcswxqkFbFPN2qVGOWOx53K0vuhjSd/VTysJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GGo5G9V/mpSszzVku02B85DJgW/tWiIx7B5rbRsB4Y=;
 b=uHA6Fm5dJSIFAXGxSUv1xLcKQ2CKU62D42dW5MNVxM2VZ9VqTPKQ05wXHvSLXpOJtX5gz1zsnyANk7m4OxmRhmikQ7uecDhdmNCXEpn1/RjhRukM4L2Ze0Zaj0sJ7wVdBRc2y2qF99OcW3vAep7E30vjmxAf4jfKKywsqPnUJzc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 10:15:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 10:15:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Thu, 28 May 2020 13:15:04 +0300
Message-Id: <20200528101507.151161-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528101507.151161-1-vsementsov@virtuozzo.com>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.178) by
 AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 10:15:15 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c2dacf-2e7d-412f-f942-08d802f0045c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531777319E453AF60BD622FCC18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpiYRnVXk5x/emFvG8B4IdMpTNVqZsiwzI0V23r7e2siQgnX3Anox4bdoFOUmfqTiFU6eC6BH7mCjysT9JX5+aCxN9QDvI9DSMFN1G0Sj2imzwXBqHI0UiftDuZ8NLhEw+mZ5hTikRYeLyGKBJAM5Kg+x5A+idXA2P0mUn2C2Wf43S3PEMPavqZdJ0Fj3WjoLlOLfuIwsDmP9nT1GRDU8gyjBX6o3aaBizSNCw0Uu2RiUZdPPIHC1b+Sn8RKVYwUkg75jA6EK/yo6y9CsMLgqc2bY049TIctLWChENmIpnywccuyDTiJJ3wT7iUjpsoeybNtwENtUvgIkyA4j67h0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(1076003)(26005)(6486002)(5660300002)(8936002)(6916009)(52116002)(6506007)(478600001)(83380400001)(16526019)(186003)(4326008)(2616005)(6666004)(66946007)(36756003)(107886003)(6512007)(8676002)(66476007)(956004)(316002)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1YRhLGQk9G99aCuJhN7FIkkB0K0JWQoyimvCu5M9/ZOY8T0QzbDJ0cafb/hYh+uVCrwZMQztVZAbIQlLhGcs8FNZ1c8/6npgHzLvJYOR5Wz/QG4B2K9Kz+Ypq2LDLCi9VN15rfxtFUrf/A4iIrdpNE7q3ic+5POUS0j/XKHeXukAfBmmEVvonvE4kpiNF9HAZK2k3uFG8Bm4u6SOYZMDcKYJj8M4Jy0W04soRd0KfilJ5IS4CGhorrjvvr5IrjZtw46jykkBdoGf+06gtgefQ2iFMUluRblFCLQh8N3m3Bo8xvqT+7A7PNL6L2ZfSlIb9x+Q1J+NAVD2QuaVKSGhuTh2HJ4O2zc1ZAZMX+S1KI9VQaLU2DHTWUkRm/WhlsxipEyFW6xcO/p4R6a3kPql/BRjkJdWUj6arBbfBvxi5Ll1vgofik/SBitOxVc+oLnoklaTryo8ytiHgrGzT7VbP6X76epUV23uirv+FpktDjI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c2dacf-2e7d-412f-f942-08d802f0045c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:15:16.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XudRmUqzy/ud4px4IzypJEf4w2wCs50FhjVOOgScFuI9WpnxuvXOlHeiHiLU8FI/iRLLyrA9SZk45Apg/Ej16dfyWjozFvoVlm7HSe+scM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.14.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:15:22
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.18.0


