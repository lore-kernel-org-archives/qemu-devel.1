Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66292C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB5020716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BxrRDZgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bhv-0007vI-Du
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k6bTg-00017W-IX; Fri, 14 Aug 2020 11:18:44 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:32903 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k6bTb-0000j4-UZ; Fri, 14 Aug 2020 11:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt9Nh29bPv4C5dQSWgjez6WddI2ur5yriXWkd3e3zBUxpvWkn403fFP/YXLw4+j8kI+0YH6dCqEkwKa8yN/em8Q9Iecs1wqd+Xk4WUFWa+uoWI2t0/0LCGuN1JMIVsUf/UKTDPylWstqkH7WK4gOVxna7QRZeB1aECVdAIfmOQ5iOqdm7n6bkEPaoDxhlL5Bi6zM89pUxchmGDoQDlM9bsE8ndofAf0FlekwYApSh+6+T+F43g4FRBLozHDo2hbf8tBy6f2F/zj6W3HLlkF11NjIbVURvu1wWQ1XieH+frL0UdcD65STXtETlek5B1iSWSSsoh/BVI71RXd0wvRoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNTfhguJa0A9BKzHw/PXVdhTgI40TFLzv1H78e0bVIE=;
 b=biQpMAqtil40d+iUKTSZsYh3M0Q2+aTwH8rKqYAhHyqy4j+8bhM2Dgn9TP5TBaOgpMyNqfLYSKyA31nHd8WQM82n8Lj7CM800+2vwEB2aPQev85RVrJ2U014UDyuGHC42VPeCcoaAY/24cNXbjOofoguvQElA6Gc0i7IQl/scWZ91RbqpIvmDYnWBvFI1YafSQoKfPNHA5x4CEHlaNswcSyLEpVfsjpSUOBIjTE1zxS5OvPebF5zxBAY3GWdr7ZWJGooAYmtoO2YQ8IIogcrXPWcDJVTkIO1RRhtp4azYrXgiP0DnNy9Ese2G7LeoVSFYUUtZyJGDskxdDI2Sgqklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNTfhguJa0A9BKzHw/PXVdhTgI40TFLzv1H78e0bVIE=;
 b=BxrRDZgFGU6NLYaFXSFvFD05eVNfkCJR3q4e/VaNn8DGs1hP4YRSMQ3o9RLsLt7Q3zlga53JjG3AusEWC/vx1Nl2mR/Ug8noC6GGDt1DXq+CFJYDemWShRk0eWbTGPsrMEdBuLEi4FhIzhtfLZFBCDejO+Sj2yXmu31SDGbPATA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2780.eurprd08.prod.outlook.com (2603:10a6:7:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Fri, 14 Aug
 2020 15:18:34 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 15:18:34 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
 <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
 <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
 <f61033e0-92be-0b9a-7a14-e1c56372b671@virtuozzo.com>
 <9f8b1eb5-2039-b2c5-6330-7f39f2c21464@redhat.com>
 <0d9ded79-69f3-4875-a19f-b97893268cfb@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <0dd934f6-d8d4-4fe1-38d9-9d1c25d44780@virtuozzo.com>
Date: Fri, 14 Aug 2020 18:18:31 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <0d9ded79-69f3-4875-a19f-b97893268cfb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0099.eurprd05.prod.outlook.com
 (2603:10a6:207:1::25) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR05CA0099.eurprd05.prod.outlook.com (2603:10a6:207:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 15:18:33 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 545dab25-e23a-48e0-fc9d-08d840654f97
X-MS-TrafficTypeDiagnostic: HE1PR08MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB27809AFC3814174BAF43CC16F4400@HE1PR08MB2780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8D/bdZEtRGyA5rWWjHcGERIBAl+sfblL7as2O28nuEY1WtPJfDGgMp0lYiMUyXjHqjBjGrRrwHyAUUNy6NddKcdqG59SNMXV2LjxCo3otc3GH4XHdDKZcYLZVE7Fr6EKBp/Ay3SFUXO5gUKQ7vSb94rN8nzBGf/kvGbdOGzMaxemdAissjNXDckoFOOm5DrAKw5+J7jNRZYzX1QdiCKQVLaHcnmm4gFk04A2BzhNY/h3qV866BRfxs0eycMsRv0xVmfO6FnvXqbpmO2TTaj6unX1aHq7FH+I8mHyZV3s6hSduf6uDyDV9W07GxUsXyz88Epeweqa+GptTwT4lnWgxJdYUKiu6KHbRF+mxGtZTUoW5eMRP+MREyonHoirlfr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(6506007)(31696002)(53546011)(4326008)(26005)(186003)(8676002)(5660300002)(86362001)(52116002)(478600001)(31686004)(16526019)(107886003)(30864003)(8936002)(6512007)(956004)(6486002)(36756003)(2906002)(316002)(66556008)(66476007)(66946007)(83380400001)(44832011)(110136005)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IRDtQicNtltBHPdVEqPkXGvPFnf/aTeU4l6MXgSGgqGIvTggVqyvlO0kBJmGzK2Ko6vsbmMmmYomWSNLMU6FwlP2ce+WnyRldgOYKwZ2AgbRXgh/10W2kY4JdzVm5CNTLvlOqhia1QVw5sVYNi/pKimXWU/tKm9Pr9OaCSJSoKqHojXDE09SaH8IHuhZooc+mMF0W6cwxaSsilty7uM+tvwqlaFwhrrLUDV3uCar8f51AMZ2h4PLhr6w5zCZeQ/Cirlazkqtql/XmMDAiWqyWasdOSWDqRK9AJgAsCXhT7Jc+btAQifQkLrOyWE8/JtwRH0+7aRK2k9TSjXSK20ESDTmt+DZ31MXWBvfd4b/zQGZ+mqyHppeE0UM5PPQZYhZKnZn9wdshFvBvGA21XAlnTkwfbJ5617nlNNdeBCVZDflJ4jB7+U/GrsPRzub9xGvIL7iXPHhom5LdNXTeDM/8OU55jqXpwGbzdmgjLCnAoPtp0WBClvaBdt6IJEoH+f9GJqGbLtUi7JJvFZFUOK6C+PNgWyOCMbSeCoH/kPvBpZmGfIYWQtdUW1aiIV29Vrhe0xNrJSaz1nqUMJ8z1brGfkeoIjMYTAGPI93yN+6JR24H0/9jrmoxWnZBXBRtl3N+Af3o+xQINAp04DltpP+aQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545dab25-e23a-48e0-fc9d-08d840654f97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:18:34.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPSO6w0lCx4cSiqrK2Rxao5dG5gCelYGkE4ioBuz84pZ9Arg0cvT80IXt9noJEEtuVQQA3RpEH3zN6nymDqXJv+8TcAioTAa+YCNNt66N0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2780
Received-SPF: pass client-ip=40.107.7.133;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:18:37
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
Cc: Kevin Wolf <kwolf@redhat.com>, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.08.2020 14:04, Vladimir Sementsov-Ogievskiy wrote:
> 10.08.2020 11:12, Max Reitz wrote:
>> On 07.08.20 12:29, Vladimir Sementsov-Ogievskiy wrote:
>>> 16.07.2020 17:59, Max Reitz wrote:
>>>> On 10.07.20 19:41, Andrey Shinkevich wrote:
>>>>> On 10.07.2020 18:24, Max Reitz wrote:
>>>>>> On 09.07.20 16:52, Andrey Shinkevich wrote:
>>>>>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>>>>>> Because of the (not so recent anymore) changes that make the
>>>>>>>> stream job
>>>>>>>> independent of the base node and instead track the node above 
>>>>>>>> it, we
>>>>>>>> have to split that "bottom" node into two cases: The bottom COW 
>>>>>>>> node,
>>>>>>>> and the node directly above the base node (which may be an R/W 
>>>>>>>> filter
>>>>>>>> or the bottom COW node).
>>>>>>>>
>>>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>>>> ---
>>>>>>>>      qapi/block-core.json |  4 +++
>>>>>>>>      block/stream.c       | 63
>>>>>>>> ++++++++++++++++++++++++++++++++------------
>>>>>>>>      blockdev.c           |  4 ++-
>>>>>>>>      3 files changed, 53 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>>>> index b20332e592..df87855429 100644
>>>>>>>> --- a/qapi/block-core.json
>>>>>>>> +++ b/qapi/block-core.json
>>>>>>>> @@ -2486,6 +2486,10 @@
>>>>>>>>      # On successful completion the image file is updated to 
>>>>>>>> drop the
>>>>>>>> backing file
>>>>>>>>      # and the BLOCK_JOB_COMPLETED event is emitted.
>>>>>>>>      #
>>>>>>>> +# In case @device is a filter node, block-stream modifies the 
>>>>>>>> first
>>>>>>>> non-filter
>>>>>>>> +# overlay node below it to point to base's backing node (or 
>>>>>>>> NULL if
>>>>>>>> @base was
>>>>>>>> +# not specified) instead of modifying @device itself.
>>>>>>>> +#
>>>>>>>>      # @job-id: identifier for the newly-created block job. If
>>>>>>>>      #          omitted, the device name will be used. (Since 2.7)
>>>>>>>>      #
>>>>>>>> diff --git a/block/stream.c b/block/stream.c
>>>>>>>> index aa2e7af98e..b9c1141656 100644
>>>>>>>> --- a/block/stream.c
>>>>>>>> +++ b/block/stream.c
>>>>>>>> @@ -31,7 +31,8 @@ enum {
>>>>>>>>        typedef struct StreamBlockJob {
>>>>>>>>          BlockJob common;
>>>>>>>> -    BlockDriverState *bottom;
>>>>>>>> +    BlockDriverState *base_overlay; /* COW overlay (stream from
>>>>>>>> this) */
>>>>>>>> +    BlockDriverState *above_base;   /* Node directly above the
>>>>>>>> base */
>>>>>>> Keeping the base_overlay is enough to complete the stream job.
>>>>>> Depends on the definition.  If we decide it isn’t enough, then it 
>>>>>> isn’t
>>>>>> enough.
>>>>>>
>>>>>>> The above_base may disappear during the job and we can't rely on 
>>>>>>> it.
>>>>>> In this version of this series, it may not, because the chain is
>>>>>> frozen.
>>>>>>     So the above_base cannot disappear.
>>>>>
>>>>> Once we insert a filter above the top bs of the stream job, the 
>>>>> parallel
>>>>> jobs in
>>>>>
>>>>> the iotests #030 will fail with 'frozen link error'. It is because of
>>>>> the
>>>>>
>>>>> independent parallel stream or commit jobs that insert/remove their
>>>>> filters
>>>>>
>>>>> asynchroniously.
>>>>
>>>> I’m not sure whether that’s a problem with this series specifically.
>>>>
>>>>>> We can discuss whether we should allow it to disappear, but I think
>>>>>> not.
>>>>>>
>>>>>> The problem is, we need something to set as the backing file after
>>>>>> streaming.  How do we figure out what that should be? My proposal
>>>>>> is we
>>>>>> keep above_base and use its immediate child.
>>>>>
>>>>> We can do the same with the base_overlay.
>>>>>
>>>>> If the backing node turns out to be a filter, the proper backing
>>>>> child will
>>>>>
>>>>> be set after the filter is removed. So, we shouldn't care.
>>>>
>>>> And what if the user manually added some filter above the base (i.e.
>>>> below base_overlay) that they want to keep after the job?
>>>
>>>
>>> It's automatically kept, if we use base_overlay->backing->bs as final
>>> backing node.
>>>
>>> You mean, that they want it to be dropped?
>>
>> Er, yes.  Point is, the graph structure below with @base at the root may
>> be different than the one right below @base_overlay.
>>
>>> so, assuming the following:
>>>
>>> top -(backing)-> manually-inserted-filter -(file)-> base
>>>
>>> and user do stream with base=base, and expects filter to be removed by
>>> stream job?
>>>
>>> Hmm, yes, such use-case is broken with our proposed way...
>>>
>>> ====
>>>
>>> Let me now clarify the problem we'll have with your way.
>>>
>>> When stream don't have any filter, we can easily imagine two parallel
>>> stream jobs:
>>>
>>> top -(backing)-> mid1 -(backing)-> mid2 -(backing)-> base
>>>
>>> stream1: top=top, base=mid2
>>> stream2: top=mid2, base=NULL
>>>
>>> final picture is obvious:
>>>
>>> top (merged with mid1) -(backing)-> mid2 (merged with base)
>>
>> Yes, and I don’t think this currently working case is broken by this 
>> series.
>>
>>> But we want stream job has own filter, like mirror.
>>
>> Which it does not have yet, right?  Which is why I was saying that I
>> don’t think this is a problem with this series.  We could try to address
>> it later.
>>
>> Or do you think we can’t address it later because right now all filter
>> cases are broken anyway so now would be the time to make a breaking
>> change (which the suggestion to not use @base as the final backing 
>> node is)?
>
> I think, we can address it later, but it would be good to fit into one 
> release cycle with these series, to not make incompatible behavior 
> changes later.
>
>>
>>> So the picture becomes more complex.
>>>
>>> Assume stream2 starts first.
>>>
>>> top -(backing)-> mid1 -(backing)-> stream2-filter -(backing)-> mid2
>>> -(backing)-> base
>>
>> stream2-filter would be on top of mid2, right?
>
> Right. In my picture, "-(backing)->" means backing link. Hmm, most 
> probably stream-filter is COR, which actually have file child. It 
> doesn't matter here.
>
>>
>>> Now, when we run stream1, with your solution, stream1 will freeze
>>> stream2-filter
>>> (wrong thing, stream2 will fail to remove it if it finished first), and
>>> stream1 will
>>> remove stream2-filter on finish (which is wrong as well, stream2 is not
>>> prepared to
>>> removing of its filter)..
>>
>> Note that the user first needs to pass “mid2” as the base to the stream
>> job stream1.  Why don’t they just pass “stream2-filter”?  In my model,
>> the user should specify exactly which node they want not to be touched
>> by this stream job, and so that would be stream2-filter, not mid1.
>
> Hmm. I'm sure we already tried/discussed this.. But I don't remember 
> the results. Seems, such logic should work as well. Andrey don't you 
> remember? I think, the only difficulty is to update iotests 30 (in our 
> stream-filter series) to use node-names, not filename.. Can we go this 
> way?
>
>>
>> I feel like the answer to this question has to do with implicit nodes.
>> AFAIU you wanted to remove them, so I don’t think we’d want to
>> special-case them here.
>
> Agree. I think stream-filter should be explicit, like recently 
> introduced backup-top.
>
>>
>> If you think that we can’t expect users to pass “stream2-filter” because
>> currently it should work with “mid2”, then that’s a case of implicit
>> nodes and it means we should ascend from @base up to the first
>> non-implicit node to get the @above_base we want.
>>
>>> But, with our proposed way (freeze only chain up to base_overlay
>>> inclusively, and use backing(base_overlay) as final backing), all will
>>> work as expected, and two parallel jobs will work..
>>
>> I don’t think it will work as expected because users can no longer
>> specify which node should be the base node after streaming.  And the
>> QAPI schema says that base-node is to become the backing file of the top
>> node after streaming.
>
> But this will never work with either way: base node may disappear 
> during stream. Even with you way, they only stable thing is 
> "above-base", which backing child may be completely another node at 
> stream finish.
>
>>
>> I suppose you’re arguing that streaming through filters basically just
>> doesn’t work at all right now, so we’re free to do whatever?
>
> I don't, but I like the idea :)
>
>>
>> Well, that still leaves the problem that users should be able to specify
>> which node is to become the base after streaming, and that that node
>> maybe shouldn’t be restricted to immediate children of COW images.
>
> And again, this is impossible even with your way. I have an idea:
>
> What about making the whole thing explicit?
>
> We add an optional parameter to stream-job: bottom-node, which is 
> mutally exclusive with specifying base.
>
> Then, if user specified base node, we freeze base as well, so it can't 
> disappear. User will not be able to start parallel stream with this 
> base node as top (because new stream can not insert a filter into 
> frozen chain), but for sure it's rare case, used only in iotest 30 
> :)). Benefit: user have guarantee of what would be final backing node.
>
> Otherwise, if user specified bottom-node, we use the way of this 
> patch. So user can run parallel streams (iotest 30 will have to use 
> bottom-node argument). No guarantee of final base-node, it would be 
> backing of bottom-node at job finish.
>
> But, this is incompatible change, and we probably should wait for 3 
> releases for deprecation of old behavior..
>
> Anyway, I feel now, that you convinced me. I'm not sure that we will 
> not have to change it make filter work, but not reason to change 
> something now. Andrey, could you try to rebase your series on top of 
> this and fix iotest 30 by just specifying  exact node-names in it?..
>

That is what I am doing now but have not completed yet. Actually, when 
we insert the COR-filter for a stream job, the cases with concurrent 
jobs fail in the iotests:030. I am trying to cope with the issues and 
still in progress. The problem I am forseeing is that if a user 
specifies the filter node as a base for a job, the name of the filter 
will be written down to the QCOW2 header on the disk. It can happen if 
bdrv_refresh_filename() returns the json-name of the filter. Max 
separated the backing file of QCOW2 header from the one, let's say, in 
the running program with this series. Imagine, If the user doesn't 
specify the backing file in a QAPI command, the program will use the 
name of the filter read from the QCOW2 header. Let me please finish the 
experiment and I will back to you with results or issues...

Andrey


>
> Hmmm. My thought goes further. Seems, that in this way, introducing 
> explicit filter would be incompatible change anyway: it will break 
> scenario with parallel stream jobs, when user specifies filenames, not 
> node names (user will have to specify filter-node name as base for 
> another stream job, as you said). So, it's incompatible anyway.
>
> What do you think of it? Could we break this scenario in one release 
> without deprecation and don't care? Than I think my idea about base vs 
> bottom-node arguments for stream job may be applied. Or what to do?
>
> If we can't break this scenario without a deprecation, we'll have to 
> implement "implicit" filter, like for mirror, when filter-node-name is 
> not specified. And for this implicit filter we'll need additional 
> logic (closer to what I've proposed in a previous mail). Or, try to 
> keep stream without a filter (not insert it at all and behave the old 
> way), when filter-node-name is not specified. Than new features based 
> on filter will be available only when filter-node-name is specified, 
> but this is OK. The latter seems better for me.
>
>>
>>> ====
>>>
>>> So, these are two mutually exclusive cases.. I vote for freezing up to
>>> base_overlay, and use backing(base_overlay) as final backing, because:
>>>
>>> 1. I can't imaging other way to fix the case with parallel streams with
>>> filters (it's not a problem of current master, but we have pending
>>> series which will introduce stream job filter, and the problem will
>>> appear and even break iotest 30)
>>
>> Besides the question of whether the top job could just use the bottom
>> job’s filter node as the base, there’s also the alternative of admitting
>> defeat and declaring that you just cannot use a single node in two
>> streams, because we didn’t find a way to make it work after all.
>>
>> You could still create a temporary overlay in between that’s never used
>> and then drop it with a trivial stream afterwards.
>>
>> (But that just in case specifying the bottom job’s stream node somehow
>> wouldn’t work.)
>
> We can break existing user scenarios.. Seems unlikely. I don't know.
>
>>
>>> 2. I don't think that removing filters above base node by stream job is
>>> so important case to break parallel stream jobs in future:
>>>
>>>   - Stream job is not intended to remove filters, but to stream data.
>>> Filters between base_overlay and base don't contain any data and
>>> unrelated to stream process
>>
>> Well, it is intended to remove nodes.  You can only remove data-bearing
>> nodes by moving data around.  I suspect if there was a way to get the
>> to-be-removed nodes removed without having to move their data around,
>> that would be popular.
>>
>>>   - I think, that filters are "more related" to their children than to
>>> their parents. So, removing filters related to base node, when we just
>>> remove all data-containing nodes between top and base (and are not 
>>> going
>>> to remove base node) is at least questionable.
>>
>> Yes.
>>
>> Although it could be argued that it is a handy way to remove filters, in
>> a backing chain at least.  (Thanks to bdrv_find_overlay(), @base and
>> @top still need to refer to different levels of the backing chain, but
>> if we lifted that restriction, I suppose it could work for any filter
>> chain.)
>>
>> *shrug*
>>
>>> On the contrary, removing
>>> all intermediate data containing nodes _together_ with their filters is
>>> absolutely correct thing to do.
>>
>> I don’t think so, actually.  Like, you have a throttle node somewhere in
>> the chain, shouldn’t you maybe want to move it down below the chain?  Or
>> a COR node, shouldn’t that go above the chain after streaming?
>>
>> I’m not making an argument here, I just don’t quite understand why you’d
>> bring up what happens with intermediate filters here.  The only reason
>> to drop them is because that’s what I expect users to expect of the
>> stream job.
>>
>>> Next, with your way, what about filters, inserted above base during
>>> stream job? They will be between above_base and base, and will not be
>>> removed. So with your way, filters above base, existing before job 
>>> start
>>> will be frozen during the job and removed after it, but filters 
>>> appended
>>> above base during the job will be untouched. With our way, just all 
>>> base
>>> node related filters are untouched by the job. It seems simpler
>>> definition for me and simpler to document.
>>
>> Hm.  The documentation seems the same to me.  Either it’s “The backing
>> node (at the end of the job) of @base’s parent node (when starting the
>> job)” or “The backing node (at the end of the job) of the next
>> non-filter node above @base (when starting the job)”.
>>
>> The problem you describe (that @above_base at the end of the job isn’t
>> necessarily above @base anymore) also exists with your suggestion,
>> namely that you can add overlays above @base after the job has started,
>> so @base_overlay at the end of the job isn’t necessarily the first
>> non-filter node above @base anymore.
>>
>>
>> OK, so after all this text, maybe some more original problem searching.
>>   I think it the root of the problem is that the stream job takes a 
>> @base
>> parameter, but as of c624b015bf14fe01, it doesn’t really matter anymore.
>>   Maybe c624b015bf14fe01 should have introduced a new parameter for 
>> users
>> to specify the bottom node instead of @base.
>
> Yes, absolutely agree. If we do it now, would it be incompatible 
> change or not?
>
>>
>> Well, that would have made everything a parameter mess, but it would
>> have saved us the trouble now.
>>
>> In any case, the problem we have now is that we want a way to
>> automagically find out which node the bottom node should be, because the
>> user can’t specify it.  So the documentation is always going to be
>> written as “The backing node (at the end of the job) of $bottom”, where
>> “$bottom” is what we’re interested in figuring out.
>>
>> I thought it would be best if we stick as close as possible to the
>> spirit of the current documentation, which basically requires @base-node
>> to be the backing node of the top after streaming.  (If you do graph
>> modifications during the job, that’s on you, because since
>> c624b015bf14fe01 we can’t keep the base frozen.)
>>
>> Your suggestion to do basically what you consider to be right, which
>> comes at the caveat of being untruthful to the current documentation
>> even if there are no graph modifications during the job. Luckily, the
>> stream job right now doesn’t work in the cases we’re looking at, so it
>> wouldn’t be a breaking change.
>
> I also try to think about future introduction of stream filter. It 
> shouldn't be a breaking change as well. But now I think it can be done 
> the hard-way if needed: just work without a filter if filter-node-name 
> is not given. but probably I care to much. Finally we can just drop 
> the test-case from 030 or insert additional intermediate node into it..
>
>>  The problem I have with it is that
>> you’re assuming what is right and what isn’t (i.e. “Who would want to
>> remove filter nodes directly above @base”) without giving the user a
>> chance to specify.
>>
>>
>> I think it would be nice if we could have something that remains
>> truthful to the current documentation.
>
> Then, we should freeze base node again, so just revert c624b015bf14fe01
>
> I go and see it cover-letter of the series introduced c624b015bf14fe01:
>
>   This series introduces a bottom intermediate node that eliminates the
>   dependency on the base that may change while stream job is running.
>   It happens when stream/commit parallel jobs are running on the same
>   backing chain. The base node of the stream job may be a top node of
>   the parallel commit job and can change before the stream job is
>   completed. We avoid that dependency by introducing the bottom node.
>
> Hmm. Bad that we didn't add an iotest, but the series solved existing 
> problem:
> parallel stream and commit, as commit already has filter. Commit has 
> filter
> with "backing" child, so, I assume that the case worked prior to 
> introducing
> frozen chains, broken then by frozen chains and then fixed by 
> c624b015bf14fe01.
> Still I don't know are there some real users of such parallel jobs..
>
>>  If just ignoring implicit
>> filters above @base would work, then I’d find that nice.  If it doesn’t,
>> I suppose there’s indeed little we can do but to indeed forego
>> @above_base and just use @base_overlay for all cases.
>>
>
> OK, at this point, I think, I'm OK with your patch in context of these 
> series.
>
> But I fill that something more should be done. Could we just revert 
> c624b015bf14fe01 as "non corresponding to specification"?
>
>

