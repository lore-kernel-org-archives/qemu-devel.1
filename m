Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53146C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819522224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FYfIAqVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819522224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFea-0001GY-1q
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaE-0005Vx-1Y; Wed, 21 Oct 2020 10:59:22 -0400
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:44322 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFa9-00085Q-B7; Wed, 21 Oct 2020 10:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3SxWj5KYF+VwTYkUCrHRHyRXrobw1JO5oZkwWuGZ/wMFxs+ASVsvvK9BTLU1klM6CM6pHoTLVYkdTt8iibyvZ4n7urL0AfPeJA12GwkBLssF7+7PkjALU6RODzFx52HLZxfZ8Y3xdfsCklKa1LZNiBf3sfSVbzd0Jpa4SXsCsO4w8sHNKteCeYcXx4QRIOq2GI5AQdRK6I3UFfMf93iJKPmkLbj072d+oCBzSomEiRa+vRSGWIIXKInBJWYjlf5lvY99IkeZAo1z0jCkWmnHEtZu0uXLZwv85UbFvnAC6CpsjuDIIxLnWJD+i10wdXu4sc1AkW8avEK/e3ifBxhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtyP47pxKIiRJbZUNzN7SE/6ydvdrpbQQ0bdKbKOw08=;
 b=Vkq6gxnt9xuPlVJTjKpcITAiJoQDmYWaXDwBSE6agVBNeChmkvbeREY0CC7xzrxJvyWa7R8bvZW1u9CcCUNEQjPoomdOH+YUn6BHtZVYLAjnFvwSQD+y86qz2wyccE7RAAEJCTvRDHklEtkKOhBNTjNcHJ+OMCamm7aJwt7Rau2R9Tv+L+QKUFj/RFSh+tVMIK98sX6BFs8k8LAY2YIB4tsxYzKWJ4jT2ZMU3Ogyf32BTuzozzzU6tf6kv66LoL3bHq0xToeBUTNyV3Gs7ZtqNyBYBCSnygbc7s/BFO6KzoRgdymz50g8DL/A7eGt5qVmw7frfDs64vY/FcuiFbxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtyP47pxKIiRJbZUNzN7SE/6ydvdrpbQQ0bdKbKOw08=;
 b=FYfIAqVmsNEyrJkUqykEiWH+jT/sTDM+MFMZKi91/jcPOwxc4jUzsgNvwjmI5qa07Vv7QxmHnOQUvrb1hKSUnKh22PHxXrHc7RBH7nbSb1OLx2uMsC9XC/Ds/dP1enZPJeo5jRXzRMbNL+2mnFMjWdu6ghpr+RGoZZNMKbemGn8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:59:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 00/21] preallocate filter
