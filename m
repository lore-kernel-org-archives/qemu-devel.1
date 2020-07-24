Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46850C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB49206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jCuUxHgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB49206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytQ5-0006aO-82
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJS-0002RE-Uy; Fri, 24 Jul 2020 04:44:18 -0400
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:31299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJQ-0008Pz-7M; Fri, 24 Jul 2020 04:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESr9hIF2VZcDS46P11lyb25PlwMcOwx1CBtgBzESH+a0C+9GdvLVe5ieWynkFtUMdTppWvggTLywjhifxLiwsdgVWOl+qydFmaa8frLKg7twmySHX2w+xUq5NyAPatuxioSuZX4BXYGXzhFUjnKKQqkuw4+Yqrt9MO1zMH4I35ESdkvrnA2MYqxqB/13962AZ4XQKE61d/ygEx3RHZG4te8rheAqVcJwYlFaHa6SugLQBzYqp+I7luMXzGtGR10bstxZVXLADfdNIbyNJ7c6DOPYOF9XeTH0ifL+lha84nYg5knIVF789WsyQqk9DVv36EwGqGdZWuDCIAnoVLUnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQd6AHYILgWJYpyBfH8/S8KgLnM4bkE4gk3+hji5yyo=;
 b=lr/ijIFUJMRToH7DVZaBil+bwxzjcLO+SxBCx474su4NjuYlB4jaBgReZVItEy0vJjCM44u9IfqRCngUuyH6HiaBeZxq1V7njZy4xhxUvfIL/5ventrwG54nHci1IjBhc9t6no9VlK3GwlX2Q/bxYbR+Wx0JHaee3u0a0LNCZwGZ3Qa3kuQUhXPGkjV9r6AFs0trgzKAPOlqTKYDwaDt0klhBaR0DnpvweImNXelIjRq/NJlwZORaXATM0ZlUsmuW9GFFy3TubYDBcY7/452i2xSqW64xN6wCcZwJQOPFWm6FVEX97P4Qi3dBmaD4XqxVQ+5YtWXjDcN6nbrSC8MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQd6AHYILgWJYpyBfH8/S8KgLnM4bkE4gk3+hji5yyo=;
 b=jCuUxHgU8BCauP0uk/zCQ+ECXMb0oal8gFaxwIBuqxqeUoakRuxTZJ2TRgGP7qe2cqlucEgkNun5TfU1EukpvSqem51Pb2TJi2DLMdv+hLSqOBh1EEfRXAWEY1TdFeDyzlW0ZQ8TQBjWL9BC2c3Q+73FsjW+AZag9tWum0H6CR0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 17/21] migration/savevm: don't worry if bitmap migration
 postcopy failed
Date: Fri, 24 Jul 2020 11:43:23 +0300
Message-Id: <20200724084327.15665-18-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70d11ea-e5eb-4bba-cea9-08d82fadb528
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534F4EFF79048C9F6C1BBDBC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQl4UxVGkFB0NuPvFDx0Glk4PWSNoDsJgZQhuYBok+CyW7aVilRRUhPJaSKG8J4NKerKksHBworuWgTQ5mVzHPLJvcY+9HAkuC6RPXeJ3jEmzn2R3FOSQmc9ybir3FbrZyyJT7lDIxRAQkbATQYUEiOU6jN1YxSWqF8VMDKzcQP/tGBfUWrHmjaMh2qfUPUyx7oYLuBT5jNaKCsep2vKrxyAnToNGgTFkHoAIxyTyJ8CjLkSrpr7V5qRiMRjr7humw3eX7tVGrRWR/Qc+CLmxDNBEfqlKjWYcmilS6+czLUij3h8GSgd2uRMw0lnvhZ1aBt589X6h8yUpujzUcSyyFbcVDxaddZyH8OEgn3iETYIMkV9QQ5KvI+uS/1Hy6Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sdCtQYY4QvabDEFmVvJMfc7WxaAFHFbxwPHn+qQAo/yPSVjpkDDA7x4AB2w8n98nbntDKrmGLJ4Yu71RDrHgAvNARMYjkulZrFDGisN3rmWx1d/ZZzvn5LowmsEucb5eLfeayz/YdrIewYzoPOcBSgGIyw0xWaSl2Z8qMYTEEw2w/g9FetdeDs4tbVNZ6tg2PvhhfJEaWgyuAYR9r5q91HBtBaW6+3SmFDqO1AxraVqtLSV+JlTue6RFM21HQSeI+V14yBVQhAHCVfMGh83PIuryWWljv42uNEoeVELwVtkcwRU6QUaMzKYcwahpX9BPKxa/McdXpCq7j53g9eEAZ5RbZfgkMGTXeGzgJQzG5wn5t9v5iENOlh8pI1Yjvw10BbHkSCZQgYNb4LxNTBDp04UeqDpk1A9uamodkZTklaTJfU57NOXAMU+tY2uI+HVDwC8SHm0MsHnT9gSeqe8SHFVSogd7k4wV2wm+i7tvSC4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70d11ea-e5eb-4bba-cea9-08d82fadb528
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:58.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tcHpJtUiTsHSuHl1qo4tRMYxJcd+ieGq7yCTjI8HD9Tq6h8IuyCPl4evXM6ZcrPvy4G1cnBZNhVtJyE0pvg+Uz53ov+AjMuVji9NMYzQdc=
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

First, if only bitmaps postcopy enabled (not ram postcopy)
postcopy_pause_incoming crashes on assertion assert(mis->to_src_file).

And anyway, bitmaps postcopy is not prepared to be somehow recovered.
The original idea instead is that if bitmaps postcopy failed, we just
loss some bitmaps, which is not critical. So, on failure we just need
to remove unfinished bitmaps and guest should continue execution on
destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
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


