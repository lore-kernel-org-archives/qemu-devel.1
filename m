Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA412C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A07F2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lymw7orR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A07F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfovd-0006Zu-PP
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouQ-0004n6-H7; Mon, 01 Jun 2020 14:11:38 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouO-00026c-9C; Mon, 01 Jun 2020 14:11:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1oCKK7ax9ziXDl0LDknVzT5b1aNzuFn3iPBcJJOQoenXvUWSWeYdpSdIxpXrvYPodeTuzAS9X1Pz7viTKqubjOZvu14PVkKqpTEwkcBzD7kAgLVVEHcPSht25ezp6AyZZECNz5QJLGr1YsvJRKSDVZU80VRhaOcgvgP4qHs9KlS+OsYQLh8CY8slC9aqH+C1ATtiqyZE1a8l+ZZNCeWD/qUqKMYhLblywsaTtvK26XAlK0bN/GXMZXlmYc7ssPlx1K7G9bGMHFogOe6xjiou3aHCOfI8BWZGyNvhXmrZanbOoG9OByDubsn99BTegEEaKrdc4Im9mNJiqLNwsVllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S7piJHeNwYr3zp0P1uGp1j5UT1HqRVco3ken6H//3k=;
 b=Rp7N47+rJYzRJUyuOHCcUZltzUFpz1/ssucPEgpzC2+47EbEx/FcTMKdFNnlofjq+VCIkVd5dD8vlcswkzMT3+yiw9QBhVdskLadSOJdUooHdjqN36+YQ3wZ8S5cMijHthaBkerPXmnUknA9NRLb/RjoEBbGh8BkfbnnKXSYxmKuYzTK2x2bRoAT5i2fpPVmOgJ1bVSXFl0vRP32O9a6IM7us684xrKensM2TypbLEmVBD3AQ+7a3UMM69qektI5sufgWYeIzWdOPTBw8r5PssW0BLWJ0SFUlU1NcrhUgPPdiCQ9wcB1sJPw/SejnaR/MhovP1jVPxOnTCBV4tjS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S7piJHeNwYr3zp0P1uGp1j5UT1HqRVco3ken6H//3k=;
 b=lymw7orRejbDE6WO3cd5xpzlqZG5z6R3Poj8hm20OS60ZyyflzdUml+OSOO+RKcOStd2tJIf/2BKMQaUF3NkzX2mAj+2Ld9LHW7SSiiUS/onFkA9tdiHIEbjUB3Slnflpzxetv12Dt6aPVk72W/kCb85plI18B+wDq2uGKy7iVY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/20] backup performance: block_status + async
Date: Mon,  1 Jun 2020 21:10:58 +0300
Message-Id: <20200601181118.579-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e19f5da0-acad-4fc2-99ab-08d8065735e8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531790DECC73396CC6B8DE9BC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yIBIJNcNZXFqR8jnbXtS0rVKLoPjmyulOSnh+3S2obV2eevILkIn9n5hmxYSUGqbym1P+g8FyNxihr51byFHfEugiViK1365amjm404fegwt0habvgwGi+XaJ9/NilX73dfdl5ndHGWj/VZG53GfHQTbVGrUIVefyVhcOlQUTZWVNCU9RtEnApDe8pOrCdbfXKdhr9tFkEOee3JMWLlwfJKD/lCzHtKMtlK0VSMBVfnruWJosgROfeKpQ8ylP3eLH8pdab+hrBbLqlC7yQArTqdUONchRnKziwBkENYVyndHqzALgfFzwRhf3xX/FDNTTSPuqQ5ZtRezPtY3GvFgFUyDH2rP4mQ4VSQDqp8/7dbMkoRxlXDMgbjQ+eTS02z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JL4d04L+xDRWQz9w5Tj6HZaAfAVeeMn8b0PHHJfhZBTRCCs4anmAzW+1s2LnRFpMBZcFbDfYyxYfBJsRa3YCtDw0AjMYslkgbml78GeB9sDwkoPXdWt//8i2CI5F0xic5qyvY7VWktS/9NnfuDLeluL+5p5gZEAg6HhpQRyfhfpzCZfZNOBLw99D00U/qnxA1T65zxTtuUnecDkqWekmY5NE3nDxGZ62Us1qUA5MzSvYDIeCCk3CADG3XtVre/9aFKdChhQViUuOOJg9YIOgR2e3KdUbrJRqkQLTkauMqjCiJ5uZbijZqjx46lbssKTC0FH4cyb6n6tB43VMNwu+cpww0k/hCugirHziDaIDjq7viooI7dSbBVqQBd+mGyoL9AJH/E08uAGWc+9GdqJGjoXOBGLxRcLAb599p/mYy5TaVX5wMVpXp30y9UrMDWNDb5YW6TVcQSmqeLdFl4Y6u8uiDpHiwEfWBS5zKWNBhdw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f5da0-acad-4fc2-99ab-08d8065735e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:31.1418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mqBQ6hkQYMpgOp9WahKsw2djzAvAfsuvZJ31usSKjyfH5+qRYboSTKWq45ADIAzoASWLBfANVBvN5Iyfbh5FPm6WrNIwOB0dtyiMiZyGSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This a last part of original
"[RFC 00/24] backup performance: block_status + async", prepartions are
already merged.

