Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6593A2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UuibPpG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6593A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k099e-0007eG-Nb
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091o-00029Z-Kn; Mon, 27 Jul 2020 15:43:16 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:11911 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091m-0003hz-3I; Mon, 27 Jul 2020 15:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3I85UkhBK7juglixmmLzE5M4swxWwQ2uVLgtDx05Pl5mskLEoxjPmFgRd1ioQ4dkkaimQ8l4/qESacXZhBlwjGGHYVJOiW8/A6u5Bjczb5wghG9LPQQ/6HaNM4mH5EDNNDN4WXLwwivEbTGDVjp05VWcLnHxVn7STlPfP0IXObHWA2ZuDpv0XxDVFq++PuTlfRl1HKYzzjTkemB/mgyugXPwxjDsbaLEBwcuswhscsdaDx74obSIFkGQ/KT/vpRmNxXB3Y1e8ueqcbBejAoeoOeOzgDCNcbCDIfAkJtUInJK1/4KrRkGWgX9CqYsj+Kh1UplXe+oby861sFeU1ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE5BgvfVeBJvGsHaNHx3jfSfSKrbjLEvLUzGlrVt5Rc=;
 b=BpfD/17jeV76yhl2k6Yz4B01HUPuF5iP+wFCuRZ88SMSLxoKDFFy9hSor8g1e1U2njNPYjxQldvqU78top8xyNtknirXeAQ6/sWUcmn3aA0fht7R1+Vnjx1MAKQBqmldTNpHEhwoezK4/SE2PKuieUE8u4vvmsrk+jW6QcFm7jh+wxshv1sL6TQGB8bJTZDORlhREgTRyi1x7YQStonvymSI/00nNzzDCNN4GLdmD0ZzhS75273hCYnWOjzAPGAlTo4ZisLGiQ0KRGPn+tJr2o+zCeufOOGPdBl4TsDpALluu1Vl4ESlo8ujZn+QGeFpm4/2WwqnqDbYdSJvb2V7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE5BgvfVeBJvGsHaNHx3jfSfSKrbjLEvLUzGlrVt5Rc=;
 b=UuibPpG+B7N6wvuyDlEMb69/EeTxSPIZIMljoZlf3qMS4O8IQwxataconEwnf9up0b0R4gmcujcLv+sWhv64qH/SqVZu+gxSDKRMDA8oXneNI38+Vze0qNKNs+4rUKTNuQcu0J6yZZvKoYDRvNA5Oyenl6/WLNgAtynoAg1YTgw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 11/21] migration/block-dirty-bitmap: refactor state global
 variables
Date: Mon, 27 Jul 2020 22:42:26 +0300
Message-Id: <20200727194236.19551-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:42:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98131ba-3084-4e19-2d54-08d832654519
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610BF95F4BF96F7E5BD5EA6C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U5qVgQRYmtQD6YG8zEzKOfN8iWojY8tKRjwiP2ZFzS6S5e0DlTXYflbBGT/r5baXQE6p44NlGQqFbzpvxwxH1Rqg6VoThwnyZmbrynof8J2BWLDfduVFCoJK3oNWM9ldV7kI8WysnP8GQHsNBbanhMU7DIBhPp4sASX5fh+F7KKi2WPZapOsSskxyc6lH9vKxZ+mzAIUuUQGRFCa90+g836gLZSjo/jw4Zo+NkrSw1i59FCus6g9aaTJBZs8iqUBEr1y9BiZVGcvEBs3zA02CGpyzR//igFtwFfyQfCmOmQBnjYk6DX3PyKfwgOE3769XMw5tmPg2pyCBiAl+IuEvuXsNtwc0pWCdnVfnmrfDsSy/ICRgqPN5x/e+yknl9H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(30864003)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XRF/qhtlTSyXEZWcmQ24OmqXZ60JI011XN1meczujLLpbA/IQ0H5iXQMbbLOthD/IthOng5oRHxSWY9x9UIJI8M6KF5j977ATvlBElsZShUSFPNr849eRsHRMdmLh+d2+9PcrXiu3wwZtXv10uDstzAdSfiBlMnrUpaDMfjyv5H+jVyjP0lTkwaf4BRgDyG14YiBZgWnxHfRANArK+QDgSkLpOdAbPZO0boJST90jgP7Z9ZQGRDfTyUP8VKPDtvzXtQuLMP3HY9GPaGqyKOrsepE/rOFbWevMU0AdeD+IVI3/y0u3HApSCR7r6qVitn8rCcEvPFvcaw+H/wXrelogQj7nmVo6YGGLvI9+kVxdAFC0cSgDcNmXdveWu73MlEeWkvF7k4B3NOyQiDjWrxruNfhhAoftWr0CkdDRwynFjaS05jTf6x0mVcqRlb7bOJ1r6fw5CPc52D6d4XQh7oFpCEPPv/pRMznc2uSgMN0+gc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98131ba-3084-4e19-2d54-08d832654519
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:00.7618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bISf7GfE1hkaPugbWD6ve7ao+xvhUG4pGyJiyuSPktqYBjxEW+rM4PQyWannH9iXYB6dZIxEzNWJgJ+SQ+veYkqQjkXwCOyctuc5uZRj3Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:43:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all state variables into one global struct. Reduce global
variable usage, utilizing opaque pointer where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 179 ++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 80 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 4b67e4f4fb..9b39e7aa2b 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -128,6 +128,12 @@ typedef struct DBMSaveState {
     BdrvDirtyBitmap *prev_bitmap;
 } DBMSaveState;
 
