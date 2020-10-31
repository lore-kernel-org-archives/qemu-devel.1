Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA87AC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4B12072C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XwfZzZz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYq7r-0002mJ-7c
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 08:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6N-0001Ry-MZ; Sat, 31 Oct 2020 08:35:23 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:47840 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6J-0000Bb-NY; Sat, 31 Oct 2020 08:35:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDdEI183ca5wHzt6n/r9fLOf0V3nsiNYDhEfiTQkuL3ZLwjkYGz/S982Fy/zVuPvrRULXFhugtc2KFq3FSL1VeAZC3bHCV/+B4+0qz+QAJTSbqoiu5ubQGOzuPla0JxXJjxAp46kcCx1DkQoigyEdmIljdhERSFLIasdv8Qxmtf1BpyTPe7Kic3zsOdrBd6RCIV4QlikmC5URX7W5thJjC0K6JW2Cjqjpg7QZMxCeQb/Wkl1i0jod+QUIEApwFk3A4XHVAFjrXAn4m8daKcIZGTumQNXNxDBoOBnwOM1z9ftrlIY+di7geMspV8Gyk3J3O6D0hxafIRbTmDFc3DhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cbjmv282qRaZtbW7SQESt++FcOX6vyW8jGym1KvQ10=;
 b=Yit0OST+U2PNkmELb25VNZLXmSJnbEerroeY4AERQdnTb33/pKKcq9wdcs/0udZptw/z+Y34HGYrliEN011ZnuEDFmWHZgpq/OYF97EKe0mKx6t2cvI2CA0ewxFMqXXq+VPw55FIyVPUb93vyCA6PCDqX12Mk44cnZVyZCy4HuI95i45TAREjf1bGTnWxEnTwHYikC4K8qET8dS/69ugRdAhfmAefywRWM5Dr91Favuj9Pdguk72/YI7uecfdiuJDug0/CwxYSUYiAjxZzYNEmOlVVJU3FumbldNiiK82DRd3a+fMMn6wto2xhFNz+3AuKpaNDdCxu/pFC+Itlm5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cbjmv282qRaZtbW7SQESt++FcOX6vyW8jGym1KvQ10=;
 b=XwfZzZz2IjWh4rsJDj7ebK4Z3BgL/8CIUBNx5XlN9EgBZVju2zZnEZI8IZkAbypg0LSr8mR0uxDhAlxhtZK5yiKb3uYKRPc7iQbxkpMvl2unsqdhewIFh3vMX47e/EVAdzCqYxf2Uk9I73ek0dHss92CNHJ8LU4iKeP/sI/sbd0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6152.eurprd08.prod.outlook.com (2603:10a6:20b:298::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 12:35:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.029; Sat, 31 Oct 2020
 12:35:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH 0/2] Fix nested permission update
Date: Sat, 31 Oct 2020 15:35:00 +0300
Message-Id: <20201031123502.4558-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.113]
X-ClientProxiedBy: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.113) by
 AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 31 Oct 2020 12:35:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870cc23e-4648-4ba8-1fcb-08d87d996a1a
X-MS-TrafficTypeDiagnostic: AS8PR08MB6152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6152BF10385C8918F4F2610EC1120@AS8PR08MB6152.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8IRUz0cM8uMwvV//9n4IL0hTisV21JVUlcDsWPZFmd1Y1Ka0fYS46aDD6XqiQwjdNwNaQUotoSH7mZJLFGUx3CLRwrqCFY4bg6eN08u8hr3y8hG+Etnm7s2lheuOkDSMWxBYtDWCQM3D3cUfzOLTRaZYLRxZrwCWXVkcuQq5ZvPMvN7EdhHQjNcW0vTMT7jYtsUNY4S7CrN2gfad3fpHi/LJ/YzkZR8dyX7miW4aOblkXiIZuN7S+AwhkH800QEnAEuPZGolGNyYjXHBrmUs2SIYg3daxORuE6Is89/9SBWaNca1P7FfjorZNIIvnFGgZCdJW1ui6X6x86wuDp6Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(6506007)(15650500001)(8936002)(5660300002)(8676002)(36756003)(1076003)(107886003)(83380400001)(86362001)(66556008)(6666004)(2616005)(66476007)(956004)(2906002)(16526019)(52116002)(316002)(6916009)(4326008)(4744005)(66946007)(6486002)(186003)(478600001)(26005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QRTMK2rDoZP24BDQVsLU9fQUVl/2Qr5ONS2gPQ3crx1hHNSITetij03aJuNYeSCgijeu6JhoaA+xNks0jiZ/LUbQ2s6jNuzpiT12gsVN/k/yx1ZIcTj5HBJ1EnM+B+Q1SEjJiJln0qaJttOeiqu+/LxzufoA5eBoIZn/yhgrYDiEab3InM8OyQ1dH0uf7br5Bxyfq/O0Xwz31/15yxdG0AdAWyqPbExSRFbePBMUiXavEH4V/wSqZWUT37XwGWZF4XxXurMHL+7Rd3+MW1YYbYhzw2S/y9UiD/rNMlPSCPB2ub+fZKti8dG6SxSE+iUEqTHJ3f0qbnLyHzXDAVswi2QNbsZflHo6SZgI7UkHE7+arNEgTIcQtjKb1KyxsSfobJagqAHP6UBs6DFy3vIFkef8HPNWj6ro6T65fWOkeUeEtiSuype+UVVGs6a4NyytFg25R9X++F3o9tTRJXtm+/YX5ciUYb0255taMIRuCOX6RHLxir2LDA2kK5rIIJianW+jthdIROu3h0pyCR8D66qj+CnFMH3ui4ijbBpL1T0HnODkVvVSBrUEv/WZakVqe/VVjqms8H4f9Ajxeh2LmHOTQFn5dT2VOLXH0EwVQnuT7QfzaPnHqYOOKMrrt95SgdXtbbMOVNTPcQ3DyT4wng==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870cc23e-4648-4ba8-1fcb-08d87d996a1a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 12:35:14.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6L02VyZQs2VqM237oRj2dlwXk6SMq8pdGw2hwCuxNbholCVzO2K3FCqkBFVNIHcaiFubA26WED+SaM1FBzeKAH7s/MPyA/xlbBh5XD9kiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6152
Received-SPF: pass client-ip=40.107.13.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 08:35:15
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

Hi! With help of some assertions (patch 2) I've found that
bdrv_drop_intermediate() do nested permission update which in my opinion
may lead to unpredictable behavior.

Vladimir Sementsov-Ogievskiy (2):
  block: make bdrv_drop_intermediate() less wrong
  block: assert that permission commit sets same permissions

 block.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

-- 
2.21.3


