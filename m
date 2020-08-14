Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C50204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oThDYmKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C50204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZQY-0005qR-AX
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNo-0000vX-Lg; Fri, 14 Aug 2020 09:04:32 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNm-0006by-F2; Fri, 14 Aug 2020 09:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvTvbiTm9cxiWTcR/mgqm7xFkLUciVqmgTg9JENHlO5kVgxLFrlrwlDsoH+Xl2qI3McJlIVYcllKaQk+mtUU3pyzjktC65v45aBUZzZMJB/iBNZT78Xb8TEvSG73RBimDuvdN5JOy08ZvfHFdPHOmfwxL2++jHJIxqXS2LlBI6aTNly9IMraAs8Ls+tyIsH30tJfNeaeBW+nCYA3D3mt89Fnxz5B4ablpNqKnIstp3jJY+i2oAE6jD1kV2IhglhyLv8Cg58qKego8WPBfX2PkgN54/umIvU2/0motsfE25pDBVOm4xVG+UdAGPV4V+ozCQDeY6tib54FMlM2seauqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwpMrQJ2k9GYrNZAWXic/UdsNjcyrHJlGpmttrF+uB8=;
 b=cj54rYzohOrIptpIfOXIJUx945lapCqgfU9L/sx0xj6bnrU9g2Ssm1OeFplyFpK3aw2RmbEd1XM94eraynGphCGn4090JFfjvfYS06Cm2+R9jZsndoml9HMn91dbD4GQ6mvyQwsuidPRFOjaM57NsEnAcd2AUCdWxai3JkXGmAUuzAIXG0hAP6rvu7iGF4Kp7P9/p9/A/n7OVU2WmTEat78g7MDcNg2YP11butUoaNlclWnCMlXGwfidnSM1j1fPZq+LeqnZBqaZk2l3Ix/mtCjsIrbnZYCuhURhFkeupE/U9MLTJTDU8Je+9iCE/uWyhlWm8T54qu2EzpZafG2g5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwpMrQJ2k9GYrNZAWXic/UdsNjcyrHJlGpmttrF+uB8=;
 b=oThDYmKU1n+w0ZIb05T076stV1tFQp8aKphn829ZutkupJLHSeby42YChaAIso8Wo73lN8dlw8iBotKDprEH+5BXjynbM53547tUxGbI6//Xl7BsPMragFKpRfJ6Lkh17Frsy0/F+uEG7rBt7nOMuJmQgH7mr/qG0mnN3zSl3hs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/9] preallocate filter
Date: Fri, 14 Aug 2020 16:03:39 +0300
Message-Id: <20200814130348.20625-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:18 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 520bf78f-4c2a-40b5-28c7-08d840528e65
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29814E3A5B97FE1482A85F55C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DesZtzyJ6Bwz2O9rbbAe6hdg27q/gqClj2UP1VmJhkzhtceguyO0HVZGangeiVRFzu50vYb2dlRcY0Hrc4zt/usHYCsWHoCaVV5wnqSS/+8rzLIffRwo7xq9OgqZ+eF6y7WVhjWC5d2hjtSq9kkOBJ1VOjf6kYAiRHWul+AQH6MXXM1A9Cid5q5twwxKlCJoc90qCg1tje2Ma5J3R0EIigU2w01qIqeOI9PqGbvmcIFQOnY5XXng44ywqMH2IdbARvMzt+ot6k2ryxzVTWPNq1iXWsH3mvnTdAeSL9JELCvKFqXZi/PumOYtxmtQzVPdUYtGqsVUFe1lSU3AdxXsGcifCBBghlm7yIoP8dg88/vmOauCT06kwt52AhOBykVdCPJTk6BeciSPDSB2ynAfnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(966005)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9zhvhT4neDmkYHgZ3pUggIau9yNC+eW4Glqr5p3bc716ZRhBu867wmhGUpI8qBlsp0X6TjGn8iDOG29NFvqavKR11CmFYmcQRTmXqkKOIZDV8GosM5s5tpCx3UUngHYKWapi2Jss8eloNvZ8WnXkTSQkfcocUIc/rCrXW33hIDCHPqxRygRM3N3SMM06K3FXGmVhsmkzj+BWAeMXu9Q6mnTKGXpX7sozNu7ldLY+hOWHG5j91u6FyXIh1Azog7LsaNDYMCETq7Y2OyVO8F34GREPEJVPFlfvzCNIomjSex/jcQ0lS8ajS8rgoY9+d58zYrP9f6x+hDOxc/13WOOxNTucdeQ+q+DyE8C8SIrPP6qKP5HbjqABHrNgDuGtxATFLUCBjzPjb0QUJZriRpIjf9rdt1W55h+QA+7441fs//YwQKcvUGNNmJoA1Alpb6zGNfYEmUwWQNUszJIess3OP9xv7S5/ftQzrOvCkWuHEJtxsVYqN/aeU8H6gCUzsI7mwQtNpfjPZyXId7+nKyvN8ZXgIJuXqJ2WlRPMuxM3se1eNqrFN2AGi3KPDxwfXWcgbJ0wWtFHRgs+tdPOlevmMvqV8Zrf9IWJivSCgBTq/86lugwiSQuZvm28c2QpXg4UueADTXy6KQeTfg0fajkRzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520bf78f-4c2a-40b5-28c7-08d840528e65
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:19.5496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrYd5cFJTFaT0LQGYMsLZV4sbcKTS16x6T1xC10MFTw84Hzkq+02xCYBc50uAU9LKTxwXAoRntSF1wvPA51m/LbaaKRsbeK0nDGkanYxl0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:28
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is relatively expensive operation. We have to
workaround it in Qemu, so here is a new filter.

For the details refer to original cover-letter
"[PATCH 0/5] preallocate filter"
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06443.html

v2:
1-6 are new and substitutes bdrv_co_range_try_lock mechanism used in v1
07: add note to docs/system/qemu-block-drivers.rst.inc
    add open options
    rebase on new BDRV_REQ_NO_WAIT flag
    drop bs->file check in _co_flush()
08: new
09: use new iotests.verify_o_direct()

Vladimir Sementsov-Ogievskiy (9):
  block: simplify comment to BDRV_REQ_SERIALISING
  block/io.c: drop assertion on double waiting for request serialisation
  block/io: split out bdrv_find_conflicting_request
  block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
  block: bdrv_mark_request_serialising: split non-waiting function
  block: introduce BDRV_REQ_NO_WAIT flag
  block: introduce preallocate filter
  iotests.py: add verify_o_direct helper
  iotests: add 298 to test new preallocate filter driver

 docs/system/qemu-block-drivers.rst.inc |  26 +++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  20 +-
 include/block/block_int.h              |   3 +-
 block/file-posix.c                     |   2 +-
 block/io.c                             | 131 +++++++-----
 block/preallocate.c                    | 264 +++++++++++++++++++++++++
 block/Makefile.objs                    |   1 +
 tests/qemu-iotests/298                 |  46 +++++
 tests/qemu-iotests/298.out             |   5 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |   6 +
 12 files changed, 457 insertions(+), 68 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.21.3


