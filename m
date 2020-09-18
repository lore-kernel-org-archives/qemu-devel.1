Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F8C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDEF21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a0Gms9gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDEF21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL3z-0002It-Cz
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzU-0007F2-Tr; Fri, 18 Sep 2020 14:20:14 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com
 ([40.107.7.107]:9358 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzP-0004bj-GR; Fri, 18 Sep 2020 14:20:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMekIhwbKP2z/Q5hlaWlBJKTOv72SYwmB9pB7sbcSsRSLevDeKMZ6eLSLC6EVvpl7nNUr0sqcZchA6krjo6wuAzr+PA6nAVnxu2B7hrveZX3gL4rLmdzXMPPoITJgi/px3WyONwHYMpdP1gxNEDdbZUO/MvDKjrB0jVQSMXGhs1pIOFyk21eXyjK9p705PAlvfr8Lx8SdphL2HdO2xqxLpDNeAN/fHGhNb+4QTKm1DBqJijg5SZaEZ9Sd0B7wrp+alEZUMUa2E23Q3gbCf2TEnFSQJrz3N2fOpQQqcGFWsz1KNGH0A/42VFvku4Le8jkX16lTchBdn6RYfpWWqpMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTxfPcxRUVJ+qZBB614QeQVAmCt0o7Hf7eI3PNeiRk=;
 b=Xwg4u38/hMZmGFeME3LkrlwSOhsdNq0MlF1j3r1/RsdsEKSFsfMhD2I2VqW6BGvxPoII+WZMQmI1L9u+orX7bizM3dxr2qALjrFGf43qtiuuThi5FGdCNfwiNd3qHjhq93b8ZXWRslT8IwRzM5RqmNvh0xsGgk715mY9M7a3cLmzknSfuSiMuZ54bVFLciCpqtu4ajXVsAs1KfDP0FeFpnUKOfRA/A53GXAad9XjGOf9nxeZMocf3gvYRfGkal6YmiESnSPYavLJttUKZssvLvBQaz1KyfIrwO86yv8IfEPvyLPVJ4DcYCyB1SKDVBmXMHN8oqXDOVcMdnlQcLIWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTxfPcxRUVJ+qZBB614QeQVAmCt0o7Hf7eI3PNeiRk=;
 b=a0Gms9gCvM9Px5HgM0Swwwrb+8Tqf8nOnYpUpBc6yolnXQsVJocI1EK8V80IpwcLAOPn94Z+Os7DPxaSZRrGTFkoVdzRwFTZmgQ+hkAKJZp04fVGLq76aJleLdtAXLFPW9F34yUvekt6xFIhdbAjs/B+gFFDFxSuceYilJ/0f/U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3096.eurprd08.prod.outlook.com (2603:10a6:209:43::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 18:20:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 00/15] preallocate filter
Date: Fri, 18 Sep 2020 21:19:36 +0300
Message-Id: <20200918181951.21752-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:03 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c4a34e4-ac6a-4ac2-f8af-08d85bff76a1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3096E8E8D65108BE12636E6AC13F0@AM6PR08MB3096.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8+lS6WFa3oAgZiTHh8eWuQ/bh9m40ENBkTxKXMe8KCLU3ttN3kks60MrPjUuvVcbH8wyaddsrBK8G1EYY1ON2V0qM1jPZXwlWzcS0RXE2gHuzrdquFxCmF37EyS/v4Od9iQZOM5CChCF4vxKQILous2roe2HWXRRgF5QRGMrSJu3gkifABP8U6Rgu7GRBuZEGQfqA0prjZAbxBMdI3i2iYi5VXS5tQ+UUe99+IaHQhhqHTDjLvQqxWBAmihDjfx7Ov2VUKVJaKs7avcIa/+OddPSrPL8nWtLX58ult30+n/Fz5Cj3lKDxc0rhqC3IkLtfEwsbbmNqUarDMoFT3IdldNPsmehCxeMRXqoJzwT20VnD5UOGq5a3paJ8Hv8vMK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39830400003)(376002)(396003)(136003)(2616005)(956004)(4326008)(1076003)(6916009)(316002)(6486002)(6666004)(478600001)(86362001)(83380400001)(5660300002)(6506007)(8936002)(186003)(16526019)(107886003)(66946007)(26005)(36756003)(66556008)(66476007)(2906002)(52116002)(6512007)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: u8tjOMG6Q11kri1GY4VWlHdpExQxZUIkYx/tIAYJRUk5P6D9dcq4J1h3/I6L/7057uoB1R4BLzcbg6l8UF16xbXMFSi41jYQWkyAfMt4po/rWX5HH8IcR6X66gi6iVaxheq6XLyOmNMXKy1kojhDP9D7vxgin/cgw6ZolWF9FrEynu8C/GEj4ejN6j1Jmqe+KmrMx2IEPpk2RCtQO4MLWpTazY+A38qW29OXpF/k34IJR2r99xYLNQpeyiwmT51VJoWV67E3a2Kp2zxhWeIay5bN4SWe+h/ZY5jfaPQV7deykwSRmcy7o0pC8r5DkDo7MNU6H+870dD2+bfS93Tz4xDP8U1HtehBbu3qaW4DYKa2U/7Pm1yU2/KPSHkLToHRn/lD23YgpMiyD+4NxxRSSpPJzya+X8qUogmO6eg2nUZQPuFDZan0wxPphdCRO2bxeJsLWqhajoqzRREgAcSN2O9Tjse6wYwSJtnABBbitKrt688uAG9DImehA8gxbtTuSEeZY/RfeAFiUuFznFBxrA8RLuVrp9ZB+zEHm3pBHZL5EyO4j4KM2wkJKU13AXysRZQ5am5Nt3BMzmtath1BCyz2CW20Y+bVhjihEPQPe0kbPkgc+WTu3oseoGt7LC1mY46eyZ+WyYSH7f82quqNLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4a34e4-ac6a-4ac2-f8af-08d85bff76a1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:04.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di8Qqil1YWEX/WNzruSSlde+hhx40tqgR/LMOkh+dTcogzB69TyhvpDoctJbJKl+TtRJvt5YL4qfHxcvaomLr+/I0nOzq7zHZo4W52fIdus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3096
Received-SPF: pass client-ip=40.107.7.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:04
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

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is very-very expensive operation. We have to
workaround it in Qemu, so here is a new filter.

