Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E06C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AFA21D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QmKily5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AFA21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6FG-0007Ww-LB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68h-000787-Cr; Mon, 26 Oct 2020 13:18:35 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:26030 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68e-0008Ma-BK; Mon, 26 Oct 2020 13:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K09dnywxywkjo5A4Yts8zaq1JR1IE0nxE9mG3mRG5eUWWKPVzVa65eSGKSmJma+OcOrBFGm1UfaI2sHIMXwJrnrsD836vAO0pkRzjZQU9Sk8+cFbsqsVvoSMdtZOTWZ+MT1x+viEGFTWEac1n4EG2d5jnSnZbXtF73O6n3VdY7xsKLXFuCyqbVNULCy4YE37XPkgIHn5/d/phSj0L6e5O1OuOML8UiKjaCrCMDEYLOdOz1g3UjtN7+PjJCMN6Wz+XwrUOzx++mdOMeVh9pbdxNGlEtqjVS5N0VPEIcjdoH2O894S8oTsYp062CaeMGUdnHVPZIpgeRD0IdNeosXkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLGpkewSYQ1B0ss6IXktspjFn8K+PBNF2VbqGm9Ecng=;
 b=kFrjF5cxwXe3/8neGt7zEAB2jyu/MqNuHsQss7Z6ycYp8uxMdn1Zlb5V6HiBMm338Qn5Ki3VhbjYnp8QUACoQCleJ9jkbiV7uZv9zsXN/DqJEylYb1YrLdZtomNTDvxQ38768E3gQ8uyiAcAYR+/V0CwrZXXbWZv0lq8KiqId+41bQRgphkQ84Q+46wybwsq5doZo2IQGYxTvyndGSwG7kU6ngYegwlEVTGdIUZnL0qQtkpZdvnY/bcTWz+ubXxUOCpDn5mUk/GSdkEDtdFWXKf+tI8SiLacqd20sUwXkAssoKGNhJnu2CUH/Zy8zmBsXoFbQDZKQzIt+aeRUzd6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLGpkewSYQ1B0ss6IXktspjFn8K+PBNF2VbqGm9Ecng=;
 b=QmKily5XmoQjv11N3+n7rk9sxw9nmQSPd/VT4BCiHjSoNPbeZNKv9FSNnNHJJ1kzFHn41mCwoJPPTPekhDFlE+DDvNYuczULwo/kawK9X6H39hdyMVKO5vK1ZkD7G3adXtpoikCyxbYEJrSNVMApSTf7drV+KrVcHsWQjo60vfs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 00/25] backup performance: block_status + async
Date: Mon, 26 Oct 2020 20:17:50 +0300
Message-Id: <20201026171815.13233-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c960d937-7674-4487-2028-08d879d32849
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5031BF4FA8AEA31C95FF1009C1190@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dcf8Y3mVrJXLSasVCkLmxP/tI2jlwUEQ91JiYHxh0NLYi2BsKmm95h6cxXkwgO9NJ6ibJL86RzsROlj2n+qLMCvv3bMwl/FZaPah2pHmk2LaU6BWxDq2lu19g9EJhrt0rrDHLB7YIWg9s9JidPRy++Dg7QRcJ/FYvJXq7i/0fPvgUaTQ5TbLGwjQEhVk25hGzG8gyzoJvJXsjLXp/IfLifuNvddarrQ8pdNpBcmsdeWOjQxLmLfSXNxunfE8H4Oozmc2Yx+QwxxFC3QGNAHFlXp/M5T+zpsfL1JYxzILbRGTy87T0cJYhRHPLY9urXal
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(5660300002)(1076003)(316002)(2616005)(478600001)(6506007)(4326008)(6666004)(66946007)(26005)(66556008)(956004)(36756003)(6486002)(6512007)(186003)(66476007)(8936002)(52116002)(2906002)(16526019)(107886003)(8676002)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 94hTFfb562vTQBfD19/ucc0e72BRWZiK74dHFPwhULR6SgbHSbDazJUWCs5+v9UOpl2LlsBjrOxJaFSgo32P0gR6oE8SJbyBGMuDR9hKjhgAxpt4JJAbwhqrnHjiMQ9ReRizN2u/5N+gOaTu0i5NE7cksrxHK3KQQOOSDXhm12USjzbxOYsZqma/FMIsdKtWWV2mUaBYscgkwZeqG7Ectq7mXdIiMK8yt63ez+OO8xg7MYSACGgK5B9+5zSRbrrN8rX2TnlWZ0a4YtqJzZLNuOaCT/n7KH8OGqyZkD7bOK16WoKZLLVPkwGEysBh2nM1Z5z2rESiw3yWpVfonk2PDRYvJwTOkS2yHf+mDsLXvEh4yJoEFZNC/rtxdJeOgYtzWAmLdmswUckaMLkjOoURwwq7sxnHIfFwx+pI8mU+7fGOkfuVgPGdL70XYq2v8VXh2LQdWOtTvF7o9rxj50r+7fh/3nbqN+m5FIsCqD3kwYEAwxklvyu8SlFOYs4CL3BdZsDjeENlnLiOtAMfQ71n6Q/aDYgn6wpJJd++gZKrzoB1rVk9o5nrS9/sBJ5v8WM+BBTHj6yw+ruxzDsSv96eFuBdJfvZ3uiHtOENokytSe1eC/0uor7sWNJSmLY0T/zcMXNhf4KUAGQnFO7o9Giy2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c960d937-7674-4487-2028-08d879d32849
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:29.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 717IvWh+7cTEw+6Ssn6VrmvNAtHsf3l27ZNRfXUUABEUvSwoJv4x+0SEF6TDNqeYZ+cTBf4Gjw8tEcLr1nOposU7FKmDjNy0D9vxNEFDxJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=40.107.6.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:30
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

