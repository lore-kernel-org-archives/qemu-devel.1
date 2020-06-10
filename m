Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97321C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424EB20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rBj+xbGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424EB20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitBs-0000lC-Hp
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jitBE-0000Jz-6M; Wed, 10 Jun 2020 01:21:40 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:57218 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jitBB-0001qn-Dr; Wed, 10 Jun 2020 01:21:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdBD3MSK91jRyX/XxBx8eU0DAtg4BQ85i30CHlU1Z79mGjQAN/ojIL9Saxhq6A0qUv5d1GTeNlcCfICoE9+4ndoXnq8N7k45pvwj17iUsFJeRTxJGXU7LETWsNVEAxykfK6F1eJ6kOcDfSEwfxPO4YzXErEkAFTvyOF5KmdIbu7ntpBdh8Tqj2ILkkLC97igqdFyMlOLU7XkABTBe3Ok/s1Cp9culO8mzHGLE+IT426TjRUVBmCIIpdxPIqzgQd4bGuN85egSK9VmyL26ctCaSeKcBrLffOpyIZcz96AyfGNUv+nZXa9Ep2e6H4J77mtNoKkicnI5fEe4YsmkbFcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49gQ3lcwFw8iBfib6BDkvdfcOJyRV1P55w8hrUMBDvM=;
 b=JPavAVbccDD/VFuc1VcxGnaX7MJ8Z1AEzIKWwgMFhOozDLUsD7WOF+RWV2Ofh8r7+dKC7PCNugj25pYCYanlraLFkn0OSvxq5aEVfr1H5Fvq0P15j0DQ6Jn0DU1wNMf3XgZUOv+2clBCnKkeThwNL7EFx/QP4qlDg7Vl4oImh5egmC9ST/T22FWrWt5M3v7OrdgASir7JbyALqFQsfCntDGVuHqCV2PrPDP4PGUqg0QsUpVPz4AqGZe+4BEWIAN9B/WX/abew4DAsAehk1vGR+QoE/bv+jISzh+LiRXCdwPN7S+NkQvbmcnIifFjuUjLyWr8PAAp5k3mfyFwTlCeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49gQ3lcwFw8iBfib6BDkvdfcOJyRV1P55w8hrUMBDvM=;
 b=rBj+xbGQvgCN0AwDmS1bZZEg7fhkT0mVRDIONBY54LWnw9unKzQoZVyPctL4a9nRwq6ZjW27xuYhK3KdLGsZmcmZH47GIAe3KH7pyIq8r3HfLDLhKy0rmqnUs/opIgwUZ1fNQPOEPm4wTap/k6DKDiyCaqbovGOUAXLjEaZkzB0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Wed, 10 Jun
 2020 05:21:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 05:21:32 +0000
Subject: Re: [PATCH v6 4/7] scripts: add coroutine-wrapper.py
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200609141329.3945-1-vsementsov@virtuozzo.com>
 <20200609141329.3945-5-vsementsov@virtuozzo.com>
 <73e06745-24c7-f7b8-9494-20f710b77e9f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4a09a07b-0e47-dec2-5d7c-378c165aa454@virtuozzo.com>
