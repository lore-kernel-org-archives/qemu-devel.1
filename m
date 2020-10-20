Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BA6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7D622265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kSmwtK8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7D622265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrNd-0007Ce-Ko
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIt-0001bj-Hy; Tue, 20 Oct 2020 09:03:51 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:56643 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIn-0005bG-CY; Tue, 20 Oct 2020 09:03:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clr0JFVisK6GPgxAu7BbeLz0p9cTF4ZDY91IFsTGdnV8v9LC7GegUUlyGV8gPAvvWg+LjBhRQirY1e/sOZya4J38QKt/pwsZbS2/5R3A5Z0dMONw6aDXHLK585h7ZTcWhX6Fgesen/OdJHFDj+D9kIfNTkViMFesDuf+5AZSZA4/C4idXDz0zGGQlTN5wGIMWnnQebLS0987CJPEX59NECmLPnm3a2vy9Yuy4T9wL6MRVe4akQUjo5LRqhcPC36OKE58S+ActbxukWy+wpNKGCqZCV+gi0RGGEbWGR7bGxbD+0RlVA0LVlwGCWrEk6I/Mx32zD4SldfB3f6QaOsC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEwDkjkRtmkl7nts3LLAr7JFwri8QCM8JsfV2d83GGE=;
 b=loZtqlNwQgEV1nssapNEAn524bQxbCTifN6BGZPqaJ29MzpbC/Hj6X/k05lDG+xkq6r/F9wiT7BIHfQRzHeBSHxAJ9Bq0bdWONG+234tX2jXV/kNML1j9Q6gegyLGWZim8MLvzzF8GGU937NC6hKNyXHiRo4p4JHz6Q2eZn/YYGUeVtjttLji1Ado7K4evZ+cas8zfo+FkRaLynXP1H7H+cxrzdC6zwh4Fa1p7Ohi/jldAIcfXHrcGYTgFOOsIkehh9XmtLiiqXBChOjHdkO5yCoCi+Qorwe3YEteQz9of7KvZS5cqX3DGBkCTsH30nv+Hc2eGTsdrV6JFameXlOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEwDkjkRtmkl7nts3LLAr7JFwri8QCM8JsfV2d83GGE=;
 b=kSmwtK8fWISemO5t5NiCMNY9Da8eYRxkZXx91ZCuPl3ob08HrLcXqCNaHBUIY9tGJjCVhn3lCdCJscALLjbrgNHKdhgq4zny/QpQmCXI/H0qAfLYDlcaI+yeDCS1dreUygql3DDDM+9xrko1fVmDhnvfmmpT7fYqVd8TMonfFlY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 07/14] blockjob: return status from block_job_set_speed()
Date: Tue, 20 Oct 2020 16:03:04 +0300
Message-Id: <20201020130311.14311-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c2eb3c-dae5-44d0-65cf-08d874f88c4e
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168025B9C7E62688563A6A3C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgYA+vLwmOmXjKD5syNdi8eGCmmmS8EylCMYN+vaZ8gCsyUZbFqfo2lacLLKWDHWe8yC6jtpUgN3NoPBqM9hpZAGLAz9yVHvbeR8jQ282KpP7MaWBnNXgxJrv+oVuRHi9cU5YsF3oHYW1tqtYjL0Z+ziiBKt5sY3PoAkUvUoSGvooeW/Lj7NmhDVQGeK1w2v/ai79kv0FpqpVBQr2wapCfiyWhFlO+E1+F4K0hOvmvDx3f8i7EZwEhoFmamNplwjBSojjLxWYolk6OFZZgGy+ayNB5KOyTMaT7XOyZQ4Hl8MhDXXITtwdD8XroriBnxHz19zrKZYFLr1dlUj+IR2mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: N4VFYzWKy4SkY+SoKvm+TLqHnzWKwGGAdo5+Z3tFMZEFcpzP3adfQJ8o1nivV6id4xfOTvbtfi2TKo7TNyeD7cA00q4bu4zJDjNQ0uOy7W3i2xpIJe4wpNZCm0nXQMFaf+k/Vo/Dswtqf2lC7xYgLuAKbJBNz//sTMJf1Po7O1JV81lk3dmqvjP9bRu5yhWdK5uWcJymD9T5xJ7x3+wHn/+V+8uDSXRtcOjIF3Y5nySZrnvnwFljxCDjE5V5bBP//r8jt+oCmzshppK9JFzQOx8CP8izIXi3mZDBhq9CT+MFnFKadNtZfM5Z5XjAIXqxwSdG6YMv6+7LXet5DcAGPPgjjG51Aj/Rr5RH74CEtPAfCnEGj566e2G7VmVjD483/z3Yg2VGDhDrAEqkxaILS9L9qzvvhg2WjWVBeTY7gb//q79LBpt4dZAJdo2AmeNmA33yhLeu6Q4SmGmlKxGQHXDPvBb9AZ7jTjjiHFJM62jgNAvZ1k4F/IbwQJda3WczhQqcx0BjRpLN3s+8bh4kD66HBlU2RvwdjK41MKCC+NP7jBHJeJA1X+gWK9FrTYhawlHXTwJ8G4pWrdnIvIHPyYpMrSEcWJHFqbeWMuaVPOr4SVr6nOJfgx5BujCDKvpwyubaRUnzAYPD7xYBHsBkMA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c2eb3c-dae5-44d0-65cf-08d874f88c4e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:32.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0goVqs2ewpjBqf5/kwnUT8KgfKMamrNwRCMAC6KEd7oOVl4YTmDWdmrg7TE29N6sd2URd6y8KfW5k22CVg68GSzO6gh8Qrhs8Pb3d9pob0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.7.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:42
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


