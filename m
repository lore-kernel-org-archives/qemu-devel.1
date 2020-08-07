Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED2FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BAB2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h+aWOTDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BAB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ze9-0003xz-AY
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3zcs-0002dX-4d; Fri, 07 Aug 2020 06:29:26 -0400
Received: from mail-eopbgr20114.outbound.protection.outlook.com
 ([40.107.2.114]:30945 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3zcn-0001Lx-MM; Fri, 07 Aug 2020 06:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV3eVcj10Z95CC3snHnBTrn40qjM/EG7PYnvgxo8OQo755MAJWKKRbET3KL6PN2ZmdbSrouMa/Gxd4emp6SPqKrAQJpyXJcz04rJp0iSsgoVP0bmMdi8M/c6UexBD0pcfLsJEsLpW5J3/SPNAx9yyFy55Dr6Sj22isg+U9TbKn5wWIUDnMZZQj5+q+07yBIDKEDyO20Q/SBwl82Lx+JNVlEMfkuWNK8r4Td5/SpQNvJZZMb9izY27Isp5TYnfPupTF4VPHrDLX7gKPxU0mB0KdLBqr5D8rqmP4cddTWUpokFmN2Y3jvj2wdBEsIgPE1nfczTQ4061Swme+fjmuBpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPXaZvPGiRZrUxKR3eTb7ezXdC0fWt+PlzrEGWpbLlE=;
 b=CdQD+qmaeTLChPT+Jy3pi15aFO/vdoUmU2oFpDp6MZx3bQWHL9kYHm22slOS+XspNZuXcl/RqqsKdROQW4zrRR0DZJ4ZpT3fAnj4IvW/4yQMKbGa5nxFYcG8LUbqD8PVikTPSEJVAJDqXygTJ5+joCEU3+qtEGNjpUaGwOMg7H2WWWIZX7QDQjKrFEtwYgZ/8Fk8MZwMupiU3+k8kjFhbVGs/giEaai0Wb27xXLOdH5N+YLRcfbFsK3Kb9QpesaRhHViOcZI0oje/+8pLAL/V6nWU3MTM0ZbReTuDZJYTIkU9fuBpEvyWcRLCam4lMfHRM/5SDzVEjPvSrvxHUsI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPXaZvPGiRZrUxKR3eTb7ezXdC0fWt+PlzrEGWpbLlE=;
 b=h+aWOTDsKWoOybjcFIDU/PjwwvaDzp7LCbuFqTVcNXQSzu2S9vNUhvFroA9+oFuteDUy/eh6yZzpKXCJC59H/tyggR6wJeeez0EGeib+vl/8PBfAqvLxkcIFHYN1GPru5TPbhp2VyxCJgFATBtDOErIk1sVmugx5NPn3nUbuGac=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4167.eurprd08.prod.outlook.com (2603:10a6:20b:ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 10:29:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 10:29:17 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
 <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
 <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f61033e0-92be-0b9a-7a14-e1c56372b671@virtuozzo.com>
Date: Fri, 7 Aug 2020 13:29:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM0PR07CA0033.eurprd07.prod.outlook.com (2603:10a6:208:ac::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.14 via Frontend Transport; Fri, 7 Aug 2020 10:29:17 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e6b08d-9964-4f45-a208-08d83abcbd57
X-MS-TrafficTypeDiagnostic: AM6PR08MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB41678756D13B489C8C6CD50AC1490@AM6PR08MB4167.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG27HaAPUCorOz0YMzwBdNQDKvxaqhP6ulIetNNZKbuCpeh77eh/oRdqQ989kHBHGXmzKuuJERbT79Ihni11R3k5IihJupJ7k8cKuhrjtD8W6OVzIWB7dNBBLdNq/sPMp+u0dte+0kzJCh+3AHUGB2Rc0KSAkxN2jq0d8tYE6NvIbohRSyc2yaJRDgMyqlB8gaa2kuGhGa0EzqTsCbBQtpiHuXcZRwTdlzPTlncSTCkN0OOeAlVspkJIqXKez/FqsHGF4E7TJpS8Gc2BTN/vR8qYGLhHVBqmbBzjBvA68VN6FfAZWg2UUYoN0f1Hu+4cokIJGfZs1XGOq/e0NrdLZR6c+mwYQQdMgksmCIYaDFI/Cq07987SSWkWOpb4ksPI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39850400004)(83380400001)(4326008)(8936002)(5660300002)(31686004)(110136005)(53546011)(956004)(2616005)(16576012)(8676002)(6486002)(31696002)(86362001)(26005)(36756003)(52116002)(16526019)(478600001)(66476007)(66556008)(186003)(66946007)(316002)(2906002)(30864003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oqOs2v5CfZpHnBz+ES8AFQ6QnM75X20+EtEsNubiadtSGQtlEJ9ZlY7bcsVPBaqYBCODYYj881OfjUZ5CphwYaIpZyW30xvBG1MSSReopPc9vmo78GRcW437/qvVi4MSUfUG7qWTYCzCCRKa1wTorLNe04mGQRT5ve1Q9xXR6OfLdbwwt2I3OgSsTBrGhkmEcF/t8EVtKlVuY7TP0v+ujmmX8A2wDjQieMVs/Z0rNQoKLMIkcGnQHH96Ob3sH3RP8FGTkCPbeG8QPFwXhd/cXiXAfxnzNeapqWvKimQ33WPISK77ggF1qzBJyAEO5OGoaIfQcOCrRmyX4/E3Oz8a9AyYa5w0MgE7W3/b5BE6yUL5O9h2MvamuXJY0G6kwTc6/f9NfSgoHNy+I9xIxQ/oNSn1sA9XzYcbn+GSw8dSFbb6sQBrKCCFCsAzcp6tRav1XPr7oL+8r+P/GChxMxl9MdNHCPyXTCb0X6eWC8LRyM+MyZoNzN7N60j9jVwVTJNYDGXti1QDBzg09EXxNfgUgNEv7Lq1jsQm6fI1hP/A21/kvpOFuguvcHez77VAiVa1h93eU0EQz3AN255fP8KLV41ZJf8QicW8ctAdeBTX68M9z8h3abURfRpXll9rIjTmyiN6CsEQguQePZpKL6Rlyg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e6b08d-9964-4f45-a208-08d83abcbd57
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:29:17.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKe92mdFRk3JIijWrMJW5HNAkMDBt6nu3RWkXCB14H5ptSGrGcYg1qVlcIo2nGAPDuJO0dC74fhGcJ27D2s4+n/wpi9xfkVLO5Hl4oweftU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4167
Received-SPF: pass client-ip=40.107.2.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 06:29:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 17:59, Max Reitz wrote:
> On 10.07.20 19:41, Andrey Shinkevich wrote:
>> On 10.07.2020 18:24, Max Reitz wrote:
>>> On 09.07.20 16:52, Andrey Shinkevich wrote:
>>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>>> Because of the (not so recent anymore) changes that make the stream job
>>>>> independent of the base node and instead track the node above it, we
>>>>> have to split that "bottom" node into two cases: The bottom COW node,
>>>>> and the node directly above the base node (which may be an R/W filter
>>>>> or the bottom COW node).
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>     qapi/block-core.json |  4 +++
>>>>>     block/stream.c       | 63
>>>>> ++++++++++++++++++++++++++++++++------------
>>>>>     blockdev.c           |  4 ++-
>>>>>     3 files changed, 53 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>> index b20332e592..df87855429 100644
>>>>> --- a/qapi/block-core.json
>>>>> +++ b/qapi/block-core.json
>>>>> @@ -2486,6 +2486,10 @@
>>>>>     # On successful completion the image file is updated to drop the
>>>>> backing file
>>>>>     # and the BLOCK_JOB_COMPLETED event is emitted.
>>>>>     #
>>>>> +# In case @device is a filter node, block-stream modifies the first
>>>>> non-filter
>>>>> +# overlay node below it to point to base's backing node (or NULL if
>>>>> @base was
>>>>> +# not specified) instead of modifying @device itself.
>>>>> +#
>>>>>     # @job-id: identifier for the newly-created block job. If
>>>>>     #          omitted, the device name will be used. (Since 2.7)
>>>>>     #
>>>>> diff --git a/block/stream.c b/block/stream.c
>>>>> index aa2e7af98e..b9c1141656 100644
>>>>> --- a/block/stream.c
>>>>> +++ b/block/stream.c
>>>>> @@ -31,7 +31,8 @@ enum {
>>>>>       typedef struct StreamBlockJob {
>>>>>         BlockJob common;
>>>>> -    BlockDriverState *bottom;
>>>>> +    BlockDriverState *base_overlay; /* COW overlay (stream from
>>>>> this) */
>>>>> +    BlockDriverState *above_base;   /* Node directly above the base */
>>>> Keeping the base_overlay is enough to complete the stream job.
>>> Depends on the definition.  If we decide it isn’t enough, then it isn’t
>>> enough.
>>>
>>>> The above_base may disappear during the job and we can't rely on it.
>>> In this version of this series, it may not, because the chain is frozen.
>>>    So the above_base cannot disappear.
>>
>> Once we insert a filter above the top bs of the stream job, the parallel
>> jobs in
>>
>> the iotests #030 will fail with 'frozen link error'. It is because of the
>>
>> independent parallel stream or commit jobs that insert/remove their filters
>>
>> asynchroniously.
> 
> I’m not sure whether that’s a problem with this series specifically.
> 
>>> We can discuss whether we should allow it to disappear, but I think not.
>>>
>>> The problem is, we need something to set as the backing file after
>>> streaming.  How do we figure out what that should be?  My proposal is we
>>> keep above_base and use its immediate child.
>>
>> We can do the same with the base_overlay.
>>
>> If the backing node turns out to be a filter, the proper backing child will
>>
>> be set after the filter is removed. So, we shouldn't care.
> 
> And what if the user manually added some filter above the base (i.e.
> below base_overlay) that they want to keep after the job?


It's automatically kept, if we use base_overlay->backing->bs as final backing node.

You mean, that they want it to be dropped?


so, assuming the following:

top -(backing)-> manually-inserted-filter -(file)-> base

and user do stream with base=base, and expects filter to be removed by stream job?

Hmm, yes, such use-case is broken with our proposed way...

====

Let me now clarify the problem we'll have with your way.

When stream don't have any filter, we can easily imagine two parallel stream jobs:

top -(backing)-> mid1 -(backing)-> mid2 -(backing)-> base

stream1: top=top, base=mid2
stream2: top=mid2, base=NULL

final picture is obvious:

top (merged with mid1) -(backing)-> mid2 (merged with base)

But we want stream job has own filter, like mirror. So the picture becomes more complex.

Assume stream2 starts first.

top -(backing)-> mid1 -(backing)-> stream2-filter -(backing)-> mid2 -(backing)-> base

Now, when we run stream1, with your solution, stream1 will freeze stream2-filter
(wrong thing, stream2 will fail to remove it if it finished first), and stream1 will
remove stream2-filter on finish (which is wrong as well, stream2 is not prepared to
removing of its filter)..

But, with our proposed way (freeze only chain up to base_overlay inclusively, and use backing(base_overlay) as final backing), all will work as expected, and two parallel jobs will work..

====

So, these are two mutually exclusive cases.. I vote for freezing up to base_overlay, and use backing(base_overlay) as final backing, because:

1. I can't imaging other way to fix the case with parallel streams with filters (it's not a problem of current master, but we have pending series which will introduce stream job filter, and the problem will appear and even break iotest 30)

2. I don't think that removing filters above base node by stream job is so important case to break parallel stream jobs in future:

  - Stream job is not intended to remove filters, but to stream data. Filters between base_overlay and base don't contain any data and unrelated to stream process
  - I think, that filters are "more related" to their children than to their parents. So, removing filters related to base node, when we just remove all data-containing nodes between top and base (and are not going to remove base node) is at least questionable. On the contrary, removing all intermediate data containing nodes _together_ with their filters is absolutely correct thing to do.

Next, with your way, what about filters, inserted above base during stream job? They will be between above_base and base, and will not be removed. So with your way, filters above base, existing before job start will be frozen during the job and removed after it, but filters appended above base during the job will be untouched. With our way, just all base node related filters are untouched by the job. It seems simpler definition for me and simpler to document.

> 
>>> If we don’t keep above_base, then we’re basically left guessing as to
>>> what should be the backing file after the stream job.
>>>
>>>>>         BlockdevOnError on_error;
>>>>>         char *backing_file_str;
>>>>>         bool bs_read_only;
>>>>> @@ -53,7 +54,7 @@ static void stream_abort(Job *job)
>>>>>           if (s->chain_frozen) {
>>>>>             BlockJob *bjob = &s->common;
>>>>> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
>>>>> +        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
>>>>>         }
>>>>>     }
>>>>>     @@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
>>>>>         StreamBlockJob *s = container_of(job, StreamBlockJob,
>>>>> common.job);
>>>>>         BlockJob *bjob = &s->common;
>>>>>         BlockDriverState *bs = blk_bs(bjob->blk);
>>>>> -    BlockDriverState *base = backing_bs(s->bottom);
>>>>> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>> +    BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>>> The initial base node may be a top node for a concurrent commit job and
>>>>
>>>> may disappear.
>>> Then it would just be replaced by another node, though, so above_base
>>> keeps a child.  The @base here is not necessarily the initial @base, and
>>> that’s intentional.
>>
>> Not really. In my example, above_base becomes a dangling
>>
>> pointer because after the commit job finishes, its filter that should
>> belong to the
>>
>> commit job frozen chain will be deleted. If we freeze the link to the
>> above_base
>>
>> for this job, the iotests #30 will not pass.
> 
> So it doesn’t become a dangling pointer, because it’s frozen.
> 
> 030 passes after this series, so I’m not sure whether I can consider
> that problem part of this series.
> 
> I think if adding a filter node becomes a problem, we have to consider
> relaxing the restrictions when we do that, not now.
> 
>>>> base = bdrv_filter_or_cow_bs(s->base_overlay) is more reliable.
>>> But also wrong.  The point of keeping above_base around is to get its
>>> child here to use that child as the new backing child of the top node.
>>>
>>>>>         Error *local_err = NULL;
>>>>>         int ret = 0;
>>>>>     -    bdrv_unfreeze_backing_chain(bs, s->bottom);
>>>>> +    bdrv_unfreeze_backing_chain(bs, s->above_base);
>>>>>         s->chain_frozen = false;
>>>>>     -    if (bs->backing) {
>>>>> +    if (bdrv_cow_child(unfiltered_bs)) {
>>>>>             const char *base_id = NULL, *base_fmt = NULL;
>>>>>             if (base) {
>>>>>                 base_id = s->backing_file_str;
>>>>> @@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
>>>>>                     base_fmt = base->drv->format_name;
>>>>>                 }
>>>>>             }
>>>>> -        bdrv_set_backing_hd(bs, base, &local_err);
>>>>> -        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
>>>>> +        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>>>> +        ret = bdrv_change_backing_file(unfiltered_bs, base_id,
>>>>> base_fmt);
>>>>>             if (local_err) {
>>>>>                 error_report_err(local_err);
>>>>>                 return -EPERM;
>>>>> @@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job,
>>>>> Error **errp)
>>>>>         StreamBlockJob *s = container_of(job, StreamBlockJob,
>>>>> common.job);
>>>>>         BlockBackend *blk = s->common.blk;
>>>>>         BlockDriverState *bs = blk_bs(blk);
>>>>> -    bool enable_cor = !backing_bs(s->bottom);
>>>>> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>> +    bool enable_cor = !bdrv_cow_child(s->base_overlay);
>>>>>         int64_t len;
>>>>>         int64_t offset = 0;
>>>>>         uint64_t delay_ns = 0;
>>>>>         int error = 0;
>>>>>         int64_t n = 0; /* bytes */
>>>>>     -    if (bs == s->bottom) {
>>>>> +    if (unfiltered_bs == s->base_overlay) {
>>>>>             /* Nothing to stream */
>>>>>             return 0;
>>>>>         }
>>>>> @@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job,
>>>>> Error **errp)
>>>>>               copy = false;
>>>>>     -        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
>>>>> +        ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK,
>>>>> &n);
>>>>>             if (ret == 1) {
>>>>>                 /* Allocated in the top, no need to copy.  */
>>>>>             } else if (ret >= 0) {
>>>>>                 /* Copy if allocated in the intermediate images.  Limit
>>>>> to the
>>>>>                  * known-unallocated area [offset,
>>>>> offset+n*BDRV_SECTOR_SIZE).  */
>>>>> -            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom,
>>>>> true,
>>>>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
>>>>> +                                          s->base_overlay, true,
>>>>>                                               offset, n, &n);
>>>>>                 /* Finish early if end of backing file has been
>>>>> reached */
>>>>>                 if (ret == 0 && n == 0) {
>>>>> @@ -223,9 +227,29 @@ void stream_start(const char *job_id,
>>>>> BlockDriverState *bs,
>>>>>         BlockDriverState *iter;
>>>>>         bool bs_read_only;
>>>>>         int basic_flags = BLK_PERM_CONSISTENT_READ |
>>>>> BLK_PERM_WRITE_UNCHANGED;
>>>>> -    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
>>>>> +    BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>>>>> +    BlockDriverState *above_base;
>>>>>     -    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
>>>>> +    if (!base_overlay) {
>>>>> +        error_setg(errp, "'%s' is not in the backing chain of '%s'",
>>>>> +                   base->node_name, bs->node_name);
>>>> Sorry, I am not clear with the error message.
>>>>
>>>> In this case, there is no an intermediate COW node but the base, if not
>>>> NULL, is
>>>>
>>>> in the backing chain of bs, isn't it?
>>>>
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Find the node directly above @base.  @base_overlay is a COW
>>>>> overlay, so
>>>>> +     * it must have a bdrv_cow_child(), but it is the immediate
>>>>> overlay of
>>>>> +     * @base, so between the two there can only be filters.
>>>>> +     */
>>>>> +    above_base = base_overlay;
>>>>> +    if (bdrv_cow_bs(above_base) != base) {
>>>>> +        above_base = bdrv_cow_bs(above_base);
>>>>> +        while (bdrv_filter_bs(above_base) != base) {
>>>>> +            above_base = bdrv_filter_bs(above_base);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
>>>> When a concurrent stream job tries to freeze or remove the above_base
>>>> node,
>>>>
>>>> we will encounter the frozen node error. The above_base node is a part
>>>> of the
>>>>
>>>> concurrent job frozen chain.
>>> Correct.
>>>
>>>>>             return;
>>>>>         }
>>>>>     @@ -255,14 +279,19 @@ void stream_start(const char *job_id,
>>>>> BlockDriverState *bs,
>>>>>          * and resizes. Reassign the base node pointer because the
>>>>> backing BS of the
>>>>>          * bottom node might change after the call to
>>>>> bdrv_reopen_set_read_only()
>>>>>          * due to parallel block jobs running.
>>>>> +     * above_base node might change after the call to
>>>> Yes, if not frozen.
>>>>> +     * bdrv_reopen_set_read_only() due to parallel block jobs running.
>>>>>          */
>>>>> -    base = backing_bs(bottom);
>>>>> -    for (iter = backing_bs(bs); iter && iter != base; iter =
>>>>> backing_bs(iter)) {
>>>>> +    base = bdrv_filter_or_cow_bs(above_base);
>>>>> +    for (iter = bdrv_filter_or_cow_bs(bs); iter != base;
>>>>> +         iter = bdrv_filter_or_cow_bs(iter))
>>>>> +    {
>>>>>             block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
>>>>>                                basic_flags, &error_abort);
>>>>>         }
>>>>>     -    s->bottom = bottom;
>>>>> +    s->base_overlay = base_overlay;
>>>>> +    s->above_base = above_base;
>>>> Generally, being the filter for a concurrent job, the above_base node
>>>> may be deleted any time
>>>>
>>>> and we will keep the dangling pointer. It may happen even earlier if
>>>> above_base is not frozen.
>>>>
>>>> If it is, as it here, we may get the frozen link error then.
>>> I’m not sure what you mean here.  Freezing it was absolutely
>>> intentional.  A dangling pointer would be a problem, but that’s why it’s
>>> frozen, so it stays around and can’t be deleted any time.
>>>
>>> Max
>>
>> The nodes we freeze should be in one context of the relevant job:
>>
>> filter->top_node->intermediate_node(s)
>>
>> We would not include the base or any filter above it to the frozen chain
>>
>> because they are of a different job context.
> 
> They aren’t really, because we need to know the backing node of @device
> after the job.
> 
>> Once 'this' job is completed, we set the current backing child of the
>> base_overlay
>>
>> and may not care of its character. If that is another job filter, it
>> will be replaced
>>
>> with the proper node afterwards.
> 
> But what if there are filters above the base that the user wants to keep
> after the job?
> 
> Max
> 


-- 
Best regards,
Vladimir

