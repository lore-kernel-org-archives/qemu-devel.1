Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A2AC55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A315206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bEsI0izK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A315206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb18G-00085M-2P
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15B-0002vg-04; Fri, 06 Nov 2020 07:43:09 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:31364 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb158-0001NI-48; Fri, 06 Nov 2020 07:43:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFp/J/Egz3VutZlgTjWVwEBcpeur8wErnGbSNMGYGjdZZEozIo2eEZB3fqvHjLzd24580dhXDAzlrcsRLf4FkXyp/35RLX0vfUwUtAHcme644S9NIBOOWdOM1lwNxzr4GgrFAm0Kmvw4Tu+6gUnN0q9X4z0n9gTA/qlqpG92SImHQkwNpWYl/S4R+88ERr1h0wV27A81mmilynBAs2hiD8JyXmHA47LcXMlM2k67Qz9BUZADDgOH0t8mnYCkKl5dGS/5qSZSAA2ERQs2HKotckbjU+INxQ3uo0uQ0evqAedbnDDOcdRpa1Z2KZLjXDNboWoyWBJs/UOMVz/cJLdRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdKH/+KGeHxAccGIfDkSCrNAMgVDMyHfJB2ONu6hlVI=;
 b=OmGvruysamYIsYP7VEbfZx2Le6RL4Bq3n1m2hy2vgR98F+HdopEQNwOkLRpcK6ZNbDq6yCMCu7jhMz1K46Pa0Ayz7UFLWSeHFAirxN725R7INpPCEx42KmAn4V2+wXawJF4u8Vn54cXdGlb8FAYU86wgl0L08OTgbeA7GxjSfnF6SftEuxJTxICyHA5XolP478wrD214J4MzSdPyA9JGur8dmg2iByejD00NEPCe/0Zqz32kwNyP13dYnkOTNW5UcO6KpgXq1mcaGbYUbf2DZ6rcD87SQsd/PxTM/pAB/kL23XwOreKqhDYFxqxUsz7icP4p5TDooNClkUERhrO97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdKH/+KGeHxAccGIfDkSCrNAMgVDMyHfJB2ONu6hlVI=;
 b=bEsI0izKoRoIAbURKNuv7hZgTe3hCG8wIE3BLTeD36M3saE7AzUOOlNkRRYRTV3KltnBNwqqNUGmGp5A/2HAJ7p6glZlK5Tua8GSJUqTx/rDLgT/Dj2RNKyvKM4u0T+gGOumehQ03pBirMZcVNY/Yab9G+rxatugBOXTor773vE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 12:42:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:42:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 1/7] block: add forgotten bdrv_abort_perm_update() to
 bdrv_co_invalidate_cache()
Date: Fri,  6 Nov 2020 15:42:35 +0300
Message-Id: <20201106124241.16950-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106124241.16950-1-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:42:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32e9a7d-7d53-409c-438b-08d882517cd3
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841DB7D46647E626F736E00C1ED0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubRkUjnm/vV3NBolrmqVsdeZDlprhf4/vvf3ALbdlBeSL5BC0ybrAHen9kKh36NvF3uj1ylv1pxJ3PJQ+r0/4Rxq4yTSDe/5lcyHmNhqUNIoYQN6sJERJiZazXlg1pV11aKjStoNmD2aLVJirW76/Up2hcBYhJ9b0+NK2Q5QIHJ2iUjtPAazxIaU/MCjhXX0+mlmM0u61pUwHp3rOwZ4dswSQaf53gY+94k6dIg4bHUmb41Gn43PbY5ep0n+yR+jS3UJi5K83l/tS6N28Bk2Gjt9hrYd90Q6QwP7gFHDekj7UmxM6mfQTdHgqfTqsnuC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(86362001)(66476007)(66946007)(6666004)(2906002)(8936002)(8676002)(1076003)(4744005)(66556008)(5660300002)(52116002)(83380400001)(4326008)(36756003)(6486002)(2616005)(316002)(16526019)(6506007)(26005)(186003)(6512007)(478600001)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: F71ZzwM//hPhy3xczfeve3NCjNOtKN8Qr/WKouomqexyIb+eddhPeUteCh8Brv8fzPLBFDJROnjD+rLsBE5Vqirigt4kss8zw2H4SYx2ysNFRBEzTBlp0Z5FiyZQRdUiiwMplmCXbdUgD/c5SJm0E33kbHZSgy9EKCUH8v7RLwZ0Viip7r2l8PA0LKV++Y3Pe3MqHzJ3MTN9ZaIR9cZwPirVSZ3Nh9DDeQ1IRutpeyOg0V7MmQGcm6TPuOWf4AB/7FqQUUkpfcOqMVjiuYqdqA6h7YH3qFhjo3J6l1etamjD++a/7Q+nYkkVnzpX5f3wt2iKGWhkG8JdZoYMZVCD65aeoCwbQxHDRdYEKlOIsK9r1VE927I9/kMbIhvo1IJjy2/SF0hBgzt4b9pXEZjZiCrJyyYGXzcDNwOZZkG9Fw76P3kn/Y0DWvW0kb5NX6PvP8aXirOITaq9BTWJNcqxlQCK/az+R1sNFjOOIcM1qdgVevYlJs/Liwlgk+igRKCr5YQqxbN7hoWT0OaqgwfEaLxENAEcXsEpqy7FZEO0oy2ZcWB7lQdXpusS6wD6EdivkiARmzuezdwho2BuVxfLA9z8pdu8+OnlyPCW7Qt/cfEh/Z1hB+j4IH9t4YCxTh8ajXGvxBEK/TbKjUOLX6kMww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32e9a7d-7d53-409c-438b-08d882517cd3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:42:57.2740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKYD8GkwT21cu9fOt0dwfnq+GsxDpWboeE9uKpDQ89dBLuePfJdSXSNS7PyYQKyL+lbBMKCL5opH1qCKx6toAOT0oSRB8vXMcHKF7IGUb7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:57
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index 56bacc9e9f..19db7b7aeb 100644
--- a/block.c
+++ b/block.c
@@ -5782,6 +5782,7 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
         bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
         ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
         if (ret < 0) {
+            bdrv_abort_perm_update(bs);
             bs->open_flags |= BDRV_O_INACTIVE;
             return ret;
         }
-- 
2.21.3


