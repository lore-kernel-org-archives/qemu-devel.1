Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75428C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C617206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oXtWt6kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C617206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtMN-0005ZJ-Bp
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLI-0003rb-Lk; Thu, 21 May 2020 18:07:09 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLH-0007vC-5a; Thu, 21 May 2020 18:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1UysHU5Kl5EvrWwAANJeGd4qjMgHEUJfQBgxavSbEqfwLIZxqdvC6VcTfWOmEw/UOAfdFeh/Evzny1grw0mjxjmL23AAGEzY4lNrkJM8md72ZmQZb3o7Jo96TvQJzeG5dO1KkDVuiajyl0G7IpkxO5gqWq3505jVrnERfICPSk2vDH6xgsXDG1T8KncerdCEacuOKYJCuPaAES4O5L/A3xVYEq42NpV5X+XwqvVxLOUZwjMMRr9t+6uAj+W/OS5TGBfi2vjZ4E1MqQcO7G2/JRPLTtyweCJEvRq5Zl8YNFc1mvJ+ZwXfp6y/EDKXGI9Bknn3W0mbPKFtN88je6QEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lip4dD19i4EOeKiQ0LX1sMJZbgdXQCeU57yRCNf1Zk=;
 b=fJpFSr/3C9BBzOTqF/b2D8i0nVl2Z/SsTONaPwBuzLfKftepbsTQuhH0VxezZi1Lp4JSeqv7s5+SpIrq74YbzdxDaeZzQN3e5XyTSIOrrDACvooZiEZKwUQ2Qq9KR2z0TdTCBVuCBeCkiSIgniDX9jWmaQGdIKdXrgcGpwXhiDJiJLGnntsa1fqHbCDE5Y+juw43agAQ/tivWAxVC5wrMc3K6DJ9gCnaRD8/9FaXPbtsUYqoubH2Cp+gIyvcbFcj/7xXF7zHWCSq41isinOMozy+3OtiKkcThmtB4EW6/gqucLtFjHk/JoICb7hfOZK2oMzQSJWGz8ENykhAhmQXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lip4dD19i4EOeKiQ0LX1sMJZbgdXQCeU57yRCNf1Zk=;
 b=oXtWt6kFT3+Bqvd7/i7+87UMAN0t0kcte9DyCdBCP9xAkJJwhmFWt/YOAEoTbHekGGfb49tCP/6ztYBYU/Ahck/7lelOpn2muxs/N0ouTpw8+/CSnQVVTpoEiheiRw9ZtKc1LFMo+w7fUAg1Htnl1ep7Sh6FnYyJmfvGUmV1FiQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/6] migration/block-dirty-bitmap: refactor
 init_dirty_bitmap_migration
