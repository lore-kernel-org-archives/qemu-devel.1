Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB5C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0792B2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DNlFRpkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0792B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8gl-0006EG-5h
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bL-0004NH-U6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bL-0005ml-5F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:39 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bI-0005iG-9g; Thu, 30 Apr 2020 08:47:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNHvDCu/zCYnoNsKFN+0WVbUV+c590YE05TraiLRHU3ELhEHkLls92WKmVnk9M+9/OdjEC872L3hcoXwwLtKeOTf057E/egoHEJToojiYjW8NlweQpqAZFhesslz4lDyKE2PUC0WsZSjrjKMAjs2KaU9iRtBOtfb9loK+9+W9F7D7HgHijOwBWVtxhvNSh+j2rX1VzI6ZWser9qwyvq9v9iIC338hlTWKGX3Abs2R+SzkGp0xFgGOlaY8sYs9KYLb1fGOyKwJ2u9abcaHB+7kkj77aAtgrrEJ1RGKHkIh/vk31IEO5z7iRX41XatPQdZQ295mLOw3dn3G6eEeokAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBhz97nABv2kplr8qWIHn+3bvbgZHECLMBp3seKMIrI=;
 b=EC/Dtyb8TwGOeMzAIacyUuw5DRjSLJDGd/C5rFNGYRl6cRe4E6Ifsbep4VWbU6F5WAN6yMRQQCx4VhHbn5ay/3x3UUA0GVLSFZZYpzVMsoaS0sJY7U+38pAdedgh3yCzCvR31nQj3kLFeEUcp7RVhKBYizh3yUaCSMB1UvywyiN2EtsUm9683goiSVWolJawbzyHHOrHgV0jtR/D83gKCu8V/gDf6oKX6JlHBRKByz4H2N0ncU55XMW0gxRI0umFPDsWyD5834JQXmw1MVhf/9zrWjyBC9WukO4c64QEsKak1/bxnChhBF5ibp8EgC8CfiA0/hC2aV5k7khI7C1NLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBhz97nABv2kplr8qWIHn+3bvbgZHECLMBp3seKMIrI=;
 b=DNlFRpkbPJrUNjURs/HFWfOosjxGVjSEIHfkBiCf0y82eMGszd13y6ZSto1/TqEQxsQ1uF7oo6ZyQ8xtRLRxS/OEjPSzmBja/p4CcyOjYzGYYkAN7CVArxfKxUahD/GhA5tdmlQ6orOMJUt7pvVQ9nWf12ooaD9hIrsXpVTrlgA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/8] iotests/041: drop self.assert_no_active_block_jobs()
Date: Thu, 30 Apr 2020 15:47:09 +0300
Message-Id: <20200430124713.3067-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:31 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60128a57-822a-4e64-8d7b-08d7ed04a646
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54781BA42F518C55FC8791F7C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxuC24a3NWxn+qh1XI2paCjGjGx5Nn1euwSjsM906cLPvBaaWto5VVa+sCRBRzP5UAviQIe6+e6i1hcN/P6TZ1QNc0RLOEJtNijktuD2ayfVpR8VhAW5xZVxzgWJIgKw6ntcm6y3wsV7kwv7u/I+vrwNtTnt3HT0H1i7IhAoqKJXS4P8dL8aey3HG260XWsCr1yosScPloNTY3TCc1V6rKKLO/TcE2qkWhntvMPpcFyJLuLi1N8ijC2YUk6ZTbD6JGIr5EfzyCvzGz7sQAiYEQLkFEKW8MyymOxzQgfm36wZZGOVivqR9eyl1PiUZCJi2kFIlwE/TXVZn87245p6g519CgnU5be3HeoQbvaTCxQAqzwQMAhBUoFegh6sJEFJoo1/MHnC5hj27jAN+DRhIcfk07q/VV+M2dNYgXfOK2mjNEzcVoxoQxbomSme9OHT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +vBgm4ap8PKTNweY0Hw7psoRstwWCsPWORDB0EkNYAchmWb/kxuq/87lKpoqCzeIyjgVr6oUJPAB5XkavHTXnp6e0B1Z8bKs3sVEIPR5WVyFlA7qPPHgJTEeJ/gt6oA7IVF6Fdpag7b+sKywYQySRi3qQCpkkcdmYhM9tEISqPXo60bIutozKHMO5SCMJ1LpKICFyTnGdzq8TfdGUApm6mKvijK2+LbomQBuqoKQ33Tb+fWdjl72iopucWyDJNs43J95k/zo9N9taBYcvk/pO7r4BaoWMGPRrXHDhEa4iX6ukWLeTUdOjyyxD5/OKQ8EeCicczYGI9zGU6Xobdc0+9WYaFPNtq46KNDfDnWEqbcNMZy4NTsQe/iL8YV2oBuTROm764ntDRlJckv0kD99NwJJnH2j/sr4oJlB48LuYmZz+xgraUHvt338X71JyMk3HcpeXxaejvgGwEp9FNhudnar6GspEEkuYx5mrhzXTlfozgKIv6EVGpQiNxRa683w4osMnUrf5GN78HnzuOAN9OUHppSHuaBNbBuPfYEjijicBA0QvHRKOFIkhwCZTKcqAmLiee8TWa6utmkbULgdaWKSELWV/ah4+XUaRuJpE772HXFiBoe3bSK6Z9mOWrDkX9sMuWumBeB/ellof+IGU5th9cO7DBqg2BixrvmnUqw6cjq/3S+EdROsGtkJBCmgqGhLdDF5NKbocZkNjjloF/sguf9ri2N1qmHhjc9kFjigA9Pb9KUMHHNa9g5xN4LGJanWxt7iWSsiGOHL97PWYZhbkccB54vDlJkmJeihX9Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60128a57-822a-4e64-8d7b-08d7ed04a646
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:32.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAhraOW5ga4b+Xyg41cc0+HMQGriuJ1tnVdtYVxF9qNVsef37mIzWWyO5CSJW8szYzDyWnIVwwoUBibcsj01U+twcqBsDFDkffUHQc+mYII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop check for no block-jobs: it's obvious that there no jobs
immediately after vm.launch().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/041 | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 5d67bf14bf..0b8cbb889e 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -904,8 +904,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                 pass
 
     def test_complete(self):
-        self.assert_no_active_block_jobs()
-
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
                              target=quorum_repair_img, format=iotests.imgfmt)
@@ -919,8 +917,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirroring')
 
     def test_cancel(self):
-        self.assert_no_active_block_jobs()
-
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
                              target=quorum_repair_img, format=iotests.imgfmt)
@@ -932,8 +928,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node(None, quorum_img3)
 
     def test_cancel_after_ready(self):
-        self.assert_no_active_block_jobs()
-
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
                              target=quorum_repair_img, format=iotests.imgfmt)
@@ -948,8 +942,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirroring')
 
     def test_pause(self):
-        self.assert_no_active_block_jobs()
-
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
                              target=quorum_repair_img, format=iotests.imgfmt)
-- 
2.21.0


