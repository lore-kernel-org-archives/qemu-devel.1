Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D67204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M4hauGED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D67204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97pb-0004Xn-SI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lf-0004zw-0i; Fri, 21 Aug 2020 10:11:43 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:48515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lc-00053q-65; Fri, 21 Aug 2020 10:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUyN8YHK28YODPrrHqc1dXZu+md57G55p0SFzw/tBazh2PeHfbRrvI0jcQjcN1E4dEfTfqT2vfjKffdtNQtXDntskev6xIFXZKg3jSgpAzpBBtKUjMQVrrSOGCW+DUQIavPsn1GLtdGEruJWrkFOFyLHcHUhk8VNflla8UKx0hXn+GyPTf0rWwajDY6ql7API7nSn81FOJxpfafugS2Jxrg7Tg136V4b9zjowEn+kDOO9bTlIyxNYE21q6uedy4f38KIiVZeX8dgZdAO11dC5bzHTi3Ma7oF7oZ3WI/rfieNaWdSq9WM7M/6ZP0ZdYjIAOy7bH2+Y2GmvZIPHOJJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MKBYu7tAY49uzfRD5yJ7/vN+qeGozCeyxwb+L5OKHs=;
 b=cUrpBOoNuj56U0JSeOUrvd5h4JvSM6BAHk6i+AUIm9/yNBa6UkmTHKlusAFGKAZPexKWvymEl6puEktJfD9JoES8pOWKrau9OJ9TaqHiZu7erlG75QZnWYRAGuWU/GszENuXRWt2x2+BtiYhvdHpmHjdODIP3xGsWIzWRm2FI7puAYccr1JdiQSvpjylcbAow+CgSmPgEegydWhooYLjhkRdXjUs+WaWFNnYAT1J6B6RbnfB2/GKZHybO3QMT1iY4j0JSy+PpaMV2TviXFoHQHeb2JeITmukQNd1RhEeNGYRLtXfT3bLgC7zS4CGmahAZp2NnicC3IQNPB8AgaFd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MKBYu7tAY49uzfRD5yJ7/vN+qeGozCeyxwb+L5OKHs=;
 b=M4hauGEDl2BB81S7tg58jWRuA6Im0xuCUcERX2GILV9qWB9IcLzS00Soq/yJ8pbyrLaRGOQFIW3lBfVU9qI1/hpw/9QlGn3fIq0Ws4gTXeBVhqwb/vxVzmYkoiUvjyjcokGSAGeTUCw/7guu6TEWPU54638naK5bPhSrlwuYh3g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 00/10] preallocate filter
Date: Fri, 21 Aug 2020 17:11:13 +0300
Message-Id: <20200821141123.28538-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:35 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7eb6742-2002-4483-d100-08d845dc1d7e
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253679A374493EB373B917DC15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dl/vMV3tQg8LkUCeOpGM0Nsoac9v54LLS2iCcek4n9tXpjGG2rd4DNeVQBOHlcF99UbZ7uAYv0rZa7NYUptpy2ubnvQvtDseDuUf0OAqOlJHDm68UIQpu5wYCXYBwS8ALJWvvPtWG044yCEdCCmERzVV9z+6nPBbtfuy8rZlxt14jkZICHqNYkFWsN1CaO36F3DeAhSSStjHITYLIPe3xwRVcFsbLqa/fmfCdCOlodPvpmGp1Hn0m0ksQSYrHXOf8uiJJqnm5h8wXg5CnfdKbEFymv5zVrwH1oNldHMpNL/S3iQB59ZGPIFJNaOhvsPg0R6jUUmYN/BbDjbmeQRydA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D2yntGVgtMuxUmnXIKlLkeIiYdfyGqkKec8RC5e8QKmOm/p+HebH02UMKFE0HFs4JeVGvBDzppplp6Y72amD5to6Z8mjC4Ork/RbZV3kaYGimijjrwog42E0vJHo5N5NQDdlCXfpa4WT/kehmRpPVv4MU+xUJdvDxoltNHl0rTH43KssVqI0c4l1bIxJ2AhODoBSXmQSEgesMeqrGSVw7iyyqMzJcvjrLkMwhZO1tyz0U1Y4xGnNqPEbwoCgwoJFJZ8rajP6rdzGfjiXinNmpDGx2u+6i6mY2y7U3lTWhT/sWZJ/B2VKB5AneG7/QSjiKJrQJ9vV0+dpCe5xy9HGdL5oHzF20uInWvNazKRVhxlV2kacmL9Ce5jmoXTBqt2INsdxsXoK8sy4naabCTqSKr+iRkkOUUksmq6M6HNP5OmjDn3DfyZ0J0LjTYWazGrvx6SotrOOL90StbKDIDoQujW7qgtzurpab7PIKumjnHFPh0HecDbCG4z7JbtKEjzED4elPzVktmXrG2MZr/l87PyNi5qNc5g1g7xWemzeDgizRHCNeSIWduuN+zdBTFIp0e8gtJv2dDvx6+mS1HbZ+6uApndy88hutUcFvIXBqCDZCgtPu/k2N0wAXXst/C9A7+Kde3uYqgXlifbJZ435oA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eb6742-2002-4483-d100-08d845dc1d7e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:36.4360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIh3dc0xMu8dO62LM5XDWZTKWyZ9ieNBfcjVqAqtFGfZQVnTTFB/fBW4sQjaxhRo+MARDC7ZgbiBPd4WeY5Cu68EDHkfzuZjurQSPmfMv08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.5.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is relatively expensive operation. We have to
workaround it in Qemu, so here is a new filter.

v5: rewrite patch 08 as Nir suggested

v4:
01-04: add r-bs
05: add coroutine_fn tag
06: use QEMU_LOCK_GUARD and fix reqs_lock leak
07: grammar
08-10: add r-b

Vladimir Sementsov-Ogievskiy (10):
  block: simplify comment to BDRV_REQ_SERIALISING
  block/io.c: drop assertion on double waiting for request serialisation
  block/io: split out bdrv_find_conflicting_request
  block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
  block: bdrv_mark_request_serialising: split non-waiting function
  block: introduce BDRV_REQ_NO_WAIT flag
  block: introduce preallocate filter
  iotests.py: add verify_o_direct helper
  iotests.py: add filter_img_check
  iotests: add 298 to test new preallocate filter driver

 docs/system/qemu-block-drivers.rst.inc |  26 +++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  20 +-
 include/block/block_int.h              |   3 +-
 block/file-posix.c                     |   2 +-
 block/io.c                             | 130 ++++++-----
 block/preallocate.c                    | 291 +++++++++++++++++++++++++
 block/Makefile.objs                    |   1 +
 tests/qemu-iotests/298                 |  50 +++++
 tests/qemu-iotests/298.out             |   6 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |  16 ++
 12 files changed, 498 insertions(+), 68 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.21.3


