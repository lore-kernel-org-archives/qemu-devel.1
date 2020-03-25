Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8B320663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UmC7M62N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Od-0004Fz-5c
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NK-0002K3-Ku
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NJ-0005Yl-Et
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:18 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NG-0005TM-NR; Wed, 25 Mar 2020 09:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRsUtnjx/oSqCMypxv18yMPXY4Ca7vjJXJck70iJNwF/vMMG0HTLziSi2b0qVPk9w+EUXuPCHnRDvvGeoroVsueSgKlOGiokGql0EIBM6xePZ7TUZzDVqjr4UMiBCIYVz0XyEjjcRXVPU5d2qfP1mdGI/2evB/J1qTkFpmq+WhRiFzX4u4weyzAt7V1KHZxL3gFUQucIQujB/N9nqHJMDhY/h4TKS055QEkmKzxWCJ2s8jID+I1D/5KdUopo8V8qpe6VASBGEIGw4a7x5bnKZEmQLpQZAgJb6dAt+y3rOXRQ245kGv1wASIlcV66+oZEAWzlqna8M839o29T3nMd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElWzpEhKWXMGNJLbAxCKN3Gla546WZjpvdHMAqNJqhA=;
 b=XrNim9LVbFdOXRubRAruOHGzytKeY0q0+cYp3P+ReabmfHZx7H01CpWbvYRbW3UwwfxsvUMfsgbE1ZqWGAD7ZPXto1hvw2yccCD5LfIMf79Ex0rEGGjzohwxE70rGUJNzD28KCcpgx2QvYsrGBMaptw1wNuRi6S+YyFNsGHKywXThOkgIotWN16BdhvTwT/BXtyS4v5FyDnrVnSndwWbABbVWXKcrJ7dVdOEHbGYBaT3KiiMzJLi9wP+Tq4Jqqr8mPuevA0wJZpl6GAaq4m6knH9d76JfubrAp7CgRkFo1F6XNm2fo3BqmnDtLfQSHsfx+7OWEQMh7+UwuiKwXixWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElWzpEhKWXMGNJLbAxCKN3Gla546WZjpvdHMAqNJqhA=;
 b=UmC7M62Nli0jD9KoIG9leUssb6N1Ov9izbUaXLNFw20fk//xp10eb5i3jEf4EmmG5/T48WY4uNunxJBdsDyrzB7v2UHC4vjbJUk81DauvjEGoUf0GZJsoFsJDFcjtRjgBUizfyXxawYE3r1jm7Gw0g1lFsa/SvQMwMmnB4YcOds=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/6] block/block-copy: alloc task on each iteration
Date: Wed, 25 Mar 2020 16:46:35 +0300
Message-ID: <20200325134639.16337-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.35) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 13:47:10 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 863aa387-de84-42f0-5078-08d7d0c30467
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480A7D9BBE3D6B37F437D39C1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+8jmOMnC8EIXtffCt//Zq+MSCVGhJKI2V2UtD0H86hJ2eoJ23HhjzYayvPVC37AErqYgILyX8iKOFpwn9iQgoz+1bgtWbNla5DheO/eb8xOI9HL6aeG8+Zz7rNEVh9sX51X/JDQMkTVbh+1Mm6eNfJSBub0iEk/SocVh9ap6fWp1g5Nem/UsMvYbTPOeig6Fc/sKOKcccC0rBDrFkvlEh55W08qeaM9vTB8IOBpaKYr0Z4O/LH7qxJD2aDBYmwi+mVVs7Sv2pqqfF4jgCHdqAUMK+8hYvX/FZvEMkI9ik8jhYHn2UukNazemY2RyneAqb7y87QBaDJ6yNxvjLAlUc0WuIqEu1g9QNT2pLU3NTra9MpMwqCBpuFSQHdCLZ5uTCwvuS0LwpB2CM3lh7iIa9C9fjip4c4bHSaJY6tkhpHU7lIqhp3qQJz3S0WBt7pg+wpjisSbrCT/e6OUfaoTMscY2Ry04K4Fipq3o2ZeY2UZ/cLcnqmL3CncmeYPnAFm
X-MS-Exchange-AntiSpam-MessageData: 85xKxkc+RnVKnmx4Q2hQgobjcEvNu2no6X/A6kUeF4Jt1GPKiPG6dEOoF+hqIrod3KnBmla/vE+Rmo7hNuutdu+38tahCFX9V0l0NeSg7Eo/nb/tcdL8E9/1EBmwfTIPTzn7bGkMX/QHMFFVi9pQMg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863aa387-de84-42f0-5078-08d7d0c30467
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:10.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1ThkaVTU6BYbnaPGELqOhU7VR4bMkPT7715SGNtHijzcLHgDw3CGuMJ7mCZXZhZXXAQzSJK+NZrvrXTiUaIwd2cKvdIcueOSU/k1n7uyhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use aio-task-pool API, so tasks will be handled in
parallel. We need therefore separate allocated task on each iteration.
Introduce this logic now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 61d1d26991..0daaaa9ba0 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -106,9 +106,11 @@ static bool coroutine_fn block_copy_wait_one(BlockCopy=
State *s, int64_t offset,
 }
=20
 /* Called only on full-dirty region */
-static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
-                                  int64_t offset, int64_t bytes)
+static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             int64_t offset, int64_t bytes=
)
 {
+    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
+
     assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
@@ -118,6 +120,8 @@ static void block_copy_task_begin(BlockCopyState *s, Bl=
ockCopyTask *task,
     task->bytes =3D bytes;
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
+
+    return task;
 }
=20
 /*
@@ -473,7 +477,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
     while (bytes) {
-        BlockCopyTask task;
+        g_autofree BlockCopyTask *task =3D NULL;
         int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -494,14 +498,14 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
             cur_bytes =3D next_zero - offset;
         }
-        block_copy_task_begin(s, &task, offset, cur_bytes);
+        task =3D block_copy_task_create(s, offset, cur_bytes);
=20
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, &task, cur_bytes);
+        block_copy_task_shrink(s, task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, &task, 0);
+            block_copy_task_end(s, task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -517,7 +521,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, &task, ret);
+        block_copy_task_end(s, task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.21.0


