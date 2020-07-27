Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1679AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4091206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eq1RJbsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4091206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k097b-0003h5-3I
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091s-0002LA-O2; Mon, 27 Jul 2020 15:43:20 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091q-0003fa-Oj; Mon, 27 Jul 2020 15:43:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K71Q0TF2M4i5UZQXlPbqSpOr2W5uI8xwSmUtsUCv9nzW8Gd3k1BahwgektrwErWZVEsEFq8EXn+0nBoqsaSjas9oWz5IkjpAA9J8QMTfp7z8zbvPavadoEcaF2ExhU6qG72gNcipiVND6A4/JlWY1t5i1ilIMqOTvQ+oTsNth+4j8j3Lg/blyEzCfF2AvSiit32AxCorz/GG2DZppyx42OH7mKZMKWBMQDS3sQJxiiZDoS6WS6cBlbCK+yhqW35KBl9zDzogDTMjfoy9ERhlClSx8q9DA66Rjw4J3Xa0XY/bgtqOKUl4063ytuTHUsgnqo9Gnjku0VBnG2VP6Cyh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6TuuuUMqVCSzAX0eux9HIhxrU1gEp4Ben7RSGWY0Zw=;
 b=enF4AmVdjD2XABwXHqMeGwAme6vA6ZGBhuSMMFznGeq/EDV1PAZAPc/LS2XBhfN/U86PSNO3bol9SK5bWxLGPp+dteX6+FaTTiiD2cb8ZSt3mJxxOCV+sxm29gczhCawy13jBGuXp6d1nUytlGG9nhv/KTh6goSGpN7k4yfkdHA9cv64Wq4ZOC1Ed3VdAnOc3gdR0RP4h5rqvYfOfkVSXzlLUInLiCLLirooHzT3VIo+U2ihQ+R4FTMF0bQ0wTvInL/eHmBi739eipkicZ3goNAQTHzw8FmWgra0IukMmoeAWoKxkhqnFRn7a0S/kf2wHTZIfmJDonMSPkAiIBxYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6TuuuUMqVCSzAX0eux9HIhxrU1gEp4Ben7RSGWY0Zw=;
 b=eq1RJbszrGFf5dH2gLoJxDgFukAgn71FVzQtlAUQBik4sfKFjdvMOt74u4UUVE7hokQYjHl4Dk2gFBtOn+0Ha5ZPsgSmeTmg0pMKyrkxalYLcwL3Yq9QcYQvnImdXn1+cSL+wiwTzZ+hFWg/rdQKy6Z8IYJNtX/MQCkrJ78uUh4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 17/21] migration/savevm: don't worry if bitmap migration
 postcopy failed
