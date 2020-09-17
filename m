Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFC1206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hPyJ1/Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFC1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ03y-0006KM-H3
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00M-0002c9-Ds; Thu, 17 Sep 2020 15:55:42 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:28615 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00J-0005s0-0k; Thu, 17 Sep 2020 15:55:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAz8sLrpQKqqS8JKT2SrLbuJ2M0R01mugW1w94mjwNLIPiIfOS+XlxWEvlLa1unFqsH/RT0OFiGIBrGgVT5nhN3Z6ieXYDd60pW3V/7xHDbb2NOO+Et1I7Y+NDAQt/xQpHvLVkUte7HwM1Kpr2Y8xndtfBimJaLcPzCxrXIlT/IB8+lBt8R8FIW2vOlXt7Ub5AvuwSk/wzWHM1wmPrwWLLHTWZ3EcpKy0v2Xs2TLzjn/pxHg8V5spJZXSQCwgHIHFMPGtkz59VuuiDQH8a/0gmc3nOfUqrVKZaXxxh+jDq5mhvFKp3VqUNjOGaHk4xuY0Nd/c08MOwe+aKMFNBvJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C19+tN07d3/cx1e38pnSnwP7YBdKChdSxkIOIwhp2k=;
 b=DmFKwFBLToi0Uuir9M4+vMNyX+sYbtbAfm/IAnyyJrTiOfvb2ljfwDNR9sVamO0vVnSXBH9cmsti5XDCHzJ6Of6X/oS6p4Sf/SyfPK8FjJTKH7qtzcNBlsOOkFJUQMDfjFtaeYjGGK3Q1xofk/a69krNlMXvLaJrbD5/Y8kwM7P7bkMBWy55Ol7F6/v6jqMsUMs/oPjEZ3zWwC4RFs3+bBr+sEis9wAxxlrwdcyL19/x99xRsh3cLu34PA80/gtqdaynMsrjaRrnKqLTxcTPLNyOgnaOqdX6omCJX37+kaz5w3mYPySBfcuAJ3LfF4nGU55fnj2YWbqp40i6wT/PTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C19+tN07d3/cx1e38pnSnwP7YBdKChdSxkIOIwhp2k=;
 b=hPyJ1/Ry05wrhs2JEPuKDHB0pPFCucp5O598KN4cUAbtz184PZVsvKlHQppdvGZA8PAkMEj9xpklGpRn0zcjzvEze/WnsCYAePfGb2Nuj/1i1kVlkdGRCvhXxHFu2D8xN3bqIUSxuAJnQfvT2d77CxJk96Pk42cx5bZi5YdaVSQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 00/13] block: deal with errp: part I
