Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74901C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F83A2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O1Rd4Qwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F83A2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytO3-0002b7-Dm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJC-0001jO-4o; Fri, 24 Jul 2020 04:44:02 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ9-0008OD-PM; Fri, 24 Jul 2020 04:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+yKiA8Tj1NNzBpVDAb9cgg5413fbLotP1ctt0YaRViZzg7Re1b8ZemG4XH9zV1P4VDQuwRpS4GEaWGJ9n9Jqv82Qt/YBBCyazJpfkBmiPGDv7S5dzVxZBHiH6z/cX8xhb2uXQK11cE2O6DuBN7SYaZJMCSEsYYmrR7VMivd2Ifgrzkp1zkERYG3d15zvXR9cYzZ5r+X8l162JI7y03qAz+8FpjvUzShYFabN0Vlp//wwmEQEEwIyez+s/l54TaYrgYbEhsPdUfkmXX9pp7xg6GNG3askcj00Oq3pbUgo6iXyp32jHaej50Y9yBrFDIsblwcHhaALReo7tNeri8i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw910HX6zmutdFxO1V4xG8fDRTG0jT6yD7Nn0Tzd7yk=;
 b=IEx6t+OaKSoyDJFmbpDEMCA+IbGtDanZB6Wra57flWKMqsT5lxzrQMLnau0IOo8nvJ1b9glyr5sQBNrcVh4qTubNmmN5KiMAv8KiHCOyaCzRyMGysAwIocaT0B7Ml/r1qUgm7IxMV36brhzHrQSeaFllbPAqTaDaAGsqOGbvKjDZ4mZypt4AMty0o3ALqU4Urc54jECauSEW3tDXtqaFXKeCYXh80qVLO5yxeye6CVDlezPwytYGzO/l8KFsbk/h58Dn3IR8b6Q1SB3XIB2mNnjqmPLkDEPuPHAd/IzRprcLo6ZqJ9HpPIJrhQvfveeH2TEzib4bAlnjfo5bq4heEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw910HX6zmutdFxO1V4xG8fDRTG0jT6yD7Nn0Tzd7yk=;
 b=O1Rd4QwuWaY7lu86TUWdymP6H7BBaI2n/HtnLtMfnpV6C3GHf2p8vXkDL5VWXm925QTqzryRfnlTHaRRgu4KLTluiP6KVu6FkqfKRZUycdIYiW1jPU5me+OZo0uzWpqnOclSNRUYGW8wwKS2dzK40PBsN31GGryqYhsQGj7bKSU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/21] migration/block-dirty-bitmap: rename state structure
 types
Date: Fri, 24 Jul 2020 11:43:14 +0300
Message-Id: <20200724084327.15665-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48c459e8-641f-4f8e-ecd9-08d82fadb00c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534528CA9B51F95ADBD4E77C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuwdp8u+mEXHEgiKQr30LNMm8GOyY+8Fuxs/TWlHFxVXUy1/aka4yK4G27+7HqAvsOdHRy35u73yT7ArScm9JKMKUSKT1R8nvqP6/fETwiag0LDkpZxKCcnYoyXLNrjDgHs+899ew0cmu3YlSLOHZiP3gVnJDCEKFHL6ULXlRl+fuN5OTBRZPasVB8xJi3YPD8TP1lqP/z97bT/NSDTEKvTQBq4YjjiM9yQmZQON++TiTYC9eMyqk3/U4mvtZ9GkagQQYEPamZn4LVBSYBCOeiO3219qeaF9fVZY3TbXT1TRLCwq+5G6Y1wGg4tFTOtv3d11XOarB3Lzyy4wcWibsfXzw5b4S//GgZfP9x1LDXbxGaiwklTpbonxqer/l4b3ZcrbwyR/pQ/HLAaawaJszjFRlNNM8d/XNBD6+DPKyx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CrtCbb5nXWXE0CDasnzMCHyzDctR1o9kVXL0rmlPphjszgfx5qsjU0Dw05jx6IO9HqU5z7yr4o1DbD5VpLbkKTYFkEWGll7qtq/lP/dmU3/6Vr+IZbX1KlgXF7f821xNDbkqegaylaRsag/WdtYRIagatbqa4agRs8xYjEvoonzsZQBVpan1UzbGhUrvYoy7KsdCLzF2i70PrbIZf6lzZTjSBhinMhRaTYeS6D1VP1slwVWRBRohSkIVYxE+ztEles0Km/wIwTdf4NpVX99h6BV9dAmuXFv8Ju8NccExJIn59G0kXOwgmYp0YtOY7aeKjrx0G8FC87hI5cMCa8jAN1rKgSC1EzS4XfX2EuF8bE5lxWAw6H3q9WpXGLiKHSkoyFy1FNrylRJ7MoZeXpByewEgjqIe0SqPGRm+l15ANnmF0UrtA6Dp/SqSjjB9lT3dQnMgQOlc9roz5CTnEWf7Vc8bpRn/nis6WTwc/AnXSKc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c459e8-641f-4f8e-ecd9-08d82fadb00c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:50.4072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86NCuygYdtp3WSTntIzFd49OJ88LqhZKdVhRQXp7YZDG5kkKiyBGKAHPxORjvUxoe5Vlzf5TaRq3Cwzy2LcaYGWxDKyUEKOaqvNJuU2LtZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
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
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename types to be symmetrical for load/save part and shorter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 0739f1259e..1d57bff4f6 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -100,23 +100,25 @@
 /* 0x04 was "AUTOLOAD" flags on elder versions, no it is ignored */
 #define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8
 
