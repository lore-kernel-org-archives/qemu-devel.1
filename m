Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2312073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N/IO0Rxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2312073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp4W-0001GX-O1
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouZ-00054n-2r; Mon, 01 Jun 2020 14:11:47 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouY-00027N-1n; Mon, 01 Jun 2020 14:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAq0Q7eHysrcDJ3wKjQNPHj2Io8gpsrEN43J1M1w9eOGzJitivucXND/KBECISQaZnSW8Eoe6S3+oaCuVjaDbAw2G9y8SGtXR1QcfMXOZGudqp/QZTLuPw1xmsJ2Ku6D8pkpwSUu42UVsfO23umM7eRiPR0MIub/3zc+6TTZRt6Zc07XY2EO+aIZHHEh3vbswgNtecdFhwsLhMAVvapHbnYS22PVXLCvo98+rdyXWG++GjfprEWrnnFZqLYvANdFBQwQSYC9xe2RqrKBx8q77Q74kNZK+GLOo5hXlpyj18iAKZL7tf1xfx1g+9Rnu7qnlLhX/cZyUsfiKwtWilUR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvM1RkOIAPydDLspA2665/HBjdPiJEGHYHpWD/s5Y+8=;
 b=ACOkJFs3KwWmJ9L/hqTNKhgsEli1m3ARHRavpLe1WwEbiJXdVRVZYMQ9y68oHE4ygyysadJrFJmeMS8eVtU3ZxjoJCHiXD62SoVx/pyH5NlY+xRKfd0b9frwqc7ys7AvEb8yHQcimUpnvrmK/3yawP6Gm5d26YisT/Of0A1gGI45p0zi8pSsWakbNzq7kzAysyGEHEK6Cufqixo43IRKBipxSN8PY8mVAcrjYJbb6ylFcX/9RDmEZGMI3u+uDtNMZG24XG24j2aQ8x/FThRBkUOOfs497GMsmodv8LRK6bRq024DbiyzyHGjmBbvzAYgHvxW3e+Tuj0Ezndly8RIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvM1RkOIAPydDLspA2665/HBjdPiJEGHYHpWD/s5Y+8=;
 b=N/IO0RxxcqRpSoSGvSOy2sg6l/iezPTia4SWekg92OklwLjxV2EwwwGn4mYMkh4CqYJvHBdkrx7xwCJ91hwZrYuIRUru8uVsv22+aT4cmEhltKEPLt4CItxpUeAhNd7EukXR+9hQ1fYVStwRy/xdYkLSz9s7KsNMV5Gwpdj+MDI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 08/20] block/block-copy: add block_copy_cancel
Date: Mon,  1 Jun 2020 21:11:06 +0300
Message-Id: <20200601181118.579-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:37 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b6352d2-3c41-4b6d-b69e-08d806573a2a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531712FA25C47A9129A4D8F2C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zigWdqXs2cPX9seloCEHrCHT4+IOo5O+3S7EssSADD8rBM4rUDjCE/GM6pDSl2h2vp94B2NYVV+BR1vHqQI+VheE9vDSnaqvG8VzNOqdzhJpISbehvnS/+biKxtrnehhwAsuMxRx+XCekgVw/kY1Uz2rXR5oMHh0FbsUm5WTCS8WP1LUET+npcJmAA1aiC5JYuV/zE+COrH3VXEwjAcjDVrqwVF2w5S6p9o4TPg+ddnqJ+06BcwZ6OMCfNEjSzhO/FZhecfUKIEwFtwDif/yaAY/o3zlzKWnSjIubo7GDT1WSsNMtTfEaBzyXmXyUkNM2rosuAJMTpW6LlosRveMY073A/5brvpIb4LKZIZ8RCF8OXVM8yRYo4QLf1+jN96W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eANPC1iiIc0Be+b2wTRpqgsNMvqYK3vvy6TGTOr/nPpt7QKfifBVo9KnkHotCN4TPwpCzB8YNMKxwuXPs4bJwiXxU77jhZ7fbbHs4yvHozc2Q86nWjP2y8SdwwQ3QHi3ULaoV0Ga5RCOzLrlP/1QNBQ5T+M6cCBCq/Cppvtwr7MRDX8nP9T4Ecq0de/WFqM8eLrrZGxvgGI+6JjKB11AtvSFKP1669S3SNADp5gqCd4klkHB9Fcpt0at3ETDgVIuSMWjqD4gFBY8w7frhjKla9vaLqiE5NlNuKae5sDCkHZKtU9I9btH3WuCQ7ZCwMa8cGwmJmh2KhUwUCgxwNv/3z3L0f8JaTGuVjFyEVLabTkFFQOrgQMSNkxzkMJf6Kio0kyjUr/Tu0dYyteRGtFDjtEi0mT0GY6xfRD7zwM9KjFnOdnf7yFvV7CnkV12U9ThSh+CATvXcI0KniAGcafPZHW7lGIJsxItACYOArcQ+xU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6352d2-3c41-4b6d-b69e-08d806573a2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:38.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFe0+cxho6ay5q8m014dTsF9UlgK/+8GyYV4ghoYzIqx6VpsLNjvAvH8/6j1eLSLCit5YpcLqJcixHPEE8Mb7H9hvNKqT4Ia4/URGcEbNDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add function to cancel running async block-copy call. It will be used
in backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  7 +++++++
 block/block-copy.c         | 22 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index d40e691123..370a194d3c 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -67,6 +67,13 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
 void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
                           uint64_t speed);
 
+/*
+ * Cancel running block-copy call.
+ * Cancel leaves block-copy state valid: dirty bits are correct and you may use
+ * cancel + <run block_copy with same parameters> to emulate pause/resume.
+ */
+void block_copy_cancel(BlockCopyCallState *call_state);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 851d9c8aaf..b551feb6c2 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -44,6 +44,8 @@ typedef struct BlockCopyCallState {
     bool failed;
     bool finished;
     QemuCoSleepState *sleep_state;
+    bool cancelled;
+    Coroutine *canceller;
 
     /* OUT parameters */
     bool error_is_read;
@@ -582,7 +584,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes && aio_task_pool_status(aio) == 0) {
+    while (bytes && aio_task_pool_status(aio) == 0 && !call_state->cancelled) {
         BlockCopyTask *task;
         int64_t status_bytes;
 
@@ -693,7 +695,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
     do {
         ret = block_copy_dirty_clusters(call_state);
 
-        if (ret == 0) {
+        if (ret == 0 && !call_state->cancelled) {
             ret = block_copy_wait_one(call_state->s, call_state->offset,
                                       call_state->bytes);
         }
@@ -707,13 +709,18 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
          * 2. We have waited for some intersecting block-copy request
          *    It may have failed and produced new dirty bits.
          */
-    } while (ret > 0);
+    } while (ret > 0 && !call_state->cancelled);
 
     if (call_state->cb) {
         call_state->cb(ret, call_state->error_is_read,
                        call_state->s->progress_opaque);
     }
 
+    if (call_state->canceller) {
+        aio_co_wake(call_state->canceller);
+        call_state->canceller = NULL;
+    }
+
     call_state->finished = true;
 
     return ret;
@@ -772,6 +779,15 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
 
     return call_state;
 }
+
+void block_copy_cancel(BlockCopyCallState *call_state)
+{
+    call_state->cancelled = true;
+    call_state->canceller = qemu_coroutine_self();
+    block_copy_kick(call_state);
+    qemu_coroutine_yield();
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


