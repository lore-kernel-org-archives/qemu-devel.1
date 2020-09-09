Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4595920C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UfYwqEVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4595920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Rc-0005bL-9l
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KH-0007Ji-UA; Wed, 09 Sep 2020 15:00:13 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:32002 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KF-0001MM-RE; Wed, 09 Sep 2020 15:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAMtviTRS/J/ZGW+WAx1O2e2Mux3l7FO80eKxZYAOI1knSGAewmXUN4j9G0lH0F+IX/6lFAZ2eZ/zNESLkQtgs/ZJT/1jTcQ+Z74RYqSUwGZDmd3DChYu/iWCi2CWPIb2YHuj2x/Uemgu/X+dQLoN6OYGDvbc3E6GEOuJZb95kvqCyBa9aqMbsjC6KhlFUuEzw2Dvt3zWa6dDgZZY2ZqHBc9SqzOwl2/eXp0BHpMOTbPcf8jxnwqcY9X3wjctTfwKUHGfYhwgHWVGosL4KgsFC/Qm/bR8LWV+l/fjxDCW/AEHLhl70TCuUR4/6cL/0c84HjGCPzUbjW9e4QzPuvZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVW5EJuC5Cwpd12U7WEueYovZVitqSy7SyEYjWfP0+s=;
 b=kpT/e4OTcVyapluNkJS0p3ZUnWTM4YCg8Xvk8IdXB/Kv8ezcUTevURkRIAwcgOCbrwlgdgPtMbZK6b7PyR3ayoJe8gakfHmYZEoyLsKsoKA/25RJ+Yo+mHq0XcuDljN3TyUCdY9zZMIRNXAfeWbIAj0axyprLbXYG9c6x0g+cfmpOZ5UzJZzoUb6/6DL+pXYSokmgilFdZS2TL1kWFFXLG7erDrkvdc/tCm+PnAMpkaY8uwO3v83AUL328ulyiQxgwq/8SZGNzYVcUlyt34wm6nlUzsdAJ6e3+0WqssxqJ7FftJlUI/HVR+tbysz0fjcXEw9DPv6Ks4aFmCuZks0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVW5EJuC5Cwpd12U7WEueYovZVitqSy7SyEYjWfP0+s=;
 b=UfYwqEVB9iLlBmQn/e2zfkeQNcZCKda2wHES260lqrg25LWFBmQGSh87ctmvmKsj/0dGKKo/+K3sqnsuCnEPYMScHu6mSSi51j7IoDwT7uyVlkGAUTQlws3wY+QSehJo70h/LNyTG1pNJv6q02Qu4pL0Jv8Nrnmu11ibTm0YkHw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 08/14] blockjob: return status from block_job_set_speed()
Date: Wed,  9 Sep 2020 21:59:24 +0300
Message-Id: <20200909185930.26524-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:58 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf8e86d3-063c-43c0-22ad-08d854f28cbb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3445A97DD8108E6CB8E51614C1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+6U9LMQ2yCtgz3BN98L28RXizAnpaC+nkFJSwJDZ/x+DW++V1+X7HCJOwXhR+6pJ3bngN29BWjGNsU1eR+/wb6NF7D/l6KaggmmKhvSEepFeYJVge8pCq86JHiodGVgH9ugRyAf1qw/XIfRH80MMJ2BrKDpT6YurPZgUimYVXxkdXrfnBjwTmekZWk1TDNcGYCnCbD/WFdoPidMicDZ1+PbxQaNj2kBPyP6KtedYfN6bof/oDGsbuQLDFAn0BYr93BDMtASFOZGyOtYF93wf/UvAvkqI5oVFqsoOiasgHsTNIYWaUEv5SAvbtZZHRXMLeePN9ksgxvwyKw9Dqe2Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pLhKJHsnyTqQEAdH4CON6ijl1EO9SubtsvvzujCLV6zwP7/n5d6EolzHNsf6nT4NBwbI4Z2Hett1AvzyxQuwg+pw9UlYu9aFL8dWqcNCJDkpk2tOja+mI3Y7rd3Uuz4hosj6sczwJd81seRVaUhjguVz8NFAOV4feCzYKzhxTbzpxFjHedV/zuUKnoNn+tfPCGykNMonWKDj0jOhaVRaw8oN89U5IxDQrXvc7D+itoGrO9vkUbWg7F0g+YcAUuoDau50+PSRbpIgBkJ2PCCW2waZJRxLU3eUsBZDI19dPYZ4ylpLhZUFBZg3zOEBeV0X71erpgiiCFrA/lQbUkTw7uqCx93tq0v0Lini+3/6BPXslvM9ZpMjCJrgY9ulMfiCVRF1UWwkHO52mIVESfWtYVjYisJ4Y6eQAicvd6f+qBf2OTmNEy18hPmS56PFI3xHjoM4Am2Ty1ZPa9au1dhFb0EA03OQK8s/Ko0eNKNfw093+28PhkGHCWMGRoRmf0UvpyhrYsNavP43VcwWPSfO/iyZEbqQUHa4RkziU/+RQQEaSCA7tUw493gJn/QOjp4qs+8rxIC5jDs2jYUhFTF6q9sJwqpyEK1YF+KZ5x+JKmdip7/gLPxxRzbco+5qnylEaHzBrdEwQnMyrdPgJCNWlA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8e86d3-063c-43c0-22ad-08d854f28cbb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:59.4471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efRru4Rq5D0JgEL9YPXqYGCs6pji1KJE6aYEt7PsAy6TciVmbVqSNMcIwhE8Gq2mKRN9cT6fwjaiWjLV+wauCSB5FLJ9BOAzRHr5JUbRIwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:58
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


