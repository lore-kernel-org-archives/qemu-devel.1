Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C17C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C41B2072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IHSPvHie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C41B2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixfM-00067e-S0
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixab-0008BP-49; Wed, 10 Jun 2020 06:04:09 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:48963 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaZ-0005xb-VC; Wed, 10 Jun 2020 06:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDQb6Nt4wdj8VqgcqicId2CnJ7JZTXg5cbHTh5m/lHT6pD0eGPjTbMhx7eaZ+ef9NKvxlLo9yNZF8HAZkbcof6eL3sHMgKLd6l9LedqpeU4zn1s6KynMruZZsf1psWib03De+9qEF8WyAUhVF1JKj9p1S/ivpFXt9XTMmn31C78nsLfdkFIDq8sNpra4shxiCP0FmtglSh7Uo81LOyl9/d2ahUbJcHRzXhqPHachttMmgxaFSGa2jGWfBY9ujfqqdxdPcT2o9YdZVV9QXBxyc3nUCKdsm46UjoOpVqCXD1RZ2bpQ/IXrDFPEq21OFX0o+mB34mJewkye37vqlHOPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXYMzBn/0AYKpIWsmi6y301z74xlRn1I4R7fytDDSjg=;
 b=jlYygMDOIVrOkomEUePJhoOphdVBxUucJOTT+p/4lTvsWaMYQXCqcad9GZvDergUMNCWZjBoWgwtw1XWINdOFLIENUiCBzAzqzF+miZ1jsdCutj/z3uzzVjyQGTEF6RbQfxbyU8BAkgkrkmJw+XAkT36azaTM6moxbr+r3sjMKPPhSwXvsPwWsTjZQbqltJkTfvyC0AJEN0jUgQHfR1wjs9LEfMjtmoZvFW6l/XHYe2+XAJfjtd8pJdMm144o9NL8Uly+FxboG1j2hO4eSkhv2SMmwdxcBnnKquPPh6jXFW5KP592c6b/wsmKfoE5WyC9fojlUPY1ymsIAmKt1VI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXYMzBn/0AYKpIWsmi6y301z74xlRn1I4R7fytDDSjg=;
 b=IHSPvHiepMmXc1bezzDZn8GrehfFGHNoCpK+xffQISspRoLeZOIvXEbh72sRXK2bU6eej/RMmkeRqR+Kl8OYjakCd4ckf4KRPyMNpE/0OjqBlKetQ6FwFVcMKt2M0dinWBU4np7jMPKGTBDId4+1RZPG2QVhesrX0noyHGlkjaw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:04:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:04:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 7/7] block/io: refactor save/load vmstate
Date: Wed, 10 Jun 2020 13:03:36 +0300
Message-Id: <20200610100336.23451-8-vsementsov@virtuozzo.com>
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
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:04:02 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7eb1a36-e1ef-488b-b165-08d80d259ab8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496752474638EA9DC925F27C1830@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XJC6xW/fgtWqgWhvRZ2RmSwQZIPu7aChs1FxaFZTKYwAkdydb+2wQy9CjKcbRPR1cdYWuGIqOettz5g7dfsue8dhsQWW/vu4aYxLkU4GpDYxTRHEmZBTJRDJG+P9ao3USgxXBopTHoaoOnYgfRt4FDP4SdWnqimzI1ftIVq4pLQEI4FoPKrwLnMCV5ENfcDRuWhVyxQ0yLv9b7l++H4fDUyeS0P/t5xFA2m/crBDZ12zcezEUcGxdJaYwhE41DC70wf7hEl/D0v8g/nP6OIrhuHxuGd5fXIzrQR2tPO+18xcU4zXDUy4MePdmrQXrLT+ggwISI7aJCuHgQ8+G7QgNtq27TqK7C3n/a3yzewXQrDyCyDtG+lM3kBDE7EjNSk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39850400004)(6486002)(316002)(8676002)(107886003)(8936002)(86362001)(52116002)(6916009)(478600001)(6512007)(6666004)(1076003)(4326008)(66556008)(83380400001)(5660300002)(66946007)(66476007)(16526019)(36756003)(69590400007)(26005)(2906002)(956004)(6506007)(2616005)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YvQjdIORZ7QlwQIuTwLNnNFSLFF5Hg1ACofIqBkaEl0LeTRV1pV1yB7UlMyhFP6mlki2sLRAsmcJ0BGH84ZfJP61p2UV913lwX9yXzhQQJsQ0/qAIUCyqOYdm+fbsQEa6qAp0VR/BY6lmrmYW+zGi7zKo4FbBufU8vLsTWWAiRe2/LHYfnvKDHx/jHbegQcGDBX4a0IePVdkHc3Iy5tVns2ZRTrwdEVNtcBy7Grf+IUhRAZE6VUGBkWoQv2RAEqidnJfXH6QlywvsVRJ3GaeCzCrquDkDx97/QTWkhJybX5TNl6/OUydR/Zmle7AQfeTMJ4Wc/cX6JDpTHKen9nKCXySkwH/mVLkKy6AZBWfQALFFb8tVR1Vl44X8ctiBV959yQz0hD2zuss5L2IkDLMLXsS/8P+lMBe9szbiJBqTFbKcd2w6PtdvcGOga2sGV6r1kk859nuWxSkMmekRT8gsT+1ICQgKCraVTErckAW+Gs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eb1a36-e1ef-488b-b165-08d80d259ab8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:04:03.5951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBU1k8IOAL4Xau775avhvnYss09Toki9ix+9dZYSeYxCw+69zlBgqFQDMgbFsiB6s+LNDNZwtFDt1V2pYO30V2Fo+0ePibbe5XsnoUZlzmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:02
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

