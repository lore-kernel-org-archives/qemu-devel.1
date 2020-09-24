Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4570C4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A13B23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o/dzJKbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A13B23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWRG-0003KV-PC
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWO6-00015R-VO; Thu, 24 Sep 2020 14:54:38 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWO5-0002O2-6G; Thu, 24 Sep 2020 14:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISV/qTCtNUGI9+tTUlvOAhWuHMj42Xm+CTJeQ7dyh3eQGW0xgdlBURuawWG9vwzL9XV37+QPA8P80EJSmzU6+1qj7haO+5JADIfEKGQ8R15g72J5Ji6CclVB7/ecqARczYXJpORrcJ8J/eEfn7N5Cqh2QMiLKyFrgOlxncZdCs6C4lEWl3IEhUCSqWo2RCx7YhJjG9cVoT7cd4jV2SvumHsNvJip7DQaVq5hDirt0mkl+4XxDcH4/FltvQmnCp9GMD6VR5cDYoU0BQX50mnLW3cTYVU8mjgzgVd2NM8XFl/KekfZpnUrrkLkpdklVSyB5UzcCgWgjVv0ZxjpiumSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sur2giZyvD+VLaT9FRjsx3KO0PYGsNxJF5v44Yu0AI=;
 b=QfTGyndkvwkjvz2Qza4FAvlPFKkUcj80GaRzeW08Fj5KIQ5kZ8TVStOE3QyvFZyL8OAwIpxH7hiXZATrbho+NLjX28NnJQptEpqTsKx6+RjWCDTjnuVFO6ChHbLQpjyOn4+lg3gECqB1DBGiUWMShDFaJmk2RXPfzqau0pVkF163tPRwFQzcOSUISJK2DpMh2FwzbZI7NgGJFqtSzYECR44uvMLT487ZWX72MTqI1eO0NInFPcaQAS6XSLaYkC2rxPe2jfJ6UhXzTqhVSZgVLLu0RyxY3S93ongBRGFz3b7eOR5fWRzQJU0S6sCUvIdDHK9kSB70jNQz/lHPTy1jtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sur2giZyvD+VLaT9FRjsx3KO0PYGsNxJF5v44Yu0AI=;
 b=o/dzJKbQ0vgNTgV9hlUNZcMN9EekAhCABHuc4ZKr3Qkd0GMw2TpSDuyxWQycjjUB/ucbfSRHlhPYErLOQGRDwC4t3Wz2C/l1bQp+31LELnLGjhAJW483zjsOf8XF6SM2pDG3WwPG9vbJ414pt51H0ds/VDx9qu/L2m6seJYGKcg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH v9 0/7] coroutines: generate wrapper code
Date: Thu, 24 Sep 2020 21:54:07 +0300
Message-Id: <20200924185414.28642-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:32 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601a483c-cc77-4e53-d0e4-08d860bb4688
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341399042FD604CFE2C91E0C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFpXUBAxcCd1LodqrU+M8R9+vRNUs4VGIThnyaQgbcS7GrcjkR1cOVwb0jLiR61DO1IH6rWvomUEZKW6BPJmM5LT91fSuwxZWoRUIjO8BheLIsyJ8dsoy2vymyNf5801KUNgrcmOITrOYtQAWrNH7Bu+xKf4KGN0V4goLGrFVpZmE+wyzWR1lPZfel8bhl+u+6xiQwFNq2sYdu1BkNIFcvYs/lVZljYLUdSNXGQhPtTKuk8KF2IIPvhWdhgv7Ab+jW7Uw98NGrH8CvDb3vOf8JNPaNGPNcXWHPdBu6bWjAeYaPHzOlJQKZweJir/LVgCplg5TkdSM9rtuxhfu+aenCVzjwSeeAEsK/4WDYwkmTVuSM+irdqGK9gAdp+KtXIe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3OLD5nQNNmolbQxl5e7dFbMjZJEb8/Qrg5ucEGKj8NJy6V3GJ750uCJJSVOIQepBl0VFfB/6BqSfE++fqlTKSjNfXCedlHtudZ7By9B+jN9rZscJULLRBwBH9+t2eRttEEHRRF0B71gHjSebIZjqQu2Sg1jBp0O1Qo0lZhV/QhR4FIXlO4Uqed/VoFiSts8MTyIN1hnKEzEKJW7IFg4+kSmI5bZG9/DuY1vcY3udH63idy1BrtqRocHLsHWc5LlMqJg7nzP9Gm/SbgfkIiniLpozWIdOC7859Ca89GxPzwBNQ9Y/0uKbWehNlY6VM00pU1HX5k3Gt8NRx8R7D2YS0Hnwf5I2Rif77cCBQVqzNgFQhbfsZPVfZt/aqm9kzxdtxd+ov65G8va3zQk2YmIdmUfWx4MwRDLtac2fRTrUnSTeY7iGxQjMKe+dTx6flgMLoh5wquHsoicxT/3T3zknEGNUcHlwDyD6EcPibW7TCpK4zGSJuv9hc7ToE9lzrga85VQop1gpuj/9+xf+Y6ulyGgUjTmomTfeVPtU8WjztmsuIaCrHB+5KJ6up9WkQ3U8ZbstGsrB1oZJL81v22O0CoFG4vbneHyNhtZbq+h6SlAwUOtractcWXQblnkG95ynsV5UxEu2EeQAO+GMHT1UsQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a483c-cc77-4e53-d0e4-08d860bb4688
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:33.2901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqbvV3Kp3zBwnEzIEj2uZTyKjmTHwlQUKm+i14ZRINoHtu9bLjBzwQWL1/7m++aMvAwlYYyprHtWnFB5iuPRaWhOQ5U7c7VazvM5BuZXLQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:34
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

The aim of the series is to reduce code-duplication and writing
parameters structure-packing by hand around coroutine function wrappers.

Benefits:
 - no code duplication
 - less indirection

v9: Thanks to Eric, I used commit message tweaks and rebase-conflict solving from his git.
01: add Philippe's, Stefan's r-bs
02: - add Philippe's, Stefan's r-bs
    - commit message tweaks stolen from Eric's git :)
03: add Philippe's, Stefan's r-bs
04: - wording/grammar by Eric (partly, stolen from repo)
    - ref new file in docs/devel/index.rst
    - use 644 rights and recommended header for python script
    - call gen_header() once
    - rename gen_wrappers_file to gen_wrappers
05: add Stefan's r-b
06: add Philippe's, Stefan's r-bs
07: Stefan's r-b

Vladimir Sementsov-Ogievskiy (7):
  block: return error-code from bdrv_invalidate_cache
  block/io: refactor coroutine wrappers
  block: declare some coroutine functions in block/coroutines.h
  scripts: add block-coroutine-wrapper.py
  block: generate coroutine-wrapper code
  block: drop bdrv_prwv
  block/io: refactor save/load vmstate

 docs/devel/block-coroutine-wrapper.rst |  54 ++++
 docs/devel/index.rst                   |   1 +
 block/block-gen.h                      |  49 ++++
 block/coroutines.h                     |  65 +++++
 include/block/block.h                  |  34 ++-
 block.c                                |  97 +------
 block/io.c                             | 337 ++++---------------------
 tests/test-bdrv-drain.c                |   2 +-
 block/meson.build                      |   8 +
 scripts/block-coroutine-wrapper.py     | 188 ++++++++++++++
 10 files changed, 454 insertions(+), 381 deletions(-)
 create mode 100644 docs/devel/block-coroutine-wrapper.rst
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100644 scripts/block-coroutine-wrapper.py

-- 
2.21.3


