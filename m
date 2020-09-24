Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1CCC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6B52399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fDxNC6Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B52399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX8b-0003e5-OM
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6M-0002BF-PU; Thu, 24 Sep 2020 15:40:23 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com
 ([40.107.3.93]:8707 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6I-00085Q-KT; Thu, 24 Sep 2020 15:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7v1I6Cyw15E4siRtZBZWndYB4DMGBwrvq6y5zNvV8MKKdgE7TKWWUq7ycwUgXffioVYYhyiTYh08Jd2MpQ3hTENdMM/PdB2HPhIofjqhSewYEjMC7bYEri1/RYLMNagxbUs0R9KcKOaRNnNtQCy1U4V3ONiqVWeGgKo6BpnrGOR2Io6Majc0Y4KHtwdXMWLuZAoDKLgyTNJQlbjMHOMVGnVSX+ZcE3O19oTJTY4Zf01XjirHzlwqgu2zixYw5OMCGIorjLbZHI42UuNqg9I343QOqrwdZSLYPzj/Z1Emk9g+BRDLuh9bx1EGgyhWwIeB0jIuPfK8ZDLfm8nxSIGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR4SmiMJjFaV7hM7ZXLJCO5BXBcAylb6hYbkX7RZeH4=;
 b=lJH50pHjOzKRafP1URBZc/cqw4vTSp31Vyh1jNUucnFU5GNK68Nd4F3TZbC2KA8LPxEsMpGkNeI5MhLjFQGlD4afBxE4dswtZHHStwtAoqwIi3q0/OjwEJLbVlJPcpLkLSDUMZmRfniHCIM81Ik8+X7YObQcrYEUFmgVkiV4BoqYoq2Jpoy3SXNERusZu20gwlqPdr+thza4GP8UvOAAXkrTfOdGLtMRI1EmCSHwAOTw+oIZt07u1qFjJiy6Gfjx2ExjdXaeICZVq4TzO6aBfdsEUNpsE7t1drmZehxFAUzGLVyll8Xw+1Vh2JxatSYxpMJL600I6237oLVW3ihUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR4SmiMJjFaV7hM7ZXLJCO5BXBcAylb6hYbkX7RZeH4=;
 b=fDxNC6KaZBRUYJkokDIF7weiUNM1dHd7tW5X+UQTaqpA2Dpaua+YZCCkp1fYuRFIgdiPmoIhPaUYRUJ9Ue/eNt9gYY/7Ty/WJ+GygPvqYxoTaYJJaTZ/M7eLYQo9/P6dbfxmLvREODfWMM/nqAIFfy9gRNkdJiG/1yjuQIjWM2E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH v7 0/5] fix & merge block_status_above and is_allocated_above
Date: Thu, 24 Sep 2020 22:39:58 +0300
Message-Id: <20200924194003.22080-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0112.eurprd07.prod.outlook.com
 (2603:10a6:207:7::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:13 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c88021d-4fd2-42be-cf45-08d860c1a86f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32885CF6B216D9D5608CBE9DC1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NGe9NBm0ps6Pk7YhtZu+w9hKW/+kzO57KVq1m5e0objM665n0yu7A7iNBgILfRHXokcAuOWPPlgMFf4wkplFuGob5j+Cy9jay5UC6Y6upH9mPE2330+wWQ2fAqAvCDA5kLf29xjD8x1FmkiR0fqHH7CZfc6TR5ii25P39TQRSOY6N63X3fZ3UndeYOKV+Z9j3IznsuPj9M1vqNbJYBQFrsSrUGjYm0GR1PaLMKfu9Mqf6Zi/L6yk6JOJDjclRG7QzM4XX1ZDaom6TOdjtC4UNaU+t2e4HM0BFNFJqLUGX7QuJgWR/Ap6U1HFP/Z1qtShX4VS55iZG2cxskL563+793oSajoQFTDm89iUD/oB2gNdBetbVcE9mUGdzAdTnjiSop/3QjILBJR3J0BSfPIfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(966005)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7iiGlmGVHrfRipaLOO1r4GlIZrPhx3QuKqfnpzISUSHsP5jfUeweX9yzPHHNynHCvl8a8BEfffk7OD52J7NNiGw8Olh9tIMXgILRVGnG8WcfGyadTzQxJgup8D10c4rz3vleVzx86CVwxxXmUwp0XTRUrY5747VbKF9z2ZpASyTh/qfBChZbyoiM5Z0vMLWiB5XA/uPLfQF145ofznHeirVaxfraXtadcfdw3spEMUReb+4WUT3tktS8ACewhcxZK/YQeJAQpgVnzXvIuGmwpZ71mQOcGO4jAb2VMQs4ylrqZ9I/0qIm1OU0m79lUbCzJM+R++M7YWaC8HEADX0kGWLyxTD0c67q8xkYYC7dASVWW5XsNzLyQUJ+wNIGDFcm8J76NvThHfWviY7kVGKV0ZFkBTU9fbCb/DKB+U5fuEcO0qjWHCV+ckCpU4sOwRxSgWMkuXGG97smy957ekSSjPRVX/LqFNwIaz5rvz4XnO2FVQsh3ribEtSYoOekudD9A5hgUNI9W9uJQbYhQw+8lW2I4PM68M7fFze1a181oiRbft1iBDEFb/gq6P8DrT8P/56yn9I9qogrUrGt5GF3JAlonIYuG2gerbJ5v0iXqUxgQ31iObMiUulfq96DolaFdg5Lda858ErQCTvPQaZTHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c88021d-4fd2-42be-cf45-08d860c1a86f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:14.5512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLY6C7yVhOhG01FS2Y8B7JAL96FW8RNubs/wHFeoFOnPfe0YuW4JmK5jrMtfbD7puM8t1VcKsDgOG+hLK79kEGMoaYTuO3Gr6LAh0M37HNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:15
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

v7:
- add Alberto's r-bs in all patchs
- rebase to new backing-chain handling, bdrv_filter_or_cow_bs is used instead of backing_bs


Based on series "[PATCH v9 0/7] coroutines: generate wrapper code" or
in other words:
Based-on: <20200924185414.28642-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (5):
  block/io: fix bdrv_co_block_status_above
  block/io: bdrv_common_block_status_above: support include_base
  block/io: bdrv_common_block_status_above: support bs == base
  block/io: fix bdrv_is_allocated_above
  iotests: add commit top->base cases to 274

 block/coroutines.h         |   2 +
 block/io.c                 | 132 +++++++++++++++++++++----------------
 block/qcow2.c              |  16 ++++-
 tests/qemu-iotests/274     |  20 ++++++
 tests/qemu-iotests/274.out |  68 +++++++++++++++++++
 5 files changed, 179 insertions(+), 59 deletions(-)

-- 
2.21.3


