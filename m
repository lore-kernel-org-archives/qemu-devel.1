Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E44C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C5B20663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UZXBnNin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C5B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Of-0004Kd-BQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NL-0002La-FE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NK-0005Zc-0i
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:19 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NH-0005TM-9E; Wed, 25 Mar 2020 09:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq2Q44O+ENwrsJ81SZe3s7j3jRsHuwSZqRaIl6s+Dzki8fvyc+By1CVNi8s3dqWYubf/vR1RmZcVRnUY//LBzMnMOHQjC5us27PfkmWlTx3+tg4WIKCxqX9dfj0eez2Ne1fRCqB0fDENtIMiFfoyftS+jX5QKraRtGY9NxuFQJtlMqD2jx9cJeaVzXP3+TpXUUSoCqll85tGVdqqpgKhFFBMfBmdafp9XpOrDs1rzxvSw2cpRESD9yRLm/atEU0/DvF3rvxTF4O6ANlEyz0gJwnE10tWfj3+ybMI2r1RbXko+bi//9A9afRSse4Q/ALjT/dsLUKagb1a68jmIM/SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov+R7HzEsBuMNU/1Uslq1UlKTxp8uG0N8e7+vE1QrEI=;
 b=NhGZXAfGJLvmxIWDufd7JTNejF5w4LnxUN1xtFwuobsWfNI0Y0IebCdMujLJF0Apy5jmiuZTRMyiv4R8Lj1sEF90Z0i59utWpUpDQvp4rpE+nFBljDa7rreofOy/Id6RSltiHu8Q3+jkgwOZK6/GhQHGmhKvuisMbEAFDf9j6jYc4bQPDwcDoTRcPZBT6RvNRyATWV5OuT39p91x9tmvx+lx2exbQawk0U9wiJ9Zen28ZDy+rttWcOTROkLppoFVknIkFNIdw+VdYh8E2t0Gz638W1r6bubCyVzj2Q7tlp9VwRSMnT3cgT9UTHPf+Z5u26nmUWG5P5DLKSSucOnIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov+R7HzEsBuMNU/1Uslq1UlKTxp8uG0N8e7+vE1QrEI=;
 b=UZXBnNinXjrWCY0O4WDo8aBlrhkA6LmmKBSTIwWCJbQ+rvcht24/NjvUCnTwoZE+wcdETESlAPKYseiXnz0baUB63a/LRv8Mx/F+nLxPRqKtY9cJ5bB1StLgAxaJDdWDGaFiTu0QI5b4i0uqd8Iy3kKVN8aMslTQyHZX9DmTkqM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/6] block/block-copy: add state pointer to BlockCopyTask
Date: Wed, 25 Mar 2020 16:46:36 +0300
Message-ID: <20200325134639.16337-4-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f85e42fe-7fc5-4c77-fc49-08d7d0c304c3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB548082B8A21EEC05D50632A3C1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
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
X-Microsoft-Antispam-Message-Info: tzxUElNh2Y8MiR80CgNS7UK3c7M7iuNY/i6/HfJcE55PdsL7Cx2dPHsfoAqClkRhlkLh4yYI+OcCBCs6yWeBTE7W3NQ+ISHUKLfP4XqV9tS9mYqrCfyu52FHje+cUskJ5pAQAHXPSPX9sls0//htTecHnxtbb98behA+ty2phF1SfOky6PzsaWm4NV9MzyrG6JY2w8Jc8EStEmp6OnaEyMWgnKdwSbzjYhH0TrzPU219oJA+3hvmWgkPnmxO+e0H3Y/CdqhOZjfvTmz4G2cVrlzW/0EtVBGw9kGAbZ/YjJyUJn1HRuM1H7wqiGHlGJWvVIna6S2dtw8Ap47IWu1tHnjaS7PMo2by4oHizQCjgkp4B15OYfc64vTbSqMclxgrZccnf9Sorn4yQPBml7kHUNTiyC6eC+r7Btxiab1N+eTOCnjnYbZ7J/gFVBCwAX0Mxp+QEuNFZUcx8OlfZNAmsCBfc/VYDRvxCM9lCXFbPlTu+yt9qNx5bXvxdUWT4qeS
X-MS-Exchange-AntiSpam-MessageData: TfHf69bh3+c44YmMxVAqeCVczZRe6ni1DezE6saa1LHvLYFTyoinFLrm0q7EVLG8n2mfRQRo9fUhGNh9EYFYqMI4aMpg+omvdwhcJHCeUkQTBxGen2BZE/6CHkYA+Os0W8q/2kzB4LBcMp6kCOCP1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e42fe-7fc5-4c77-fc49-08d7d0c304c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:11.5199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC3lpXxssbboQPh1l9Scanzxntv0jssm6awN6bArodLD+j8NUUCs764R7UP1bEtFGE9qM2mknJLLFbTqJbZbAaNzyd2GF0yAXL2rKQiKGsw=
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

We are going to use aio-task-pool API, so we'll need state pointer in
BlockCopyTask anyway. Add it now and use where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 0daaaa9ba0..63d8468b27 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,6 +25,7 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
 typedef struct BlockCopyTask {
+    BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyTask) list;
@@ -116,8 +117,11 @@ static BlockCopyTask *block_copy_task_create(BlockCopy=
State *s,
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes +=3D bytes;
=20
-    task->offset =3D offset;
-    task->bytes =3D bytes;
+    *task =3D (BlockCopyTask) {
+        .s =3D s,
+        .offset =3D offset,
+        .bytes =3D bytes,
+    };
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
=20
@@ -131,8 +135,7 @@ static BlockCopyTask *block_copy_task_create(BlockCopyS=
tate *s,
  * wake up all tasks waiting for us (may be some of them are not intersect=
ing
  * with shrunk task)
  */
-static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
-                                                BlockCopyTask *task,
+static void coroutine_fn block_copy_task_shrink(BlockCopyTask *task,
                                                 int64_t new_bytes)
 {
     if (new_bytes =3D=3D task->bytes) {
@@ -141,21 +144,20 @@ static void coroutine_fn block_copy_task_shrink(Block=
CopyState *s,
=20
     assert(new_bytes > 0 && new_bytes < task->bytes);
=20
-    s->in_flight_bytes -=3D task->bytes - new_bytes;
-    bdrv_set_dirty_bitmap(s->copy_bitmap,
+    task->s->in_flight_bytes -=3D task->bytes - new_bytes;
+    bdrv_set_dirty_bitmap(task->s->copy_bitmap,
                           task->offset + new_bytes, task->bytes - new_byte=
s);
-    s->in_flight_bytes -=3D task->bytes - new_bytes;
+    task->s->in_flight_bytes -=3D task->bytes - new_bytes;
=20
     task->bytes =3D new_bytes;
     qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
-static void coroutine_fn block_copy_task_end(BlockCopyState *s,
-                                             BlockCopyTask *task, int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -=3D task->bytes;
+    task->s->in_flight_bytes -=3D task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
+        bdrv_set_dirty_bitmap(task->s->copy_bitmap, task->offset, task->by=
tes);
     }
     QLIST_REMOVE(task, list);
     qemu_co_queue_restart_all(&task->wait_queue);
@@ -503,9 +505,9 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, task, cur_bytes);
+        block_copy_task_shrink(task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, task, 0);
+            block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -521,7 +523,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, task, ret);
+        block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.21.0


