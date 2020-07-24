Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD58C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5CC2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OlIQ0ikw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5CC2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuwC-0002Ol-Oj
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyuvJ-0001qs-Ci; Fri, 24 Jul 2020 06:27:29 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:9921 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyuvG-0000pw-8p; Fri, 24 Jul 2020 06:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm5IKdW/j9QfXQHRkv2d8Uxi75yJO6LWDpOci5tsargCFxmv9XIIcxs/RoWST9tgDFKBBSZxECIYF1QQsC4Ce5wuseJjN+jpAC7iY7qkrUeRMLPNtXroj7kVN7DnU6zkLqj7kV7PNL2IJq5G306yIjFsfcpg7fb7q2RrtLM6N+LcuTseilTt+O21Mdf6f+V4qdhI16h5f0aiT1ds8CMLOvfaqW88TT673AfYhHfWVp++/s6T2mmpMfMLl5J3qeckStDDyJPsXQmn8DucJh1+LBArFpdCuqoHjU9Ewn3G3stbtYyZ5zk5ohKGX4byoSeReUWAng5YRC88qASGdCqakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98bfTot3O/+lDehVT18E5jLtqhf2ANoSAiyrvtU4Jhg=;
 b=SFOPdrfasrdXYI9IBhBc62/Bn7cn2+X8zYDeoYqy6Mvmitm3Xv3n/ZLMkhx6rUW/Y7L/+ylraNZvRajWTeyX6bscNnr/shfijs3oJ+x1mWqfkbIWavrvI1Gg3TFTVdTcYcF3a7XqVRs7/DMjC45cH8UG4Le7a3fgpqYZobVxVHvI3ujkaPwMhGBEEX1kztjQ/WhNnDHcI83tXDEAdPZJySTuAyl6LZ8tMtNQuTAft3OGksMBAKQRO2asixN4xJQZL6OGyirbck7y0qLC0FgBHz85R3b6zPigilc7DJujLP1QA5d86uGsImPbrqIpYrHILWMQREV7+a8jwkzZ6W9yuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98bfTot3O/+lDehVT18E5jLtqhf2ANoSAiyrvtU4Jhg=;
 b=OlIQ0ikw5OBUnQgm7pQZdLxDs6mmIMPD6xZkg1eyUm0xOLoVbxzh9ibNTpEYNJpieB8rVL7DlHYYmduxs/F6Tyk25m3ruMczS2jcSnT67xdn/Uw2PqHJOHz2hzCFAhXlGdypPXQm0AUIF5yzeoF2thS8rE/r/nNP/JrQpwQyTG0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:27:22 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:27:22 +0000
