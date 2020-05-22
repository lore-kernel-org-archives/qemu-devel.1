Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0685120723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LO0xIpDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAUC-0006OS-5u
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP3-0003ra-9w; Fri, 22 May 2020 12:20:09 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:54509 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP1-0006ph-HS; Fri, 22 May 2020 12:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrqhJAiE63IlGsRp7EIOj0eaY8nB+o853PkCxBulzHRMEpEQWCzn4+LVh8g+RCkJPTYfXuCRF45LJNd+XiXH2Usw2ccFvnhk/kVgikmoxzMioXNlOTYB+gnB9writ3O8kO9sljigufAu/2WNaykKjdus7+CSQVAg293lO1oZUl3Zx1tdo7l+YYZQrvh2pNBc9mtPNYO3cShmJunLoMKJ+NhuuJwIUt9Xsr30xqG7GWpv78eI87LWhMUYwkai+zojatkejV3Ag2+Oz5enZC1/B1Vd0JUuYyOiZ5CpW6gNZMDKrCSKf8tennWQs5vx5mXLickTyX6VE7j0Q17QzwWhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37UPKvYPOUtSH/3fe/nRIKAGkIsyAlgYRdoSi6WC4u4=;
 b=bstdqV0BCjq90jKkHXJ902YkHGR5I+/cqOaESIQNMYVzi/gDPWEOMSCghFqsg1tyEYQ12NPcOLOGBnnfJs3shJckwCyKTH4/w3Nthbx0L/fT9/MtMCV5Hnl0FVuMyNEwBgfqpnGoQfiQG5jb0boEHH6iPXVkbOobZuQsCQQ6vEInrqn3ZC8rOCWwhjJCWrG2YrYdOT9x5qKCGohJVEBiPb9QLqhvYMomIqH7vDuAn3oqCtNfzNFYahsiyCDcmJXnoSxwJzmu2BvtOhX6G3DHeE4xkm2GiuiCRFUDZ/o5C8V8k7tMWSu2d8FfmwF/KFKuUiRQKczD/VcV0fTPAOySlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37UPKvYPOUtSH/3fe/nRIKAGkIsyAlgYRdoSi6WC4u4=;
 b=LO0xIpDBgIDK2hRGEIiRfCc6y3AuL7oFgDH0vk7zt6GfCBsGrRqg8m7IuCVFFXbFJWb+03H3OnRJmJElR5ob5e0KtugxtNu12RivUKE8psXuDkLFjTqVRN+rG+sp7zMBZn3O8UOgSMoYxe/q7KLNqqdQiF0/1m4EwXkIAizg58k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4000.eurprd08.prod.outlook.com (2603:10a6:803:dd::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 16:20:04 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 16:20:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/3] block/io: refactor coroutine wrappers
Date: Fri, 22 May 2020 19:19:48 +0300
Message-Id: <20200522161950.2839-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200522161950.2839-1-vsementsov@virtuozzo.com>
References: <20200522161950.2839-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::46) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 AM0PR01CA0177.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 16:20:02 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0d614a-84bd-4b07-1e8c-08d7fe6bfbf7
X-MS-TrafficTypeDiagnostic: VI1PR08MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4000FACB82A0F8C3BEF9B259C1B40@VI1PR08MB4000.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iue0IzkJIvAxBgAEmXoIZupt89vqSf5ZM+qocaVInQN4YxunLh0zaygUpZYgH9Jl6xk1FypuNZ2/LiGuyM4ptbnm4MazVWEdtM7nWflrkEpWSq5C6BBP9UYRgg9baAbaJRtJzGxH+e14CojGF/BKLkipVxh/UZ5lEXnUKBB5UfS1dYUJGJMUR/IaT48rMGHYDbgIEnm46vY9PDExRJmEDNUUwzzyB8NZnPSEWveT9LHl25lsCnJ04wsNSH8AhxFCN4takW2XCJP3zmtwiErdTaFcjce7umoFhA11cJ9v69sbolAufYgdrnuEz1JZXQ6iXcwfCdnn3Ewdu45po7GsC74Dq1q9777pEDoXCOJZgQxNWrMDw2iYzeQEoz4EHjMQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(346002)(376002)(366004)(136003)(107886003)(6486002)(2616005)(956004)(478600001)(26005)(36756003)(66556008)(6916009)(16526019)(2906002)(86362001)(5660300002)(69590400007)(66476007)(8676002)(8936002)(186003)(6506007)(66946007)(6666004)(52116002)(1076003)(6512007)(4326008)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7jwiLB7ABePUk7aifR+OZRr98X2NQrisiHctSUVjuuYwQvllJUXR0vvvicEB7vJVXkb/CYs1ZhN+F4XwLccPsr8Y/HmWiQwOOpzQqgcnj+BdWuHMiOWuRjx7I0Xm1E3LToS7+5NwPJvclsAM+KgcBf4cacRTnlaEO3ySi4NzHohDmgeiW6aIygo2BankqlwxtLQHvJNsfTf8b8epudUSt7MidVPaI2H4Kj5l4IdTCwItfeFpcKmMcAD/0c2z8xj69j2g5JXnGklcwHGe4cW+AbegEkw7CVom04rI6PiqGsOKE5EceEs9vmbr2rv1XUCsaD+D3Q38xmp5I0tMMK/mvXv4ppc8x0B+7d4VZTNSQYysKmOn4nAAOM+/WCb8VlIa3iwrmop/JgsuaSbvBqK8BtgxOFlMkIAbMLitA+/C1Zexy8hwAz5obfPF/N2HdLUXOQRYuW7Z19OSl3DiVDV0p4JaghPcXmFrJUQvazTuXdI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d614a-84bd-4b07-1e8c-08d7fe6bfbf7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 16:20:03.9760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzTBWau1S+SaWYwjC/ueRaMeM4eiBp6W8muSrU4YJSl7mcUMpFq9nqM8ZVU4PiNAIvrXJpdmG70iAGFOBjOSgnaNq6qOyc9GG/Aj8CU7Np8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4000
Received-SPF: pass client-ip=40.107.2.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 12:20:05
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

Most of coroutine wrappers already follow this notation:

We have coroutine_fn bdrv_co_<something>(<normal argument list>), which
is the core functions, and wrapper, which does polling loope is called
bdrv_<something>(<same argument list>).

The only outsiders are bdrv_prwv_co and bdrv_common_block_status_above
wrappers. Let's refactor the to behave as the others, it simplifies
further conversion of coroutine wrappers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


