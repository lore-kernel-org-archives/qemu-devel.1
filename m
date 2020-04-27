Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50918C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA4520661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cSLW657c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz51-0005Lm-1q
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3W-000299-Ao
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3V-0007Y5-QW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:58 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3T-0007Ta-Be; Mon, 27 Apr 2020 04:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5BzBO08wmwr0A5vu6lk9tw8P7xNPWDufNiKJDK6bZeW3Oqj0W+rqcD64ThHtdSN1gesNiC2CzKZabjxH8AAeMvCXlEAw3orl6jsPHI1v+RiAc63b5TGSbGVVRa444kkOwbvhhpF3cyiSyO55dxBSCYOm5zDIuBjbUkpjb0mqa23y1srjv++RFp8moPGlYyal1YfP8OrHogLUJpinvoY+Ls9g61cK5j/JJQ6UqkFsN+eTgw/tFVHjOFdXYhCxjpBzf+m7IHPTO/HRO76M6MbO8FHtUgQeIJmJqPiMsC7ixOltcj+vc5L0rvC7oVIrAsTfJj4P9BHY3EYXGfEmG54tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3A7BjRO6BWghj+MQI84aNzoy1mPP8DugbbqSODxbGM=;
 b=P1vlVxrloGkHn5D0arRZ+b3RTfIZ14hauDBkzvKkSMWWZKBiExZVpvjro1R8pfKWUMmORwXVqLw9vlcowPVEYswPlnOpsV33gi1V3bNPdF+ROP5gpEajU26Eh7elx08pz1T5bimwAZjYDR8e7L92horKEtpQ3O1+AzxO86LLiulFuLnp5dkdhT/JKFrfsCv0DdmP8A6l4O0D8ZXnN4uS+A26Np/HZ8h998GI1DNWY+p5MeYPw/ukzVxsmloaTLicolWtKPGmub+A7M3NaNBTecBF2ZZn1CaDEr/R3iSzsipVbTsKts9p+Zrj5sQwMNIi22oCD4l4KvcPjx8Zxb8qbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3A7BjRO6BWghj+MQI84aNzoy1mPP8DugbbqSODxbGM=;
 b=cSLW657ckOM7YUcfXj3O57B689cN495QJzTe5n+HhJXhvF7WVCbWYgC26sCDNztNFwgZ1QB3BBXTbIohsRHaaPtolpIT4Wc8m0ih2HlqOaYp2rlgPwOHp+TYuYYtda/+DeQsM+42u1M57zjK0lpLnDWikcRsHyRwIh1eQUjD54g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/17] 64bit block-layer
