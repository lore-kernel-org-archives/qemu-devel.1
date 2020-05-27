Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B54C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553C5207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gtgXUiuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2pH-00066Q-Fl
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oE-0004RZ-N8; Wed, 27 May 2020 16:37:54 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:57342 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oC-0007uz-Kd; Wed, 27 May 2020 16:37:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RetWrofzGWshSLPg0xqG9ma319bKOaydZXQqEP/UidQccwvBb2d/ZJPiTVYMqwROgCBIwDoBXiy4afHoYTkt0jW/OatzbwQc4hUZR5ru5QN4v7BPe4To65ioAsaBBluRaLktCgNA6V2zfpuEiUs+C/VB9JxubODqEVJkDTh910k8YAmqBk/ivC63nzJSjPCkiKfYATXFnNxvngZnXQ15Cx/ivfh0Qa2NYjlyXOaERzvVuLn8Fi+KTkFT81C56pQlMnJmoHFzpN7UF4Ez/Npm0aR1Hs1ZiHoAIBVSK8kII/0JLgRj2aC/hcnL6tKUhhCI4xxKPQWtkI8g906+Cq4JPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0MMTlurA4Uk5DF5rkD9AvXhTGTt6zlsjYWDik2Ux+U=;
 b=cyzPuoRSo2uAu5vm9XtJ3YU4d2ExmY3j/5JEJhHxHmfoCjQSzujdvb2AMbsxkQ4SBIvJ6scijWzMM5dlAVI7M1YqnJRgGVkQmnzbKWd4G2+ut4sgX5FMDa6JRYqLb/BpUnwyUSfv5YXeFENftToY2fOwo5vE7Eh6eExL2xlO1ugLCnzim1V0+mxmjyR8tdDz6LWCJbbpkoDHiynYBV4Bvuc364/n6qjUVNUodVynS9xo+oy+j0IkkazQtEFnRW1yzBn4xPfDbrZHLT/n3WPrADxAIcd1A0lIRU6+lLw8GOdhA8K1/xgJXHZDrXIE53pIvfqR74R6m9qZiwkBesl/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0MMTlurA4Uk5DF5rkD9AvXhTGTt6zlsjYWDik2Ux+U=;
 b=gtgXUiuH8aDRQ9YOQxvoJHnkkCq3TDShEGeSQG0feYj8qOD9Moq1mqfwQIohRVxqYclsbGQeFAqyOnMznxfvcTMEpaGBqUrXrjBnVQ7etK8oDZUOFbE/7OPHFMAkU4CTgizLSUr/bB61Ee/K/R7U3OQRI1vpWxzNNRmTzAcE0sQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 0/7] coroutines: generate wrapper code
