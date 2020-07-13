Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7066DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1342067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SCK8HjvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1342067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutuw-0005UD-I3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juttn-0004Lc-JT; Mon, 13 Jul 2020 04:33:19 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com
 ([40.107.14.101]:62436 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juttl-0007eL-04; Mon, 13 Jul 2020 04:33:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Gv5tWbOMxEK6dfblestwAXvk0fMkrudLDYcvnRJisd/ktWG/JCMnNUtOcfX2GidNC9I8AiBDRAjVYs/IUx4gFFGcRu1l1Jvuk9Z1kFkB20LUbVlrO9hnJ4Bo7sEQaV2l8h3TEFURvidmcE6nva+6FtVeRVYb/wrUGT4ICInIRZK1Wp+WYQMw5YzdP6SZoUzxvXTmtqRxPnQM/flkZRHDwSw4gCIIbKmUDjMUIdG2wekwsy78S5I2ykNveX8RUU6qoq8YPzkiNh+/yMn5zyFXr2trPmLOQR0TH29ifr3pcuHYUoruxAtnRtcVCHt4ngyFwfzv1sy/6NN42DF3TW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc1wHlf6I5e/FKZYOfU4o4ah7tspW0maC+3M6zORcxI=;
 b=Yuoukr90QoqWwv0rbmuR3r4n8knJL8hBfZ2zKD+2CrQv+g901b5p4b5s1aBeh6otjo84S+NFaBoSPpdfh3/LeOOw5I1MnrRvRmE9IMCwFYebkficdL0Rbr1EHoJrmEzosamNdNiaRonP2h3qmuSlkovNquFa2M6yKdn2Gmp/AqtoUsCfYDPQjXNyc+EEsg8/7Cuq4+bNeX0/l/TPpGSEKbRXgMfbWbOdunb1Yina4gpY5UlaokT9/nLrR426lio0Ki4cefs8rsRjsGvGiDRJ32NVWlzZiYaYDRd6tT91LRGvlm7covjNdqD1RqUo/jXhl+IKiPDz8Tg7GqSBtEjwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc1wHlf6I5e/FKZYOfU4o4ah7tspW0maC+3M6zORcxI=;
 b=SCK8HjvMviRyktp/dnWgbFjUUXONlt9PCXe+lGQPKzIMr5ia01zhMvYAXSTy0GjAzB/yZX7cRzoZXRX5SYmnWn1aGpVdiazeBpCXEYw+20IUSoDHsuu1pDHvM+/0tdFrHzzEMdWePvdV9vkfk3AKvCxcJGUCodHOSqkC0YSmlwY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 08:33:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:33:14 +0000
Subject: Re: [PATCH v8 03/10] qcow2_format.py: change Qcow2BitmapExt
 initialization method
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e10319ea-0a60-3585-8b36-92783dba3862@virtuozzo.com>
 <8f214a44-f8af-b79a-4a62-e5803ccc81bd@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8dcd8e6b-0452-20a9-db08-847747cb9fcf@virtuozzo.com>
Date: Mon, 13 Jul 2020 11:33:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8f214a44-f8af-b79a-4a62-e5803ccc81bd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 08:33:13 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd6c2b4-7dec-4170-f1ef-08d827076222
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850F1353C5D2D7B40D87F9FC1600@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJLN9w4M5Lxgmd/VmFsHoim7iuG/Ra+7iYciuDsJS91TTFCCxrb4z5C6+DChL8HNwlEGEtbza55BUqMLx7P34vBrqheNIvq6O2gHairX2f+8PfTIPo1FKQOsZC6FiyCd/w2Wwg19z400W2b6zSFG/F3l8iETgEgRv6mLdUOiLY4oIVuAaQh8Hl4iXa5aUGZYoUpn4q4PIMCjXqV4cYaPh6Fi8MdIUltvUkao5C23ydb5/8lKkqO1l6JydQUsimxJDNagLRVAIA/QiFyODFOIIF53LKUbSxWR/8Szwk4tD4zrQSoLcwmAJz3FHZL85Zb+Z70E8kUoSNtSYK17ZLXBiX/xHJfT2tnw5+T98p/xEg3WE4Q77QAyL+N7bd79N8fZUSk3xChTZqqQ1Kjw+9UqyJ7Nj/pyCaSQbdRXCSvV4cCa5/CwlQ3Di8bH3aVmDCpsRlFYpV6NpmmSnBj6mmoU8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(346002)(376002)(366004)(136003)(83380400001)(26005)(5660300002)(107886003)(52116002)(8676002)(31696002)(66556008)(316002)(16576012)(53546011)(8936002)(86362001)(66946007)(66476007)(6486002)(478600001)(2906002)(2616005)(31686004)(956004)(36756003)(4326008)(16526019)(966005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4HrKGqWukpMUSajz9TgK3srF8wftPVaYtI5fwY41m6ZBREE/xAGhPdeds7Qse76ylcN5s6HUo0zZNsEJUBlKjNzCWDZTsLtrs/2yP7EsVqRYQU+56o+xg8fXsFo/iRWEKZh3Ayk+XVz67KywB8PFViMcuu6h1CGg8L4U4Ik8DbLxhpU11RmsuNiwZsdhx9es21Q7VlG/zI4RKCeneJk5CjIhCJL2I9l3bOmhcfzg635/CXl1XA4FoUwVkdrSFvqpfC6gHqR/+rHv7Gxg7keBQ+2wzssDCrSRvJ363lwakd7opqyqcUs4/n1T63MNFkwTXds9lnzU9uDcWaNHFsVyBFnO1kQl2XgZ42m2WpTGOYIJmqBaCy+0kd84Tf9SizXDzlN05WTaziEdbO8nxr00Imv7bpiFiysZW/84rtHavonb6U2IjKE02x312ce6GiMGtNzJTLnBhRjgewAON96vkxf6KH3Jv+VOat69t5IKmIRkRe7dNPxAY6Tl2U9ulzhj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd6c2b4-7dec-4170-f1ef-08d827076222
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 08:33:13.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRYicsoxVrBRM/m3zQjcE7EC2e5iLWgASwwd5HH2JseSq5E4Uaf7QNpKKGecpIWa3DTGxuuvGeV9RKZW66i1zkQS7bwDKGeW8HZds5DzdCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.14.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:33:14
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.07.2020 07:49, Andrey Shinkevich wrote:
> On 11.07.2020 19:34, Vladimir Sementsov-Ogievskiy wrote:
>> 03.07.2020 16:13, Andrey Shinkevich wrote:
>>> There are two ways to initialize a class derived from Qcow2Struct:
>>> 1. Pass a block of binary data to the constructor.
>>> 2. Pass the file descriptor to allow reading the file from constructor.
>>> Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
>>> support a scattered reading in the initialization chain.
>>> The implementation comes with the patch that follows.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2_format.py | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index 2f3681b..1435e34 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -63,7 +63,8 @@ class Qcow2StructMeta(type):
>>>     class Qcow2Struct(metaclass=Qcow2StructMeta):
>>>   -    """Qcow2Struct: base class for qcow2 data structures
>>> +    """
>>> +    Qcow2Struct: base class for qcow2 data structures
>>
>> Unrelated chunk. And why?
> 
> 
> To conform to the common style for comments in the file as it is at
> 
> class QcowHeaderExtension::__init__()

It's OK to additionally fix/change style in the chunk where you change some logic anyway. But changing style in another places - I think it doesn't worth it. Remember that it may make patch porting more complicated for nothing.

And this is not only my position, https://wiki.qemu.org/Contribute/SubmitAPatch directly statates it in "Don't include irrelevant changes" paragraph:

     In particular, don't include formatting, coding style or whitespace changes to bits of code that would otherwise not be touched by the patch.

> 
> 
>>
>>>         Successors should define fields class variable, which is: list of tuples,
>>>       each of three elements:
>>> @@ -113,6 +114,9 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>           ('u64', '{:#x}', 'bitmap_directory_offset')
>>>       )
>>>   +    def __init__(self, fd):
>>> +        super().__init__(fd=fd)
>>
>> this does nothing. We inherit the __init__ of super class, no need to define it just to call same __init__.
>>
>>> +
>>>     QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>>   @@ -173,7 +177,13 @@ class QcowHeaderExtension(Qcow2Struct):
>>>           self.data_str = data_str
>>>             if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
>>> -            self.obj = Qcow2BitmapExt(data=self.data)
>>> +            assert fd is not None
>>> +            position = fd.tell()
>>> +            # Step back to reread data
>>
>> This definitely shows that we are doing something wrong
> 
> 
> For Qcow2BitmapExt, we need both fd and data and they are mutualy exclusive
> 
> in the constructor of the class Qcow2Struct. Rereading the bitmap extension
> 
> is a solution without changing the Qcow2Struct. Any other suggestion?
> 

I think, we want to modify QcowHeaderExtension so that it creates/reads its children appropriately. Probably, for bitmaps extension exclusively we pass fd to Qcow2BitmapExt, not reading data by ourselves, and for other extensions keep current semantics of just reading data by hand (or you may add a simple class Qcow2Ext.

> 
> 
>>
>>> +            padded = (self.length + 7) & ~7
>>> +            fd.seek(-padded, 1)
>>> +            self.obj = Qcow2BitmapExt(fd=fd)
>>> +            fd.seek(position)
>>>           else:
>>>               self.obj = None
>>>
>>
>>


-- 
Best regards,
Vladimir