Like for read/write in a previous commit, drop extra indirection layer,
generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h    | 10 +++----
 include/block/block.h |  6 ++--
 block/io.c            | 67 ++++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 6c63a819c9..f69179f5ef 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -57,11 +57,9 @@ bdrv_common_block_status_above(BlockDriverState *bs,
                                int64_t *map,
                                BlockDriverState **file);
 
-int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                   bool is_read);
-int generated_co_wrapper
-bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                bool is_read);
+int coroutine_fn bdrv_co_readv_vmstate(BlockDriverState *bs,
+                                       QEMUIOVector *qiov, int64_t pos);
+int coroutine_fn bdrv_co_writev_vmstate(BlockDriverState *bs,
+                                        QEMUIOVector *qiov, int64_t pos);
 
 #endif /* BLOCK_COROUTINES_INT_H */
diff --git a/include/block/block.h b/include/block/block.h
index 280cf2a7d5..7826c3fe27 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -574,8 +574,10 @@ int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
 char *path_combine(const char *base_path, const char *filename);
 
-int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
-int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
+int generated_co_wrapper
+bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
+int generated_co_wrapper
+bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size);
 
diff --git a/block/io.c b/block/io.c
index 3060c7e6ed..83ffc7d390 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2489,66 +2489,67 @@ int bdrv_is_allocated_above(BlockDriverState *top,
 }
 
 int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                   bool is_read)
+bdrv_co_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 {
     BlockDriver *drv = bs->drv;
     int ret = -ENOTSUP;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     bdrv_inc_in_flight(bs);
 
-    if (!drv) {
-        ret = -ENOMEDIUM;
-    } else if (drv->bdrv_load_vmstate) {
-        if (is_read) {
-            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
-        } else {
-            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
-        }
+    if (drv->bdrv_load_vmstate) {
+        ret = drv->bdrv_load_vmstate(bs, qiov, pos);
     } else if (bs->file) {
-        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        ret = bdrv_co_readv_vmstate(bs->file->bs, qiov, pos);
     }
 
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
 
-int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
-                      int64_t pos, int size)
+int coroutine_fn
+bdrv_co_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
-    int ret;
+    BlockDriver *drv = bs->drv;
+    int ret = -ENOTSUP;
 
-    ret = bdrv_writev_vmstate(bs, &qiov, pos);
-    if (ret < 0) {
-        return ret;
+    if (!drv) {
+        return -ENOMEDIUM;
     }
 
-    return size;
-}
+    bdrv_inc_in_flight(bs);
 
-int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
-{
-    return bdrv_rw_vmstate(bs, qiov, pos, false);
+    if (drv->bdrv_load_vmstate) {
+        ret = drv->bdrv_save_vmstate(bs, qiov, pos);
+    } else if (bs->file) {
+        ret = bdrv_co_writev_vmstate(bs->file->bs, qiov, pos);
+    }
+
+    bdrv_dec_in_flight(bs);
+
+    return ret;
 }
 
-int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
+int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
-    int ret;
-
-    ret = bdrv_readv_vmstate(bs, &qiov, pos);
-    if (ret < 0) {
-        return ret;
-    }
+    int ret = bdrv_writev_vmstate(bs, &qiov, pos);
 
-    return size;
+    return ret < 0 ? ret : size;
 }
 
-int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
+int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
+                      int64_t pos, int size)
 {
-    return bdrv_rw_vmstate(bs, qiov, pos, true);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
+    int ret = bdrv_readv_vmstate(bs, &qiov, pos);
+
+    return ret < 0 ? ret : size;
 }
 
 /**************************************************************/
-- 
2.21.0


