Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49B022D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ey7rRjEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49B022D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bu6-0004BS-2L
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3btL-0003gM-9w; Thu, 06 Aug 2020 05:08:51 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:48805 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3btH-0004Bm-QC; Thu, 06 Aug 2020 05:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6QKEmu8H5QsWqRx9XQGCl6Qj9yYCSfURgqEHXIzRYugDAti+7aRS+nOk9s658IAPrahC+4rzcdQwMoohGAGaYPq0wx7uutqxOcSinzBQXhzjYGlPIRNzMrMPeAHgpcSVf5taitlzv18b6uXqO72LSOUDnxPuytQL3OD0LTFdnzBiH/D2fa2Ubx+KMN+85Bv8ePzBEVfVegJDbhBaIBl6KvRkSUgXcOJhKMeSDE+q3Ccm9lSdcBWDag6XBdjeguyh/KOE/9HMzOkxh/uoC2VGy3Kdzn1D1oXnxQa41y2BypKyeMbAhsXe19ajAftBRJ519dxJWUFFwB47pN6eZ+6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6ee+u5Q5TxwRI7+RGsD2WQaqU7U/7FEJsDba2viR0g=;
 b=kMZRDaNq2n+DV/ZykXQOR4cgdE2Dk05uyN7ROrfxrLJeDmlW91V1l87G8Lm18vZDv73IiSdHjtCHoB74X9wJkpBXbC8CtMvbkmLe2Sul1eWmS1SwHUbcJEWSEerDWyMNLSvpF9vc+/jCSRWlIzUZEZ+R8aGOwHmUgMs6x3eH+4dYNjJ2JigBmV1mUdgZYv9EJS/AkLTEh6tfV720QavXlmVqSfRawwL9QKisJb9keZ8Pw/ktT73iN3BywhaqvQJt32Mxot1vZU81X9d3PT0GG+2uRg1hiI4d7l+YLSQwSBzpHQFyBN64DmkFP/lDQ/iZuEKzvEYXj3vdvLOhoBDRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6ee+u5Q5TxwRI7+RGsD2WQaqU7U/7FEJsDba2viR0g=;
 b=Ey7rRjEnbVio8GROmCo/0SfUlVZ7PpMEK2dPIuSVZYuAF8ETobhITZNIluPwm/Qz+6Uxl7Qz+hEbfl5u8ffNK///dJ9S7PYXZ2HYOLFrH7RZof7BUvMaIf6iCDcvhL9+IRWiWTWI/wpzL0FtgotSbMb4pAEZrVu3TNkPgZtkE/w=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2619.eurprd08.prod.outlook.com (2603:10a6:3:d9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Thu, 6 Aug
 2020 09:08:43 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3239.023; Thu, 6 Aug 2020
 09:08:43 +0000
