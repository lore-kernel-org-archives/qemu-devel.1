Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23701C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA05B2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fD94185q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA05B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09BY-00030u-45
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091k-0001yd-My; Mon, 27 Jul 2020 15:43:12 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091i-0003fu-Tq; Mon, 27 Jul 2020 15:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+3CYf/maCBOtinXH8JKwWODUbd3K/FBFec6E6lkXPo65I0VIPBBCz474gIY/zOm4nyGQBdBUiVbq9gGpAU1ZGQIXaDKGW+YwZ5Y/qxloPZuaXoq8tS8rcMQjS+pitBci1zEWUQ979uRPxJHoLhcn4t3p+MXFvcen1ylp2HXFKBKFdNeAEJQnKDzGamnRt4a4ADMG78n75ZlhSAhmdJl1Zodg39JjjcW6hUdkBK5/XWKgTEDkkK6IGqPQwv1QEBWgasQUINoOjoBvGVgTuT9VnAyTrIVLaqjvM95Kpi8IittApIguWil/WciVJ9BHaJHlUnxhj+gWAPXZyBTpkG2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoAXJX19H5DPBudqTwRPImRFql1ccIfcjIodlpzIyyA=;
 b=l6InaKvzojWQq+oL2WabrmZxAapBUl0b0rpUymXn4MEZ8e50r6xn6gn0cRaCRFN6YwYsa1Gh4DUDMd4dn5U2n0Kamv7eOVRJspuvkZ8kbHgrrYVHEaMuUUZ5dm2rlXbngW916sil0+GRFAmZv+cJYOEkJxl24si4uyYOFKTXsFnUepCUfIh+E0Ruqib0gWGz62CEkNqS3jndli+ZXGCIaD2XQgGpQtyDHgnwd0VT9z9IVcC8BW/evHUZKLGqMgOqvV3W5zf9gRHrk+8FfRPqeU599uTRNmvDRf1xCfeRGNWkiUrAo4+vOjmW6zZOm6Q6ibwzvKbeLaTaTe3UyPznLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoAXJX19H5DPBudqTwRPImRFql1ccIfcjIodlpzIyyA=;
 b=fD94185qE5c6TSVm2d85Vpbz6PyELt8lLJQbm4FMPakHbeNlTsZuqIMIy1clyl2QNgk0FkNW5xG7tNutri4j2Vz46/hZnmXN8qAeQukyXNm9lyjt8BIJjcRt2PuTYM8oEpSgu7QACSuzoEFwh17vtRc4FVZQfh80ompospny2MA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 09/21] migration/block-dirty-bitmap: rename
 dirty_bitmap_mig_cleanup
Date: Mon, 27 Jul 2020 22:42:24 +0300
Message-Id: <20200727194236.19551-10-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b61243b1-a46d-4c68-fafe-08d8326543ec
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610096A59E3D32FE6AFF595C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9xQDoTR4DP0LYtF+PRkNpqLmtyJ90C3VA5cpVSWE4eTw/3pmP4BehYal2q9mNxFyIIvrz8YQqNCm3ryXfDuKi6gd1n5W6J6Ze3Qn/SpUeESvVbqFwP0TbYZxDFp9CO9wtNDokIrooZ3UHVXrdmXxj6WHUJEG3raIzqiCICe8uEXPAAFWsqQ2kdt/BzHncFYisRsUrtEBC4vqHURHzr1rwJC9aDMB5aznR/znhaO8wYsfe+5CGS6Sju55NWbiVdFvEf4tZyWGTJyyP1JGu3ebDSPktbd6Oet/gpyfL3d1dIHBoa8+/9uPXu8hEXLaQ1iSQ2ladekIwsRkGtmkchjE61S7XXypsKB0Ht2EGk9gbLGSEIphXXaasmohg/vJ2ms
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EYsCqdpe3pyg3M3GeTgLKhYWC+zeLnVmjiL5NpqIULWDUTponvESUZzJR6qiE/neHl/6ZkJCTrhJqryzkWwsdhmEAtrhTDkx8Xe/1QM+W5ECKqttxKnH3ODOj64YI4BN7F6TSQPzp3fVzP9Do3DMk7pnzgf//JDBlnC/3Iyk96WOiN6xMOSESmKslaK/pKuoyo2bqP9UK1xSI1McJBHvLkWXuYphPiHSzrMz/sQEePvgiD6Xa5Akq9/+05ozuYSxBeK+ylTfjBjGN8Ga6Wzll8qpk1wPJd3utSm+EHD7WHCW9hkMspd+gU3zHhJP1JIET5cIkhMx6hLGcflFlIGzI924XsdTgF3C/Rskvtb8v5LFihx90V6onuT8j3GT/5AL7gAZA5uLzv1orrtUgwbJ2k5QZRGavA66qIBXkUiImlTOnPC+JAzlk7abpaTVvFG+cgdU+lRdkw4PJGpEK7P/2+EVRK/fESYdLMIZ1uXH3uA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61243b1-a46d-4c68-fafe-08d8326543ec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:58.7457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYof2A9Ef4hR+j0YRGTHKk9K65SLcEQ9bAtEJfORV5axqXKZ/oH4UlQ3WoWuKl6ksnUpWrnuUDhl1Q2ag8ObE4TOJdW9FwYtA9AmreMH1V8=
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

Rename dirty_bitmap_mig_cleanup to dirty_bitmap_do_save_cleanup, to
stress that it is on save part.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1d57bff4f6..01a536d7d3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -259,7 +259,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
 }
 
 /* Called with iothread lock taken.  */
-static void dirty_bitmap_mig_cleanup(void)
+static void dirty_bitmap_do_save_cleanup(void)
 {
     SaveBitmapState *dbms;
 
@@ -406,7 +406,7 @@ static int init_dirty_bitmap_migration(void)
 
 fail:
     g_hash_table_destroy(handled_by_blk);
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
 
     return -1;
 }
@@ -445,7 +445,7 @@ static void bulk_phase(QEMUFile *f, bool limit)
 /* for SaveVMHandlers */
 static void dirty_bitmap_save_cleanup(void *opaque)
 {
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
 }
 
 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
@@ -480,7 +480,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 
     trace_dirty_bitmap_save_complete_finish();
 
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
     return 0;
 }
 
-- 
2.21.0