Subject: Re: [PATCH v7 33/47] mirror: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-34-mreitz@redhat.com>
 <b69b871a-4cc5-a09d-c20b-deaa7438afda@virtuozzo.com>
 <bc5ef8af-6938-6abf-1232-e58c5caad38a@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <27bb3cef-f033-5a12-d0ce-38981c1a8c40@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:27:17 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <bc5ef8af-6938-6abf-1232-e58c5caad38a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0302CA0029.eurprd03.prod.outlook.com
 (2603:10a6:205:2::42) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM4PR0302CA0029.eurprd03.prod.outlook.com (2603:10a6:205:2::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 10:27:19 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef252a00-d8eb-499b-bf53-08d82fbc2687
X-MS-TrafficTypeDiagnostic: AM6PR08MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5080EB6F9AF800C4EA0D33E9F4770@AM6PR08MB5080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVCvdIlk99ziK2RCmWGIMafgfXOwU4FuOuhxlOtHRpIvOVfcFCKaD4Jsw8SD0IcbVSD0zB4CjNkjTSXu7RsbnDKUmTQliFAKo8a5q5kUnllwRHQB/+2lkQH/7pGnDV2QbMAiJiG9OP+Bf5ogrOa3CaI1K10txFL9XjphhwbXHGwvDAIfvJ6Yb/glX9BPWVx//cFvw6r/zyhDpf+uVZgBp2bEPeqiiolJofz3RO+ZJ3XAHpkVjgNsGOzv1qbi0s5aqvNLDZKvGEVNpwxXjyvTrrXBLIQ41SlsqvFuUfI9ntd0idBZjzuJzi7ghvm+3ErwfEbsUqLiqREwq7TTHHp9S8MunnxXIvQQGEKL3hchQ5ccg+IGnWUsNGuJvgnDX9o04hfdgu/i5uVhCGeGHgNbpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(31686004)(2906002)(26005)(53546011)(36756003)(6506007)(52116002)(44832011)(86362001)(5660300002)(6512007)(6486002)(8676002)(66946007)(478600001)(316002)(83380400001)(956004)(8936002)(186003)(66556008)(66476007)(16526019)(4326008)(54906003)(31696002)(2616005)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: p2Qbe0oPurEaQrm/jLVj7eqf7LgbaarsugrRyXpq2EPRwN6eF+QLl3SOGa0GK9oxaQAqHwAljtyX71woFrjydl8aitzMbYwD1bAiMWLOjLULX2izRQfu51mAZ0bwhtsBczgPRojBikTh0j3thH+A7lkkIPRrvmBc4Q6FgrO4464Zg5OHhRzFhKvswlk2esmiILQTZtO9lJKdWOpvsojvN0n8lW4oebNs4Zvi493vH50u6CUhDyBaHnoQ+Bxk1uStE7Nfd61JRq8uDhlzUb10yZeDWZuy4o6OygLol2j+NNjwWjA+PSfgQsxZ49ALQpoN4XHV1fAKaWAzRkbQ00G4mWGoD/TChidd9rFpSmqV42z+sZQwsLHaExGcBejEud4w08STwKE5EtacJ7zQXXcx/cMED38GIlnVf0eTNrs4FCWKEb8xxwU7zYkxakbySQLwWk9Py+GXwkItqX6UMG+/NnjsoqVDY5bx802sFHDuV4MQ5G4xyg6Y0rtnw4ham7wW
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef252a00-d8eb-499b-bf53-08d82fbc2687
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:27:22.4320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZyqrJ2Zo3bJMlt9ZHgZkCB39WX8MXAYXApZb8DtrYv+nstyoHUagIM/dlF5Ff95G/ouSHoqQ8Kdv17KwCF6PH48xJTSBxJL/sh+v1YUHpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.20.113;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:27:23
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.07.2020 12:49, Max Reitz wrote:
> On 22.07.20 20:31, Andrey Shinkevich wrote:
>> On 25.06.2020 18:22, Max Reitz wrote:
>>> This includes some permission limiting (for example, we only need to
>>> take the RESIZE permission for active commits where the base is smaller
>>> than the top).
>>>
>>> Use this opportunity to rename qmp_drive_mirror()'s "source" BDS to
>>> "target_backing_bs", because that is what it really refers to.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    qapi/block-core.json |   6 ++-
>>>    block/mirror.c       | 118 +++++++++++++++++++++++++++++++++----------
>>>    blockdev.c           |  36 +++++++++----
>>>    3 files changed, 121 insertions(+), 39 deletions(-)
>>>
>> ...
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 469acf4600..770de3b34e 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -42,6 +42,7 @@ typedef struct MirrorBlockJob {
>>>        BlockBackend *target;
>>>        BlockDriverState *mirror_top_bs;
>>>        BlockDriverState *base;
>>> +    BlockDriverState *base_overlay;
>>>          /* The name of the graph node to replace */
>>>        char *replaces;
>>> @@ -677,8 +678,10 @@ static int mirror_exit_common(Job *job)
>>>                                 &error_abort);
>>>        if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>>>            BlockDriverState *backing = s->is_none_mode ? src : s->base;
>>> -        if (backing_bs(target_bs) != backing) {
>>> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
>>> +        BlockDriverState *unfiltered_target =
>>> bdrv_skip_filters(target_bs);
>>> +
>>> +        if (bdrv_cow_bs(unfiltered_target) != backing) {
>>
>> I just worry about a filter node of the concurrent job right below the
>> unfiltered_target.
> Having a concurrent job on the target sounds extremely problematic in
> itself (because at least for most of the mirror job, the target isn’t in
> a consistent state).  Is that a real use case?


It might be at the TestParallelOps of iotests #30 but I am not sure now. 
I am going to apply my series with copy-on-read filter for the stream 
job above this one and will see then.

Andrey


>
>> The filter has unfiltered_target in its parent list.
>> Will that filter node be replaced correctly then?
> I’m also not quite sure what you mean.  We need to attach the source’s
> backing chain to the target here, so we go down to the first node that
> might accept COW backing files (by invoking bdrv_skip_filters()).  That
> should be correct no matter what kind of filters are on it.


I ment when a filter is removed with the bdrv_replace_node() afterwards. 
As I mentioned above, I am going to test the case later.

Andrey


>>> +        /*
>>> +         * The topmost node with
>>> +         * bdrv_skip_filters(filtered_target) ==
>>> bdrv_skip_filters(target)
>>> +         */
>>> +        filtered_target = bdrv_cow_bs(bdrv_find_overlay(bs, target));
>>> +
>>> +        assert(bdrv_skip_filters(filtered_target) ==
>>> +               bdrv_skip_filters(target));
>>> +
>>> +        /*
>>> +         * XXX BLK_PERM_WRITE needs to be allowed so we don't block
>>> +         * ourselves at s->base (if writes are blocked for a node,
>>> they are
>>> +         * also blocked for its backing file). The other options
>>> would be a
>>> +         * second filter driver above s->base (== target).
>>> +         */
>>> +        iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
>>> +
>>> +        for (iter = bdrv_filter_or_cow_bs(bs); iter != target;
>>> +             iter = bdrv_filter_or_cow_bs(iter))
>>> +        {
>>> +            if (iter == filtered_target) {
>>
>> For one filter node only?
> No, iter_shared_perms is never reset, so it retains the
> BLK_PERM_CONSISTENT_READ flag until the end of the loop.


Yes, that's right. Clear.

Andrey


>
>>> +                /*
>>> +                 * From here on, all nodes are filters on the base.
>>> +                 * This allows us to share BLK_PERM_CONSISTENT_READ.
>>> +                 */
>>> +                iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
>>> +            }
>>> +
>>>                ret = block_job_add_bdrv(&s->common, "intermediate
>>> node", iter, 0,
>>> -                                     BLK_PERM_WRITE_UNCHANGED |
>>> BLK_PERM_WRITE,
>>> -                                     errp);
>>> +                                     iter_shared_perms, errp);
>>>                if (ret < 0) {
>>>                    goto fail;
>>>                }
>> ...
>>> @@ -3042,6 +3053,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error
>>> **errp)
>>>                                 " named node of the graph");
>>>                goto out;
>>>            }
>>> +        replaces_node_name = arg->replaces;
>>
>> What is the idea behind the variables substitution?
> Looks like a remnant from v6, where there was an
>
> if (arg->has_replaces) {
>      ...
>      replaces_node_name = arg->replaces;
> } else if (unfiltered_bs != bs) {
>      replaces_node_name = unfiltered_bs->node_name;
> }
>
> But I moved that logic to blockdev_mirror_common() in this version.
>
> So it’s just useless now and replaces_node_name shouldn’t exist.
>
> Max
>