Date: Wed, 21 Oct 2020 17:58:38 +0300
Message-Id: <20201021145859.11201-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 834540ef-d061-49a8-587f-08d875d1df71
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35416AFF66BCC3BA7DA98213C11C0@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oynnPTe8i6BZdF6IT1Lc8BbuDeb2si+keFxmGJBkxxJCsLkZrBa0rLs6QmQz4sp5vDosrnt5C+ZsOGDiDMpp4YSNFzFkHGDNPgOeBJhREcUWpKwjcK7VW2Bk93dKWdfXAthB1/ljaMZaxtSIj98IvmiNU9BvqfPVhzHaKliBMyuibcZ+Upr0TH9KoMMYEYBySIerq9yQWJmLAvXe61zhAP/WB5SZJRz3F4NSPZKX1bEmb4F1CRtUqPM4Tj8q0IjqXl4m4cPYt/c0/S2RmvGyyHlBEkbUrCqg/iKMLic7Zz/8pSr7oX6XQkqkwrhc9neN8Y2zjFgdg4+22eQqubwy/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6512007)(8936002)(83380400001)(52116002)(4326008)(478600001)(6486002)(6506007)(8676002)(186003)(16526019)(107886003)(2616005)(956004)(66946007)(66556008)(66476007)(6916009)(36756003)(26005)(2906002)(86362001)(1076003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5aZnpssi1/MBiYrXEL3w3aJf+Rr+mCf3yQ+D7Lf6BaQb/yCAyOoOAHIzUTr2Y/vJQ/B4RgemUcAQjuVOHeb7GYxLVeLKS4+UjrjiuJboYFV+7t/h5688Q0YMmsiQsSEwpXS51SOhW6O1IDVJrqy4u97WcC0mm2m4mHpwcm9lY+G5YBKaGYkSaUnJjNZ4rCCkfYRVblQhXOLiaUT3I5vW7nAmXeIaMMEUk/ODYKc5GCQhJ6Cwd1PQ7uM8bQDM57nkYn1SmcLt2hdDhygPHsNjHolvB+5nVW44z3Ce/J1Trq6Oe0n9HQbfGEa3F9B0AttWJp/bYJ4/O7HzpTVVLheC5s/PloIvtvIN4mfWZyafN7Tq/UJX2iZbgjAXsN3W0BRpx59SMB3/20Tn5wRgqUIhZr2c/0PwXZf4fu/MUvksJZmZoBHXDSAIrM/wzC/Y9W8rUE3tyzZeqvJQc6jukefN3psxeNYHoN/Cz31wvl+e3zCR9zPJUyjmHS9dgo3G2ejZTbhUGevPduz9K6waWofJFuu8lD/aMh0wbP10B5J6iUZfFc1q4hn47I/J0BoMF1xPFDeDEsAi4J7jP7mgAAHlJom9Nyj2QUxIIGEzFnst81N0rqNS54TUpdPxyojKYgOJHz8w5JYnihfEcrvCOQizdA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834540ef-d061-49a8-587f-08d875d1df71
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:13.1720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leYXN/PiSKkFVAf+gyN83gZ4AtG6M/aF9SARhJR6HnNQCwLw8ryP/ULPcHbTl5nUW0+kcLAyfdKywO02mVugGHAfUASpJTHHRLqwZ5HB6Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=40.107.22.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:14
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

Here is a filter, which does preallocation on write.

v7:
01: add Alberto's r-b
07: don't remove sentence from the comment
08: - drop extra "s->file_end = end;" line
    - improve check/set perm handlers
09: add Max's r-b
10: add Max's r-b
11: new
12: - skip if preallocate unsupported
    - drop auto and quick groups
13: new
14: - improve 'average' field of result spec
    - drop extra 'dim = ...' line
15-18: new
19: a lot of changes
20: new
21: add results dump to json

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is very-very expensive operation. We have to
workaround it in Qemu, so here is a new filter.

Still, the filter shows good results for me even for xfs and ext4.

Here are results, produced by new benchmark (last several patches):

All results are in iops (larger means better)

----------------------------------  -------------  ------------
                                    no-prealloc    prealloc
ssd-ext4, aligned sequential 16k    2e+04          2.7e+04
                                                     +36%
hdd-ext4, aligned sequential 16k    4.8e+03 ± 5%   3.1e+03 ± 4%
                                                     -36%
ssd-xfs, aligned sequential 16k     1.6e+04 ± 5%   2.5e+04 ± 3%
                                                     +59%
hdd-xfs, aligned sequential 16k     4.7e+03 ± 22%  3.2e+03 ± 3%
                                                     -31%
ssd-ext4, unaligned sequential 64k  2e+04          2.7e+04
                                                     +36%
hdd-ext4, unaligned sequential 64k  4.9e+03 ± 2%   3.2e+03 ± 8%
                                                     -34%
ssd-xfs, unaligned sequential 64k   1.5e+04        2.6e+04 ± 2%
                                                     +69%
hdd-xfs, unaligned sequential 64k   5.2e+03 ± 2%   3.3e+03 ± 5%
                                                     -35%
----------------------------------  -------------  ------------

Note: it's on Fedora 30, kernel 5.6.13-100.fc30.x86_64

The tests are actually qemu-img bench, run like:

  ./qemu-img create -f qcow2 $img 16G

aligned:
  ./qemu-img bench -c 10000 -d 64 -f qcow2  -s 16k -t none -n -w $img

unaligned
  ./qemu-img bench -c 10000 -d 64 -f qcow2 -o 1k -s 64k -t none -n -w $img

and for preallocation, you'll drop -f qcow2, add --image-opts, and
instead of just $img use
  driver=qcow2,file.driver=preallocate,file.file.driver=file,file.file.filename=$img 

Or, use new benchmark like this:

  ./bench_prealloc.py ../../build/qemu-img \
      ssd-ext4:/path/to/mount/point \
      ssd-xfs:/path2 hdd-ext4:/path3 hdd-xfs:/path4

Vladimir Sementsov-Ogievskiy (21):
  block: simplify comment to BDRV_REQ_SERIALISING
  block/io.c: drop assertion on double waiting for request serialisation
  block/io: split out bdrv_find_conflicting_request
  block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
  block: bdrv_mark_request_serialising: split non-waiting function
  block: introduce BDRV_REQ_NO_WAIT flag
  block: bdrv_check_perm(): process children anyway
  block: introduce preallocate filter
  qemu-io: add preallocate mode parameter for truncate command
  iotests: qemu_io_silent: support --image-opts
  iotests.py: execute_setup_common(): add required_fmts argument
  iotests: add 298 to test new preallocate filter driver
  scripts/simplebench: fix grammar: s/successed/succeeded/
  scripts/simplebench: support iops
  scripts/simplebench: use standard deviation for +- error
  simplebench: rename ascii() to results_to_text()
  simplebench: move results_to_text() into separate file
  simplebench/results_to_text: improve view of the table
  simplebench/results_to_text: add difference line to the table
  simplebench/results_to_text: make executable
  scripts/simplebench: add bench_prealloc.py

 docs/system/qemu-block-drivers.rst.inc |  26 ++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  20 +-
 include/block/block_int.h              |   3 +-
 block.c                                |   7 +-
 block/file-posix.c                     |   2 +-
 block/io.c                             | 130 +++---
 block/preallocate.c                    | 559 +++++++++++++++++++++++++
 qemu-io-cmds.c                         |  46 +-
 block/meson.build                      |   1 +
 scripts/simplebench/bench-example.py   |   3 +-
 scripts/simplebench/bench_prealloc.py  | 132 ++++++
 scripts/simplebench/bench_write_req.py |   3 +-
 scripts/simplebench/results_to_text.py | 126 ++++++
 scripts/simplebench/simplebench.py     |  66 ++-
 tests/qemu-iotests/298                 | 186 ++++++++
 tests/qemu-iotests/298.out             |   5 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |  16 +-
 19 files changed, 1225 insertions(+), 127 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100755 scripts/simplebench/bench_prealloc.py
 create mode 100755 scripts/simplebench/results_to_text.py
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.21.3


