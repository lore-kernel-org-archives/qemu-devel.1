Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6369DC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CF02076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M5dPu2f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CF02076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Ab-000142-7i
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78O-0006q9-Cp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76s-0005EN-TJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:40 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75f-0003SE-5q; Thu, 30 Apr 2020 07:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3NAxU3NQ3hwMDY5vscz/hcFGrpB5gvZKSxfaftpv4H4bm+QUI87svVfcOxIufxmuh7a/tUtzDzJ7EQmvy5DqcaL0yIt+7/P8elvpzmZJ8QoLO7jebAilOkdP51jpKQW90s025TPNxY+w3CNi7qFb4+lYBJ7yCEvA3pPdSr4Ts0lsBb7H+GtyCS0gjDZXuA2zDBxAsuGh4Rvbt094TAZS2sIfBQDbSyZRuX8WUGRl89PKJOjupk2WAwJftd2IxISzpt6zFE30GsBMFcS8CGWkKtiM8+5oxeokFh0GlBfP9XwbF5WI1Sd9uXdhf0bDA4/IGYK828xRXrtbupjW0zLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmSkGO6lXXAsVZFGIdC5DwIwsvBz0bgBg9Y5ZP6Ysu4=;
 b=fhFWM4/u1xjrjwrgB/EGyV7PCzkO6kQjlOm6PZYQXGb8T3/AqlvdVqpnyI0bo8aAsc1jGtU6hugxLPC+5p9Qn3YmKLN7wW3c30ipRVhnyBRzic9MyMCD8x0wtjJKf+4pHpqjVj00u/5jDC4DfnVjrnQCapBHjTmmNxmcXpOZyP9XpNHMLK2bxuCAI/AupbVmRB3YUfUqJMhMJ7CiB48L+ymXXoRM7M84bPhgiIORMrt8R1wq0v9IXQIbXutcivDA6pLkTH42hhHuXdJbdHbQGyn5ceo6lD7Kpei1f3XSuu3GZOIJV8IRiIzjTveDMjE4oXEN7SIh8Zm/la3d8xg7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmSkGO6lXXAsVZFGIdC5DwIwsvBz0bgBg9Y5ZP6Ysu4=;
 b=M5dPu2f5nsgeFWWqcsk+WL6YfzQqjHCx2/Gk9XutKk0YymTrmuZ6zUvKnCE33/N5AUiF8XEW7xvJcuPkjVUkdr2AEXlc8kpfepW3jPTb91G8rCQBoU+x7ZIcrDokwkeKjFbp9P4hUWnwOmGDe7peh8uagdK+SUQPfw41+E3oV8Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/17] 64bit block-layer
Date: Thu, 30 Apr 2020 14:10:16 +0300
Message-Id: <20200430111033.29980-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a050737-2e43-4048-06c4-08d7ecf72239
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399182358548711E00EAEC3C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7V5Qi2IM8bH8OvYJG2SImk64gOvWG89W9M/kiIHlk1K9sn6ON7P9Lewy4bfuSnhSC8rMicnWRsErxnv2MkI8FGrj88iCMv5XWt4/olKbc7G99uRn7u8AE0lkdHJ+1c31GW46lsYXYBxpskqJleG6ZfrdwTLoS8WXbbiZLm2beHInMhc09uKE3JaZZSmsa6XTwoCjr/+oRBZipL65O/d+/SRGxc6lg1kWiWZQYdbCx+tHI9/m53cLaOSZt+I8dV/n3SNFKCF5WekT1BX7RAe29eB2UbnCdivW4sQSddulm8zE+V7xTtHoCzodZsuGhB44/7FnEqEh0sQYD3Rnh9y6rH7TiLGJbqixTM3kXXkQAhvsZMK62HzbludxIyRzyq8cQHe/OTHrS6b60bSRRkqQh5/OPOXG1MOZxkXPPrMdeOKloYWDVbkO1VV9wH3z5SUgi5G/g6CoY5x/M/l6qadTwZw7JaDGE2wT/I//e9aDU7x7KAl1siq1nbHZIl+gkFz4RRd48QEW/Pwec5Fw6Lyiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(966005)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y1mQy4ijtUJUQ7Z+7O9T02YrIGmlU6hQKGwLrl5LoyF82e0W+jmyflp7UwfOcTn2U0R4543/wjvbZPh5+VeSfH5QXIqhS5+0dfzsA0ZX1qgxRwV8VRc6NEzxo4jjr7JmqYehjrts88bJOF3qixFBn13XrpYGkXiXujviQQByndX9Bz3B5qsb+4qdtAPZ0OEKIn4cCDKGdmxiWDIgw+f5lEAYv7nSvWofBTn/7QwX5nvp/Q+nvi62D1ailxlcxPuCbO2NoPD4wAyLU1bOMRrx6fLIuQqsukbg5hT0PrlzvC6TPT4f30DXzS6WhR1j0+TMIIkc3aHVloJJgtMLV+oF7xBhVrdqeoBUl9mdKb8+UytgwvLOXoPtkdt1Q9O4LZIlIuHx7A8loqrZPx3k5on9e5I0IqEmv2AS9KIVIe5macUQpI6kTpiTEEABsHfmCt/oAK91gUyIbLD1Vyufy/5qpi0GkdoGfja0ftpDH52lODEVWCx0eVTtjHl11xRpT1PMGN6Db76LaD425FHdkFPEqX8JN2oWzj3ssE+3aN174F8WHkCi88LyHJyLPFANuDJUvxfva6yJbFws8vPd6AbMWUSXM48j0yZsVQHb5wGeQgc8d/Geag7WyhlnbUPlyWyRd1LFxodxJEg4Ggi6cO7h8zxk61kMqRiH/XoO5LBURCn1M5uLtv2ZhklK2RlgT1Nj7po9/FuaS214SNfTWZ7j0AHm2hCbS/ZjO+QoqdAp12WjuSqGdultnc2uW85RE/FpCmlscz2P7qbiD/jeshDjOCSXxAARjyNphqFAvX9T7Qo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a050737-2e43-4048-06c4-08d7ecf72239
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:47.3346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y2ChtYvnleoazn5/phDy24fIEq1tZohtHrAC2YCv+EITC1hz5WeyI7TMdcfPLRBKRy3jCqUZwT78/DtQuNVvS1FDkblNsAhTVPJVUP3wiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:10:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We want 64bit write-zeroes, and for this, convert all io functions to
64bit.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