The series turn backup into series of block_copy_async calls, covering
the whole disk, so we get block-status based paralallel async requests
out of the box, which gives performance gain:

All results are in seconds

-----------------  -----------  -------------  --------------  ---------------------  --------------------------------  ------------------------------------
                   A            B              C               D                      E                                 F
                   mirror(old)  backup(old)    backup(old)     backup(new)            backup(new)                       backup(new)
                                copy-range=on  copy-range=off                         copy-range=on                     copy-range=on
                                                                                                                        max-workers=1
hdd-ext4:hdd-ext4  19           20             21 ± 14%        19                     51 ± 12%                          22 ± 24%
                                  A+5%           A+12%  B+6%     A+3%  B-2%  C-8%       A+174%  B+161%  C+145%  D+165%    A+18%  B+12%  C+5%  D+14%  E-57%
hdd-ext4:ssd-ext4  8.7          9.4 ± 3%       9.6 ± 2%        8.8                    24 ± 2%                           8.9
                                  A+8%           A+10%  B+2%     A+1%  B-7%  C-9%       A+174%  B+155%  C+149%  D+173%    A+2%  B-5%  C-8%  D+1%  E-63%
ssd-ext4:hdd-ext4  9            12 ± 9%        11 ± 7%         9.7 ± 7%               11 ± 2%                           10 ± 3%
                                  A+36%          A+28%  B-6%     A+7%  B-21%  C-16%     A+21%  B-11%  C-5%  D+13%         A+16%  B-14%  C-9%  D+8%  E-4%
ssd-ext4:ssd-ext4  4.4          11 ± 4%        10 ± 3%         4.7                    5.7                               10 ± 5%
                                  A+143%         A+134%  B-4%    A+6%  B-56%  C-55%     A+30%  B-46%  C-45%  D+22%        A+133%  B-4%  C-1%  D+119%  E+79%
hdd-xfs:hdd-xfs    19           20 ± 3%        20              20                     45 ± 4%                           19
                                  A+3%           A+4%  B+1%      A+3%  B+0%  C-1%       A+131%  B+125%  C+122%  D+125%    A-1%  B-4%  C-4%  D-3%  E-57%
hdd-xfs:ssd-xfs    9.1          9.9 ± 4%       9.5             9.1 ± 3%               23 ± 2%                           9.2
                                  A+8%           A+4%  B-4%      A+0%  B-8%  C-4%       A+151%  B+132%  C+142%  D+151%    A+1%  B-7%  C-3%  D+1%  E-60%
ssd-xfs:hdd-xfs    9.1          11 ± 9%        11              9.5 ± 4%               12 ± 22%                          11 ± 3%
                                  A+16%          A+22%  B+6%     A+4%  B-10%  C-15%     A+32%  B+14%  C+8%  D+26%         A+18%  B+2%  C-4%  D+13%  E-10%
ssd-xfs:ssd-xfs    4.1          8.7 ± 7%       9.2 ± 5%        4.5 ± 2%               5.7 ± 3%                          9.7 ± 5%
                                  A+113%         A+126%  B+6%    A+11%  B-48%  C-51%    A+40%  B-34%  C-38%  D+27%        A+138%  B+12%  C+5%  D+115%  E+70%
ssd-ext4:nbd       9.1 ± 2%     37             37 ± 2%         11                     11 ± 3%                           19 ± 2%
                                  A+302%         A+304%  B+1%    A+18%  B-71%  C-71%    A+18%  B-71%  C-71%  D+0%         A+106%  B-49%  C-49%  D+74%  E+75%
