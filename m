Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0AD22475
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bt+1Waml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0AD22475
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrKz-0003OD-05
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIt-0001aq-49; Tue, 20 Oct 2020 09:03:51 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:38727 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIk-0005at-Uk; Tue, 20 Oct 2020 09:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc0rrWF6mh+1YFSxCvqxPKCSuDbAPA5t77RNLaHDJ3kUAAGqnkUmF8a1gAfICSN+nt7NlOn0cBg04Ak9zZLToDXxdCl4nEcyT+C7y5ZzqOcovMi6PECW4XnWPcrT5RWAEwAsVLYs4TQ9N94eS+Q/kVc1mvy6aVwcljzz9hpUWyfTO13e6m1Mj+1p1+0K3nsYIM2mugHIHsdYndPGMK/GdHpETSWM+FjyD3UOc3V6dXE9gRdyYNgC9aiZYzMN9ew5NYN8ZtmsAGHDXckAYxB5FNBArmeB9m+T4RWiQAhQA9DDzUG4ATJqGAGkVCcA9kol65w2S4Gl3rq5LYCfGMmtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzwI6yjtID0+Lvy8WbOn3esTTKJbyyDELKSbFPHnepw=;
 b=f5Vvw9UGSkz/VPxuG14V2Za8J1otuWn4qJGgtFAdb2CLweu6Uaf45tQhP1lHZiB6vAanyn2D7Cm1ZuGsuGdvTXAppNW1QGb5Sdn6/JvqB7dmbWZFGMXeQecTQgJRoE26VWPixIToUOBXv0pqhgnF6pRa3KRehMOWYjeej66zH6vdop0qPDaEN6LdW27eoL8tMoJI+zMrG1XTtPrn3EcHxBv/w8nfwbW/Hv/mlKm4bSgEs7tvIIpkzzgSenVqwE4PWtsXemdkreTCHVTkhMND7nQPnUVwjLrTxaX7Z+8h3MFRVE+C79HzHw/Q2vE4FCkGBUn0neqOrBhVMHgD62pF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzwI6yjtID0+Lvy8WbOn3esTTKJbyyDELKSbFPHnepw=;
 b=bt+1Wamls8xZwzyOPim4WSLtVtGcfB/hKs9/K7IY5yC2NfWLcP3Sd4eBpGnQfppD7jQMq/F/xrZ1DXaUvCLSChU676NYskBMd97E0hr1gwhXzqLq0TLR1+NKAzJH6rBD0pj/GWlHxZTCDCHHtLlFR4VDEZNlPOBlDFtA7s4C0jE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3030.eurprd08.prod.outlook.com (2603:10a6:209:46::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 20 Oct
 2020 13:03:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 08/14] block/qcow2: qcow2_get_specific_info(): drop error
 propagation