Date: Wed, 10 Jun 2020 08:21:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <73e06745-24c7-f7b8-9494-20f710b77e9f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR01CA0127.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Wed, 10 Jun 2020 05:21:31 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ed7768-e2ec-4452-60f0-08d80cfe22eb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5333DD7AD46DE63706674C9FC1830@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKhZjYrgixh7RjjpEnYEhWuyVJkgmrU527OU8zwmY2S1cxd6zG5HrQd94BKdRjrk20ptXBzg1smbN6cz6hcTDDLmhVtDgnJsxSn5Y9a++nbg2cgaEiZNq4sieN+Iq7vzJTUgjTVOgdg5cn9VJvrLsCdtoc3IbtDMQRkGzM8TrLdXgCzJKcOUSXMynlxQcPK92YJ1troedgA0nI5Hb6rk3jBPKNQZNxt5yjxRxlE2YGH77ykXqUvNhLtTuEZBh8tpRJLJ6vNZGCSwbrZa14uE9Yx6ecUYof2vpXOZxb0NpzPjFMoNvikyfrmvoJDKuzZDg9FJEXt7Pgg0E+YKsSXR4nKLkOU8xTJgovUI4mUcWTf6EUjA90L4P/NoOf0uHkdk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39830400003)(376002)(366004)(107886003)(956004)(83380400001)(2616005)(66556008)(26005)(16576012)(53546011)(5660300002)(52116002)(478600001)(86362001)(31696002)(8676002)(4326008)(66476007)(8936002)(30864003)(16526019)(36756003)(2906002)(31686004)(66946007)(186003)(316002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rMgkcQQrUQoFOAsl2/12aevoUgAMR/Q5yJkau6B6kYhxPwINKcSSYkzQCZYBQFECBB5a0P11y/z2v5LPWiRdPHGaBGTirZJpNFwa1pMjelocYkPfZ0Lkj/N0SiYZ468X2unBbTWw4OC/nU849exfAdFYzhQW8Zzn8+6JXeyhfK+pUdDMpLCybdzus/U+3CYIwWsfoMg4pElcG7LGzxkLLP2Qb/Vvd7jCg0n3w55JJuZI4xSZhxhZoofEMaNQG21mAj+/AhsStyj+zuGzFlWWxwy4M6gGjkWqwH3grZTvD6txoghGDjwWRwL3bFi/tVmcLQCqagBnqVAmPco7holgYeo38iaKm7cO0N4jn4yp69VYip9Xa3+CyEAEiErTELxail+50szHQ7yTG5x8iNXJtGvqKOIYxkgWXAMicQcfN6FF4TJUhBHYcwp/qCxeQkS4ZAVn0EKcGKImvAXGOU6ngVtbkllDz19uQkJvF625G09rvu8KphRCMpChHQPybJY7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ed7768-e2ec-4452-60f0-08d80cfe22eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 05:21:32.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTdHNd7kClHPuCsJ4Nm0TspaOaCqczg0OFv2LmUtQqP7DVuY/F4Phz2iab4t4glrd00jf6j0Ov/9Q4+SmBFeEhVERESWpO6ekslONaR+3M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 01:21:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 00:21, Eric Blake wrote:
> On 6/9/20 9:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We have a very frequent pattern of creating coroutine from function
>> with several arguments:
>>
>>    - create structure to pack parameters
>>    - create _entry function to call original function taking parameters
>>      from struct
>>    - do different magic to handle completion: set ret to NOT_DONE or
>>      EINPROGRESS, use separate bool for void functions
> 
> Stale comment, now that you got rid of void functions earlier in the series.
> 
>>    - fill the struct and create coroutine from _entry function and this
>>      struct as a parameter
>>    - do coroutine enter and BDRV_POLL_WHILE loop
>>
>> Let's reduce code duplication by generating coroutine wrappers.
>>
>> This patch adds scripts/coroutine-wrapper.py together with some
>> friends, which will generate functions with declared prototypes marked
>> by 'generated_co_wrapper' specifier.
>>
>> The usage of new code generation is as follows:
>>
>>      1. define somewhere
>>
>>          int coroutine_fn bdrv_co_NAME(...) {...}
>>
>>         function
>>
>>      2. declare in some header file
>>
>>          int generated_co_wrapper bdrv_NAME(...);
>>
>>         function with same list of parameters. (you'll need to include
>>         "block/generated-co-wrapper.h" to get the specifier)
>>
>>      3. both declarations should be available through block/coroutines.h
>>         header.
>>
>>      4. add header with generated_co_wrapper declaration into
>>         COROUTINE_HEADERS list in Makefile
>>
>> Still, no function is now marked, this work is for the following
>> commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   Makefile                             |   8 ++
>>   block/block-gen.h                    |  55 +++++++++
>>   include/block/generated-co-wrapper.h |  35 ++++++
>>   block/Makefile.objs                  |   1 +
>>   scripts/coroutine-wrapper.py         | 174 +++++++++++++++++++++++++++
>>   5 files changed, 273 insertions(+)
>>   create mode 100644 block/block-gen.h
>>   create mode 100644 include/block/generated-co-wrapper.h
>>   create mode 100755 scripts/coroutine-wrapper.py
> 
> My python review is weak, but here goes.
> 
>> +++ b/block/block-gen.h
> 
>> +
>> +#include "block/block_int.h"
>> +
>> +/* This function is called at the end of generated coroutine entries. */
>> +static inline void bdrv_poll_co__on_exit(void)
>> +{
>> +    aio_wait_kick();
>> +}
> 
> I still think it's worth inlining aio_wait_kick() into the generated code, instead of this one-line wrapper function.  Patch below.
> 
>> +
>> +/* Base structure for argument packing structures */
>> +typedef struct BdrvPollCo {
>> +    BlockDriverState *bs;
>> +    bool in_progress;
>> +    int ret;
>> +    Coroutine *co; /* Keep pointer here for debugging */
>> +} BdrvPollCo;
>> +
>> +static inline int bdrv_poll_co(BdrvPollCo *s)
>> +{
>> +    assert(!qemu_in_coroutine());
>> +
>> +    bdrv_coroutine_enter(s->bs, s->co);
>> +    BDRV_POLL_WHILE(s->bs, s->in_progress);
>> +
>> +    return s->ret;
>> +}
>> +
>> +#endif /* BLOCK_BLOCK_GEN_H */
>> diff --git a/include/block/generated-co-wrapper.h b/include/block/generated-co-wrapper.h
>> new file mode 100644
>> index 0000000000..62c6e053ba
>> --- /dev/null
>> +++ b/include/block/generated-co-wrapper.h
> 
>> +#ifndef BLOCK_GENERATED_CO_WRAPPER_H
>> +#define BLOCK_GENERATED_CO_WRAPPER_H
>> +
>> +/*
>> + * generated_co_wrapper
>> + * Function specifier, which does nothing but marking functions to be
>> + * generated by scripts/coroutine-wrapper.py
>> + */
>> +#define generated_co_wrapper
> 
> Do we need a standalone header just for this definition, or could we stick it in include/block/block.h?  Also in my patch below.
> 
>> diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
>> new file mode 100755
>> index 0000000000..dbe6fb97d9
>> --- /dev/null
>> +++ b/scripts/coroutine-wrapper.py
>> @@ -0,0 +1,174 @@
>> +#!/usr/bin/env python3
> 
>> +"""Generate coroutine wrappers for block subsystem.
>> +def prettify(code: str) -> str:
>> +    """Prettify code using clang-format if available"""
>> +
>> +    try:
>> +        style = '{IndentWidth: 4, BraceWrapping: {AfterFunction: true}, ' \
>> +            'BreakBeforeBraces: Custom, SortIncludes: false, ' \
>> +            'MaxEmptyLinesToKeep: 2}'
> 
> It looks odd to pass in style as a string (requiring \-newline) rather than a dict (which would not), but I guess that's because...
> 
>> +        p = subprocess.run(['clang-format', f'-style={style}'], check=True,
> 
> ...you have to stringify it anyway for the subprocess command line.
> 
>> +class ParamDecl:
>> +    param_re = re.compile(r'(?P<decl>'
>> +                          r'(?P<type>.*[ *])'
>> +                          r'(?P<name>[a-z][a-z0-9_]*)'
> 
> I guess you're safe not including A-Z based on our coding style.
> 
>> +                          r')')
>> +
>> +    def __init__(self, param_decl: str) -> None:
>> +        m = self.param_re.match(param_decl.strip())
>> +        if m is None:
>> +            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
>> +        self.decl = m.group('decl')
>> +        self.type = m.group('type')
>> +        self.name = m.group('name')
>> +
>> +
>> +class FuncDecl:
>> +    def __init__(self, return_type: str, name: str, args: str) -> None:
>> +        self.return_type = return_type.strip()
>> +        self.name = name.strip()
>> +        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
>> +
>> +    def gen_list(self, format: str) -> str:
>> +        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
>> +
>> +    def gen_block(self, format: str) -> str:
>> +        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
>> +
>> +
>> +# Match wrappers declared with a generated_co_wrapper mark
>> +func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
>> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
>> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
>> +
> 
> Makes sense (requires coroutines to return int, but you fixed that earlier in the series).
> 
>> +
>> +def func_decl_iter(text: str) -> Iterator:
>> +    for m in func_decl_re.finditer(text):
>> +        yield FuncDecl(return_type='int',
>> +                       name=m.group('wrapper_name'),
>> +                       args=m.group('args'))
>> +
>> +
>> +def snake_to_camel(func_name: str) -> str:
> ...
> 
> Nothing else jumped out at me, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Still, here's the promised diffs I'm thinking of:
> 
> for 4/7
> 
>  From 8c089d488ed8d9778fd5ee1f18dbc3845e4349f2 Mon Sep 17 00:00:00 2001
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date: Tue, 9 Jun 2020 17:13:26 +0300
> Subject: [PATCH] fixup? scripts: add coroutine-wrapper.py
> 
> Worth squashing in to the coroutine generator?
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   scripts/coroutine-wrapper.py         |  5 ++--
>   block/block-gen.h                    |  6 -----
>   include/block/block.h                |  7 ++++++
>   include/block/generated-co-wrapper.h | 35 ----------------------------
>   4 files changed, 10 insertions(+), 43 deletions(-)
>   delete mode 100644 include/block/generated-co-wrapper.h
> 
> diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
> index dbe6fb97d9bd..0c2cf13401ce 100755
> --- a/scripts/coroutine-wrapper.py
> +++ b/scripts/coroutine-wrapper.py
> @@ -57,7 +57,8 @@ def gen_header():
> 
>   #include "qemu/osdep.h"
>   #include "block/coroutines.h"
> -#include "block/block-gen.h"\
> +#include "block/block-gen.h"
> +#include "block/block_int.h"\
>   """
> 
> 
> @@ -139,7 +140,7 @@ static void coroutine_fn {name}_entry(void *opaque)
>       s->poll_state.ret = {name}({ func.gen_list('s->{name}') });
>       s->poll_state.in_progress = false;
> 
> -    bdrv_poll_co__on_exit();
> +    aio_wait_kick();
>   }}
> 
>   int {func.name}({ func.gen_list('{decl}') })
> diff --git a/block/block-gen.h b/block/block-gen.h
> index 482d06737d10..f80cf4897d11 100644
> --- a/block/block-gen.h
> +++ b/block/block-gen.h
> @@ -28,12 +28,6 @@
> 
>   #include "block/block_int.h"
> 
> -/* This function is called at the end of generated coroutine entries. */
> -static inline void bdrv_poll_co__on_exit(void)
> -{
> -    aio_wait_kick();
> -}
> -
>   /* Base structure for argument packing structures */
>   typedef struct BdrvPollCo {
>       BlockDriverState *bs;
> diff --git a/include/block/block.h b/include/block/block.h
> index 46965a77801c..59a002e06f23 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -10,6 +10,13 @@
>   #include "block/blockjob.h"
>   #include "qemu/hbitmap.h"
> 
> +/*
> + * generated_co_wrapper
> + * Function specifier, which does nothing but marking functions to be
> + * generated by scripts/coroutine-wrapper.py
> + */
> +#define generated_co_wrapper
> +
>   /* block.c */
>   typedef struct BlockDriver BlockDriver;
>   typedef struct BdrvChild BdrvChild;
> diff --git a/include/block/generated-co-wrapper.h b/include/block/generated-co-wrapper.h
> deleted file mode 100644
> index 62c6e053ba12..000000000000
> --- a/include/block/generated-co-wrapper.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - * Block layer I/O functions
> - *
> - * Copyright (c) 2020 Virtuozzo International GmbH
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#ifndef BLOCK_GENERATED_CO_WRAPPER_H
> -#define BLOCK_GENERATED_CO_WRAPPER_H
> -
> -/*
> - * generated_co_wrapper
> - * Function specifier, which does nothing but marking functions to be
> - * generated by scripts/coroutine-wrapper.py
> - */
> -#define generated_co_wrapper
> -
> -#endif /* BLOCK_GENERATED_CO_WRAPPER_H */
> -- 

Note, that because of this line, thunderbird assumes that the following is the signature, and doesn't include into citation when click "reply" (so, I've selected the whole thing, before clicking, to put the following into citation too). Not a big deal of course.

> 2.27.0
> 
> 
> 
> for 5/7
> 
> diff --git i/block/coroutines.h w/block/coroutines.h
> index 145a2d264524..c62b3a2697ca 100644
> --- i/block/coroutines.h
> +++ w/block/coroutines.h
> @@ -26,7 +26,6 @@
>   #define BLOCK_COROUTINES_INT_H
> 
>   #include "block/block_int.h"
> -#include "block/generated-co-wrapper.h"
> 
>   int coroutine_fn bdrv_co_check(BlockDriverState *bs,
>                                  BdrvCheckResult *res, BdrvCheckMode fix);
> diff --git i/include/block/block.h w/include/block/block.h
> index 321d75675768..9f94c5905788 100644
> --- i/include/block/block.h
> +++ w/include/block/block.h
> @@ -9,7 +9,6 @@
>   #include "block/dirty-bitmap.h"
>   #include "block/blockjob.h"
>   #include "qemu/hbitmap.h"
> -#include "block/generated-co-wrapper.h"
> 
>   /*
>    * generated_co_wrapper
> 


Thank! OK, I'll try it and resend.

-- 
Best regards,
Vladimir