+typedef struct LoadBitmapState {
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    bool migrated;
+} LoadBitmapState;
+
 /* State of the dirty bitmap migration (DBM) during load process */
 typedef struct DBMLoadState {
     uint32_t flags;
@@ -135,18 +141,17 @@ typedef struct DBMLoadState {
     char bitmap_name[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
+
+    GSList *enabled_bitmaps;
+    QemuMutex finish_lock;
 } DBMLoadState;
 
-static DBMSaveState dirty_bitmap_mig_state;
+typedef struct DBMState {
+    DBMSaveState save;
+    DBMLoadState load;
+} DBMState;
 
-/* State of one bitmap during load process */
-typedef struct LoadBitmapState {
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    bool migrated;
-} LoadBitmapState;
-static GSList *enabled_bitmaps;
-QemuMutex finish_lock;
+static DBMState dbm_state;
 
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
 {
@@ -169,21 +174,21 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
     qemu_put_byte(f, flags);
 }
 
-static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
-                               uint32_t additional_flags)
+static void send_bitmap_header(QEMUFile *f, DBMSaveState *s,
+                               SaveBitmapState *dbms, uint32_t additional_flags)
 {
     BlockDriverState *bs = dbms->bs;
     BdrvDirtyBitmap *bitmap = dbms->bitmap;
     uint32_t flags = additional_flags;
     trace_send_bitmap_header_enter();
 
-    if (bs != dirty_bitmap_mig_state.prev_bs) {
-        dirty_bitmap_mig_state.prev_bs = bs;
+    if (bs != s->prev_bs) {
+        s->prev_bs = bs;
         flags |= DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME;
     }
 
-    if (bitmap != dirty_bitmap_mig_state.prev_bitmap) {
-        dirty_bitmap_mig_state.prev_bitmap = bitmap;
+    if (bitmap != s->prev_bitmap) {
+        s->prev_bitmap = bitmap;
         flags |= DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME;
     }
 
@@ -198,19 +203,22 @@ static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
     }
 }
 
-static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
+static void send_bitmap_start(QEMUFile *f, DBMSaveState *s,
+                              SaveBitmapState *dbms)
 {
-    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
+    send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG_START);
     qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
     qemu_put_byte(f, dbms->flags);
 }
 
-static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
+static void send_bitmap_complete(QEMUFile *f, DBMSaveState *s,
+                                 SaveBitmapState *dbms)
 {
-    send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
+    send_bitmap_header(f, s, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
 }
 
-static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
+static void send_bitmap_bits(QEMUFile *f, DBMSaveState *s,
+                             SaveBitmapState *dbms,
                              uint64_t start_sector, uint32_t nr_sectors)
 {
     /* align for buffer_is_zero() */
@@ -235,7 +243,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
 
     trace_send_bitmap_bits(flags, start_sector, nr_sectors, buf_size);
 
-    send_bitmap_header(f, dbms, flags);
+    send_bitmap_header(f, s, dbms, flags);
 
     qemu_put_be64(f, start_sector);
     qemu_put_be32(f, nr_sectors);
@@ -254,12 +262,12 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
 }
 
 /* Called with iothread lock taken.  */
-static void dirty_bitmap_do_save_cleanup(void)
+static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
 {
     SaveBitmapState *dbms;
 
-    while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
+    while ((dbms = QSIMPLEQ_FIRST(&s->dbms_list)) != NULL) {
+        QSIMPLEQ_REMOVE_HEAD(&s->dbms_list, entry);
         bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
         bdrv_unref(dbms->bs);
         g_free(dbms);
@@ -267,7 +275,8 @@ static void dirty_bitmap_do_save_cleanup(void)
 }
 
 /* Called with iothread lock taken. */
-static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
+static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
+                               const char *bs_name)
 {
     BdrvDirtyBitmap *bitmap;
     SaveBitmapState *dbms;
@@ -322,25 +331,24 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
             dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
         }
 
-        QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
-                             dbms, entry);
+        QSIMPLEQ_INSERT_TAIL(&s->dbms_list, dbms, entry);
     }
 
     return 0;
 }
 
 /* Called with iothread lock taken. */
