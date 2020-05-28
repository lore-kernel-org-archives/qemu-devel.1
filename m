Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E33C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29130208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dFQjDyRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29130208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF85-0004YA-78
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5L-000819-Ln; Thu, 28 May 2020 05:44:23 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5J-0002k0-Cb; Thu, 28 May 2020 05:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOS2Egn3bfH6nojYVC5xqkKRN1s3ULKmn9TM6QA34rts5VuVtDJK4q6JeQIg6U0PqbLVnA6kXxIUqY8yKrJtdzY6pQ5gMuypvHX/db39fEHasDspOB50WJfBI+zbTPqT60ONfQySUWLpOzlJTQmdPstnhi0tPRT1uhWA2H6ld5G6pehsSKAxvjB9CFnMvMjSt4e+hv8BgFNSchBvZMKP5AOAmWlYBix7eU2pilAx71GlD1xQi/PJbnwJdGwO+H351obXXis/Qg+8HHAvdraCfNMqTvlWvAP2XPuei7txAZQJE+sAG6J2dKC88giGOWLMkbGlosPVre1DeptfxJoMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7RKyG7Lv7j8ZfVHW1iNVi1k82366Wml5DByxru1Ow8=;
 b=OXPvM64Acz/3qKXclFMvH5KA0Z/Rt4YcmCg1yPM9E4NLr4YRDEOwQ0S8lZgOIJEnCQEM/UHZhGxX5+1pQ7fUdT4dNDSNRPQoumYCiCwMBGMVonBd2LaFFH+c3myEDzKnmOANSmiqRhrWeCNvfinbkU600sH0Guji8UFsT26rbpqV4tjyFf1UTWpTT6fIPNhgck883gh6zcxBPQzw8ziLin6Z3eptSfZdxfZ2QUPyYxEPghkl76rHqehVu/Pws7CRfY3BdT0qkASCf544mvJ1gkqE9lvwcLGq1f1MWcHqPZgYpv0SOkQ2UjxA83iLS6aMdQ1ml3LVFgVPgq71wDimrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7RKyG7Lv7j8ZfVHW1iNVi1k82366Wml5DByxru1Ow8=;
 b=dFQjDyRq64x0Ks6h/uf0HRQ4CxwVupx1L900MEerb+kriWv68h/eQgHjBjJChPBAp6lbOWiy+MPYlQymaL+dpU/6shNyaFEoXgFKZ26j0DUZEngVfWupqWojn6rYb1enxL5oC6XBVIPOifzp5fsJrobPs2HHHf51UA/gqHUiZys=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/10] drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:43:55 +0300
Message-Id: <20200528094405.145708-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:16 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3108b26-c39a-42e3-e7ad-08d802ebb085
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366E00BF85E435F1FE53033C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJBby08n/7UnGbQNTMU8kCwvzlPqv6mfc2kJYIJcGbsNSeXT0b11WjcwXtZdJ/YVXswpqiUElnHSxrvWJ3J7MuqJeuTdWVZqgJBdQPSXoAYteZ7Z8BjesLMsE7LtK3Mc6Y9dA19xQTM4lfdBcWqQscCxkuGUeYjTbM6f9p37JbCbnIeB6gsKYYXXu6bK8+n0TeR00zp0+7zg9w+qTPsmMjmJ0pY82I7zcAeLub3XhoF6orePNOhBWDGOTZC8Usx0XBzp7cACjMlzJWGRBdPAo7HxMQTb3Ax9+B/vNP/U9iQ3ybpn0Udvb4DL1+P9NLcsGYLnteWx9aILVW40QvvfbRRstNyIi2zZsIFkrKq7vkcqmYXAI7nqSaxQsa3ApN+4Qn1uyEhOG+vDhBqfHI5wPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(966005)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AWJa+HIPEymial7AYU8gboj5kQECfTBZ8jmTAqW2B2cPenqMJQQmOdjiWzUwGWl/on01hG7MCkl++LCgUP0Ow6s3ArVcyTLxrqXJYmp92L7KC+YKCV9Ky12U9+jlQO9rpWqNBu6y6L1c7wWKZ/Y3YRd4pPEMDM7diUKWdHURrGippNzvwodNh8k7aB+leH/YrEVUKGB+ovDDaA987V3Z+MQWAjR6MsYY/D/Ag2MdsWvGeBpLX69CE26Nk+HGPfPYc8tQYADiGUsBqj06P0fN8S0SpKE7TGOsOHcpKyfvH7eVsnnRn2ineMQJhbWUiDfPChXowgpHBmFwkazajh/EE1Q/wrV6YYFDCTgBJ0ryKWUDE8FLgkHQoPLkNHTSVVxq51Rm3kVKuIJpltwm9KcKqGqpRFuJYqm3DcpwxVQUXqelOTmeg8uL7NvwAWq1PIDpf1evxpAQVzzcXSmPl9hmgWvHa+DhPyA5L+LhYR3COdBq7PFPDlEvk7P4TA6jWZfF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3108b26-c39a-42e3-e7ad-08d802ebb085
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:17.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw/qqspRWa6codLmgsQr5mrxzCEH9yZoRl9b/a98UwqMgsc2SaDuTLFNkaUkKgd9TSKrDlwvMo8DdFRPsAXNUGfmjnBay2Rjp1CFJyHjCMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is first step to block-status refactoring, and solves most simple
problem mentioned in my investigation of block-status described in
the thread "backing chain & block status & filters":
  https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html

The whole series is reviewed, let's proceed with it please!

v3: rebase on master
02: grammar fix in commit msg, add Eric's r-b
03,04,09: add Eric's r-b
10: add my r-b

Eric Blake (1):
  qed: Simplify backing reads

Vladimir Sementsov-Ogievskiy (9):
  qemu-img: convert: don't use unallocated_blocks_are_zero
  block: inline bdrv_unallocated_blocks_are_zero()
  block/vdi: return ZERO block-status when appropriate
  block/vpc: return ZERO block-status when appropriate
  block/crypto: drop unallocated_blocks_are_zero
  block/iscsi: drop unallocated_blocks_are_zero
  block/file-posix: drop unallocated_blocks_are_zero
  block/vhdx: drop unallocated_blocks_are_zero
  block: drop unallocated_blocks_are_zero

 block/qed.h               |  1 -
 include/block/block.h     |  6 ----
 include/block/block_int.h | 12 +++++++-
 block.c                   | 15 ---------
 block/crypto.c            |  1 -
 block/file-posix.c        |  3 --
 block/io.c                |  8 ++---
 block/iscsi.c             |  1 -
 block/qcow2.c             |  1 -
 block/qed.c               | 65 ++++-----------------------------------
 block/vdi.c               |  3 +-
 block/vhdx.c              |  3 --
 block/vpc.c               |  3 +-
 qemu-img.c                |  4 +--
 14 files changed, 24 insertions(+), 102 deletions(-)

-- 
2.18.0


