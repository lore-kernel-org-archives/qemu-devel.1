Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB1C20829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EyCByyNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB1C20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE8f-0005wa-96
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4P-0000Fw-Af; Tue, 15 Sep 2020 12:44:41 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com
 ([40.107.0.99]:58470 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4N-0007hn-FG; Tue, 15 Sep 2020 12:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgN6sIdoP2MSzPkZxg8kgvqQMPWMWe7l4ZoG67y5NKSCh/4u5JstHmD4E4XDs1rnp72UQnY2bxizzd8Vbxd6Bi9zLVWw1vfeOCUt14clZQSIWXncBP4axwvVQ34b+GvX0NZSg+VGYpcUzpsn5nUfFBwk1NpeTRe23mitDUQdBFIsxLJEfjsCa1rwYHDQFSMwHjn0+rxPtkmax0Psen/KnVGxUkfqQ3imMGUFOHJC3YXONMwOVNCuZEajjgB8RQY3tbBrLmVXyGqnYGynJDHLlxlBS+pmqyYaFw5OB3hJ3cNqUXAphYfVfxctzb918b/83ZaUbB5x8w2raf5bDc5U/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEvaQ+4moyf7BJ81ZgScnoOoGx05Ry4V4/CfXm04VFg=;
 b=Loi/SxD/6KWVbBiFxJW9BMEDTCEph8R9c4RhR168w5v7lSy2WqSfW0GiV9bYhkK20Us8utm5v9bhJvcAthUqSbu04nZYF//bWofQ/gP8PRkxyu/6q1YnptQ8dI01daNlOnkyMiFRd5S5ItU3SWRASwGNA0mV2/nFzHVcFcMnxZGXU6T7Q1gBEgB3Fyo/uuWgopUbdPgrDkSFfSYn+lehHGRTlRlqVBOWWBQzrd/lP4yxM1lOlYrl6fSh7Fad0kmtJ+xqWKGpMsUHWU9NfyOCIX/IiA0StUULliQ+pczjYtzGca02x4M8Pgg0G1zmz8qTutOjlOGxLNAt2HBF46LncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEvaQ+4moyf7BJ81ZgScnoOoGx05Ry4V4/CfXm04VFg=;
 b=EyCByyNmNOQBqxStHswDCBzAwV3Mw7M43/OWTeOuOOwkO9npYnqGwN213WGwY9PSDuDC6Q/GyvB1BiSYa9Pc9HBMstKaUELn3qC1jISU46BQj0ShNZBPMaXCtqtJOvbVYdaaLVsrY06WIAL2uLJ9fdrezghvINQiooCygnZWy+0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 2/7] block/io: refactor coroutine wrappers
Date: Tue, 15 Sep 2020 19:44:06 +0300
Message-Id: <20200915164411.20590-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915164411.20590-1-vsementsov@virtuozzo.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:24 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df40fd52-4054-4eb2-05e0-08d859969ac3
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652836A38E5578BF88E3B20C1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:189;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTfm8IOrKk228fNaa4EebWzRP9VNHJGOkvAiVrI6eppem/Na9c4rHdwoovJybrol7VaGmLzpXA5PPevFnk2RGW9bu02JQ7Ja4eioPKhjcAJmDjpzADw/oi0guETPMaPIx3nMvt6Z/rW7eSDKLpBcvVZdg5ySoZ/MLvRGOhWPNh5Fu3NLgVZ8SIIVZ+ity5omgJQQGLorUUXazw+O5VRNi8G5Ccfxwp5bWY+LML1MLT1dTmD1fMjrMoULXyf9p3YNJh1gApVxfRnFktTW1FCbutlUMi9tkCJzGFLfOeuRzhY383vXLB++IcZ+B6Fw2r2rpIj9wGo/oIGaz5uHVncyicN78AtUOcDpfyJtg8XpveYojFQeodC7WeohszTFc3yw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K5zzFIC2KfOEwT8CWNBt6PvM5wQUtPi1ybzoTpulVsBlYwXE0YH0eH+D/CSKGj8i8DCGkhjolqCHWBTmZrvZ/wRNl4MbVLUZbfcVewnlMXwcesQMtM20oVeF/fgOl1S7KLTLZqPgycIlwJBDF0lea5XqEb5V88Tw9A7TWsZGblUFHt66yqAyx/MAXK5reRiNyhTt5aT7ioGFHaWNwjUcl29G1L4ZtjScHUgzM3n2MrJawLt1J3OPFcK99+0q3Mis16pKbzIGp0FcduMrbfQ3bzZ7R0wgoUC+FXwcSSxbNDqutO3vXnvL3vFAErxPqUkKmkEgWO2tiBqGG+JxKszAd1I/5NVp1vnb3MpD607r/QaN/O2BrW4IPEhRbu/kCa+VSWfnTpXRF9IR2Y2Yc4x3BeHd/dl/6RLGkVWCVWL3lrtuUVI8RbutoYPtq3cP3FLZfYPsBG6/AFDp9W0zrjqlwpjXGeCc81oIY6WsVFb+NnrvLPoYRuNFNPp/t90lcapAMs/8JTM4+3B4rLDZGIRhejtHHurfpL6TXYdGA1MQBd+OyrtyNoLMzzzSkLIBciAAunrxgDHmP3J8tJB6fawBW6VqfKW2y9KUGy3RU5IR0hjkaFT4qI6XwJ3afz6H6xIR4NDa7jk3HLhMBeLTQ1NucA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df40fd52-4054-4eb2-05e0-08d859969ac3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:25.1424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6w7dI5BlL859ruftAkoO9hiCKLWhhOeyuW4x4c1V6L+iPds4ucjY0dE1oKM94sHv5esvolpWc4OHo90Rz7o6vibQ6HscLRCx2LbNyS+Ptg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index ad3a51ed53..2e2c89ce31 100644
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
@@ -2465,14 +2468,15 @@ early_out:
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
@@ -2510,10 +2514,10 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
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
2.21.3


