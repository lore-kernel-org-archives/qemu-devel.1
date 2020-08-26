Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70041206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tsNHwAyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70041206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArXl-00028s-IW
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kArXC-0001fj-8n; Wed, 26 Aug 2020 05:15:58 -0400
Received: from mail-eopbgr10122.outbound.protection.outlook.com
 ([40.107.1.122]:54423 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kArX8-0005jx-9n; Wed, 26 Aug 2020 05:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBo5YXcW7OMgICIeUTZF7lLf3ZuXCYbMOj3CVKMCNmURj/DRm+pIUKlG3BtuM0vRshEgG3m8YqcaliAva1glCIODvMVNm1BIDekEf9eIx3wlIVTIH6sThJ3GOXIBwHv5ZXwqcUT0ED87xQhfO8aDwBn3tzPYTX0wGG+DiyJx9xPMQOoF5+WRTiZf9ycifY1onh5Jnr7U8MMjUwi1ZfplGlKLtI5rhxh1kAQ29imNNmnQxhggWY7WVo7351CU01hEsvGZKZ3rublvsC6DzVEbrmuWhOcSdAkN3xvrZO641u4mejCu+2ObJz5sW9frjqbhTY1CtjrgTA3BwV2sdISVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvO/AhEv8fwWyME883uw96cKuBBq/fwQ9huGRxkHbs4=;
 b=KL1YBS3dHsGJ1pT+q01DefOYmVkAxv/Ie6VOwaOO/FaQL3pCRgw2Ck1x/TvFMyc68O3G4YBBTS+KvtX9d9g3MFLIewJ6Or4M4cwTB3nLu5F8sgJftyqi0ReyQ/ax7Ek+rFcaB8IO7upE+w8FRAppaRQ0zLfT5gLg5lbErPmraRaoBx24R72CPTCI2lAZo5MrfvW12RGmWRpOejap1M0N5RjeM48/FgfVRCU5m/Ps25yYo+G54Fhjuxk+AHGPH4Br49RhkDjHkLiqwkQgXn+AaVsZMr4/sy2nre/AfbRcNqzOKb85j5LeAofDLU6cdcDl/9Ni95ltC7x3FK8C8/MUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvO/AhEv8fwWyME883uw96cKuBBq/fwQ9huGRxkHbs4=;
 b=tsNHwAyHDdE7/2tY2ryteDGshsnl12lV8lCxm7BqcAUMPVI7imUVmcH3vso3j5m262aYvxImdO9cp6fjtH/4je1cl5YE8JPSeRahdD/NDXSlrsCoG2nrQDLZT3LLWbYZbYVBcIwvYh7OdAAQfZtnryttzs2cC03utKcl6Lxa6uc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 09:15:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 09:15:48 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
 <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
 <3d155eaf-7365-70a7-f4fe-1abe88383087@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <09281829-fbe3-7007-ca03-b57b6581c3bc@virtuozzo.com>
Date: Wed, 26 Aug 2020 12:15:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <3d155eaf-7365-70a7-f4fe-1abe88383087@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0501CA0065.eurprd05.prod.outlook.com
 (2603:10a6:200:68::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR0501CA0065.eurprd05.prod.outlook.com (2603:10a6:200:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 09:15:48 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f71e1a-1e74-4c52-d9fc-08d849a09f20
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376743E332C37119E59AD278C1540@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29LRkIDY353iNrfyJKmCFRSkCVhhn87aVYdSMkcO8SQ2n82TFM2bWMw8AlZ/FcYmwIk1ud7ocqIsPulwvW3WRa6SCFGuMH6QZFIqT+t5Vb/9VksKRI/qkzhxH//AVrICD6C9RXpQBV9zNGdxtZZutApaX3KKss6XnAQ+KafQF68Te7DInmELz8G+ZaBgCCc2Xa5JpPlD2jjxgKOO7Z4nyA2Pohm4J1PUVBan620DDV1SUbcFsgv0oF4k1fpvGXx8e0f6u8ZEn+82GhTQTdFstuVvtfdPF5qPVrmmzJfsHci9RU7FSO+MQr2Wts5zSPd3V9zo9mwhUyymDJJ4tq+C0sK9zl3MGxEqJCuebGsHnwp5kJF5cimXg4eOeTtGkV6Zbg9/eX4acBRGn2fxfnLkAQC58xqbyGSkeCvlpjBtunb9cM93F0FynZCv43yP3lkkQVUK1Al3MyblzkPJv6Be2xuBJ9EL/E4mXQSYL5bfxfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(8936002)(478600001)(53546011)(8676002)(86362001)(52116002)(36756003)(26005)(186003)(16526019)(31686004)(83380400001)(956004)(2616005)(2906002)(4326008)(16576012)(6486002)(66556008)(66476007)(66946007)(31696002)(5660300002)(316002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uizP2MDZ7pu3mRK1458iQpYWPn+/kAUjmJq/tdE1l5lLteqk3nr24Vw2GZ/duIgCu0QrELHgfCJ3XQOcubZucJpz3PUj1RSA5//eJgyAOHpyljGvPEzptyJ8jVdzn+6Z3Qh7CEwra0QxlXXKg3yDnY/tZ3iFIagvkRrfpW/McBRGzkMqqD0CTQrDHXPCX+5GZhQE6LpVDUF7+2+TLFJS+z3o3SPEG3vQ8AnFIvbhjdlZxegSU8SdQ4334wYFzvfnrAQhf8hypBHy84ZmlbOfAE2mV8exTVY+3pCDQdiM+eYe1r1y/ZTvojrVhDBtFbvnAt5keIAud6g4mPpbvoXRp6YLS7/Q3TkXJHv2xCfLHiTh7J49fRckr9a50nY9Kq/dNAQbcH+3ScLPIxu9py2p8xvPoaBuE4GpStwoF9MBWacxGujxwo3COwCgNt1RdArVgYuhP9pDgssqTipyORU4kEScTLimpkeTt0hqkoWrPk6OUn5O0mB2TSyE8kq+NJh8tLTZ2qGA299GYhMkW6a17/F5wcOHM/g5vPATlR+ZJdDmc8PfcUDKMek8WP8p7AXQ4MRl8RmnZ2THjVrlf1wtg64H44MB2oaUFvTTwZuBRFVHbm66WIp52TN0vtADa2cju4uz/hZETW9xB/j7E8P73Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f71e1a-1e74-4c52-d9fc-08d849a09f20
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 09:15:48.8391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tryu7zHD7eOkDPkoAOBVObsfEhIesRGMkYa0Vdb6GMXlfhmhXlinsFjwUDrsT7Zgolz9KrZAtOfpH7qgkGNzlbRTow5xQ55Cw6Bv3NXnJ68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.1.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:15:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.08.2020 11:52, Max Reitz wrote:
> On 26.08.20 08:49, Vladimir Sementsov-Ogievskiy wrote:
>> 25.08.2020 18:11, Max Reitz wrote:
>>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> It's intended to be inserted between format and protocol nodes to
>>>> preallocate additional space (expanding protocol file) on writes
>>>> crossing EOF. It improves performance for file-systems with slow
>>>> allocation.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    docs/system/qemu-block-drivers.rst.inc |  26 +++
>>>>    qapi/block-core.json                   |  20 +-
>>>>    block/preallocate.c                    | 291 +++++++++++++++++++++++++
>>>>    block/Makefile.objs                    |   1 +
>>>>    4 files changed, 337 insertions(+), 1 deletion(-)
>>>>    create mode 100644 block/preallocate.c
> 
> [...]
> 
>>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>>> new file mode 100644
>>>> index 0000000000..bdf54dbd2f
>>>> --- /dev/null
>>>> +++ b/block/preallocate.c
>>>> @@ -0,0 +1,291 @@
>>>> +/*
>>>> + * preallocate filter driver
>>>> + *
>>>> + * The driver performs preallocate operation: it is injected above
>>>> + * some node, and before each write over EOF it does additional
>>>> preallocating
>>>> + * write-zeroes request.
>>>> + *
>>>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>>>> + *
>>>> + * Author:
>>>> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +
>>>> +#include "qapi/error.h"
>>>> +#include "qemu/module.h"
>>>> +#include "qemu/option.h"
>>>> +#include "qemu/units.h"
>>>> +#include "block/block_int.h"
>>>> +
>>>> +
>>>> +typedef struct BDRVPreallocateState {
>>>> +    int64_t prealloc_size;
>>>> +    int64_t prealloc_align;
>>>> +
>>>> +    /*
>>>> +     * Filter is started as not-active, so it doesn't do any
>>>> preallocations nor
>>>> +     * requires BLK_PERM_RESIZE on its child. This is needed to
>>>> create filter
>>>> +     * above another node-child and then do bdrv_replace_node to
>>>> insert the
>>>> +     * filter.
>>>
>>> A bit weird, but seems fair.  It’s basically just a cache for whether
>>> this node has a writer on it or not.
>>>
>>> Apart from the weirdness, I don’t understand the “another node-child”.
>>> Say you have “format” -> “proto”, and then you want to insert
>>> “prealloc”.  Wouldn’t you blockdev-add prealloc,file=proto and then
>>> blockdev-replace format.file=prealloc?
>>
>> Yes something like this. Actually, I'm about inserting the filter
>> automatically from block layer code, but your reasoning is about same
>> thing and is better.
>>
>>> So what is that “other node-child”?
>>
>> Hmm, just my misleading wording. At least '-' in wrong place. Just
>> "other node child", or "child of another node"..
> 
> OK.
> 
>>>> +     *
>>>> +     * Filter becomes active the first time it detects that its
>>>> parents have
>>>> +     * BLK_PERM_RESIZE on it.
>>>> +     * Filter becomes active forever: it doesn't lose active status
>>>> if parents
>>>> +     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink
>>>> the file on
>>>> +     * filter close.
>>>
>>> Oh, the file is shrunk?  That wasn’t clear from the documentation.
>>>
>>> Hm.  Seems like useful behavior.  I just wonder if keeping the
>>> permission around indefinitely makes sense.  Why not just truncate it
>>> when the permission is revoked?
>>
>> How? Parent is closed earlier, so on close we will not have the
>> permission. So, we force-keep the permission up to our close().
> 
> I thought that preallocate_child_perm() would be invoked when the parent
> is detached, so we could do the truncate there, before relinquishing
> preallocate’s RESIZE permission.
> 

Hmm, I can check it. I just a bit afraid of doing something serious like truncation in .bdrv_child_perm() handler, which doesn't seem to imply such usage.

> 
>>>> +static void preallocate_close(BlockDriverState *bs)
>>>> +{
>>>> +    BDRVPreallocateState *s = bs->opaque;
>>>> +
>>>> +    if (s->active && s->data_end >= 0 &&
>>>> +        bdrv_getlength(bs->file->bs) > s->data_end)
>>>> +    {
>>>> +        bdrv_truncate(bs->file, s->data_end, true,
>>>> PREALLOC_MODE_OFF, 0, NULL);
>>>
>>> Now that I think more about it...  What if there are other writers on
>>> bs->file?  This may throw data away.
>>
>> Good point. Actually, if bs->file has other writing parents, the logic
>> of the filter
>> around "data_end" is broken. So we must unshare WRITE and RESIZE
>> permissions.
> 
> That’s certainly a heavy hammer, but it’d work.
> 
>>>   Maybe BDS.wr_highest_offset can
>>> help to make a better call?
>>
>> Anyway, we'll have to use wr_highest_offset of the filter not the child
>> node
>> (in the child wr_highest_offset will track preallocations as well),
> 
> That’s true.
> 
>> so we want to unshare WRITE/RESIZE permissions.
> 
> [...]
> 
>>>> +static int coroutine_fn
>>>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>>>> +                        bool exact, PreallocMode prealloc,
>>>> +                        BdrvRequestFlags flags, Error **errp)
>>>> +{
>>>> +    BDRVPreallocateState *s = bs->opaque;
>>>> +    int ret = bdrv_co_truncate(bs->file, offset, exact, prealloc,
>>>> flags, errp);
>>>> +
>>>> +    /* s->data_end may become negative here, which means unknown
>>>> data end */
>>>> +    s->data_end = bdrv_getlength(bs->file->bs);
>>>
>>> What would be the problem with just setting data_end = offset?  We only
>>> use data_end to truncate down on close, so basically repeat the
>>> bdrv_co_truncate() call here, which seems correct.
>>
>> We can use offset only if ret >= 0 && exact is true..
> 
> Well, on close, we ignore any errors from truncate() anyway.  So even if
> we used exact=false here, it shouldn’t matter.

Here we handle truncate from user. If I understand "exact" correctly the following is possible:

1. parent does truncate 1M -> 2M, exact=false
2. driver decides to truncate to 5M (exact condition is sutisfied)
3. but we remember s->data_end = 2M, and on close will shrink to 2M

Doesn't seem a real problem.. So, we just consider the preallocation done by driver as our preallocation to be dropped on close().

Could there be problems on user shrink?

1. parent does truncate 2M -> 1M, exact=false
2. driver decides to do notihng (why not)
3. on close() we'll shrink to 1M..

Again, seems no real problems.

But in case when bdrv_co_truncate failed, we should call bdrv_getlength anyway, as we don't know the result of failed truncation. Or we can just set s->data_end = -1, and not care too much about fail-scenarios.

So, probably we can do
s->data_end = ret < 0 : ret : offset;

But I just feel safer with additional bdrv_getlength().

> 
>> But simpler is
>> just call
>> bdrv_getlength() anyway.
> 
> Certainly simpler than thinking about potential edge cases, true.
> 
> Max
> 


-- 
Best regards,
Vladimir