Date: Wed, 27 May 2020 23:37:26 +0300
Message-Id: <20200527203733.16129-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.148) by
 AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66cfbf3f-a9a5-4b1a-06f4-08d8027dd1d1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53368A5C3B1884F3722906DCC1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsrHFH1gXyckT4bhU8Gv9CVWMGz0vpWilUBovPRu+gwrjpx1g/IchcA4XrFkXoJ/8x1x2co/uBQWeag/LBzD15A92U/aVApMuOBQ75/7tPGtQkhhdoC9+FPnQbE+nf8QngFkZO2W1mQGnK26rX64/SSCn2Yww8q3S13oJUU6mK03neC1r9g3TnCY6p1JD47VGYklJ1mveEQsKHUESSkW+IRnSjf6pp3vUVNL5PtY7nlQZ51FhtyKkWxTcndbTy0p1EMk8AeKWOZkA1wlm8FrV3wZgxCkGZLjg9LQoX+WwzrhoN7ArURgtyHPA5qiDWZfR9MDOh/xpGrnI2/lF2pRZ5SYIswjFDqVuCocbpNTnZWEhDqDHzIJVHN4ainiQo631WpYQSQPGeBn3huEoFfobvgvyz38FPbC/SlrnDKd2ulk83ARxDeMyrFqZ2ZcHEF3O02O/13Fe/UkhWmP2p+u0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(30864003)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X0yi/tYjfzL0gxwRyVGfz3jmc9ChoRSbesK68YaVSjnLg/yHxbkdb8VlQxfvJjpxobcRgqb6ZzqP0JAa1uL3UGyZ2AAhtSHmBVMs3blKmsyghjphWzrX3CSs3jfOgWVPjTqLD06viNavOT3xRV+HerjYvjFwyDBVZTenejSh6AFEDy4L6ztvuSeNYtrO8TFJJS3bFz+9+GlqsH+NLVV7r1+OCCI6LGF1OQHTbmMMmAwrsBm52xueZUnWxckImFHR7AkpqDcOM5tWj6I58xAi2bwTtNdFiej19Vi7R9vgMjDQ31bqrBeN/8e9mkPePZGQAiDW8v6djIPum0KmtOUNfPZJqavbs8Hn24TzJjnKiAcKwBhT8O73xKF7lElY2ZJoF+3wb7nfFdLOD0gpiHJXIgjtnagN+Xe2VQlKjIt70zG+D0gyU+rVgrtD2Ro1Q90Tm954shbIXiTeWjB3myZDilB15L+4P/Rt7YsMtpiwsxQnuogB1ob2BveZM5epDGOY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cfbf3f-a9a5-4b1a-06f4-08d8027dd1d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:48.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsCyIOOI9tApM9HaXiVdE+4CfOjhtEuHHYJNgelf4DRkQIXXMcyX7Bmzbk6xkxibwzVBdrykcgLUbohA6LGCPDGSoTO8sK1GMStiTRcrm/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

The aim of the series is to reduce code-duplication and writing
parameters structure-packing by hand around coroutine function wrappers.

It's an alternative to "[PATCH v3] block: Factor out bdrv_run_co()"
patch.

Benefits:
 - no code duplication
 - less indirection

v5: mostly by Eric's suggestions:
01: new
02: tweak commit message
03: - fix type in commit message
    - rebase on 01
    - keep Eric's r-b
04: - conversion splitted to 05
    - script mostly rewritten
      - use f-strings for templating
      - add copyright to generated file header
      - wrap long lines if clang-format available
    - fix makefiles
05: splitted from 04 mechanical conversion
06: tweak commit message, add Eric's r-b
07: add Eric's r-b

For convenience I attach generated block/block-gen.c file below.

Vladimir Sementsov-Ogievskiy (7):
  block: return error-code from bdrv_invalidate_cache
  block/io: refactor coroutine wrappers
  block: declare some coroutine functions in block/coroutines.h
  scripts: add coroutine-wrapper.py
  block: generate coroutine-wrapper code
  block: drop bdrv_prwv
  block/io: refactor save/load vmstate

 Makefile                             |   8 +
 block/block-gen.h                    |  55 ++++
 block/coroutines.h                   |  66 +++++
 include/block/block.h                |  25 +-
 include/block/generated-co-wrapper.h |  35 +++
 block.c                              |  97 +------
 block/io.c                           | 383 ++++-----------------------
 tests/test-bdrv-drain.c              |   2 +-
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 173 ++++++++++++
 10 files changed, 417 insertions(+), 428 deletions(-)
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100644 include/block/generated-co-wrapper.h
 create mode 100755 scripts/coroutine-wrapper.py


===== Generated block/block-gen.c ======
/*
 * File is generated by scripts/coroutine-wrapper.py
 *
 * Copyright (c) 2020 Virtuozzo International GmbH.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "qemu/osdep.h"
#include "block/coroutines.h"
#include "block/block-gen.h"


/*
 * Wrappers for bdrv_co_truncate
 */

