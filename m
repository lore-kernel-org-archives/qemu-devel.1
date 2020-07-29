Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B001420786
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eBAU6Cu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B001420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0f64-00032f-UP
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 01:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k0f5O-0002Xu-DA; Wed, 29 Jul 2020 01:57:06 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:9193 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k0f5L-0005Jv-7q; Wed, 29 Jul 2020 01:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7rCFPgvh6Xk6+GqLXtDC05Ss/EczNslO827GueHQEHmqfLqkXdiRJwyNofGDn5GY5FVzV9Txg4TMhRP5kZjFNFrS10Z07I3BMjoxM+ql76P4o6CHxmWS5RANzVRExxsg1Qwop8JxDaNXanXZ1d75fjx2d6AMdfCEcFDtzwDEod+KUScxgrfbxx7tpCss2zQY7EyZaeWP2iV+a/dxLgFqcCE3CUNzny3Y8KZ18PeqjNgPmZ6A/8EN/GSeUiLIS24FsMwwRXrkZ64Qfx7LdCT/1I3r0PjzVLBv0hYjOXCoc0J/DU+F7wKIzKzYnfGJijt+S0OQQLCdmPcQ0EKL+RLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/y7iMtIskJvCh0fUwBnCaonSL1BOAS5FwnmvLHHlYQ=;
 b=jKwVuc69RNHMLw+otpvG9cyqwgxETuTpQ2kleuWRU1zVsTQTt0jZG23iNDnpv9yl/SZBkjLKVaDk/n3AzctBjVrp20IEGzrtW70Zil+/ycjhgYEZgaJ5acZViCip4InOGnsR6ZzG7kV5OJycY0i1JcjLqPSYyXZFxsNd6sHDgI+sFGXZZ8sOcFnkXrJVcNr9n+odeNoXrSTLI1kmWCkHH9S98pnqOfhjYyos2FM2lSVYL2YATTx3c6f4DdYkWviGR1ZFnkJuqa2DymeCJvx749CwB+GE5WMy0dCLICrLxy0nZ+ffg0+Z4idgv/cdlFLf8fGWXiF2Jnx6nBv0aeVCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/y7iMtIskJvCh0fUwBnCaonSL1BOAS5FwnmvLHHlYQ=;
 b=eBAU6Cu6gqdciCFzGtdL38VGJUwopdzsoxTHIKXFmp1ltMGPdWWN8v8cGhyCok2gukl34Qi+O0LJbxCJl5DTC1SnpSBJu7Gksp6gBDKErYgaYRXVOmzKt55tTJ3+pQp3TLx0TrFPh1LwOKBbNHcQDkwtn8oXmSG6JtOzEZ0f45A=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4914.eurprd08.prod.outlook.com (2603:10a6:20b:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 05:56:58 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 05:56:58 +0000
Subject: Re: [PATCH v11 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73a45f07-eefa-3489-fb7f-ed888dc559b0@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <77aaf45a-de06-8bea-f283-49249ad3a5ff@virtuozzo.com>
Date: Wed, 29 Jul 2020 08:56:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <73a45f07-eefa-3489-fb7f-ed888dc559b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::28) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Wed, 29 Jul 2020 05:56:57 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d03a75-6ef7-4db2-a45d-08d8338434b1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB49147F2267D632739B0DB8BCF4700@AM6PR08MB4914.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYnqhyT2zxBFI9uMbwlLtLLh9zzX++l2GKMrP1RnKwKqnwaBz4AaxsjBtmBPdL5BN0PouWyFUsH3OrpRgLZycW8gPHmR0/xDeFXmWyNCKgW3iM5oYWjoA+Q6kYAmYjCGw2ixarSMlD9Y/1Pb/Z30EaTM9CJrIok+BgwoeKAYAS91Vz6D1tgNjI98pVDf95MJ2JAbPRox841QSEARwvJT4a1bfhxE3TG1CfZA4ZgLHAsCt/GY6u1xWcCJhhx530GvRtH4TB3oIVc7hQEDWcFgxg0ryzKKfRpdcbccuKBvNJqQqaI4dkZeIM8pTJlcdBHdGMts6oHI8uOezcmyvHL44Si/98gtBFpU8HX2P/b3kzHJneymCrUYW3t6XFgwyrDg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39840400004)(376002)(346002)(6486002)(83380400001)(316002)(107886003)(36756003)(4326008)(478600001)(6512007)(31686004)(8936002)(31696002)(8676002)(86362001)(5660300002)(53546011)(6506007)(186003)(26005)(16526019)(956004)(2616005)(44832011)(66946007)(66556008)(66476007)(2906002)(6666004)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OeCA3IVwPjijW2GSHDtmBAAAPUA4xP4iJr+hIH8BU7o0Te08yI90Mg93pi+ZXdLBC6Xnm1gFFgWgACS+WBPGqR6iz2CLAI+Gzg9h1JTP1OtqyKKfSZJwFOjoaM0bwgWqmzxDM64HNt4lepdcDokKBnNwVMW01Xr/Wr3rfCY1km6RcLh01IpvmLEHKy7G0vWivXA+2PxQOkwrME9YERBofqJX3tkhAXySs7UWqxdqxf8jEtytZIVVuoItg0zfVYTu+7UU7VzfACtxphDRRpdiiJXSOkZumCAY1cvXE9oF4xB0oZsXONQpisY4/au78IFTGtf+Xx39yhJje2qP0RL8OUyqSL9HNT7ypZOl9Vp/O0caWuaXHTL/4ttMd460Vag+XWEflLzIFNRyEkBkGCXZkWypKqZZ7mXkc0562EMgiNh1bAYnyEM2zYXk8AiRQCJBmWwJFdP05tgCqejrkLujjbqSUqz/nIn/M0PYH/F+LIrlMd3axoZGdP4FmTCLMnEw2UUsZnSACVGZ18+x7gnG56cL2iqWwcXM3LemQj45eowqxVEWp1Q3+zGZdZbFmY3AprXRAN91J0Wf3cjXOY2SotT2SxXct18JvPknXt1rDLVJH523JHuDsW7OYxUrzj4UVf7r9bjxzXqx1ZoXBImO4w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d03a75-6ef7-4db2-a45d-08d8338434b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 05:56:58.7091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZUoaFD8wYzxnPZQT6R1eLASBv1jTNCy20wYgFIje0dAm75JXM44RxPZGkmvltOyLwaw0ze3kJTvvoUe8qlB+6tRkScAssrTu+zhAjvFFdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4914
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:56:59
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

