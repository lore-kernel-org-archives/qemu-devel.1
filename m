Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E03C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1CF2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D8mdwwff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1CF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Ei-0001HM-T8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091r-0002HX-Fu; Mon, 27 Jul 2020 15:43:19 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:11911 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091p-0003hz-9F; Mon, 27 Jul 2020 15:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmcONKL98Xhj1sKRTKdKTUrGpw2pqWDb29knJVww9VlC5pxRIHhO2OKVHPu9PEsEHhbW470lJlDdvTB+ce5OU0OECIgEcJGYcIDU1N39bl0XyIFRgfvc8xmV8y0sS71pjOsQUAbxXMYg+9p2KBPpX0Ysmh8LN9lqL3xejGTQB6znWEFKmAogVWAYJH9DhUw6BLXk4Q3TgxlkC6ELwwKnwmnVUUxa0KHF5mY0HatbypUkXqAiD1Qlsj/iboakJpS+UVELxIyzalo6kkBFROx8CZnp105rDiPdLqeUOH469NQk0gBi3jxLvhDtAcJHydORzKwxtTsnrsUmYdwwuEe6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YavZ1LfW83NyyYRtN8DuSm/JceHzf1c/BlcUT6odU4M=;
 b=nxUeSX8woU29g/2AzWz8lmJB1i8h0HUcOJFiPRqP7oE5ykszBlhPjGsGsqCgcSbsw2QlgnLeaZuQG6+xia5yU+BoB5WOXgXtmzyVC81g5SAu7OTuGqRx6mDvtO5GgIgU7xZF07Pqr9ykQ/Np/vp0NR65utVXXYVJlqkvMaK3yRlL5npaMGw+NVa/2gkPxzZR4WJWJqSluPEpN9aVSaUTayg4U4+cLcGToM5Nqswb7cefw9Q9MhekK3ozeWEgLbCS035mSagjPdAEzO22sT+lT2TIbOHmm/OgnAklDUZHQdiaKSm/uaZEE/ROK3ZW/7rem96gP7wdBSruYVh12iuYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YavZ1LfW83NyyYRtN8DuSm/JceHzf1c/BlcUT6odU4M=;
 b=D8mdwwffkdwgH5TpVkHfXXf1Rq8KV19IMjmemeLEc3Azn+5WCWfwLiqGCf+j5U/thY9IqotvHpzYIDYSUSEMQEknFUxDw/60y205yTxbw4S/hd/ek/Rsd1r82YWXir1dnlpjLPRfpHdSLR4iivAuzXWw5I+k2SJycioMtekrPLg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 15/21] migration/block-dirty-bitmap: relax error handling
 in incoming part
Date: Mon, 27 Jul 2020 22:42:30 +0300
Message-Id: <20200727194236.19551-16-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51bd44bf-5589-4ae4-e6a9-08d83265477b
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610A23EB891D75B3B85D416C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6uzjP6j7e0mQXpIc2iMA4sQJeTxu2og4bbSHYSHDGf9YEbL5ygyL2LjbWwJLrtd5NsCfJuoB/yvWvg0hnAl+yG4DnM1K6EitxX9aOm51W+CCMavTlbrsUOXCPjNBSU6/ZcBkB0QIJrtFewZM4gtcxX9Nyks6YHTl+yAXPUkIR2+SvaIlU3czSoFToeMmK15g+nyWY7JVzvqBIoD2ogzJE07PgMbdmlEwbIcvFOyKsoPG+rLFZfFfwXJbY+HFXCTw/L2ezCdnfE5YF6Mjj7YrSppqni1NJPFsfOeOJnVc8xyx6WgyaA5QBnkaHTY7Va/ACoKEDwEjZ7jQ1m/U/i4GcTrmPvrj6KIMQ/q6GRxtqSBO6Eg3l9V6ogvo+4MRx6J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OJhNg4O7L9vJVRFLzzM+jTwzRj/lZsP8dmifApFkTUqoWaEqqKagGKoORqzsC0lBeofrUWyiotoSnHAsvUg/e9fbjl/hR5r/GSX51YFjqyqK7zzWN8cBMpSsLMo62HGOpWoTkrz29igGGjru1Zro+HOSCaum7wQpN7Jr0lVF0aGzmadbDu4lnVSpvNTRd5XKd6cdMi/IRhecS273ObHlOospnc0GBLk0XIeXJymCu+jpj2soguC6NTjUkpAD8EJlkDwZzGzMz2GTIBiUMkvewUsiFKT0AH9qDt2LCFCINV3zi/rZTq7fOGDv0KJdfN8i27QOsPiqzxRWRb0C8akFsHEqlzsjgsZAs23f+q+JjwK9j/gCcZmCV2mQe8zWVblfC5G9AOBADI2MFwcLAJvE7gqpxtS0isGhcl0R1KTukTr+qzzDap65EYkYKWVDf5BCdPoZde2TM/0XHIEdWA8ANiuLpnVrwLRyrq2tuzj4J9U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bd44bf-5589-4ae4-e6a9-08d83265477b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:04.7792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP6Xru0QbGlC8Ro7EGFvamVPX2i1hg+GbD1G+kqdMExXwWsuWj4rDX3joudjhROpVv4Pv4tWJ5H0fUVChzArRSryYWtoy6e4wajTlajbSBE=
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
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bitmaps data is not critical, and we should not fail the migration (or
use postcopy recovering) because of dirty-bitmaps migration failure.
Instead we should just lose unfinished bitmaps.

