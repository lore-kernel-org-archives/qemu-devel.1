Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93237C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F381206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eFJSkJo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F381206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0954-0008S5-FJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091Z-0001iF-GV; Mon, 27 Jul 2020 15:43:01 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091X-0003fu-RG; Mon, 27 Jul 2020 15:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp/TbGmnEavncY7sifYYmmcklbAd+LhrIc/TKtCzqlkRk2UgWIS16ZyOV7xDUJoA0521jABlrysw/F1QgXzVQj1Ib5mwTp7/w+D0eYPd/QnWuFLL3qlz9cC0HAuUiFaD4Ot+tm/rumN8ur3qBAau5PZ5X7WOj+vqjZUYlbXxbmBa+SlRZ36JluyAIrCg5HcIyd7RxUVzk2mGPpC8OAjVDOTwQ7X1+ZC++R97dG+Pv9FqGQ4NsI1Cu0OHz6TV7j5ni5VlNZ045RdwQB4VcuhoFIhxm/XII+p+3CH37sVfqpdd6p/E9O6NKldpKhuW5ezx2bG9Urar+DOiy51yhXpzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRjEsKXCNKOMH92X12n2N4X/wygLaagQIufb/RiMPAg=;
 b=c8wcQSo4U9eQ7u3MZpVJ/3NYxXRF/Eq/vesGtgCl4MWlJPy/ZYds2IssD0QDGYD265OkY8DdK31LtSZj8HonUwZ4LNGsgY5ICJuvFyvbmTGQfaqQFO+5YWVmrivww9KolEm0V+I+H/IYghq7SdJO569uCXBqTUfJXXM2iZAUIFDDLifV8h/MzCpk4xn9Bgj1cPJpMPDWG24K5HB816EBhqFPD7tRAblkn6LMWsMCEzLzE2hFC9QEvq5Fv5u8AwUqAlvx8rpy8iZD3V0OJoN0tYCWv3uJ9TmYtKUMgzyFEVlHgw713+0HOwa1g3Jfkp+1XRyXCmHm+5XY4aH/GnPa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRjEsKXCNKOMH92X12n2N4X/wygLaagQIufb/RiMPAg=;
 b=eFJSkJo6EUy53XDfETgE+ArxJMmoCCwVeFuuVik8ixRWwANybqVNSOACGaDwLuqMrdABjt1N4nOaGt/HHEesoYmqFrK92Av3mhfOaDWQUV9SOFB7EEm+tQGELCJuVjbGbtGsIgvGnVdHNDVGLtFPWcDnIUWLQHWWxeHtLBtjmSI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 02/21] qemu-iotests/199: drop extra constraints
Date: Mon, 27 Jul 2020 22:42:17 +0300
Message-Id: <20200727194236.19551-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:42:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f4b8b9-e5f4-43c3-c18a-08d832653fb3
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610A5E0447B5FD90643C260C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DKuy1rUJVmHNvxUY8hnS/bs1zt6XV/DCeLxd7d8z8WpHG/gZCLPVDg6cRbbl6HNQ09eUfImD/TeF9H9YnucsYZAuhv4k+dfapJTzVHT3Lex+LC0rMM8W15IRHw5bJgnXeRp2xBedVnCDYQ3o/c+kzr1ThFV6nvHMZ6vBjKh/J3a4uBvJ3iDeEppgRA6qI/vuaMQFB8Q9NGlYcig1n1frLqL/rL/4F2xgWptF01YdjtxvqVvlNXSuK6BBQaZNjTBZ+Ec4uMH2Z7XUXPZkTAMuzbq8N4YjXZlvZgV6GapV84MgCEvglnzc2ULi12N+Qtf8SfPgB4rTiIszMNJZM7rCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(4744005)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VsglGsTIWtxPaH8mSfuqNByjk7xEjV9JR+1pSdZEzuJDCsc3zr4tcQQ6Xy+LP7qukN5r18I1jf6oXjlCfpv8rVfompRA0gmTEOJXcHohjTKBn5Nfqto5knP2h8+I/3vqWDdHy0q1KcW1sRtHujENEV9K3E8np4lQTUhVc3HYfYeEyPCBatS2aAygiI+7+4sw797dqZ+5iMzuNH6tGNSfCMb5CMTnF2OICAP0zbhGZdc7LmYeXw7cQmT6YfhDqLU7QYajXtxh9sWI9gXapiLu4rSzI4MJ18QFbDSkrDtbgGuKFWjyhudvTzTM5Pi504XtIrdkVjWavydmKXaekmPRykn/0LHqoGSYAwv42viYw4cAfaCSgTmq67N5Rl/lDxOPKAIt/P+OtaVeRIUVLri9VE/SK80nz6QEiFxORvlKATKC0GIjfuK2ei9Hr4qfK71u/HFTw1gGlZwoMuYyoc8tYCdgZaauSmQZf2s9pNBsUEM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f4b8b9-e5f4-43c3-c18a-08d832653fb3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:51.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnCLyqRLbklbLIzN3QAu56xqzNYF651xw6D68kJUIxL967Avq1ow52Lqrzb3D8xDr73wmd1Qb1IxJbbG5lfk8ALG0TUtToa3s36iABArwk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need any specific format constraints here. Still keep qcow2
for two reasons:
1. No extra calls of format-unrelated test
2. Add some check around persistent bitmap in future (require qcow2)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index de9ba8d94c..dda918450a 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -116,5 +116,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-                 supported_protocols=['file'])
+    iotests.main(supported_fmts=['qcow2'])
-- 
2.21.0