On 28.07.2020 14:09, Vladimir Sementsov-Ogievskiy wrote:
> 17.07.2020 11:14, Andrey Shinkevich wrote:
>> As __dict__ is being extended with class members we do not want to
>> print, add the to_dict() method to classes that returns a dictionary
>> with desired fields and their values. Extend it in subclass when
>> necessary to print the final dictionary in the JSON output which
>> follows.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 38 
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index 2921a27..19d29b8 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
...
>>     class Qcow2BitmapDirEntry(Qcow2Struct):
>>   @@ -190,6 +198,13 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>           super(Qcow2BitmapDirEntry, self).dump()
>>           self.bitmap_table.dump()
>>   +    def to_dict(self):
>> +        fields_dict = super().to_dict()
>> +        fields_dict.update(bitmap_table=self.bitmap_table)
>> +        bmp_name = dict(name=self.name)
>> +        bme_dict = {**bmp_name, **fields_dict}
>
> hmmm... I don't follow, why not simply
>
>            fields_dict = super().to_dict()
>            fields_dict['name'] = self.name
>            fields_dict['bitmap_table'] = self.bitmap_table
>            ?


The idea is to put the name ahead of the dict. It is the same to 
QcowHeaderExtension::to_dict(). The relevant comment will be supplied in 
the code.

The .update() will be replaced with the assignment operator.

Andrey


>
>> +        return bme_dict
>> +
...
>> @@ -303,6 +327,17 @@ class QcowHeaderExtension(Qcow2Struct):
>>           else:
>>               self.obj.dump()
>>   +    def to_dict(self):
>> +        fields_dict = super().to_dict()
>> +        ext_name = dict(name=self.Magic(self.magic))
>> +        he_dict = {**ext_name, **fields_dict}
>
> again, why not just add a field to fields_dict ?
>
>> +        if self.obj is not None:
>> +            he_dict.update(data=self.obj)
>> +        else:
>> +            he_dict.update(data_str=self.data_str)
>> +
>> +        return he_dict
>> +
...

