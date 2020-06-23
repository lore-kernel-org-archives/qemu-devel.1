Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31526C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF74520724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vtjd7+F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF74520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncxM-00057P-6v
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jncwQ-0004En-LA; Tue, 23 Jun 2020 03:01:58 -0400
Received: from mail-eopbgr130121.outbound.protection.outlook.com
 ([40.107.13.121]:11342 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jncwN-0002EX-68; Tue, 23 Jun 2020 03:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBVAG11tHb7dR4FnNihFTnUBm67XHQz8MzP2NuqgBO08mx6UDElvFGCBIMU0rVsFgdpmrYnP2Q5/xDqEYxCfDewlkwVoSYmYN8J6Pdtig61ONjMT0QMhuOzThXPLflYPJOMJj/SL7ZRtXlZ/rbpD3S0yMUCQ0xhaD7YlUWWGaHH7YvIVeiQY9OzOHIC3mCTbIMemjtaod+LF7+VFZeXJqV5q15eTXsrz7idQ3yjx+1IbcKUuSpcnKXNSfG0gtepzc+QvBJWyvbmxnnv+vWfBev2xltEjB5Oiz2uGoPFGvWmPwLPUPMsiuUnuSpXwQaaVRFUdSvEqsQfTco2EsOrvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtLNjnt9pzyjSl2kNAL9c6u9EIoINwwYdJzl9SJEoFI=;
 b=MerD59ojc9kK9mCWs0ZOE+PIdhKMhKSRZOdBhJS6Tj5akMxaRl/9hlVy8Qx1D754lpC1YXlLkQICdD8IA4/4BqVGCVQPsYA9lSz2MZNiz13GB8X3XjWf8zeLM4GtwsyZjNSgnl+VWoraAGQvZwrmQIIQQTct6sno1JlY8wAfCRxh/O1GPfvWn+ZhvMgibTDunMMrrVcQVZIbHWXwJJho8I1WpSpNVd67vTEf2H3zyTDCAZTkOocoeMYOmfHBhVewbzWNY9mqe9wn2egRez3f2T7IMUuuo494pPf1Md0VarcNl/aUBW51nIRlLdPLamc6cPNF8ImEZCB9A+7SrperRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtLNjnt9pzyjSl2kNAL9c6u9EIoINwwYdJzl9SJEoFI=;
 b=vtjd7+F45oOBYnWYL7/AC1QB+C/OoYODskmwlgcU0QGR7rjJDdoSOJXQ6zGguCSrxvhTVsIZH5PQswQPCrsCPgKChXWCom4vYGPXChbmtBwKK52QMrqZekieAbOZcWEgFxHQGgoAsO8/w1XGPkjApRqJ7zzCEXyEP3yApgEvlHw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3677.eurprd08.prod.outlook.com (2603:10a6:803:7f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 07:01:49 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:01:49 +0000
Subject: Re: [PATCH v3 1/6] block: add bitmap-populate job
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-2-eblake@redhat.com>
 <074b3859-a6e1-1388-2142-5a7af8ee3fdb@virtuozzo.com>
 <74dc0ce7-2c0e-c987-cbc8-398d2c23f21a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c9eee3d3-8e5f-9908-e0d9-16d5c88ff90c@virtuozzo.com>
Date: Tue, 23 Jun 2020 10:01:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <74dc0ce7-2c0e-c987-cbc8-398d2c23f21a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0084.eurprd02.prod.outlook.com
 (2603:10a6:208:154::25) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.117) by
 AM0PR02CA0084.eurprd02.prod.outlook.com (2603:10a6:208:154::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Tue, 23 Jun 2020 07:01:48 +0000
X-Originating-IP: [185.215.60.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a18760bd-ade7-4e4e-843c-08d817434cf8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3677:
X-Microsoft-Antispam-PRVS: <VI1PR08MB36771A5914F5F316DEABAEAAC1940@VI1PR08MB3677.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoaxQcLkttcJp8yHEL+LgOUmcZjlRbeHnGzxx+NgMJovs3LsFyi7FEZ67AkZDohs6SqaemV8YsaYrCSSj68gdCowzCloG52oDxTuLlWUfxIpNx9+snxMcowSrKiiWku0n6gTseenKMlTTQXD/ZMSdgWB75Tb5PvlJHqVtUjDW9VIIZmsT/xG0pnc7vALCL+r40AyNSQVfY0X60DWwxuRRkX5uSKUfkcboXar5+AFzhdG2EITDIANeTi8vcFqpzF/Ik8Ftuq0jYoke3uFqyWnrW2LFyG4GLLSc9kfSAlqVXBSMBvJLk3PB6WvOPXW/+yOCAOCYN8uJRepYpiJBlPc7JV/y9uhGekulvyvt+eY/VxKIIEe44kPKLWDEDpjysz3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39840400004)(346002)(136003)(366004)(83380400001)(478600001)(316002)(8936002)(66946007)(16576012)(66476007)(66556008)(53546011)(31686004)(2616005)(86362001)(956004)(16526019)(8676002)(36756003)(186003)(2906002)(5660300002)(6486002)(4326008)(31696002)(26005)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: G/TKcaPBAi0xzzbRR8LQLwVTPB84mDdSANwhD+wzqEX3hxG4EIyS4c6dgS2t/CSc7SaLCG9XPDSbagV5xGajDyRXdq38s5Y2Zv7Dk/gc/nHdS+fB45xbVM3KcuuZBKe5go8yMdeXJrUqKSiwJojjo/jKgJos/LS87VAVPE+kXoimJfNIW6rb44aReZ1dpbP4ZrerPl9ogE3QDHzypoHh5lFrAxH2k4A6kQWeZdwKKJuH4Ck81m5NjoOBq/NK9PR7xkNLFSo+6eMHa8zdFSd7DrrUrmkvUzeBQO3uEqIcpJ+CBnAXWcyowuFM9KM8/WHbGS9YXg39obPS7XTPbxnMZlAYPjHt2+qQy94+rFJEkRwlRkC4M+k2WYh1Q4Ynz/0aND0FLdS/FEmYoZcB3zStW4KQCps5Cm/2/fEXE6htsolEOAAvuW/LOXEyNvPKsoC9EHqX8omRyEaDjpjlmCxil6wt/zQmmOmHSwxWf2WdYt6vnfyfOh40HSTZU10ezgMx
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18760bd-ade7-4e4e-843c-08d817434cf8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:01:49.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0x+Tyx0v5dTiBkzjr9Ps24GZTq5BdtZQjX+LkHvEbtRJHBzFTwMX0G98o1CI4LllwICAKHxq/Dmfu8VPMBnsuC6xcwVaM7WrEmuu13I2f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3677
Received-SPF: pass client-ip=40.107.13.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 03:01:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.06.2020 00:44, Eric Blake wrote:
> On 6/19/20 11:16 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 19.06.2020 22:56, Eric Blake wrote:
>>> From: John Snow <jsnow@redhat.com>
>>>
>>> This job copies the allocation map into a bitmap. It's a job because
>>> there's no guarantee that allocation interrogation will be quick (or
>>> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
>>>
>>> It was designed with different possible population patterns in mind,
>>> but only top layer allocation was implemented for now.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
> 
>>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>>> +  'base': 'BlockDirtyBitmap',
>>> +  'data': { 'job-id': 'str',
>>> +            'pattern': 'BitmapPattern',
>>> +            '*on-error': 'BlockdevOnError',
>>> +            '*auto-finalize': 'bool',
>>> +            '*auto-dismiss': 'bool' } }
>>> +
>>
>> Peter said about a possibility of populating several target bitmaps simultaneously.
>>
>> What about such a generalized semantics:
>>
>> Merge all sources to each target
>>
>> @targets: list of bitmaps to be populated by the job
>> { 'struct': 'BlockDirtyBitmapPopulate',
>>    'data': { <common job fields>,
>>              'targets': ['BlockDirtyBitmap'],
>>              'sources': ['BitmapPopulateSource'] } }
> 
> We still need the 'pattern' argument (the idea being that if we have: Base <- Active, we want to be able to merge in the allocation map of Active into bitmaps stored in Base as part of a commit operation, whether that is active commit of a live guest or offline commit while the guest is offline).  Having an array for 'targets' to merge into is fine, but for 'sources', it's less a concern about selecting from multiple sources, and more a concern about selecting the allocation pattern to be merged in (libvirt wants to merge the same allocation pattern into each bitmap in Base).  Generalizing things to allow the merge of more than one source at once might not hurt, but I'm not sure we need it yet.
> 
> But there are other patterns that we may want to support: an all-ones pattern, or maybe a pattern that tracks known-zeros instead of allocation.
> 
>>
>>
>> @bitmap: specify dirty bitmap to be merged to target bitamp(s)
>> @node: specify a node name, which allocation-map is to be merged to target bitmap(s)
>> { 'alternate': 'BitmapPopulateSource',
>>    'data': { 'bitmap': 'BlockDirtyBitmap',
>>              'node': 'str' } }
> 
> This design is clever in that it lets us merge in both existing bitmaps and using a node-name for merging in an allocation map instead of a bitmap; but it limits us to only one pattern.

Ah, yes, we can't discriminate by type node-name from 'all-ones' or something like this.

>Better might be something where we supply a union (hmm, we've had proposals in the past for a default value to the discriminator to allow it to be optional, so I'll proceed as if we will finally implement that):
> 
> { 'enum': 'BitmapPattern', 'data': [ 'bitmap', 'allocation-top' ] }
> { 'union': 'BitmapPopulateSource',
>    'base': { '*pattern': 'BitmapPattern' },
>    'discriminator': { 'name': 'pattern', 'default': 'bitmap' },
>    'data': { 'bitmap': 'BitmapPopulateSource',
>              'allocation-top': { 'node': 'str' } } }

Yes, this is better, of course.

> 
> so that you can then do:
> 
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b1" },
>                                { "node": "base", "name": "b2" } ],
>          "sources": [ { "pattern": "allocation-top", "node": "top" } ]
>    } }
> 
> to merge in the allocation information of top into multiple bitmaps of base at once, or conversely, do:
> 
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b1" } ],
>          "sources": [ { "pattern": "bitmap",
>                         "node": "top", "name": "b1" } ]
>    } }
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b2" } ],
>          "sources": [ { "node": "top", "name": "b2" } ]
>    } }
> 
> and of course, wrap this in a "transaction" to ensure that it all succeeds or fails as a unit, rather than messing up one bitmap if another fails, while also allowing future extension for additional patterns.
> 
>>
>>
>> - so, we can merge several bitmaps together with several allocation maps into several target bitmaps.
>> (I remember, we also said about a possibility of starting several populating jobs, populating into
>>   same bitmap, I think it may be substituted by one job with several sources. Still, it's not hard to
>>   allow to use target bitmaps in a several jobs simultaneously and this is not about the QAPI interface)
>>
>> Will this simplify things in libvirt?
> 
> Peter, in your preliminary experiments with block-dirty-bitmap-populate, did you ever need to start more than one job to a single bitmap destination, or was it merely starting multiple jobs because you had multiple destinations but always just a single source?
> 
> 


-- 
Best regards,
Vladimir

