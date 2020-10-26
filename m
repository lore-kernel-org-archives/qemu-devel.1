Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462F9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B2E22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OCp0LLaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B2E22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Rl-0007qk-Rz
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69N-00080V-Q3; Mon, 26 Oct 2020 13:19:19 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69A-0008NC-3R; Mon, 26 Oct 2020 13:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUHOOoKIehEgyMEioVb+nxn6QpMHbpm/bqLE2JGPpshSaPLP1K5zNp7pGqIyBv9U3WYNPhUK9OJGIEHwRn/7Er1h6Ewiv0m+SSXMoIm9EdFCiScKvTGw+5A97f8BC9rAl+0S8XtdX3s77Vu8EtJOAvlubzu4/xi+wrsO5HrubIcyBymYXdkCPHfGe0Qa/pPbEf6GX4ykVaeRmQA8mBQlNSZVXR+df13LKEREC64ikH21x9WcGeMcBSXQRnirNGuLAAFZBp3/0I9D3PMao2NVNpZoyNF1N9A8HXTkzbGa3lMaPu4OE54MfAKF4YL7uMEtl/yY4+vgnOx7ZMcsp8xACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7blNLfYfmsle4Ppu6DqQyUTOJ5oaBW+g3DdYSYApssA=;
 b=MBYflykjZXU11OI6/5tYEVsY3M/8IxRaCqeWuY3HVbIAQ6ULFEEC4xU6/OEb3VQAayGiQj6ctl30A1YYUEP9f8PUqUrLbKdJsYsRASPukXfAMnUeAjJAH8AVTqkJh/NlDFmheUFDNJ9WYyVDgQys9D3N58j0v7CSO64lh4+q+X0PHm4/i7oVxFpLgLKS+hi5RTKKGy3X5fwYuytPWICawRlRv6yZsBvGE+b9jmXH/FcbnLe9zadMqn1FxO1wu72dE5wk6fP9fOXcbeGGucPGvzoT3R3jLIpqGe60h79Cf0LC+GK9KGjbz8DJaeusT+7jc873Rkb0gGQntbC6ktmoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7blNLfYfmsle4Ppu6DqQyUTOJ5oaBW+g3DdYSYApssA=;
 b=OCp0LLaW7vu3hqlgedJbF+ntSbutLPaE6NatzjujTr3kpzZeBbphb6ERcLybUTr10YT5coM8adP88u8X9krOVEKn4fouFv9LxQtXFeFDvSw2KmYzIb0JChQa2bTDRQmbRRqcc4aZmFh0Iq/IBs7uNXKV5ZiI/aZh9obQRVBJ6LA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 21/25] block/block-copy: drop unused
 block_copy_set_progress_callback()
Date: Mon, 26 Oct 2020 20:18:11 +0300
Message-Id: <20201026171815.13233-22-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e7cc94-b870-4196-c762-08d879d333ae
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032DFB9A01A0E4BB88D0BF5C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:52;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XShwB12DL7JOIJ5F/GPizucIMvTew0bSals62B9ZHhGv0+HwiS37AE21IF6rKd9i7m6yRnVJNImxK8ZTNv/zu5EbxNWsnPh/Ywcw9QINZKKyFrpEqwETUaguaewGxc+31NfqHOXXcqFGuUHTocef/xJkXBNB7f1Rqh9kf1QYG5n3XQ/94r8WEmjz27ArpAlrpq936o0KbrtC5k4IaaAztEqlRZuFoN4Yx9pP+w+4xziZWuSf+fpCDiqmQjHPU+SfRdP80wWkzDp33ChWHnqjDhGlgk6yfmijJZ5yj8bpjsI1KzmxT/dYNSDXZkpIrjIKGE9T6bdA1+5DQZKNwx0U+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pOxxpAiL7t/5mu4ssrHYgwnlaihiJTJSrHY8jyr8c4RASF7mPzDuHXhjKlzGYjgDSPSMKSgdZBD5ZW5Pnr3p26aM5Vs0Hj+bcRB6i8OptPYhnJA3x57YKt0zOojiQaGVS040QMdShbvJyCmKxb7g1ejKeH8TsLycNB4kW7mph2QjDJF0Nczks14sAcjd8gXC5lARn4KFw4b0/s+JzJi0ZhdE3JYYExV97O1QgMrA6vrTAKWi9yRtbVQd5Gvr21hW0UitJjFIj0CkbQkGTq/YvcW2NY2i4CsCDiwB6qSQmXEVsGHBKyjx0UIpimJnPP0SlaXaz80wBVGI5Nb/EAi6mYsUjoUrWIKD2FpIxOtpjqqQxaf2HckJ2EcieeKdA2bBWjP6VD3G40TV98/L+TdOwDF9PRbWBiJfrlMgZtDJiz7/GZPBaPjpHT6LbpNqWlpV9Y7/w+ZC3/PJZcC7kwkxAwzO97Obgejqr6J8vXvFdeXMx0NUKNF4B5JjLf2aNGk3VR6C2SYop/mmyA0DCOFNGOKNylt8uU0qS+PiDjbxdsrK7Fcosg9Gs6D930+d8sQ+RU6skt97bfVSOncvDtXuCQrqfiaPWlSI7yKiJtybZucneRtEwkbAkwYRAUVEUteJBJcHLSQILv30+q55tM+QdQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e7cc94-b870-4196-c762-08d879d333ae
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:48.6441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhk52LXDAxTZTpk3qE74G1E40N0trVZuuuExLo03+9r8Dq5XDV7XrGkv1YBHvqamOtUuUCzCsm6hatq0cwHHdbWygDE9nnBZlo/sG0gHWO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop unused code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  6 ------
 block/block-copy.c         | 15 ---------------
 2 files changed, 21 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 8f5013d0aa..7b77abf70b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -18,7 +18,6 @@
 #include "block/block.h"
 #include "qemu/co-shared-resource.h"
 
-typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*BlockCopyAsyncCallbackFunc)(void *opaque);
 typedef struct BlockCopyState BlockCopyState;
 typedef struct BlockCopyCallState BlockCopyCallState;
@@ -28,11 +27,6 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
-void block_copy_set_progress_callback(
-        BlockCopyState *s,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        void *progress_opaque);
-
 void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
 
 void block_copy_state_free(BlockCopyState *s);
diff --git a/block/block-copy.c b/block/block-copy.c
index 61d82d9a1c..2ea8b28684 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -110,9 +110,6 @@ typedef struct BlockCopyState {
     bool skip_unallocated;
 
     ProgressMeter *progress;
-    /* progress_bytes_callback: called when some copying progress is done. */
-    ProgressBytesCallbackFunc progress_bytes_callback;
-    void *progress_opaque;
 
     SharedResource *mem;
 
@@ -298,15 +295,6 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     return s;
 }
 
-void block_copy_set_progress_callback(
-        BlockCopyState *s,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        void *progress_opaque)
-{
-    s->progress_bytes_callback = progress_bytes_callback;
-    s->progress_opaque = progress_opaque;
-}
-
 void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
 {
     s->progress = pm;
@@ -454,9 +442,6 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
         t->call_state->error_is_read = error_is_read;
     } else {
         progress_work_done(t->s->progress, t->bytes);
-        if (t->s->progress_bytes_callback) {
-            t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
-        }
     }
     co_put_to_shres(t->s->mem, t->bytes);
     block_copy_task_end(t, ret);
-- 
2.21.3


