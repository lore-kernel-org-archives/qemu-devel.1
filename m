Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B98C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5C120702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aYvNczhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5C120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvOc-0000VW-WA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqvNm-0008CC-3y; Thu, 02 Jul 2020 05:19:50 -0400
Received: from mail-eopbgr40107.outbound.protection.outlook.com
 ([40.107.4.107]:2179 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqvNh-0001Fa-Jd; Thu, 02 Jul 2020 05:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE7OmYJcBIBEp87QV/VPHydNLf/TywG0TI510o7EHTk9cuqX2HqpTe09kFn9yU9MTCpOiC3CcjyHXv/mVXb2RH06vmtPwT6njkNAzqv7Tvr+BJwEKoHzMu9tp1CAeNLBzAvdoaZM5cynilYzfRpU/3mj1GL/DzYgzW7f5+EiMm2WRuckIW31aLhPbTzvPG1jKvdtuVEg+5q42wor5/Fz11J0wC6PwNYbZjzSmJrl8TC0lPEVysTwFVLz8iKaQO5IQ0Ng4tn79x+6ZReEuCYLWUg3wCR3TIX94zwULWmVkg5IKCCiJMmJcth4pnQXlgI6WX+djgA97+uEApt4SAROCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNXsvhSr5HsCfa5sSVfAoA2nppSPRTeH3UV22pzOgzo=;
 b=ieIxz61Xw7rpM6GMCZxHdCVNcRnr6xA5U5lpOW1b5KJb24gL0g86UncesxFWPZgr5PhsoDmG3+eKMzkbkC2uV+0Jya10s3wdQsINXaTUb4UT2VMCjJYgVjPM3j+Y85Z/DulJvnDZNjlqKFy6JcRXB410Zw0hF6bIiAiOzZ+iYP4dTWyjWxtBhuj6gieYO264NW3X3ifLNBTHCsKPmltoF9xW2IZ+rrp1I01ypQiFh0+m6dOa7Cgi1VzqtIcZp9FZxRcD7VpeXm9++nkqsICXDMg+z6P6GFK+OYoyDYsDhOdpYnbRlmf/lXjWRjKd8DChlH09ZtknWwFfz3mk14sucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNXsvhSr5HsCfa5sSVfAoA2nppSPRTeH3UV22pzOgzo=;
 b=aYvNczhWUmbM+5kSca4LAT9+M3UgaCkrVhKEegJzIkjlCkpXHv28w/mmN+8N8te2/ayqlG++EpMJFthSyKP+uymmVIRvPWM59TFeqfugd+DnVKZ+IOQc5Jwdm6LS3aUCXQ8yxdOpiukZIilRRrKFOgzHUVMVL5WeRk9CUNJAa4w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:19:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 09:19:42 +0000
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
 <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
Date: Thu, 2 Jul 2020 12:19:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Thu, 2 Jul 2020 09:19:41 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660c5b38-cbf3-49bf-bc1a-08d81e690d55
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26108B3D162DD1752C471C8FC16D0@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3w9KZIvuqQxpDySV+5r/niicNmwU6qix/ODjr306o60OjrjX9F9Z0vxRKcg2+NFRprFcYbQ7XBR9qkUXKqkE4wahMrmdVeVa52BpxRlmU9vOEesAOZMgC5gA+5ZDR1Twp4j29IKGdSjPDTTI99b+01ymK837cx9VzpuWQLkCHw4hyGv3Vg0ggp8YliEnzcaxt2/gPd7BrqqKehfbh+58KPHJvlqO69/KROkJU2wf9w9hyRODeyqXwmaKEF58D2/khfGuR3VLG4HFxz/kCCh1bMHsioUvwIbm323t5vMah/RbN3Ba+pmjmkldVxkkWRA0GfuVZjsORaFTN6vvR5NTtasIlQ76tkDQp3FCc1tWN1oQcTm1EIE6b1pn8knPdH8Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39830400003)(396003)(136003)(186003)(52116002)(31686004)(86362001)(66556008)(8936002)(31696002)(66476007)(16526019)(36756003)(2616005)(956004)(66946007)(8676002)(5660300002)(6486002)(30864003)(2906002)(54906003)(26005)(16576012)(53546011)(478600001)(316002)(4326008)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DdJVVN8OYTEShY4KFoxK7k4+jnZMEBQvh2Ul0ivSzmy8/WeJM10tTTo9nO7MtziETVyUh5x/hN9RiDOETEzoVOsvYomvyiIM2Wyfajp8uqDfU9MBNwckd9l/CBEFOBbdP0y6QJfGze/wuC+BHMd6bmVcTKGlEo0CvMBwl0PDNcEEZXtq1ngKko0lfRpmL4cmFvysXbmm5a2r2C21MicW3A+h23IwjviiM3OofHgCUzO0/QhNOVf+obuvGy0NvjM/1fH9JhftckNzqMGG6YanOW7H6oaw6FqCp68bP79tFXM1OjPKSeDg86Sthj/ckHy1QBqryKqJUsZjCv8XqGy3rl7Moxag/ZdW2AtfRUFeGr2066Bw+snWBhGPmS9bhorVxw4KiFAvdnA0k/wB1ruQhFCMGEEamUUqY8LXfrsJg2uygyDK5sKtKKEpJfxJRLA0Az1XSnsgGgkfiYUE0KIW2NZOqrpKOOtj0DUKtZUlmbQaDrcBX+vV21cgxQCa9Fkj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660c5b38-cbf3-49bf-bc1a-08d81e690d55
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:19:42.0272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqg6sYeGU+KFm+rmagO/CwY1anBsHgHNwFL261iN7UMy0847VWNcbnyhGnAb5cyGoVRwJCn9zXJqXSI/Hs36Aa+VZLKiYdBdcTfUYkYLYqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.4.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 05:19:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 11:09, Max Reitz wrote:
> On 01.07.20 16:34, Vladimir Sementsov-Ogievskiy wrote:
>> 30.06.2020 11:45, Max Reitz wrote:
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
>>>    qapi/migration.json            |  83 +++++++-
>>>    migration/migration.h          |   3 +
>>>    migration/block-dirty-bitmap.c | 372 ++++++++++++++++++++++++++++-----
>>>    migration/migration.c          |  29 +++
>>>    4 files changed, 432 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index d5000558c6..5aeae9bea8 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -507,6 +507,44 @@
>>>      'data': [ 'none', 'zlib',
>>>                { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>>>    +##
>>> +# @BitmapMigrationBitmapAlias:
>>> +#
>>> +# @name: The name of the bitmap.
>>> +#
>>> +# @alias: An alias name for migration (for example the bitmap name on
>>> +#         the opposite site).
>>> +#
>>> +# Since: 5.1
>>> +##
>>> +{ 'struct': 'BitmapMigrationBitmapAlias',
>>> +  'data': {
>>> +      'name': 'str',
>>> +      'alias': 'str'
>>> +  } }
>>> +
>>> +##
>>> +# @BitmapMigrationNodeAlias:
>>> +#
>>> +# Maps a block node name and the bitmaps it has to aliases for dirty
>>> +# bitmap migration.
>>> +#
>>> +# @node-name: A block node name.
>>> +#
>>> +# @alias: An alias block node name for migration (for example the
>>> +#         node name on the opposite site).
>>> +#
>>> +# @bitmaps: Mappings for the bitmaps on this node.
>>> +#
>>> +# Since: 5.1
>>> +##
>>> +{ 'struct': 'BitmapMigrationNodeAlias',
>>> +  'data': {
>>> +      'node-name': 'str',
>>> +      'alias': 'str',
>>> +      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>>
>> So, we still can't migrate bitmaps from one node to different nodes, but we
>> also don't know a usecase for it, so it seems OK. But with such scheme we
>> can select and rename bitmaps in-flight, and Peter said about corresponding
>> use-case.
>>
>> I'm OK with this, still, just an idea in my mind:
>>
>> we could instead just have a list of
>>
>> BitmapMigrationAlias: {
>>   node-name
>>   bitmap-name
>>   node-alias
>>   bitmap-alias
>> }
>>
>> so, mapping is set for each bitmap in separate.
> 
> Well, OK, but why?

But why not :) Just thinking out loud. May be someone will imaging good reasons for it.

> 
>>> +  } }
>>> +
>>>    ##
>>>    # @MigrationParameter:
>>>    #
>>> @@ -641,6 +679,18 @@
>>>    #          will consume more CPU.
>>>    #          Defaults to 1. (Since 5.0)
>>>    #
>>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>>> +#          aliases for the purpose of dirty bitmap migration.  Such
>>> +#          aliases may for example be the corresponding names on the
>>> +#          opposite site.
>>> +#          The mapping must be one-to-one and complete: On the source,
>>
>> I've recently faced the case where incomplete mapping make sence: shared
>> migration of read-only bitmaps in backing files: it seems better to not
>> migrate them through migration channel, they are migrating through
>> shared storage automatically (yes, we'll pay the time to load them on
>> destination, but I'm going to improve it by implementing lazy load of
>> read-only and disabled bitmaps, so this will not be a problem).
>>
>> So, now I think that it would be good just ignore all the bitmap not
>> described by mapping
> 
> OK.
> 
>>> +#          migrating a bitmap from a node when either is not mapped
>>> +#          will result in an error.  On the destination, similarly,
>>> +#          receiving a bitmap (by alias) from a node (by alias) when
>>> +#          either alias is not mapped will result in an error.
>>> +#          By default, all node names and bitmap names are mapped to
>>> +#          themselves. (Since 5.1)
>>
>> This sentense is unclear, want means "by default" - if the mapping is
>> not specified at all or if some nodes/bitmaps are not covered.
> 
> It is clear.
> 
>> Still,
>> tha latter will conflict with previous sentencies, so "by default" is
>> about when mapping is not set at all.
> 
> Precisely.
> 
>> I suggest to word it directly:
>> "If mapping is not set (the command never called, or mapping was
>> removed".
> 
> The mapping cannot be removed.
> 
> It’s also technically clear because mentioning a default for some
> parameter always means that that particular parameter will have that
> default.  So in this case “by default” refers to block-bitmap-mapping,
> not anything nested in it.  (Defaults for stuff nested in its value
> would be described in the respective structs’ definitions.)

Reasonable.

> > I’d be OK with “By default (when this parameter has never been set)…”.

Yes, this is absolutely clear.

> 
>> And, actual behavior without mapping is not as simple: it actually tries
>> to use blk names if possible and node-names if not, and this veries
>> from version to version. So, I think not worth to document it in detail,
>> just note, that without mapping the behavior is not well defined and
>> tries to use block-device name if possible and node-name otherwise. And
>> of course direct mapping of bitmap names.
> 
> OK.
> 
>>> +#
>>>    # Since: 2.4
>>>    ##
>>>    { 'enum': 'MigrationParameter',
>>> @@ -655,7 +705,8 @@
>>>               'multifd-channels',
>>>               'xbzrle-cache-size', 'max-postcopy-bandwidth',
>>>               'max-cpu-throttle', 'multifd-compression',
>>> -           'multifd-zlib-level' ,'multifd-zstd-level' ] }
>>> +           'multifd-zlib-level' ,'multifd-zstd-level',
>>> +           'block-bitmap-mapping' ] }
>>>      ##
>>>    # @MigrateSetParameters:
>>> @@ -781,6 +832,18 @@
>>>    #          will consume more CPU.
>>>    #          Defaults to 1. (Since 5.0)
>>>    #
>>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>>> +#          aliases for the purpose of dirty bitmap migration.  Such
>>> +#          aliases may for example be the corresponding names on the
>>> +#          opposite site.
>>> +#          The mapping must be one-to-one and complete: On the source,
>>> +#          migrating a bitmap from a node when either is not mapped
>>> +#          will result in an error.  On the destination, similarly,
>>> +#          receiving a bitmap (by alias) from a node (by alias) when
>>> +#          either alias is not mapped will result in an error.
>>> +#          By default, all node names and bitmap names are mapped to
>>> +#          themselves. (Since 5.1)
>>
>> Do we really need this duplication? I'd prefere to document it once if
>> possible.
> 
> Well, or maybe this just shouldn’t be a migration parameter.  I don’t know.
> 
> I don’t really want to move this documentation or even just parts of it
> to BitmapMigrationNodeAlias, because that’s just one element of the
> whole list.
> 
>>> +#
>>>    # Since: 2.4
>>>    ##
>>>    # TODO either fuse back into MigrationParameters, or make
>>> @@ -811,7 +874,8 @@
>>>                '*max-cpu-throttle': 'int',
>>>                '*multifd-compression': 'MultiFDCompression',
>>>                '*multifd-zlib-level': 'int',
>>> -            '*multifd-zstd-level': 'int' } }
>>> +            '*multifd-zstd-level': 'int',
>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>>>      ##
>>>    # @migrate-set-parameters:
>>> @@ -957,6 +1021,18 @@
>>>    #          will consume more CPU.
>>>    #          Defaults to 1. (Since 5.0)
>>>    #
>>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>>> +#          aliases for the purpose of dirty bitmap migration.  Such
>>> +#          aliases may for example be the corresponding names on the
>>> +#          opposite site.
>>> +#          The mapping must be one-to-one and complete: On the source,
>>> +#          migrating a bitmap from a node when either is not mapped
>>> +#          will result in an error.  On the destination, similarly,
>>> +#          receiving a bitmap (by alias) from a node (by alias) when
>>> +#          either alias is not mapped will result in an error.
>>> +#          By default, all node names and bitmap names are mapped to
>>> +#          themselves. (Since 5.1)
>>
>> once again..
>>
>>> +#
>>>    # Since: 2.4
>>>    ##
>>>    { 'struct': 'MigrationParameters',
>>> @@ -985,7 +1061,8 @@
>>>                '*max-cpu-throttle': 'uint8',
>>>                '*multifd-compression': 'MultiFDCompression',
>>>                '*multifd-zlib-level': 'uint8',
>>> -            '*multifd-zstd-level': 'uint8' } }
>>> +            '*multifd-zstd-level': 'uint8',
>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>>>      ##
>>>    # @query-migrate-parameters:
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index f617960522..038c318b92 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -336,6 +336,9 @@ void
>>> migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>>>      void dirty_bitmap_mig_before_vm_start(void);
>>>    void init_dirty_bitmap_incoming_migration(void);
>>> +bool check_dirty_bitmap_mig_alias_map(const
>>> BitmapMigrationNodeAliasList *bbm,
>>> +                                      Error **errp);
>>> +
>>>    void migrate_add_address(SocketAddress *address);
>>>      int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>>> diff --git a/migration/block-dirty-bitmap.c
>>> b/migration/block-dirty-bitmap.c
>>> index 47bc0f650c..621eb7e3f8 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -29,10 +29,10 @@
>>>     *
>>>     * # Header (shared for different chunk types)
>>>     * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
>>> - * [ 1 byte: node name size ] \  flags & DEVICE_NAME
>>> - * [ n bytes: node name     ] /
>>> - * [ 1 byte: bitmap name size ] \  flags & BITMAP_NAME
>>> - * [ n bytes: bitmap name     ] /
>>> + * [ 1 byte: node alias size ] \  flags & DEVICE_NAME
>>> + * [ n bytes: node alias     ] /
>>> + * [ 1 byte: bitmap alias size ] \  flags & BITMAP_NAME
>>> + * [ n bytes: bitmap alias     ] /
>>>     *
>>>     * # Start of bitmap migration (flags & START)
>>>     * header
>>> @@ -72,7 +72,9 @@
>>>    #include "migration/register.h"
>>>    #include "qemu/hbitmap.h"
>>>    #include "qemu/cutils.h"
>>> +#include "qemu/id.h"
>>>    #include "qapi/error.h"
>>> +#include "qapi/qapi-commands-migration.h"
>>>    #include "trace.h"
>>>      #define CHUNK_SIZE     (1 << 10)
>>> @@ -103,7 +105,8 @@
>>>    typedef struct DirtyBitmapMigBitmapState {
>>>        /* Written during setup phase. */
>>>        BlockDriverState *bs;
>>> -    const char *node_name;
>>> +    char *node_alias;
>>> +    char *bitmap_alias;
>>>        BdrvDirtyBitmap *bitmap;
>>>        uint64_t total_sectors;
>>>        uint64_t sectors_per_chunk;
>>> @@ -128,7 +131,8 @@ typedef struct DirtyBitmapMigState {
>>>      typedef struct DirtyBitmapLoadState {
>>>        uint32_t flags;
>>> -    char node_name[256];
>>> +    char node_alias[256];
>>> +    char bitmap_alias[256];
>>>        char bitmap_name[256];
>>>        BlockDriverState *bs;
>>>        BdrvDirtyBitmap *bitmap;
>>> @@ -144,6 +148,162 @@ typedef struct DirtyBitmapLoadBitmapState {
>>>    static GSList *enabled_bitmaps;
>>>    QemuMutex finish_lock;
>>>    +/* For hash tables that map node/bitmap names to aliases */
>>> +typedef struct AliasMapInnerNode {
>>> +    char *string;
>>> +    GHashTable *subtree;
>>> +} AliasMapInnerNode;
>>
>> Probably, would be simpler to have (node,bitmap) <->
>> (node-alias,bitmap-alias) mapping than nested hash-tables, but this
>> should work too, I don't have real arguments.
> 
> I’m not sure it would be simpler.  Instead of this, we’d need a
> structure to hold two strings (and hash and comparison functions for it,
> though they’d be simple).

Yes, I thought about that too. So, consider it thinking out loud.

> 
>>> +
>>> +static void free_alias_map_inner_node(void *amin_ptr)
>>> +{
>>> +    AliasMapInnerNode *amin = amin_ptr;
>>> +
>>> +    g_free(amin->string);
>>> +    g_hash_table_unref(amin->subtree);
>>> +    g_free(amin);
>>> +}
>>> +
>>> +/**
>>> + * Construct an alias map based on the given QMP structure.
>>> + *
>>> + * (Note that we cannot store such maps in the MigrationParameters
>>> + * object, because that struct is defined by the QAPI schema, which
>>> + * makes it basically impossible to have dicts with arbitrary keys.
>>> + * Therefore, we instead have to construct these maps when migration
>>> + * starts.)
>>> + *
>>> + * @bbm is the block_bitmap_mapping from the migration parameters.
>>> + *
>>> + * If @name_to_alias is true, the returned hash table will map node
>>> + * and bitmap names to their respective aliases (for outgoing
>>> + * migration).
>>> + *
>>> + * If @name_to_alias is false, the returned hash table will map node
>>> + * and bitmap aliases to their respective names (for incoming
>>> + * migration).
>>> + *
>>> + * The hash table maps node names/aliases to AliasMapInnerNode
>>> + * objects, whose .string is the respective node alias/name, and whose
>>> + * .subtree table maps bitmap names/aliases to the respective bitmap
>>> + * alias/name.
>>> + */
>>> +static GHashTable *construct_alias_map(const
>>> BitmapMigrationNodeAliasList *bbm,
>>> +                                       bool name_to_alias,
>>> +                                       Error **errp)
>>> +{
>>> +    GHashTable *alias_map = NULL;
>>
>> dead assignment
> 
> Indeed.
> 
>>> +
>>> +    alias_map = g_hash_table_new_full(g_str_hash, g_str_equal,
>>> +                                      g_free,
>>> free_alias_map_inner_node);
>>> +
>>> +    for (; bbm; bbm = bbm->next) {
>>> +        const BitmapMigrationNodeAlias *bmna = bbm->value;
>>> +        const BitmapMigrationBitmapAliasList *bmbal;
>>> +        AliasMapInnerNode *amin;
>>> +        GHashTable *bitmaps_map;
>>> +        const char *node_map_from, *node_map_to;
>>> +
>>> +        if (!id_wellformed(bmna->alias)) {
>>> +            error_setg(errp, "The node alias %s is not well-formed",
>>> +                       bmna->alias);
>>> +            goto fail;
>>> +        }
>>> +
>>> +        if (name_to_alias) {
>>> +            if (g_hash_table_contains(alias_map, bmna->node_name)) {
>>> +                error_setg(errp, "The node name %s is mapped twice",
>>> +                           bmna->node_name);
>>> +                goto fail;
>>> +            }
>>> +
>>> +            node_map_from = bmna->node_name;
>>> +            node_map_to = bmna->alias;
>>> +        } else {
>>> +            if (g_hash_table_contains(alias_map, bmna->alias)) {
>>> +                error_setg(errp, "The node alias %s is used twice",
>>> +                           bmna->alias);
>>> +                goto fail;
>>> +            }
>>> +
>>> +            node_map_from = bmna->alias;
>>> +            node_map_to = bmna->node_name;
>>> +        }
>>> +
>>> +        bitmaps_map = g_hash_table_new_full(g_str_hash, g_str_equal,
>>> +                                            g_free, g_free);
>>> +
>>> +        for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
>>> +            const BitmapMigrationBitmapAlias *bmba = bmbal->value;
>>> +            const char *bmap_map_from, *bmap_map_to;
>>> +
>>> +            if (name_to_alias) {
>>> +                bmap_map_from = bmba->name;
>>> +                bmap_map_to = bmba->alias;
>>> +
>>> +                if (g_hash_table_contains(bitmaps_map, bmba->name)) {
>>> +                    error_setg(errp, "The bitmap %s/%s is mapped twice",
>>> +                               bmna->node_name, bmba->name);
>>> +                    goto fail;
>>
>> bitmaps_map is leaked here and ..
>>
>>> +                }
>>> +            } else {
>>> +                bmap_map_from = bmba->alias;
>>> +                bmap_map_to = bmba->name;
>>> +
>>> +                if (g_hash_table_contains(bitmaps_map, bmba->alias)) {
>>> +                    error_setg(errp, "The bitmap alias %s/%s is used
>>> twice",
>>> +                               bmna->alias, bmba->alias);
>>> +                    goto fail;
>>
>> .. here
>>
>> Probably, simplest way to fix is to create AliasMapIneerNode and insert
>> it into alias_map immediately after allocating bitmaps_map (prior to
>> this loop).
> 
> Ah, yes.
> 
>>> +                }
>>> +            }
>>> +
>>> +            g_hash_table_insert(bitmaps_map,
>>> +                                g_strdup(bmap_map_from),
>>> g_strdup(bmap_map_to));
>>> +        }
>>> +
>>> +        amin = g_new(AliasMapInnerNode, 1);
>>> +        *amin = (AliasMapInnerNode){
>>
>> style: space before '{'
> 
> Is that required?

If checkpatch doesn't complain, than not..

> 
>>> +            .string = g_strdup(node_map_to),
>>> +            .subtree = bitmaps_map,
>>> +        };
>>> +
>>> +        g_hash_table_insert(alias_map, g_strdup(node_map_from), amin);
>>> +    }
>>> +
>>> +    return alias_map;
>>> +
>>> +fail:
>>> +    g_hash_table_destroy(alias_map);
>>> +    return NULL;
>>> +}
>>> +
>>> +/**
>>> + * Run construct_alias_map() in both directions to check whether @bbm
>>> + * is valid.
>>> + * (This function is to be used by migration/migration.c to validate
>>> + * the user-specified block-bitmap-mapping migration parameter.)
>>> + *
>>> + * Returns true if and only if the mapping is valid.
>>> + */
>>> +bool check_dirty_bitmap_mig_alias_map(const
>>> BitmapMigrationNodeAliasList *bbm,
>>> +                                      Error **errp)
>>> +{
>>> +    GHashTable *alias_map;
>>> +
>>> +    alias_map = construct_alias_map(bbm, true, errp);
>>> +    if (!alias_map) {
>>> +        return false;
>>> +    }
>>> +    g_hash_table_destroy(alias_map);
>>> +
>>> +    alias_map = construct_alias_map(bbm, false, errp);
>>> +    if (!alias_map) {
>>> +        return false;
>>> +    }
>>> +    g_hash_table_destroy(alias_map);
>>> +
>>> +    return true;
>>> +}
>>> +
>>>    void init_dirty_bitmap_incoming_migration(void)
>>>    {
>>>        qemu_mutex_init(&finish_lock);
>>> @@ -191,11 +351,11 @@ static void send_bitmap_header(QEMUFile *f,
>>> DirtyBitmapMigBitmapState *dbms,
>>>        qemu_put_bitmap_flags(f, flags);
>>>          if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
>>> -        qemu_put_counted_string(f, dbms->node_name);
>>> +        qemu_put_counted_string(f, dbms->node_alias);
>>>        }
>>>          if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> -        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
>>> +        qemu_put_counted_string(f, dbms->bitmap_alias);
>>>        }
>>>    }
>>>    @@ -263,15 +423,20 @@ static void dirty_bitmap_mig_cleanup(void)
>>>            QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
>>>            bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
>>>            bdrv_unref(dbms->bs);
>>> +        g_free(dbms->node_alias);
>>> +        g_free(dbms->bitmap_alias);
>>>            g_free(dbms);
>>>        }
>>>    }
>>>      /* Called with iothread lock taken. */
>>> -static int add_bitmaps_to_list(BlockDriverState *bs, const char
>>> *bs_name)
>>> +static int add_bitmaps_to_list(BlockDriverState *bs, const char
>>> *bs_name,
>>> +                               GHashTable *alias_map)
>>>    {
>>>        BdrvDirtyBitmap *bitmap;
>>>        DirtyBitmapMigBitmapState *dbms;
>>> +    GHashTable *bitmap_aliases;
>>
>> can bitmap_aliases be const ptr too?
> 
> Unfortunately no because g_hash_table_lookup() expects the hash table to
> not be const, for whatever reason.
> 
>>> +    const char *node_alias, *bitmap_name, *bitmap_alias;
>>>        Error *local_err = NULL;
>>>          bitmap = bdrv_dirty_bitmap_first(bs);
>>> @@ -279,21 +444,40 @@ static int add_bitmaps_to_list(BlockDriverState
>>> *bs, const char *bs_name)
>>>            return 0;
>>>        }
>>>    +    bitmap_name = bdrv_dirty_bitmap_name(bitmap);
>>
>> Note, that bitmap is wrong here: it may be internal unnamed bitmap which
>> we should ignore.
>> I have sent a patch for this: "[PATCH] migration/block-dirty-bitmap: fix
>> add_bitmaps_to_list"
>>
>>> +
>>>        if (!bs_name || strcmp(bs_name, "") == 0) {
>>>            error_report("Bitmap '%s' in unnamed node can't be migrated",
>>> -                     bdrv_dirty_bitmap_name(bitmap));
>>> +                     bitmap_name);
>>>            return -1;
>>>        }
>>>    -    if (bs_name[0] == '#') {
>>> +    if (alias_map) {
>>> +        const AliasMapInnerNode *amin =
>>> g_hash_table_lookup(alias_map, bs_name);
>>> +
>>> +        if (!amin) {
>>> +            error_report("Bitmap '%s' on node '%s' with no alias
>>> cannot be "
>>> +                         "migrated", bitmap_name, bs_name);
>>
>> As I've said before, it may be reasonable to ignore bitmaps not
>> referenced in the hash-table.
> 
> No problem with that.  We just decided on this behavior when we
> discussed the RFC.

Sorry for that. The reason for my changed opinion is a recent bug from
customers about bitmap migration.

> 
>> And it seems to be good default behavior. We are really tired from
>> problems with bitmaps which
>> can't migrate for different reasons, when bitmaps are actually
>> non-critical data, and choosing
>> from customer problems like:
>>
>>   1. - Hey, after update migration is broken! It says that some bitmaps
>> can't be migrated, what is that?
>>   
>>   2. - Hmm, it seems, that in some cases, incremental backup doesn't work
>> after migration and full backup
>>        is automatically done instead.. Why?
>>
>> I now prefer the [2].
>>
>>> +            return -1;
>>> +        }
>>> +
>>> +        node_alias = amin->string;
>>> +        bitmap_aliases = amin->subtree;
>>> +    } else {
>>> +        node_alias = bs_name;
>>> +        bitmap_aliases = NULL;
>>> +    }
>>
>> Hmm, actually bs_name argument is incompatiblewith alias_map, let's
>> assert that they are not non-null simultaneously.
>>
>> Ah stop, I see, you use bs_name as node-name later and before.. Hmm,
>> seems all this a bit confused.
>>
>> Prior the patch, why do we have bs_name: because it may be node-name or
>> blk-name, to be use in migration protocol as (actually) an alias, so
>> bs_name is more like an alias..
>>
>> So, we have bs, which already have bs->node_name, we have alias_map,
>> where we have relation node_name -> alias, and we have bs_name, which is
>> something like an alias_name.
>>
>> I think the most clean thing is to allow only one of bs_name and
>> alias_map to be non-null, use bs_name only for old scenario, and for new
>> scenario use bdrv_get_node_name() for error-reporting. And a comment
>> about function semantics won't hurt.
>>
>> upd: aha, I see that in case of new semantics, bs_name is exactly
>> bdrv_get_node_name(). It's a bit redundant but OK too.. Let's at least
>> add an assertion.
> 
> Now I’m confused.  What assertion?  I don’t think I want to add an
> assertion that exactly one of bs_name or alias_map is NULL, because that
> would complicate the code.  The caller would have to pass NULL for
> bs_name, and then add_bitmaps_to_list() would need to fetch the node
> name again.  That seems redundant to me.

I mean something like

    assert(!alias_map || !strcmp(alias_map, bdrv_get_node_name(bs));

I am afraid of interfaces with redundant parameters, it seems strange
and unsafe to pass node_name together with bs, which has bs->node_name
which is (and must be, in case of new semantics with alias_map) the same.

Still, I don't mind keeping it as is, I can think of some refactoring (if any) later.

> 
>>> +
>>> +    if (node_alias[0] == '#') {
>>>            error_report("Bitmap '%s' in a node with auto-generated "
>>>                         "name '%s' can't be migrated",
>>> -                     bdrv_dirty_bitmap_name(bitmap), bs_name);
>>> +                     bitmap_name, node_alias);
>>
>> OK, this should not relate to mapped case, as aliases are well-formed.
>>
>>>            return -1;
>>>        }
>>>          FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>>> -        if (!bdrv_dirty_bitmap_name(bitmap)) {
>>> +        bitmap_name = bdrv_dirty_bitmap_name(bitmap);
>>> +        if (!bitmap_name) {
>>>                continue;
>>>            }
>>>    @@ -302,12 +486,24 @@ static int
>>> add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>>>                return -1;
>>>            }
>>>    +        if (bitmap_aliases) {
>>> +            bitmap_alias = g_hash_table_lookup(bitmap_aliases,
>>> bitmap_name);
>>> +            if (!bitmap_alias) {
>>> +                error_report("Bitmap '%s' with no alias on node '%s'
>>> cannot be "
>>> +                             "migrated", bitmap_name, bs_name);
>>> +                return -1;
>>> +            }
>>> +        } else {
>>> +            bitmap_alias = bitmap_name;
>>> +        }
>>> +
>>
>> Hmm, we don't error-out if we didn't find a bitmap, specified in
>> alias-map. But it seems to be an error from the user point-of-view (the
>> required action can't be done).
>>
>> So, probably, we want loop through the alias-map (and in this case we
>> don't need a map, but can work with QAPI list), find corresponding
>> bitmaps and migrate them, and fail if some specified in the alias-map
>> bitmap is not found.
> 
> Do we?
> 
> I don’t consider setting an alias an action request like “Migrate this
> bitmap”.  I just consider it establishing a mapping.  If some elements
> are not used, so be it.

OK. This non-strict behavior is in good relation with ignoring not-mapped bitmaps which I've proposed. We can add any kind of restrictions as an option later.

> 
> I don’t know if doing it differently would actually be beneficial for
> anyone, but OTOH naively it seems like a more invasive code change.
> 

I don't see real benefits, we can go either way, so, not worth rewriting the patch.

===

I feel like a stupid reviewer :)

-- 
Best regards,
Vladimir

