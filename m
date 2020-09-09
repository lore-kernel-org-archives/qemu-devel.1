Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3234F20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D7Tkpu0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3234F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5LJ-0000DW-6G
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K3-0006rl-2N; Wed, 09 Sep 2020 14:59:59 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:14387 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5Jz-0001M1-H3; Wed, 09 Sep 2020 14:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJMHpn30u4SwWG1qXBBvm9dKD6PoCUrrFOCUEZMlDvhJgAulFVGE8qO04xG5xL7Ts/RAVGiWC8xcmyRYNybM7GEftUEEOlcwgbhJMZ7Y3eikznvMEour7A2Fc7qOXKgDLo9e+JfIMX8tRy2HX2QvkGhfjqbA6lykmOxjAOrK6BJmg/o6njzSIschq1BpZl2L8VRgyiYFF8pa9scSGZF2NupM/xzFNWq2hcxr4EGBR18Qlj+qZXeFg+4fq2b4Rjgk4k8AjARkV4OHXasITfwBEeYHgd68Y+FLUrmGu0zZngtBgCZ6JHWU6kDyVcyIN/RkhbMDX5UUR8tpM19qRlprMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmo0hyIg1IZLlpBd1NVw8Q7AnAjEni7ySIS4wnDLXyE=;
 b=WvORO/6Z1Xsrv8Tr2HxHB3lwFR93T3Nnd+EsgPTx09TqT7Y25AP9FTeXYuR9g6nQaEVBCRMn092JUqj3vp98PkLgpdPzirClG5Gjmu5vUehOrXv9nVenMdzHrfRoZIeGmkWaGyQ7MgO14dSWdh16nGKxKMWmlgr60EhnPIKtZ56Vx2MBl8V1A+TwcBoE+fWP0b7HBTimkJubcQqDjTnjcL/IsaqNsk5ev9sR771xjtyZVJbEtSlgbrFAGmnjD6CbNrANnJ2hNsqgHCRfuFAX5DRsECrEb2chP/9w/Y0d/U347iP1hwPik26lsoYht3rDwB1kQX6QLWlqRb1EjLY25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmo0hyIg1IZLlpBd1NVw8Q7AnAjEni7ySIS4wnDLXyE=;
 b=D7Tkpu0VNIQaYB4dl1yRFECQfEPV3rX+W9ajaWVBCH2C6pXFiKUVYtpXB7h9liMsMePKmKKoOn0OmiR0KV1mPGDdBZ+8bDZus7wgOmpNEPknYvK1Zs+Pz7iGWQ/HJjiJydfhC+ZKQf0wj6lNtDYNg4b4dooXCWfzpLM8D2chxpw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 00/14] block: deal with errp: part I
