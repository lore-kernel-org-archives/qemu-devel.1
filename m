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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA3DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E83206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hsyS9R6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E83206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtdP-0006nB-IG
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAtco-0006Hi-5N; Wed, 26 Aug 2020 07:29:54 -0400
Received: from mail-eopbgr40105.outbound.protection.outlook.com
 ([40.107.4.105]:35973 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAtck-0006ED-Vk; Wed, 26 Aug 2020 07:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTHqeFJI/SFDQrvX/63Y7YEs+rkxU5269om89S54V2glhsinYhCpIdCo7S+j42bUAFgBXIwrJVxqYfVyCi8PvN/BrPFrEnI2Irp1aZ+Y/BLdIbIL/ElzgWhWxtF3KBzf2oznk7vWtrJLm0UmN36ydtCrAWoU7N1JtHTUS8FVbcwA/SLn7MbJdI0oXfDDuS7c7JXJVaUP2lxGumsfv6IwJgySdOR2mjKWYHRIgDi6NkH1K/cVUTnrI8LtbaAG2h5E3RDOu1xzeVg0DCtlXt2B8pNxPJLqR/t1A6liUySEqWnSszCMEuvdZQo+OZrikG9MGWduyAjr5Q0g9aI57BuXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QxcgedOhnlgcYfu/kbPUwzPtnGdW9uJ0QrgrfZOFKU=;
 b=Jyc9sHaDpF3ixu1uBcwVvMNzAGRig9g/8B2JKA8qrtOOMGqUouWZiwKTZ61zp+O0lKlieX0Vq/e4k6EkKAt+dZQUm107bDztwcB1lQmAGwH8rijkfEFv1eYby5hPaP/w/Odf3f6b/VYtFeTdX/LottsKPAm6N+cwPIgzPqSeMszK4l4nCuNkD3NZ2ueKAQLW1q6Ch5Igzj6l1ZwFvULx0KUmyloYO2keOn9Rib67kDnW/hxhDr5EUnGeAv1zlFnxSklOwlc2lW1ZqVK7vM6e7fXUOMNI7w5ASZKaV9CNViVqT4WA6IQyCfmshTsM/dMGp+Hb2XuGQGAg8fpOV41a9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QxcgedOhnlgcYfu/kbPUwzPtnGdW9uJ0QrgrfZOFKU=;
 b=hsyS9R6KdvWHxzXJdHVxvPj95JoKYiWk8IBsdb7YK0g+1wgsCbWCkQ92zto0bUs0qzeu9XLcCwiiY/QwDl2xt8ddJ1D6oyGZcE5EkPK+f23OML2+oB4g6WB4ZNG18ErdzU3edb5uaZd7vYoUtBtgV/99vKQHrGZSaJy4vSmx4mg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3286.eurprd08.prod.outlook.com (2603:10a6:209:40::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 11:29:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 11:29:47 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org,
 nsoffer@redhat.com
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
 <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
 <3d155eaf-7365-70a7-f4fe-1abe88383087@redhat.com>
 <09281829-fbe3-7007-ca03-b57b6581c3bc@virtuozzo.com>
 <78c778e7-ee15-027e-aab5-4d7e9935e01d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <48b05641-a7a2-89dd-0fea-3f900749b1f0@virtuozzo.com>
Date: Wed, 26 Aug 2020 14:29:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <78c778e7-ee15-027e-aab5-4d7e9935e01d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 11:29:46 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72251d75-8537-4a2e-c4f0-08d849b35659
X-MS-TrafficTypeDiagnostic: AM6PR08MB3286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB328640DEEBACBFEB8B1C56F9C1540@AM6PR08MB3286.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPljSr83/FjUNd+Ky4NAloWn+tg7TlYJQKk/goGYeyZkyDPhkPDKoc3wctqgh37PM89x7nBcZU75MzR4bUUveCSVnhIpQMq6BloZiSh2Hk1J8WzHEn6Z/FahYIgb3hH3vj/oOrr8VQcUg0GUffP4ytrc2IWxDeUb1U/RYnuMAM/9toX9BPeYEMeKIgK4AR0FAqgt4lJQrBfpPP4n5VBWxfh4kVTmYmibUWdxWiwNHsoYondQNaO8WsR+URAya7d7aVg5LLwLDlg4iA2OgveLA3ewogJTM95A7sRZyQ51T51JwwKHOQRWiyEnRA2fpit0fLTMujMCzQM0oY+jB4gRrrTs2tPsEPZ2T76BgtHNFunikeIKTdWK4fhhvcxoPRp7CTSTfpwD3Dtosg+MGIsREGtUym7ty/zhe1WqbGJPixQ2DWcFaG2peV6QlWaUyGdtZDX67UaLV6oxDcyls3QEtPgnWn+mUgbnEgdP2H50Pi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(346002)(376002)(396003)(4326008)(478600001)(52116002)(36756003)(16526019)(26005)(16576012)(86362001)(66946007)(66556008)(31696002)(316002)(186003)(5660300002)(66476007)(53546011)(2616005)(956004)(8936002)(83380400001)(6486002)(31686004)(8676002)(2906002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Hg+fPjCI2P9m8/auDjGPdu1oxoY3ElNGHOQELS/srssbbjdef2FuyaxqDIS37VeA4SvYQWWUu7Msgnlycsmc1wcwhFQ5WL4gKyS09ppPFP+ytVF0fN1/mn/0b+EYruL4uvWjN3xrtQ/wewQp1ygYOReKH/99uWAw8BxDngW/K1hmvU92nkBvH/lBxBGY/2xeOgab9MkVci13dQviRqoMkoXT8dC6BLov7qHHqOCiAyyC8WKY8AD7GhC3tzVP1Wq92nTCvAPWSz+R8oqf6samy/LdrE3ynUHVazEDk1E1uL3kEzjFVcap0pFlvt9BhEfy6K3PwXnJ/T1Xpz9nuesTZMuXmbA4WfQwNe36FkdIzVCJde7ff0n4nDUpgyl/0J2rTVCTJ4VM7rZYQrSgHQs5u+CADUMhcWNhsdA5km/0bPGb+0WhNYOfKZq6lHkniXxsADX5avaFwXhoXU358Z6/wvv5YQAAsCqXHL5Y46Ed8Zb4EvxqZukTLXwqiuL+G0sRl/qNoxVibr5jCcLdIYic73J1+97zCOxC/logSaHpg9wT3vmrrJN8h8g4JgyIfdsNZ4/tE3CohN3BZIkxIiHmuStFbZq9YSb0PCq1M64kYBDEJW7l/ea5YVrzGn8tFPkzt4n/SxXCnupX+T4MA5Seeg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72251d75-8537-4a2e-c4f0-08d849b35659
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 11:29:47.0707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fybum5CSJ3SLOHmUx9ZYsR2TiQdXwLejTwrbOn7rrHaY8M7uJb6rMsYNRdYAvUIFTj1xx7K4xt3kZdAznrsv/cdGLkJ0QBL21HdDDkJbeLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3286
Received-SPF: pass client-ip=40.107.4.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 07:29:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001,
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

26.08.2020 12:58, Max Reitz wrote:
> On 26.08.20 11:15, Vladimir Sementsov-Ogievskiy wrote:
>> 26.08.2020 11:52, Max Reitz wrote:
>>> On 26.08.20 08:49, Vladimir Sementsov-Ogievskiy wrote:
>>>> 25.08.2020 18:11, Max Reitz wrote:
>>>>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> It's intended to be inserted between format and protocol nodes to
>>>>>> preallocate additional space (expanding protocol file) on writes
>>>>>> crossing EOF. It improves performance for file-systems with slow
>>>>>> allocation.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>     docs/system/qemu-block-drivers.rst.inc |  26 +++
>>>>>>     qapi/block-core.json                   |  20 +-
>>>>>>     block/preallocate.c                    | 291
>>>>>> +++++++++++++++++++++++++
>>>>>>     block/Makefile.objs                    |   1 +
>>>>>>     4 files changed, 337 insertions(+), 1 deletion(-)
>>>>>>     create mode 100644 block/preallocate.c
>>>
>>> [...]
>>>
>>>>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>>>>> new file mode 100644
>>>>>> index 0000000000..bdf54dbd2f
>>>>>> --- /dev/null
>>>>>> +++ b/block/preallocate.c
>>>>>> @@ -0,0 +1,291 @@
>>>>>> +/*
>>>>>> + * preallocate filter driver
>>>>>> + *
>>>>>> + * The driver performs preallocate operation: it is injected above
>>>>>> + * some node, and before each write over EOF it does additional
>>>>>> preallocating
>>>>>> + * write-zeroes request.
>>>>>> + *
>>>>>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>>>>>> + *
>>>>>> + * Author:
>>>>>> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/or
>>>>>> modify
>>>>>> + * it under the terms of the GNU General Public License as
>>>>>> published by
>>>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>>>> + * (at your option) any later version.
>>>>>> + *
>>>>>> + * This program is distributed in the hope that it will be useful,
>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> + * GNU General Public License for more details.
>>>>>> + *
>>>>>> + * You should have received a copy of the GNU General Public License
>>>>>> + * along with this program. If not, see
>>>>>> <http://www.gnu.org/licenses/>.
>>>>>> + */
>>>>>> +
>>>>>> +#include "qemu/osdep.h"
>>>>>> +
>>>>>> +#include "qapi/error.h"
>>>>>> +#include "qemu/module.h"
>>>>>> +#include "qemu/option.h"
>>>>>> +#include "qemu/units.h"
>>>>>> +#include "block/block_int.h"
>>>>>> +
>>>>>> +
>>>>>> +typedef struct BDRVPreallocateState {
>>>>>> +    int64_t prealloc_size;
>>>>>> +    int64_t prealloc_align;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Filter is started as not-active, so it doesn't do any
>>>>>> preallocations nor
>>>>>> +     * requires BLK_PERM_RESIZE on its child. This is needed to
>>>>>> create filter
>>>>>> +     * above another node-child and then do bdrv_replace_node to
>>>>>> insert the
>>>>>> +     * filter.
>>>>>
>>>>> A bit weird, but seems fair.  It’s basically just a cache for whether
>>>>> this node has a writer on it or not.
>>>>>
>>>>> Apart from the weirdness, I don’t understand the “another node-child”.
>>>>> Say you have “format” -> “proto”, and then you want to insert
>>>>> “prealloc”.  Wouldn’t you blockdev-add prealloc,file=proto and then
>>>>> blockdev-replace format.file=prealloc?
>>>>
>>>> Yes something like this. Actually, I'm about inserting the filter
>>>> automatically from block layer code, but your reasoning is about same
>>>> thing and is better.
>>>>
>>>>> So what is that “other node-child”?
>>>>
>>>> Hmm, just my misleading wording. At least '-' in wrong place. Just
>>>> "other node child", or "child of another node"..
>>>
>>> OK.
>>>
>>>>>> +     *
>>>>>> +     * Filter becomes active the first time it detects that its
>>>>>> parents have
>>>>>> +     * BLK_PERM_RESIZE on it.
>>>>>> +     * Filter becomes active forever: it doesn't lose active status
>>>>>> if parents
>>>>>> +     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink
>>>>>> the file on
>>>>>> +     * filter close.
>>>>>
>>>>> Oh, the file is shrunk?  That wasn’t clear from the documentation.
>>>>>
>>>>> Hm.  Seems like useful behavior.  I just wonder if keeping the
>>>>> permission around indefinitely makes sense.  Why not just truncate it
>>>>> when the permission is revoked?
>>>>
>>>> How? Parent is closed earlier, so on close we will not have the
>>>> permission. So, we force-keep the permission up to our close().
>>>
>>> I thought that preallocate_child_perm() would be invoked when the parent
>>> is detached, so we could do the truncate there, before relinquishing
>>> preallocate’s RESIZE permission.
>>>
>>
>> Hmm, I can check it. I just a bit afraid of doing something serious like
>> truncation in .bdrv_child_perm() handler, which doesn't seem to imply
>> such usage.
> 
> I’m a bit conflicted.  On one hand, I share your concern.  On the other,
> I find it completely reasonable that drivers might want to do I/O when
> permissions change.
> 
> Usually, this is done as part of reopen, like in qcow2 when a drive
> changes from R/W to RO and caches need to be flushed.  But I actually
> think it makes more sense as part of the permission system, because of
> course a reopen is not the only time when permissions can change.
> 
> So that would be another alternative, to implement
> .bdrv_reopen_prepare(), and to check reopen_state->perm there.  If
> RESIZE is about to go away, then we truncate.  We could keep track of
> whether we did any preallocations after the last such truncate, and if
> we did, do another truncate on close.
> 
> This would cover reopen at least.  Seems better than nothing, but, well...

Reopen will not cover the main case: bdrv_clase_all..

> 
> (One big problem I see with truncating in .bdrv_child_perm() is that
> that function is in no way committing.  It’s just a request: “If your
> parents need this of you, what do you need of your children?”
> But I think that could be addressed by doing it in .bdrv_set_perm()
> instead.  Of note is that file-posix actually does do I/O in its
> raw_set_perm() function, in that it commits to file locks.)

will try

> 
> [...]
> 
>>>>>> +static int coroutine_fn
>>>>>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>>> +                        bool exact, PreallocMode prealloc,
>>>>>> +                        BdrvRequestFlags flags, Error **errp)
>>>>>> +{
>>>>>> +    BDRVPreallocateState *s = bs->opaque;
>>>>>> +    int ret = bdrv_co_truncate(bs->file, offset, exact, prealloc,
>>>>>> flags, errp);
>>>>>> +
>>>>>> +    /* s->data_end may become negative here, which means unknown
>>>>>> data end */
>>>>>> +    s->data_end = bdrv_getlength(bs->file->bs);
>>>>>
>>>>> What would be the problem with just setting data_end = offset?  We only
>>>>> use data_end to truncate down on close, so basically repeat the
>>>>> bdrv_co_truncate() call here, which seems correct.
>>>>
>>>> We can use offset only if ret >= 0 && exact is true..
>>>
>>> Well, on close, we ignore any errors from truncate() anyway.  So even if
>>> we used exact=false here, it shouldn’t matter.
>>
>> Here we handle truncate from user. If I understand "exact" correctly the
>> following is possible:
>>
>> 1. parent does truncate 1M -> 2M, exact=false
>> 2. driver decides to truncate to 5M (exact condition is sutisfied)
>> 3. but we remember s->data_end = 2M, and on close will shrink to 2M
> 
> In theory, yes; in practice, exact=false just means to ignore failures
> due to unsupported sizes.  So in this example, the driver would have
> resized to 5M because 2M is an impossible size, and thus the shrink on
> close would just fail.
> 
>> Doesn't seem a real problem.. So, we just consider the preallocation
>> done by driver as our preallocation to be dropped on close().
>>
>> Could there be problems on user shrink?
>>
>> 1. parent does truncate 2M -> 1M, exact=false
>> 2. driver decides to do notihng (why not)
>> 3. on close() we'll shrink to 1M..
>>
>> Again, seems no real problems.
> 
> Same as above, in practice the only difference between exact=false and
> exact=true is how failures are reported.
> 
>> But in case when bdrv_co_truncate failed, we should call bdrv_getlength
>> anyway, as we don't know the result of failed truncation. Or we can just
>> set s->data_end = -1, and not care too much about fail-scenarios.
>>
>> So, probably we can do
>> s->data_end = ret < 0 : ret : offset;
>>
>> But I just feel safer with additional bdrv_getlength().
> 
> Yes, let’s just leave it as you wrote it.
> 
> (It’s a bit silly of me to argue based on how drivers handle exact=false
> in practice right now.  It can always change.  Also, I shouldn’t pretend
> calling bdrv_getlength() would be an issue whatsoever, because it just
> isn’t.)
> 
> Max
> 


-- 
Best regards,
Vladimir

