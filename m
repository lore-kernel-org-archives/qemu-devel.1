Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301FEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBD72065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RyhmMp7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBD72065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfoz0-0002hy-4j
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouZ-00056f-PG; Mon, 01 Jun 2020 14:11:47 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouY-00026c-QH; Mon, 01 Jun 2020 14:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnCuatbqJJB8fVad7xCQKQ7JHiVIL/DfHCyJ9mcKHn+FA01YkI6kIBbxc2p9qCQjJ4eAoCPCJsrKVcKRjVqY3oJSQVBQTheMqzbHm8omVK1MonT98pjrNfnZitgc+RrXGHFD8cQHiviLodFoKy5Kgcz6UNlpzze3QYE31lJpEqEbrI1PfhMue/0Z9lVcTzVwyBL79CaKEWACbuUeUyffCuBcbGC7lolOc67SxJqtx3hJoNdgFOT0EOfdebtmAzFlVI9Rs2qXzLUGov4REAtZDXWxq78+WDPSqRiJkST/qMSAEd25h3AUrrb4sKYHnKCmao0tmplDbNVed6T3bhUN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znFRNezH6Gtp7Y4DMShKTwpnLuEmwzp2+Pc99rpaJ/g=;
 b=nwNQSbQfpJMOz4pnqZ0gmxq08piyJ9rElAzq86NY7rQFaA4ueEeqCD8wuPEYnLnVjTYMbspTwrWqTHb6S38g7oJiUytXPoLqOXdMDuB+fgHxj3aeeJvQ7wLoo//WB1DA4TpEGZsLg1qyyYfqmK6FHBdhw2mbQlZGlbIAgjaiO9RKtKRYPitWG8xSALR6I8ULlnvyvj/EMOmSWvKQC7WmDAeXBOy5T/Kxhypr/LAvNHeAmNfO9cGZ3KgbylczamJgtJHJE0ZE+AIDIY6S3L8N+5TTXuEc8wD69P5zW4c5rECTLPCAe8ovHZ3hUJa0gM5nWJOHliSYjoxlCSN1Rtk0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znFRNezH6Gtp7Y4DMShKTwpnLuEmwzp2+Pc99rpaJ/g=;
 b=RyhmMp7Y7/R28OaqstmLuFRgHSYWhVtegQSaWsc4LghHbuGVZZ41GK6Nqy3N0bm6jrBNZVK5OwkFNhqdBwvTW1/1M9JJd9s1Hc+S/R43Uw9sMtudIpsehK3IOMh00jn112weZm0sNk8ZvMjPB9NWG2Y18vo5VWVlU4Yo8K7Eers=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/20] blockjob: add set_speed to BlockJobDriver
Date: Mon,  1 Jun 2020 21:11:07 +0300
Message-Id: <20200601181118.579-10-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:38 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01ed54af-27e3-4d86-efa0-08d806573ab0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53170C5F4A305513AC78AAE7C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I9nsrUqyrp8jcJaN4AWnbRxIA0gZWBRnDCTaRsQ3ajk6U181z1U9p1NbfAnD81SnT/ua+tbuc5ryY7MlHfWuNZ1HPP0rGAEW0H0oBDbe9+8yXiEi9hD4qeQffC8vvt1canB0lvG0cDgmr2suRdiPr5LdYDWqH9SzipO3l2AeKyq8FUY0p8F4P76GTU8CI/iljb/pmt/ysLmkAwdPlOzLz4+tm7scsGJLMG6u4qZzxIcDIzUb8rc8Fi9FP6KelNk9NCAYCf4LxxC8zsPwIUqrR8ssqeiHDta4PI+u9XplmvoUg1FfelACkX56iz+HgeJtC+ILJMz+QZpnqgVWQARlL4gcSwjr8WlqyIuyoaC91KHGbj1F5pqH2mQiaZ75/D9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pMDDGYn1Q0LRTh5Rlxk3enp3SVACN0Tpm3Qnifwx0g59XfnSknSCkj10eemPauPE/Vj74AFB3m6n23Dtms1mW1df0vb6XXmNo50bDv9IQ2cAyajkJXaOg/QJF8+uTPMuANs2/k6n9eF4+0xaXs4qHFQ1Vpr8nIeWtq5i66IwFE8HTKE2BWWdlmiI5EYsWkAye1+w+gk/tPJAvoNC+qntczqc59ORmTnnCIh9TWyYdAKWERY+y8H5hUOph4g0fbiskW3qXSMBwK2spuoIyeR7QypDZv410xChkY/y+6uGInWIx/LEc6MIOPeTRq9ef0r8phptBre445JsIFDHMmB1vuJbghaT+Cjw6Bn3854VKD365jc5L0VKLzVdMKygnzOh2xqdqyDrXqNSNTkY5JFUxeWxHfYivxh9GuIy4Boqdh3WwwxxHIGUUU43aVTu4+X6N69EJSDazbzUICaGmt7IM/BBK745GdSNPUDtCvectBU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ed54af-27e3-4d86-efa0-08d806573ab0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:39.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y3zb8noGlsVzFfr+96h3p5lfo2sc9ZCX+yRjefECSiNwlJgvsmXID0EGnD68lqGLNnhmQ1RrUwwhfLKhxl+T78pB902IXI7rFxoN9tpLJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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

We are going to use async block-copy call in backup, so we'll need to
passthrough setting backup speed to block-copy call.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/blockjob_int.h | 2 ++
 blockjob.c                   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e2824a36a8..6633d83da2 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -52,6 +52,8 @@ struct BlockJobDriver {
      * besides job->blk to the new AioContext.
      */
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
+
+    void (*set_speed)(BlockJob *job, int64_t speed);
 };
 
 /**
diff --git a/blockjob.c b/blockjob.c
index 470facfd47..6a0cd392e2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -256,6 +256,7 @@ static bool job_timer_pending(Job *job)
 
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
+    const BlockJobDriver *drv = block_job_driver(job);
     int64_t old_speed = job->speed;
 
     if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp)) {
@@ -270,6 +271,11 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     ratelimit_set_speed(&job->limit, speed, BLOCK_JOB_SLICE_TIME);
 
     job->speed = speed;
+
+    if (drv->set_speed) {
+        drv->set_speed(job, speed);
+    }
+
     if (speed && speed <= old_speed) {
         return;
     }
-- 
2.21.0


