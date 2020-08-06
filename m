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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB75C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F274B22D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vv02orK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F274B22D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3c40-0000Ed-8G
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3c39-00085d-9O; Thu, 06 Aug 2020 05:18:59 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:64385 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3c31-0005Kq-PP; Thu, 06 Aug 2020 05:18:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW6+DYoEApwMgGVR2WFITJ9xSbYu3biebpKxlhfdqn+bx4BZ0XvSoBSAQx1+lidZ/xGMJYh4ml1ic+9G+X0EMoYmITEIM4RNL4Il+jihDv07KuJgiJeoYKwsPaA9zxyLB2enE3XiNOssRhVt9L9TMtFxXMb9FEd8rhwblJbp6+Tyc9J3e86sXYMys41VjdWBHpv6UhiUChYSWocNJ1teb/DhH0p4dyEosAtvJXNIuH6khdMvqusEeCdgcM7EjsxcGeSL50+ORGX9G+BSCfH9wG9AexCiAbjhR40jKbRIjawahDoAAokBeeMTlwns48/9u6qi7TWiUDMTRUiocBl7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHTuuWxCcH0WfsooGlNpL11S9USKlcdsS0uPcanB2ew=;
 b=OzwgHsMb/l5kOLAqj0F2hTql4zrDWC4NYzbCKfAsuxdZEXFLR/RhUXhZy9aE85oaioz8jUeHH+5bo3yMVwOL5HR7ewc6C9o0Qa/EOfGBM7sootLr+vx4IqqxA5yz66JlM32hlhmLKY4uk0nw4nwnTAjtoVOvpqAasT7zKZJhWMdox1lRw0ji9U+aixFHCKq8+nLTgC8a08ItTd6uki6fKKoDG5jWcufiFG2dy+6nhKolsyzTFSg6MG9MThyNlPoT5fEukVb5SkDIb9OnqX+iFoljan2aQ6as3jID8FpKdWUmaZ1sXDhjJ0Xix9dTSGa3BEj4SMXkGDaSAXlKNnCLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHTuuWxCcH0WfsooGlNpL11S9USKlcdsS0uPcanB2ew=;
 b=Vv02orK+GvvTvutsSKjLE1iAw9j0mxnuv42y6p2khemJ4CaYGG0IDW+a6VhMOcdwLeNnAlIMi+oB7Nwt9qch0n9oPh+r9cBryMnt6o3o7lDMBDXxJIQY/SkeUGEh8YFf8TbqzCwpja33ae4vMd3Cb+8oQO9DEMcNkPbepazfucA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3895.eurprd08.prod.outlook.com (2603:10a6:20b:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 09:18:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Thu, 6 Aug 2020
 09:18:46 +0000
Subject: Re: [PATCH v12 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4aff9a66-89e2-2a66-e9d5-46a7e9d650fc@virtuozzo.com>
 <9a56462e-fc51-5438-13c7-ab1c687a86e1@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4235bf3a-b85f-50fa-b489-3aa52c89d5a5@virtuozzo.com>
Date: Thu, 6 Aug 2020 12:18:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <9a56462e-fc51-5438-13c7-ab1c687a86e1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Thu, 6 Aug 2020 09:18:45 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99df7fe7-d1ce-4f2e-8db8-08d839e9b8ca
X-MS-TrafficTypeDiagnostic: AM6PR08MB3895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3895C17E03036C2CB0D939A8C1480@AM6PR08MB3895.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UleFijxM/qvvlC8AB6wiSMYWaYpcu1UwPvLvtSNCbrHrAde96HN6zyrUHsPd6kmlCSXYpeLVe6gLONJBdPdOfkYGXIvi95T5rUYXt9fDoaIlo1m3/GxoX07x2rxN8l+NTN+A40g1A4+Qwebld/Ryvc+HIl7ZdzCge/TEn+3Eo3DPoFR/wiwACaATKo+nWEVz4yPVYS8woZjWbYNSlrPnTlnqxS7BeWaVC3K1EzaCUfYVQ+OXBV4f23qc8w5DBMGpGWVuOgxPHoGSFllCmm7fn92QLhFiYaK37yRhnssfzZrkOHhuyKPqtkoIL/uOZdxgjZHjbinN5D4zDFPTiOh+oqYTXru+VTTj53ogrn6eMoi0GraExPr2Bbnj2cPTSw0b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(136003)(366004)(376002)(396003)(16576012)(53546011)(16526019)(8676002)(107886003)(83380400001)(6486002)(316002)(478600001)(5660300002)(52116002)(186003)(2906002)(26005)(31686004)(36756003)(86362001)(66556008)(8936002)(31696002)(956004)(4326008)(2616005)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DJahSPOLrl+BhiFPnBeoLLjEY8ZfLxpLaOdSqtGLSy69nTqjRX61RK5CloRHbhQjupCcFq6eJVV+4f1JN5BPJyOLVhdj3PybO+wWmCvoGbzZHl7Ks6MxviOax9NV2dv1JUoi2iA9pb5kNxKaSBkD37yoZ3/liMUIFS3F1iaFvFSSHZRVqS9S9bLCA4RvONFjUQ2XuhPqt2Bs+gdNY3Ihq++cj3toB7iFzgJOHLHgET92LyfqC7W8vLat6MzcF5JVfIWbNDBU1fxg/wMiUCJ9t77Ui6J8aMHiASQZ4+fkKFwGYskBCyv7tm/uaxmy2GPYwa1kGrgpJSBUy18wve8QQdW3xnuSNwz5+1KSgnAloTbiy6HcJ1zF86IDW6mNrfihdvM0w/o8GXw0K9P4pAjOM53JxT1nrQNdZIWdZW0vA/Uwx8zpDvQFEFhKreecTF49/YcST8pnNqBXd7XXhzUi9rF4gMrWvltMYiHGFt5nYY96/Fa59sM6u5QDu6r69X3zCvAjdn/uw/cVHopRQXs5a8j4eXsxAyJdmvrRikBVqEB48rGEBhn8La9P1Rk+jn/foV556hYolDdWt50HjYFehziYg5RuA5CjbowYO1P/2HvIaAQKRUm/SCgtFq038GQEM8bCyWV48MJsFnorHdxjvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99df7fe7-d1ce-4f2e-8db8-08d839e9b8ca
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 09:18:46.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZzQXB1U6uGfR4sHIGYgzaudWLQGcmkClwnisAwkZdXK88ScqxYbIAbY2Yiz7WgerdkLx8twtGPLKgfnmElO2uojTF3zrP5pT5VGzxP+p/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
Received-SPF: pass client-ip=40.107.1.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:18:47
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

06.08.2020 12:08, Andrey Shinkevich wrote:
> On 05.08.2020 19:58, Vladimir Sementsov-Ogievskiy wrote:
>> 30.07.2020 17:15, Andrey Shinkevich wrote:
>>> As __dict__ is being extended with class members we do not want to
>>> print, add the to_dict() method to classes that returns a dictionary
>>> with desired fields and their values. Extend it in subclass when
>>> necessary to print the final dictionary in the JSON output which
>>> follows.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2_format.py | 34 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 34 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index 2000de3..a4114cb 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>>                 print('{:<25} {}'.format(f[2], value_str))
>>>   +    def to_dict(self):
>>> +        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)
>>> +
>>>     class Qcow2BitmapExt(Qcow2Struct):
>>>   @@ -151,6 +154,11 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>               print()
>>>               entry.dump()
>>>   +    def to_dict(self):
>>> +        fields_dict = super().to_dict()
>>> +        fields_dict['bitmap_directory'] = self.bitmap_directory
>>> +        return fields_dict
>>> +
>>>     class Qcow2BitmapDirEntry(Qcow2Struct):
>>>   @@ -189,6 +197,14 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>>           super(Qcow2BitmapDirEntry, self).dump()
>>>           self.bitmap_table.dump()
>>>   +    def to_dict(self):
>>> +        fields_dict = super().to_dict()
>>> +        fields_dict['bitmap_table'] = self.bitmap_table.entries
>>
>> the fact that we have to access internals of bitmap_table is not nice, but let's refactor it later.
>>
>>> +        bmp_name = dict(name=self.name)
>>> +        # Put the name ahead of the dict
>>
>> Aha. I don't think that ordering is necessary for json, but why not to order it a bit.
>>
>>> +        bme_dict = {**bmp_name, **fields_dict}
>>
>>
>> strange to create bmp_name dict just to unpack it. You may as well do
>>
>> bme_dict = {'name': self.name, **fields_dict}
>>
>>> +        return bme_dict
>>
>> bme_dict is extra variable: it's created just to return it, so, how about just
>>
>> return {'name': self.name, **fields_dict}
>>
>>
>> or, maybe
>>
>> return {
>>            'name': self.name,
>>            **super().to_dict(),
>>            'bitmap_table': self.bitmap_table.entries
>>        }
>>
>>> +
>>>     class Qcow2BitmapTableEntry(Qcow2Struct):
>>>   @@ -214,6 +230,9 @@ class Qcow2BitmapTableEntry(Qcow2Struct):
>>>           else:
>>>               self.type = 'all-zeroes'
>>>   +    def to_dict(self):
>>> +        return dict(type=self.type, offset=self.offset, reserved=self.reserved)
>>> +
>>
>> Python has a special syntax for creating dicts :), let's use:
>>
>> return {'type': self.type, 'offset': self.offset, 'reserved': self.reserved}
>>
>>
>>>     class Qcow2BitmapTable:
>>>   @@ -246,6 +265,9 @@ class QcowHeaderExtension(Qcow2Struct):
>>>               0x44415441: 'Data file'
>>>           }
>>>   +        def to_dict(self):
>>> +            return self.mapping.get(self.value, "<unknown>")
>>
>> aha, so, actually, to_dict() returns not dict, but string. So it should better be named to_json() (and return any json-dumpable object, like string or dict)
>>
>> and then, we can add to_json() method to Qcow2BitmapTable as well, to return list.
> 
> 
> So, should I refactor it now?
> 

Up to you. Better yes if not difficult


> 
> 
>>
>>
>>> +
>>>       fields = (
>>>           ('u32', Magic, 'magic'),
>>>           ('u32', '{}', 'length')
>>> @@ -308,6 +330,18 @@ class QcowHeaderExtension(Qcow2Struct):
>>>           else:
>>>               self.obj.dump()
>>>   +    def to_dict(self):
>>> +        fields_dict = super().to_dict()
>>> +        ext_name = dict(name=self.Magic(self.magic))
>>
>> strange that we have to create Magic object here... Ok, let's refactor it later
>>
>>> +        # Put the name ahead of the dict
>>> +        he_dict = {**ext_name, **fields_dict}
>>> +        if self.obj is not None:
>>> +            he_dict['data'] = self.obj
>>> +        else:
>>> +            he_dict['data_str'] = self.data_str
>>> +
>>> +        return he_dict
>>
>> again, let's avoid extra dict variables:
>>
>> res = {'name': self.Magic(self.magic), **super().to_dict()}
>> if ...
>>
>>
>>> +
>>>       @classmethod
>>>       def create(cls, magic, data):
>>>           return QcowHeaderExtension(magic, len(data), data)
>>>
>>
>>


-- 
Best regards,
Vladimir

