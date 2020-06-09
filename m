Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A996E206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jnlzvYw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A996E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif2J-0000DX-KO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0n-0006m6-5d; Tue, 09 Jun 2020 10:13:57 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:27969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0l-0007gx-NZ; Tue, 09 Jun 2020 10:13:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8IFxL2gqijsG4Pv6UJ2QVu06cjT72u2M9iR3aCWkIroRrxgpCYRLrIC7Y3qkiuTjbQNPxgt7q8/1NTh3Niy9YjPXEd1TLnNRffRLmpbn961iONW33BOLqJeklOoDY8hogFm3+bipJY8X1YSKGoNBa8MKFtcW8d6qGUmvHW+xwV2P+5DNOCQy1ybAmpC5CyihDCeQ+eJP28CvzBTSXKDSVIP5VL/ZURO21EGncOns+N2UUx2CJuuLlQsZ8bqqjtAIcso4NSIQwmi9MynvJHop1TBLbHxxw1PdelE/T7CRYo8NT+j+oI2x45KCquuWVgyfzehgzsb5MMiO4H6rffXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P3eZo8WPmovaEVuviCSj6vzBDK+j0ShsQU3UDgtRyc=;
 b=FFQng4LJ6iFlnqlbCzZPYcWND/zD6b4UCct6T9SkUVIjjm1uOu1yXKiodg0Us+/eocAJbmLFSQDfct7TjH8t3M2Y/s44TMuLNBeyFppLbIFMOYrJkMr+wiXCdxzWZBnTEsbzuMH3psladUPQsTM5PAFqy7sNJ+SS20EqsAECnrHlSnCNinlRhA9A3UOfC+hXL89WhiPzROWK36C4fndz9jfx1FCZgb9LthWt0BzmlVTIqI4+O49SeDmAPRzv+e0ivRddT9wQGYZgibHuleHXHfjYqhVh50AuqGxZC0/fy1atNkzRPHWvthOdSpYbn23QxSSqkJRi8oShxNDTPoMClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P3eZo8WPmovaEVuviCSj6vzBDK+j0ShsQU3UDgtRyc=;
 b=jnlzvYw48aDOqBDYYlnTM/rOq9P62NeOJbllP0syttaJT0JGQhRxdks3dRdv43X59ikwH5/Nf8v7X+IbRLyTfWJuAe0mhOpE9TvnAjrQPRAV95HV4n2zMRFg4DkW+NTGUvyj6sLFrNc3i3AUYjHYutouGCJp4qdB8hAh+hqO/K0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 2/7] block/io: refactor coroutine wrappers
Date: Tue,  9 Jun 2020 17:13:24 +0300
Message-Id: <20200609141329.3945-3-vsementsov@virtuozzo.com>
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
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00798308-d24c-44b0-74c1-08d80c7f5446
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54947BA1127F45AB749F75B7C1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:189;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pe2uHK+92iDA0FnAULw9Uoe57zhO636okwRSPFc1VKTBkV68klhNqOtrizHT8uLzYL3XwSZocAO7Y5uNaY0Vc86zQAMk2W565CziFut3nTalf6yYJWJZjXUkJKwhNeAOqITnOOc3//uD7gvj2pN4k0QYHdYljTwSHdua2yajgGDcXsZu9eK5uPSGx/NryuDyRfqZD3RSQFqhFlt6ll3JVl6m+7AgK2j0CeBAk0K6qyypBzsPqqovHIx3siiQuRs+gDvi7v9f+pe0KvOFfTC/Udr5HCUs6l9mksKss2nWpENMvVgfxYnKWWYuHGRU/EX0+h9NZORAQ5VizCX4Or/tnsYnu367ZyArOgPmfGBJoKZyeq1A4H1x0qoiFxAJzCge
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AyA8H99OEGgYo5TgclMKZZqniJvGevUI/hJ63jVdVA39WK2cD/HS3Q3ZKPWumm++bIxBUMLZ6yT2g0rFJ2ddIFC62+zt7G8QgH8TdhowTgHUodrrYUQiLV0xLdVhZTTZPdVPagviUTmrKi74VTEapcv9VGbStMLo1PFaA6zb45YnbaAyuzvPm8Soj6QTxBbjOZzhMiB/dkdG4ASl0007qvUjwPnBSjCfUc55/VpbjKZ221pv7tn5a7tJLPyeVNTltX0sedKxonch2R6oWT7uXgkQZBp0ipNDIR7tFmzYmhdTCxjIw2A1Rdt0KH6u86ZDXjxZwD4u6inGbGaj+kohJALMqLOphhZ4IHbIoD2zREWCfSdDnVxdE5SDOgyw1mXEfgwpjl9NM5+IkvhafUZoV7wjRnpwf7PTeset72vKnq7KQiEUaAA0Ac3bSYoRS6l/60fsd085a5SeKIbnwohfT+YLjvD2Z/nYJg+UBIarZGw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00798308-d24c-44b0-74c1-08d80c7f5446
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:48.8791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27QNfNGRJAkWcm+WAK1J5irNjanmFiMLWhRO7OxL4GXguFomC32lkckzZ/P+FBOiMQ7uTJf1xtmXfDi+K2NNnlAyRRWcz/mdo60ypYjtmH0=
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

Most of our coroutine wrappers already follow this convention:

We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
the core function, and a wrapper 'bdrv_<something>(<same argument
list>)' which does parameters packing and call bdrv_run_co().

The only outsiders are the bdrv_prwv_co and
bdrv_common_block_status_above wrappers. Let's refactor them to behave
as the others, it simplifies further conversion of coroutine wrappers.

This patch adds indirection layer, but it will be compensated by
further commit, which will drop bdrv_co_prwv together with is_write
logic, to keep read and write patch separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


