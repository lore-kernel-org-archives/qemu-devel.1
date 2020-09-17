Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F9C43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA10206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AvgiIOk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA10206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ07I-0001eg-VQ
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00c-0002r7-BV; Thu, 17 Sep 2020 15:56:02 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:28641 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00X-0005sK-5N; Thu, 17 Sep 2020 15:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmnXYjqdv519Hr/zRHSDKuyWuoEcY7Q7JHqGISMU0Mfs4o/8ElXXLaTY3BI+WOVxM1GEP8OVNg49Jt07zntzG/LihHQ4R59wBN512jcslovmEMgpC6i+98pCUNSzuZgTfxEBL6jq+7544xItSLqNsiqceh34iL1YtoYqzXgw8pk3vSsa1h2OaQFJT05ch3TETXS1Rhj134L+0hw8+1l+13vSVnh0m6Jo6pI1cThEOybOFXxQvEcIwVRF+D/P7H1j9hHulPBL+8G6N3JjC3VI8aGqm06awbJrRQzdWx+lwzYO+CYFD0bks6anpaXaqLrYO55FsJ5ik0mnK1SqRjzNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=g3m30TJJYXSQqyYK1QQmbd6G0J7DzbVb1QRxnxwB+kZG7+LKn0AlYgUitcyB97fgWlZZvCCoFAfyhUOH/ZLK8kqDWX6J3f27/Lq8NNz+a6Ytk0EDKNt3hX/1g8D2bXocbDxjL4/GPeUe4ctyZqCkOmLEk8mQEb9gE/GUaqfQNdpGoM2p2UV8pg5A13ToMq1vyY2smbD+DSOA5UZnWsDwJAQc0kb+TWMdQn7+QpTlKnvktg70v5as5KdyB8Wp4+SBnj/WnzziKihmbYfSBPPaL92gx9NaO+fo5tSqvrn3kLdMSVG81yQJHwEYgdmWS0tBBZPshlqJI3lSjK7lvIBZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=AvgiIOk8DYtxfWkRJn44A18TXCVdXcA0/IrVAKSxGG5B3bcaG9GuhAPWgj+doMV3yJd1EzDheaPb9AUszJJWXGsVuM4r514UjYtc4IchcSavuWSjaTNhFnfH4Zq3TsxE7+O2TZTZjJSfpR4zvM2yFJEZrkx8jpJSu/pPcTGqi+Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 06/13] block/mirror: drop extra error propagation in
 commit_active_start()
Date: Thu, 17 Sep 2020 22:55:12 +0300
Message-Id: <20200917195519.19589-7-vsementsov@virtuozzo.com>
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
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:40 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fed1308-2ea5-4c49-9dc2-08d85b43a7bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30325C42C88FC350B8D86C14C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLENT5QQVhopUWX0tpxEAl/LRwkkL+SqYT6z0D0/r4TyqgMh9Kq6KAHJP5pWvUiJcYh12wsyzQjc5JhXxgvvTJkKdU6Vy0TLVKXe7Raque0tMSieQ8QYvUHFYTjHyjs9+DMN/m2nJksETd4WeSIlcZm0Qhnmg9xyKNuoOMfV+EB3cfbNxHHHb0VcRxMiPQ6az0GyjPyTREmJ88agcLQrASgv+vZZv4yBf25FRkaWvjGAE5KOs4gKoRwVeAFmv6xd+uFMOXgguTg21hhu/PYMBAp98Z8X+wZvZ9z/OsmHjBXz83kWdaAuHIr1zbGxUDqd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Rs1OPYgHPygtAn+yEWERvaU57x65FzM95/s+m2FXC9H7DIK00pkRlwzWkwTXYnABq6GlKwXui1ulEq02dpsJ/ILPM2JIk6PJUsaBybWSqbwEenHLaOt1hpPUkIi0yfsv7pXd75h1j1nHe+f6Ff8v/Svm4tmudrSsb8wOxUk2DIr5KR15yiO0AhbKRgEKSLZULzhkxlSapy/iMu/Iuuqc1h2P0zkzk3quWVQ2nNcho7oopROJ6/0SlkcMek16Prqo1zgCGWVMgfoJ153BMnhJ8zq9jNr2g0RbztftDPqmj0U4jKJecnh+our/vrzDQ87zjI/WBw6lPPyDc3mxChigFn0VmO8STdxNon4ZepQp4KLICtuhPovNvMyJxxR/lNMluCdxqxzA1/5t+ia9veGrIl1algqTCZGEb1j7G8AJEkdfetqg+YeTSXJAZPnagezDayEAeabbauVxIknSo34p9MrXUUDWAPTNydGXsw9sII60hD9TxG5zI+2Ekc2OTBoHv5DNXNhXfpePIIuwXkc1V8AsKsXdjCTgZOv0TOITEsXs5g+rWxlIAB1KssQRsolH1QLIAe8hLrxglDrusdwBcS+ZTRSCvVNlUackPw+cS0b/YlA4OrIgmWFXGzkTqgYPTSpld+GcoUo+bg6IfY7tjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fed1308-2ea5-4c49-9dc2-08d85b43a7bb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:41.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIcpVgznL/zKJlaaFoJimJF7ciMkREQ2NqLtnkWD61ANIqhb6efp++qQbUhuNGCr8myTKpvn21gYgNC5V7m+2vmopZUD2CQKrTku1yoNiz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:40
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

Let's check return value of mirror_start_job to check for failure
instead of local_err.

Rename ret to job, as ret is usually integer variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b3778248b8..f7c624d6a9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1851,8 +1851,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                               bool auto_complete, Error **errp)
 {
     bool base_read_only;
-    Error *local_err = NULL;
-    BlockJob *ret;
+    BlockJob *job;
 
     base_read_only = bdrv_is_read_only(base);
 
@@ -1862,19 +1861,18 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
-    ret = mirror_start_job(
+    job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                     errp);
+    if (!job) {
         goto error_restore_flags;
     }
 
-    return ret;
+    return job;
 
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propagate
-- 
2.21.3


