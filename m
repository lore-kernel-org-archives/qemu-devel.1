Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A036C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AA020674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GrF/wLDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AA020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytJt-0002xc-BJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytIz-0001DE-Es; Fri, 24 Jul 2020 04:43:49 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:40593 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytIw-0008Mg-82; Fri, 24 Jul 2020 04:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxHcspbE55CvIFttnJCv1ceJJRSbWyxdvcVlYDXYx/RfP6ugeqOVSqqYhwY0ATjQnjGoGbh6mU5nQ4k12c62EEjHn/Sr9X7SjPB+U8C04w6vP7+dJ+IWrvwNhXRhUKfNYU77hsQFssUfEQbhst0t0SWDe4xX4LV8tVOx80edXVbSH25AcexHbgqxTJB/pW/yM7h3J/bWHtpMmLAQ6f7KDZpfQxPnR2dYXlJC4pklIPTvtKjuNSdVm3ceyHI4KwHysJW2B5Y7YOK7XS46WhWNDag1Q/Aell2zkGsxXqBzcF8uNwerRP98XqTZWQW2B0v140Te7Q9FkQul5RfBKtkyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe/YtVggd7RjbCp0xdBBE9wQB0QeCaPngMdgujjjxXQ=;
 b=Qqz/OPKioASWr3jRxryUSrIVPVOeQx4d6SoW3TQobd7kuO4p5JCrw5ce9g1jMfVtFHzFmJlDxM/6d9dX130c5jZsiMxpKYZpXb3tu2ZhL0g0438Mu+TSVsZzFlq25RjE9UoqBE7DVUw3DoFUikBDTd1QD3C0ur0vvU4cjEtLVtAylxhyFudNu40s+zdMqZnYiuH58mpvU2hzMuZGJMjpaHY01cRnV/9WaweXoeSiTc12tu2jFLM9vAklNODDCkD7ElNo0KMpgPXtKa6t1JejvpBeYZlNV1O8PimqPn7bxR3k6CaDkmMVay8DQdOH+HBrKvjz87Cy1XETJ+OZB2M23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe/YtVggd7RjbCp0xdBBE9wQB0QeCaPngMdgujjjxXQ=;
 b=GrF/wLDfQD9CBzdGza8XTkobGLhG6bANjJqVO8FvUYIZGqLk/HXnHO/R3Hq6ilcFmCJYgXpADc4OkJp8aTqwHU6kzKaCCtTkiR/aU9aTRBpnMjPTCNKlPeDXO/3ALL+nq7mlahVEE+WV1L30qbVasznWX2ZeIkez50JnEpIpGZQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:43:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 for-5.1?? 00/21] Fix error handling during bitmap postcopy
Date: Fri, 24 Jul 2020 11:43:06 +0300
Message-Id: <20200724084327.15665-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8158ca7-9188-4cf8-b1d4-08d82fadab73
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB484965173C33A117C7DEC930C1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4teDCAJoLpJ+rdGjyA1f3cPd45OJ9Ocj0oRg1J/Y0mxqa1X+7vUeutCbf4NN9fn2np69NTex9GDHiODjGXPWayM8pqWotex2xJr01kDmkKc1k5/X9lhJ5Wqcw1T+4d5pkJgn++giW8sQm5SMryuvDJHRoo4RnkXH4rM6bP8v1Kn//goQrhj9+xvA4EhTl9H28x1ISKyH7osoLyInkOWDzr/JGbf6KS7399sbSeeEMxQ8RKYVnNe3Sp6NVYuZZju1OcxYjCMomuCV46boRd1v+AM6RktucrnQvSTZ1Vmzkr6oHn/oEXC4TnF4zTMQVusfG+WvZbNRGW9+nknGnoKt89CRTuHcjJ01DraGBCd1JXM2D18jOhqfJR48zuXQQZDy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zLeYAwV5BYXdgVe4W6cEVkVsNNI/QowZxNjIGC1n/i3HdbRnIaR4kO2cN5AMguzoafz8QvtoQoRJAsT7EcOy/YdzsYNXP6PuGf3HhoGSyDWDYECEYKQqf7gTWPH0qNJtCNnh/j6RsYzTxDVgZQpePCjbx003vMEO0zdKqAmj1bVT3viZ8HYsnEV0tUJ3xRiTiB7miSOWWJrEgEwvJa2ZZ8/0VatDbH+qK7/o8QQnhw8MO7hcxiFJWrx9tS+CRtyGNgH40K138qns6o/LYa4EqcVIL+xWWrFzHI2ccqhwEjBDBkWt4W2FJpduL7JYztpLiqorF82npjhYK25TpiS1TquCyQjbMJDm97SXYPJIewFVTOkTEV7sArgiDNhR4X8nCekd526v/T6n6ACRXiTDQCXM5a7X+Y1LI/UqOELPVSZdwCMtx/dBf9sCva6nnodiOxm5HzXBx/0fKoBUMvtxtJxLeo/SvElE0lDgbfgd+r+Mf6FgPl6W3fMqPAdASSW0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8158ca7-9188-4cf8-b1d4-08d82fadab73
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:42.6712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8REhRlzMK9OXTmWuU8TOFPoo4elUthBytLjIYPhgqV3KdJTPFvsRm+4arO1xs5z/918toNI3qR4dJh+wN4kBnyqUpYLbck3B/2RYrso6xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:44
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
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