Date: Mon, 27 Jul 2020 22:42:32 +0300
Message-Id: <20200727194236.19551-18-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582a4a39-509d-4a79-2051-08d8326548be
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610A68F645DD762325C8F17C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mO0lcCnKk/z/BEGTjPTO8sYeUlEASwKa7rw7H/sHHZSvk2lAGgybGAXhhzE6p52XviqVyPILOHNx0kJDozIPyO5/DBsf0/h4THqEkduyKrJBsRlcv/e5B45yM3JScbjvFvcF32syxvhJ5EtChoRinlXdcg1GkkIF5PGq/LfZehAdKS8Xee4gchkN0YjTYJC8jSO7pH/zd0xaFriwF4Fu/Wsami79cM/c0zR6mwRFU5zqJ0cSlR88cC2t1CWFPyaA7F3foNVfBjhQ7SxKNBN+6Ypea+oPc2IOpp7fBKPX/64yL7K0de/OHFJ26J6e+CYfnauzAPvgp0Jh+E/RK3E3RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Hoi/wb51dhx5eHLvlMl9Nf+Sp3ukxVv2UKsxMnwj4lsgaxbaafhLW4PWntbFEA+QggwYUcWs2v9A2iW4e5KSX1znKPLeFzj1qqtZqsvDK+KieA9hXFkCIfgjWzbJ9WO5EB/5h4LZSr9fpib6f1CEL319tE+2bFXwwmhvBN9VFYqnxNBUtRnXPK40s5kd2p5gFuCoCjv0u195dgEZP8PQ8YLD6YIcZT4928MlGIFSEKE3335wLk64u4TiFIq1wK/HjoGou+6QA5a2FbZ/y7ojpUFBQsire5xPMw11KL+txCjmWxLu+66kHYrQ+9LoS7Kcmma08OqcNTl/qEySQsTzhgihqHwGYhvY4hDEM5j+yZ4gNCTIJNx1CYCwkqR+Z5IfjLr3BX5/+oS2LQSG5E7SdYMGHs3lAV5L3mxFQvkD8wS+M/a8v1o3aW+VJ+ytKNrMf9N3WBjZauhntN0pDKUSGWLdC1PxjQEAmRjL5R/+5c8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582a4a39-509d-4a79-2051-08d8326548be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:06.8372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SQ8uNon3i78STNbHqwVDV5pPXpQqQnZh1hDujIHGUT+DUx1OpABtEdVkxskFdjHxIDGC77aYN4U+AlNGo4QiPEWb0Dn+ZIDPiuB9y06Ok8=
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

First, if only bitmaps postcopy is enabled (and not ram postcopy)
postcopy_pause_incoming crashes on an assertion
assert(mis->to_src_file).

And anyway, bitmaps postcopy is not prepared to be somehow recovered.
The original idea instead is that if bitmaps postcopy failed, we just
lose some bitmaps, which is not critical. So, on failure we just need
to remove unfinished bitmaps and guest should continue execution on
destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 45c9dd9d8a..a843d202b5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1813,6 +1813,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
     int load_res;
+    MigrationState *migr = migrate_get_current();
+
+    object_ref(OBJECT(migr));
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
@@ -1839,11 +1842,24 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
-        error_report("%s: loadvm failed: %d", __func__, load_res);
         qemu_file_set_error(f, load_res);
-        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                       MIGRATION_STATUS_FAILED);
-    } else {
+        dirty_bitmap_mig_cancel_incoming();
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
+        {
+            error_report("%s: loadvm failed during postcopy: %d. All states "
+                         "are migrated except dirty bitmaps. Some dirty "
+                         "bitmaps may be lost, and present migrated dirty "
+                         "bitmaps are correctly migrated and valid.",
+                         __func__, load_res);
+            load_res = 0; /* prevent further exit() */
+        } else {
+            error_report("%s: loadvm failed: %d", __func__, load_res);
+            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                           MIGRATION_STATUS_FAILED);
+        }
+    }
+    if (load_res >= 0) {
         /*
          * This looks good, but it's possible that the device loading in the
          * main thread hasn't finished yet, and so we might not be in 'RUN'
@@ -1879,6 +1895,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
+    object_unref(OBJECT(migr));
+
     return NULL;
 }
 
@@ -2437,6 +2455,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 {
     trace_postcopy_pause_incoming();
 
+    assert(migrate_postcopy_ram());
+
     /* Clear the triggered bit to allow one recovery */
     mis->postcopy_recover_triggered = false;
 
@@ -2521,15 +2541,22 @@ out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);
 
+        /* Cancel bitmaps incoming regardless of recovery */
+        dirty_bitmap_mig_cancel_incoming();
+
         /*
          * If we are during an active postcopy, then we pause instead
          * of bail out to at least keep the VM's dirty data.  Note
          * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
          * during which we're still receiving device states and we
          * still haven't yet started the VM on destination.
+         *
+         * Only RAM postcopy supports recovery. Still, if RAM postcopy is
+         * enabled, canceled bitmaps postcopy will not affect RAM postcopy
+         * recovering.
          */
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            postcopy_pause_incoming(mis)) {
+            migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
             goto retry;
-- 
2.21.0


