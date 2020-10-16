Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F01C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29C220704
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dorP5KAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29C220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTQV-0004Ci-PI
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGN-00038P-I9; Fri, 16 Oct 2020 13:11:31 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGL-0007NG-C0; Fri, 16 Oct 2020 13:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXerHqzZFsFcsfzbT0bchZAGM3MxUROhzY3H3Yb6LI5nLlV9YqMbQ7d3m9cSGDVGkNrAX7JUhWYAvcBllNE8biZALgvS3SixSw5e3NkVWp8WC1Kq9afyE/8ahVlMOhHgkUyS4hI/6t40Z2rAxN//9Ol556NumXoiGoN1qn6h39WoqIfIFBn9EXw7zMa+4edKbnfMJ6Onx5tvgS2QNszVzahPZw45ohbI7ILjugPs9ofA4i8soWT++2me+57gJ8MNfx7Sr1QeYQ0nByLbkYf6xx6HbuhL4mN6jWVmpFrGfEmwRCzuynW+Bc2RKkzmmmUnmuB7dxQejKXM/mPoshq7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEwDkjkRtmkl7nts3LLAr7JFwri8QCM8JsfV2d83GGE=;
 b=N1lvEaI/GHeoiT0t463opLvtRs67bW33lsOMlQFvPKkcAaBaQ5pvM7rxwH7+fvASet4FLHiBTOEndoucq59u3oY3ZnW/suH/LYKWoevezPl7a/pTft+nSG3Vjw+nEJqOeQ0LL7Hn8dm/nHQSXV4G4OYUuWx7JtksKkKzxBAnFobHd5la4vk8FhsSHqdXXucblPkeyU+0jDh6PTBp+zXTwPnz9D0i1+GUWU/k0dXuMugZrfMq5IxnAcTQlJEE74A1LqhyT+gTfib4r3rje1AlaSsMhqAEajasQkYtwEesmIim8BK/YLwgSNW739NOgnGxMLvQXqdqrhWecBVX+LOGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEwDkjkRtmkl7nts3LLAr7JFwri8QCM8JsfV2d83GGE=;
 b=dorP5KAa0ldqZlsHrXVz3xrCZ4/bbXvxMBhDEcJ8742VNXO4hPCyz4vnG94sj8A6/cRQU3HtlYH889aHdQN5pAwP88lHI7aRNEgcDA2VCJ1otwZJsSTDaFD/wFQ7j0iXNUVoH1iOVA7bXEERlGt9i0CGYgyC7ef8eo7ud0cruZk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 07/13] blockjob: return status from block_job_set_speed()
Date: Fri, 16 Oct 2020 20:10:51 +0300
Message-Id: <20201016171057.6182-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff55794-0499-4e1d-ca35-08d871f67f91
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549510FBBF8845DA50C35A0AC1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ragaz7oeTnNqrWTmAHhi/DdZP+nZxQ7My4lnD/7CBVvgCyY7J16iS1367TsW+XHhXK1ROIFy7vX5+/lTd2KTumOEyu+qlFutJEFUZCmHdMjp4yE8tyf6rXBQW4E2nW0Duoyv73jo+NalQPr6bflVGgJIbjFR/EkCYRyVqdRs6QzQJVh1UbbctgfP+Qv9sWJcknozmLaOQ3lNzZwI1Wdy/4sjWixY7pBUlNTZWM/d1StcNVPY37NDla0/lCgfVKphzAo4EfeCUsjQ4s5bTNcUQqvVCe5aYDHGD0H1kd1FP9DbEYkh0nUhXE7YB75YPb1oNGT5Se+UGoqpuE5jMHVL/YzMSbe9Shj7W2ZBFwpfzcBIOYHLmNQfIvoK914StCT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ILqZlwjvjJQr9jo1Fl4SBw1l61AQ3ulbAPCT+ydycANOLOwU8oUp5yiS7uFjc4VhLVZa19WhwaF2lT2VAjupxbIpnh4OI8GWAF1yVDytrbR2LVtnaWXLlCzhy7Njk7jLCJPZmtj5YQwYGHP6pdFhf+f/H0D3ST5z8wsP/W2bDvT/jbrcBxmx1hF5nUqMe5ZfPObBx0xU6On+rDMgoSRpfjjA0ElHDSl4bZUWv6jQOUBTuOUaUuWTx+GJNTmH7f1QsHRvYTnBILi5NzLJ48+L2gjw0NQcFGfG1Imz/HAvff5FAybbosSd4n7A+bjtWm3wJH49MFQaNC/cHW6ny4eqp2SylpRBWrDbbCo3FJcEw9nnoFIOBv3B3APWh4nUC9lnuII6fegv/QNpnh2vdSjqJ4b+eI6VzIS8RTiB2WKARF4HDzKPzobcCg4kPj6yVLEOQZoVlVTEPTA3OD/Ka98egjcEEQa6lBSYPw6bPKZiz2Ph8pwl/tiVWT9FmQKF54t7ZkBYxgcrkdhy3TIwEB+Exgsf8+i6WiJXNAZZmkmVp6pEMu9ycV0do6IywRcQsyeEw1dG+ci/DJ/7NzH2WdVssNgWGDx6H4Y0eCQJP4dTv8SKDUMw6r2evKO6su5Um8zk/Oz94rPsdipJeZEbju4OJQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff55794-0499-4e1d-ca35-08d871f67f91
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:19.0553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ+q+t/KdrOogsCbuS+0xSeL1U+vyIBvbRhxXEXV/MQ1kezjJ95oyAN4lFLTbYnWVfEvKPdGLvxO51WFrfjGUot1g+/zGsdaNoFQv+w7fKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
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
index 98ac8af982..bba96a89ba 100644
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