I'm resending this now, as Eric started to review v2 and it occurs
outdated.

Last time it was somehow postponed, and I thought that I'll to
rebase it onto Max's
"[PATCH v2 0/3] migration: Add block-bitmap-mapping parameter"

Of course, if this goes into 5.1, Max's series will need a rebase, sorry
for this.

So we need to decide now, do we really want this in 5.1?

pros: it fixes real problems
cons: - it affects migration in invasive way. Still, it may be not bad,
    if we double check that it don't affect migration when dirty-bitmaps
    migration capability is disabled (the default).
      - seems, there are at least one more crash which Max found. I
      don't remember now, if I reproduced it on top of my series or
      not...

If we decide, that it goes to 5.2, than again, let's decide which series
goes first. I'm OK either way, and can rebase this series, or rebase
Max's series myself, if he will not have time (I fill responsive for all
this mess, sorry).

Max, please look at this series if you have some time, you are familiar
with code now.

====

Original idea of bitmaps postcopy migration is that bitmaps are non
critical data, and their loss is not serious problem. So, using postcopy
method on any failure we should just drop unfinished bitmaps and
continue guest execution.

However, it doesn't work so. It crashes, fails, it goes to
postcopy-recovery feature. It does anything except for behavior we want.
These series fixes at least some problems with error handling during
bitmaps migration postcopy.

====

v3:
- 199-iotest improvements moved to the beginning of the series, v2:0018 already merged upstream.
- add r-b and t-b marks by Andrey and Eric

03: rename same variables [Andrey] 
05,06: update commit msg
08: some changes due to rebase, still, keep Eric's and Andrey's r-bs
11: rebased, drop r-b
14: s/,/;/
15: handle cancelled at start of dirty_bitmap_load_start()
17: Modify error message a bit, keep r-bs
18: Rebased on 03 changes
20: add comment

v2:

Most of patches are new or changed a lot.
Only patches 06,07 mostly unchanged, just rebased on refactorings.

v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps postcopy"

Vladimir Sementsov-Ogievskiy (21):
  qemu-iotests/199: fix style
  qemu-iotests/199: drop extra constraints
  qemu-iotests/199: better catch postcopy time
  qemu-iotests/199: improve performance: set bitmap by discard
  qemu-iotests/199: change discard patterns
  qemu-iotests/199: increase postcopy period
  migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
  migration/block-dirty-bitmap: rename state structure types
  migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
  migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
  migration/block-dirty-bitmap: refactor state global variables
  migration/block-dirty-bitmap: rename finish_lock to just lock
  migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
  migration/block-dirty-bitmap: keep bitmap state for all bitmaps
  migration/block-dirty-bitmap: relax error handling in incoming part
  migration/block-dirty-bitmap: cancel migration on shutdown
  migration/savevm: don't worry if bitmap migration postcopy failed
  qemu-iotests/199: prepare for new test-cases addition
  qemu-iotests/199: check persistent bitmaps
  qemu-iotests/199: add early shutdown case to bitmaps postcopy
  qemu-iotests/199: add source-killed case to bitmaps postcopy

 migration/migration.h          |   3 +-
 migration/block-dirty-bitmap.c | 458 +++++++++++++++++++++------------
 migration/migration.c          |  15 +-
 migration/savevm.c             |  37 ++-
 tests/qemu-iotests/199         | 250 ++++++++++++++----
 tests/qemu-iotests/199.out     |   4 +-
 6 files changed, 535 insertions(+), 232 deletions(-)

-- 
2.21.0


