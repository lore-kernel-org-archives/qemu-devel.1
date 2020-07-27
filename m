Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BCC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDD32074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H0TvTa5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDD32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0933-0004nU-Bm
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091p-0002Ck-OS; Mon, 27 Jul 2020 15:43:17 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091n-0003fu-SP; Mon, 27 Jul 2020 15:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc1AmhBb54F6F5XbbyPkjJAShoRMD0X8oi5wmVld4CEkutf/+dJGZ4QGHkD76gCrGWq3oYFy5pdC1lp7JVqR/Q/lamMoFFaa4h6FqCYJbVRffDhHxQjsIz4XW233vHQ+ADKEJQFwGU4Xq4FYeXnIfoOVERXG/jd0qr4dGAWsC1iQpIW2141azyrluGq6qAzRrGHP6pIz86G5F/sVk0U2g2CzjLNN+v1yJQoSE1W2rGz+cdCQ48YtotinsxgD9fI1gQ88A3s9h/ABH2utVJmgma/E+EsWsMi2rR8/05F9M3zKSSBIg09AdvB6+bm3Q/obToCsEL1o286NxiEMGEOUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJz/6uNkQvviCpEQRT82foNK1gNYcCC5arhGIcj14zU=;
 b=XN42O9oK3C/zxuVULzfnq3rjI6c08bWR9GLuFOuD48crvFdRNSs9h6f40AAVMwUsSI+5zUTDRefrMDLITaQ0IhAOL/t4Fa5YHVGAJE4IVMzEOkC1SGDi5kifzULJM1UAOaaIRcAfAxqy4Hzl7RiST1OjxLwmuSlxfyWN7VDOOQMPqeKgSKaJtA7eh/dCjTqHSif2gpJ0aWpN3wBxQ74MTGklireBs9sbfVzrESfCvpWtNT8XUkcjehf6fCQzuvOtkviD0/zvk1DXVWEuW+a6u2p8pL7fi58AjIAGU5MvfS/vLO7aVVQ0Onoed0K1LFUVrh1V5afqPpqmKjgGgqkPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJz/6uNkQvviCpEQRT82foNK1gNYcCC5arhGIcj14zU=;
 b=H0TvTa5YJyj5UelCJRqGia61ohiV6smJuXwT5kkUvW7ibb8PjSX1SDVQC9PLqxZ4RzLCSrgqc3edqo5ktWYvxR5u/bVD6GfCGfK9irnIuFaT70Of5C520HkolHEGQlfDXmhtcwIQgFUbu3EdUsBr00pjBLe08njz+h2Au3xp+3w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 14/21] migration/block-dirty-bitmap: keep bitmap state for
 all bitmaps
Date: Mon, 27 Jul 2020 22:42:29 +0300
Message-Id: <20200727194236.19551-15-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:02 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3888acd-c3c5-4cae-9d37-08d8326546ee
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26102CB167FA1798CFA8C420C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzsqA5fIADs8YzWXP7AKE2RQx8xHNeMMf/I5LdI/WzgnrI6W5GaAolw/raaeYfaqyzptIuBYajeJUeRxPg1rsqOLhKiY1D7xFAK4R4WDkm4P/irouGCQs9HKXJEqeN3lmuBxLnFOHzqNtEalnthcQS15VqZJ2vC/2i0PThbp+dDeAnCFs0K1yBQuGqWCDHSJTahmCOYJS+azFzv/eKUZtfsTEeCXBcPss0hA854Uei3OngO2v/657/inGtQBluU6Dm+VHcm1AMtYMEIW0rML6LUc2UDQuzo0JgkdX5BVydSzCXLM82q8O7v2q7uFN0c8Z6YPNX89zNPNd2xibWGPfItJJUzG6NrV94/c1vEffHPjF/MOVgZcLOL5l3MTlplg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cLz7ovySvytZiQtwlR7OAVKt40r9UEWgmYS7szEyFzdVS4KWWkb0S6fHEIcQyDgo5KPO+n7JDCpWPiYo3hZhlQcceGFr0vd3zd0jDk7mrQtpLM5y0Hp+y+gEuq06pffcMVkKIyzZrzKVArjoVoDYR6MXPlq/hvCx8tFPHKEo+I77iJXYiOkeLEefpxFhqVaCncIhob8w4/qQ47QCdMORFKSyBj4YL0wr7pqoAcGW3ibZWD/sGDXRTRn++0GYNPhmzpTbvdW7KJkI6AzxwIbyLl5qSIrCUaqKFqQVMZA1UAwkXizZZstIrBxhBrQV6ictv0hdeTJ4UyTIkozr5wW6WaV+8TpNFW8kmAYZy96e9OncNCa7JUN7jm6qw7DmLkzQBMTS4bmOFw9Qjm7lymP0cGv8+FMyiGkvBLrumVzVwF3zdLbBYHAmSophC+VAoEpUK4MROqgB+TY60OpGm/xEKgd1X3RLATRppm/Wv+oavfU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3888acd-c3c5-4cae-9d37-08d8326546ee
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:03.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQS+IwAiG/slJuGqcQkopWCBUTehw6WtnEVz0tc/8cfLYBWsHDH/VfJn8MIQHJUeWljTIz0sDsIahusBIjth/R9Zfa8GefCAHFfXt8C+zWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:57
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

