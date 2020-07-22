Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B637C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F7F206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HrHRvWWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F7F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCcM-0001v3-GM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyCbX-00012U-Kw; Wed, 22 Jul 2020 07:08:07 -0400
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:37685 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyCbT-0005gz-Ej; Wed, 22 Jul 2020 07:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki1tuMfumpy+BgDlZ2AKKT70ushwsgV/yt6J5eUAa76BN8aLNlAd4W9nICASYM2ydc6F3VwG/jD6qQLLNKYkt4faiM2C7a2SK91h2YH++1dAj6nmpXpCQsjqpWbZql/1qG+kc7XmFX0M0RowrZtITcZrbLXMz59XxryJp6E7Wk5zIYX6T2hF2LdgKs3VPoXfSWAVPu/an5qp+ABX/kFDD/sYx6EbPDJIdSuSjww3igg7g7VXNGnIVHdDI0Z6f6DnGc5q+FMnEWx6W2y2s1hhgZUXLwB/uw7X95HzcbWowgp3XnqTsHLymAPicL1Ig2kgT+CCkqF2PVRTUv4Kx5lVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq6V1QbInuzgLk/wkINps4KrlJBJUEzALX0D5qw9Hpc=;
 b=Ea0aE7NjAlnYBAzBNHZoAtRZnf+WYh1f6xAGuhPInPyy8ccNdhnnGlFIqBje3gu92T3igwPr29leFgdBkycxG9/VnuUxEY5X1EltYngW43Xy7bXSpeDsfNKSTajeT+kPgUwr5oFAya9sda1IWcusWz8gaKMIhZOMJpcDNHOHqqXdZqGDQ+FdGjfKO8RVqwUVy5kwvuImr5JdD0hSfZf/rdEZFyopOcPT06UDYtW6HIGvOtGqXhr/kW0F7X0wObM6FVdNQNzw09Y9NWeXb/8Lw1MwKXWMObbjIlXFM0yJvGgK+2JrPkZpXEnOV6fC/B3ifNTZp3TbBHdvovK4yuxqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq6V1QbInuzgLk/wkINps4KrlJBJUEzALX0D5qw9Hpc=;
 b=HrHRvWWFajTXBpyLixdef6itHhjeH5Rh6GoLZnytx2Q4lemmHX638wnWJIChiSqSxUG0OGE67hesyjkLNPTSfeL+RSXj/RgrVrOqJ/HpENvOUt1hC3jXnMAgcCkL3TVB1BG0Zl2e/WTzXNL8iTGroRuI7wkxpo5cOBEvEXGK51g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4216.eurprd08.prod.outlook.com (2603:10a6:20b:89::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 11:07:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 11:07:59 +0000
Subject: Re: [PATCH v2 1/3] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200716135303.319502-1-mreitz@redhat.com>
 <20200716135303.319502-2-mreitz@redhat.com>
 <ab6c9048-868f-23bc-5366-ca53f11f01a5@virtuozzo.com>
 <c6245682-d688-1596-964c-8b08c46e53fd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7ac8b833-943a-ae13-6861-a800c4f4181f@virtuozzo.com>
Date: Wed, 22 Jul 2020 14:07:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c6245682-d688-1596-964c-8b08c46e53fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0020.eurprd07.prod.outlook.com
 (2603:10a6:200:42::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 AM4PR0701CA0020.eurprd07.prod.outlook.com (2603:10a6:200:42::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.15 via Frontend
 Transport; Wed, 22 Jul 2020 11:07:59 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c24326-d9fd-49a7-ac17-08d82e2f7e9f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4216:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4216013B4C1623B4BD166B3EC1790@AM6PR08MB4216.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxuT24hDQE+bV0MyJYMf77SKhyynFUovuGo1X5PnQj7dDfLTOztjNDmhJ02ZGSnhHkjObXOr9Sp4qnWbvOMaQdaclUlIYAnC7n68vghtp47RIN0qNmBu8ofgfcBuocci+SQJrtX35lgQZfjdoo+cuTmCZsWhPy3MdxEht7IJSClt18/QbKLWQDLK/xIFAqYXSLY1C2R+ardMMpkNnV5WwET3Eve/Lw9+oYs/XqRqP9dI4wTE38h3fg2wvgbklfb9ESwYpkjFtIB03vvdNQN1I3uh8oAA++HH4YD9IpK+gdsim2nmsgS0nNKE0DScjrvUdJLGE+M+RkBVzBUR/A5G8QXH3NOGT304j4Mauxr+VdB2HdxJ496jVxiP3J/qgtOJVVIx7IPBqTVs/oBX3sr0cyvCSteWQ+xYB23rtPUmEbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(83380400001)(36756003)(186003)(2616005)(31686004)(54906003)(16576012)(16526019)(26005)(66946007)(956004)(5660300002)(66556008)(66476007)(86362001)(4326008)(8676002)(31696002)(316002)(478600001)(53546011)(52116002)(8936002)(2906002)(6486002)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: B/ac85REjcXKJzJPC645k0UQ8/hsq+y/ZNeyL/908Hu2Y0WwxOABnybmt3ySC61lbgq7xsesgwqXg/tf4vrbQbds/EMZb0YeqJrkGp/VkLmAI4beSNvjT9skU9KTR1cQQz9yrwJUig8FWTgfB3Ok9ipFvYe+ztXJXZFOXyvuovclIvdIRpodowPJcKcKON0/W34ZOc9UC3vPUYZHWIs4nfHQu0PRJuKBwNscKEdIz+o4nxkhiWbU83w3tWNnLwuU9TnBsnEdX4ScG6zdCvCbfWPfzoyY73ub84ev0c0vv7NxehayzqiQm8GM8YxbUhi1FQoX/nWn2h3ewiojNPswb2jG+hXE2BSMm88OJygcHRY8oBMEQoJNOF7+tOO/l38DT3ZvgEV0iObF/msrDMyS+EOR782tJwObENuKGYBE6KuaR6QTyAnxtY+qC5erEEqClwYqT8lw3iiS66U3j9S1cb1h2hEn3AyjdJ6BWPH4sLI4zAjd/vK0gg+NDJkPUH9D
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c24326-d9fd-49a7-ac17-08d82e2f7e9f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 11:07:59.6774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeQnbAw4RFc3h5RlqbHIE/P2nBEftLozCAflRzyqH4ND15NZTltkgUBwV4IH2skujm9cRhPOMVM2oRK8+HQI2/5u/JQoJNg01RVY2ZftZew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4216
Received-SPF: pass client-ip=40.107.20.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 07:08:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.07.2020 11:02, Max Reitz wrote:
> On 20.07.20 18:31, Vladimir Sementsov-Ogievskiy wrote:
>> 16.07.2020 16:53, Max Reitz wrote:
>>> This migration parameter allows mapping block node names and bitmap
>>> names to aliases for the purpose of block dirty bitmap migration.
>>>
>>> This way, management tools can use different node and bitmap names on
>>> the source and destination and pass the mapping of how bitmaps are to be
>>> transferred to qemu (on the source, the destination, or even both with
>>> arbitrary aliases in the migration stream).
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>> Vladimir noted in v1 that it would be better to ignore bitmaps whose
>>> names aren't mapped, or that are on nodes whose names aren't mapped.
>>> One of the reasons he gave was that bitmap migration is inherently a
>>> form of postcopy migration, and we should not break the target when it
>>> is already running because of a bitmap issue.
>>>
>>> So in this version, I changed the behavior to just ignore bitmaps
>>> without a mapping on the source side.  On the destination, however, I
>>> kept it an error when an incoming bitmap or node alias is unknown.
>>>
>>> This is in violation of Vladimir's (rightful) reasoning that such
>>> errors should never break the already running target, but I decided to
>>> do so anyway for a couple of reasons:
>>>
>>> - Ignoring unmapped bitmaps on the source is trivial: We just have to
>>>     not put them into the migration stream.
>>>     On the destination, it isn't so easy: We (I think) would have to
>>>     modify the code to actively skip the bitmap in the stream.
>>>     (On the other hand, erroring out is always easy.)
>>
>> Agree. Actually, my series "[PATCH v2 00/22] Fix error handling during
>> bitmap postcopy"
>> do something like this. But no sense in mixing such logic into your
>> series :)
>>
>>>
>>> - Incoming bitmaps with unknown names are already an error before this
>>>     series.  So this isn't introducing new breakage.
>>>
>>> - I think it makes sense to drop all bitmaps you don't want to migrate
>>>     (or implicitly drop them by just not specifying them if you don't care
>>>     about them) on the source.  I can't imagine a scenario where it would
>>>     be really useful if the destination could silently drop unknown
>>>     bitmaps.  Unknown bitmaps should just be dropped on the source.
>>>
>>> - Choosing to make it an error now doesn't prevent us from relaxing that
>>>     restriction in the future.
>>
>> Agree, that's all OK. Still we can at least ignore, if we don't get some
>> bitmap on destination, for which mapping is set (I think you do exactly
>> this, will see below).
>>
>>
>>> ---
>>>    qapi/migration.json            |  92 +++++++-
>>>    migration/migration.h          |   3 +
>>>    migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++++++++++-----
>>>    migration/migration.c          |  30 +++
>>>    monitor/hmp-cmds.c             |  30 +++
>>>    5 files changed, 473 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index d5000558c6..1b0fbcef96 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -507,6 +507,44 @@
>>
>> [..]
>>
>>>    #
>>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>>> +#          aliases for the purpose of dirty bitmap migration.  Such
>>> +#          aliases may for example be the corresponding names on the
>>> +#          opposite site.
>>> +#          The mapping must be one-to-one, and on the destination also
>>> +#          complete: On the source, bitmaps on nodes where either the
>>> +#          bitmap or the node is not mapped will be ignored.  In
>>> +#          contrast, on the destination, receiving a bitmap (by alias)
>>> +#          from a node (by alias) when either alias is not mapped will
>>> +#          result in an error.
>>
>> Still, not receiving some bitmap is not an error. It's good. I think,
>> should
>> be mentioned here too (does it violate "compelete" term?).
> 
> Hm.  Well, from the implementation’s perspective, it obviously isn’t an
> error, because there’s no list of bitmaps that’s transferred outside of
> the bitmaps themselves; so if some bitmap isn’t transferred, the
> destination of course never knows about it.  (And “complete” just means
> that all received bitmaps must be mapped.)
> 
> So I never thought about mentioning that detail here.
> 
> How would we even go about documenting that?  “Note that the destination
> does not know about bitmaps it does not receive, so there is no
> limitation or requirement about the number of bitmaps received, or how
> they are named, or on which nodes they are placed.”

Destination "knows" about bitmaps to receive, if block-bitmap-mapping set
on destination.. Hm, but yes, mapping is not a list of bitmaps to receive,
it's just mapping. May be, "Note that it's not an error if source qemu doesn't find
all bitmaps specified in mapping or destination doesn't receive all such
bitmaps"? But I'm OK without any additional note as well.

> 
>>> +#          By default (when this parameter has never been set), bitmap
>>> +#          names are mapped to themselves.  Nodes are mapped to their
>>> +#          block device name if there is one, and to their node name
>>> +#          otherwise. (Since 5.2)
>>> +#
>>>    # Since: 2.4
>>
>> [..]
>>
>>> -static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState
>>> *s)
>>> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState
>>> *s,
>>> +                                    GHashTable *alias_map)
>>>    {
>>> +    GHashTable *bitmap_alias_map = NULL;
>>>        Error *local_err = NULL;
>>>        bool nothing;
>>>        s->flags = qemu_get_bitmap_flags(f);
>>> @@ -676,25 +890,68 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>>> DirtyBitmapLoadState *s)
>>>        nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
>>>          if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
>>> -        if (!qemu_get_counted_string(f, s->node_name)) {
>>> -            error_report("Unable to read node name string");
>>> +        if (!qemu_get_counted_string(f, s->node_alias)) {
>>> +            error_report("Unable to read node alias string");
>>>                return -EINVAL;
>>>            }
>>> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
>>> +
>>> +        if (alias_map) {
>>> +            const AliasMapInnerNode *amin;
>>> +
>>> +            amin = g_hash_table_lookup(alias_map, s->node_alias);
>>> +            if (!amin) {
>>> +                error_report("Error: Unknown node alias '%s'",
>>> s->node_alias);
>>> +                return -EINVAL;
>>> +            }
>>> +
>>> +            bitmap_alias_map = amin->subtree;
>>> +            s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
>>> +        } else {
>>> +            s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
>>> &local_err);
>>> +        }
>>>            if (!s->bs) {
>>>                error_report_err(local_err);
>>>                return -EINVAL;
>>>            }
>>> -    } else if (!s->bs && !nothing) {
>>> +    } else if (s->bs) {
>>> +        if (alias_map) {
>>> +            const AliasMapInnerNode *amin;
>>> +
>>> +            /* Must be present in the map, or s->bs would not be set */
>>> +            amin = g_hash_table_lookup(alias_map, s->node_alias);
>>> +            assert(amin != NULL);
>>> +
>>> +            bitmap_alias_map = amin->subtree;
>>> +        }
>>> +    } else if (!nothing) {
>>>            error_report("Error: block device name is not set");
>>>            return -EINVAL;
>>>        }
>>>    +    assert(!!alias_map == !!bitmap_alias_map);
>>
>> Actually one '!' is enough. But '!!' looks good too (usual convertion to
>> bool, why not).
>>
>> But what's more serious: this assertion will fail in case of "nothing"
>> (sorry my architecture :(.
>>
>> I assume, by protocol, chunk with EOS flag may contain bitmap and/or
>> node information or may not.
>>
>> So, it most probably should be: assert(nothing || (!alias_map ==
>> !bitmap_alias_map))
> 
> Right, sure.
> 
>> (You can cover "nothing" case in test, if enable bitmap migrations when
>> no bitmaps to migrate)
> 
> Thanks, will do.
> 
>>> +
>>>        if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> -        if (!qemu_get_counted_string(f, s->bitmap_name)) {
>>> +        const char *bitmap_name;
>>> +
>>> +        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
>>>                error_report("Unable to read bitmap name string");
>>>                return -EINVAL;
>>>            }
>>> +
>>> +        if (bitmap_alias_map) {
>>> +            bitmap_name = g_hash_table_lookup(bitmap_alias_map,
>>> +                                              s->bitmap_alias);
>>> +            if (!bitmap_name) {
>>> +                error_report("Error: Unknown bitmap alias '%s' on
>>> node '%s' "
>>> +                             "(alias '%s')", s->bitmap_alias,
>>> s->bs->node_name,
>>> +                             s->node_alias);
>>> +                return -EINVAL;
>>> +            }
>>> +        } else {
>>> +            bitmap_name = s->bitmap_alias;
>>> +        }
>>> +
>>> +        g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>>
>> Hmm. Actually, we should check that in alias map target bitmap_name is
>> short enough. It may be done later.
> 
> OK.
> 
>>>            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>>>              /* bitmap may be NULL here, it wouldn't be an error if it
>>> is the
>>> @@ -702,7 +959,7 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>>> DirtyBitmapLoadState *s)
>>>            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>>
>>
>> OK, with assertion fixed;
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Thanks again!
> 
>> It's a bit weak, because:
>>
>>   - I don't have good understanding all these migration parameters logics
>> with this triple duplication. So if it works in test, it should be good
>> enough.
> 
> I hope so, yes.
> 
>>   - The whole logic of bitmap migration is a bit hard to follow (I know,
>> that it's my code :).
> 
> O:)
> 
>> I'll revisit it when rebasing my big series
>> "[PATCH v2 00/22] Fix error handling during bitmap postcopy".
> 
> 


-- 
Best regards,
Vladimir

