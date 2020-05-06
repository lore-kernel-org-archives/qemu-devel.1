Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5424CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB03206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dyN2R4WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB03206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGLi-0003Nm-7C
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJP-0007hs-K1; Wed, 06 May 2020 05:25:55 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJO-0006M8-8f; Wed, 06 May 2020 05:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzDGZqXrZgRF+9qzALbw4x+xGDg1RQI4uIP5Vv0HCTOGDQBcL9uWDKJMr9UGC94Z8xV6YDJjKI1RfavBEp2UGEBtO+TfHWlbjY5MRoVjjkEo6R4qMKk4kQaLoXY5OwB4KyLbakqMO9cXnK6wyGsUunrOQGOgiN0s0VdurHE2YtnBq/oTujBQDft8A/KTM6vJ0Mg+aD7Aeow4+EdY+ffTRS+qIPEK2knpw7ylh0sPFVBnm724xkXsz8WU6FegXUCllcvSffwnB3E6ddjvi93LcIpGsZGg16LFrGf+vbEm+Llhw5aW4e0hVSeddbuHdBEynJ1GwNZylt6eg3F2v744mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4stp/YPQb+H23VtW46Eqog8ZHEO8flueBqrIOysmr9c=;
 b=NnLs+RNr4+TEPjOQxXRUqGyjB+9EBF7zC05Zz3uwwJ3Zzo7y/BpvIPgC/jmhAhD1ZwqA3yEj6uQhjTQm/WVk8C2dRCezFksYySvbNBEWd//H/QhZ52gzC4VdUJugCJHwtiq4Ucqyw6ZYSl3Nd4q1aBDcYZ2N6ugcdM3RMhNViCoO1zOLsuB2W02eraVe/V44OiO0A6JKduiqwYeQl5kovzn7Sby38zSxrXrJNfPffVFwifPhc6EOYsPlM3bVOHNfW7yWgIVOG/bumLGbxxPDBVMopTK4qZvXX0Y/uIsDKWWTT6/HCJ+nRwCoajayVkScoTTajLpgFVYJ/daZSca5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4stp/YPQb+H23VtW46Eqog8ZHEO8flueBqrIOysmr9c=;
 b=dyN2R4WVHj7YSZIgKJ4VzYftKwwiTfrLGas1UNhrVUktY0ZWbYHnzlRjUaH4mzcUSzUOnfrekWpIRcexNhS9UVYMzNIPY9LN6j2UJ5KAWcBqHVIVSNuGGPLAfoUgOaSXs8jryQ+T6F/v5XGbhk/693O9Gz6E/szHwKFvSP4m1hk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/8] block/vdi: return ZERO block-status when appropriate
Date: Wed,  6 May 2020 12:25:06 +0300
Message-Id: <20200506092513.20904-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506092513.20904-1-vsementsov@virtuozzo.com>
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af39444-98eb-4dce-ae35-08d7f19f75e0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538249B259E4AEBC1F583122C1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PByJXHvid5NjG7bA6XhLYpTe1XAJkduEFLeS5Cf3bOMfpv1Otmv/UEtRSkQADvCu3yZtU2ppQpyEmFeqDscDvW02v0GSKeur9ouTIv6FORuprVDwFGjAlIq9mc307FM2l50ydWyLonG8FDgfq8p2Xvfio3RMXu61DPay6KcQIqIC34caIgvs23rsyfe2e4U9ImLvaV7NizBYjC11b8eKLt467jjFZS8evf7rzN6r/LkZEBIG9BMyIBXsoS6yJkjQcNze4ZDvxzmkPpEmFuMOblJOJl+FpRZGm/P/kROOISvnvmqWuGfqPB+q0IQeSOz9UaC1nbw+dC0Q9Qd8BuaDwgRIltuIv7AKixMRuwQLhX4scKcUt8As1aSgQQkUBp9g73/DlZZNcKjjXocA273iEMx/Mf3ShozJwLoiQ34jS0yyKxMgAGIg+tnR7j1wmKH96BX93ih13Ho4mdGJ25tzRj7Ngof5yxnIyN6EW0N8HwUJzRqOuYjsWorenK+b8C9bk57ScOVya+uo068SSukjCRSVRbFW3fGxuWrS5z9NgkPIQaw1sJF7vCIv9f+XUGc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fqGiKrwSbYuOItnwIhGTBTr/Fz6sc/bFq9h5I68nkqgzvrsakVEOFaz7uBNUDg2fahwSOc9ns92S8zyS7JPSFFz2R4B37Kd0Twu0NrfDG54rjKWfa+5rEIi8ynz7NPzlnRr9nNuv6Ar+V5D/gkoZuzF5Wiflu2BZOo/VwvUQlMvx5Gzp55vFrMVW7DPCrA0WrA/WoOYEeErzRzFHeYKWfa161F16AWC/u0ZPX4H/T95ntEP5RxLDEoXfF4XnjLiULFEe4crLXSln9E0aXOjACGJQ0kbFPUaUSp1JqQ7OdVLQBiBWoc8BjJJz/bK4vE6UzffHfKdcyOVJ2hNA2PQ2G7awDX/7/lnbgHZl0ndhLQ/o22CJCfR+a8YbTIV8kRVCFcSbxE9soHew88i43Kl2mJYLnPXodtJ9YeTypym3qmZ04jEkko38fiLQS5sqjSHjds4EBAOuMQSI77wXbfdBI1F/LArelLbxP/tEAYl9kM7Pb3T8B/0nF57h3yw9MNCqX08VTF0EtIYHLfECSVzH+ojaSvKY/WExDEzKaYXmKafTNgqA/OI4cWuxU5VvZTf5HlTejiZYYF8F7+RioUlS9uPNGZaZ4pHXtYhP7yPd1YdjjFkpsmw4C7xxsS+QaJmvGKMi9dSxai7h422VyReEXHZOL3wgbRq1ovxQUhXeyeNcnRZZXD2EqN0H2yQGh2GgMCKBqrJl4sjyzzDQL4Qz24lLB7B+3WqbjQVeQnTp2xVGLk3+uiplSQSaPssxBX8LLtmsx5kdPmg4BYjhtvqwmGxHvzUSDhnhSO5bqS/5teA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af39444-98eb-4dce-ae35-08d7f19f75e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:47.7042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wncI5Bxz98fKwiVmIgUk1zW/SL33UoJsx5iil+ADlccwneW1wlVqGj06muIQhKg0D++FE6WGFESwJGUzTwkVWABoIaH0WgiEXBJt3q6NZJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
of qiov. So, this should be reported as ZERO.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense. Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/vdi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 0c7835ae70..83471528d2 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     logout("\n");
     bdi->cluster_size = s->block_size;
     bdi->vm_state_offset = 0;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
     *pnum = MIN(s->block_size - index_in_block, bytes);
     result = VDI_IS_ALLOCATED(bmap_entry);
     if (!result) {
-        return 0;
+        return BDRV_BLOCK_ZERO;
     }
 
     *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
-- 
2.21.0