Date: Fri, 22 May 2020 01:06:43 +0300
Message-Id: <20200521220648.3255-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521220648.3255-1-vsementsov@virtuozzo.com>
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8041b0bc-98b8-4b6c-78a8-08d7fdd349ed
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512C2BD39AD6B6A5389CD7EC1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdG/JnPVHQW4UUWcIQaxrUhwSDhrUX0M8QctRxgRpyiOq8rBmZTaKcwl8TcnmISNOD9ITx+JD6+452UljA3BLi80CUzKTKoJaki2z1c0nOwaF6+loyMqoCx2lYboawePpTmkWTOm9h2CZezLSkXbvxaFUyJXiDR0pvj+ff3aNw5UvcqYXW11/8x3GisePqzfV7GgBjwCaerFy1rng68ZROvLXva77xMDdbU8beI0ndegvYEiRel0kiL78SDpDX36e133a2pCj0eGGUbSWzkmlUVLMA+EXhANHh6BgQeKh56Rd+uy+4pV+O1mkn0pp/x/ePoCOCoM7ukwxb8+D0fozkesUh1JpH4Rzunyku9MnaEdDCDfAfg8AvJZmMH5FlCGKGYvQ3S9VSESNtHjx34+IiV3P2NHzfVf1/7mvzgX4+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aJhV33YihziCHV1sztTE8kEWEELhW4nQiJxg1wRmebOfWDNtKIAeSFDbfFZXs/WEcNDOh7DKPHh9fYpu5xwlp7azvVzv3TnEH4fYjj1CU9GhW1eyYIRQsj1b5YTjl1cckxLSYt+65Ru3z7LfsD6BAI6S5Xf/01Fpep1oKdHNvnRSQ12w8545u8qT2yOWvs8pixyVeBobvgzufM0nU1J6SuM6bqKPRCdZnWelPwboiCGWDosNC8AKGc6qoPsGZMh+unnFSjZHlAC/Mh4AejD/rQ3Zw4eChRusC8GvqTVo2SsToQMd9J3dxYqjWYO5FkxGkjXu4Dmqi2VCMU6B384Yx6MJpS/WSrQnPyo7LvGSgftbSEoZlnoZujpAFqGLyeuiddfnk2XNDYBbToLrr4oaWBUtCwVZ4P+OYx38qhLgQvIGAaVXw4yP4Yb/R10/RINlJ/rCy2Hf/V04pNASsN2VdB3Tv1+G+Tk+yM7yg+NlQ8R96qxDG12TBk7ADdVDwUda
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8041b0bc-98b8-4b6c-78a8-08d7fdd349ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:01.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6mjHuTigG2R0fsDQSmafNVshk8U1e3mAYsnP5RWnGypyE+4Fff0+Spt8LFRgTRi7lPupAqwQinwkmltV0nj8ww8CS6OgtfenMh2ryjKsME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out handling one bs, it is needed for the following commit, which
will handle BlockBackends separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 89 +++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface61..7e93718086 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -268,57 +268,66 @@ static void dirty_bitmap_mig_cleanup(void)
 }
 
 /* Called with iothread lock taken. */
-static int init_dirty_bitmap_migration(void)
+static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 {
-    BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
-    dirty_bitmap_mig_state.bulk_completed = false;
-    dirty_bitmap_mig_state.prev_bs = NULL;
-    dirty_bitmap_mig_state.prev_bitmap = NULL;
-    dirty_bitmap_mig_state.no_bitmaps = false;
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (!bdrv_dirty_bitmap_name(bitmap)) {
+            continue;
+        }
 
-    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        const char *name = bdrv_get_device_or_node_name(bs);
+        if (!bs_name || strcmp(bs_name, "") == 0) {
+            error_report("Found bitmap '%s' in unnamed node %p. It can't "
+                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
+            return -1;
+        }
 
-        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
-            if (!bdrv_dirty_bitmap_name(bitmap)) {
-                continue;
-            }
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
 
-            if (!name || strcmp(name, "") == 0) {
-                error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                             "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-                goto fail;
-            }
+        bdrv_ref(bs);
+        bdrv_dirty_bitmap_set_busy(bitmap, true);
+
+        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms->bs = bs;
+        dbms->node_name = bs_name;
+        dbms->bitmap = bitmap;
+        dbms->total_sectors = bdrv_nb_sectors(bs);
+        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
+            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+        if (bdrv_dirty_bitmap_enabled(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+        }
+        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
+        }
 
-            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT,
-                                        &local_err)) {
-                error_report_err(local_err);
-                goto fail;
-            }
+        QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
+                             dbms, entry);
+    }
 
-            bdrv_ref(bs);
-            bdrv_dirty_bitmap_set_busy(bitmap, true);
-
-            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
-            dbms->bs = bs;
-            dbms->node_name = name;
-            dbms->bitmap = bitmap;
-            dbms->total_sectors = bdrv_nb_sectors(bs);
-            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
-                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
-            if (bdrv_dirty_bitmap_enabled(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
-            }
-            if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
-            }
+    return 0;
+}
+
+/* Called with iothread lock taken. */
+static int init_dirty_bitmap_migration(void)
+{
+    BlockDriverState *bs;
+    DirtyBitmapMigBitmapState *dbms;
+
+    dirty_bitmap_mig_state.bulk_completed = false;
+    dirty_bitmap_mig_state.prev_bs = NULL;
+    dirty_bitmap_mig_state.prev_bitmap = NULL;
+    dirty_bitmap_mig_state.no_bitmaps = false;
 
-            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
-                                 dbms, entry);
+    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
+        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+            goto fail;
         }
     }
 
-- 
2.21.0


