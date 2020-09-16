Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E77C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEED206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fyBA4L6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEED206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWf6-0005Vj-62
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQM-0004Xk-P9; Wed, 16 Sep 2020 08:20:38 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:3150 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQG-0004Gb-UL; Wed, 16 Sep 2020 08:20:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqqszoojw2SD09ZJgERt9JMPYWM9Yywf7aNMgl8pOz3yfUsyzJQof8Cre9Bp6fnDl+SZCpzI6Q73giYJoXk2xC/1PguyrJ8D3pZW++EDcFUY5LZlZUBZ4+x0409iR/WTVwYbD3ouQ+nSl7BAcsIUWscdEzCTHEAdANlr/bILpuI3ssaYGcZUT9zyvAJGA1HMBftrORc3S+6EWAqEHvQPaweK9p9yLHbJLb+PDnYOjXy4uwGTapq/2uLkT+COqe61Mkm1ivAfHsud60wcAzjlvnzZJ8CtrBqSILLyCJ0WRpYhRRQi/5TICnoX729dnIjbKJSQu1dyC99WLyTUJ/9Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85ZGrh1SNnrMBuCOlRazjGESFkLnEFbSWpzqpOiPd/8=;
 b=BXgj0fc5qXz8QPfOzTecUgbo0PhkxV80LsfT11lZABxVMrQn1RADA/KbwL/EaTH3yd/aeeCay+YoIjfyR54xkxH66mbRzw6y+QsF4RoayZXjZXfrJemn5BxyPBHQtqOpKvp3k2nnAbEW1kYANsI9mp/x5L+0xIJ/P82wbRlmI2OmInefFZGJ4VTCz8AosmmxLGqyZD0aVSb9BDukEUAG3VJvYEWzACET2cO05dUNmEtTJnNbUrqiJ0AXpuU0uw3Z6YFMyWHSxq7GRGgPA8DxK2TAQN/8uFW3FMwAYB4ejSFlYRyqOibYXq004i316oAgBpsSr5ez6rgebcje72DQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85ZGrh1SNnrMBuCOlRazjGESFkLnEFbSWpzqpOiPd/8=;
 b=fyBA4L6A58lfx/4TDYV+jvJI/nE+WUY9WALJAEh9J7yLuWzxnuhBlYHJjnDaeq1GhVeHMFVDRSFkcWFsr093d6H/pr53pXjM+/zFan24IVjhhSZ/J+6WAtDrQPEAn+gl3spbI1R3WFpiCfIjiZ8gemDwSlfkrNJJIG93o8xov5M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:20:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:20:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH v6 0/5] fix & merge block_status_above and is_allocated_above