Still we have to report io stream violation errors, as they affect the
whole migration stream.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 164 +++++++++++++++++++++++++--------
 1 file changed, 127 insertions(+), 37 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index eb4ffeac4d..4e45e79251 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -145,6 +145,15 @@ typedef struct DBMLoadState {
 
     bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
 
+    /*
+     * cancelled
+     * Incoming migration is cancelled for some reason. That means that we
+     * still should read our chunks from migration stream, to not affect other
+     * migration objects (like RAM), but just ignore them and do not touch any
+     * bitmaps or nodes.
+     */
+    bool cancelled;
+
     GSList *bitmaps;
     QemuMutex lock; /* protect bitmaps */
 } DBMLoadState;
@@ -531,6 +540,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     uint8_t flags = qemu_get_byte(f);
     LoadBitmapState *b;
 
+    if (s->cancelled) {
+        return 0;
+    }
+
     if (s->bitmap) {
         error_report("Bitmap with the same name ('%s') already exists on "
                      "destination", bdrv_dirty_bitmap_name(s->bitmap));
@@ -613,13 +626,47 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_unlock(&s->lock);
 }
 
+static void cancel_incoming_locked(DBMLoadState *s)
+{
+    GSList *item;
+
+    if (s->cancelled) {
+        return;
+    }
+
+    s->cancelled = true;
+    s->bs = NULL;
+    s->bitmap = NULL;
+
+    /* Drop all unfinished bitmaps */
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        /*
+         * Bitmap must be unfinished, as finished bitmaps should already be
+         * removed from the list.
+         */
+        assert(!s->before_vm_start_handled || !b->migrated);
+        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
+            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
+        }
+        bdrv_release_dirty_bitmap(b->bitmap);
+    }
+
+    g_slist_free_full(s->bitmaps, g_free);
+    s->bitmaps = NULL;
+}
+
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
-    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&s->lock);
+    if (s->cancelled) {
+        return;
+    }
+
+    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
     if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
@@ -637,8 +684,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
             break;
         }
     }
