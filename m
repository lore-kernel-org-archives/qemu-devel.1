Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF12C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCB82070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Exj9g8be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcASF-0001lv-Gf
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP2-0003qq-Ky; Fri, 22 May 2020 12:20:08 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:21575 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP0-0006pe-R4; Fri, 22 May 2020 12:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQwyqdy+kH/B0Gxkzo7HlyKB7kyM6fy5IQ6G1kfvCli7Gy7oGL6rt8B/SS9yGRlTsU4PbuwNH5Qs5Djd5yEgFzkgvnJPjUgUUE7eNr69OeggCRB4AOYSb2oxuEt/4/KzWH9u2+TgDS8BGi/oDS7zWxeL5Qkjeiyi+HAe6h6Afzluy7OkXk9ts9mHxNpk5W3agGdG9BDP1raq805mZZYwUDeYqIQL8xkVF+cuNLThSNubg82DU72sVBdTWmPMfJZBSzmLlT6qZ7Worxiu8z22dvM31/8rtMB5oBn7KPgB1L/SIlBZ1l1kes/vIERWfs0rRuuxmhjYyqrEAjwpwSETxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u26EYttqlHC4j3yS/Xn5yhfkoRnR5zFJMm3PJDH5Mec=;
 b=DmQXf5fcyvaC1igBSjdacUNh/IbZoyOINwrvPSFl6seZVDsySZmn0QyYwdR8V9irvhqE6+LfeSQF6vpW2tjqbIHVIU4kSSGkcjyxCa/oW3cgbfQHDZexYhQCHXwDxgpMfgCgfuE9pKzhj2/ukgIAaKWGFjN4Lm1bECjXazqi1+iJRIrYRIIaOkAI07rry0iSHCcxFNvNq3cBftBWIqJwjz8fnNUWOwVnf5mLgGorGQwthQ2aooIGjLjUl+flmC+H/vPJCMhRRTN5oUeHEyFEwhdH+YomV1uPu+l7aFTGlEx77fX97R8pONKp225XD+d1qtCfiFDGzvjzK+x+gOPp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u26EYttqlHC4j3yS/Xn5yhfkoRnR5zFJMm3PJDH5Mec=;
 b=Exj9g8bec8zd4hRbUufQKii6BepsaHvZrJccLh78AGRBuvDcJJmREg+ymBver/UxMwlEfTPhYQ3+IZAH6r3fB99/3RfrmtYCTyRnogGItHLEFvSSiqcZ1STEt/J+LRSlKf9aeUBrGAUbZPerfxbFcf/3dkBbxC8RdwAPPrhASXg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2813.eurprd08.prod.outlook.com (2603:10a6:802:1b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 16:20:02 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 16:20:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/3] coroutines: generate wrapper code
Date: Fri, 22 May 2020 19:19:47 +0300
Message-Id: <20200522161950.2839-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::46) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 AM0PR01CA0177.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 16:20:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eac050b-4486-4bf9-0168-08d7fe6bfb44
X-MS-TrafficTypeDiagnostic: VI1PR08MB2813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2813D1C33C4FD3D047CFE14DC1B40@VI1PR08MB2813.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPNr55Tu8lnFKJ/3emnSunqzv/mxxYowynYmgFqhHkKyeo0dczGrPQxNZPfqbh6nSO6g+yLv+1tG8lXdjrPTw0p3WEo9DdMblvH0fkjfYh56v9GPNa7cDp+/YDM5umhOZMJfiEL1+wi0k8KdKQiEPV0VWiZ215GZAFm1A135C0SKFHEdZnQ9MGqinb+6j2dzubnyYM92dOK+PhJpcrDztbLMsDVjH41sIuoH4KLwTKxWeBkwMvaSCQ/FmbH84banf0EIaTKPSGfljdhFHpFvfdYexFrJxE2mq5uWjhQeWoASBBNvfPHEfKOoYNLF0rsWJMahAo0RuJYsWlAkrtTs2VCs2lGtDmxPw3Jlivm3eVXZ3ay9qxAesn0pOUvV53WvXNW8nJZTgNZWA3IQPzl2NZY6YpQKR4UFw2jDEYkS3Dvhe1FquwhBEpOl8WW4vrDTFOiHcKKv+7aP/xEiM1j9wuc5UulzoOqtb8mdPgU0TBf6p+r2fnnVE+IrMouKlM8g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(186003)(1076003)(52116002)(26005)(6486002)(16526019)(2906002)(5660300002)(86362001)(8676002)(69590400007)(6916009)(4326008)(66556008)(6506007)(36756003)(478600001)(107886003)(316002)(66946007)(8936002)(6666004)(66476007)(6512007)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A7AhGNeQBwk/8+6XN9FA6CpcsNS54I24O6zjNypCw8cnc0hFyxY2z1FO3xxo5mfEme9mGITjHSArVmJmVhpDfIRQbUVmirwHvN0/ryy4lyqnh74/OFwfVlWLbnezPKJDW++8MYG6fT+wHWgBBm/6YwOGM3xfdQ/yzP7/aRaa6YAv6ft52QCMuE1oyczQpXHKZQBLw90SlNkTRLAbrQbCvQLd5RSTUMtD7u98fghX5F1zE9CMerSS85UptOWBipUgxWtkkFeNvBwPO2vY3XH+XyiCBrsqGZBefmzjYmZT28jo0TeKsSnAYmNFHhO0EoDcxqlpNaCVauHa5ykgR4JnJcxvsKgN4FbJP3wVu9647Oesc8Pv4423T1mcACpM9hoSys7WYzbXW58SEWxKf5CMYQEaJMqMpNjubxHN7Ew3SwzSSucgVpg1Yg1TFr9gB0ig/ne+k9Xi5VP8cr+ouY38zBLfVXy/HgwY+bTmLGJcjUQyMn15MjeAGsdM7SZXoFQM
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eac050b-4486-4bf9-0168-08d7fe6bfb44
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 16:20:02.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZP1lPSGWjewn3kbhNhx70auBDHX5VF4T7zDvYH4QFipyb2AaJSN9WVK+z0kIlhpdRAaFMnTtTkAIANjiYcX/VgkOvmCN2hB1XDxv7xqumE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2813
Received-SPF: pass client-ip=40.107.14.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 12:20:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

After a long delay (~year) here is a v3.

The aim of the series is to reduce code-duplication and writing
parameters structure-packing by hand around coroutine function wrappers.

It's an alternative to "[PATCH v3] block: Factor out bdrv_run_co()"
patch.

Benefits:
 - no code duplication
 - less indirection

Vladimir Sementsov-Ogievskiy (3):
  block/io: refactor coroutine wrappers
  block: declare some coroutine functions in block/coroutines.h
  block: generate coroutine-wrapper code

 Makefile                             |   6 +
 block/block-gen.h                    |  30 +++
 block/coroutines.h                   |  44 ++++
 include/block/block.h                |  17 +-
 include/block/generated-co-wrapper.h |  11 +
 block.c                              |  78 +------
 block/io.c                           | 295 ++-------------------------
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 169 +++++++++++++++
 9 files changed, 296 insertions(+), 355 deletions(-)
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100644 include/block/generated-co-wrapper.h
 create mode 100755 scripts/coroutine-wrapper.py

-- 
2.21.0


