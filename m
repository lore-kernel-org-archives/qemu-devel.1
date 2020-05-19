Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EEB20872
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QhbonY6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EEB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8Nq-00060u-LJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kg-0000Af-PI; Tue, 19 May 2020 15:55:22 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:52740 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kd-0003c9-Tu; Tue, 19 May 2020 15:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBu4h2la99P1s/EzYr+E/pycqcT5sg8qF+Ko+zzEE4F+/w6VNofPe6AUpqEVUSwq1lAIIX+0Vi4rt3nQSiBXXI3GScQeOxyw/YIsi71cLW0KgAeUEMl+YdmEUiqBrOwJ7VY9pNQReWK1B1hV669w4JArc99fdTSVRarBR40iXSwBAnTzI7hO2whBSS1bvKPLSvALdRX7TinCykMaqFwiPyyHPue6AtgxgCIPjqB4HHu5LP4/DPOPhIcK3dR1H4r7RjUNEGcuNXEJByKG4OmgF2PaqaCtAtagFqHsxoMW3p+tzh1d06gFVw2PSS5rEPtaLP98RhnLdMOJXt0s2OCF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+hd37ddoNSCqA4Ykw1nZ82GCgd40NW4l+wAYSU+3EM=;
 b=FJRu79a+hvEgy2YovRmrTlrQhT2lk6Q2cgMwwyeUQQ1eelJeJ4AvcFlEsX7+Bz3oGjd1boVX6RWoqJhTF6owfTrlEGuyzgCpeYmXFgpjKO4YRZ9zbt6WJTRvZpxa1A46vuQ9jQh9hsXe3f+oyYySETrJlaf6s48UAwmwXLB1ePnvpZ2OU30EMl2kq7OigTZrN0EAbDd+CpAdQ2ksvQ/AKLxwGnr1W4ohlj+RHigKQBzb6cy08WOEqt/Id3BL1AUpbLTiUmAChjTJ24qW69jrXdxpTHJ2NCa4VNUb6d9UUOcf3NXuUqOufvEbtqmDY4gSMNq6BCgACLPnics+reCs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+hd37ddoNSCqA4Ykw1nZ82GCgd40NW4l+wAYSU+3EM=;
 b=QhbonY6fye9Np0kt1kQvv9ASm7RZPVBAuXsXZhBag3IDdVNo/s+PeuqG5F3R13Q1+IwQJEM7PZHgPZ/KupVils5ps0bTGTcBDWDY8DM8vRCy3r7c5qkT3kKMr6VBmZNqTApJgsm53OWAarXnSj+AAYOntOlXtZzYiUa70v+D8cE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4542.eurprd08.prod.outlook.com (2603:10a6:803:fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 19:55:16 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Tue, 19 May 2020 22:54:58 +0300
Message-Id: <20200519195501.29071-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519195501.29071-1-vsementsov@virtuozzo.com>
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:15 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db13909-dac7-47ac-6945-08d7fc2e8cca
X-MS-TrafficTypeDiagnostic: VI1PR08MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB454248242CBB6AAC0A9EB67FC1B90@VI1PR08MB4542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjyLS1g4zCEEDYn6QeBosRxLQZ+AdvJufNBhJhmq85T6ahByoqBe4aB1YwKM8pwbEsIsPOs0MhTwcOwTovezN5ACaZscIv8jCtGbaVZQvUSWBp1XSbSCcqj73o3NuetMv7En7PCgqElNijEH5LX62sNSDnQyk1R2HIq4+354rc0d5Jfno7g62p5j9jXwsIwu5pF/7Aw+4pEV8NQV6qO096gCpj2+nYE+/BzkPj2gAu3cQyCRZ5PEh49wRKvixU1XikcMRwKmTdJLMxaxchv8WvE4ABMgbK+W3XsSXjXhDC2t0OHCD2Ae5am0BEISwQjsDNy+qhtucpqm9gEsVK9C/JANCudA2RkTUt4TtkfJPK855SzDQp/U0AivOUUqSXLxmnqN6qs7pKd4pQHbRqq6ku0BGGBV0tZ+ermFPQRZLKv3Ijd9K1yTY/SJ7ohM+UE1PhHMtYLQk1tX2t8YZj6f/NH+XsQKjzLBfnUOs0xS1+vNphGLjLjT2egr3vsFb1XZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(6512007)(2906002)(69590400007)(5660300002)(52116002)(66946007)(36756003)(6666004)(107886003)(316002)(8676002)(16526019)(956004)(6916009)(186003)(8936002)(26005)(6486002)(86362001)(66556008)(66476007)(6506007)(2616005)(478600001)(4326008)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jmqGZkIBSDa+ptz1PlWIZOFLGcjpamjtltRNWy6py8tuzqYARgN2lpIW5y8xmwGH/h3mLeT9hpXLXFmV2Q/s6kquGTje5ly9V/x8brBiNp2Jy8CLFKYyAyDbaPjsaovtaLhVNCG4tMQZHGkOPLkjHS5FUjNH7CNk4tUxOR0QGgUxgDn6xak05G/Uj2qA1GStzXB6CK0bwuMMz9ntZqHtaEsFEnDwK0CBdrOIlkKtcLTrAK8RqgdmANl4A39rMciqULE9iwIvGgFjuzPUk+qNpg39NoYIlCGky97vNfx5NQithFoVzxerUD+qpSvyAWcUu66WaZLNAip5st9bo0FEyRtVuNjoMcRrDXc59PUY2ER+oaq824HMlxdfwSwPLT1dD8mTvLrp35CktiklUfvfE5Zja5FPdqPz525Q5zPFVGS8i+NCe1eUtmZG6OvfeiC5ir97koTH+QGGQW9ifLajDixYf8hItoyrR5E5BaEEXNds96MBwRMHP2+d+fZyhZQ3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db13909-dac7-47ac-6945-08d7fc2e8cca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:15.9061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sUsDXWJyshS+qmvrClg6xYonIv32fugUFjB5IhHuYkd+JtVbupuRAPVSwX2Cz00I7A44Gtb+7yGa7icSaxSJfs/zIHh3strEPq2tsTjISU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4542
Received-SPF: pass client-ip=40.107.6.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:18
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
index db990e812b..cdc0e6663e 100644
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
@@ -2495,6 +2497,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 
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
@@ -2509,7 +2516,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
     BdrvCoBlockStatusData *data = opaque;
 
     data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->include_base, data->want_zero,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->file);
     data->done = true;
@@ -2523,6 +2530,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
  */
 static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           BlockDriverState *base,
+                                          bool include_base,
                                           bool want_zero, int64_t offset,
                                           int64_t bytes, int64_t *pnum,
                                           int64_t *map,
@@ -2532,6 +2540,7 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
+        .include_base = include_base,
         .want_zero = want_zero,
         .offset = offset,
         .bytes = bytes,
@@ -2556,7 +2565,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2573,7 +2582,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
-- 
2.21.0