Date: Thu, 17 Sep 2020 22:55:06 +0300
Message-Id: <20200917195519.19589-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:33 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f572dcfc-785e-4316-f0b1-08d85b43a3e8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303213E1F2CC6BB65728A03BC13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh0SlaPPozzkqBR9uUz11PxRLbLJw1qJjaS1WaRbf+KGnN2/v/OtI8bLPlFqLpCMjBInvadp7PXn2E41AkJsrL+9893v7np8KBT2NX1x89ugaLc7zOfQXMGAu6t7JTQeelTCGWqcB1IW9Cqkl1uMC6t7lEG6RahnS1Ok6gNh3j5ge2RWePIV9x9rGnLzxSfNzfxQGiFUHli06X0GosWbqYzMlRbT5j6LOYDu1CIj48HzxDEfJjM6tbKRKqBjhGqeJFAIDgT50F8wGg5qV9HQ6+FYq/q6gP14c2V3ApkLL2josiRXBshz90VF2x7YsdXBdtViiY0cpBBt7RjgoLDWTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VMKg2Nb/eidZJ/uWAvlPrVnBz30yIUvejBTHFb53DYps3e7HB/jDnOVOEDbPMBS3znfuYUBjPhpvEKFuA6g7QK4Ab7P7n4QBrExaB0le6SbmdN4gNrtRWX0plRyCHsqYGBCZjM81PKPT//lORbw5YVMzzkG9CsxUiXwCqFuPVSR7fatz7ZqnzrttUFvthhzaenh+6LSjqIsG9bANY+xCLscQENIBMAmVz0TYzPKjOVSGOHyD+ql1mHyIA5+S2ehl7DPszKnPTl+e7M0yGI9biTEgshXmSpsHzz3N/iYx3TJ6yO0n786TnhiralpCvn7ZGANIIT1gAkRPfL4u8Rl6whH2SaWpMjdAESPEswgsS3oa0jHnzHflwxvy/c2N33sMQlzVgNpw699v4JbmST43JAvnZfoUHTVQe4o7qdRkzi8v7+AUvhANKnZc3WKyzV+2gDVsdqceyVK6luF5bmXsmv64rHoZ0IxO+wWh3p9H3Cj4a5l3KoY8vxh3wLdEZpqJReLMo2DzBimGDsIRfK/8Xvucp/tz2ufwHUbjMhZ/Giv/3YP2ZMbiOCxomIBfENYmsSPVeQjkdDrmzX1YU0z+EBBhHjl3fruX5wKS/eee5MB8m2xbeLSHRoyfW+ew+ilh8Xl/Zf6TdRO/s5dsHAayyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f572dcfc-785e-4316-f0b1-08d85b43a3e8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:34.5227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPwmx339QIAHjjF9zkFL0i9je5uJb76BlNVCwR/HQfGqcO02+LvzW3z7bFg3+gXAyJuzYvsHw60MGB9aFTgrj6Q0LmrRdlzw16Rhoo9YwU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:36
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

v2:
01-07: add Greg's and Alberto's r-bs
08: fix wording in commit message
    add Greg's r-b
09: fix header_updated logic, add comment, drop unrelated style-change [Alberto]
10: - fix commit header
    - add note about ERRP_GUARD in commit message
    - add Greg's r-b
11: add Greg's and Alberto's r-bs
12: was "[PATCH 13/14] block/qcow2: qcow2_do_open: deal with errp"
    - drop wrong update of qcow2_do_open() (and ERRP_GUARD() fix
        for qcow2_do_open becomes unrelated, drop it too, will
        update later)
    - reword commit message correspondingly
13: add Alberto's r-b

"[PATCH 07/14] block/blklogwrites: drop error propagation" is dropped
for now, as it needs separate small series.

Vladimir Sementsov-Ogievskiy (13):
  block: return status from bdrv_append and friends
  block: use return status of bdrv_append()
  block: check return value of bdrv_open_child and drop error
    propagation
  blockdev: fix drive_backup_prepare() missed error
  block: drop extra error propagation for bdrv_set_backing_hd
  block/mirror: drop extra error propagation in commit_active_start()
  blockjob: return status from block_job_set_speed()
  block/qcow2: qcow2_get_specific_info(): drop error propagation
  block/qcow2-bitmap: improve qcow2_load_dirty_bitmaps() interface
  block/qcow2-bitmap: return status from
    qcow2_store_persistent_dirty_bitmaps
  block/qcow2: read_cache_sizes: return status value
  block/qcow2: simplify qcow2_co_invalidate_cache()
  block/qed: bdrv_qed_do_open: deal with errp

 block/qcow2.h               |  9 ++---
 include/block/block.h       | 12 +++----
 include/block/blockjob.h    |  2 +-
 block.c                     | 50 +++++++++++++++-------------
 block/backup-top.c          | 20 +++++-------
 block/blkdebug.c            |  6 ++--
 block/blklogwrites.c        | 10 +++---
 block/blkreplay.c           |  6 ++--
 block/blkverify.c           | 11 +++----
 block/commit.c              |  5 +--
 block/mirror.c              | 18 ++++------
 block/qcow2-bitmap.c        | 65 +++++++++++++++++++------------------
 block/qcow2.c               | 53 ++++++++++++------------------
 block/qed.c                 | 24 +++++++++-----
 block/quorum.c              |  6 ++--
 blockdev.c                  |  7 ++--
 blockjob.c                  | 18 +++++-----
 tests/test-bdrv-graph-mod.c |  6 ++--
 18 files changed, 150 insertions(+), 178 deletions(-)

-- 
2.21.3


