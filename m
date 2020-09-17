Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9FC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E20206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I5WEodxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E20206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ035-0005Mu-PA
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00g-0002t4-Hz; Thu, 17 Sep 2020 15:56:02 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:28615 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00Z-0005s0-JA; Thu, 17 Sep 2020 15:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icDs3AmfU/jGuUDpZNQoGj9cBFQNe94/ZZI2IJcdoyxvW1vcFm7MdMZyKqy98sGteeJOXq4xijaAwmJaADaLS5znfuwhdgk0M/oxk6Z6J0sxGz4Nfw8h7CCj9Uk5bcsRKZG61uT5cBpwZMeCZztU4ZIUQPdDxcvmUCwxyYpYngzV4AMauI7snfh2bq99Tp+StWZiltjwrAywCsvnN3cxTd1Hqnf1wEFd0bINkd9rs/bCO+ZfnIxJw6pLae7duY0BLkH2HaBaQWgoBgkEUnyJ2TGcmdKgpoEjgd1dmMnvRmoqzz7WgJuSoqq2QTsuA8WTK+BkbXNN0AUxibvWLxyEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAwAjiQVUm3xU700PhqcZagEGRihHemRUG8ZBQaQTMM=;
 b=M6qsqmmEoCVs48bcHDRV/ORghv4TBuZUBDgL96NRiiVX7A/7Mc3VNjvp+gBLXgT0yZtKO0Tjk650sKocs35BDZbq2iuxDOppqViJK5Mn+NgVTSGIaDa89u0dTCFWaiEfMF5pwepwi9XiXfVeXakqVr9sHG7ZkPQdMZi3jhMt9bsZYYtFRrvE/k9P0FXk5S06vTvyQN9rTIRRz0hOTYFWD60Ws7nlgqvvS9UPXAP+CnAWAAkN3vgB7NegXA3SHlKRS7f2wI77Pn6Y68a396+ZR1yahk/ZtD2PfJjFzWyTEiipskR2lQTIBEYWudFS0/P/2mZexf8REaB4pfYjNVC6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAwAjiQVUm3xU700PhqcZagEGRihHemRUG8ZBQaQTMM=;
 b=I5WEodxhx8IMMq8dCmYpeyk7vbBixdJkbu2XnTA6vkH2YHtdtHVJAINWt6ZNsOGY9W9uhI8YeQLeS+ZRjDnlWCY59HOqtgQUq0S9UYB+W0CosiNGvkPgAQafq24P0lAgki1KRms8txfTxhq+Ui7L8qLZ4MqVCY50k4IlnUgnNFc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 07/13] blockjob: return status from block_job_set_speed()
Date: Thu, 17 Sep 2020 22:55:13 +0300
Message-Id: <20200917195519.19589-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:41 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2adffbd5-85b8-47b9-d168-08d85b43a861
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303254A2ADF70C41AF1C5199C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6R34owuwBY3Ku4nStkzUtM4FRDEri5RjETEJ/6ZoaoBc3jy6ooPNpUPmuC5nOYfbsn5KYnH3Cj5HNTnZ/jIKQek8XZQRRaxfxon+9i/LPHF2Ii2b1648S+OinS0Tum6qp0ynodvIf9gwyY+5nkyUFQVm6Du6Km5FWLe/B+ZV0RNuxAQQ1F/ghui9ZwQgpGx92XJj0yx4UUBn+nejwC3s72oncdHzD2uTw7Po/qOtu4vPopje/BLnYbqBdNh+1lCdDm9kyiaL77G0gzhQJL2rzBRu7pQiHg+2Q4iTrXXpLCype1Y/klBrpW8UOwIC8T5o4FsJoIo0u3szbSzBBzedg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nsp8uJIYkoJZ/cylw6uOHTStWxMkFwu05Hx0Pl5M18hWj/15E9yWHh7R+z7r4EyuApevrXH5ula4XTjJNcHId2XNoQKPqBWLxsyk6k9kFo7nEWWffMU0teyQNFuvdN1P7MnVmQudKPukPNTEkv0I7lqL1S7WOs3foEU0z64m4E3hEj0g8nlT5YAOhu6x/a1MDVv/T9VkpwH5651q+mGKaj/Rx5mJFsx3zu7K8jCj/YiO/QAjwgtmCrdQvHnKVdWFR0i3yLb0VtKqC/FfrGOsdCow0lSfb/SgPCzmwlxtzhrChvkQgK5Rb4nYhE/0IwRzpdT4srCQ7YlfqGGlwKJiSLXRfdgs8C4GsUDz+QFZNdvnifTZ4Goh9AJScG2LSnmE3pD8ryKeF1WTD3OLkUVGcJq1Drds/zOVRLTNf0Mn+haL30JLqQT1p0TDnuOibdp7XPOxMBfpxE6IO8U/erJIHLMmDz8/9be797DQUX23FsZ3vhpIeQGOGtdAm21BQ/OTVu5V0iptzyjjpodwhQ0DeVtKVMGMJkmxMd61Qv8r6qBh0vPNZPUiMms4iYTxTJQqywdbBYLHV37Hz1c8jeNH3ONMvTvplmfP2HRLPnH1TTOmXRxJO4PRaS2iayTsjo9iSu/y+oA4O1LmoG5ERKq6XQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adffbd5-85b8-47b9-d168-08d85b43a861
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:42.0347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RGIrpohbrvgCNOHPzBmLv0BmLl6f6NthDFgi/QO+SDV4Ap7v8ClWmPRXZyfjqsqGM/SKKwWwgF4qjUtgFsIpwvCcnvbGcAHyPXgEX811Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Better to return status together with setting errp. It allows to avoid
error propagation in the caller.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/blockjob.h |  2 +-
 blockjob.c               | 18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 35faa3aa26..d200f33c10 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -139,7 +139,7 @@ bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
  * Set a rate-limiting parameter for the job; the actual meaning may
  * vary depending on the job type.
  */
-void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
+bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
 
 /**
  * block_job_query:
diff --git a/blockjob.c b/blockjob.c
index 470facfd47..afddf7a1fb 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -254,28 +254,30 @@ static bool job_timer_pending(Job *job)
     return timer_pending(&job->sleep_timer);
 }
 
-void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
+bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     int64_t old_speed = job->speed;
 
-    if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp)) {
-        return;
+    if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp) < 0) {
+        return false;
     }
     if (speed < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
                    "a non-negative value");
-        return;
+        return false;
     }
 
     ratelimit_set_speed(&job->limit, speed, BLOCK_JOB_SLICE_TIME);
 
     job->speed = speed;
     if (speed && speed <= old_speed) {
-        return;
+        return true;
     }
 
     /* kick only if a timer is pending */
     job_enter_cond(&job->job, job_timer_pending);
+
+    return true;
 }
 
 int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
@@ -448,12 +450,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
     /* Only set speed when necessary to avoid NotSupported error */
     if (speed != 0) {
-        Error *local_err = NULL;
-
-        block_job_set_speed(job, speed, &local_err);
-        if (local_err) {
+        if (!block_job_set_speed(job, speed, errp)) {
             job_early_fail(&job->job);
-            error_propagate(errp, local_err);
             return NULL;
         }
     }
-- 
2.21.3


