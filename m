Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7321120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u2I8E6cW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7321120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixc7-0001QY-Mm
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaY-00085j-JA; Wed, 10 Jun 2020 06:04:06 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:48772 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaX-0005xX-Fb; Wed, 10 Jun 2020 06:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpbIWWwjGTXXIyGy/W9D6F844WMRymfjdyW/jCIZ7KM39wahDsxqiyPbQCDOcumwVJ0chcKc2u4Je4G59gtKbWMuEk3Jw7IFTtgndOKVsynerD3kzukHtVye2gBdTvqAWtjggwY1un58ynnG8S+icGwmrepGzia2WjkgUjpgFy7YzHKHJWpJeCW6/KPsiyiVWWpKQHfHpJ2XSSy1ndNl1t1mjbm7INY13suNpjfegDLafirTcrffc52abm8/uaRoNXAgAIc3gkz0tUiuLV1e0Ln9UucS8kaV3DP6tiu2VYMN/ML31ZIKrT8Njzw3mfyOK+IsDx1wjaJnCOm7SP+XJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyuElqbl1dwKIMPBQiLQGPB4rKWdUC711HR1FYlCycQ=;
 b=N5Su/Jj0gL2lzPlWfcUs6XHWpMnSiM2XeTfs2XMCDxBr/n2Iv+RGD6oFyXWgCD4aqOkIBbEDBd5c9dVPIvKZe9WH51VtHrBzusYTlnQ61+2YUWPff5WSbi7eodyB8KXawsTKxG53ssv/egYAzLZu2bvQT322UXYC39P2ei5KNrWT86EMgnite9/yd27GReS7blcx0lX2ZF1pTGa2ErKqx9UmhcQOwdn/lAR9XgddmmZs8pTki7QRujUuCfnyAKsU0CoFXMjbzaNXJtIZHgrQXrl8AnLzFnbnZLKNY4iI7R9+Ns/sDv0lnezYzXKMBuUSDZqiFWx90UGFxdvNxxJ/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyuElqbl1dwKIMPBQiLQGPB4rKWdUC711HR1FYlCycQ=;
 b=u2I8E6cWqvuAV5rf+z74dRFpLLXCmOPoiLOy8PUU3jpqrCw6fmNUCpgeGTPn5AKsBF6UeNciDEJ4cZvp9Jf0PgGOSS17WT4xpdH6q/u3T5W81bUXfXnMspqQ2J/+H2o47u+W/IwIKXBHl7KaZuxKD1L1X3tIdn6UY67oBLSzyPo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:03:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:03:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 2/7] block/io: refactor coroutine wrappers