typedef struct BdrvCoTruncate {
    BdrvPollCo poll_state;
    BdrvChild *child;
    int64_t offset;
    bool exact;
    PreallocMode prealloc;
    BdrvRequestFlags flags;
    Error **errp;
} BdrvCoTruncate;

static void coroutine_fn bdrv_co_truncate_entry(void *opaque)
{
    BdrvCoTruncate *s = opaque;

    s->poll_state.ret = bdrv_co_truncate(s->child, s->offset, s->exact,
                                         s->prealloc, s->flags, s->errp);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_truncate(child, offset, exact, prealloc, flags, errp);
    } else {
        BdrvCoTruncate s = {
            .poll_state.bs = child->bs,
            .poll_state.in_progress = true,

            .child = child,
            .offset = offset,
            .exact = exact,
            .prealloc = prealloc,
            .flags = flags,
            .errp = errp,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_truncate_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_check
 */

typedef struct BdrvCoCheck {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
    BdrvCheckResult *res;
    BdrvCheckMode fix;
} BdrvCoCheck;

static void coroutine_fn bdrv_co_check_entry(void *opaque)
{
    BdrvCoCheck *s = opaque;

    s->poll_state.ret = bdrv_co_check(s->bs, s->res, s->fix);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_check(bs, res, fix);
    } else {
        BdrvCoCheck s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .res = res,
            .fix = fix,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_check_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_invalidate_cache
 */

typedef struct BdrvCoInvalidateCache {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
    Error **errp;
} BdrvCoInvalidateCache;

static void coroutine_fn bdrv_co_invalidate_cache_entry(void *opaque)
{
    BdrvCoInvalidateCache *s = opaque;

    s->poll_state.ret = bdrv_co_invalidate_cache(s->bs, s->errp);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_invalidate_cache(bs, errp);
    } else {
        BdrvCoInvalidateCache s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .errp = errp,
        };

        s.poll_state.co =
            qemu_coroutine_create(bdrv_co_invalidate_cache_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_flush
 */

typedef struct BdrvCoFlush {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
} BdrvCoFlush;

static void coroutine_fn bdrv_co_flush_entry(void *opaque)
{
    BdrvCoFlush *s = opaque;

    s->poll_state.ret = bdrv_co_flush(s->bs);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_flush(BlockDriverState *bs)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_flush(bs);
    } else {
        BdrvCoFlush s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_flush_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_pdiscard
 */

typedef struct BdrvCoPdiscard {
    BdrvPollCo poll_state;
    BdrvChild *child;
    int64_t offset;
    int64_t bytes;
} BdrvCoPdiscard;

static void coroutine_fn bdrv_co_pdiscard_entry(void *opaque)
{
    BdrvCoPdiscard *s = opaque;

    s->poll_state.ret = bdrv_co_pdiscard(s->child, s->offset, s->bytes);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_pdiscard(child, offset, bytes);
    } else {
        BdrvCoPdiscard s = {
            .poll_state.bs = child->bs,
            .poll_state.in_progress = true,

            .child = child,
            .offset = offset,
            .bytes = bytes,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_pdiscard_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_readv_vmstate
 */

typedef struct BdrvCoReadvVmstate {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
    QEMUIOVector *qiov;
    int64_t pos;
} BdrvCoReadvVmstate;

static void coroutine_fn bdrv_co_readv_vmstate_entry(void *opaque)
{
    BdrvCoReadvVmstate *s = opaque;

    s->poll_state.ret = bdrv_co_readv_vmstate(s->bs, s->qiov, s->pos);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_readv_vmstate(bs, qiov, pos);
    } else {
        BdrvCoReadvVmstate s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .qiov = qiov,
            .pos = pos,
        };

        s.poll_state.co =
            qemu_coroutine_create(bdrv_co_readv_vmstate_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_writev_vmstate
 */

typedef struct BdrvCoWritevVmstate {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
    QEMUIOVector *qiov;
    int64_t pos;
} BdrvCoWritevVmstate;

static void coroutine_fn bdrv_co_writev_vmstate_entry(void *opaque)
{
    BdrvCoWritevVmstate *s = opaque;

    s->poll_state.ret = bdrv_co_writev_vmstate(s->bs, s->qiov, s->pos);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_writev_vmstate(bs, qiov, pos);
    } else {
        BdrvCoWritevVmstate s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .qiov = qiov,
            .pos = pos,
        };

        s.poll_state.co =
            qemu_coroutine_create(bdrv_co_writev_vmstate_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_preadv
 */

typedef struct BdrvCoPreadv {
    BdrvPollCo poll_state;
    BdrvChild *child;
    int64_t offset;
    unsigned int bytes;
    QEMUIOVector *qiov;
    BdrvRequestFlags flags;
} BdrvCoPreadv;

static void coroutine_fn bdrv_co_preadv_entry(void *opaque)
{
    BdrvCoPreadv *s = opaque;

    s->poll_state.ret =
        bdrv_co_preadv(s->child, s->offset, s->bytes, s->qiov, s->flags);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_preadv(BdrvChild *child, int64_t offset, unsigned int bytes,
                QEMUIOVector *qiov, BdrvRequestFlags flags)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_preadv(child, offset, bytes, qiov, flags);
    } else {
        BdrvCoPreadv s = {
            .poll_state.bs = child->bs,
            .poll_state.in_progress = true,

            .child = child,
            .offset = offset,
            .bytes = bytes,
            .qiov = qiov,
            .flags = flags,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_preadv_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_pwritev
 */

typedef struct BdrvCoPwritev {
    BdrvPollCo poll_state;
    BdrvChild *child;
    int64_t offset;
    unsigned int bytes;
    QEMUIOVector *qiov;
    BdrvRequestFlags flags;
} BdrvCoPwritev;

static void coroutine_fn bdrv_co_pwritev_entry(void *opaque)
{
    BdrvCoPwritev *s = opaque;

    s->poll_state.ret =
        bdrv_co_pwritev(s->child, s->offset, s->bytes, s->qiov, s->flags);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
                 QEMUIOVector *qiov, BdrvRequestFlags flags)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_pwritev(child, offset, bytes, qiov, flags);
    } else {
        BdrvCoPwritev s = {
            .poll_state.bs = child->bs,
            .poll_state.in_progress = true,

            .child = child,
            .offset = offset,
            .bytes = bytes,
            .qiov = qiov,
            .flags = flags,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_pwritev_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}


/*
 * Wrappers for bdrv_co_common_block_status_above
 */

typedef struct BdrvCoCommonBlockStatusAbove {
    BdrvPollCo poll_state;
    BlockDriverState *bs;
    BlockDriverState *base;
    bool want_zero;
    int64_t offset;
    int64_t bytes;
    int64_t *pnum;
    int64_t *map;
    BlockDriverState **file;
} BdrvCoCommonBlockStatusAbove;

static void coroutine_fn bdrv_co_common_block_status_above_entry(void *opaque)
{
    BdrvCoCommonBlockStatusAbove *s = opaque;

    s->poll_state.ret = bdrv_co_common_block_status_above(
        s->bs, s->base, s->want_zero, s->offset, s->bytes, s->pnum, s->map,
        s->file);
    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_common_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                                   bool want_zero, int64_t offset,
                                   int64_t bytes, int64_t *pnum, int64_t *map,
                                   BlockDriverState **file)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_common_block_status_above(bs, base, want_zero, offset,
                                                 bytes, pnum, map, file);
    } else {
        BdrvCoCommonBlockStatusAbove s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .base = base,
            .want_zero = want_zero,
            .offset = offset,
            .bytes = bytes,
            .pnum = pnum,
            .map = map,
            .file = file,
        };

        s.poll_state.co =
            qemu_coroutine_create(bdrv_co_common_block_status_above_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}
========================================

-- 
2.21.0


