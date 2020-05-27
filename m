Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5D2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5751207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OLRmk8Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5751207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2r7-0001f2-3z
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oH-0004TE-5V; Wed, 27 May 2020 16:37:57 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:57342 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oG-0007uz-DS; Wed, 27 May 2020 16:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAemYnGiAHIFea/ti7uzSgj/x0fCmMdTAYmRmvunXI7V53Lia2CNMbV2w6o3oJwakeUkQqjGE9P6pqD1UY9Mnx1axZNmmJHG9uyGVYycAYJvnA4R8ZJm2KHZqKzdd+xsKls/Hqt5WCGGN1Erm1UQKDs/TVSoCsNBpZIo4ZCe/+GOeaVu1nx/KJ+Kvdv3nTv41cBB/EcXm+C3XN4kX3gGxqTWGZlNJoJizWooxbN2N79I5bvo3mUI6xAhG0rCse91Zfzo6s2GVjeOIcllFP1bPktHzYarkhF0CNoWeSg4X4noqPiVEy9MD3Kgk0+mP2XgPMetzjpK/VsVjODj8zny8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+B/0B38ta1cH4B105Z17VFOIQ3nKibFWFX93vJaNbQ=;
 b=T6gvJ5zk52lbpCvrDN3UIwtnccYawUYciZuSGHNHTZ+Bfx/33LVRWC7bZPPB9EaC+DJs+Lb5AFUCIU6YypBk3vbZPNeJ0cKA9Pfc7Tmsj1cJHkfz+/qNgsBkJEoKjBuQBOnLQyZNa51K9OHxJwzpe8gZD1ZL7LzP90JnwnjgfJ8NQs+gDJ2rFmUFCPL4ykSvKv2LDl2/Gi9AI96UCQoM4GQvG7QjI9wRzcyHe55FoAtbWGzYTMVj5AB8+LxaC4JBNZCE+uHe1c3lIGcjhci/OxyHhmb+DID1AAx5DWRBc5b7zuU7DLgvGzN7tuoj2/w1bd421K6PQVCo1frX1Mg26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+B/0B38ta1cH4B105Z17VFOIQ3nKibFWFX93vJaNbQ=;
 b=OLRmk8BfxytVFnIB17xCCCN+swqE9Aa83hWhUtnJjefUuOfZwe/NSfHNSDnLbKVCcqLK+qz2+ad5bD5y6QBZUSM/9J8ke28EcEIy4E1bMcMjvWziJlcql62Lcofa3iZow2s8iWi6A29A6IU6N0mqm9RRJ6mmxR1tQM2s0ee3Az0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 2/7] block/io: refactor coroutine wrappers
Date: Wed, 27 May 2020 23:37:28 +0300
Message-Id: <20200527203733.16129-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200527203733.16129-1-vsementsov@virtuozzo.com>
References: <20200527203733.16129-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.148) by
 AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9701913-4f0a-42f7-1a8e-08d8027dd2fb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53361CDF68B9D342FCE437F8C1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:189;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRZ5sLG6RS7Eub5an+jmIcPJhxVykXn5SCT0xM6d12r9mz09ggIVCjW33ZGuKA4LCcutLgW6M5ym0xfHFC8+PvrRgSIf6tuRzkpQmtFL9tEishCriy4Pp3YnRhpcmqKX8MI+jQgvf5zc5+xcg1JAkrWANGkpxMRf7QlpSk6tc/bQJeGC44ksTqhg9XkvzHC9kTu8/yhPdhExzDxZsm1RyGqd5ZLPpfJIo0E9Rk3qRwXN06w6lER8fiYnTJcefXOA3C9akRzjQiW+yk27jrDizMJcY7cSJ4dfLud28/O2C2NzAjhxjkmDfqREee1/AF/+VMfzNXukVq0C4gJWVqcG6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C/IoHt8HsmeGb+4e61MYbxo5O2dTCAWF6GErz3qngd5K/FleQE9KfUACF50aewCDeCgO0xEER1aiLqRekkyro8HgOxqcFKkTAn3xdJKdDBS2TgI32nKT/CJ6QzNVRQJMb+bLZ/UFxf9GVubqdLl9x0GEm6udsVAf4KsuM8GXyeGSqFjx/xzoqA0A53Bud9x4CqI0wHBfaUwhoHcyphEeXPRd5B/I0OK0DsFe8djRVmuii5eAj0LMuRx0/9waeLQNdsdtxVJbuxVHIVz+5GI885Rfq37ICcfOIbNg7WaJT6viHN+bIibJU2h3k6gh5xuQvnBnfexTw8FRTKRm/fmUs4SqBwdNYZFaupf8Ak7v1CRxDmVSkXsrZQZr3BBhaZHSyAIbQh0Lc9NyViaV5Q8dBp82830Hlyxo/EAAKErfQmIAPhwXr91Qou+aSh/IqfnFFY71EbC5jKvEVxMq4bqvNlXTQmRBFx5zdtUAwVwKmqw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9701913-4f0a-42f7-1a8e-08d8027dd2fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:50.8745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR2zEnFVmHpreCJcwl8IUNc/tH+dj78lc3So3wz7vEYxF+hLZ4yR+LAWyqvPVoqMUkvaTw92wAR+iP9FBHeo47WeRqp4diNgELK75l7iRqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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

This patch adds indirection layer, but it will be compensated by
further commit, which will drop bdrv_co_prwv together with is_write
logic, to keep read and write patch separate.

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