Still, the filter shows good results for me even for xfs and ext4.

Here are results, produced by new benchmark (last 4 patches):

All results are in iops (larger means better)

----------------------------------  -----------  -----------
                                    A            B
                                    no-prealloc  prealloc
ssd-ext4, aligned sequential 16k    19934±1.2%   27108±0.27%
                                                  A+36±2%
ssd-xfs, aligned sequential 16k     15528±5.5%   25953±3.3%
                                                  A+67±11%
hdd-ext4, aligned sequential 16k    5079±29%     3165±11%
                                                  A-38±36%
hdd-xfs, aligned sequential 16k     4096±95%     3321±7.6%
                                                  A-19±101%
ssd-ext4, unaligned sequential 64k  19969±1.9%   27043±0.49%
                                                  A+35±3%
ssd-xfs, unaligned sequential 64k   15403±2.8%   25725±6.4%
                                                  A+67±13%
hdd-ext4, unaligned sequential 64k  5250±17%     3239±8.7%
                                                  A-38±23%
hdd-xfs, unaligned sequential 64k   5291±8.2%    3336±4.2%
                                                  A-37±11%
----------------------------------  -----------  -----------

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

v6:
05: add Max's r-b
06: add Max's r-b
07: new
08: Changed a lot. really. no .active now, support more use-cases.
    Somehow, now I see performance benefit on xfs too :)
    probably due to .zero_start feature.
09: new
10: new
11: mostly rewritten, a lot more cases, drop r-b
12-15: new, to produce final benchmark table

Vladimir Sementsov-Ogievskiy (15):
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
  iotests: add 298 to test new preallocate filter driver
  scripts/simplebench: support iops
  scripts/simplebench: improve view of ascii table
  scripts/simplebench: improve ascii table: add difference line
  scripts/simplebench: add bench_prealloc.py

 docs/system/qemu-block-drivers.rst.inc |  26 ++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  20 +-
 include/block/block_int.h              |   3 +-
 block.c                                |  10 +-
 block/file-posix.c                     |   2 +-
 block/io.c                             | 130 +++---
 block/preallocate.c                    | 556 +++++++++++++++++++++++++
 qemu-io-cmds.c                         |  46 +-
 block/meson.build                      |   1 +
 scripts/simplebench/bench_prealloc.py  | 128 ++++++
 scripts/simplebench/simplebench.py     | 103 ++++-
 tests/qemu-iotests/298                 | 186 +++++++++
 tests/qemu-iotests/298.out             |   5 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |   7 +-
 16 files changed, 1146 insertions(+), 98 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100755 scripts/simplebench/bench_prealloc.py
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.21.3


