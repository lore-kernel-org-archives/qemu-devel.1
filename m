Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892A82072D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wUaoopI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892A82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6fP-0005iZ-Js
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX695-0007vl-SB; Mon, 26 Oct 2020 13:18:59 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:44161 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX694-0008QM-7D; Mon, 26 Oct 2020 13:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUjBxTAT5HeNYt/UsB2kBgmX7mlQv0T9NCnG1kXJknriHJUabuS5e5sQX2x9jw7cJPpEygmYcIJwLfusnNbPDPzD2jH/I9evfec30JQIDK8ApbUg4VMn0Bn5V7uoKkut7RlZXWxu+lThecFDN5BBpLcNexGVDjfrlUJ9J8K1ia21xZkNxgXVK2j/qNeeRIRE4zA0LIshHfqXFbS2LYKiUzh7dJI/7TErY4Bnqta6ro8+yD+sp38i5+rky5EK+BM9eoJOvmZtFACR2jGiIiXfGDCYuj6VPJIp8M55Su1xaS/ZVWFHoj6UQsBnALDQJZMVXKGh2dBzd+GDaX7TQ1vPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrLj5bDWnH24UiJtSpC15ErMgQPVauwci30aWo3RncQ=;
 b=Ze2AEA0aQ6NsHfdXWketvtGA8mGeefriTYlinQGUNBQt80sQoR2wMI1pcTqUqOmsJ1oqfvYxLn0N2q6VWemS8GEBiczQdyFZHlGEJ1RLKCG4GzkXZfnExRgV87FTy+e3MTZTw3NcxFRMW2+XNh/td0CaA0RVulITeCobfdtsZXDcSWhej5dStiIYFSJsFiZmqSaqhPYBFL/+QiCsexlQxR6D/QVl27n4uR7OOJiMKV8W0uMINvRQ0e2tUChKqUZLovJZ1bqD4sASvDtcSPxw6gPOtAv0JPPfAv47JpFJKXCIHDlCW/hdqFm2hSMhoYEHaiMPFmjFwAiEZCEk04BUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrLj5bDWnH24UiJtSpC15ErMgQPVauwci30aWo3RncQ=;
 b=wUaoopI0ptDW+EmGq+ljx4tkX9mYKZWxM0Lstc+ep07TzHm7+dIqo57uU3k8uIKCXwNAYS5b85ytR0GqQPwb+hXdR3ZmSLwa/4qRQvBX8jr4R0+HqqE4vJUEbVVQYgCJNA+2ZFd49SL46SOl+SGi5cIPJ6IeJgBV+h/igdUeW9g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 18/25] block/backup: drop extra gotos from backup_run()
Date: Mon, 26 Oct 2020 20:18:08 +0300
Message-Id: <20201026171815.13233-19-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 105f281f-95c2-480e-d4c9-08d879d33213
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032B4FBC5AF17A5EBC3E88DC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B08tSOWqZLlKV9fnV/8sq+UmLJgHqt6QxUfczkkAAwHHX/F8EwhZXI+NmI0XzmdK+4n7Tu01AVxiaIadNu6CraLk2wUrcXBjPErz7ENMUzSbBFWr6VkZcIT94phUk0I+8an92B8zk863HGSjzLgPD74dflFAWLu1uCYvgn3MXhz3f6wrqrVU3XFLGvKjbOg81YoGB5LOfv4kikV5CVavO1Fp7oluXVEOH+GO6QwF3dSzzUAgXbF8a0wqnQzorgzVGR/jn2YJ8lQsxlQYmvdq2ccCh2UuMzDQJZChtkPQtZOfY3JPY1im5WWxfL8VBARuxUKFX6jRu1Lb/loKzloRAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vUVL3erhDXnYW9rg3sDawnqiRgo5QvsivZMgNJ35mspPt6+rRGtMhk9SysJlhjFNQ7p69esQcWFoxjJ/2H8cLwU6RKG2G+SLLbeEomAtqjclvd9yUddY70UUn0QzXPGF9uAdK0UFGBDJTGGBc6INo8nK7/S5E08WOpdM8yMoNHVKJPN1nonaMF+ZJZXSPIJ2aQBfs7qqWL/cJazWERpMJHtC+xeBf2aKshj3bD/vSeSFeNY9nK/ir2l0Lj4xv9BJNriY/syLmmAlh02ik2Y0vt7p2HAIwIqHL1HK/L38jWiQjtMQg7J17l3xMzThWDqGCGeosBTCtuIGI/dTj/aYBbu9gQyTwYN489pmXFDNUQ7cBtj6HBp7vhihytWBz2oeUHxb/ZNnU2rZZaUBK9mpRcs54CGrPtZr3psih60N6AfRzDR33A2ZNzQR0QWSIr4aTHHSRjhTWCLwjk82wGd6WN/ox85fHyUARnmVyxerMzI5KN3ARPuEvdwALKdkU9TTpvLDalYB2D+mzJypnjUJfbkQdKlhAoW7j/hl6+h40b5ItjjfTKKiXOY21QdlbgwboYv8Fj6D63cnyqAFmEdvpI3P1xdyiw6afAM8cdGvfNmrIgtQCT4+V6iEbm5pFywbyM9QTDIqvYqpBnFTV3zSHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105f281f-95c2-480e-d4c9-08d879d33213
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:45.9589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgl2kHkgvozQzNTDbi0yRKSjPURYo4GI52inwp/cto4y3XVmj4DA/eeDXmBp4d7vru/+LPDqRt9l8B9JkNSsIZIeIt49QmRcPWTnPjNTDck=
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 8c67d77504..449b763ce4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -236,7 +236,7 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    int ret = 0;
+    int ret;
 
     backup_init_bcs_bitmap(s);
 
@@ -246,13 +246,12 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
         for (offset = 0; offset < s->len; ) {
             if (yield_and_check(s)) {
-                ret = -ECANCELED;
-                goto out;
+                return -ECANCELED;
             }
 
             ret = block_copy_reset_unallocated(s->bcs, offset, &count);
             if (ret < 0) {
-                goto out;
+                return ret;
             }
 
             offset += count;
@@ -273,11 +272,10 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
             job_yield(job);
         }
     } else {
-        ret = backup_loop(s);
+        return backup_loop(s);
     }
 
- out:
-    return ret;
+    return 0;
 }
 
 static const BlockJobDriver backup_job_driver = {
-- 
2.21.3