Date: Wed,  9 Sep 2020 21:59:16 +0300
Message-Id: <20200909185930.26524-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:49 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb1faf6-b3df-4474-167c-08d854f28763
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34451C92B03CDEDE849A7A1EC1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8i3RRZW+tTMI2I8atd7QNHPckM2ooZzMMmcUZeXbJLdH3Qe0QNS3NDW1hzrMJZpFVrufp5Ejw233qYN2lA3t85a1nK5+aLncsbcvrMlMh01umCk6CsgAEn2icsjWBwUakHysdyFjsPJDQ49ukbmjGmBSzemdONewqkM/r7QRNitem5te59w0l8JsWe60EIoik1NZP2fWSocvw1aVHl3zVYFh/9WQjpG9MuEMxn/kvMk53QmtMhWsVpMnvhFHRkD2uxqqzFqATreThW20dvKNHYszl76Yfz6N79IMhHfmyaVGqM8fBD1UuF/Ivu/CxTSxFjmCVuw291zjJQbYiTAhFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rDiu1c815Vysc8PA8bVGu3vMkAj7TeQihZ9U/jmmcUHRSjUStNLC+TQ95y3EYcgtQ24lU/9/wuLFGWhgd2S8tTzOC2WPxzeATKG60AGIgm0toNo3Z3lyo0ZJ8KeOO5dDE+jRBx8B4loVN7C6DAA7ltAF4j/9rx/mMjW3xXAEUwaj9CHr/SYvkkQ3FYbWYFV1czHKh9XB489T2NB/4SUPXGKQ2cUjEyA+FcM3oVgkmCR4eqzhDC1u9q58Z2G16CRUbFvRgwjs9diwdmcvA1t6X2zYqYGDqDcYF8sqoNykA6c/jLhqtJYfo7AxYVFVy0j8kSuoCF/+iXtWD75upfN/5bcZVvcrN5WqILU+2OYgNR8cHxpGwfEdOZc+tPfccYb4yid2QtV3DhTpgRKfEc6Gw0ZAlZKSbiVI4rjEwb0QClbZktwILef+nh8qYrXe4h81TDEzXxhWEW6XzGUUE5tmxR/AQjHp5IPsWxMNjp8GXcwwZIkFCuluQb+2lsw/dNPQv8yOTV/RAXsWH1MjHt4FoufSlm1h6CbF1/Umg9VMtJSJ6Cg1SPk4fEUedZki12/MxMcpw9OWkyIQDePhcrCcgJImW+fR9uNpu3lgJPriIr8kY7HiPtjEIg/vboCpAvJ6qdAyCUkXdDYCG02g4Ai5aQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb1faf6-b3df-4474-167c-08d854f28763
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:50.5621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9UoVVJZsAaybllkWPkpnUELyAQVNFcwsOB7koRp5q2RnOo3N3qc9tnNKGfVcaQoCoqaNjoyzK8ktunEQS8gyZ7wCiSxgAiKRTeCXpTpID4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:51
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

Hi all!

I've start to apply scripts/coccinelle/errp-guard.cocci to block
subsystem, but it turned out that in most cases error propagation can be 
simply avoided. So, here are some improvements to block layer error
reporting to avoid error propagation. It's not complete, so its called
part I, I don't want to create huge series.

Vladimir Sementsov-Ogievskiy (14):
  block: return status from bdrv_append and friends
  block: use return status of bdrv_append()
  block: check return value of bdrv_open_child and drop error
    propagation
  blockdev: fix drive_backup_prepare() missed error
  block: drop extra error propagation for bdrv_set_backing_hd
  block/mirror: drop extra error propagation in commit_active_start()
  block/blklogwrites: drop error propagation
  blockjob: return status from block_job_set_speed()
  block/qcow2: qcow2_get_specific_info(): drop error propagation
  block/qcow2-bitmap: improve qcow2_load_dirty_bitmaps() interface
  block/qcow2-bitmap: return startus from
    qcow2_store_persistent_dirty_bitmaps
  block/qcow2: read_cache_sizes: return status value
  block/qcow2: qcow2_do_open: deal with errp
  block/qed: bdrv_qed_do_open: deal with errp

 block/qcow2.h               |  9 +++---
 include/block/block.h       | 12 +++----
 include/block/blockjob.h    |  2 +-
 block.c                     | 50 ++++++++++++++++--------------
 block/backup-top.c          | 20 +++++-------
 block/blkdebug.c            |  6 ++--
 block/blklogwrites.c        | 33 +++++++++-----------
 block/blkreplay.c           |  6 ++--
 block/blkverify.c           | 11 +++----
 block/commit.c              |  5 +--
 block/mirror.c              | 18 +++++------
 block/qcow2-bitmap.c        | 62 +++++++++++++++++--------------------
 block/qcow2.c               | 56 ++++++++++++++-------------------
 block/qed.c                 | 24 ++++++++------
 block/quorum.c              |  6 ++--
 blockdev.c                  |  7 ++---
 blockjob.c                  | 18 +++++------
 tests/test-bdrv-graph-mod.c |  6 ++--
 18 files changed, 159 insertions(+), 192 deletions(-)

-- 
2.21.3


