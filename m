Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C37C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E5A2223C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WIDKBQYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E5A2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Hx-0003P1-G5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69I-0007z8-Jp; Mon, 26 Oct 2020 13:19:19 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:44161 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX696-0008QM-Lg; Mon, 26 Oct 2020 13:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHzHYmx6DeyW5/H4kO9jrdHnubLPJA1A9kr5B0iV5L/HbD/wFhFlxVljw65d38l/y1amK9LT0morQ/gD3VeGqye96cjrLKQotnrjiSuy/9MuShr8lcE1KokZ+2i4GjkHSdOsYaOek2I1xcPc3arHQnNgkblymqnsudz06u744UaP9PYzB2iXzNwE2WJaBh50Q+DLQEKTgXoL4mgnmJSHlqePjxmEpcQZC6PBtbPDpnQqOgqrv/ZVMZuC3BcRkuXGS9wtRn/tOWm0vZmhCdAh83cLucyQ7/05lUhtd4GHFvK1BbCVPx8zcseFD4nAf8CetdWOIt+0z1sPhRnIthg7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax5gb4hnoQNUNCadEku9+5X26TJXBk1zvOqc/StrbZQ=;
 b=f4xFxGIMAHi4bERTOM/9DSxZefHdWRSCY7mO/3qFssLhSyYUHbOnQuZVddRiqrgG3UZANpPBkBw18o3yn0CUca9kKVagYQfq/RAE4lREIFpl/4fQIbA+qkDEQyTSDkf76pr9gZlpMkNsESM5qJMiR4cavF5jKswHtlFWMMuz8f0KVgUfFNU19bqmFI8EgsEQ/wc6gIDQPol/1BklU3oQGnPZk1YDBlhob96Bmv1+gS4M7SO6OkabYn7WED7Qq8eiOmZ88rNNCJ6j7VNGy8lcSyYPQqz8jvAPDrInNeF+9abkyf/SkWDGCek0fMTtfKGQEBS1gIxeT/WppgRoYTVyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax5gb4hnoQNUNCadEku9+5X26TJXBk1zvOqc/StrbZQ=;
 b=WIDKBQYpNACWLvZ0PMI+WNuILADl+Cj+FnqM/GrSan1vAsNch/3qYJF8mhLSppdorUxbuQXQoByn6hljTYr9fdTpo1iSAkaaPk6AegEnbZBe25jQM0Q0Q7S0pW8p0xTJkPgxFwgCpLoOs/RTBcPrBHGrhh5ubsdOKxhn2PCPEN0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 20/25] qapi: backup: disable copy_range by default
Date: Mon, 26 Oct 2020 20:18:10 +0300
Message-Id: <20201026171815.13233-21-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c87392-c1ad-4e58-df63-08d879d33327
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032D875175609044B41B01BC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myvEXm4GSMI/qVqEin/Ybf1/mFS9dgTWrLgevdRWJUwtfWM1XDs8SL6iauy+0GjZ0SJbzp62bqqOCEGaJaS71+YUjBhvO6+01gtts9ZSkKtCiazQpnZyX6LKZywU2t6y+higfDzdGFprhQeXSmiCNHWzbkGP9YzJyuJA+w3RTA18AbpRm0rCNRZEejxZPkXu5ru5pmMLw7aPWzpbKchHDJLkbXkBhr6lExJVCownpDzEFk3pfGr7JF4ciR6yitmROnNvaqTpbFSSgaP2xSR0dXK5xwLYes0GJwqm+aVN/EWmd5cqejaFaNo6vrQb0n7Zb6E085QTHQHTHhW3PtaX4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WwlNS7J1sW3/z+V5gy+x/icJwzvpEuRcPDjLHmlVBKWm/cL3hUfD0NPSeMf2xU+dEZ3U3jA4o6DNdyD1Q4yOEKNYCXgbPVGlsxigJrdhoR+EWTKw3qWhv5QS+QhTz304rWmXsPmkB8eUDlZu7fZHOpqUcXXZZYqsbjt2xMHks2kF/RpcFZVFDt4RB8eEVXSAuY9/NC5Hf4U9uaDjwiPmuUa0K6Apdq6BIlUZK5pjNKzHZTnmXFh3OkRKBfZhn8ZaVRJ+KfxF+ouJwizvN9YkA2njMH9VxohGWk1NUQvx+C32z1cbjBbekM6BrOL2xac6KLGtdHeS/WegqPgiqHqmY6jGmjAA/vyxe2iCw3q1tCw8T8/nD8sCHBOg5PGtjxwVbrIK0QpvR1cfztGyG2t5raIwKVMV2Sw76OED1FLGlSQuTdX4ziN92G5hUPuVbZt9rw7QJ2MkXi/Srr5YVo+j/l5Yc0XdCzKsVV85RF354XI0yI3bEiZOYR5XJRuC87fcUd7jIozlYsMqpkSZ0nZH+QhbKyT2QeBEom6l7v5eofzDw2L7QmdqqghGPAF9sVzkmnxbnCqFIGaFsrR4xHSjoWK/qTsqMDCbP0iQbMs3Ah5vB5dlglM0oJizHaOF0kbwSp4GGV5iqMWpUeK8riFIhQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c87392-c1ad-4e58-df63-08d879d33327
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:47.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmG9grveiYS0NCEYVWQhmrPUkKGvOcpNB7XvZEabL1wGLATGUqk5E111SHp96B2KiUqIlM90+M8Ukv2p6CURh31+kJMAc1BlR8ONk1c5Y+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:53
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

Further commit will add a benchmark
(scripts/simplebench/bench-backup.py), which will show that backup
works better with async parallel requests (previous commit) and
disabled copy_range. So, let's disable copy_range by default.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 2 +-
 blockdev.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5a21c24c1d..58eb2bcb86 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1376,7 +1376,7 @@
 # Optional parameters for backup. These parameters don't affect
 # functionality, but may significantly affect performance.
 #
-# @use-copy-range: Use copy offloading. Default true.
+# @use-copy-range: Use copy offloading. Default false.
 #
 # @max-workers: Maximum number of parallel requests for the sustained background
 #               copying process. Doesn't influence copy-before-write operations.
diff --git a/blockdev.c b/blockdev.c
index 0ed390abe0..1ac64d8ee2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2788,7 +2788,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 {
     BlockJob *job = NULL;
     BdrvDirtyBitmap *bmap = NULL;
-    BackupPerf perf = { .use_copy_range = true, .max_workers = 64 };
+    BackupPerf perf = { .max_workers = 64 };
     int job_flags = JOB_DEFAULT;
 
     if (!backup->has_speed) {
-- 
2.21.3


