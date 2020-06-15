Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B31C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F3E2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JYgqUBbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F3E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmSG-0006hs-Fp
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkmRP-0006Au-P6; Mon, 15 Jun 2020 06:34:12 -0400
Received: from mail-eopbgr140104.outbound.protection.outlook.com
 ([40.107.14.104]:24710 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkmRM-0006qA-Cv; Mon, 15 Jun 2020 06:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRaZn4bG/HRBmZ68Kt4yczVKLyyJyI81gMA3DANb7clC1Quq/Dq0BkCdzYK6YXFHaFQJhpyshY8OPwN8eFqCopX0FNK1nm7dJPqHGJN2ofMUlknBUTk/gSz+29wcwX+Ut4AMzZye9QHnXJXn9RdxE3sSag0evxhdrBsH12IwtbRgvrqTjJwDDKEJ257DIE85Yo6arhzgDKaca2nk1ACy20wHoolJn6IL8437ZWS7VhAVQg/EFdEejZE6iyb2dqG/DDBhas93pmbjpWyFM1HEsF4EtnnANfjPLNqZVz7lY3rCnGqDYuC2MFfpD8MHARvNlJgJ1GKcg3acgq48ZDn56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUShBNyGRH4nyd0R298tyEdOM17zPToOGMBgpSg6O0s=;
 b=WsfJoHIuh0+lR99EoBPKFvd0d/L6qW+OI6sHyCyepqaDdH4avxONpfiJShzV1q7kZMs1XpF//pVR0kLUd+tejw9+r65Z1KnrW7wk5zs1KJvYRZg2bM/u6UizSPcjJpTDFcS0vMosX8AsIpuOYyzNhWcNBLpg/PilPTXzy/UYQdKl/vHgMRPcuLZCr1z/NJl/f75XcEyczpg1LdPALIRQbt1gGuniC+npqYnsWuY6+IxkLtsIUwqSYwthbUVnW6QCXv8vRf9jgt3PWW80vDcvrFZvS7PBNEWKrsrwVnEfICrPGPWsx6Ej27rkuPznXtm7h1cNtVi9ebjAwYFomx1GQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUShBNyGRH4nyd0R298tyEdOM17zPToOGMBgpSg6O0s=;
 b=JYgqUBbU4T1W3R5PaA32OvbnDFEW676HAXSyDrunE4wOWx4oAMVLnR3LWSPag9sX8dzRfQx1F0i3fraU8duBpxF4I+sor/k1wWIAMyCp14X+ZthuPtIEmb0GDkmsfTV1/s0LTaVoQKTA3mth78qK6BQuPVS35cGQ1FqkfFh6+sw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5510.eurprd08.prod.outlook.com (2603:10a6:20b:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 10:34:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 10:34:04 +0000
Subject: Re: [PATCH v7 4/9] qcow2_format.py: Dump bitmap directory information
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591920302-1002219-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b8bd5522-d93c-01fa-4b8e-928caee73125@virtuozzo.com>
Date: Mon, 15 Jun 2020 13:34:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591920302-1002219-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM4P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 10:34:03 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f12b50-dc29-4455-2db5-08d81117a049
X-MS-TrafficTypeDiagnostic: AM7PR08MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5510ED3DCDA39F023411D9E0C19C0@AM7PR08MB5510.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJGYEMZQpjSJJ0up5BT/yGBJWrPBm8UXBXvfr7pMYP50r86dyhh1ELNQ+H84Ni2OklK1rZ2E8qMkeMMwXmarm5iA4jzPUspxApIc1zU2mSermku1ChYKhdYw3gfGDJ8IbdJtaASGASe8n1n43kXZGLLlmYTi4LrdrVZZdn30lpY2ToPHtrrWKnx1VLWQ2HXRl49SOgahKRYZID8PwPMb44pinQluY7e8DuFSwFA14QatkilFXY407NKRf3ZCXCx7pe2o9f0IT6NZbzUtu/mgHr2rf7ADM4/gOZ4TyazGDauMGxaoxsT8RDn8SoJA9Af6E8uTAnhBZgyq+nHtBxTcfhPLIGQTBdggMYQIUe0eq+wHfnby4RxFQhbnyQXmqREn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(346002)(136003)(376002)(107886003)(66946007)(66556008)(66476007)(5660300002)(19627235002)(4326008)(31696002)(86362001)(52116002)(2906002)(83380400001)(26005)(186003)(16526019)(6486002)(956004)(8676002)(2616005)(36756003)(16576012)(8936002)(31686004)(316002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NbooHfQeIJWJh7Ls8kdkJVN2GN/tr7yqD8eH0lHt5HeJIAK/qMzBP5Be9ZqOU/qK7+IlPn0vY7DGwbbTmpzRcAxAId6Xeb+LEe09enNSya43WuLtA4J/X/r52oOBEP+42zR58I+7W8/uFNf5RNS3MvUB77aBmcaIY2D7HJOQkNMc9BF6IHGa70iiWq4qBcp3IjP1CCRp+1QMvaDTuvvXWFdLtjqNjBTlqzGzrDnci2awQh15EYx+Fp8VI6jFWFtPeLnOpFG+lYqxfkxAnYiuGxD33n28SYv84T31jEdjZlLYN6bvdWr4KhHCRMCAV5Vh/YS8+/xc9wrRd/uRQ0zKVk52mMYWcDMMEVtRJ+23j3nantRGkI5B4K3eos3gGlOj9YmHDL4M9zNVoiuVey1aZ4spy+sFjcxXsRvFZqUbxxMihqtS+tRn+F9YycEymjMC8Uc9G8mggesyZI3sXhZ5IudCmrGIlg3Qg85QToD8Kr48u9Yzfoy0w4L+qftPgZwq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f12b50-dc29-4455-2db5-08d81117a049
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 10:34:04.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0EQ7Kj61eBekI0xBIH9cfMD4AwcrevxCKTzmfiPMMQdhAD8eKFVgRpyDi8ZLogYm10vRcc/LPMXh7haYZXC7zIffa+yk5YK5EeqECHihFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5510
Received-SPF: pass client-ip=40.107.14.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 06:34:05
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.06.2020 03:04, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image.
> It extends the output in the test case #291.
> 
> Header extension:
> magic                     0x23852875 (Bitmaps)
> ...
> Bitmap name               bitmap-1
> flag                      auto
> table size                8 (bytes)
> bitmap_table_offset       0x90000
> bitmap_table_size         1
> flags                     0
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hmm I don't remember me gave it..

> ---
>   tests/qemu-iotests/291.out         | 52 ++++++++++++++++++++++++++
>   tests/qemu-iotests/qcow2_format.py | 75 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 127 insertions(+)
> 
> diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
> index ccfcdc5..d847419 100644
> --- a/tests/qemu-iotests/291.out
> +++ b/tests/qemu-iotests/291.out
> @@ -33,6 +33,27 @@ reserved32                0
>   bitmap_directory_size     0x40
>   bitmap_directory_offset   0x510000
>   
> +Bitmap name               b1
> +table size                8 (bytes)
> +bitmap_table_offset       0x4e0000
> +bitmap_table_size         1
> +flags                     0
> +type                      1
> +granularity_bits          19
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b2
> +flag                      auto
> +table size                8 (bytes)
> +bitmap_table_offset       0x500000
> +bitmap_table_size         1
> +flags                     2

both having flags and flag in the output looks strange.

If you want good human look of flags field, you should implement a special formatter-class for it, like Flags64.
Maybe, something like this:

flags      0x3 (in_use auto)


> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
>   
>   === Bitmap preservation not possible to non-qcow2 ===
>   
> @@ -98,6 +119,37 @@ reserved32                0
>   bitmap_directory_size     0x60
>   bitmap_directory_offset   0x520000
>   
> +Bitmap name               b1
> +table size                8 (bytes)
> +bitmap_table_offset       0x470000
> +bitmap_table_size         1
> +flags                     0
> +type                      1
> +granularity_bits          19
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b2
> +flag                      auto
> +table size                8 (bytes)
> +bitmap_table_offset       0x490000
> +bitmap_table_size         1
> +flags                     2
> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b0
> +table size                8 (bytes)
> +bitmap_table_offset       0x510000
> +bitmap_table_size         1
> +flags                     0
> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
>   
>   === Check bitmap contents ===
>   
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index d4f0000..90eff92 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -103,6 +103,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>               print('{:<25} {}'.format(f[2], value_str))
>   
>   
> +# seek relative to the current position in the file
> +FROM_CURRENT = 1

Firstly, I though that it's a global variable to control class behavior. Only than I understood that you just decided to use a named constant instead of just 1...

So, I'd prefer to use just 1.

> +
> +
>   class Qcow2BitmapExt(Qcow2Struct):
>   
>       fields = (
> @@ -112,6 +116,73 @@ class Qcow2BitmapExt(Qcow2Struct):
>           ('u64', '{:#x}', 'bitmap_directory_offset')
>       )
>   
> +    def read_bitmap_directory(self, fd):
> +        self.bitmaps = []
> +        fd.seek(self.bitmap_directory_offset)
> +        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
> +
> +        for n in range(self.nb_bitmaps):
> +            buf = fd.read(buf_size)
> +            dir_entry = Qcow2BitmapDirEntry(data=buf)

Base class of Qcow2BitmapDirEntry can load from fd. We should definitely utilize this possibility, instead of writing it again.

> +            fd.seek(dir_entry.extra_data_size, FROM_CURRENT)
> +            bitmap_name = fd.read(dir_entry.name_size)
> +            dir_entry.name = bitmap_name.decode('ascii')

You should initialize object in its constructor, not by hand here.

Actually, the code here should look like this:

self.bitmap_directory = [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]

OK, you may leave a loop, and even calculating of final alignment here, but real fields should be read and initialized in Qcow2BitmapDirEntry constructor
    

> +            self.bitmaps.append(dir_entry)
> +            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
> +            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
> +            fd.seek(shift, FROM_CURRENT)
> +
> +    def load(self, fd):
> +        self.read_bitmap_directory(fd)

Let's load in __init__, why to force user call additional .load after object creation?

> +
> +    def dump(self):
> +        super().dump()
> +        for bm in self.bitmaps:
> +            bm.dump_bitmap_dir_entry()
> +
> +
> +BME_FLAG_IN_USE = 1 << 0
> +BME_FLAG_AUTO = 1 << 1
> +
> +
> +class Qcow2BitmapDirEntry(Qcow2Struct):
> +
> +    name = ''
> +
> +    fields = (
> +        ('u64', '{:#x}', 'bitmap_table_offset'),
> +        ('u32', '{}',    'bitmap_table_size'),

please, don't do internal indenting, I've dropped it from all other classes here.

> +        ('u32', '{}',    'flags'),
> +        ('u8',  '{}',    'type'),
> +        ('u8',  '{}',    'granularity_bits'),
> +        ('u16', '{}',    'name_size'),
> +        ('u32', '{}',    'extra_data_size')
> +    )
> +
> +    def __init__(self, data):
> +        super().__init__(data=data)
> +
> +        self.bitmap_table_bytes = self.bitmap_table_size \
> +            * struct.calcsize('Q')

struct.calcsize('Q') isn't more friendly than just 64.

Also, you tend to prepare everything you want to dump in a constructor. Why?
I'd prefer not to have attributes bitmap_table_bytes and bitmap_table_size
stored together, it's obviously too redundant. You can always do
print(self.bitmap_table_size * 64), no reason to store the calculated value.

> +
> +        self.bitmap_flags = []
> +        if (self.flags & BME_FLAG_IN_USE):
> +            self.bitmap_flags.append("in-use")
> +        if (self.flags & BME_FLAG_AUTO):
> +            self.bitmap_flags.append("auto")

Again, for this we need a separate formatter class, like Flags64

> +
> +    def bitmap_dir_entry_raw_size(self):
> +        return struct.calcsize(self.fmt) + self.name_size + \
> +            self.extra_data_size
> +
> +    def dump_bitmap_dir_entry(self):

this method should be called just dump

> +        print()

this is extra formatting print-line. Do it on upper level, it's unrelated to Qcow2BitmapDirEntry class itself

> +        print(f'{"Bitmap name":<25} {self.name}')
> +        for fl in self.bitmap_flags:
> +            print(f'{"flag":<25} {fl}')
> +        print(f'{"table size":<25} {self.bitmap_table_bytes} {"(bytes)"}')

Why do we need this additional representation of bitmap table size?

> +        super().dump()
> +
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
> @@ -253,6 +324,10 @@ class QcowHeader(Qcow2Struct):
>               else:
>                   self.extensions.append(ext)
>   
> +        for ext in self.extensions:
> +            if ext.obj is not None:
> +                ext.obj.load(fd)
> +

I don't like this chunk, it breaks encapsulation. Why QcowHeader object should know that some of extensions may have internal obj, and to initialize it we need to call its .load method explicitly?
If extension wants to load some additional data it should do it in a constructor.

>       def update_extensions(self, fd):
>   
>           fd.seek(self.header_length)
> 


-- 
Best regards,
Vladimir

