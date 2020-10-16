Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1532084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C/WYWYjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1532084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTII-0004jn-GU
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGB-0002tz-8a; Fri, 16 Oct 2020 13:11:19 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:3705 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTG7-0007Mv-FH; Fri, 16 Oct 2020 13:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emi435Hg6AQLyT9AykWXrkn3mYep/sBY3tsMfAXh1F2bfJmsM6Cg7NbHGw5rLFxbtZPEmo1wtsbTGkCsso0QvbR3OOTNlz90rAvYtwAP1ZyD/1vPd1JsbZzVWw76crJHQJXiqhLK/aCMOrqBTwfLmN/zZEEzwH7RsMnQBJoC9Wupr2aZqY9Sy84L6L5J1wYkaMJ0/69kNQAzpyVhA67fvNJ2j+lwS2cndZHY8VtUbiLhDnCyb0HbbORp/d1q65503lrka9kP4Da7oDiC7IyCro7LSxVnuWpykztHtGDxQvgmFOXFSKURGdZTTCwIuBB0+D4Lyg3K25CL5ubF52Qvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRsNM4cuq3vUj96l+SDYDQaQmCXErz2vGHfcw9xJHGA=;
 b=LMaUD0pjPIx+aapdf0QPEkLiyBQMPVdQ0nfEHv68L9Mol6Sw+HoxW4btZjbeht9vuefWS2A2Y7gT4GzX2qeyMItDgRNkLPq6T7od612OfB3q4mrKfh0bqZEy2zFG9wOGGXt5znBhcxXCGVsvpn7L++dgnjFwX2AedDvNZboKPH03HpC5olgjUo0gcY60h3++lOPTPgXh3wT7XmzwyfEuzsHwDf2g1QW8MDusAycimyPIXwIawR/3AVIWpLZSnKQRpTyLC1LB8+JwZPqj6Wq3q1pK+iDNtUALoAIDxTiBCVQtx9to+nwXF8E4GvUTJo0Lj0kkcdentbvgiUaPJb1A7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRsNM4cuq3vUj96l+SDYDQaQmCXErz2vGHfcw9xJHGA=;
 b=C/WYWYjrT4KnSpg1Cak1fUTXEkXgIfPwrN4C/xPiVNvzgYf6zJhEzdUq9zqGSBo6SEd6N5aq0Q7ecCM1Ys6RIEJN+tCNzw5KhtddhatrPqzQvV9hVYSClELXrKpcrxXPV+laRdhs7n6rW8DnFASi1T6N9BpJisnGeYn0b8wNsgw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:11:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 00/13] block: deal with errp: part I
Date: Fri, 16 Oct 2020 20:10:44 +0300
Message-Id: <20201016171057.6182-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34b55f4-12fd-4a41-59c6-08d871f67ae9
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19727715A60E94DA83DA5E62C1030@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R704EhQjkZnAt4mFH4WQFAxD465nhQtyCY+MJgIPmhLK9DdfAkgH+x8nM+qXnPJ4jFD/nCqyC0FVPwj6aG0yjCY376A11MUJ6Xd5sXQ8GFxs2Ns2ZIqVdsb0UJHTOP07m3Tw4kYYJGdfzts/WqDwMRxyLeOyCQQvC5iNFieFF/9FaFAHX6gStCBFL4Io1T1N9uNB/mqj2nnbKuW6jXmXYpldWL8BcDcec43kRw0poKTWi5FKTR7GXZxvbqCRNkVh6HF5mvoEH+u5aH7gxI+fDo0DWPSWI5Uji1INeb+Dt30XiKUkVK0ncvGuYE7Txr7n7ZdtCCdTKYCXLmrn6vhh06T8vfTQftIHmZqD0dp3RJxf4IPxOMBXPuQh4gaIt3Z3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(366004)(346002)(376002)(136003)(83380400001)(8676002)(8936002)(6666004)(316002)(6486002)(36756003)(956004)(1076003)(5660300002)(6512007)(86362001)(107886003)(2616005)(52116002)(34490700002)(66946007)(2906002)(66556008)(66476007)(4326008)(186003)(478600001)(7416002)(26005)(6506007)(16526019)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bPMSxeVWceU2kEc63rFaam4WffIOLULNY2PKT5uwJ3cgWpEJ0GcMLYgE+4hSDD9eviQAKrPtOnfbO2l95ylxiJRyXFCHZMyNaWwci40iy7kQkYpEQVVLxxllQbYP1vTqghMUUruqmyyESLarQX9jEciFmGuApMlDj14A0xi1bGz4z5F1ByPRyrN0pwM/MryCANGXnTii0nvX89FPaGVnLeeJqnmJcPoyu9bBC6sAN4rg12v0qojUXtHFfDhkFaAeHZgt1jQ7+nCOSyAsbhGlgLYp+Jdo216iz2R3btst0ATRadstzZ2cTFdZbwp+W3/L0NIFiQrUJkmT4pY8Sx2Pg4jVMernaeVKAfUq60lhZtZkiyaUpYt83BD/8pjAwQSBU1g3WtdUP87adNigjr2IEdXCYmPr/FUMV8ML1jZ/k+r736vQ5aF7OzztWTK8eSlEdMj+S+Y93aKSAOjMGk8tlDVziFZHx008BjZAh7ZQLF3x/jgP/KnEwsF7MAnf9G6RSJ6Kf1V+a6dEVFluzeaVpiqBBGYORPzVfjsqIEVNKwtA2OnPFfAugcBs0F2X9jA7ah5VphPfbMDPrSDGzi5lUUHE5dwwbgXChMuLtC+rKJG+T8fsGBgMwv+9949n2Oj45+XbOAbNisMaowYRUdeQwA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34b55f4-12fd-4a41-59c6-08d871f67ae9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:11.2295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdHYJY741/YMy6W1+MJtjYEJYIc3KjyH4Kvgd7PyKfMMaejmm1MoK8OlVxStRY5cpGOncG1b2CwonM0kFEscdz079wbn2ew/X01g+NwpysQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Received-SPF: pass client-ip=40.107.0.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:12
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

v3:
08: update comment, add Alberto's r-b
09: update comment, add Alberto's and Greg's r-bs
10: add Alberto's r-b
12: Update commit msg, add Alberto's and Greg's r-bs
13: add Greg's r-b

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
 block.c                     | 50 ++++++++++++++-------------
 block/backup-top.c          | 20 +++++------
 block/blkdebug.c            |  6 ++--
 block/blklogwrites.c        | 10 +++---
 block/blkreplay.c           |  6 ++--
 block/blkverify.c           | 11 +++---
 block/commit.c              |  5 +--
 block/mirror.c              | 18 ++++------
 block/qcow2-bitmap.c        | 67 +++++++++++++++++++------------------
 block/qcow2.c               | 53 +++++++++++------------------
 block/qed.c                 | 24 ++++++++-----
 block/quorum.c              |  6 ++--
 blockdev.c                  |  7 ++--
 blockjob.c                  | 18 +++++-----
 tests/test-bdrv-graph-mod.c |  6 ++--
 18 files changed, 152 insertions(+), 178 deletions(-)

-- 
2.21.3