Date: Tue, 20 Oct 2020 16:03:05 +0300
Message-Id: <20201020130311.14311-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a333777-d9a8-4916-ea3c-08d874f88ced
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3030945974307D26CD80D693C11F0@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWY3H7HR+84ICnsP0UZjrEYHtKWjiKDEiuWiRSx8B/2X74Cp+xcqixouPwldOlgdoFbZNY0Z5JkyBp/lIuyj9tWpSoLOxOcQ0K6RHIwSA/9kk5P/FP2iW5BM5grKT0PJ3QLy9qxljBN3DI5FzKnagMGQ/N04+6kMuVVuICYaMtshJ2Dv0w81B/FuqArjarORvX6Mu2R3bU519id9j/S/dRWmadAJ/MkJbu+HSSFWkSd3pPvGkuy8rVhYAUGB/we2K0YVC3WX7qdK/C6+C78Re2U3PSwkusoWW8YflBprCpjMtk65MyjrXHkUQg4LRbz7IiweAV5JdFIeSE28s1DVpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39840400004)(136003)(19627235002)(316002)(5660300002)(83380400001)(66556008)(66476007)(36756003)(1076003)(66946007)(4326008)(6916009)(52116002)(86362001)(6506007)(8676002)(7416002)(956004)(6486002)(2906002)(6666004)(26005)(186003)(478600001)(16526019)(6512007)(2616005)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ka3yaxfqHIG6jHrA4dQOxZCiNiLKpcsLGGZ6mHdmsSKF8HEu8HeYzdlZFzvbnT78HKnpoElm9HhZLXZ5T3hWNPki3c6eMgR8KaXbQbOBn+nhtciTPOADNwS0ayLF8JPr7R5OnSGi6yHdDTfcbuKrMOmB6Wh3zg0r0SwWKNtTsBUp0XjNo8xzsvEZ1LyHj9JXUsG7zm4vaaA9kbQAk79UzPCE33H0ax006IQMYzbluUgKrJUuIhZB7srNPvM3QKMcrMpSOqVe6lWwV6hIYVSsN19z5LFIwNgUwhtKuNMkAz1/+aQToBRAqoXvPSxmT0+zJnPv2LEGu1KXVHT5mZ6JhJwE7AeBPNSGHF+w7cJCqB4sioSUCVibOTI9As73Vsl+ecFcHZ5xnTpthg6TX0bk+QJt7VxCQpaZkl1HbDHmjsQkYhGwamcr0WySM+xA9XgPJf/smCmf+9aSY5WcnrR5RCiITQH0ZgE8H2arlhDK+3krfT3rr8x/Pyok80H6eA/vTN86U6jLfXhxI6zvuSX9zc49aAmPbWZ7dfn8WcMhOSj+Jz5cvB92WKJ/Y7nouvRH8uMRsrZlJQmy4NGf9p5G+o97m6A936V0LuwilrG3JD1PZxWh/qVGJBsrBxBHkYPZ9vyJntwZxZcXv8Vb/NmL9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a333777-d9a8-4916-ea3c-08d874f88ced
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:33.9681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylVsudc2fPJZgrBeg7X6chdUxai6K9CGnDfRmX5AnrFMhucS1hXCAfu2QcDr9setznmAOQ1qRkD/cNBF7KNFBUJ5TD0nqKno1+ddfR6d6tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Don't use error propagation in qcow2_get_specific_info(). For this
refactor qcow2_get_bitmap_info_list, its current interface is rather
weird.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h        |  4 ++--
 block/qcow2-bitmap.c | 28 ++++++++++++++--------------
 block/qcow2.c        | 10 +++-------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 125ea9679b..024901a6ca 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -976,8 +976,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
-Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
-                                                Error **errp);
+bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d7a31a8ddc..55cd52ab96 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1093,30 +1093,30 @@ static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
 /*
  * qcow2_get_bitmap_info_list()
  * Returns a list of QCOW2 bitmap details.
- * In case of no bitmaps, the function returns NULL and
- * the @errp parameter is not set.
- * When bitmap information can not be obtained, the function returns
- * NULL and the @errp parameter is set.
+ * On success return true with info_list set (note, that if there are no
+ * bitmaps, info_list is set to NULL).
+ * On failure return false with errp set.
  */
-Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
-                                                Error **errp)
+bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                Qcow2BitmapInfoList **info_list, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
-    Qcow2BitmapInfoList *list = NULL;
-    Qcow2BitmapInfoList **plist = &list;
 
     if (s->nb_bitmaps == 0) {
-        return NULL;
+        *info_list = NULL;
+        return true;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
-    if (bm_list == NULL) {
-        return NULL;
+    if (!bm_list) {
+        return false;
     }
 
+    *info_list = NULL;
+
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         Qcow2BitmapInfo *info = g_new0(Qcow2BitmapInfo, 1);
         Qcow2BitmapInfoList *obj = g_new0(Qcow2BitmapInfoList, 1);
@@ -1124,13 +1124,13 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
         info->name = g_strdup(bm->name);
         info->flags = get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS);
         obj->value = info;
-        *plist = obj;
-        plist = &obj->next;
+        *info_list = obj;
+        info_list = &obj->next;
     }
 
     bitmap_list_free(bm_list);
 
-    return list;
+    return true;
 }
 
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
diff --git a/block/qcow2.c b/block/qcow2.c
index 41a29072e6..8c89c98978 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5038,12 +5038,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info = NULL;
-    Error *local_err = NULL;
 
     if (s->crypto != NULL) {
-        encrypt_info = qcrypto_block_get_info(s->crypto, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        encrypt_info = qcrypto_block_get_info(s->crypto, errp);
+        if (!encrypt_info) {
             return NULL;
         }
     }
@@ -5060,9 +5058,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
         };
     } else if (s->qcow_version == 3) {
         Qcow2BitmapInfoList *bitmaps;
-        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qcow2_get_bitmap_info_list(bs, &bitmaps, errp)) {
             qapi_free_ImageInfoSpecific(spec_info);
             qapi_free_QCryptoBlockInfo(encrypt_info);
             return NULL;
-- 
2.21.3


