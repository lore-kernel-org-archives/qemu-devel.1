Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B62C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A692072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lRmzp2XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A692072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09AA-000093-CS
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091j-0001wR-SL; Mon, 27 Jul 2020 15:43:11 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091h-0003fa-KR; Mon, 27 Jul 2020 15:43:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQBlVjimDaPbgV31NkSyAE3pwEQuEoWpvAE9aK/hWtywRDVpj/6+gvCUSJe41D/28Djob78ZsZFfub/xl3bSE7+MMT9dka7jB3pB9gm8bZqxPs6+IlZ7y2guD84BuYReQWgO3CXMDkUA6iRZe+s3jMzDvA19z9VPZdc3afYTAkFCrfxPPehzg7LrHYgeq35ZtcX+dAZvntqIjyxYkCXnIQEtFAqzFBMgGoEunuZTDVhq8+2vI2ex+QXTGUOfN4bDe1kgPJQWrM9Jw45zpPIEsSQOBrgMOoLzuRLIcM+3wUdG/W9cphFUE9fVmGVS0w4SX/V7ne3LNdRKkyMy+PV3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw910HX6zmutdFxO1V4xG8fDRTG0jT6yD7Nn0Tzd7yk=;
 b=ZEgP5N/lHsDZTi8L/UJdgemtIl2cl3aX1I/hhJzgCNI1Z3a07p7tne0UGeDFtMXmft5QPl7x42k0RbV1oQNA9vxCH6CsEBH0G/Ey39kigLjQF+qjPKnrQMxx8WkUzFvjCDOTgYHr1Ng66yy5w0L/vkCw/wg52IMDr/EAiD7i4cpPi63/8i8h5B7li0isFNzIjNsyGwZ65TrgbPGdg2X0cZjQFtnY2XK1kiaB9AxuxmfnALPuwg7OGEQFPS94pKNdZekdStsZtkzNSB9Xhdfa3Pqg+SMCMVxO+81gVxYZjynXTS6EvUAYCf3bQ4URNFVwNiokMVjZwBoMJBwBiM5Tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw910HX6zmutdFxO1V4xG8fDRTG0jT6yD7Nn0Tzd7yk=;
 b=lRmzp2XNI8DhxvdEvQ576Fab10JRFJqB/Vu6va+87t/MWsTuAkE51JUEinBP0ZuyTuYSsOkRNmMi6CLJQlZf2J5XgFNBtQHYOIoVpLtFMC9FV4iZG5V7JT0g4XHL/ACeruAFhqoKZdkIhdGHtyX58oJCPX2mAkhC2HOg3o7ErB8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 08/21] migration/block-dirty-bitmap: rename state structure
 types
Date: Mon, 27 Jul 2020 22:42:23 +0300
Message-Id: <20200727194236.19551-9-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3937aaec-c9ef-43ed-b413-08d83265434c
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26104318D2EA00D32D89E009C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLMwA4C/VIsvwuqRRqkkL1lLWBRwu62vhyIvYYpq/vUsOIHJzCnZaoOFDb6F5ITruf5uast/qmJjCYBY54dQ/KkHD9wWgixCylLz2k4ReCa3jtBdXLTaGvBmnNyV+1YQcAcPKmsQclRYB+cKFcsrefbn4Y2EdwQVMfM6rGrjvU1F3edocUe4aBTmHOKno0xqv1NBzqIiWI7qMEJn3OuvCUsWBWll28Ma1kEzgGFNAbj35QREP3gLEAgX2aO0uGLMIXdL4fl3oRAjc0xZjuxFoYnFo2xkX8jit9U9S2PamvN1hYOUHOBaxKQYgF3SIAhmb8YzAXExOrcsIEeD4GUbqdsaRtPLpV2IAG9r9UjBoRyEJ77A1tMjI8yJf3w9VoXS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: k7cFQtFYQXn6dxspxlvkhzOf7FESWbifUWJeXy+ZKo3sDI0x7e2VuCKJqf9ArsVTrO/foF8K5RHVBAn8JWCTL3w9sosHSIB96m3S2PxLG0S2QKidsvff/3mkYD3pxe4SNCS1sTS3R2a3tydOGwtN1fgTVZ70CD6P63lf22NneIhjxAkvaXZDQsdv7DB+ee+DhWfcT89oYuUoU9V+ZzKIaPFaq2CjounqZOUBMbHyGnSCy+qQc7a1lLm9W+v2uLDI+X1v9Slk7TNBcPd4bDFnJoJS/D9i4wpsZQ5Gm5tIw6mFNqPtl8eis8WYspa2ZWQM8l2CLo/hLFV/EbDJoefde/d19FbWlsYKm+YaqAqpli1XxpV8jCUaRSfcoAFL6k8zPRsKmhTsaAezHaOiUBsmxkWcq5z8yT8upLGJsY5e+tsXl6EmXLrtXnZGpC+FYPI5f/tQbcn1n2QTmePinDrY21BXj//9upCuDQt3RBUtCKg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3937aaec-c9ef-43ed-b413-08d83265434c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:57.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft1FKWUOUSKhuijlrgzZy/dh6vi8m6YXByNOjzLaEApCZCyNmxNUoMv8s2rnJimYbcFoymu0Re5LyGLx+5eZY/xLt4JFndhjJh5eG8qZKF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
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


