Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E479C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22894207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vZAyXWol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22894207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA3y-0003P9-5p
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2m-0001id-NW; Mon, 25 May 2020 06:09:16 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:60641 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2j-0003yp-T9; Mon, 25 May 2020 06:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EymTUVWtf1OGiqp3bTOuXfJX3Y/Uszq0251FMe2/HfeZ1QhlLneF1C1zIatfS8VbFFuaqiPSiIuSO9ePHe08Z1r6KGM//OSC0+x3S5rfd7ibbLYM5UHJXCdegOKcNNMW1RMOG0CwKPSTAPjsGGSFsV1/LtV+9UP0Ow3Anl5szFCyua74HDBGjcfpkrN7Bs4cJrks/AOzILQL7/KTSgty21MMubVUcThLx3W5Tzx9u5dSnJ4xNaZ6nvQ44+Iu3LlB4adv++pG+k034YAO7Sa1/UUIiTcB6tDPeqT4WADXcRItmwZcIb0RoMkG6io+rcAlhc5ZRdiyXSM4fXEqD1Rmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnIv6DLA7HhkMY9Ls4yE+Ln5QMgdFN9i4RaDCE2NAKQ=;
 b=aiY2RPxMgFAEOXJ5wzziA+8YjA7BD9y35L17usR1VJzAMnQRObZXo4WjXpgIRxWW/xgZ5+Uyy79rrQqKj0OKuUuF5kTSPtpePUmMo3wsDaDspkvFIYePFQmG6Dc19f3oG0t0/tNMa92aT+WQP8ruPWu3bxCCupcYJph+xr9t90XNtZ42UyOnthTJsVzblT8Ro1ddFyoKsOd+uZd0xkUoM4k3r9A/5EgSkOPphWVNOYBbv2SuCM84o5h+sRKUcZTWY/mu3xuN4AjLngpC4zilxMBEYUyh64ufpfvWChAwkkE9u/oCOTR/sHiazhT8B9O0jMtRTIFW7S/FFmTcq2U03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnIv6DLA7HhkMY9Ls4yE+Ln5QMgdFN9i4RaDCE2NAKQ=;
 b=vZAyXWolsE3dp426aDnfxn2UTRSRW7zaFzl9HoN5asozcEQ1oZjvMdB3ga8C5z0bD0go1ms0FOF95pW9KZ9/yHDP9sG39YjeTMPumchfha240MYbjlwCx8HWB70wAA0FsBDFwt9ploc1vMjNg5hchvrdIsjXKj7YrF/w4RbCvMU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:09:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:09:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/5] coroutines: generate wrapper code