The series turn backup into series of block_copy_async calls, covering
the whole disk, so we get block-status based paralallel async requests
out of the box, which gives performance gain:

-----------------  ----------------  -------------  --------------------------  --------------------------  ----------------  -------------------------------
                   mirror(upstream)  backup(new)    backup(new, no-copy-range)  backup(new, copy-range-1w)  backup(upstream)  backup(upstream, no-copy-range)
hdd-ext4:hdd-ext4  18.86 +- 0.11     45.50 +- 2.35  19.22 +- 0.09               19.51 +- 0.09               22.85 +- 5.98     19.72 +- 0.35
hdd-ext4:ssd-ext4  8.99 +- 0.02      9.30 +- 0.01   8.97 +- 0.02                9.02 +- 0.02                9.68 +- 0.26      9.84 +- 0.12
ssd-ext4:hdd-ext4  9.09 +- 0.11      9.34 +- 0.10   9.34 +- 0.10                8.99 +- 0.01                11.37 +- 0.37     11.47 +- 0.30
ssd-ext4:ssd-ext4  4.07 +- 0.02      5.41 +- 0.05   4.05 +- 0.01                8.35 +- 0.58                9.83 +- 0.64      8.62 +- 0.35
hdd-xfs:hdd-xfs    18.90 +- 0.19     43.26 +- 2.47  19.62 +- 0.14               19.38 +- 0.16               19.55 +- 0.26     19.62 +- 0.12
hdd-xfs:ssd-xfs    8.93 +- 0.12      9.35 +- 0.03   8.93 +- 0.08                8.93 +- 0.05                9.79 +- 0.30      9.55 +- 0.15
ssd-xfs:hdd-xfs    9.15 +- 0.07      9.74 +- 0.28   9.29 +- 0.03                9.08 +- 0.05                10.85 +- 0.31     10.91 +- 0.30
ssd-xfs:ssd-xfs    4.06 +- 0.01      4.93 +- 0.02   4.04 +- 0.01                8.17 +- 0.42                9.52 +- 0.49      8.85 +- 0.46
ssd-ext4:nbd       9.96 +- 0.11      11.45 +- 0.15  11.45 +- 0.02               17.22 +- 0.06               34.45 +- 1.35     35.16 +- 0.37
nbd:ssd-ext4       9.84 +- 0.02      9.84 +- 0.04   9.80 +- 0.06                18.96 +- 0.06               30.89 +- 0.73     31.46 +- 0.21
-----------------  ----------------  -------------  --------------------------  --------------------------  ----------------  -------------------------------