-
-    qemu_mutex_unlock(&s->lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
@@ -650,15 +695,46 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
         trace_dirty_bitmap_load_bits_zeroes();
-        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
-                                             false);
+        if (!s->cancelled) {
+            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
+                                                 nr_bytes, false);
+        }
     } else {
         size_t ret;
-        uint8_t *buf;
+        g_autofree uint8_t *buf = NULL;
         uint64_t buf_size = qemu_get_be64(f);
-        uint64_t needed_size =
-            bdrv_dirty_bitmap_serialization_size(s->bitmap,
-                                                 first_byte, nr_bytes);
+        uint64_t needed_size;
+
+        /*
+         * Actual check for buf_size is done a bit later. We can't do it in
+         * cancelled mode as we don't have the bitmap to check the constraints
+         * (so, we do allocate buffer and read prior to the check). On the other
+         * hand, we shouldn't blindly g_malloc the number from the stream.
+         * Actually one chunk should not be larger thatn CHUNK_SIZE. Let's allow
+         * a bit larger (which means that bitmap migration will fail anyway and
+         * the whole migration will most probably fail soon due to broken
+         * stream).
+         */
+        if (buf_size > 10 * CHUNK_SIZE) {
+            error_report("Bitmap migration stream requests too large buffer "
+                         "size to allocate");
+            return -EIO;
+        }
+
+        buf = g_malloc(buf_size);
+        ret = qemu_get_buffer(f, buf, buf_size);
+        if (ret != buf_size) {
+            error_report("Failed to read bitmap bits");
+            return -EIO;
+        }
+
+        if (s->cancelled) {
+            return 0;
+        }
+
+        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                           first_byte,
+                                                           nr_bytes);
 
         if (needed_size > buf_size ||
             buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
@@ -667,20 +743,12 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
             error_report("Migrated bitmap granularity doesn't "
                          "match the destination bitmap '%s' granularity",
                          bdrv_dirty_bitmap_name(s->bitmap));
-            return -EINVAL;
-        }
-
-        buf = g_malloc(buf_size);
-        ret = qemu_get_buffer(f, buf, buf_size);
-        if (ret != buf_size) {
-            error_report("Failed to read bitmap bits");
-            g_free(buf);
-            return -EIO;
+            cancel_incoming_locked(s);
+            return 0;
         }
 
         bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
                                            false);
-        g_free(buf);
     }
 
     return 0;
@@ -700,14 +768,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
             error_report("Unable to read node name string");
             return -EINVAL;
         }
-        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
-        if (!s->bs) {
-            error_report_err(local_err);
-            return -EINVAL;
+        if (!s->cancelled) {
+            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
+            if (!s->bs) {
+                error_report_err(local_err);
+                cancel_incoming_locked(s);
+            }
         }
-    } else if (!s->bs && !nothing) {
+    } else if (!s->bs && !nothing && !s->cancelled) {
         error_report("Error: block device name is not set");
-        return -EINVAL;
+        cancel_incoming_locked(s);
     }
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
@@ -715,24 +785,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
             error_report("Unable to read bitmap name string");
             return -EINVAL;
         }
-        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
-
-        /* bitmap may be NULL here, it wouldn't be an error if it is the
-         * first occurrence of the bitmap */
-        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
-            error_report("Error: unknown dirty bitmap "
-                         "'%s' for block device '%s'",
-                         s->bitmap_name, s->node_name);
-            return -EINVAL;
+        if (!s->cancelled) {
+            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+
+            /*
+             * bitmap may be NULL here, it wouldn't be an error if it is the
+             * first occurrence of the bitmap
+             */
+            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
+                error_report("Error: unknown dirty bitmap "
+                             "'%s' for block device '%s'",
+                             s->bitmap_name, s->node_name);
+                cancel_incoming_locked(s);
+            }
         }
-    } else if (!s->bitmap && !nothing) {
+    } else if (!s->bitmap && !nothing && !s->cancelled) {
         error_report("Error: block device name is not set");
-        return -EINVAL;
+        cancel_incoming_locked(s);
     }
 
     return 0;
 }
 
+/*
+ * dirty_bitmap_load
+ *
+ * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
+ * violations. On other errors just cancel bitmaps incoming migration and return
+ * 0.
+ *
+ * Note, than when incoming bitmap migration is canceled, we still must read all
+ * our chunks (and just ignore them), to not affect other migration objects.
+ */
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
     DBMLoadState *s = &((DBMState *)opaque)->load;
@@ -741,12 +825,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     trace_dirty_bitmap_load_enter();
 
     if (version_id != 1) {
+        QEMU_LOCK_GUARD(&s->lock);
+        cancel_incoming_locked(s);
         return -EINVAL;
     }
 
     do {
+        QEMU_LOCK_GUARD(&s->lock);
+
         ret = dirty_bitmap_load_header(f, s);
         if (ret < 0) {
+            cancel_incoming_locked(s);
             return ret;
         }
 
@@ -763,6 +852,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         }
 
         if (ret) {
+            cancel_incoming_locked(s);
             return ret;
         }
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
-- 
2.21.0


