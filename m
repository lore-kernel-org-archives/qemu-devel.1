Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78B42072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tgL73xfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78B42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09G4-00037v-7e
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091s-0002JA-0g; Mon, 27 Jul 2020 15:43:20 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091q-0003fu-Bn; Mon, 27 Jul 2020 15:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDRk6OukzBRY5pJ0MewvXY7gs0dK79Xqf1GPF6s7meiVBSSXebHoXGjC/VcGS/mU6RDsCiV1NG5Cv0wNxydqQE0azMX3T4OP7HNaxbjv6RoQESejPMinn/8ivyxRV+s74vHrnF9Br7xt4JSFnCGDicyXtSpWupZqyWsXuRZC1FqIlG+vMZvFHURW/ErnShCMuWegRI7ba5QQ+VOQG5bKkRF5TiU/oRbr5P0bnQJt3HdDLHD/AqC+shRnvGtch39UwZiZQ7b4acxn/QxNHkJnWub/nRwvvlsyxrSE90GvYAUt+PZssHJkzSwrWsWsZZCyaRH7wQ/H99jjgr+wqU2UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucg/Ovsrzv5kYnL8Nj4xUSnnLkw3TIiil5s/HrmGgQI=;
 b=EzZUDypVvD3qeWUePpBOm58bbfWdAcjtLFXv8wxkO4TPqK79AL26NlLPCIGA4D4hZmOtSiBT3gcgwkLpes8ymA/PAiukNd4U30ZdRjvD4BWOn411503PVAijjwJhTTBKKSvnYt2x55AkXEcPOFxbt/8smDth3QgA+bPHPXtG34XgoxZyh3rZHZmeGhX7LSnDueTnuBVFdJjgEwXJODY1Jvr2HSzR92M8024Fd3XIkwMRHOJEuvwnlidvd/lXUM6PU6OkPJUOceaRf981QPXI5TloKK4Jgjg51bEnwC7IthP9EOoptx6GhurgU2VnomyMO8dI+8XdApFvEi3voauwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucg/Ovsrzv5kYnL8Nj4xUSnnLkw3TIiil5s/HrmGgQI=;
 b=tgL73xfvqX02BHvc9x6JJps6AWT+A7OT9O3zZiB/VCd8yEftyq8rH5gzDFej+1fKMtf9b2V/FPLbtFIBtcSbOYCsAOC9kC/MgaB+fRibBE6m7mdc+7qgeRps0Ov+vuk0QfdNWye3wCDENqpYJT30nqvdgdK1KXhmslYv4CbeIqM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 16/21] migration/block-dirty-bitmap: cancel migration on
 shutdown
Date: Mon, 27 Jul 2020 22:42:31 +0300
Message-Id: <20200727194236.19551-17-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022c3600-9544-4f5d-8532-08d83265481f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610C67A0B343C4690C38730C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yykh9suNWZW+YWv6jCFitrxzPGfASOK4EJnncsHQpH5qQVuAlKu1rvLOvqz5U88LNQRpa4c/HejwPtlUqcdS8e5tpOeeC0MYyWJr9M5zNxytQmfmIic28FKg4GvZ8Zi03aobs6/TIqT2BgtixMiTlCdbK9ZRfPKwbZm/cOyxLZ9QqsOu4DvXLvu+bgN4+i9vIW3Qm7mJOTYUZlfBEx+tmyADMjRfpCjUcS7yfB3Q+zYlqtPmdY+bfj7UKX0ULr8kJrKhP07wvf5p4X/+PtaEQVsqf+XNVdyfWcHSD8Vse0HXO8QfQf3dv1/rt/uhQAcypeLH9mi6KxLrFn/ciAUKPg8riRUJQ6ifx3LnuSWrtVPz+14wQEuqtZcD7OmqtZL1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cH7rg+B+HZSjbZ9J2gQCW94qCD83BrWIhESpy8b+MHnqxjg9tMIe4zeErbBoFaj4m6Khi6HRXYNysnIXzjlBHhV9EPjvtxuI5PLHJmzj9yKYDMT+HyVNGHJQavT7ioP5i8gAISC7h8XIh1H62IrmoYOuHouP5LmG1gMVSdmVC+NJSsPFyGDUzdTIC58z/RV5o6R9/gDr0NjxSNJ2Q/rt/ipcpDIPgwtYAL9HIkJqUoYDFKc+AgkdNCMS+rfq0YeLV268qhYtNKw6Ehe4hkYKaPijSIXqqZ2y3/VjsPDXQUl1dMug1QraUM5MJpbP1Wk17DNx6H9pZ9/QGwloPKVZroEpcmXlfH4O2tqRA907EY/QbHNm07zLZfG+gYZYIlXNAF3X4/XeibsOrptwYTAXy5YbMDt33OFbOhBgZzUMQ4gK/HOxFGOv/BpAXdrYDxG20IK/9Gab6orSRxwuL//r5jU9bDzZzIGE2D8mCLbyPgk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022c3600-9544-4f5d-8532-08d83265481f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:05.7868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aAdceozFGa6jBxpw5Za/JxM/r0mHMaLBlMqvUVfKV/Ms99RmQQ/wy+YLN3XqXKqNNH9chia6AyYrSd+FnOzuAL/UgXilGjtpHqpqFgoDXc=
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
index 4e45e79251..36ca8be392 100644
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