Subject: Re: [PATCH v12 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4aff9a66-89e2-2a66-e9d5-46a7e9d650fc@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9a56462e-fc51-5438-13c7-ab1c687a86e1@virtuozzo.com>
Date: Thu, 6 Aug 2020 12:08:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <4aff9a66-89e2-2a66-e9d5-46a7e9d650fc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0088.eurprd07.prod.outlook.com
 (2603:10a6:207:6::22) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR07CA0088.eurprd07.prod.outlook.com (2603:10a6:207:6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Thu, 6 Aug 2020 09:08:42 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 849ad083-09d6-4aa3-7fdb-08d839e8512b
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB261960FBD98DF76C35A52AFCF4480@HE1PR0802MB2619.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICjBVDFclE07NLW27Ndu/yj9fBjXbso8BrGBuPjVJqEadfGEkuPS51K60RT4JkSb1Td5csryMaCjHEhWE4406Jdd/1rh3WrpDdlhzuFmj1y2ct4EJJTdLG9/qGSDbpmkBJwhfoZdyVPXcBK7liamYcBz6X2axyodzjoA0E6EUznUqAYW+vknGr7MEEhppXYSLnje+pr1RwpFD+RmSM5TJZp4/JSCueU5pnVT1c8OoTn5U9COMSIdMBFbbLYJ6JOkY194wQ3vs48oTSkneuxRkfjejcA9qlIRUmhZLJdaVqoBCiINdSn22mxQH3B1FMXiRFiFsztK2D1LOG8q+7L1LfR2Qj/317Z4H5lxOqmf2xO2bVuRnGlP5U1dgdwan8mc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39840400004)(8936002)(478600001)(31686004)(956004)(316002)(44832011)(2616005)(83380400001)(2906002)(52116002)(4326008)(53546011)(6506007)(36756003)(16526019)(26005)(66946007)(66476007)(8676002)(6512007)(186003)(107886003)(66556008)(86362001)(5660300002)(31696002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JXQ//k+0Pck39FN3EckCFKadLkq7CuaColFDC/ouseT1wEQg6Q5capxImT/D4dKmGll6/63jQ++z3amanXB9JJKMWdP2FNAK7yL2OD6A6rjrDyFeA+OSL7xs8xWSV0bD6iw0NF/03hprtFuKIreEzoC0Ur1cvocMKQAnC24MB907mwIOaH0gVAn6ogWW4VYGwUSqepqulVlnRtDhmsXYYSeoFx5xhkqJmfGy3Ko15vTbvQBg1hm4GPjP23yAK1mZfKIvKW17J85zy9IjfMidoomAbhwMgHGHJA2QGDCjENXASd42WelOl8k0yRVb68heaJvWeaHIOP3dBKtH9/+pOIVY4Lsai2L8rVzy479zrvx9Iq9RFwFeOX0G+/pMLS4qVnO+YTH3vvaz8mQKpNtyU0pX8aP4hObYPd5nWgq0xA4DgmnlPzMIUd9GjyMLPBHlAEJDGkGggOqV9P07C76lAmES7+fS4WKLx9eK4EooerUxhi4RSoJES1sH5sEs04qI7GCPmQFVzcl6OBJB5uXH65lhrXQhm6Sg89Ojql88q+ZClfEzaD9AXfL0YuhbqGCWNGbGATwQ3B90SSTzDCpvsS720jY7nSE0EiImhwAAVf9voBTVLRDI5fg5g//pXmpC5uZeNlgtd3cfMruSEzdaNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849ad083-09d6-4aa3-7fdb-08d839e8512b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 09:08:43.4254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+jhDqBA/faiQGMOpgnRXj9OnpAlGLQMGqcR7lx5ODQ8jJ/OX1Ea+u51nxZZrL6z+9227m0VkhrIhKcW7i3MjbirgpvRskDil2YND+XLoW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2619
Received-SPF: pass client-ip=40.107.14.112;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:08:45
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

On 05.08.2020 19:58, Vladimir Sementsov-Ogievskiy wrote:
> 30.07.2020 17:15, Andrey Shinkevich wrote:
>> As __dict__ is being extended with class members we do not want to
>> print, add the to_dict() method to classes that returns a dictionary
>> with desired fields and their values. Extend it in subclass when
>> necessary to print the final dictionary in the JSON output which
>> follows.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 34 
>> ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index 2000de3..a4114cb 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>                 print('{:<25} {}'.format(f[2], value_str))
>>   +    def to_dict(self):
>> +        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)
>> +
>>     class Qcow2BitmapExt(Qcow2Struct):
>>   @@ -151,6 +154,11 @@ class Qcow2BitmapExt(Qcow2Struct):
>>               print()
>>               entry.dump()
>>   +    def to_dict(self):
>> +        fields_dict = super().to_dict()
>> +        fields_dict['bitmap_directory'] = self.bitmap_directory
>> +        return fields_dict
>> +
>>     class Qcow2BitmapDirEntry(Qcow2Struct):
>>   @@ -189,6 +197,14 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>           super(Qcow2BitmapDirEntry, self).dump()
>>           self.bitmap_table.dump()
>>   +    def to_dict(self):
>> +        fields_dict = super().to_dict()
>> +        fields_dict['bitmap_table'] = self.bitmap_table.entries
>
> the fact that we have to access internals of bitmap_table is not nice, 
> but let's refactor it later.
>
>> +        bmp_name = dict(name=self.name)
>> +        # Put the name ahead of the dict
>
> Aha. I don't think that ordering is necessary for json, but why not to 
> order it a bit.
>
>> +        bme_dict = {**bmp_name, **fields_dict}
>
>
> strange to create bmp_name dict just to unpack it. You may as well do
>
> bme_dict = {'name': self.name, **fields_dict}
>
>> +        return bme_dict
>
> bme_dict is extra variable: it's created just to return it, so, how 
> about just
>
> return {'name': self.name, **fields_dict}
>
>
> or, maybe
>
> return {
>            'name': self.name,
>            **super().to_dict(),
>            'bitmap_table': self.bitmap_table.entries
>        }
>
>> +
>>     class Qcow2BitmapTableEntry(Qcow2Struct):
>>   @@ -214,6 +230,9 @@ class Qcow2BitmapTableEntry(Qcow2Struct):
>>           else:
>>               self.type = 'all-zeroes'
>>   +    def to_dict(self):
>> +        return dict(type=self.type, offset=self.offset, 
>> reserved=self.reserved)
>> +
>
> Python has a special syntax for creating dicts :), let's use:
>
> return {'type': self.type, 'offset': self.offset, 'reserved': 
> self.reserved}
>
>
>>     class Qcow2BitmapTable:
>>   @@ -246,6 +265,9 @@ class QcowHeaderExtension(Qcow2Struct):
>>               0x44415441: 'Data file'
>>           }
>>   +        def to_dict(self):
>> +            return self.mapping.get(self.value, "<unknown>")
>
> aha, so, actually, to_dict() returns not dict, but string. So it 
> should better be named to_json() (and return any json-dumpable object, 
> like string or dict)
>
> and then, we can add to_json() method to Qcow2BitmapTable as well, to 
> return list.


So, should I refactor it now?

Andrey


>
>
>> +
>>       fields = (
>>           ('u32', Magic, 'magic'),
>>           ('u32', '{}', 'length')
>> @@ -308,6 +330,18 @@ class QcowHeaderExtension(Qcow2Struct):
>>           else:
>>               self.obj.dump()
>>   +    def to_dict(self):
>> +        fields_dict = super().to_dict()
>> +        ext_name = dict(name=self.Magic(self.magic))
>
> strange that we have to create Magic object here... Ok, let's refactor 
> it later
>
>> +        # Put the name ahead of the dict
>> +        he_dict = {**ext_name, **fields_dict}
>> +        if self.obj is not None:
>> +            he_dict['data'] = self.obj
>> +        else:
>> +            he_dict['data_str'] = self.data_str
>> +
>> +        return he_dict
>
> again, let's avoid extra dict variables:
>
> res = {'name': self.Magic(self.magic), **super().to_dict()}
> if ...
>
>
>> +
>>       @classmethod
>>       def create(cls, magic, data):
>>           return QcowHeaderExtension(magic, len(data), data)
>>
>
>

