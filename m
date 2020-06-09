Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB32DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74863206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZUFzjIhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74863206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif2X-0000Xw-Jj
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0s-0006yN-Uc; Tue, 09 Jun 2020 10:14:02 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:18497 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0r-0007hk-Sj; Tue, 09 Jun 2020 10:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or3vjzDLCt8BdMjYaXO76iyg5FXdESmIDymUjYFsaCYgCSVDJlG8b6fGwvgxSP9rLdw6b6O6tZJTm0wYNFsHXmLsNI90jjo3YUw8+rbjHqWsaU+730AmxTt1xCaGr7qUv4YS8WRQflM8wjGHMTRpL2HAoEi6vp7H0OUgiu6uQNHkCBJu8TWlGF2CasleavfnozOdKjujGYdo2tuNc3AnppiAsZiCTCyrR3C1nP9mUC7TfX2wbJATLjufwRABHgIVg4HAsiJ7Y22T+JUU91qv3JlrJws+p1LQ+kONRTg5LeaSSHvpwKy6HmhJKi+kQwGBGXNstu+DAPXloRNMHBNhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xuWWArO7p4I0F+lEkAtacYWCf55HAJXFv7UbUiYUGk=;
 b=at4WC/szIeICBVLpmBbWU2V0R+I9/ohISrda3+ND3U0Mc9dSMIt6VInQKXXcqKCm4xcAwmiahUmUhAxOo8QaSMquitAooBvSigTbzcbzyIePEoLI78by/oK0/lvX2H2ogGryF9wVpiiX0ShoZmuewNGaH3N8QueaDS679RO6WdY0XhC44sC5fnRVJCQb0E6D9fR8gF9ucCPizvaeNR/i0ZxqGl82SHX8uZDo5cIk6FoLmgUeB5TsIwsmeJFWYLA/cYugjQsDAl3daObFNMOZqzl4rqO8wdWRr3hGPG8C+sb/DAThM6VtcIKpjRYL/vzvliiKrDUndMm8TfHn8svOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xuWWArO7p4I0F+lEkAtacYWCf55HAJXFv7UbUiYUGk=;
 b=ZUFzjIhUHqFm+wVqZT5xJl4qFDXIObeci7dCxhfNFnKqoPS66PmTuK9vaMcLmbYIyLaEmImwT7Tsv4kv5zlyps6esSDLe81RgxdjNdgniy6LI3KiVttnXyNo3FY8yCw2Y4AgPOaVDCvGJi8ZFAruB9Y2m94jWpBM9pkLRQIUzp8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 7/7] block/io: refactor save/load vmstate
Date: Tue,  9 Jun 2020 17:13:29 +0300
Message-Id: <20200609141329.3945-8-vsementsov@virtuozzo.com>
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
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 206b2d25-aa5b-4f55-75b0-08d80c7f571e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549421627C3025BC339018C7C1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A7nyRdgWmkC4x6O6SEbx59d9T/vdcJD+Gu97pR3ViQXSbeRvDps+Cg/+s8GCcjtNIvf1870iOIFVxNjBrDAPpn1my//wno9A64aNoS/LalU2FophLltZ7bSARSTTCIXtS+EBq7dldL39Y7b0G6m6ejyapPKKPVB9oIH2rk+w4UCReHRF/Ibh4bqqQ7n2TmJcU4W7QL8le57wVY1UkgRyjn3fosVqmIg2S1O3LD8cZhfyjNEC6eWZ3Viz5Qmrjs8+f+vzqx8gA1R4jng+vsAJpV4W5eb9igrTZwa/EB4m0eRTRDHpXM79t5blr5SFQK66kPW6nk07t5CWJd89fe9xZ7BkAEAz3ERE2i5BlaWf70pWxEu9dQofFhotPu5hW5y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5HssCftwQJMb0AhKw8FVIl8bm00a0VlT2mRoN73xZsXhPa42JBFf/Pm6g1r1q5EDSKIxzZy+Cwbadj84hay/wouJ07juspi6S6guI86mwRTgN71gMCOAGxGyqX7TlYhQNt80rgBAQZY0+VztznlIomQB8s0mDjnIvZriAp98yxBEp+/cDX40S/T3dMCSIV2P4f1iQ8fO9tWEvUlszh0R9Mlsj+oIKClI/aCughPZ+vQI5zidrjC2mYwsxnsjcstiFSeanJfBBCfEJcqfTX1n128wFOrDcksQkLd5H/TOisfS9aCCCmgGf7KR7/U6fPRI3IO756sLQ5CWGQvzZ60JwXRK3vmz3VJ0No/KT730YBsz00N5BJuoB+IES9jkBvkZ10UDHj4rL6Nzbc9UJ1QGkaK+BG8uAmK74uiajWxe1lEbb7b32w4BCvgX6LbxnNPPUy40GZ3mogF9eNCi1eMMx7486Gc8apeCA2Dt9fgY5BU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b2d25-aa5b-4f55-75b0-08d80c7f571e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:53.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prKhldKxicGN8fIfoRkaMRy3UxBz56fIXTQMueZKdxlgoeD2/uHHOUossPjbSsULnIfmbvuuHELG5+DNuvtEHuGCKCCK8B68Au1QuHXWmYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:55
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
index 56c0be6f8f..7e14fdeccf 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -58,11 +58,9 @@ bdrv_common_block_status_above(BlockDriverState *bs,
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
index dadb6e796f..cc2edbeb65 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -568,8 +568,10 @@ int path_has_protocol(const char *path);
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