Date: Wed, 10 Jun 2020 13:03:31 +0300
Message-Id: <20200610100336.23451-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610100336.23451-1-vsementsov@virtuozzo.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.166) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:03:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04747811-8ac3-47cd-7ac9-08d80d259765
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55251809CA5DBDF60A2D795FC1830@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:189;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrLUj3mf/mxIIckA7Zw+kd1q9kdbrUV/80/edQI6gl98DV8rkwnvModETE8uvKKCAPQx/hHhz0orLG/rLpCupZHxlh1WxjyPMZKBPnsKDzczZHBxeWB9V2zbXq960D7AgCaMtcPkimJnP1gydz6nfn5ni6Ly5EQ9pp75bFQMw55z4CDwt8UVldfDBzQte3PS3JmT0kTTvPqkYQy91fQFO2Vw8pOnC/hL0A+qndBQtGawp0jFwZKijkt8PT9tp8TbeB4rWCLJ3S/wxhtHx+8szdIB9KMxO02NyeC2EcylvhqluQ9vEXjkcknnk6cN0V/xGyrwaCNCCpSGnpkl7w+meapWjpfBRv25q8kimf7pUPqhfWR4smwnOUZkbLMOmaX+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(478600001)(83380400001)(66556008)(66476007)(956004)(6666004)(316002)(5660300002)(6512007)(2616005)(36756003)(8936002)(107886003)(69590400007)(6916009)(6486002)(26005)(4326008)(66946007)(186003)(8676002)(6506007)(52116002)(1076003)(2906002)(86362001)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: as1jDgAWU12iOS+qtDJk2pleApQnMxMcreckCAB1E9aaW6uihSLtvhtZaPGPK+meI1i83yyb4CceYl50CC2xIzINTQJb6lqsLW8ePgzt1jO3dYyZtf/r3qWaqSwQ279z4KMOl48BUrt9qTH+l1PK6/89BhT5vKKMpvHieJaz/tgLPnZZQ8BOdhxhCHBWEjdf1ZGr6EHChiePm5xlW/GmRuyAl8Cx60anUShiew3jCZbvWkRIW25fYgie/U0X6GA+n82zNUDhkk9Q6aRA6Q0Baa8CR62Urq9tjFAYpaDQtKB3zbpeRAGjthQBDGVXWp98EBs687aXwxz3tZAMtAMUY2tTNDo2mVt0Zfpp/hpGR1Q2oCaPoiqsx0mkX/gn/oujY4BDkiWruCZC+od8aEFZhsKwqHBWylFqyto9uiXXcS79HJWSwN0IdDlZ0ICmTSmjYXMPcC9WNRnHqI/NLkubJjq2EAf5XiL8v1zrXUebo1iYbBKm6soQl508jxHMVOse
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04747811-8ac3-47cd-7ac9-08d80d259765
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:03:57.9449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1hfhXx80CRQA2jGrcgsjq9G5zV2jI98RncaBFPlsgCtPgcyXq0ibmgEKWgl+USvziOICqoevUEyAKzND0U8e0VzK6EkAIzqcdLrV3eJfC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
Received-SPF: pass client-ip=40.107.13.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Most of our coroutine wrappers already follow this convention:

We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
the core function, and a wrapper 'bdrv_<something>(<same argument
list>)' which does parameters packing and call bdrv_run_co().

The only outsiders are the bdrv_prwv_co and
bdrv_common_block_status_above wrappers. Let's refactor them to behave
as the others, it simplifies further conversion of coroutine wrappers.

This patch adds indirection layer, but it will be compensated by
further commit, which will drop bdrv_co_prwv together with is_write
logic, to keep read and write path separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 60 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/io.c b/block/io.c
index df8f2a98d4..af6cb839bf 100644
--- a/block/io.c
+++ b/block/io.c
@@ -933,27 +933,31 @@ typedef struct RwCo {
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
 static int coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
-    if (!rwco->is_write) {
-        return bdrv_co_preadv(rwco->child, rwco->offset,
-                              rwco->qiov->size, rwco->qiov,
-                              rwco->flags);
-    } else {
-        return bdrv_co_pwritev(rwco->child, rwco->offset,
-                               rwco->qiov->size, rwco->qiov,
-                               rwco->flags);
-    }
+    return bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
+                        rwco->is_write, rwco->flags);
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
     RwCo rwco = {
         .child = child,
@@ -971,8 +975,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
-    return bdrv_prwv_co(child, offset, &qiov, true,
-                        BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -1021,7 +1024,7 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, false, 0);
+    ret = bdrv_prwv(child, offset, qiov, false, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1045,7 +1048,7 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, true, 0);
+    ret = bdrv_prwv(child, offset, qiov, true, 0);
     if (ret < 0) {
         return ret;
     }
@@ -2463,14 +2466,15 @@ early_out:
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
@@ -2508,10 +2512,10 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
 
-    return bdrv_co_block_status_above(data->bs, data->base,
-                                      data->want_zero,
-                                      data->offset, data->bytes,
-                                      data->pnum, data->map, data->file);
+    return bdrv_co_common_block_status_above(data->bs, data->base,
+                                             data->want_zero,
+                                             data->offset, data->bytes,
+                                             data->pnum, data->map, data->file);
 }
 
 /*
-- 
2.21.0


