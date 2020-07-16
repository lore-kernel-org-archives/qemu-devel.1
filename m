Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFCA20739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DQ1sTDKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFCA20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6Ro-0007eB-VS
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw6R7-00070T-F1; Thu, 16 Jul 2020 12:08:41 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:32992 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw6R2-0006cx-Je; Thu, 16 Jul 2020 12:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTi64/m2xNPNNRV1qPwOVS72KaKuCtg99kI+6Um/sN8TNmnKbAmE+x90hP1Gcm0Dvi9jXTTyNMr/yyBrmOeoa8k6AJCxb0EzHo1+qOOAVk2iw2L2pXLLSlnDsr7xltTJQ9RfBix56hhuJM9vfYfPRtcZ8mG+Tr2iojVSef4GLk5WmK/8CVJ6/NZG+ezPEKKEBkEeOieNwUd+wBQGTioLObIatMBsWe0l3Xm6WbOrnWNoxFsOcq47HpkyokRTKWRneAE86dc29nLlPH/ttRldxRgZmd+1DWnV+qatDARjHz1I0Xm0eNCKXiIXYOBb+LU4Ep04I5eSVmDaczDQuRmGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DMMwwE8tE993B2nb6AR25/Qu+6SNYV83QPTYvc3Ud0=;
 b=LyOyI1PusDMTPHn7MNTe85pyBR7rYUeCxKiqTY8veyQWmMKbS6nVtDGQ+8UWn9XVfRszl8eBuIo758E13/mRJor4idxTizxuw4ZWk0fLbXf4XX9hW2KTm7WWC2ls8Lc6RSRvIaBvyqSoTTVQZmXo7lMZLZs2RfBD+Oi9DtuUaB1BxYJGvY4pqMkjqGGmgz8dvK7WIMYLGUDWd6JoyIX2WKCsJPLF5IaxYkOi7LF0GsUxthEYG4q6DMnqv3381a8L7eqQn8/7sp345wqs2lES5zcqpgdwYsBNurhxGOPFfaK91AkD1IYHwtuO7LxdVdfE9pr9m0eEuHrqwUVjVtRK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DMMwwE8tE993B2nb6AR25/Qu+6SNYV83QPTYvc3Ud0=;
 b=DQ1sTDKWxu6Wmn7zc1vXo6L0UY+MiszQQo3FuLwinTAxXOMhDiB2Lae0235q8mG6er/2z0eWD2zksOsrXQ7IVHrSETh3IeDB/mw/Wq7XlMN/obsJz1qkE96VAsDeD0LhPj3vMpuUrKYmgDiWqW9apxu0ACx2V7Z7OGLXuzTpcZs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5032.eurprd08.prod.outlook.com (2603:10a6:20b:ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:08:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 16:08:33 +0000
Subject: Re: [PATCH v10 09/10] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
 <3e22fb08-2fd1-c0bc-8b83-2ded1a090720@virtuozzo.com>
 <77d809ff-d42d-55ee-b65d-c5fa69dcc394@virtuozzo.com>
 <225afe71-36a5-803a-97f9-4f2eb3f355b9@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <50904a8c-8116-fb28-6115-2f1762677820@virtuozzo.com>
Date: Thu, 16 Jul 2020 19:08:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <225afe71-36a5-803a-97f9-4f2eb3f355b9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR01CA0093.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 16:08:32 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd8cdb8-f4ea-4710-e274-08d829a27cd9
X-MS-TrafficTypeDiagnostic: AM6PR08MB5032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50328F7AB35E1284D85A6FA5C17F0@AM6PR08MB5032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hx/5dNltFKPdfdJzGMgbwi7Qmxg/jDSx4UjCzql3yXND+jpE19EapecbPGaUJLJfY+rQqhMYN+z++PFboa9iREJRutNg0p+UDXr9Ol4xU17/+xRnP0AlYDtcBD+jgFeroWMS31F+/UCe8PRquzcMnhKfzmF2a+8pIE1cCjHyMwq0DBupMu8mHfZT28z+4X8XvCynD2GRZDLPbfjumbNEV7P9S2Z43atfWnDKWVkc9W/MCUBizoOEBklTRDyP9tvvRSIWKn4MYS/G7FJAIDfQi43E0KRVwy1kmP7j2w9p3gslL25MPX6qmVXNfJNWYWiaB86CpVKHp4vylOxicNCFHRCx1DTdGRZRih+jqRemLrK3LwvWvXqU+7rtrwgQnHdL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(366004)(376002)(346002)(316002)(16576012)(53546011)(5660300002)(66476007)(66556008)(52116002)(186003)(8936002)(66946007)(2906002)(8676002)(16526019)(26005)(31696002)(86362001)(36756003)(956004)(107886003)(478600001)(83380400001)(6486002)(2616005)(31686004)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EcqIWJoPsATRfiLqOTlaslTesyBjYDZwONiLvQ0x8ES1gDXrg0xMPwtah87pN9eTosZRcF6ihT/E8Cr7R0eThjw56wFWK2eOVdioyrP6/FtoQ7KFRANmwpuDV4GyICDp6pwcntjw/oZzfEHOnY8fscPTl7/O6JhuC9/KbZMBqYRofF6QYAHpqrzD3HCMS9JCycn7LO1llf30vpcbepiIDhJ/p1KysznVprSyAsaELxieM2cPDpepZPXFU6NXxZpDcBkxDauNDzdWpGvphy+AXWeDB5BEUWTxdIrDbEbZfa6wLz/M1Il0fLXdZfmPsScBg8ioLABHV9Q36azSgRWLVujca4Gsy7HkN70+2tvfcYdCGEBrYF1lMsJ244uV2ZUsCDz8pToX3lyZomIs9SrtLHM/uMyqlsKZIpbQFP3rm77mxGDx/tc1oPUksgRyIzqnYbAFbtiaisje49q1dILHRiJgu0coRnPx/dEqb31Lf8l9zDbu34VRF5yY9ipmye7q
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8cdb8-f4ea-4710-e274-08d829a27cd9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:08:32.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6ZFaevaSEzMmdtsPFiZiQGto6+tc8RgH0pHsWrRcC4UsV5hzWLJUdVh58A0cqzuxluZG1utIh7kjC5t+OwEBATwCrYTVCpIAGVfKm5oHVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5032
Received-SPF: pass client-ip=40.107.22.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 12:08:34
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

16.07.2020 18:52, Andrey Shinkevich wrote:
> On 16.07.2020 18:40, Vladimir Sementsov-Ogievskiy wrote:
>> 16.07.2020 18:34, Andrey Shinkevich wrote:
>>> On 16.07.2020 13:24, Vladimir Sementsov-Ogievskiy wrote:
>>>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>>>> As __dict__ is being extended with class members we do not want to
>>>>> print, make a light copy of the initial __dict__ and extend the copy
>>>>> by adding lists we have to print in the JSON output.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>>   tests/qemu-iotests/qcow2_format.py | 4 ++++
>>>>>   1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>>>> index e0e14b5..83c3482 100644
>>>>> --- a/tests/qemu-iotests/qcow2_format.py
>>>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>>>> @@ -109,6 +109,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>>>>           self.__dict__ = dict((field[2], values[i])
>>>>>                                for i, field in enumerate(self.fields))
>>>>>   +        self.fields_dict = self.__dict__.copy()
>>>>
>>>> No, I don't like that. Keeping two copies of all the data is bad idea. If you want to select some fields, add a method (dump_json() ?) Which will collect the fields you want in a dict and return that new dict. But don't store object attributes twice.
> 
> 
> That is what I did in the versions before but it looks clumsy to me. Every single class lists almost all the items of the __dict__ again in the additional method.
> 

Most of them should be listed automatically by base class method, which will iterate through .fields

> 
>>>>
>>>
>>> Not really. It makes a light copy that stores only references to the desired fields.
>>>
>>
>> I'm not about memory consumption, I'm about the design. Keeping two representations of same thing is always painful to maintain.
>>
>>>
>>>>> +
>>>>>       def dump(self, dump_json=None):
>>>>>           for f in self.fields:
>>>>>               value = self.__dict__[f[2]]
>>>>> @@ -144,6 +146,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>>>           self.bitmap_directory = \
>>>>>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>>>>>                for _ in range(self.nb_bitmaps)]
>>>>> + self.fields_dict.update(bitmap_directory=self.bitmap_directory)
>>>>>         def dump(self, dump_json=None):
>>>>>           super().dump(dump_json)
>>>>> @@ -189,6 +192,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>>>>           table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
>>>>>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>>>>> cluster_size=self.cluster_size)
>>>>> + self.fields_dict.update(bitmap_table=self.bitmap_table)
>>>>>         def dump(self, dump_json=None):
>>>>>           print(f'{"Bitmap name":<25} {self.name}')
>>>>>
>>>>
>>>>
>>
>>


-- 
Best regards,
Vladimir

