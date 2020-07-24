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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EFBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3090C20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ciA/shiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3090C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytOU-0003Bl-Fu
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJK-000263-GJ; Fri, 24 Jul 2020 04:44:10 -0400
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:31299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJI-0008Pz-Hy; Fri, 24 Jul 2020 04:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAZFJwKmKTKJhiEsm5lLliYASuQ5BVrBSHGXGqGCyW91tbk/TDWr5IU3AE81TLsh+sUlS46ioHen1/e60d+Ndcpw3DNAlN8o/oMVV2vYez2aPlNfodjiLSMPe0okpk/hUOqMvUhQf88+2YNj0VByl/vhPH6q9VJZcFAiISdK03xehRN1ecFaCoUwBc2ao17aqatD9yhUVb8rhPjoA1BhhjDwosHJJiaBCGkl6Q7kejENj+tQcnoZoDxp8onIuqphSChscmRHkEqdKqceEhyrl3ESJGa4YbVIvaLRqgOA4LzGOzczjFWx52imkTk6aP15V8SL7xXAlp8lwBg/MGXmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJz/6uNkQvviCpEQRT82foNK1gNYcCC5arhGIcj14zU=;
 b=UuN9dJV45zn7jLqmLbyRbmt58Y/o8bcyIwIFPCfbqvAOE9Jzw4oljDRiHld46+49IdcLlrSpdEjmeoOHESN1MZziKlL2XpwTiLUlBIWKrDsEFE1KNLuDti44G+Wb/xLvAXNEw3t0e6JwE1+Zrs7RABeZZwmeS5FXP2oG5zR3y61ITvSWOhTjgYa/q7Gi2b3+JbJG7Tf/EJB7beeIGa+v3U+mdF/HtiVfqHAc8coExQIqBnj3+sijp2nyxve2+9WaN5Cz4i7xbqi0kRCNQ7aBKfV9GfHuuBhJczKxGJEVynT6ISTZ3iPsLJxl705guFoYebGz8qEIQB9gbFfiqcnqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJz/6uNkQvviCpEQRT82foNK1gNYcCC5arhGIcj14zU=;
 b=ciA/shivq4BkIhM2Q5ypdgZLcxOTHIFumTLd46yC90rIHiuEvirZsp0YjXXZJaQuXXKruYhC/jtuzkBv55d0pENCYbV8zyaWBESAStwo3QwleLeUHE8f3EHiHsfISjqUmxeh/Z0w/Fwhqfw/9rZJdfg9inw054CHuqJq1092/8Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 14/21] migration/block-dirty-bitmap: keep bitmap state for
 all bitmaps
Date: Fri, 24 Jul 2020 11:43:20 +0300
Message-Id: <20200724084327.15665-15-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb596f1b-05f0-4338-efa4-08d82fadb37b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534A69779C36E37AC3C426FC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3mu2qXgzV7YHxkKxFefQlSmqdpBTvW7gk+lHwgZG5tIN/+RA8paTl2XYWTeIGRvdBC+EDSLbSg1hDlHC4CnfyKx/66Dn/9mEBcibC2BEZd3nsj374Q0f/r80EDkueEdegLqF0/ffzzFpSxaLYIsrtLzhFKSJzJvs9slac6p3N9aqEaoWNOtPD9mnbevV+H3x5hATMrVJcdXs9n2QCDeYZbpYcpJd9VmaclbwRclWV6Es3GdRdLVAWAYRo/I0CDDbMJcrSLgZ3YqTUAEkJwkH40q4tdfULQCvDCIHs3DjT9iOykJl8UwkTFKHcJGZGf+qCc+r1P7/1YpQOW4NFCY9ZrOflBoC6yT8zFURt/6rCslTsRojDmO6fBPMf91fj77ipGEIBONZmRS3g65U9zUhQHX4AoLRT4HeMrsmBU0Mgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +toFTHe2z4Gerx3BR1ChHeYmEks4ok435FGn0zp8fzjR4xqTF9biEpBLVb/3m7qKqSCUjtIXEhnCBMveQtC/7sTp6n4x9O4oyeE7vDPDTa2t71SM5sVGkvOS9VJ2J2P90R+wYyyHSnvU2Z+vgc4X0iBLzsoLa585unKiFC68TTgTeuDqmx+l7dDul5KNFy6e+ezXR3aTmVxNNnNPk8mShaEE2acVsyPKBPoCeQgwb5El0cbrglAVAO//KrsbTDEotE8yH/SOudCiRzUmdUGRTaW6X8MhpAfyxU/CiE5tH0hcJoAZ/M7mqNiJBEFs2FuPKk4OzRK2m/ueJry1pSqStYeVRVbuGJL5+xzqHaOjaiDiaPNEkQL5VxFPQFqMmVZF5XIPS0uI3rFM4MQ9sD6T+g60ZRmLYp9PuKiA0NMPZ8Cv+LhgBCf/TGHYZl3ynMmUHRns+5EPSHTsRzmRe2X4T2klBEYibIsQb0pnvrmlow8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb596f1b-05f0-4338-efa4-08d82fadb37b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:56.1569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CsJWiChmbDF46PU1Rnd2+zcZw8cFFqwU0oAeyhay/qQCSDfcrD008y4QUSo8V6/9QZctmu+WgJ9HEDwgPSe3T0JCQ2543czUVEnIPKtv8A=
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


