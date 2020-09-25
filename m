Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB263C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942652085B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cGNhkoWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942652085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLik5-00074M-Fs
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLiiq-00067Z-MR; Fri, 25 Sep 2020 04:04:52 -0400
Received: from mail-he1eur02on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::702]:3459
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLiil-0007mq-OB; Fri, 25 Sep 2020 04:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBUdOZLDXFdWZ3bNvPg8SAVrsxLLS1cn7AC5adDrCM8+tpEPTOVB0UA/VepOkXIcJlXYG/JUPWmGRCwsVqO/C2grVV8HShyznULm9TRLZD/wg3uMCYCU/ZxSbjOMW6QdgJ5K6x0WmB85fBC+vX88srefynyz9YqiiS01SEEJQ2Vp/RKXGj78sg0dV01iCh3BCD21PDe++hrZhhKRvjoD3MIZo1w2PjBBecKbryYo5i5HA4c/OXWzjuWq1d+76s1eGzchBqQybWVsov/R5IIzVmI8p5E7il/98bvCIdm2UimNWQXmIsvnyHEokQmInqliUoSuB7vMhj3Y2kM0YdHZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uXaW3KniobZwe8FLP4WW5B8hdN4p73+Qgf9pGFfEZw=;
 b=BT6707WjfnOweeTX1K5XFqOBFf5Jp6eMDXa4ebJqRlQvgWtvtIUL3GkpCDdQd0SquVofGt0AgUAq6MXfU91qcS7XPEp15h6qFbRaiyqN2r4h7MHv8pwzEVf/IIODksGmTGkJuFuV1HMGPtwt359Rt/UFmbkDtSXbQOe/66D+Kz+HTzprtnz3WqHak8Q1RV2QapWwwlR8NUhpsWn70xJZ1Li8L7T0OnQPoDvue41tUZ+rIXbNiQ2B3USQCYJq55NjPsZSATsSdnZPP8wKBidqjZnIunFHWzA+HZ6a9dhqcAlheR8uk2j9N9KH13uY5CkMbZJKToLJ+tNhCZTlWeIvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uXaW3KniobZwe8FLP4WW5B8hdN4p73+Qgf9pGFfEZw=;
 b=cGNhkoWhdMoxCB4c9krAAkyprppmkkC+RDMQG038b0fWeyFk0m1JRjNQ3s6XTx/cQj1ytOHfRUDhP9KTzCxh7U4HYcn60RkJBbVFlQG3LrbeEGm55epxm0Td8AXn6JbYyyiTADaZP2VyrD91JwQFODWAUtphr4wnfZX+VL/7t3c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 08:04:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 08:04:44 +0000
Subject: Re: [PATCH v9 4/7] scripts: add block-coroutine-wrapper.py
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
 <20200924185414.28642-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e64c06a6-8e15-2e65-ba58-2667230394e7@virtuozzo.com>