Date: Mon, 27 Apr 2020 11:23:08 +0300
Message-Id: <20200427082325.10414-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c2d692-3cd7-4d8f-2fa2-08d7ea84512a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463F8DEFF15459598797CDAC1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001)(966005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmeb99FtudFiLlxWkHPMYARwOMmxyzQmIiUvb2hDP5lPJlUHPDfHAMaUyGUzD9mZo77//gsENXuSdWxpyR6GEnnLXZKpIj763KC3JC1WLgUO/Iz6XasL6/MZwMREYTFnzw/Jl9FjvNCn22ROXMQz31SGu6sveOcTrRKzSzLajCAJQF7JIotIOayjfsDHGQ5lyTHW2dc4srtmOeEFd9ZRB6hR0i6Jr9I28mV9lMayMHOX4UwzNbQ9qHEyHrOGRwKJNpeViJnE/ce4mM8xzwa5CELs7SPHGN2GJz7bWqFDMxFdoMp8jQmuxBcVVd/ft6vKRC6uCCzecFG5Xb9QZC0d3UMKNE1Bm2mJq7vyuwF2G/tDqHSCStgjIT+a4CP3dmNx2UjyNKIvN6Zxo69jX1cknUGtFiGgc1hf1FArMBlgrx8ggEHOfDbBiQ4CycNOxLQXmQKwoB7szvj2BhYpPJ+uGaCrcRgzXP/2k+ROrnfOzvKWuUO4Jkp1/kYhtHZYI4YX76J0CJRIi+MhQ27pvhmoP4d68cvOKz2avbMwS4lqrCPNs8/pkqkMfw254RIOBU3HNqylMD4V95usteVPqXpZSA==
X-MS-Exchange-AntiSpam-MessageData: qze0kS/vGuCJHNXmXogGj+LDYN3KQnPwKgckSLSCiMAEfwccxxYx1DqM085y1U4GfAIv2Jy3KN7sXrIIckBYVqAH6TUyQxAUD63GBSv8/ohtiUkj5mwrnsAWP10uj6Rg4KsHE/aCh8PCAjy5Cr9c+oKzwQbECAtQaHxDrZALJWBMCgXWsf5tgpgYxKlH6pRjs49vPhOjJxB7tA0bF06Vxk1P5x5gHBUuwQtrXMjV6Hj95nm5v5D0Oj5sTa1X6njpDawOiooymY2MkX9zC2J+ps3U1ZvfxP/Uu1WLnFXciRpjr9ySx+sAOaa9AP+z7z2xl3LPY/6yvVt882iXnPZUi1PSmCQJwNRFKbzp6pEOPX7XtE2fWUOqAUBbAm6ijnTyztsAy8s3Rs1/iZlLbqwPzL+n73w9JwVBRoekKfk5rOr9uSFP925LMasNmcEsLa6vpNpcXP28ZlXB9o6N4OcnL5V/N8jslzd1NmJ4iX+KR6zaF3QXwi+ownUiMTL3rb0um8lJvQpFWqSMWz79Mh2/+Eb8IbdbJKJbCMa7pzxOwC/Yca8mkp4Pywr2uy3uHd8mcji5LbErbZYIt3xECqcycp44iTmGoxYxzk4hhagAPqXoA9+eyClDQBslO3mZsDXk5AOw5bjS0Or57lc2pC5g9fMSqeMueDTSOSmJqaV+SgE+xdlZ471FFgHBBSIFAEnN56B46K6XpdRz04b6xFvgWR1ZDLz355mApqR9RL6rE2omhV1/XaAvNiAyoRfnWMg7zd0JxHWlOkWinhCW9tORJSNAYo2D+ZRB83udJdwRqfo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2d692-3cd7-4d8f-2fa2-08d7ea84512a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:51.6308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtGkWoWVAhCkM4bP/4XQq2c7HE6Ahb+I/mcTCIDH447hdkl8ZykwZybH/nOSFvmDX4FPfoQJaW2agcZu9PHeCXFInkPZZaCMQbi9+UraZiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v1 was "[RFC 0/3] 64bit block-layer part I", please refer to initial
cover-letter 
 https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg08723.html
for motivation.

v2:
patch 02 is unchanged, add Stefan's r-b. Everything other is changed a
lot. What's new:

- conversion of block/io.c is now done step-by-step, to make careful
  review possible as well as future bisecting

- converting of driver handlers split by io type

- convert write_zeroes and discard (so the series is not called "part I"
  any more). I decided to convert most of things alltogether, leaving
  simple wrappers only in unobvious places. Still, if you consider it
  risky, I can refactor it to use only wrappers as a first patch and
  then update driver-by-driver, but it would be lot more patches, I'm
  not sure it worth doing.

Vladimir Sementsov-Ogievskiy (17):
  block/throttle-groups: throttle_group_co_io_limits_intercept(): 64bit
    bytes
  block: use int64_t as bytes type in tracked requests
  block/io: use int64_t bytes parameter in bdrv_check_byte_request()
  block/io: use int64_t bytes in driver wrappers
  block/io: support int64_t bytes in bdrv_co_do_pwrite_zeroes()
  block/io: support int64_t bytes in bdrv_aligned_pwritev()
  block/io: support int64_t bytes in bdrv_co_do_copy_on_readv()
  block/io: support int64_t bytes in bdrv_aligned_preadv()
  block/io: support int64_t bytes in bdrv_co_p{read,write}v_part()
  block/io: support int64_t bytes in read/write wrappers
  block/io: use int64_t bytes in copy_range
  block/block-backend: convert blk io path to use int64_t parameters
  block: use int64_t instead of uint64_t in driver read handlers
  block: use int64_t instead of uint64_t in driver write handlers
  block: use int64_t instead of uint64_t in copy_range driver handlers
  block: use int64_t instead of int in driver write_zeroes handlers
  block: use int64_t instead of int in driver discard handlers

 include/block/block.h           |  16 ++---
 include/block/block_int.h       |  56 ++++++++--------
 include/block/throttle-groups.h |   2 +-
 include/sysemu/block-backend.h  |  26 ++++----
 block/backup-top.c              |   9 ++-
 block/blkdebug.c                |   8 +--
 block/blklogwrites.c            |  12 ++--
 block/blkreplay.c               |   8 +--
 block/blkverify.c               |   6 +-
 block/block-backend.c           |  60 +++++++++---------
 block/bochs.c                   |   2 +-
 block/cloop.c                   |   2 +-
 block/commit.c                  |   2 +-
 block/copy-on-read.c            |   8 +--
 block/crypto.c                  |   4 +-
 block/curl.c                    |   2 +-
 block/dmg.c                     |   2 +-
 block/file-posix.c              |  42 ++++++++----
 block/filter-compress.c         |  10 +--
 block/gluster.c                 |  14 ++--
 block/io.c                      | 109 +++++++++++++++++---------------
 block/iscsi.c                   |  34 +++++++---
 block/mirror.c                  |   8 +--
 block/nbd.c                     |  16 +++--
 block/nfs.c                     |   8 +--
 block/null.c                    |   8 +--
 block/nvme.c                    |  33 +++++++---
 block/qcow.c                    |  12 ++--
 block/qcow2.c                   |  29 +++++----
 block/qed.c                     |  17 +++--
 block/quorum.c                  |   8 +--
 block/raw-format.c              |  32 +++++-----
 block/rbd.c                     |   4 +-
 block/sheepdog.c                |  11 +++-
 block/throttle-groups.c         |   2 +-
 block/throttle.c                |   8 +--
 block/vdi.c                     |   4 +-
 block/vmdk.c                    |  10 +--
 block/vpc.c                     |   4 +-
 block/vvfat.c                   |   6 +-
 tests/test-bdrv-drain.c         |   8 +--
 block/trace-events              |  14 ++--
 42 files changed, 379 insertions(+), 297 deletions(-)

-- 
2.21.0


