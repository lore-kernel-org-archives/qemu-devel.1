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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D22C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50BC206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="csDe3tNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50BC206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytWe-0007CN-21
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJN-0002B7-4z; Fri, 24 Jul 2020 04:44:13 -0400
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:31299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJL-0008Pz-2f; Fri, 24 Jul 2020 04:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmmV7dBbmvf+AewTtlCaJwtquT4VAsfOyMsDwtKt8OYE3ZpguEBuCew25Tl4RMmyIk738Bk0fNmD03+zD+GHmbpnvPDp8ZiSryD02HgyFQkqI9immBHiRsJFIRhCh0vCiELgUHW5xYLuyER3nWqMGSPGfIrVk0//HhToOLsM+vB2JKfhRSuYB87obuIA3Z687gDc0emFT97w122q0aOvfAdSQVZ+LZGIWUJ5rKmRZoujwXp0RYRHSpqG/xATuAq6gtFK9HGDexyz0Pjd8us8C0DyvCWVj9hAad9YA697ssbTRxA0Z/6hzmuqCGG2BfNiSgnXvXQRa3RDiwEDvoyWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMpKHaM1T4DGMfhxNR1tENrd3lNYCRq9gAmCP+uILUE=;
 b=E+jADHfaYO2jqGPbFIWvD6pAe9AwGM8Cjyu7kKpOi/tjmfRqczrpkgkh4yiQhHHFrXUzQIFsC3ZCvEULMGp0T2IFcd6TNWffyHHRvfuqnM3dzSdS49+RkcNxbCD4WiwCcA4DL9tciVK3bBwVQAEV5PY4uU/sms50EcOpyoYgsad/t4UYMkatNvgz+2bHq+AdXNIkmH88B2gGZj/b05FcAfBhBm8nB2sTLOVN+agEtxlr2Xlu2rbe4y1Ek16OU6YFKi3/ioq8469pYbet8HJYSBg1DwDi7JUshkpnpL3YUkD/zR0AaO3VYRwTv2O5kuyN1THnaT2uqIXJrv4NzWOZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMpKHaM1T4DGMfhxNR1tENrd3lNYCRq9gAmCP+uILUE=;
 b=csDe3tNSehuLrBWhINgK/8HYiEJMiez9k6E5D0MRHnTeFWuqIFx+gIaOyyGeikDb3KR7tTBk3D1e2LhzYtWKe06w14FbsnffJTj5/sYsuLmaN8/9C+UXtmiklqbSPnP0fmY2/2HFc2MSMEdGH1TU7fBbCSwXtcXU8s+cSEjEk7k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error handling
 in incoming part
Date: Fri, 24 Jul 2020 11:43:21 +0300
Message-Id: <20200724084327.15665-16-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1bd369-177a-47b2-a0b3-08d82fadb40d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534BA9C97C9E7F31F5BCDACC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du1MQNh2InkXsVpVGkpWKcZF7apAhEald/NX9Ten49uRpyYd/ywKXQKNRFy6G9U1fl10JaWdU4xdeYUOs9ydkbBNMu5aonmaRzNkTnBTgnt2tYk78sHK5tfBkgswdtP8K3Fvb2gHpsNfbFRKN1qGxtsHXJ39isDqeK40nYXe4y/WEkU1XzzTqqaaC42/79HYK4sgpa8t+MDGk8NyEI9fHW0y5EkY7ECy4+W8CePaZMPJpqaFI5HbxTrGIwIFC1huZVZjNLZbgxQtGXlWcwTEBPAyAr4eFMNDOvK+5OvpGu11aUhyRQmxHYSbvXvQNGDoIrcedp1jELVdPNKtuygAqGphpAL6Lsu+Rzre/Sg8tswElm+QJGqTgJOjNJ34ypQSp/UqI41bm0UzBHPJ1/ocLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZLOUJvb6TdfTKnlE3eU11Mz2GFGxyPLYWfqdxFxJtYfLhNYQZKwQcfOkaUdwayYOer+K37gFDsVJf3Ay3dd1nBlHZeWnIa6aBBfUMtGlHYDgxSVhh7vS465zCBv1rjec6tkTCrLIE2cTdIQmckCPw7cGrKABQ74ytqHRLZSFz9pSeIcHs6Oi3237ywiuZB7rAWs8qts358kGQA3eoD5Z+AbWpkwqE8ZxmvbgAfBOu0SkIg4tbHBiBwqAAkEL18aWG0T7ZB8cTua68y2nge2PcjZkLnu+3tP+SNI6WlkPbZMvZ8NCmgrcAjOAe5Szmmm6N/U1d+8x54JI3U913NkytxXPk/EZ5/VGQRVVlp41xAg3Yj+TIDDZJHL9z0ItyVvrxY5BX/joZlb7Dd85i8whHKjkLPydZUzXo3SKb+K+wKu6XxNer7Gy1nJcVNf6B8g6VeKdQu8BV4yZ6K+MSyudyeLg0J/6u/XZAvEOk8Xk/NQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1bd369-177a-47b2-a0b3-08d82fadb40d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:57.0779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmdhZbNU1EncSfacFituGif1yN0SGSa28g18JxUZxDyYP1H5aAmIfP8S82VcWWHNZQVHmyVFAWnRbL8PAu3zmPPUn7k//atP8RTkInhBxRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.8.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:59
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

Bitmaps data is not critical, and we should not fail the migration (or
use postcopy recovering) because of dirty-bitmaps migration failure.
Instead we should just lose unfinished bitmaps.

Still we have to report io stream violation errors, as they affect the
whole migration stream.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 35 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index eb4ffeac4d..c24d4614bf 100644
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
@@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 
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
         uint8_t *buf;
         uint64_t buf_size = qemu_get_be64(f);
-        uint64_t needed_size =
-            bdrv_dirty_bitmap_serialization_size(s->bitmap,
-                                                 first_byte, nr_bytes);
+        uint64_t needed_size;
+
+        buf = g_malloc(buf_size);
+        ret = qemu_get_buffer(f, buf, buf_size);
+        if (ret != buf_size) {
+            error_report("Failed to read bitmap bits");
+            g_free(buf);
+            return -EIO;
+        }
+
+        if (s->cancelled) {
+            g_free(buf);
+            return 0;
+        }
+
+        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                           first_byte,
+                                                           nr_bytes);
 
         if (needed_size > buf_size ||
             buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
@@ -667,15 +729,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
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
@@ -700,14 +755,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
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
@@ -715,24 +772,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
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
@@ -741,12 +812,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     trace_dirty_bitmap_load_enter();
 
     if (version_id != 1) {
+        qemu_mutex_lock(&s->lock);
+        cancel_incoming_locked(s);
+        qemu_mutex_unlock(&s->lock);
         return -EINVAL;
     }
 
     do {
+        qemu_mutex_lock(&s->lock);
+
         ret = dirty_bitmap_load_header(f, s);
         if (ret < 0) {
+            cancel_incoming_locked(s);
+            qemu_mutex_unlock(&s->lock);
             return ret;
         }
 
@@ -763,8 +841,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         }
 
         if (ret) {
+            cancel_incoming_locked(s);
+            qemu_mutex_unlock(&s->lock);
             return ret;
         }
+
+        qemu_mutex_unlock(&s->lock);
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
     trace_dirty_bitmap_load_success();
-- 
2.21.0