Date: Fri, 25 Sep 2020 11:04:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200924185414.28642-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 08:04:43 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18661ad-db45-44f2-b3cf-08d86129a9f7
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB503120E56D7508F7A7816260C1360@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqFJqFMgz808PXpUfCSujWmRdTyJksRucmWwShm87sk8oPtamSyTc2pY27dw1G3u442nDlgx6wc6GeZJjKRoP9NQdrg6MxtlNP72Fqx5632l35TKXXyyJvbTkMK41ZBoy1pBSd/J1gkonE8ghe0KCLh44XLWtyhG5Z/Fm2qt4T8GW1gwKx1E2i2+9NTlSLpxm7KPQb4YNuzSbgHWpbCytMOHgKK5IHBqG5D4nvG2SwAfTD8eHRzvu37dbOe6WH8KiZgl0QYIFu0Al1Xr4TjIrBufr7X/XJ4xYK0Taii4LIW+zfqgXwPKRxaJ/jwX+DMwb11SEIpzkL/XrFkHucsBTHlfOlOq//8S68mctOsJqX+oMEc+JSLq2eHUZ3a+NppgwIuaaFB3x5tYKk1GQ3Y/SLl6G+BkddpU+vKbh3MntILTIV1h+4k206mTBlYIwGjZZe1ezzoFFw7AYlPDstGfW+kAS33kIJ1qtYgBgUCgjly27+s/ixWypE4E+ApBr7oMDTBCv7dnKsWOglh+fmwDIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39850400004)(376002)(346002)(36756003)(478600001)(956004)(16526019)(26005)(2906002)(16576012)(186003)(52116002)(2616005)(6486002)(4326008)(316002)(8936002)(8676002)(31686004)(86362001)(5660300002)(66476007)(66946007)(31696002)(30864003)(66556008)(83380400001)(6916009)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lx+QxMVJXVRC5g6OORKUqUDc1gjkOqcjH0lLin6DZBKzTV/PJ7vEnJkLoE564c4kFpCZxg7q6DLQUZsAog+91ufwZqGxhKWLlSg2Z6y8B0uFMhme8c7kdbc7Hju3r/Fw4dVpmNcc98g/uSzsJPUP5faZV5VL8ACbPtPDKMxaJ/4acXy8X6fBA9xbjzUN6AESZlgDHYZJREIjEegxy8G6DhEAjiTu7D98Z/KWY3s/BV2mvx2rqIbn9+xBpUEJyRCa59CmqaYbXZ4IE9vj3gXFjape6TiUceIYAkDvlqPa2p2d9gxuPK1Orwa9e6Z5s+dNAc2/VB7l90MHpNVC4MDsxAI0UxYH3TCFOKuq5Fzb/aBfb44VmDCJg3ID6/aXz6KasAYw0U7QlzaArWVh5Z2C1hkZbmiT8nfYU/+rRVDElGFv3M2BFBwPMZ9VwQpQKweKxf23Wh7YJcBzSHJDG0pWDhSBiW6WXSELG7qPu1IfAKhBFDFW874pP5FfOTppMQMSQK7PQ+5HOTdtCfH0P600FqW2/qBiH0M5VCgV460KAaDLavRO4qDYN/yGc65I0UhJrI+ZUu2MSmmkWSsyYPQz3SetIjTDHfPZtRAOTw9jkpNpYNT3Msm+NStRilYgJH/p0CN7hfUGFbjkBr5SE6daCw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18661ad-db45-44f2-b3cf-08d86129a9f7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:04:44.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wtgbxFgfS4OMJpNZbJzKRY3IIjGnF4omKq9wUhs7jM0DwJTs2UPU+1CK5AEhlj4EMCSwJ/dQZwIt6qHwobRFGtJ3br/9fgunk5UCgXksFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=2a01:111:f400:fe05::702;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, SPF_HELO_PASS=-0.001,
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

