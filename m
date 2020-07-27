Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6CBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72412072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SnbxvRaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72412072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Cr-0005cc-68
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091m-000231-B6; Mon, 27 Jul 2020 15:43:14 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091k-0003fa-Gb; Mon, 27 Jul 2020 15:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USY9N8l0IXE2LThMvanYM65ZufypGP9YrFpCGOtWlNfAPNO/aNqqWWhREvFqv8aXuPQ+A4mpBviDXU3EYaXxW8WfBrQVQh5TkhvZutVnfZ8siPFGqBaik30NmvFo57wAYtVdQDvVQ9aLweEZDiKsV2OZgwl+j/LVt5XxT6H1HyAca8HXL19biJ0UsHHBRUUHDf9RBjK5i2DKJ1l/sUuW/3VPZHJBaGfbALwqd5Vl5DccukiUvwxTQqZWAG/Tm5iOB7Z8rA28E566nZE2G8x4AwfjKqOtwIRb+JpxxnrjqoYJ+A9aL29v1qQIs+OBBYdmdaw+BmlnpqbdXzD23tvbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4YZZv8qbkPLWM3lv9XRSUa8O1uA5tHXH1R5oqeY8aw=;
 b=iK2JKVK/lQFLwKH97M0WYVMS1U8TIzfZRpI419LJpopFGhcNmZP/XWXFwAR7ZbSWgpFPxEQdvo8gZuoxkHvEfG1thIjzXQQz/Q90UM7WpHh6alzuXaUq9vGYa8+Dmd6gevCSRzGhFDfSP4B1Xc88bVFmzuRiiQvltaQiTTFNcVQXjek7LBY+hg+rK92kfPl26iWdiqw/dpS3PuM4T83oVQ4C1n8cWZ6+ZcI2ESr5h+uS6Oh+h4ZQBIjd7awOk8OSUlCbEiliZp6ZQQoB+oH/lekU5neXtdwb4sEIKylB2EY+0TzYiOFrfB6JaKwnfJRRfHtLVoixOtVRH4vJTQR+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4YZZv8qbkPLWM3lv9XRSUa8O1uA5tHXH1R5oqeY8aw=;
 b=SnbxvRaMbVWD6h0H0kvlZjRtwJ/FU/uRp5CX4Ag2DLqxfk0XxGtma8HDgPbnRufs9FzgxNBEI5gH9dZHVpXkEgdO4rcRP7KTouejt839n9dDR+QaehwdHwEcwHH/HOumgzwNW3+qlEx7rUytqxDLg7rDTm9k7oTOO4IoFkwExvg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 10/21] migration/block-dirty-bitmap: move mutex init to
 dirty_bitmap_mig_init
Date: Mon, 27 Jul 2020 22:42:25 +0300
Message-Id: <20200727194236.19551-11-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a384a15d-e866-43ff-e6d2-08d832654484
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26101180BB17D64BAD0436B7C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6yof8m6RapnVad6MM0diITQNSOGaGRrOsKuCONIDqiKoM3LYX/GgKbNG4z0yC9ZYMz4y8SP5B+vVJ1CaoXZmD0Q1ETg0LldmnP0HQoZti/qqGxShLrGuhY6d0GqQvBLs4kBc13nRm3x0ZASYxwFLC6zPr8+ObzvSfVj4zhxkr4NpAaoabo2ZtKo3RcrdbvTReBk3f+g5IhO8QfU+9FoxajzVnzj3ocSUMtyLWddqw7OZeTmeN3stxRPsr/0bLruDMiM+FEtBxGauuvivooLZT7xIuTq2dKgeFiSinlJBM8Yc5VDfd+FbaK/cCLfQbR4NTYMWF/iz5/trUh+NuxZE/K39dro1eMwoxR5Ux8WMjyk5ICyMm5qXqGXzrgh+S/H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LOGRGQEN0X+q4EnRFbCtPE41u6/YVUjpRapWw3Jy5ssWJT8l0O40I5XmA5BDmZH8O0q2M6s3ijqG4VnUn1IJapdw2Ooeh72PyrXjDuxg6hL8G00/GXeuwZ2zfQ8C3lFQZPqrPhqCmCYWm43EMWBzQ7fhMjpIJN6LEbFF5c2eJJNsW/vZoeyhRZFq4RUxk3xtINQKv2+ruIDWmZnlhGzJn9JxzB0RLd4oKHMj+BvW/fv6gZx1H9iap1SsEpujZouvod0C08Fe6Pt77pJs26ekr491y5My8g/3/msBasXJTsrpyUVgFtAXLKRLThlg06aW1/jUOX18Pa6ptTa0pvSbye2nZkT36SBJ4jUB8rclAEeZXHxj+RZAbZXvguUhTOHJQYp+uQxhyyZwaRn/Xg5BQ4vyx80bC+199dpChBPtelFcIoNgFeqB1Wyu/05o3yzkI3v+XZnqmaFkXbqLuTaElcKkK4scdmgqHLCHJDqZVHc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a384a15d-e866-43ff-e6d2-08d832654484
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:59.7373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFRu+gA6+0fXS0J/9qcvksz8awQz44FGpvX1SA+Ue2EOIX2ZDfziRxDM7csItfw8jfFi6qbu3JIFxW3zzWiLxsG6/UigY68rZ4QZl/MZ4+s=
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

No reasons to keep two public init functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.h          | 1 -
 migration/block-dirty-bitmap.c | 6 +-----
 migration/migration.c          | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index f617960522..ab20c756f5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -335,7 +335,6 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
-void init_dirty_bitmap_incoming_migration(void);
 void migrate_add_address(SocketAddress *address);
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 01a536d7d3..4b67e4f4fb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -148,11 +148,6 @@ typedef struct LoadBitmapState {
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;
 
-void init_dirty_bitmap_incoming_migration(void)
-{
-    qemu_mutex_init(&finish_lock);
-}
-
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
 {
     uint8_t flags = qemu_get_byte(f);
@@ -801,6 +796,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
+    qemu_mutex_init(&finish_lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
diff --git a/migration/migration.c b/migration/migration.c
index 2ed9923227..1c61428988 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -165,8 +165,6 @@ void migration_object_init(void)
     qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
 
-    init_dirty_bitmap_incoming_migration();
-
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
         exit(1);
-- 
2.21.0


