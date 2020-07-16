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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E4B2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fMcJTkua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E4B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0N9-0004im-0b
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw0MP-0003w6-EI; Thu, 16 Jul 2020 05:39:25 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:24385 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw0MM-00046c-RJ; Thu, 16 Jul 2020 05:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPwf3uzdHe0/6wC0s5MTZZFuFJeGHZGTciItYG2vjnBTRaQrqLSbCNvdChLq7ZjkvhiioQAx5+n4vfIy2IKxQV0rPzYWuFsQcCCAnRr7w10Q7m4tOVsrgnLPiKsqS8DvR5NCunoUqK8Auz6wW47J2GcvUWQ+j0VY161f2Lj3RCC8Y0+Lhb5vpv3/Gywmx1Veaab7byJkmy4WUHKwjDVWjLZbMjETxeXiMi2VpZ3k6tAaXql8vzLICzbfrrZpRswdC3Zn/5i4jzF6uVJcj5TfvXAVLHWFuYnB0zEd72SiDHr4qC4qkOFXOPZLUBtsqDOipvso3wISDC7e9NAim5q4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlncOBCh9BpDGnXMoMvfp76+SXjpva+Y7FuZS3ALHkk=;
 b=lrn/jWDCrwITQhFJ2Vnv8KctCd3u4CGRN2lHyVV+/7yKLVI5jGWERGneBFRnm1/3zglf2I+nE0xCPG1OnQ3wAHOLEyEjAdFy2ZkqoJVLSjZgS98h7CiHpay+9OLr9vAfk27Rf/HHY2vsA1hsSl6uzDBIP1kTq9N7H/GRkIXQNSmMxPELo5ZZyFhG/jf/X7a9GUco1ZEGy00wyWpBh7QlDI71Ynfy6VzI7K+dPwEIdBmYOT6XXiPU/cxWhGkD9BBVRYjzq6dfwLMoVVehI6szBTMfXX7Zdd2VcFthv2PvVljdowaAtRwzhoYXPmuFWqmGvGrvJ38Z2O+j//jU0WEEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlncOBCh9BpDGnXMoMvfp76+SXjpva+Y7FuZS3ALHkk=;
 b=fMcJTkua4rIqM70Zg8V9Ea8RGdY1+WheuY0VgWgu/vgVUf0ec8YIZ7nOmQIm1JXn+NEhKdrK36+LRimZO2fjl4IMWdjBDqzluzzWM3z5pK3zU/tGvAl1F6qd7m093nqGC49MI0uOMTZiXxay2EWSe85db3O6L+6pNBEUTlV6LgQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4470.eurprd08.prod.outlook.com (2603:10a6:20b:b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 09:39:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 09:39:19 +0000
Subject: Re: [PATCH v10 07/10] qcow2_format.py: Dump bitmap table serialized
 entries
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8a020207-0a23-9407-a199-aea0af61170b@virtuozzo.com>
Date: Thu, 16 Jul 2020 12:39:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:207:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 09:39:18 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb66654e-ee08-40a9-996e-08d8296c1cf4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44708E4F410C5780990DEDA0C17F0@AM6PR08MB4470.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jw0/RKl/yzUClYISAHj4VO8j886BDhgQB6AANUONtN0HFpDDUKTIWMn+ob7OtEdlwFHuGoWI6bPywuEhILy1pT03899nsmeOxPHgSPRj4Jnd2hnuIWEC9OUqALPtKBzQd9hhpLLcFjAMyAyP5paVR+EYx1I5oO0la9WjsD9ejVK13esUDriGKmrMxcAWNsv1WMNZQM8MQmM28/EZ9fHIQfa0o5eiL0+5HctWvomRcHi0JuIVUyp/tT1hGSjIQ8GeWT0YLbEHl4c8VZuTP+Ikt4L9l/lBFPyCtBxTBLZ9V2CITnWtR6kFylasWU9ekv7WRWOqTrG24Ln0Vq+i7HuyiFkUf06fLOMLLIiIZ9VUdVOJ43rrSaJdCLoyAVEjXzx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(956004)(4326008)(16576012)(2906002)(8936002)(8676002)(6486002)(52116002)(86362001)(26005)(186003)(316002)(31696002)(2616005)(16526019)(36756003)(5660300002)(478600001)(107886003)(66556008)(66946007)(31686004)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tnjRD3cBVnRJqAW+thbOu538KWQ68wP+UCJX1jzMi3mE6SyRPS9hrn8VlszHU4DOwCDux/PDAJ7POH3yYoUG3Mehp/kJo277At5WEFNKsZKBYwESOrI9ukrjVk63N2ZQb3S0V8F7J9++R0EXICvNWPxy/vu9+J0ZoMeTFtGfBpdeOZC0TBTQF3oGlLZdRyolfPmh6nJyTCg2jsIPgGxJf81u07CQssFSckLo/aifgFraWY9cbA4XwuhUZXx4jaVIfCe+0F/vUGDkQX84ZhOx0QHvYN4SyS7j3sPTCmmIOPZ48MxsDk6Aag4UJ+D/3sXi+cB41jMvHFJfpKfChORRQ/Q+Ceqi0iHDS8RaGab3BhRO5E1KRenXQZlnIpdlosqOlR1eZONFLJAlIIP/MdMi22Hk5t81z8QEwEA+bb+6jigbINM6UymkLxUwBPhmsiCP5roMOr+bOxvszOR9RR4YQI395lP/kxAZpDHCoyGqrW2gMpKpQzz7LRjytzKbFk4B
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb66654e-ee08-40a9-996e-08d8296c1cf4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 09:39:19.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5raMgDXer06TQ2ll0sZ3lmYQLnp7C9VcIO+gDZw63JToYPHakSVJwFtgSzG9yM/iSuz7uoXS8AbCSY5QFxf4BozDRwg8bdpFSvt2O5NUdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4470
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:39:20
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

14.07.2020 00:36, Andrey Shinkevich wrote:
> Add bitmap table information to the QCOW2 metadata dump.
> 
> Bitmap name               bitmap-1
> ...
> Bitmap table   type            offset                   size
> 0              serialized      4718592                  65536
> 1              serialized      4294967296               65536
> 2              serialized      5348033147437056         65536
> 3              serialized      13792273858822144        65536
> 4              serialized      4718592                  65536
> 5              serialized      4294967296               65536
> 6              serialized      4503608217305088         65536
> 7              serialized      14073748835532800        65536
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 42 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index d9c8513..2c78d46 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -175,14 +175,56 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           entry_raw_size = self.bitmap_dir_entry_raw_size()
>           padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
>           fd.seek(padding, 1)
> +        position = fd.tell()
> +        self.read_bitmap_table(fd)
> +        fd.seek(position)
>   
>       def bitmap_dir_entry_raw_size(self):
>           return struct.calcsize(self.fmt) + self.name_size + \
>               self.extra_data_size
>   
> +    def read_bitmap_table(self, fd):
> +        fd.seek(self.bitmap_table_offset)
> +        table_size = self.bitmap_table_size * 8 * 8

s/* 8 * 8/* 8/ ?

> +        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
> +        self.bitmap_table = Qcow2BitmapTable(raw_table=table,
> +                                             cluster_size=self.cluster_size)

Strange to read an unpack it here, when we have separate classes. It's obviously should be work of class: to read and parse its object data from file.

> +
>       def dump(self):
>           print(f'{"Bitmap name":<25} {self.name}')
>           super(Qcow2BitmapDirEntry, self).dump()
> +        self.bitmap_table.dump()
> +
> +
> +class Qcow2BitmapTableEntry:

Why not to derive it from Qcow2Struct? It will have only one field, but it will work, and we don't need to open-code loading in .read_bitmap_table of another class

> +
> +    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> +    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
> +
> +    def __init__(self, entry):
> +        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
> +        if self.offset:
> +            self.type = 'serialized'
> +        elif entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
> +            self.type = 'all-ones'
> +        else:
> +            self.type = 'all-zeroes'
> +
> +
> +class Qcow2BitmapTable:
> +
> +    def __init__(self, raw_table, cluster_size):

As well, probably no sense in deriving from Qcow2Struct, but for consistency, passing fd to __init__, and read all nested things here (list of Qcow2BitmapTableEntry) seems reasonable

> +        self.entries = []
> +        self.cluster_size = cluster_size
> +        for entry in raw_table:
> +            self.entries.append(Qcow2BitmapTableEntry(entry))
> +
> +    def dump(self):
> +        size = self.cluster_size
> +        bitmap_table = enumerate(self.entries)
> +        print(f'{"Bitmap table":<14} {"type":<15} {"offset":<24} {"size"}')
> +        for i, entry in bitmap_table:
> +            print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
>   
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
> 


-- 
Best regards,
Vladimir