24.09.2020 21:54, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating a coroutine from a function
> with several arguments:
> 
>    - create a structure to pack parameters
>    - create _entry function to call original function taking parameters
>      from struct
>    - do different magic to handle completion: set ret to NOT_DONE or
>      EINPROGRESS or use separate bool field
>    - fill the struct and create coroutine from _entry function with this
>      struct as a parameter
>    - do coroutine enter and BDRV_POLL_WHILE loop
> 
> Let's reduce code duplication by generating coroutine wrappers.
> 
> This patch adds scripts/block-coroutine-wrapper.py together with some
> friends, which will generate functions with declared prototypes marked
> by the 'generated_co_wrapper' specifier.
> 
> The usage of new code generation is as follows:
> 
>      1. define the coroutine function somewhere
> 
>          int coroutine_fn bdrv_co_NAME(...) {...}
> 
>      2. declare in some header file
> 
>          int generated_co_wrapper bdrv_NAME(...);
> 
>         with same list of parameters (generated_co_wrapper is
>         defined in "include/block/block.h").
> 
>      3. Make sure the block_gen_c delaration in block/meson.build
>         mentions the file with your marker function.
> 
> Still, no function is now marked, this work is for the following
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/devel/block-coroutine-wrapper.rst |  54 +++++++
>   docs/devel/index.rst                   |   1 +
>   block/block-gen.h                      |  49 +++++++
>   include/block/block.h                  |  10 ++
>   block/meson.build                      |   8 ++
>   scripts/block-coroutine-wrapper.py     | 188 +++++++++++++++++++++++++
>   6 files changed, 310 insertions(+)
>   create mode 100644 docs/devel/block-coroutine-wrapper.rst
>   create mode 100644 block/block-gen.h
>   create mode 100644 scripts/block-coroutine-wrapper.py
> 
> diff --git a/docs/devel/block-coroutine-wrapper.rst b/docs/devel/block-coroutine-wrapper.rst
> new file mode 100644
> index 0000000000..d09fff2cc5
> --- /dev/null
> +++ b/docs/devel/block-coroutine-wrapper.rst
> @@ -0,0 +1,54 @@
> +=======================
> +block-coroutine-wrapper
> +=======================
> +
> +A lot of functions in QEMU block layer (see ``block/*``) can only be
> +called in coroutine context. Such functions are normally marked by the
> +coroutine_fn specifier. Still, sometimes we need to call them from
> +non-coroutine context; for this we need to start a coroutine, run the
> +needed function from it and wait for coroutine finish in
> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
> +void* argument. So for each coroutine_fn function which needs a
> +non-coroutine interface, we should define a structure to pack the
> +parameters, define a separate function to unpack the parameters and
> +call the original function and finally define a new interface function
> +with same list of arguments as original one, which will pack the
> +parameters into a struct, create a coroutine, run it and wait in
> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand,
> +so we have a script to generate them.
> +
> +Usage
> +=====
> +
> +Assume we have defined the ``coroutine_fn`` function
> +``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
> +called ``bdrv_foo(<same args>)``. In this case the script can help. To
> +trigger the generation:
> +
> +1. You need ``bdrv_foo`` declaration somewhere (for example, in
> +   ``block/coroutines.h``) with the ``generated_co_wrapper`` mark,
> +   like this:
> +
> +.. code-block:: c
> +
> +    int generated_co_wrapper bdrv_foo(<some args>);
> +
> +2. You need to feed this declaration to block-coroutine-wrapper script.
> +   For this, add the .h (or .c) file with the declaration to the
> +   ``input: files(...)`` list of ``block_gen_c`` target declaration in
> +   ``block/meson.build``
> +
> +You are done. During the build, coroutine wrappers will be generated in
> +``<BUILD_DIR>/block/block-gen.c``.
> +
> +Links
> +=====
> +
> +1. The script location is ``scripts/block-coroutine-wrapper.py``.
> +
> +2. Generic place for private ``generated_co_wrapper`` declarations is
> +   ``block/coroutines.h``, for public declarations:
> +   ``include/block/block.h``
> +
> +3. The core API of generated coroutine wrappers is placed in
> +   (not generated) ``block/block-gen.h``
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 04773ce076..cb0abe1e69 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -31,3 +31,4 @@ Contents:
>      reset
>      s390-dasd-ipl
>      clocks
> +   block-coroutine-wrapper
> diff --git a/block/block-gen.h b/block/block-gen.h
> new file mode 100644
> index 0000000000..f80cf4897d
> --- /dev/null
> +++ b/block/block-gen.h
> @@ -0,0 +1,49 @@
> +/*
> + * Block coroutine wrapping core, used by auto-generated block/block-gen.c
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * Copyright (c) 2020 Virtuozzo International GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef BLOCK_BLOCK_GEN_H
> +#define BLOCK_BLOCK_GEN_H
> +
> +#include "block/block_int.h"
> +
> +/* Base structure for argument packing structures */
> +typedef struct BdrvPollCo {
> +    BlockDriverState *bs;
> +    bool in_progress;
> +    int ret;
> +    Coroutine *co; /* Keep pointer here for debugging */
> +} BdrvPollCo;
> +
> +static inline int bdrv_poll_co(BdrvPollCo *s)
> +{
> +    assert(!qemu_in_coroutine());
> +
> +    bdrv_coroutine_enter(s->bs, s->co);
> +    BDRV_POLL_WHILE(s->bs, s->in_progress);
> +
> +    return s->ret;
> +}
> +
> +#endif /* BLOCK_BLOCK_GEN_H */
> diff --git a/include/block/block.h b/include/block/block.h
> index 81d591dd4c..0f0ddc51b4 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -10,6 +10,16 @@
>   #include "block/blockjob.h"
>   #include "qemu/hbitmap.h"
>   
> +/*
> + * generated_co_wrapper
> + *
> + * Function specifier, which does nothing but mark functions to be
> + * generated by scripts/block-coroutine-wrapper.py
> + *
> + * Read more in docs/devel/block-coroutine-wrapper.rst
> + */
> +#define generated_co_wrapper
> +
>   /* block.c */
>   typedef struct BlockDriver BlockDriver;
>   typedef struct BdrvChild BdrvChild;
> diff --git a/block/meson.build b/block/meson.build
> index a3e56b7cd1..88ad73583a 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -107,6 +107,14 @@ module_block_h = custom_target('module_block.h',
>                                  command: [module_block_py, '@OUTPUT0@', modsrc])
>   block_ss.add(module_block_h)
>   
> +wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
> +block_gen_c = custom_target('block-gen.c',
> +                            output: 'block-gen.c',
> +                            input: files('../include/block/block.h',
> +                                         'coroutines.h'),
> +                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
> +block_ss.add(block_gen_c)
> +
>   block_ss.add(files('stream.c'))
>   
>   softmmu_ss.add(files('qapi-sysemu.c'))
> diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
> new file mode 100644
> index 0000000000..505e070660
> --- /dev/null
> +++ b/scripts/block-coroutine-wrapper.py
> @@ -0,0 +1,188 @@
> +#! /usr/bin/env python3
> +"""Generate coroutine wrappers for block subsystem.
> +
> +The program parses one or several concatenated c files from stdin,
> +searches for functions with the 'generated_co_wrapper' specifier
> +and generates corresponding wrappers on stdout.
> +
> +Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
> +
> +Copyright (c) 2020 Virtuozzo International GmbH.
> +
> +This program is free software; you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation; either version 2 of the License, or
> +(at your option) any later version.
> +
> +This program is distributed in the hope that it will be useful,
> +but WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +"""
> +
> +import sys
> +import re
> +import subprocess
> +import json
> +from typing import Iterator
> +
> +
> +def prettify(code: str) -> str:
> +    """Prettify code using clang-format if available"""
> +
> +    try:
> +        style = json.dumps({
> +            'IndentWidth': 4,
> +            'BraceWrapping': {'AfterFunction': True},
> +            'BreakBeforeBraces': 'Custom',
> +            'SortIncludes': False,
> +            'MaxEmptyLinesToKeep': 2,
> +        })
> +        p = subprocess.run(['clang-format', f'-style={style}'], check=True,
> +                           encoding='utf-8', input=code,
> +                           stdout=subprocess.PIPE)
> +        return p.stdout
> +    except FileNotFoundError:
> +        return code
> +
> +
> +def gen_header():
> +    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
> +    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
> +    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
> +    return f"""\
> +/*
> + * File is generated by scripts/block-coroutine-wrapper.py
> + *
> +{copyright}
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/coroutines.h"
> +#include "block/block-gen.h"
> +#include "block/block_int.h"\
> +"""
> +
> +
> +class ParamDecl:
> +    param_re = re.compile(r'(?P<decl>'
> +                          r'(?P<type>.*[ *])'
> +                          r'(?P<name>[a-z][a-z0-9_]*)'
> +                          r')')
> +
> +    def __init__(self, param_decl: str) -> None:
> +        m = self.param_re.match(param_decl.strip())
> +        if m is None:
> +            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
> +        self.decl = m.group('decl')
> +        self.type = m.group('type')
> +        self.name = m.group('name')
> +
> +
> +class FuncDecl:
> +    def __init__(self, return_type: str, name: str, args: str) -> None:
> +        self.return_type = return_type.strip()
> +        self.name = name.strip()
> +        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
> +
> +    def gen_list(self, format: str) -> str:
> +        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +    def gen_block(self, format: str) -> str:
> +        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +
> +# Match wrappers declared with a generated_co_wrapper mark
> +func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
> +
> +
> +def func_decl_iter(text: str) -> Iterator:
> +    for m in func_decl_re.finditer(text):
> +        yield FuncDecl(return_type='int',
> +                       name=m.group('wrapper_name'),
> +                       args=m.group('args'))
> +
> +
> +def snake_to_camel(func_name: str) -> str:
> +    """
> +    Convert underscore names like 'some_function_name' to camel-case like
> +    'SomeFunctionName'
> +    """
> +    words = func_name.split('_')
> +    words = [w[0].upper() + w[1:] for w in words]
> +    return ''.join(words)
> +
> +
> +def gen_wrapper(func: FuncDecl) -> str:
> +    assert func.name.startswith('bdrv_')
> +    assert not func.name.startswith('bdrv_co_')
> +    assert func.return_type == 'int'
> +    assert func.args[0].type in ['BlockDriverState *', 'BdrvChild *']
> +
> +    name = 'bdrv_co_' + func.name[5:]
> +    bs = 'bs' if func.args[0].type == 'BlockDriverState *' else 'child->bs'
> +    struct_name = snake_to_camel(name)
> +
> +    return f"""\
> +/*
> + * Wrappers for {name}
> + */
> +
> +typedef struct {struct_name} {{
> +    BdrvPollCo poll_state;
> +{ func.gen_block('    {decl};') }
> +}} {struct_name};
> +
> +static void coroutine_fn {name}_entry(void *opaque)
> +{{
> +    {struct_name} *s = opaque;
> +
> +    s->poll_state.ret = {name}({ func.gen_list('s->{name}') });
> +    s->poll_state.in_progress = false;
> +
> +    aio_wait_kick();
> +}}
> +
> +int {func.name}({ func.gen_list('{decl}') })
> +{{
> +    if (qemu_in_coroutine()) {{
> +        return {name}({ func.gen_list('{name}') });
> +    }} else {{
> +        {struct_name} s = {{
> +            .poll_state.bs = {bs},
> +            .poll_state.in_progress = true,
> +
> +{ func.gen_block('            .{name} = {name},') }
> +        }};
> +
> +        s.poll_state.co = qemu_coroutine_create({name}_entry, &s);
> +
> +        return bdrv_poll_co(&s.poll_state);
> +    }}
> +}}"""
> +
> +
> +def gen_wrappers(input_code: str) -> str:
> +    res = ''
> +    for func in func_decl_iter(input_code):
> +        res += '\n\n\n'
> +        res += gen_wrapper(func)
> +
> +    return prettify(res)  # prettify to wrap long lines
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) < 3:
> +        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
> +
> +    with open(sys.argv[1], 'w') as f_out:
> +        f_out.write(gen_header())
> +        for fname in sys.argv[2:]:
> +            with open(fname) as f_in:
> +                f_out.write(gen_wrappers(f_in.read()))
> +                f_out.write('\n')
> 

probably we want encoding='utf-8' for both open calls.

-- 
Best regards,
Vladimir

