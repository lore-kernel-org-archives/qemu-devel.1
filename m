Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE24C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FC2206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="huKESRsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FC2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif5L-00043r-OI
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0k-0006gi-01; Tue, 09 Jun 2020 10:13:54 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:27969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0g-0007gx-NM; Tue, 09 Jun 2020 10:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVZnu67wxxu81SJXxhBbe8BGog22fYdIas3ECGmp/yCN29U0/YPOA4//cU5ozFABN1jLKHCtvzqr7X+FrHR5MrQ57M5ZCUv3fW6x9VL82DSuEU0yhxAqyNhIEqD4azF/9kBiYqMXjVJ63XTp2B9NU9lms7+KSJ5V+XQrMD1akzciB0IH9TmTebfDxtB3qiwMa0r6tfbO/xbiWXtQKAgP5ylFpEj74GdBnP42KqJ4iQj0KdCgDspUKmNHwP0uKG6IyeoHoNfQ/VXJ59fCFu8jMW0RFLab65+LmMNlnO7i6Z6tyTnV9YLBroKfdsraTelPqb57yRCv64yH+/R6pnsFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYDZax6AB9s2wnR+pMnXW7iHZVloaHakENoatPJJ2z4=;
 b=Nheou43OdU707+Kxm0wGBsgCrGkVrH7wElSh2cKV3jWZUFliTzxRqhcaCnTb7F0iK/eREakIfYkTYWhBJKXeiy/wBCnwsG9cPsRCBAPIpVWY4JkUmPQILXi9FhQvb3xCK1RHelV+hbYcl3KWF36WPHHW6T8hgVVuZ8R62gfegUv+KgTNmktVMX9ZyWxgXqw9Df2Y9e+S/i/oI017uGbML7/ERnSLKhHeLNsA9QzlKMNLo3GNNZsYCbE0+scSucJBPRgJgWvjODVaDL3sOQRna83a0umi3PbwxIW7i8TF+5rbVDydJ0CcCgV0K2Z0gLbP4+gpgH0VrVxXf2wO9wBE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYDZax6AB9s2wnR+pMnXW7iHZVloaHakENoatPJJ2z4=;
 b=huKESRsromlL3b3l67BwDmtl7RaKKYg6kVNT4kviCWyq01m4i2F3L77dcQH47R1vTUjI+H563RECwuYLFfCHW1EFQN7N4Ig4rT5gMuDHRQB8OFegtNJK0e7b7DPTQHDOtwwyMYqkFzSCXsNKZzihMqmSrTMh7wuK7PpSuhejERc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 0/7] coroutines: generate wrapper code
Date: Tue,  9 Jun 2020 17:13:22 +0300
Message-Id: <20200609141329.3945-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.180) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87bf82a-57d1-479a-b9ff-08d80c7f5307
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54948E1D1E9C65C56D19B47EC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuB3pb1XTD8f1EnHZ+eKh/7TUODi3HfsdJuNVTEcXnTuz5k11Cwtd/9pf99klaakEjz9ZHWqnT/ZM0ax/DpUrj+HpTd04c8vipiVXU+W60ntZNiLA1pBBMeb42GZED+GSo0U5JhsZLB0DSiBJfdZhaJaAp/Z3ipZqVKpoKzmb2lr9O/R5u8wzuO9nfEWx0OYQndYW5pwhwVnEG8XtwqzHQ3juM/VxOVJb8GmOyaCcNJjo2E/K7Un1el62gMnJqVDvqHq1QV3oOLLdAB4VaAvq7UTWxGeI54QKgsakKNWVx9M6wZWNpvY182jykBNnDeb1OauJh2ZuLmyuzifrXExCgZiHF8JX/UBB7Yx/5kuLZQuh+8Oa+p2yJY2qfoC0z6u6TNZ84OW7QpM4Rf1ab1qj9HFBApmgqyonmEcFehAxOlihjnCw3/iXl27zzM0FRs5RNNTOu2kTcpkCnjOH5OP6aGK6gEPPgOLV6Zi6ChFMn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(30864003)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O8b8FPrq6CfhrimOsXyXslxd6pecdEUZD2KMhIAlT6ZF3ywL4x5L9+koYxFceCzK+AzJiDNVg5PcOYJ/fViDmM2cjhHHzfxFtg5mkvJ2yDS2XLWOjA22S73SMMXgL9K7o9loHABINl0pYSZXe+JKPWfr9PA/Vh0lpvlzjYWwTzn3s7ihuCJe0CNArMe34SY0JhhOcSubWZSlJu8/PaYYu+JrmGATa+DZHkigTMR40txtQPbuMP5ac5iSDZLB27rCt5wqNhQ84xmb+cXWcGxYcJwlZa6hcrqcR8QQZyJTgtTnw2MVHh5vKynNrxE/aN7AENtrvB36d2/T7XuskJ4ohBl5bGYY/JQChTqUtix8TuhBMgbdpHsS5xPmS7yBwKis5xLy8jb9xPE2uhrUgd9wbTOkrnryMfbkvSGzG4SoZo/XGckO/hqVAZ1S3QGe2dZprcifkdUAIOrCVCw5GWKEw2sMsgxru/c9nijBeiLA+NKf/fHJkm31wfiEnuggC1DV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87bf82a-57d1-479a-b9ff-08d80c7f5307
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:46.8699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pjytGqWYNWaGiPMC86R3Ds4s7uk9/GTfznC1rwJAImpPGwuZ5uoSKCqmm8tinNuLyIKtcNkHrxCiTL/U8QUsvFhKe1Ye3qdC43UaqyJw+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:47
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

The aim of the series is to reduce code-duplication and writing
parameters structure-packing by hand around coroutine function wrappers.

Benefits:
 - no code duplication
 - less indirection

v6: rebase on master (mostly because of introducing bdrv_run_co())
01: grammar/wording in commit messageq
02: rebase on master, drop r-b
03: contextual changes, keep r-b
04: use stdout=subprocess.PIPE instead of capture_output=True
    to support older python
05: rebase on master, drop r-b

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
 block/block-gen.h                    |  55 +++++
 block/coroutines.h                   |  66 ++++++
 include/block/block.h                |  25 +-
 include/block/generated-co-wrapper.h |  35 +++
 block.c                              |  97 ++------
 block/io.c                           | 336 ++++-----------------------
 tests/test-bdrv-drain.c              |   2 +-
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 174 ++++++++++++++
 10 files changed, 418 insertions(+), 381 deletions(-)
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100644 include/block/generated-co-wrapper.h
 create mode 100755 scripts/coroutine-wrapper.py


============ generated block/block-gen.c ===============
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
=============================================================

-- 
2.21.0