Please refer to initial cover-letter 
 https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg08723.html
for more info.

v3 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-64bit-block-layer-v3

v3: Based on "[PATCH v2 0/9] block/io: safer inc/dec in_flight sections"
Add Eric's r-bs, improve commit message with short reasoning of the whole
thing, and Eric's audits (if you don't like something, I'll change or drop for
next series).

Add "Series:" tag to each patch. Just an idea, if it's inappropriate thing,
I'll drop it.

01: add assertion that bytes > 0
02: fix indentation
06: refactor calculations in bdrv_co_write_req_prepare
09,10: simple rebase conflicts solved

Also, cover more drivers by driver-updating patches and fix int flags
to be BdrvRequestFlags flags.

Based-on: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Series: 64bit-block-status

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

 include/block/block.h           |  17 +++--
 include/block/block_int.h       |  67 ++++++++---------
 include/block/throttle-groups.h |   2 +-
 include/sysemu/block-backend.h  |  26 +++----
 block/backup-top.c              |  14 ++--
 block/blkdebug.c                |  12 +--
 block/blklogwrites.c            |  16 ++--
 block/blkreplay.c               |   8 +-
 block/blkverify.c               |  10 +--
 block/block-backend.c           |  60 +++++++--------
 block/bochs.c                   |   4 +-
 block/cloop.c                   |   4 +-
 block/commit.c                  |   2 +-
 block/copy-on-read.c            |  14 ++--
 block/crypto.c                  |   8 +-
 block/curl.c                    |   3 +-
 block/dmg.c                     |   4 +-
 block/file-posix.c              |  46 ++++++++----
 block/file-win32.c              |   8 +-
 block/filter-compress.c         |  15 ++--
 block/gluster.c                 |  14 ++--
 block/io.c                      | 126 +++++++++++++++++---------------
 block/iscsi.c                   |  34 ++++++---
 block/mirror.c                  |   8 +-
 block/nbd.c                     |  18 +++--
 block/nfs.c                     |  12 +--
 block/null.c                    |  18 +++--
 block/nvme.c                    |  38 +++++++---
 block/qcow.c                    |  16 ++--
 block/qcow2.c                   |  34 +++++----
 block/qed.c                     |  17 ++++-
 block/quorum.c                  |   9 ++-
 block/raw-format.c              |  36 ++++-----
 block/rbd.c                     |  10 ++-
 block/sheepdog.c                |  11 ++-
 block/throttle-groups.c         |   5 +-
 block/throttle.c                |  14 ++--
 block/vdi.c                     |   8 +-
 block/vmdk.c                    |  14 ++--
 block/vpc.c                     |   8 +-
 block/vvfat.c                   |  12 +--
 block/vxhs.c                    |   8 +-
 tests/test-bdrv-drain.c         |  16 ++--
 tests/test-block-iothread.c     |  19 +++--
 block/trace-events              |  14 ++--
 45 files changed, 488 insertions(+), 371 deletions(-)

-- 
2.21.0