Date: Mon, 25 May 2020 13:07:56 +0300
Message-Id: <20200525100801.13859-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:09:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce61fa2b-06a0-4788-89b0-08d80093aaee
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54648DE34AD53589D1234162C1B30@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNbg7Pu+NIHpaklivEp/yg2F8H+dtBAapMZs061ikHFFTjfYtfEENUyuOXHxvWON3MA7oNWsFQXz1ykd9w7bbYlCWfI3dGIsFBwXwAHDH4IiWqGXXnO/gADiRNhnIHYSuQrgPYQbXICImvCeztpWotDHl2yfOv1q+Bj3PUA+02r7+JP5ymDDVxexb3hXzyy2phjAnRkIVBONcjZmDHTWsT0yK34H9cwXiL205gF4B0JxJV99qDO5L9KKta4KRkcfiYYOt/iqEwECEj+1pHcAPlyNM4noMi32PJIZ4LCuaXpZCxV4JlmeYUW+FG9uLdUzOk4aINxMqGJs9ZewhNfxmt1cnqyM1czYiUOsh4EfPGaM4/qmdyRqinCsiyWJKCmm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(6666004)(6486002)(1076003)(316002)(52116002)(26005)(69590400007)(6916009)(6512007)(478600001)(107886003)(8676002)(6506007)(2616005)(8936002)(86362001)(16526019)(186003)(36756003)(2906002)(66556008)(66946007)(4326008)(5660300002)(66476007)(30864003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zMhndy4ouO3cofIJeHYxz2Gb+3kaw1uWLqlfg1nSJbnV0RuvgAw8Wcz8C2NLpwvxdNYn6ibsIrGlID0+s1rYngehfsCgSHj0AAUG7oXAb2MAOPABL1s38iS3E69FQrhI7gvRbXNAkMlrMPaFnpv7aIVwY6KbebOIbW8IBPHb2qVz+bcEi53S64PuZEsStfrn59OTkP9ERB/g5YSt8NnOws1z/K/iavjodHj+mOVywg5lqaHjWZWcTkP1FLQjILGxT9N2Efk3HwXhOB50/X99C/w5LJYSkhgiHS21hSq1GlQ+Mae2B4cEYZQGsuQwX4+kezSyiiZhb7sF6t4fgr5Qlrag1nEWByR3XlPkXf1HeiSPGQEHoF3mXH57DczAzQ3IauVFrPeEeRAxwhh09Pe2Ddta/0ygeTfSLCdkfByeiI7utiajbJgQWmHFbKsBYgCnsIIgS9zbxOFy5JK/TTw9O22IeNSpINnLbF203LZnKjc1MDHI7WBmi8DYdVql4AEk
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce61fa2b-06a0-4788-89b0-08d80093aaee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:09:10.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ney7/wpl2MEY55pdAGWhv50LG5rTssJhrZWz9K5ROAu+UvSvMlcj7JpuzG6LuQkVZF2d9c2/x5n6OXTT4Jp6MyhUz67FaS4cajcyGmt8zyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:09:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

v4:
01: wording in commit message + Eric's r-b
02: add copyright header into new header
03: - add copyright headers into new headers (most funny is
                                              generated-co-wrapper.h)
    - fix Makefiles (hope this will help patchew, code builds for me
                     even without fixes, I don't know why)
    - fix extra new-line at the end of generated block/block-gen.c


For convenience I attach generated block/block-gen.c file below.

Vladimir Sementsov-Ogievskiy (5):
  block/io: refactor coroutine wrappers
  block: declare some coroutine functions in block/coroutines.h
  block: generate coroutine-wrapper code
  block: drop bdrv_prwv
  block/io: refactor save/load vmstate

 Makefile                             |   6 +
 Makefile.objs                        |   2 +-
 block/block-gen.h                    |  55 ++++
 block/coroutines.h                   |  66 +++++
 include/block/block.h                |  25 +-
 include/block/generated-co-wrapper.h |  35 +++
 block.c                              |  78 +-----
 block/io.c                           | 383 ++++-----------------------
 tests/test-bdrv-drain.c              |   2 +-
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 168 ++++++++++++
 11 files changed, 401 insertions(+), 420 deletions(-)
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100644 include/block/generated-co-wrapper.h
 create mode 100755 scripts/coroutine-wrapper.py

=== Generated by these series block/block-gen.c ===
/*
 * File is generated by scripts/coroutine-wrapper.py
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

    s->poll_state.ret = bdrv_co_truncate(s->child, s->offset, s->exact, s->prealloc, s->flags, s->errp);

    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact, PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
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

    bdrv_co_invalidate_cache(s->bs, s->errp);

    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
{
    if (qemu_in_coroutine()) {
        bdrv_co_invalidate_cache(bs, errp);
    } else {
        BdrvCoInvalidateCache s = {
            .poll_state.bs = bs,
            .poll_state.in_progress = true,

            .bs = bs,
            .errp = errp,
        };

        s.poll_state.co = qemu_coroutine_create(bdrv_co_invalidate_cache_entry, &s);

        bdrv_poll_co(&s.poll_state);
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

        s.poll_state.co = qemu_coroutine_create(bdrv_co_readv_vmstate_entry, &s);

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

        s.poll_state.co = qemu_coroutine_create(bdrv_co_writev_vmstate_entry, &s);

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

    s->poll_state.ret = bdrv_co_preadv(s->child, s->offset, s->bytes, s->qiov, s->flags);

    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_preadv(BdrvChild *child, int64_t offset, unsigned int bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
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

    s->poll_state.ret = bdrv_co_pwritev(s->child, s->offset, s->bytes, s->qiov, s->flags);

    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
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

    s->poll_state.ret = bdrv_co_common_block_status_above(s->bs, s->base, s->want_zero, s->offset, s->bytes, s->pnum, s->map, s->file);

    s->poll_state.in_progress = false;

    bdrv_poll_co__on_exit();
}

int bdrv_common_block_status_above(BlockDriverState *bs, BlockDriverState *base, bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file)
{
    if (qemu_in_coroutine()) {
        return bdrv_co_common_block_status_above(bs, base, want_zero, offset, bytes, pnum, map, file);
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

        s.poll_state.co = qemu_coroutine_create(bdrv_co_common_block_status_above_entry, &s);

        return bdrv_poll_co(&s.poll_state);
    }
}
=== End of generated block/block-gen.c ===
-- 
2.21.0


