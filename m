Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1137C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF9A206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L+pnaZ4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEd1-0005WZ-Vu
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiEZn-00037o-Bi; Mon, 08 Jun 2020 06:00:20 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com
 ([40.107.21.125]:12447 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiEZj-0005Ag-6t; Mon, 08 Jun 2020 06:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuT1yRSf3rfSx3nK/L1GJmsU+uETpQuw9qB/uniA8dzYy+AiGwvUgVHHxex3ilFqb1R/wKrxVVY5tHFzKNAjoE5c4Evgwu7yA67v8wgf+expdTFN71y1XES8TUwmskSDfQr2FkoHteleVZlYyqy/Btg9faZuLnazk9rRAjYyxkq2KApF+t8daJp6kLmfnM+l/5MZG3nG4cksmdkOEKjCt0LoD5UgZkMVA36QvilvtnkCTPiYNJCVv9s1so/A9Y1dXeEHwwXtB9NJZolsAGlABtB7peQzI6JmAheoXQ28SRnO3p73s+zC+v+0jEjqS4951DYLfs32WZZ9/cO0yZeUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MX/YtVtKeLeAGKbkPgRawNt9gebpnGbtNefSyJOxSo=;
 b=QSUJE3hgLqWJGm7tsvlPtQ5bPEOjD5k5yqnZ6geJC22nQ8Rps/gknfTxPo6hgdi+jHCT9JS2GaQ5ME9PzOpDQHOrRrXRc4D04sR066AjfomrqrzLUuCfEsVMMR2O+zls07sLlOFFOBbMejQo49oqvGnUI4btppqt3MZA1pWtfj+Nwm7nCsCdUMyi7Y8/PwbowSf1ulmXg00j3gkOQL00bSea/6jw7AfQ0QH7eJaj2DXzUPo1VMEUAEIodGcc1zBZu6DuVDjNzPQJjpwuAPkf19HVYfJ5pjzYpqt00NByxArE4uC8P48wcir5r0DZ++C17mhA1T1snYzyG9QoJ8io/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MX/YtVtKeLeAGKbkPgRawNt9gebpnGbtNefSyJOxSo=;
 b=L+pnaZ4oPagGkQbXQY0UGLrd5TnXvwMsv829CpqhC7VnT3gtIdOU/5iIwdr58SPuKFOKCjBXKgQkT3VEsEoRoqStsVSJF4gaOef5ijRNIjY7CbwqGBG8uEAUTDId+FSPjLBNB/HvoyoY3/G4/WoSZhcNaDiOopDA4IPLa6tQSHw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 10:00:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:00:09 +0000
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
To: Kevin Wolf <kwolf@redhat.com>
References: <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
 <20200608092127.GB6419@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0362d7ec-7584-e5e9-2619-f4a1fd292761@virtuozzo.com>
Date: Mon, 8 Jun 2020 13:00:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608092127.GB6419@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 AM0PR03CA0034.eurprd03.prod.outlook.com (2603:10a6:208:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:00:08 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e97ecb10-4db2-4b6c-3caf-08d80b92ba66
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512876FBB52BAAF305CB0F3C1850@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpWOmcbjznL8kJYp74ZLx8USZXZyEXHQPjuhwGPy6sR/FKh/xsID5cFW+35yLQUIwvBD4ZFgZlCBnGG1+QnXCV2a3tRNZG1hy8JyTxh/0dweIM0ockW/m+TczVv3Kf70Qi8WX/B15bGxF7rNQ6b3z3ZqYM8VSkOW1rjqthezDik+nddoFoG1hYZf1e7ps9J8Z+IksYMJ32nw478bA0oX3ByaTCfQ02jx9eCvrWW8lZOvzip5uiyByALdJoRIq7r/FuhZPAh+JL7fvYJkWPErPUb74d3VSowBdSXcrX4K0GjPZhv2TyMzJiB8H5EmLO8YtiaPXt88+ZWui9iZNZlqkaRXwKhatl3rovf0c/0JSahdDnSEyweZ6h7agJd3ZsLG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39840400004)(366004)(478600001)(316002)(31686004)(4326008)(54906003)(8936002)(6916009)(2906002)(16576012)(956004)(2616005)(83380400001)(53546011)(186003)(16526019)(31696002)(86362001)(6486002)(66476007)(66946007)(66556008)(26005)(36756003)(8676002)(7416002)(52116002)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 090olJvsL5BMgJWvCYk8YL0KKL+p4knAeZUORVJ7H7r6bOOB+n/nF6JUffa9LtdzlYEieGsgiVH6zaVZBamcBTop+F3hc8JqEWJASYyGsQjlE0FcQjI/ZYg9xysPp6rEcNOK7B5W4cSNr9fYKjnjd7zzqvtQHZ60IjAA6h2pmUnfESj19bHOg7MBla1waPSvkg0djW0+JtaMm/fv8vPE6DlPeT+IepXF7hkngifDw5XjhbwkV67Ss1gYlf9ZGE09iaDDRpeih5aZNbrpptOsvMckVTci37C0mPUVmKiayqZnTKfdSRc6fLXphbOomqPDoYqxj7QkHLSbhyYqOkd9dXw2t3UHqPFCrw9XLV9KqHdoCHxxvQRgYwG65VQs3H6c7ScDoQfZQtV07pvf3ZX/nLlpX/nIcVjHcP/NfmUBwk4+yjdVFKv15TeiMJRDZmsA6fFIXgLoHdv1deW0Ee5xKNEJBulf5rc249W8bmwdbh8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97ecb10-4db2-4b6c-3caf-08d80b92ba66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:00:09.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9MY9sUr/fN24ocZH1FOI1wVlrFIVvC/MIIGvduMn8Y3AAWqnC6lk+3qVTjOjUiy0e1pkbIgxwCwevKLCTHUn6dFDM1rbhKW2omFdhtXKnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.21.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 06:00:11
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.06.2020 12:21, Kevin Wolf wrote:
> Am 06.06.2020 um 08:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 05.06.2020 13:59, Peter Krempa wrote:
>>> On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
>>>> Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
>>>>> On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:
>>>
>>> [...]
>>>
>>>>> The above was actually inspired by a very recent problem I have in my
>>>>> attempt to use the dirty bitmap populate job to refactor how libvirt
>>>>> handles bitmaps. I've just figured out that I need to shuffle around
>>>>> some stuff as I can't run the dirty-bitmap-populate job while an active
>>>>> layer commit is in synchronised phase and I wanted to do the merging at
>>>>> that point. That reminded me of a possible gotcha in having to sequence
>>>>> the blockjobs which certainly would be more painful.
>>>>
>>>> It would probably be good to have not only an iotests case that tests
>>>> the low-level functionality of the block job, but also one that
>>>> resembles the way libvirt would actually use it in combination with
>>>> other jobs.
>>>
>>
>> Hi! Sorry me missing the discussion for a long time.
>>
>> About new job semantics: if you create temporary bitmaps anyway, I do
>> think that we should allow to populate into target bitmap directly,
>> without creating any internal temporary bitmaps. I suggested it when
>> reviewing v1, John argued for more transaction-like semantics to look
>> like other jobs. Still, we can support both modes if we want.
> 
> But don't all other jobs allow you to see intermediate states? Like,
> when you look at the target node in the middle of a mirror job, you'll
> see a half-updated target image.

That was my argument on v1 :)

> 
> If we have an actual use case for both modes, we can certainly support
> that, but do we have one?

No. We have only one: without extra temporary bitmap, let's implement it.
We can always add transaction-like case later on demand.

> 
>> Allowing to use one target for several populating job is an
>> interesting idea. Current series does
>> "bdrv_dirty_bitmap_set_busy(target_bitmap, true);", which forbids it..
>> Hmm. If we just drop it, nothing prevents user just remove target
>> bitmap during the job. So, we'll need something like collective-busy
>> bitmap..
> 
> I'm not sure for what the busy flag is used in detail, but if this is
> the problem, maybe it's possible to just replace it with a counter?
> 

busy flag means that bitmap is already in-use by some process (for example
backup, or exported through NBD, or being migrated). User can't change or
use busy bitmaps for another jobs. So multiple jobs writing into one bitmaps
should be an exclusion from this rule (we want to allow several similar
block-jobs, but still don't want to allow migration or NBD-export in the same
time, or bitmap removing). I think we can just hardcode this case, add a new
flag, which says that bitmap is used as target of populating jobs and being
busy still allowed as a target for another populating job.

-- 
Best regards,
Vladimir

