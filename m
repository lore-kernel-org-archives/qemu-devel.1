Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64010C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF8E2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YVypRNBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF8E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jusZU-00085M-BY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jusYa-0007Ic-65; Mon, 13 Jul 2020 03:07:20 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:42980 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jusYW-0004xZ-F9; Mon, 13 Jul 2020 03:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBEvbtMw1BYK6zLFc340cLQ1xIeW32X5DJ/rT/BPuXmEW4DcvB2aerChzx81/3XizzMTFxIRjw+MTttl3O47J0Vd8ax3cVMcLbr8lm3nnuDile26uFyS3lamCsikVArwDAfpSHVOdPC8suRaVvYz4Ktm/WOGfTtqS3zX2WCAMaXqRTavn58kIM0J4nzjwjjDWBoQp6KInp8JNag4a2PmcOM5ToYzvtBxzVIn5EeN4nbphaz6bYq8U9/4RrE/bERyqsKXVqaGYyJNxRLHGoxJylX3nSlAUsgdqlrjMy+3KQsXMADsJUIBBGeWUMLoP/3V/jRN6tApMpCFX3Bpy1BGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsUiGRqbj4mRg9DE35NuyB1vocdhEb2G2n+IyEU/c+I=;
 b=FHb3zJkz6ZFmM84lvHHP+qzFhkdrxIxgkp7xQGohRDwDwkkhaZ9kIea9rd6BQtz8mokki2Aktudq3grnRRlPkLPfkOWIgYJECM1cmPb45bZGJ4wYs3ox0h4RHf9jToPFlcZ0Iegoov0Dyz7YSNm/qiUSDPe6PtPX7I8m1j6GaEQWKr/QwvQ9sv/JBNP5DOWyBk9EYlo/DSmVl6v2Trs8GurBNWT/75Tn3qCiqIOuArshKh39JlwoK6kU9djViMzdrnQ8Bp1rQxuDa6wWidrbcTJv7NpcVq0ZZqw9VMlblEfRlkiKfu8I6tCH+nAMsI6EYpRhR+x/wFTmRLLzImIpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsUiGRqbj4mRg9DE35NuyB1vocdhEb2G2n+IyEU/c+I=;
 b=YVypRNBiQdQrCQSBx2aRUh1pnc8LkTPmHb6EBC52lDAjLl2I/I7pdZhjmYioiX0wuFPXML7Szewk4pJF3D8+acrSYcrIVNEm3QfAlXapVHXrMykIkZnOoPfGHs4/oiK6XrGQsEyevD6lHb548cBJ1u2nCUk+2MGQGeZdd71emY4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1779.eurprd08.prod.outlook.com (2603:10a6:203:2f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 07:07:11 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 07:07:11 +0000
Subject: Re: [PATCH v8 05/10] qcow2_format.py: Dump bitmap directory
 information
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e3b87637-92cd-fc56-9344-c8c9d7329dd3@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <ca35f69b-3ab4-a0f1-9785-8354fec90d60@virtuozzo.com>
Date: Mon, 13 Jul 2020 10:07:06 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <e3b87637-92cd-fc56-9344-c8c9d7329dd3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::19) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR06CA0114.eurprd06.prod.outlook.com (2603:10a6:208:ab::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 07:07:08 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c982e7-b70d-4adc-c8a1-08d826fb5d24
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17791C2B17380144EF885A0DF4600@AM5PR0801MB1779.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H25Y45i/YUiJ/qVvAAoSg4M/US1JQMxDFjuGVN83EGChZz6LkYuqdAE1omPoT50dH3mli3jR9V0QW9TWPUbyb4YUbEdbVbFaEchZIz6xNYv3MsJQ8HdHuQ6nz8zWnaMt66woyQ4/MSon3zfOHjlFe10e6L1wfSeVMw/4MZ7SP4rCqgY+m77yF4ZzKoQlkCECKv0Ihqf1PvzZy0Gy2VI4CYYJBrpNILeyrAZh9eT+/gnd6xhYLxZZcDa65a1uzPp18hDtL/6R3DsrIrp53w+rhhD8oGM5TEUh+syKOkD/JdVorQX3+NNbmROrZYXDtvYWUdqZX9AixbqggMjSLV+1W+mfIg2KN4xoMrSaWAg87ls3zvP0eyLgwJGQr5f2ZCcO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39830400003)(346002)(36756003)(44832011)(6512007)(5660300002)(478600001)(956004)(2616005)(316002)(8936002)(8676002)(6486002)(2906002)(86362001)(31686004)(6506007)(53546011)(186003)(16526019)(4326008)(26005)(52116002)(66946007)(31696002)(107886003)(83380400001)(66556008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HWGLfSwM+1+zUpH6eL+0tGkM+mLWHQuH8OfX+dgJp4yCmoKYZdxMQ2E9SuIVMBEyDLCMgYBo/RNYNbbySusO2YdHUUHpzkIT5J1WhACI1opggmQklupEJ/6dRVsNyqlfv9iuMfaI8qze1yErVJE4pgUOKpa8EXbAGqrhao1d0MTT2LSFGss/0odq90obw1WhJGXylN5jpFF22qkSxTQyhLCFbKsF/+iGkEwoZBboz8BL9+mlfXlWj6j0fvLyiycyRPoWkOTiirtbz5/dwD1VZm43YT1jYf4YzQyuBTJkcGV5YJFTdsmaseGhxgNUHRZWSwGxkyTtq49sWCLG/a7oLHacKT0F5AmZrl1xmOduAf6HgZxMHbkgq0BRC0cz73X0B/4hyqbUrkoRaRl8lWGZUlYMkz+glUu5UYpOfWaPmPkPHkUM+Xc6Vszgzhx3/4PosuFotzQiE79H4EMw3PN+WHnp+kbobtkOAz29OKyoO206wN+z2g/cRqyomtbPranm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c982e7-b70d-4adc-c8a1-08d826fb5d24
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 07:07:11.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiEgpgGLOOsN2KrL1v/WmXl7dIB8wy3mt5lwHu6EzMKhVnIEYcQyQucZZRBz1Kf4PTePWn+CXipMq1p4ZahIJLFXsZ+akFUX494tm9fwg5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1779
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:07:13
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

On 11.07.2020 22:11, Vladimir Sementsov-Ogievskiy wrote:
> 03.07.2020 16:13, Andrey Shinkevich wrote:
>> Read and dump entries from the bitmap directory of QCOW2 image.
>> It extends the output in the test case #291.
>>
>>
...
>>   diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index d8c058d..7c0dc9a 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -132,6 +132,50 @@ class Qcow2BitmapExt(Qcow2Struct):
>>         def __init__(self, fd):
>>           super().__init__(fd=fd)
>> +        self.read_bitmap_directory(fd)
>> +
>> +    def read_bitmap_directory(self, fd):
>> +        fd.seek(self.bitmap_directory_offset)
>> +        self.bitmap_directory = \
>> +            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
>
> sounds good. I think, we should restore fd position after reading 
> bitmap_directory, to point at the end of extension, to not break 
> further extensions loading
>
>
Yes, it is done in the constructor of QcowHeaderExtension:

if self.magic == QCOW2_EXT_MAGIC_BITMAPS:

...

position = fd.tell()

...

self.obj = Qcow2BitmapExt(fd=fd)

fd.seek(position)


Andrey