The table shows, that copy_range is in bad relation with parallel async
requests. copy_range brings real performance gain only on supporting fs,
like btrfs. But even on such fs, I'm not sure that this is a good
default behavior: if we do offload copy, so, that no real copy but just
link block in backup the same blocks as in original, this means that
further write from guest will lead to fragmentation of guest disk, when
the aim of backup is to operate transparently for the guest.

So, in addition to these series I also suggest to disable copy_range by
default.

===

How to test:

prepare images:
In a directories, where you want to place source and target images,
prepare images by:

for img in test-source test-target; do
 ./qemu-img create -f raw $img 1000M;
 ./qemu-img bench -c 1000 -d 1 -f raw -s 1M -w --pattern=0xff $img
done

prepare similar image for nbd server, and start it somewhere by

 qemu-nbd --persistent --nocache -f raw IMAGE

Then, run benchmark, like this:
./bench-backup.py --qemu new:../../x86_64-softmmu/qemu-system-x86_64 upstream:/work/src/qemu/up-backup-block-copy-master/x86_64-softmmu/qemu-system-x86_64 --dir hdd-ext4:/test-a hdd-xfs:/test-b ssd-ext4:/ssd ssd-xfs:/ssd-b --test $(for fs in ext4 xfs; do echo hdd-$fs:hdd-$fs hdd-$fs:ssd-$fs ssd-$fs:hdd-$fs ssd-$fs:ssd-$fs; done) --nbd 192.168.100.2 --test ssd-ext4:nbd nbd:ssd-ext4

(you may simply reduce number of directories/test-cases, use --help for
 help)

===

Note, that I included here
"[PATCH] block/block-copy: block_copy_dirty_clusters: fix failure check"
which was previously sent in separate, but still untouched in mailing
list. It still may be applied separately.

Vladimir Sementsov-Ogievskiy (20):
  block/block-copy: block_copy_dirty_clusters: fix failure check
  iotests: 129 don't check backup "busy"
  qapi: backup: add x-use-copy-range parameter
  block/block-copy: More explicit call_state
  block/block-copy: implement block_copy_async
  block/block-copy: add max_chunk and max_workers parameters
  block/block-copy: add ratelimit to block-copy
  block/block-copy: add block_copy_cancel
  blockjob: add set_speed to BlockJobDriver
  job: call job_enter from job_user_pause
  qapi: backup: add x-max-chunk and x-max-workers parameters
  iotests: 56: prepare for backup over block-copy
  iotests: 129: prepare for backup over block-copy
  iotests: 185: prepare for backup over block-copy
  iotests: 219: prepare for backup over block-copy
  iotests: 257: prepare for backup over block-copy
  backup: move to block-copy
  block/block-copy: drop unused argument of block_copy()
  simplebench: bench_block_job: add cmd_options argument
  simplebench: add bench-backup.py

 qapi/block-core.json                   |  11 +-
 block/backup-top.h                     |   1 +
 include/block/block-copy.h             |  45 +++-
 include/block/block_int.h              |   8 +
 include/block/blockjob_int.h           |   2 +
 block/backup-top.c                     |   6 +-
 block/backup.c                         | 170 ++++++++------
 block/block-copy.c                     | 183 ++++++++++++---
 block/replication.c                    |   1 +
 blockdev.c                             |  10 +
 blockjob.c                             |   6 +
 job.c                                  |   1 +
 scripts/simplebench/bench-backup.py    | 132 +++++++++++
 scripts/simplebench/bench-example.py   |   2 +-
 scripts/simplebench/bench_block_job.py |  13 +-
 tests/qemu-iotests/056                 |   8 +-
 tests/qemu-iotests/129                 |   3 +-
 tests/qemu-iotests/185                 |   3 +-
 tests/qemu-iotests/185.out             |   2 +-
 tests/qemu-iotests/219                 |  13 +-
 tests/qemu-iotests/257                 |   1 +
 tests/qemu-iotests/257.out             | 306 ++++++++++++-------------
 22 files changed, 640 insertions(+), 287 deletions(-)
 create mode 100755 scripts/simplebench/bench-backup.py

-- 
2.21.0