-static int init_dirty_bitmap_migration(void)
+static int init_dirty_bitmap_migration(DBMSaveState *s)
 {
     BlockDriverState *bs;
     SaveBitmapState *dbms;
     GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
     BlockBackend *blk;
 
-    dirty_bitmap_mig_state.bulk_completed = false;
-    dirty_bitmap_mig_state.prev_bs = NULL;
-    dirty_bitmap_mig_state.prev_bitmap = NULL;
-    dirty_bitmap_mig_state.no_bitmaps = false;
+    s->bulk_completed = false;
+    s->prev_bs = NULL;
+    s->prev_bitmap = NULL;
+    s->no_bitmaps = false;
 
     /*
      * Use blockdevice name for direct (or filtered) children of named block
@@ -369,7 +377,7 @@ static int init_dirty_bitmap_migration(void)
         }
 
         if (bs && bs->drv && !bs->drv->is_filter) {
-            if (add_bitmaps_to_list(bs, name)) {
+            if (add_bitmaps_to_list(s, bs, name)) {
                 goto fail;
             }
             g_hash_table_add(handled_by_blk, bs);
@@ -381,18 +389,18 @@ static int init_dirty_bitmap_migration(void)
             continue;
         }
 
-        if (add_bitmaps_to_list(bs, bdrv_get_node_name(bs))) {
+        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs))) {
             goto fail;
         }
     }
 
     /* unset migration flags here, to not roll back it */
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         bdrv_dirty_bitmap_skip_store(dbms->bitmap, true);
     }
 
-    if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
-        dirty_bitmap_mig_state.no_bitmaps = true;
+    if (QSIMPLEQ_EMPTY(&s->dbms_list)) {
+        s->no_bitmaps = true;
     }
 
     g_hash_table_destroy(handled_by_blk);
@@ -401,18 +409,19 @@ static int init_dirty_bitmap_migration(void)
 
 fail:
     g_hash_table_destroy(handled_by_blk);
-    dirty_bitmap_do_save_cleanup();
+    dirty_bitmap_do_save_cleanup(s);
 
     return -1;
 }
 
 /* Called with no lock taken.  */
-static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
+static void bulk_phase_send_chunk(QEMUFile *f, DBMSaveState *s,
+                                  SaveBitmapState *dbms)
 {
     uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
                              dbms->sectors_per_chunk);
 
-    send_bitmap_bits(f, dbms, dbms->cur_sector, nr_sectors);
+    send_bitmap_bits(f, s, dbms, dbms->cur_sector, nr_sectors);
 
     dbms->cur_sector += nr_sectors;
     if (dbms->cur_sector >= dbms->total_sectors) {
@@ -421,61 +430,66 @@ static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
 }
 
 /* Called with no lock taken.  */
-static void bulk_phase(QEMUFile *f, bool limit)
+static void bulk_phase(QEMUFile *f, DBMSaveState *s, bool limit)
 {
     SaveBitmapState *dbms;
 
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         while (!dbms->bulk_completed) {
-            bulk_phase_send_chunk(f, dbms);
+            bulk_phase_send_chunk(f, s, dbms);
             if (limit && qemu_file_rate_limit(f)) {
                 return;
             }
         }
     }
 
-    dirty_bitmap_mig_state.bulk_completed = true;
+    s->bulk_completed = true;
 }
 
 /* for SaveVMHandlers */
 static void dirty_bitmap_save_cleanup(void *opaque)
 {
-    dirty_bitmap_do_save_cleanup();
+    DBMSaveState *s = &((DBMState *)opaque)->save;
+
+    dirty_bitmap_do_save_cleanup(s);
 }
 
 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
 {
+    DBMSaveState *s = &((DBMState *)opaque)->save;
+
     trace_dirty_bitmap_save_iterate(migration_in_postcopy());
 
-    if (migration_in_postcopy() && !dirty_bitmap_mig_state.bulk_completed) {
-        bulk_phase(f, true);
+    if (migration_in_postcopy() && !s->bulk_completed) {
+        bulk_phase(f, s, true);
     }
 
     qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
 
-    return dirty_bitmap_mig_state.bulk_completed;
+    return s->bulk_completed;
 }
 
 /* Called with iothread lock taken.  */
 
 static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 {
+    DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms;
     trace_dirty_bitmap_save_complete_enter();
 
-    if (!dirty_bitmap_mig_state.bulk_completed) {
-        bulk_phase(f, false);
+    if (!s->bulk_completed) {
+        bulk_phase(f, s, false);
     }
 
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
-        send_bitmap_complete(f, dbms);
+    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
+        send_bitmap_complete(f, s, dbms);
     }
 
     qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
 
     trace_dirty_bitmap_save_complete_finish();
 
-    dirty_bitmap_do_save_cleanup();
+    dirty_bitmap_save_cleanup(opaque);
     return 0;
 }
 
@@ -485,12 +499,13 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
                                       uint64_t *res_compatible,
                                       uint64_t *res_postcopy_only)
 {
+    DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms;
     uint64_t pending = 0;
 
     qemu_mutex_lock_iothread();
 
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
+    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
         uint64_t sectors = dbms->bulk_completed ? 0 :
                            dbms->total_sectors - dbms->cur_sector;
@@ -549,7 +564,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
         b->bs = s->bs;
         b->bitmap = s->bitmap;
         b->migrated = false;
-        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
+        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
     }
 
     return 0;
