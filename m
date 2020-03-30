Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8112073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TAV5oJYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8112073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvHG-0003qZ-TH
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFT-0001rt-H4
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFS-0005GZ-Bn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:43 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com
 ([40.107.6.91]:38311 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jIvFO-0005BI-Hr; Mon, 30 Mar 2020 10:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyLqHoDBQN+up2MIbCUQegnfR5LBOZJXDipWAd6Ny1/Y2TsqLsLH4r/KjNUhLw1WQ7dr7B7X45XUwhbRLFuQK0+L/a/XMaAH6A/ON05LHaOhD4oWB//2oMU29WB0CCTm73o+c5mX3RoGPJtqhlL4LjUvgaZVigSqothz/RcMOWIuFrW3vBSxFFoZOA8qXodVp/NCfOp1XCDyydqftsjBBiNc9FOJlhkGtZgcGbTZSnreYDF2n33//zAANhQz4Vk8uwtNlo3/XRmpmLPRdn+ph6WF5Tn5MgqFlduAswg2Cq08qswsHr0X/bHMKgSvvrhJVPq75VGyXhcUpMjRSLVQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgFFHEqlcA7zJpp9Ag67jpVqiNgzmnJKMP7Pcg/W1QU=;
 b=OysahpkaGCskbNaYVGp+UyjcgC8qtLaQrtIcgypHtn8Wrzhzw+2LaiY5/jCThlWkMGAEWP+5nKHx43qYuUNqirlQ3HG/LycQb99O9HZ2FO3j/2Dlu+O/wU75FDN+wI/2pQmScfJmvDAw1fs3ZLtTgpauAyMQ65pi6BbGyA5MMTD6w3sarOexFC9hoH+dbBhCQ8WPRibmxJC98QwO3CzCeCtQHM4OxKU856u0tIthqaukQkVF1gcXDwyLLbZLBTj5g8BY9HqNXowQBxrg0YsCS45nSCKt8rOkTw2v4uvdB8WgXjVSmfU9DQ5v6uDS2jSw/U7xwBIxsZxiFoynzqojtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgFFHEqlcA7zJpp9Ag67jpVqiNgzmnJKMP7Pcg/W1QU=;
 b=TAV5oJYxvr4pN8DRiRaE63dUV0Yv1ubxgTBu9tL951mytAfcZ5bitO0bAimQXCXblreOvvFQyrt5NgyoNigmD+RD9SABjbpIADi7kvdX6NLZF5mnFWk/LJ95dsP4kNiGYz/GZH8h29UuPY7mCaVQclvqgwLIZHqaUzsqTDWhnZg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5382.eurprd08.prod.outlook.com (10.141.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 14:18:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:18:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 0/3] 64bit block-layer part I
Date: Mon, 30 Mar 2020 17:18:15 +0300
Message-ID: <20200330141818.31294-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0064.eurprd05.prod.outlook.com
 (2603:10a6:208:be::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.14) by
 AM0PR05CA0064.eurprd05.prod.outlook.com (2603:10a6:208:be::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 14:18:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841cd072-1203-4760-2a88-08d7d4b53c43
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382E5C968F45A4C7796C964C1CB0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(39840400004)(396003)(346002)(6506007)(52116002)(6486002)(5660300002)(107886003)(478600001)(6512007)(8676002)(16526019)(186003)(4326008)(26005)(66556008)(66476007)(6916009)(2616005)(956004)(1076003)(36756003)(81166006)(86362001)(6666004)(316002)(2906002)(81156014)(8936002)(7416002)(66946007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOZkq/GnACgqpZ4VUqfye9JG8Ysvv35EZXMmjpCXXTx8rQtvQrxtRlDeRX5BTSV43oixUIELDR2BAHL0twEoHzvrs127x8O5+JHcA3en68gfuk4fdrBEkmiDliKVL70nnh8RJ/AThm0Dl11dF+0mxU5v7A+nptBsuNyGtAoIwx4QwXazctyhc3nomOiGjv9lbiwMaX3jw51jYTUF8IEBddpUyuNDxSrUwvDaYeveGc35/LepBk53CG4miKS1Z39s//EMRWLPmvwT0lmjsbdndS/uClj99h3ttHo8QGy2sZE9QIYrmlcs7ViwhrFNNnbEUGHcHZh117l+K/Lb+GLGUy3nbCXH9CYua9ok7UAnCh5oJ39X+jH+8QFcmRGaRbQP5DqRvN40+3nhfRu46tpogRnXV5muXoUm3Us0ddkStc0DnI4jjSLho8UBbLI4I931
X-MS-Exchange-AntiSpam-MessageData: P7CWX/ZKEkpomXMLzpn8/gjorFZ3jiqEtHC+SurWbXuMYcxVrVUcSIx6rMOnNlJisO0dx6n3NixReF+naZQdC2PFzTCzseqKGaYOXvPOlv7VzF7xeynOq2YQICPeOGZIVQhgxqJRRmD4NMxtLpiWwQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841cd072-1203-4760-2a88-08d7d4b53c43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 14:18:36.2911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtmJAvDuR5ShCuCHfacU/vi5vVu81Zv/MRCL9JhZlPLzY8bubKi5bX1uQv8lMILvH6xb43GbSbq4kteV5HfEqFtjU5mipYxbR0K5H6PqZmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.91
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 berto@igalia.com, stefanha@redhat.com, pavel.dovgaluk@ispras.ru,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

There is an idea to make NBD protocol extension to support 64bit
write-zero/discard/block-status commands (commands, which doesn't
transfer user data). It's needed to increase performance of zeroing
large ranges (up to the whole image). Zeroing of the whole image is used
as first step of mirror job, qemu-img convert, it should be also used at
start of backup actually..

We need to support it in block-layer, so we want 64bit write_zeros.
Currently driver handler now have int bytes parameter.

write_zeros path goes through normal pwritev, so we need 64bit write,
and then we need 64bit read for symmetry, and better, let's make all io
path work with 64bit bytes parameter.

Actually most of block-layer already have 64bit parameters: offset is
sometimes int64_t and sometimes uint64_t. bytes parameter is one of
int64_t, uint64_t, int, unsigned int...

I think we need one type for all of this, and this one type is int64_t.
Signed int64_t is a bit better than uint64_t: you can use same variable
to get some result (including error < 0) and than reuse it as an
argument without any type conversion.

So, I propose, as a first step, convert all uint64_t parameters to
int64_t.

Still, I don't have good idea of how to split this into more than 3
patches, so, this is an RFC.

What's next?

Converting write_zero and discard is not as simple: we can't just
s/int/uint64_t/, as some functions may use some int variables for
calculations and this will be broken by something larger than int.

So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
.bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
drivers updated - drop unused 32bit functions, and then drop "64" suffix
from API. If not - we'll live with both APIs.

Another thing to do is updating default limiting of request (currently
they are limited to INT_MAX).

Then we may move some drivers to 64bit discard/write_zero: I think about
qcow2, file-posix and nbd (as a proof-of-concept for already proposed
NBD extension).

Any ideas?

Vladimir Sementsov-Ogievskiy (3):
  block: use int64_t as bytes type in tracked requests
  block/io: convert generic io path to use int64_t parameters
  block: use int64_t instead of uint64_t in driver handlers

 include/block/block.h     |  8 ++--
 include/block/block_int.h | 52 ++++++++++-----------
 block/backup-top.c        |  5 +-
 block/blkdebug.c          |  4 +-
 block/blklogwrites.c      |  4 +-
 block/blkreplay.c         |  4 +-
 block/blkverify.c         |  6 +--
 block/bochs.c             |  2 +-
 block/cloop.c             |  2 +-
 block/commit.c            |  2 +-
 block/copy-on-read.c      |  4 +-
 block/crypto.c            |  4 +-
 block/curl.c              |  2 +-
 block/dmg.c               |  2 +-
 block/file-posix.c        | 18 ++++----
 block/filter-compress.c   |  6 +--
 block/io.c                | 97 ++++++++++++++++++++-------------------
 block/iscsi.c             | 12 ++---
 block/mirror.c            |  4 +-
 block/nbd.c               |  8 ++--
 block/nfs.c               |  8 ++--
 block/null.c              |  8 ++--
 block/nvme.c              |  4 +-
 block/qcow.c              | 12 ++---
 block/qcow2.c             | 18 ++++----
 block/quorum.c            |  8 ++--
 block/raw-format.c        | 28 +++++------
 block/rbd.c               |  4 +-
 block/throttle.c          |  4 +-
 block/vdi.c               |  4 +-
 block/vmdk.c              |  8 ++--
 block/vpc.c               |  4 +-
 block/vvfat.c             |  6 +--
 tests/test-bdrv-drain.c   |  8 ++--
 block/trace-events        | 14 +++---
 35 files changed, 192 insertions(+), 192 deletions(-)

--=20
2.21.0


