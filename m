Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD886C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEC12073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E+TdlsAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEC12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGNL-0005hQ-Dj
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJS-0007nr-Hf; Wed, 06 May 2020 05:25:58 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJR-0006M8-NR; Wed, 06 May 2020 05:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdTeAEn9euWBgsVBCSBeNPhFsDKfUB+LGgN4oftOSJRAb/+eqBlQSybMr321ajm0pGn1AqFV+ouhl7Bfp+01bM/iGSXMFUiIqyMnv5ANtUr/kLMPyOamgr1uelAzhLxICu/1s0GfLiPJfWZEyzIChzVdYxzZLaYN3GoxIevbWUnw8teATPLfJtUhh3j5gJdPiZm8xNpgqywjCEAkFvg0BQr5s9LUzUPNt0fuTFTLTamnWF4xpSY70lM9cNtMhhX/i4CmeBDQV6BjA4XdvE9ieGRbFCzNPKnZN5QRnHYY1AHYMU5RpTYE6AFWK9wfcVPkVOJbFEhrsZ8MbHfO3kMtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyMhc+tlp9KJH7/4pnAro/zM2Gj0iiVvsKyD1K0GLlU=;
 b=h9YeJ4nJoRV9kgpj7/4Os37Y7FboNdmy1e03nvWtfjERwGWN9MtOxd9dXMdbKW4DbhNipYVwb2oKQhHYKsFr8wtvA2EvP4FN1+62lugQlPeq3iGTbzEeNRcEcO+jSP8AqFa0j/PSo4isO97TZ/kdKTLggw32tqk7cg3l7j0s7pdqlPKAFfa2sqZ9RViekmTDQqlP0Hb1Z2q+2M5GV7d+eyzo8xUcM77PmrXGEI16uLYpZ0TbTo+FuNkmYmosqFcwKUfp8sMcOJjWpMXo8DxG5mkQUT2Ikpckm0EjnI/BH9BqGQ4Ep1muUPKxcjxbT7f7WLPQQT8RnHhffivX5id7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyMhc+tlp9KJH7/4pnAro/zM2Gj0iiVvsKyD1K0GLlU=;
 b=E+TdlsAGCNRYPpv/duKFzs1ontm+L9tx/rMrF/pFIc66Fv12EA3VOA3MeAucx5rjrQPuTBFIiQ37t25/baV1kxQz4H0T5ItaUWz51/zJG4W1pEXUjCP4f9Xo1CBGcZt6DwB9OR13wGFx2d4qA+hy7jptOJBjEDbPMRVP1kCLGwo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/8] block/crypto: drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:08 +0300
Message-Id: <20200506092513.20904-4-vsementsov@virtuozzo.com>
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
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da912479-72e3-433d-b81a-08d7f19f76f4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53820CED3A2FA2BE383B05EDC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMCJlo7AgEfrOPenwG3v0tcb2oBw/bq4akmKaBTV1oNjUQncPEEFmLypD++QiXCG+N2iGZGq16sHPWMfbvJLkKYyd9KSbvX6QdbTesXp53g7xMA9o3y1Yxa3DXPZ1H0YAqSED+GJbk8IDcYJEAEw0qBe/DjGDHIKulfVSwVd11x6XruP+K0y2dAUZ1/y/TqKcvUEPjrBFa4TMj2t5Q/jcLx0va75GNirfD9H0YKZ4oo+Y58z1AjfFSnLe4GoxLsVlB6B1UQUjCmBt/j1QrZLlH7o59bVlXsokbMmboQf7D5nSyM48Orv+h8JE2FFNujVDtzm/YUN6kbks35tHCxpVo+Gw6h6Iy+vYQw1nl/NT0d4AcsiSvKPk9hQj4AFJRGyWLo6HeGG7VvtHr9QgMjTQXiZzXjM5JhblAnSx98eu7prTwKSOC+Z/ajNKhD/lFd8fOncZ6pa0nwn4kjGfNnnqpoSYtfYA3Z96+7WZOmmOW03SQe9wnwhsMze3MUi444bVlYu6Ox9Aad7tK24sOmWqDIl2s7GZnon/HqNEuXW479bU3VR1HSkiTwqDkeDaBjb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(4744005)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3KIQ34l7lBXZ/Mr3n8JwO0gxpPZhK4O0KM5jKIp1uzXmaKipr0RVEIHd6Re55o4KMvX4tV0rdskiVVpn5nlnLt1jQbyrW5po0qXND4S6AoaWxQPKA1dIq1g1wxNZqu3yFTLJrjcBJrfLczmy1EQqn6CRXpYvbVUaeAf8FpTM4YtGyu7IiGuGX2nyrlSoxmXaFGle+ktBVXfzxHwJooayB8pQAvvBXc7TAkznILsAy0CvJ9SzMQqgeRBivc8F4GzmML8Uxw7nzixFn0L49/v6LArWsbkKB+xke/J6qQkd9AQgnjweYw9NyvVrzEkOSVsOFyUE2pDFtL548wH8+xCkXvD65KPp9efBsMuIv4OUqr/545PUYVBBqMGuB8qfIEyG9qVOuUaQF7njOkp5S5YJpNdyGcsnOnWyCCXTE7sBgQ+Vt4q9AyCDJk/3G6aWgsNi6RgAXSHu6fdmubWnbfyxFMDn9qGeLFGn1rND6fQqRQsDqgef4HcYpV0nvde9+ZzFx5HcJw8Fl//eZXypIRrYbQXIImAVVLT/TO63Jx5YI/ykiMvnAX5ohpFgoqYavvEmsqELMt2W1JgEoG1E3giHRj/Qj/WFQwLDH7qzaeMEptuYj+IQAMc0zCmMlEHmTe21j9lQufNRwmo55r+OWls2yMqeQnK3vFoKT8RSGj2nEeae/PgDqT9f244wO/w+vbqyuh6bBS8qqlkNSuwxEc3bVOGtA2kNyU4BNwM7BGzRTYdFAlPYcjiIVCKPu/1RxCrvViF+875U43SFPC/uSojv/SYS52xz/KA5fH8keZg43Io=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da912479-72e3-433d-b81a-08d7f19f76f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:50.0270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ouat+iKPF+bmTQYaRj2OMBzcbfmo+QL3JI39wHaE2ajCIthvDkL1l2oRVk+qSf3hUoyOV9g9l1z3qdcEGmslG5iVH1s4O7use6icfICnQ4Y=
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

It's false by default, no needs to set it. We are going to drop this
variable at all, so drop it now here, it doesn't hurt.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index e02f343590..7685e61844 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -694,7 +694,6 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
         return ret;
     }
 
-    bdi->unallocated_blocks_are_zero = false;
     bdi->cluster_size = subbdi.cluster_size;
 
     return 0;
-- 
2.21.0


