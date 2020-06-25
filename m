Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB74C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C980E20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tinZvmFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSqo-0003hL-T3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpr-0002aj-98; Thu, 25 Jun 2020 10:26:39 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:41601 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpo-0005wS-Fy; Thu, 25 Jun 2020 10:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie49HEZvxect3q0ntpZoKamjoo3YgbEH0TElqvDGbIrt954RRT8xL0fidrey7BsO/Occ4WnyOLVNjMN0PPI7iaqS9Dfw+qyzpUpBZR81oaivWjmi20UPD8S2KD6RHvw8bmfUwNps2Q/fYik9uu4+iFlVX5TA9asLhqGg74tdohdp2URwVjy1H3kwuAdID/alWEqXeM42yYc2uyFjpbrxGQiqXqaqHRmd0x+kuebCbj5tUfl/tK9SsV/UEj8a/+91GsIQU7K5RsEZ6FebRbC+45Q4CRuKTbM/FKSTWR7w77c4Il7ZTOTwzw6m2Gl6qMTq2ZWR2Ej0es2VVsFwP5HsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjSQ7+Y3Vzfs7x1ZAuEqBLGZxGrNx9httgAGjQNo/kU=;
 b=EFSL9ezgiS3agO/23D9AVeZiQ42gD3Ig3iEfohXvq9k3r3AAHWLbCTlJavrDpGLYoFfsGZJEhZqvfdwX/a447VwuFd2J3k+S1pyDkjbZF91SwzYO3jJ4lePY9XkM6T5wXYE0iuG2/kolEQniKE/+X0BXqFcqjrbcH6yNxOVP9xnAVlJUp3tEd4O8Z6Kk3YxPtr6l6h1KJgHjHPOLMtiRu0RJsOhIoHmar4G8Z+ColYm2vwyrfHijLy040nT3zKP++hui1pYdCgDG212DzlsxLYCstjEJW6cIz65aFMkv0inJKqTEaRwtZpbJXezQszJDrbfmvNN72iklWAbIrEO1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjSQ7+Y3Vzfs7x1ZAuEqBLGZxGrNx9httgAGjQNo/kU=;
 b=tinZvmFTQqnueDL8JiEYQHgS+nQyYrlOuGeFvTCsEgMdVXf+BA9N/xM1mK/YE2rLQzGhGbcpuTmY+YTAfW5VIVlVmYYKgbE/LKD42IcVqh2TLIMk8RO7zjEP/72eATls0cKzwPX6gYig0hPVP+8Z+nsqdDp6UUR7RCQ7ntz1woo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2100.eurprd08.prod.outlook.com (2603:10a6:203:50::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 14:26:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:26:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/4] Fix crash due to NBD export leak
Date: Thu, 25 Jun 2020 17:25:36 +0300
Message-Id: <20200625142540.24589-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:26:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bdf9366-42fa-4f5e-2ece-08d81913c2cc
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2100676B9AA26222F5FB7BECC1920@AM5PR0801MB2100.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC8UW5g+znjVtOUsJxQ7ZpmQlHdJ2++13VRceMmY1zpTSpcH/nz1TawR9ZEE7kL/7XJ5bF9DOjqfflShl7nbK1GRGmEUpUD9IXMf65Dt1Z8XIpZDjdcNbzWM7F4bzcFVk/rQHCNFPvGMGzRybiHIWJT+8LDaILOfcDiNwHuYWfxOf3JXqBEvAuqYpIPPIy2JFcREOu33K+lH1T8IOXfGjDw+j5Xl42ltzmOM4TkaTBAgM5axMuaGy8ZYLjhEjxVF6VvM5R2AktTxZ+xrGkgJ4oR5Ac122hZSmgDzDD+q+N2UrvLPwGpl/i/8SEMRr+QunV/ROcPlnERH/W8sdNHyYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(52116002)(5660300002)(4744005)(6506007)(2616005)(86362001)(956004)(316002)(36756003)(6512007)(1076003)(6916009)(8936002)(4326008)(107886003)(8676002)(66556008)(66946007)(66476007)(478600001)(186003)(6486002)(2906002)(83380400001)(16526019)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1+TvU0rqDxH73DFmT1gRMplFRz+AdeHL2+C5OLtU/luBFswcKFL8D76zdlHfx2SjIN9vILH4VTxIclTel/oiXT3oWAxh/DJxOu/z67bJDMuHz1uSkgD5gdk9p8vKH3q7yGAfeWI9ZWy21ferRDXjOC/fmGwGRYaF1yyJgJiYpueyKZ+agyf74BbI4AFmcWQkaRVsop5RKSl9tlQ8naOMibqcAJfP8Yo5yZiNqniu0HcCJLNz2U1GKleBgVTIu8b+BWdeRe8kS8OtqQmUmCnepnZm0+CCuTcam5L1Sqt9c9J33ufxR6LVTtBFRmpUq+CJLraU78jjPXJnOOPdEinaN/J7jEnaUDfB9AT3hGLz7N14iH3fZ8R+w44E87BXzWKPFLNNGfxqY/g+9lXJe0C9w5hkfofvWqruRnnbaINgZmebGItjJijjC7HftxcOKqbFeaNWkjVtbiFzu9jcSxWu9R51xHWk/GlQKqB3+0RcV+8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdf9366-42fa-4f5e-2ece-08d81913c2cc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:26:33.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 319NleFGIhQY/utt8NtH+mQqsxzHGJwUc8pqbLq63dgE+LYV43qFwtZQMcxV/zmikFp7qpUfk2ka5DUV7xupG8sSczoEAXjKiSCXzUUEwH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2100
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:26:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We've faced crash bug, which is reproducing on master branch as well.
The case is described in 03, where fix is suggested.
New iotest in 04 crashes without that fix.

Vladimir Sementsov-Ogievskiy (4):
  iotests: QemuIoInteractive: use qemu_io_args_no_fmt
  iotests.py: QemuIoInteractive: print output on failure
  nbd: make client_close synchronous
  iotests: test shutdown when bitmap is exported through NBD

 nbd/server.c                  |  3 ++
 tests/qemu-iotests/299        | 65 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out    | 10 ++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 15 +++++---
 5 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out

-- 
2.21.0