Date: Wed, 16 Sep 2020 15:20:03 +0300
Message-Id: <20200916122008.20303-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 12:20:22 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb0a542-3288-47d8-f87b-08d85a3ae27f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5077BCBD154E175CBD07A01EC1210@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCRY//qFUI37xwkyr+PMqbmSDVcfwlNr7vSIFi9Y001Byu0fMGI/X+PXmZCLWXcznIv8xs5Lo2QZYGYCQ8uk1ewqdsooIOVp+ZKelnkonT5AxlxTUfdsOwxx3kZ58REbXrEyNzqNsVBySwg8Q7wECTMpHxq3ONNpTwkdhgda5EUbnt6orWdWdE01RS0YoNIFyRXLEZJOI5WsrXGgS+CKRvxAvtBbF44yVjjjVRlRYsbAmkjSeP0eJudw6PFVZpxiY9rv8gZCNcTd5tv9kdAbk6We1cScu1eJmoNOTcjbGSqFKTWvJ7QSoSYYO3mQzqSJm4KQb67VinVGyTW4+bcXXGl16bM0g426Pc15KDr0qepsvC3MLZONdDPHEEA9KhvbjZ4KGlTZ/kiSI9y15Y2bRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39830400003)(366004)(396003)(26005)(16526019)(6486002)(316002)(478600001)(6506007)(186003)(5660300002)(6512007)(2616005)(956004)(1076003)(36756003)(6916009)(2906002)(966005)(8676002)(66556008)(66476007)(86362001)(52116002)(107886003)(4326008)(66946007)(83380400001)(6666004)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dXpBDP4UDA2SfXBy10GIix30pVTeYT1hM+tXwuXXJrJLSfUawKJhbOIsfpruk06fVcw42bzkqn81zTe7JTX5+e2qsrPVSAWnjSNYrlxOp2lFG6mF1cRQqkI6dhDu4G7YMl388eEDo1izdi/MEdADBkPI8eu721BFfuF1NxUOtiQrFaCm32TsIQoSdLS45CHKAjk7wmmGQHg/KVNs8T6v3sywrDub/fbx+lFkx83IHzBSZo2MHhVla+AAgB051QRAyD0Z1hglvm3fNWF5W0IT13mneNAYngDGNehkvnWg/OMg0DPCVb6srzKz7LrWOSbwvZ/vgnyKu56HkZ/68ORbUAj1cT2ccKairTVMXhHkpw/vBApHvd2lcJWJ96xMjnT+G26/vmgPO+czHzj4vKUuoBiZdeAwkO4NAyn36BqCnbf+r60qAhJmCpCHvi31Uq8auXndr+dF6CbLDLxJW1qnsSS4bc19UmRgURUko+mL5SFDaSz1Ad4AHFmKzoMWRCPCz+SvDPHLXjrp6B8FRFZvxs1NDLXerCV2Hnnzsrb9F2b5lG1HImQqdp0SvWkCSyoVi19QOERcGXsX3O7MHhNFHd5J0wY6TfjGVoWQeMOxPuG9HRvivYnVSqq2lEnNXAmJs028MQFYWu5R5SptmOgsbA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb0a542-3288-47d8-f87b-08d85a3ae27f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:20:22.9825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4/p5XBCN+FPwAJTvPFdn5xiXjTzD2ksOC1Da3BqFrtHWju5lYxz5gnm5B3kOpyhXgcZOyBlAK63/UaPJXvc5DKWC2IicSD70SvIO+ugltY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:20:24
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

These series are here to address the following problem:
block-status-above functions may consider space after EOF of
intermediate backing files as unallocated, which is wrong, as these
backing files are the reason of producing zeroes, we never go further by
backing chain after a short backing file. So, if such short-backing file
is _inside_ requested sub-chain of the backing chain, we should never
report space after its EOF as unallocated.

See patches 01,04,05 for details.

Note, that this series leaves for another day the general problem
around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
vs go-to-backing.
Audit for this problem is done here:
"backing chain & block status & filters"
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
And I'm going to prepare series to address this problem.

Also, get_block_status func have same disease, but remains unfixed here:
I want to make separate series for it.

v6:

01: handle EOF better, don't merge reported ZERO-es with automatic after-EOF zeroes,
    handle first layer out of the loop to make code read simpler. Drop r-b.
02: rebase on 01
05: update test output for extended l2 and backing file format, keep r-b

Based on series "PATCH v8 0/7] coroutines: generate wrapper code" or
in other words:
Based-on: <20200915164411.20590-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (5):
  block/io: fix bdrv_co_block_status_above
  block/io: bdrv_common_block_status_above: support include_base
  block/io: bdrv_common_block_status_above: support bs == base
  block/io: fix bdrv_is_allocated_above
  iotests: add commit top->base cases to 274

 block/coroutines.h         |   2 +
 block/io.c                 | 126 +++++++++++++++++++++----------------
 block/qcow2.c              |  16 ++++-
 tests/qemu-iotests/274     |  20 ++++++
 tests/qemu-iotests/274.out |  68 ++++++++++++++++++++
 5 files changed, 175 insertions(+), 57 deletions(-)

-- 
2.21.3