Keep bitmap state for disabled bitmaps too. Keep the state until the
end of the process. It's needed for the following commit to implement
bitmap postcopy canceling.

To clean-up the new list the following logic is used:
We need two events to consider bitmap migration finished:
1. chunk with DIRTY_BITMAP_MIG_FLAG_COMPLETE flag should be received
2. dirty_bitmap_mig_before_vm_start should be called
These two events may come in any order, so we understand which one is
last, and on the last of them we remove bitmap migration state from the
list.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 64 +++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 405a259296..eb4ffeac4d 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -132,6 +132,7 @@ typedef struct LoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
+    bool enabled;
 } LoadBitmapState;
 
 /* State of the dirty bitmap migration (DBM) during load process */
@@ -142,8 +143,10 @@ typedef struct DBMLoadState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
 
-    GSList *enabled_bitmaps;
-    QemuMutex lock; /* protect enabled_bitmaps */
+    bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
+
+    GSList *bitmaps;
+    QemuMutex lock; /* protect bitmaps */
 } DBMLoadState;
 
 typedef struct DBMState {
@@ -526,6 +529,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
     uint8_t flags = qemu_get_byte(f);
+    LoadBitmapState *b;
 
     if (s->bitmap) {
         error_report("Bitmap with the same name ('%s') already exists on "
@@ -552,45 +556,59 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 
     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        LoadBitmapState *b;
-
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
         }
-
-        b = g_new(LoadBitmapState, 1);
-        b->bs = s->bs;
-        b->bitmap = s->bitmap;
-        b->migrated = false;
-        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
     }
 
+    b = g_new(LoadBitmapState, 1);
+    b->bs = s->bs;
+    b->bitmap = s->bitmap;
+    b->migrated = false;
+    b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+
+    s->bitmaps = g_slist_prepend(s->bitmaps, b);
+
     return 0;
 }
 
-void dirty_bitmap_mig_before_vm_start(void)
+/*
+ * before_vm_start_handle_item
+ *
+ * g_slist_foreach helper
+ *
+ * item is LoadBitmapState*
+ * opaque is DBMLoadState*
+ */
+static void before_vm_start_handle_item(void *item, void *opaque)
 {
-    DBMLoadState *s = &dbm_state.load;
-    GSList *item;
-
-    qemu_mutex_lock(&s->lock);
-
-    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
-        LoadBitmapState *b = item->data;
+    DBMLoadState *s = opaque;
+    LoadBitmapState *b = item;
 
+    if (b->enabled) {
         if (b->migrated) {
             bdrv_enable_dirty_bitmap(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
+    }
 
+    if (b->migrated) {
+        s->bitmaps = g_slist_remove(s->bitmaps, b);
         g_free(b);
     }
+}
 
-    g_slist_free(s->enabled_bitmaps);
-    s->enabled_bitmaps = NULL;
+void dirty_bitmap_mig_before_vm_start(void)
+{
+    DBMLoadState *s = &dbm_state.load;
+    qemu_mutex_lock(&s->lock);
+
+    assert(!s->before_vm_start_handled);
+    g_slist_foreach(s->bitmaps, before_vm_start_handle_item, s);
+    s->before_vm_start_handled = true;
 
     qemu_mutex_unlock(&s->lock);
 }
@@ -607,11 +625,15 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
     }
 
-    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
             b->migrated = true;
+            if (s->before_vm_start_handled) {
+                s->bitmaps = g_slist_remove(s->bitmaps, b);
+                g_free(b);
+            }
             break;
         }
     }
-- 
2.21.0


