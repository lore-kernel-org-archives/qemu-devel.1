Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A74C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C192342C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f3wGKCWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C192342C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Log-0007t2-1x
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3LnM-0005mB-4Q; Wed, 05 Aug 2020 11:57:36 -0400
Received: from mail-eopbgr150127.outbound.protection.outlook.com
 ([40.107.15.127]:27374 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3LnI-0005y2-O4; Wed, 05 Aug 2020 11:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWFzr1bbduaxrv0FER4BIlNovpIZZrJH7hjA00EMX2MQTMpjMSfnwEyjrglFHRDMlySERrZc05+p9YrV9auo6nIoXlR+OWzc05XZirq644Ds2Cmckr8S/l157ZsIZbtua6oAI+35EVMPwh9O+lAnD8zFofKMBK4BbozIISYz7UXhkr/P9lLw0kG1xaO8L299xlnxZH/F8DjhhJcE4ZzUa7b0SBqO+HeVBcWSHeb+933FPw52BkAP6v1zXVHllypZ8FgJNxYuoFpeizqAVj86k37wgfRinv3JSPu41+O5dDMTwEIIcdrSROFUQ1LkhlGTlo7yw31we1cnvWyvS6na3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay5rGPY3GdjHNciga4JJLckZxuS2AuKmkMAc17pkVSE=;
 b=h8NTYX5/GYwM70NbxlZ+Pzv7yUYQY+Et7p3VnV4Gv4FGUcE7t2mzoftLJ+ivClPnesZTsX+mkKrf2l1KL+4TNK3+ChQyJRwaa2YiJr5wx76kyHM9StHXq+p/u7/B9H+ZFjayoDthSbcFC3uLFnrEsPYtJ94BbJuBCHya4eQV0+1gl6HP0MzE8QmsMeiCZPVN4gZSetL8SgP7c7T84A7PlTpkelM7niUIKbNM40YzX8qs0Fa2z9RZdYyiSEwgmyDPq+ors2pAVOoR1y0LZjjo46GmXZ7oVasDUJ9jV+hgqh9b5SrIcYrRMxhOwwrYmN1njMkfFkv5A9bcJyrc3SdI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay5rGPY3GdjHNciga4JJLckZxuS2AuKmkMAc17pkVSE=;
 b=f3wGKCWdhUHp0MXCSbpZTS1nQhNCShUxdwWBpJiX5SK09fzjdmLFx6CgStlCCI9BxBlKliA1iw2QtDka6iDPseRtx3Fs7PvqtV2Y9MXu+cKwdzhkgMpaz7/YkSjOQS0x3QJ9fZGcBbCnnP2XivnQ45l1rgHmtjpySPpBNxiantY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3862.eurprd08.prod.outlook.com (2603:10a6:20b:8c::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 15:57:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 15:57:28 +0000
Subject: Re: [PATCH v12 07/11] qcow2_format.py: Dump bitmap table serialized
 entries
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ed880db8-be61-1633-390c-a6a708ef19ad@virtuozzo.com>
Date: Wed, 5 Aug 2020 18:57:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:207:5::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM3PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:207:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Wed, 5 Aug 2020 15:57:27 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a09c2662-beec-4b78-8071-08d839584100
X-MS-TrafficTypeDiagnostic: AM6PR08MB3862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3862830706FA113A00943AC3C14B0@AM6PR08MB3862.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCdRYjC69ByeeML8FiqTnSMhl5ghaLvWN6iG8m8vQQpozmUnwrtC5WHLRPlUVoX5WKD4xZlfPmhYtSY1eWtooTwAfWU5XI0JlafLeDxXqk7kjuLvlOes3HJXPU8FKVwBFqv1a1U5MYk79KB9rKyg9luKOVN3m2uR2bV3nG0KitAs+peIsK/Rs9H4AySPG2Dzc0C/VPkm3e3poGRfZbn9BOk00g8vQ7e0KCwyzGhoRxVdbitxJzA8kTn8A4oYIo9Yu4z1H3kAglBx+sczVJHzKPflytRom59ztL0DEzdKrIJvkmF0n4Es2Mj8/tHfI63OJjM+aAeVHZ+1yi29htVlOm+MHxdqloS06mMxwqUrtGmoFTbLUyzVR+AchlpcqmtL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(396003)(346002)(186003)(478600001)(52116002)(26005)(2616005)(5660300002)(86362001)(16526019)(31696002)(956004)(316002)(2906002)(16576012)(66556008)(66476007)(66946007)(8936002)(6486002)(36756003)(31686004)(8676002)(107886003)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JQy3MjVzOSQOC89VMw05pIyUc7QPh8v6W68p7A3GQcvnY33zfRwjoUQbzwPyM51KJKRIPGGwtE1CnOpPjhuGNT/rr4CLZaas3HyLRxWMmvKz+WZSiZsf+t4lOHC5lLh9U+Ka9KZpucvu+anGVEzkAlu2/AzQDKnwv1Vtpa7GOhMQxaw+2SGyvc6MKC8obiFIWep3LoAq6sgsSXFBdo7zHhrqw9UHbBT9m2w/RO4IFnnsPD8vzGO3OupiGhTE2QBDL1r4G0j8V78Oz1c/sOP8tVLXPHws0Nm5orBvW3bWc6u/dwByqwNey8EM6P21vH0ppBo0Si+CfghQtDXF4Aewzu4Qd6pOgLQAziaEWUBRhGEHD7N1fUqOqqtCcMKrwYnbBoU2k88TnCWArmsEHRbt4x7ckAnXkhRHE3C1Wd6ix7aOYcBN/Dnd6c5xtp/NkcXLuKhU+2l1+c3QES3YRoKxPCHbSzGJKQluxxWrfkorRZjfG9TfAtAKzOvKpG61T7gq+uV4v36PEPXg8h094KDH8RmmcKKTOsKcVwcUC+O3gthYUWg81B2w8uzuPiGSCmc2VVBU81FbGQzyWiBhbyOrw5DFQo1aZ57ReMD5lDS3Poy6qnn10Z24ojiQiZkjMtIKrm9SSbtRr2crBw+r9a56bg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09c2662-beec-4b78-8071-08d839584100
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 15:57:28.5234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GWsI+2LHD/K4urwy//5CemOy7Y8Z31RfAaY9NqlQ7LFxPDWQrx2f9RpEkENGimWrYpFFlXAcRZf85K77p/+hIrsV0VPU/7l5q/wFTv+qDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3862
Received-SPF: pass client-ip=40.107.15.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 11:57:29
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

30.07.2020 17:15, Andrey Shinkevich wrote:
> Add bitmap table information to the QCOW2 metadata dump.
> 
> Bitmap name               bitmap-1
> ...
> Bitmap table   type            size         offset
> 0              serialized      65536        10092544
> 1              all-zeroes      65536        0

For serialized, size and offset are size and offset of bitmap table.
But, all-zeroes bitmaps don't have any bitmap table, so size and offset
both are undefined (OK to print zero for them, but 65536 is unrelated).

> 2              all-zeroes      65536        0
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/303.out         |  4 ++++
>   tests/qemu-iotests/qcow2_format.py | 47 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
> index dc3739b..d581fb4 100644
> --- a/tests/qemu-iotests/303.out
> +++ b/tests/qemu-iotests/303.out
> @@ -70,6 +70,8 @@ type                      1
>   granularity_bits          15
>   name_size                 8
>   extra_data_size           0
> +Bitmap table   type            size         offset
> +0              serialized      65536        10092544
>   
>   Bitmap name               bitmap-2
>   bitmap_table_offset       0x9c0000
> @@ -79,4 +81,6 @@ type                      1
>   granularity_bits          16
>   name_size                 8
>   extra_data_size           0
> +Bitmap table   type            size         offset
> +0              all-zeroes      65536        0
>   
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index ca0d350..1f033d4 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -175,6 +175,10 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           entry_raw_size = self.bitmap_dir_entry_raw_size()
>           padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
>           fd.seek(padding, 1)
> +        self.bitmap_table = Qcow2BitmapTable(fd=fd,
> +                                             offset=self.bitmap_table_offset,
> +                                             nb_entries=self.bitmap_table_size,
> +                                             cluster_size=self.cluster_size)
>   
>       def bitmap_dir_entry_raw_size(self):
>           return struct.calcsize(self.fmt) + self.name_size + \
> @@ -183,6 +187,49 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>       def dump(self):
>           print(f'{"Bitmap name":<25} {self.name}')
>           super(Qcow2BitmapDirEntry, self).dump()
> +        self.bitmap_table.dump()
> +
> +
> +class Qcow2BitmapTableEntry(Qcow2Struct):
> +
> +    fields = (
> +        ('u64',  '{}', 'entry'),
> +    )
> +
> +    BME_TABLE_ENTRY_RESERVED_MASK = 0xff000000000001fe
> +    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> +    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
> +
> +    def __init__(self, fd):
> +        super().__init__(fd=fd)
> +        self.reserved = self.entry & self.BME_TABLE_ENTRY_RESERVED_MASK
> +        self.offset = self.entry & self.BME_TABLE_ENTRY_OFFSET_MASK
> +        if self.offset:
> +            if self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
> +                self.type = 'invalid'
> +            else:
> +                self.type = 'serialized'
> +        elif self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
> +            self.type = 'all-ones'
> +        else:
> +            self.type = 'all-zeroes'
> +
> +
> +class Qcow2BitmapTable:
> +
> +    def __init__(self, fd, offset, nb_entries, cluster_size):
> +        self.cluster_size = cluster_size
> +        position = fd.tell()
> +        fd.seek(offset)
> +        self.entries = [Qcow2BitmapTableEntry(fd) for _ in range(nb_entries)]
> +        fd.seek(position)
> +
> +    def dump(self):
> +        size = self.cluster_size
> +        bitmap_table = enumerate(self.entries)
> +        print(f'{"Bitmap table":<14} {"type":<15} {"size":<12} {"offset"}')
> +        for i, entry in bitmap_table:
> +            print(f'{i:<14} {entry.type:<15} {size:<12} {entry.offset}')
>   

All this looks like 'cluster_size' is not really needed for Qcow2BitmapTable class (we can print only offsets).
Still, if you want to save it, can we print it only for entries with 'serialized' type?

It's minor, I'm OK with it as is:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
> 


-- 
Best regards,
Vladimir

