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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77330C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AE2206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BspSyHKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AE2206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytQS-0007d7-Ew
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJP-0002Hw-Kk; Fri, 24 Jul 2020 04:44:15 -0400
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:31299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJN-0008Pz-Nw; Fri, 24 Jul 2020 04:44:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icvG1tmNUvujPACCgSk+y4sk/PIiy8xnp+K8Y+FCPCKuipve5i50sNaiqG+eiVkEuv7Ix5rUSiwy8/8urWAfOB7oZ9OOSvtmDK8N7vl08yfMHInUwOJSKcvw2xI9QbsWH2cgBuKPjWX/QotHfU0Tc93s6E1lHv7bL39CN90gdnu1sBcRyn1TvGNmGCasq9ZnE/mGX5TZlJEsC35dgRWc8LGwoaWjUhdt6iltb1Jr5+j2TUIGjhqSel+rQF8568U7XbJPuN+DXVeeNbMPRGB5s3ls7NeL52yQVJztBrqhH95g+cktxoaUWTYWEz7I0mjQBzxnf5dhxKQLej5bpnzc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynjU9Knm6e8nCCTu2gLbW8zmWyoAo4WpTYKHgfHY5oY=;
 b=MI4GPgDhYCyajlzzYDbca1RjWpqS+UTiZzEZAwbNJLKyL0+q7uu0PPi5MHjUT+Et733kCNR4XP/xdJ8NCWCuWwUR15j7h5DCqQfDUrR7OQ0wpQy86XTTPX8WBi9wMqK8kC/Pg11xZ167Y4FYOZJNBJ2Q4+ZKO1w8YhZiK/T5CTpnCJooJt50TZeEA3KNDWpZsGow14waslZXaoqbeVXoGdCIT17B48DE39/sSD3JsBn9+sdL6m67AjBuaJQlVq/HBYO7uGfG+Zod7TuEcUIfw37FTnAAFsl1DCP5NlTHq0v6hwc2Qu/J/Y+rQ0kfcgx5QIvLiV5efcT9lxQmRWlCEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynjU9Knm6e8nCCTu2gLbW8zmWyoAo4WpTYKHgfHY5oY=;
 b=BspSyHKPcUduPQFTi/ArCLLrnB6X9SEqnCdxmDiUrnbC90jIhW8jr2eP8s4TNOelN8jkW9Q5v9ldYstf/dyqMo/dUNtWfw0cLjyqqEKByzcje3AP79CWCPP0jPGiO64pPnhezauKGPJv+7kDorN3M/WD6r5YlekOQWKioGadNaA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/21] migration/block-dirty-bitmap: cancel migration on
 shutdown
Date: Fri, 24 Jul 2020 11:43:22 +0300
Message-Id: <20200724084327.15665-17-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1499da8b-ea96-4b2d-e9ec-08d82fadb49a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534B1FE7A7379A1856C6542C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0muT/Ue4toBs8z0yILfNHjbvJTBdeH1oE8T/vED4nZtSLi//siJHFNEkLQkEqtYACeYGDqGAFj3N+RKvBPgWRsc5dpmfdo4ZWEQ/y3Corb5CDn+M2i9hDNGck/WA4RNpw/BE4xtfrpm1qpTTdn7LSCsEFpCMcZztdlH9uuF/hfGrbswueLIIhBnsnko+mT1qLukDetpS/PmCnP/TmLNJw7HcjN5hhiF3Pv5DdsEvj0lLrUfVV5bWibkprPLoH3p4LLtGjiQgWKfgtxy2F+1bf8Ol0XBakz2Wh4TwdwjWyRfhLtvoqnE6ghAIFKbF/cg8z9r7AU31lTNoF+nmNj5XunXc5mxjJEJTsL+276lTe8puyWuq3OwIcLv7Tv2AqvxtKIfgxJy7zgNA+5dEzvwu26M7zxKcfSQacQLv9W+o1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JjZ4Ogr+j8rPDPJgP7Fg4EGXXL9HS7gzPPP949XNmcw5VaSBpdTvxPYN/EE6XwntiK0nqhc7IZeUpF+YuSDPNGosFEUtjODaXeLYI4jDsKDwj++2/4CSHhpvP/5UlYronx/eAws2QzEOC223eCMlRQlME9EtAXKCcNKJV7QV/iqNHnrw5D+f0/tq+wPKRzV/pWZfcA8Pko9cPZLdNabm0gZcdEmvxj6VinPoshn9u2Ll5NVeDe3UbQsXAQyvDBbD0GE3b3GAK+juS8WaUky6MAlajCkW7MLqs4m7nZQGp/OO0Y9vOeAPmKPHvHFY89moTjCm7Rx0H9lFXpF/AwhCcamMp9QbMI3vPn6HjI+L5GlMO2buqpm8w1Za30owwicfVY+qPvEtrTxAMDsKJJeHwmEy8ATaIiYrhCSq5J+bmSgFtTjaYnCGiHejT9+I/nUSLWJp8VgZUcCpCyB6MgG1INN0TmpbgsK0c2HMt318IHw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1499da8b-ea96-4b2d-e9ec-08d82fadb49a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:58.0048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thIm5lKWMs2mpUH45vfiIqCW/WjWhguJFVAQaP3dip20j2xgG97ClYvjMy3h219/ZCUhl055bXNTOQ62QCsSwV24BQPn9tyUFhulkJxpYvc=
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

If target is turned off prior to postcopy finished, target crashes
because busy bitmaps are found at shutdown.
Canceling incoming migration helps, as it removes all unfinished (and
therefore busy) bitmaps.

Similarly on source we crash in bdrv_close_all which asserts that all
bdrv states are removed, because bdrv states involved into dirty bitmap
migration are referenced by it. So, we need to cancel outgoing
migration as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/migration.h          |  2 ++
 migration/block-dirty-bitmap.c | 16 ++++++++++++++++
 migration/migration.c          | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index ab20c756f5..6c6a931d0d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -335,6 +335,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
+void dirty_bitmap_mig_cancel_outgoing(void);
+void dirty_bitmap_mig_cancel_incoming(void);
 void migrate_add_address(SocketAddress *address);
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index c24d4614bf..a198ec7278 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -657,6 +657,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
     s->bitmaps = NULL;
 }
 
+void dirty_bitmap_mig_cancel_outgoing(void)
+{
+    dirty_bitmap_do_save_cleanup(&dbm_state.save);
+}
+
+void dirty_bitmap_mig_cancel_incoming(void)
+{
+    DBMLoadState *s = &dbm_state.load;
+
+    qemu_mutex_lock(&s->lock);
+
+    cancel_incoming_locked(s);
+
+    qemu_mutex_unlock(&s->lock);
+}
+
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
diff --git a/migration/migration.c b/migration/migration.c
index 1c61428988..8fe36339db 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -188,6 +188,19 @@ void migration_shutdown(void)
      */
     migrate_fd_cancel(current_migration);
     object_unref(OBJECT(current_migration));
+
+    /*
+     * Cancel outgoing migration of dirty bitmaps. It should
+     * at least unref used block nodes.
+     */
+    dirty_bitmap_mig_cancel_outgoing();
+
+    /*
+     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
+     * are non-critical data, and their loss never considered as
+     * something serious.
+     */
+    dirty_bitmap_mig_cancel_incoming();
 }
 
 /* For outgoing */
-- 
2.21.0