-typedef struct DirtyBitmapMigBitmapState {
+/* State of one bitmap during save process */
+typedef struct SaveBitmapState {
     /* Written during setup phase. */
     BlockDriverState *bs;
     const char *node_name;
     BdrvDirtyBitmap *bitmap;
     uint64_t total_sectors;
     uint64_t sectors_per_chunk;
-    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
+    QSIMPLEQ_ENTRY(SaveBitmapState) entry;
     uint8_t flags;
 
     /* For bulk phase. */
     bool bulk_completed;
     uint64_t cur_sector;
-} DirtyBitmapMigBitmapState;
+} SaveBitmapState;
 
-typedef struct DirtyBitmapMigState {
-    QSIMPLEQ_HEAD(, DirtyBitmapMigBitmapState) dbms_list;
+/* State of the dirty bitmap migration (DBM) during save process */
+typedef struct DBMSaveState {
+    QSIMPLEQ_HEAD(, SaveBitmapState) dbms_list;
 
     bool bulk_completed;
     bool no_bitmaps;
@@ -124,23 +126,25 @@ typedef struct DirtyBitmapMigState {
     /* for send_bitmap_bits() */
     BlockDriverState *prev_bs;
     BdrvDirtyBitmap *prev_bitmap;
-} DirtyBitmapMigState;
+} DBMSaveState;
 
-typedef struct DirtyBitmapLoadState {
+/* State of the dirty bitmap migration (DBM) during load process */
+typedef struct DBMLoadState {
     uint32_t flags;
     char node_name[256];
     char bitmap_name[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-} DirtyBitmapLoadState;
+} DBMLoadState;
 
-static DirtyBitmapMigState dirty_bitmap_mig_state;
+static DBMSaveState dirty_bitmap_mig_state;
 
-typedef struct DirtyBitmapLoadBitmapState {
+/* State of one bitmap during load process */
+typedef struct LoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
-} DirtyBitmapLoadBitmapState;
+} LoadBitmapState;
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;
 
@@ -170,7 +174,7 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
     qemu_put_byte(f, flags);
 }
 
-static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
                                uint32_t additional_flags)
 {
     BlockDriverState *bs = dbms->bs;
@@ -199,19 +203,19 @@ static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
     }
 }
 
-static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
     qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
     qemu_put_byte(f, dbms->flags);
 }
 
-static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
 }
 
-static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
                              uint64_t start_sector, uint32_t nr_sectors)
 {
     /* align for buffer_is_zero() */
@@ -257,7 +261,7 @@ static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
 /* Called with iothread lock taken.  */
 static void dirty_bitmap_mig_cleanup(void)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
 
     while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
@@ -271,7 +275,7 @@ static void dirty_bitmap_mig_cleanup(void)
 static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 {
     BdrvDirtyBitmap *bitmap;
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     Error *local_err = NULL;
 
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
@@ -309,7 +313,7 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
         bdrv_ref(bs);
         bdrv_dirty_bitmap_set_busy(bitmap, true);
 
-        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms = g_new0(SaveBitmapState, 1);
         dbms->bs = bs;
         dbms->node_name = bs_name;
         dbms->bitmap = bitmap;
@@ -334,7 +338,7 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
     BlockBackend *blk;
 
@@ -408,7 +412,7 @@ fail:
 }
 
 /* Called with no lock taken.  */
-static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
 {
     uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
                              dbms->sectors_per_chunk);
@@ -424,7 +428,7 @@ static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
 /* Called with no lock taken.  */
 static void bulk_phase(QEMUFile *f, bool limit)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
 
     QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
         while (!dbms->bulk_completed) {
@@ -461,7 +465,7 @@ static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
 
 static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     trace_dirty_bitmap_save_complete_enter();
 
     if (!dirty_bitmap_mig_state.bulk_completed) {
@@ -486,7 +490,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
                                       uint64_t *res_compatible,
                                       uint64_t *res_postcopy_only)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     uint64_t pending = 0;
 
     qemu_mutex_lock_iothread();
@@ -507,7 +511,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
 }
 
 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
@@ -538,7 +542,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
 
     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        DirtyBitmapLoadBitmapState *b;
+        LoadBitmapState *b;
 
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
@@ -546,7 +550,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
             return -EINVAL;
         }
 
-        b = g_new(DirtyBitmapLoadBitmapState, 1);
+        b = g_new(LoadBitmapState, 1);
         b->bs = s->bs;
         b->bitmap = s->bitmap;
         b->migrated = false;
@@ -563,7 +567,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_lock(&finish_lock);
 
     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;
 
         if (b->migrated) {
             bdrv_enable_dirty_bitmap(b->bitmap);
@@ -580,7 +584,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_unlock(&finish_lock);
 }
 
-static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
+static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
@@ -589,7 +593,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_lock(&finish_lock);
 
     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
             b->migrated = true;
@@ -621,7 +625,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_unlock(&finish_lock);
 }
 
-static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 {
     uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
     uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
@@ -666,7 +670,7 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
     return 0;
 }
 
-static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     bool nothing;
@@ -715,7 +719,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
 
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
-    static DirtyBitmapLoadState s;
+    static DBMLoadState s;
     int ret = 0;
 
     trace_dirty_bitmap_load_enter();
@@ -753,7 +757,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 
 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms = NULL;
+    SaveBitmapState *dbms = NULL;
     if (init_dirty_bitmap_migration() < 0) {
         return -1;
     }
-- 
2.21.0