nbd:ssd-ext4       9            30 ± 3%        31              9                      9                                 17
                                  A+237%         A+245%  B+2%    A+0%  B-70%  C-71%     A+0%  B-70%  C-71%  D+0%          A+93%  B-43%  C-44%  D+93%  E+93%
-----------------  -----------  -------------  --------------  ---------------------  --------------------------------  ------------------------------------

Here column B is current backup and column D is new backup with
default parameters.

Mirror is still faster, but we are very close to it.

v3:
01: add Max's r-b
02: change to perf.use-copy-range
03: add Max's r-b
04: - more explicit finish status of async block_copy
    - block_copy_async always return non-NULL
    - personal opaque for new cb
05: - new arguments added in this patch
    - no default value for arguments in block_copy_async()
06: new
07: - caller does _kick() by hand
    - grammar in commit msg
    - add new parameter in _this_ patch
    - switch to opposite ignore_ratelimit
08: cancel now is async
09,10: add Max's r-b
11: changed a lot
12: add timeout
14: rebase on x-perf, keep r-b
15: rebase on x-perf
16: rebase on x-perf, keep r-b
17,18: new
19: now only backup.c is changed in this patch, changed a lot
20,21: new
22: rebased, keep r-b
23: new, split from 24
24: drop unrelated change (now patch23), keep r-b
25: changed a lot, explicitly specify options for each env (test table column)


To run benchmark do the following:

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
./bench-backup.py --env old:/work/src/qemu/up-backup-block-copy-master/build/qemu-system-x86_64,mirror old,copy-range=on old,copy-range=off new:../../build/qemu-system-x86_64 new,copy-range=on new,copy-range=on,max-workers=1 --dir hdd-ext4:/test-a hdd-xfs:/test-b ssd-ext4:/ssd ssd-xfs:/ssd-xfs --test $(for fs in ext4 xfs; do echo hdd-$fs:hdd-$fs hdd-$fs:ssd-$fs ssd-$fs:hdd-$fs ssd-$fs:ssd-$fs; done) --nbd 192.168.100.5 --test ssd-ext4:nbd nbd:ssd-ext4

(you may simply reduce number of directories/test-cases, use --help for
 help)

Vladimir Sementsov-Ogievskiy (25):
  iotests: 129 don't check backup "busy"
  qapi: backup: add perf.use-copy-range parameter
  block/block-copy: More explicit call_state
  block/block-copy: implement block_copy_async
  block/block-copy: add max_chunk and max_workers parameters
  block/block-copy: add list of all call-states
  block/block-copy: add ratelimit to block-copy
  block/block-copy: add block_copy_cancel
  blockjob: add set_speed to BlockJobDriver
  job: call job_enter from job_user_pause
  qapi: backup: add max-chunk and max-workers to x-perf struct
  iotests: 56: prepare for backup over block-copy
  iotests: 129: prepare for backup over block-copy
  iotests: 185: prepare for backup over block-copy
  iotests: 219: prepare for backup over block-copy
  iotests: 257: prepare for backup over block-copy
  block/block-copy: make progress_bytes_callback optional
  block/backup: drop extra gotos from backup_run()
  backup: move to block-copy
  qapi: backup: disable copy_range by default
  block/block-copy: drop unused block_copy_set_progress_callback()
  block/block-copy: drop unused argument of block_copy()
  simplebench/bench_block_job: use correct shebang line with python3
  simplebench: bench_block_job: add cmd_options argument
  simplebench: add bench-backup.py

 qapi/block-core.json                   |  26 ++-
 block/backup-top.h                     |   1 +
 include/block/block-copy.h             |  58 ++++-
 include/block/block_int.h              |   3 +
 include/block/blockjob_int.h           |   2 +
 block/backup-top.c                     |   6 +-
 block/backup.c                         | 233 ++++++++++++-------
 block/block-copy.c                     | 227 +++++++++++++++---
 block/replication.c                    |   2 +
 blockdev.c                             |  14 ++
 blockjob.c                             |   6 +
 job.c                                  |   1 +
 scripts/simplebench/bench-backup.py    | 165 +++++++++++++
 scripts/simplebench/bench-example.py   |   2 +-
 scripts/simplebench/bench_block_job.py |  13 +-
 tests/qemu-iotests/056                 |   9 +-
 tests/qemu-iotests/129                 |   3 +-
 tests/qemu-iotests/185                 |   3 +-
 tests/qemu-iotests/185.out             |   2 +-
 tests/qemu-iotests/219                 |  13 +-
 tests/qemu-iotests/257                 |   1 +
 tests/qemu-iotests/257.out             | 306 ++++++++++++-------------
 22 files changed, 798 insertions(+), 298 deletions(-)
 create mode 100755 scripts/simplebench/bench-backup.py

-- 
2.21.3