@@ -557,11 +572,12 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 
 void dirty_bitmap_mig_before_vm_start(void)
 {
+    DBMLoadState *s = &dbm_state.load;
     GSList *item;
 
-    qemu_mutex_lock(&finish_lock);
+    qemu_mutex_lock(&s->finish_lock);
 
-    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
 
         if (b->migrated) {
@@ -573,10 +589,10 @@ void dirty_bitmap_mig_before_vm_start(void)
         g_free(b);
     }
 
-    g_slist_free(enabled_bitmaps);
-    enabled_bitmaps = NULL;
+    g_slist_free(s->enabled_bitmaps);
+    s->enabled_bitmaps = NULL;
 
-    qemu_mutex_unlock(&finish_lock);
+    qemu_mutex_unlock(&s->finish_lock);
 }
 
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
@@ -585,9 +601,9 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&finish_lock);
+    qemu_mutex_lock(&s->finish_lock);
 
-    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
@@ -598,7 +614,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 
     if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_dirty_bitmap_lock(s->bitmap);
-        if (enabled_bitmaps == NULL) {
+        if (s->enabled_bitmaps == NULL) {
             /* in postcopy */
             bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
             bdrv_enable_dirty_bitmap_locked(s->bitmap);
@@ -617,7 +633,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         bdrv_dirty_bitmap_unlock(s->bitmap);
     }
 
-    qemu_mutex_unlock(&finish_lock);
+    qemu_mutex_unlock(&s->finish_lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
@@ -714,7 +730,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
 
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
-    static DBMLoadState s;
+    DBMLoadState *s = &((DBMState *)opaque)->load;
     int ret = 0;
 
     trace_dirty_bitmap_load_enter();
@@ -724,17 +740,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     do {
-        ret = dirty_bitmap_load_header(f, &s);
+        ret = dirty_bitmap_load_header(f, s);
         if (ret < 0) {
             return ret;
         }
 
-        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
-            ret = dirty_bitmap_load_start(f, &s);
-        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
-            dirty_bitmap_load_complete(f, &s);
-        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
-            ret = dirty_bitmap_load_bits(f, &s);
+        if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+            ret = dirty_bitmap_load_start(f, s);
+        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+            dirty_bitmap_load_complete(f, s);
+        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+            ret = dirty_bitmap_load_bits(f, s);
         }
 
         if (!ret) {
@@ -744,7 +760,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         if (ret) {
             return ret;
         }
-    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
+    } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
     trace_dirty_bitmap_load_success();
     return 0;
@@ -752,13 +768,14 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 
 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 {
+    DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
-    if (init_dirty_bitmap_migration() < 0) {
+    if (init_dirty_bitmap_migration(s) < 0) {
         return -1;
     }
 
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
-        send_bitmap_start(f, dbms);
+    QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
+        send_bitmap_start(f, s, dbms);
     }
     qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
 
@@ -767,7 +784,9 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 
 static bool dirty_bitmap_is_active(void *opaque)
 {
-    return migrate_dirty_bitmaps() && !dirty_bitmap_mig_state.no_bitmaps;
+    DBMSaveState *s = &((DBMState *)opaque)->save;
+
+    return migrate_dirty_bitmaps() && !s->no_bitmaps;
 }
 
 static bool dirty_bitmap_is_active_iterate(void *opaque)
@@ -795,10 +814,10 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 
 void dirty_bitmap_mig_init(void)
 {
-    QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
-    qemu_mutex_init(&finish_lock);
+    QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
+    qemu_mutex_init(&dbm_state.load.finish_lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
-                         &dirty_bitmap_mig_state);
+                         &dbm_state);
 }
-- 
2.21.0


