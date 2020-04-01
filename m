Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD098C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8919D206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nt5b3Gn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8919D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJetP-0008DP-Kv
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJerz-0006HQ-V4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJery-0004AW-HF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:31 -0400
Received: from mail-eopbgr10096.outbound.protection.outlook.com
 ([40.107.1.96]:31205 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJeru-00046o-Fw; Wed, 01 Apr 2020 11:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkdBm7sP5GkFH6o/PiEnefcIry1N9YUhBRy7rE1Ud0V2GxnjNPb5JCyLHYLtNP4qIratR68EwnqzLv9AXKCcpur+13A0k5L0vAAP4OZX3BNLN0OQoDytnno2IRrMMMvYRYx5VSwRudMjl6P029QYYMKkGVdHWb5150vyhWjgjDV9ZOhuTBWwhdP+pMpg6/f2BclWdzJGp7o3uKn0ElS3iosMggjIHetLbNHSSvHV3dcU2LgGczHeEFNydQH8VcxQtfta/ulRbAGr9Lgf7qyOfMwSjiY1LVaMvFyUiz8mG1IGECBVl+Bo9Xf36rtssPRJXp9ayc+Aso+6AyHX1z22xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/tXF1MoMA9n97SlQnpuWzI1A23XwPQ6pQKExQ1EPe4=;
 b=mxm8W9bYvM86wBnYOcS+wxhv3XYjmttf4cksIODnNeBcfNIyeI6/XBFdJFuPToz/3f3nhJ4/KMA1XbvJDCoCzfE3/TyH6H3j4dizRwEAFxTvF8TnN4rb8oq4gvga1tWCiW0lcacozHl51d+aE8S1kwUEzUIJhXMC1i4ACYdlJKwZUKZKzV3FVMrcn7xSjQ2aNXEgp5FzhfBpH2mEhYjT8w0YAVf2IZz55HdV+vml+Zo7mQupAsCegv6roDVyHD5ugZ/bNLG+Gy7pCgdwI8ljjZsbppco0O0MEPF1Ax09owbvu8vzM/tOvMEyAI32gkMf10WnlH/1389X+5ylgWEhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/tXF1MoMA9n97SlQnpuWzI1A23XwPQ6pQKExQ1EPe4=;
 b=nt5b3Gn7gJlUwQgXyDbStqujAz4OlANOfposkz7/prhGmh7W4LmC4+EI8Aq8SF1/B+avUkc2dHZvYRTMO3g49uYgl2NLTUdVyEIE1MIOslJzcdtP3XfgQ76QXdwwQr1gxWyh97R2KxqNC4+jCHBqUDIOhbr1yavhPiYCoTeZ9G0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 15:01:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/6] nbd: reduce max_block restrictions
Date: Wed,  1 Apr 2020 18:01:06 +0300
Message-ID: <20200401150112.9557-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.23) by
 AM4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:23 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09f6e57b-7ae4-4849-c57f-08d7d64d8bb4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54947F877633AD06893C88F9C1C90@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(39840400004)(366004)(66946007)(66556008)(52116002)(6486002)(86362001)(186003)(107886003)(478600001)(6506007)(4326008)(2906002)(6916009)(16526019)(26005)(5660300002)(6666004)(316002)(966005)(66476007)(1076003)(81166006)(36756003)(2616005)(81156014)(8676002)(8936002)(956004)(6512007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MWIH48cPsUoaa6A5Faq9WRLbAiXjJZd+ZGgK0cxFciV2YqSHRqg/bGXqzFv7r5Qnjm9UBhQv1GRql+N2Sgn2rGtlgCQww6ionJjCGETknEftUlzBc7aj32xXC2ohXLh5ryL/7POHP6cpFFzdlxhvxroPXZJxTCNuzs48G20tJLOtOWM+Dg+4uZN/nsreR7mfnPxPzSBEUgY5TAfE+9BzuePaz6hBNxygeN1Y4yomnT09kuEy7YG7m+gh+AXb47BLES5svT5O8m7C/tvj3RuqPWUIea9DfeRWo0/a65BpcObYTSYixgwsaMO3CE4qgW4N2Dr8+/LlUbA055kpLkopJREmmMAqXir4NyQhFs/izVXWIEvT9gR+GXHyCNwOfMdEUMOKwSk1EL5Ci2wutu+nNVEz16NKlcknO1XwK2/3/dOJ8LHQb8c3RMbjmTNTrRFFO7FQItekNtxo9eLiFQpeyVNz1u1fT15Ll474G0OpVlS1Gx15zTuiTMI6IpgNkX4bIwGPMtQyT1ASWN/aZyABQ==
X-MS-Exchange-AntiSpam-MessageData: YOya9huRcSsCNCFkGq6xOdXQxoj8DeoyEsrMytCX0QfQpfzeSnA0HVDk/4JPScwQlur+ypNGhHK3rs359xmF0kQQfm5fnH1R4FTE1dDePWVkucI0XcmbILy7NFBoD+LVw4cmzDM4oD4rbXc8Bup2aw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f6e57b-7ae4-4849-c57f-08d7d64d8bb4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:24.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulu6QKwOIOZxO3i0jNqQrL2eFZrJHDQrP+UdJedziVF55kEI9QxZBg10G1nHCtIcmfu0YAdiZaPat1cqJC5cimC948jjuQH3ZkpeMmCMZlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.96
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent changes in NBD protocol allowed to use some commands without
max_block restriction. Let's drop the restrictions.

NBD change is here:
https://github.com/NetworkBlockDevice/nbd/commit/9f30fedb8699f151e7ef4ccc07=
e624330be3316b#diff-762fb7c670348da69cc9050ef58fe3ae

v2:

01: add Eric's r-b
02: keep INT_MAX limit for discard
03: s/max_pwrite_zeroes_no_fallback/max_pwrite_zeroes_fast/
      (a bit shorter, so that if condition fit in one line)
    default is changed to be max_pwrite_zeroes,
      so blkdebug is unchanged and we need one more patch: 04
    refactor max_write_zeroes calculation in bdrv_co_do_pwrite_zeroes,
      prepare to last patch
04: new, actual change for nbd driver
05: reword commit message (fix -> refactoring) as I don't see bugs here. Ke=
ep an r-b
06: rewording, grammar [Eric]
    rebase on 03 changes

Vladimir Sementsov-Ogievskiy (6):
  block/nbd-client: drop max_block restriction from block_status
  block/nbd-client: drop max_block restriction from discard
  block: add max_pwrite_zeroes_fast to BlockLimits
  block/nbd: define new max_write_zero_fast limit
  block/io: refactor bdrv_co_do_pwrite_zeroes head calculation
  block/io: auto-no-fallback for write-zeroes

 include/block/block_int.h |  8 ++++++++
 block/io.c                | 39 +++++++++++++++++++++++++++++++++------
 block/nbd.c               |  7 +++----
 3 files changed, 44 insertions(+), 10 deletions(-)

--=20
2.21.0


