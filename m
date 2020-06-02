Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F332C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26280206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RYSWoJ+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26280206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEHK-0003de-AF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEGV-00037w-3u; Tue, 02 Jun 2020 17:16:07 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:26720 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEGS-0001Ea-EV; Tue, 02 Jun 2020 17:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Megkqcy1iontH7VQTDlNvu3ukREmsvjlSKP06BijgplO2iLuwqc4CwVVoKwvFZrh7t/XhJo3xjZboU8eU6KVY6NEPi1rkzg3o+4u22Rb7qXKLJ+knRYg84u+8jVjDPFuKdK+h7rf4O88J+I5ZkndxKNOdT67UIEQjfls0JDn4e87BCzQ7dIzsOY6cu0Qt+7uO3IrPlP0/QeU52qfAIRyWehhNCnsSdKGBbaqR3CoHEMeM7Jj4ziVZcMJ1lKcpjv3El9VOWU9B23lVwwJEAYhlGBLlAIbpH86a58o0AT0tCxTkeu+AI550W46/oFWThGaT+LZnjgDPxneUUwSjFkd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FizUq3NFSM2tvt6hatetgGEHisE2+KJMAQDmI/sdbos=;
 b=b6hDujKgYnoVI9PRsOM1M4PPt4dx5PkbF56BhoCZ9t5cUgMmfTkBlqEoqxRrzNbB7i6gwvlrkFmNdjeQgjnJISdIURrGOegC61npWBwpimnv7yt8q5G71WxZf1OhwYWrbgAC8Ab5P72fRM0Kb1Y1PZ5+0j9fzMaqm97YG/Tc5kh+Y4yhu80vyW6jdkeV1F2Q04N0+zbVYPs7wVjB7OgzKTaDYeoVd9FDEe78uvwMuByoU6A4FhDyhuUt5cs9ICDirD7aDP5xdJKri9c/7zOhZThTmuE9IHMOULoYtYInwG6FkPTKwqhnmokK3+SQD7oXJr8BBYr0tb0Y9G/eohuGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FizUq3NFSM2tvt6hatetgGEHisE2+KJMAQDmI/sdbos=;
 b=RYSWoJ+weQ3CvPQ6dkh6vvoXtfq0djQRb5kJnulPANnGxlnMrGixPqPwqokv5uBB4bBJebbN5aRBwpXhW2q0NDxFp+VgsnVT1BZlA8okoEbAj9fu+kfIqzdHQ3dkpvsr84TQ2ghasvmUO+ajxPT4WYdm9czUHylYIzMqniF6twc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 21:16:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:16:00 +0000
Subject: Re: [PATCH v3 4/6] iotests: Dump bitmap directory info with qcow2.py
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <02513d75-fcd3-4ea9-215f-28f219454339@virtuozzo.com>
Date: Wed, 3 Jun 2020 00:15:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR10CA0118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 2 Jun 2020 21:16:00 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fbe7470-a2ef-48f2-595d-08d8073a266d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527490B35763E9097F149C1C18B0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XF4VUykLGTw8rvNUWTBN0luFNoIkiaKBSaWBSWykFEsI3RvZDDxc4B069zLMwDF4hU7TSJm1mYsu/iKkH9FgqjC/dUNtbeTvgxK0ki6xMy9ZnoQfD8uWv2r7mX6cA7piH2j1o6GK9Xv07ynuPNSxZBmueMwn2Jnd4KYl100Z8Ww50CIhHKiL9lJa7hReLiNSg6kty7HCJVQ4ULxKxPHR/m0dRCxPTbls9Y8RC+Ugl9rujbEJnA7Ju5WP6ANxHQx1GtI87Wh1FsC7UYzV7I6yqh2i3PY0tG9m4eNP4pdCuquBcL+J4C/ukmozcgoooLmm/2S0aZ9oBF2kNvk8gCfBt+60jU9G1nbvsxw5K9v55xmaUOS3nvf3IEPGE99QX/Jw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(346002)(366004)(396003)(376002)(4326008)(52116002)(66556008)(86362001)(36756003)(66476007)(26005)(8936002)(107886003)(31696002)(31686004)(16526019)(6486002)(5660300002)(2616005)(186003)(66946007)(83380400001)(478600001)(316002)(956004)(16576012)(8676002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JdQyGKXkLi6gts4uLshTAj+c2Z6W8P+E0E+YrPH8VAtldCwcWE0qpDSs9QRk8vHXgP0W1o2hOCGTvaD9OBper6snW4OqhZW/TnghQLcTSBhBEUxV6t0ALCHSpr9eiqVInqKvjEn67PU04o3faX71WcTn7vJiLkqKsE+LgP4/NW3DItq1g+BlVf6WWYJXb2y5qs4LZ4ekkf57tI3wL4N2tEawdEDfS+Je2CoNwTrIaw81Vbu7UP3cKXsMlNtJtQpXxv+JWbBPmNLrM7krHoVozeGKXB/NFxD3aBiL05XnLsSp0QhLX4F6HBSZL1h90UUb2MEqffgeA0r5x9HRexPuIPPpQSd2e284A5e0HP603S955YM5keK/vZjH5xxmnwee3InaeW9ztDCaSMVswLPOKrlOf3njZB/weHAwnJLKFJ0M5PT3MZIRzqilHSw9XS2QrfYocDrLtAKM6HQAoWImOnkq5CUoRHRjz6tNsUjROt2QDurwx8+RRSElbZtTN3gZ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbe7470-a2ef-48f2-595d-08d8073a266d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:16:00.8004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iQc3rKRFFXISrFjVQN5lrwYWrIf80iwozeD/iV9vX9HTNuEehfiOWnHiOvwWcIPmZ6Z06/TMGcDHVoRWooL1aglAWqcEds0TMV/x601y9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:16:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

01.06.2020 16:48, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image with the
> script qcow2.py.
> 
> Header extension:         Bitmaps
> ...
> Bitmap name               bitmap-1
> flag                      auto
> bitmap_table_offset       0xf0000
> bitmap_table_size         8
> flag_bits                 2
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 104 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 8286115..e4453f6 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -5,6 +5,88 @@ import struct
>   import string
>   
>   
> +class Qcow2BitmapDirEntry:
> +
> +    name = ''
> +
> +    uint8_t = 'B'
> +    uint16_t = 'H'
> +    uint32_t = 'I'
> +    uint64_t = 'Q'
> +
> +    fields = [
> +        [uint64_t, '%#x', 'bitmap_table_offset'],
> +        [uint32_t, '%d',  'bitmap_table_size'],
> +        [uint32_t, '%d',  'flag_bits'],

I'd keep exact field name from spec: "flags"

> +        [uint8_t,  '%d',  'type'],
> +        [uint8_t,  '%d',  'granularity_bits'],
> +        [uint16_t, '%d',  'name_size'],
> +        [uint32_t, '%d',  'extra_data_size']
> +    ]
> +
> +    fmt = '>' + ''.join(field[0] for field in fields)
> +
> +    def __init__(self, data):
> +

You are not consistent about adding this empty line. I'd avoid it.

> +        entry = struct.unpack(Qcow2BitmapDirEntry.fmt, data)
> +        self.__dict__ = dict((field[2], entry[i])
> +                             for i, field in enumerate(
> +                                 Qcow2BitmapDirEntry.fields))
> +
> +        self.bitmap_table_size = self.bitmap_table_size \
> +            * struct.calcsize(self.uint64_t)

I don't like this: you keep name from specification, but change its
meaning.

> +
> +        self.bitmap_flags = []
> +        BME_FLAG_IN_USE = 1
> +        BME_FLAG_AUTO = 1 << 1

I'd define all constants copied from C code in global space, to be simply
available from the module.

> +        if (self.flag_bits & BME_FLAG_IN_USE) != 0:

in python zero is false enough :) (you may omit comparison to 0)

> +            self.bitmap_flags.append("in-use")
> +        if (self.flag_bits & BME_FLAG_AUTO) != 0:
> +            self.bitmap_flags.append("auto")
> +
> +    def bitmap_dir_entry_raw_size(self):
> +        return struct.calcsize(self.fmt) + self.name_size + \
> +            self.extra_data_size
> +
> +    def dump_bitmap_dir_entry(self):
> +        print("%-25s" % 'Bitmap name', self.name)
> +
> +        for fl in self.bitmap_flags:
> +            print("%-25s" % 'flag', fl)
> +
> +        for f in Qcow2BitmapDirEntry.fields:
> +            value = self.__dict__[f[2]]
> +            value_str = f[1] % value
> +            print("%-25s" % f[2], value_str)
> +
> +
> +class Qcow2BitmapDirectory:
> +
> +    def __init__(self, bm_header_ext):
> +        self.nb_bitmaps = bm_header_ext.nb_bitmaps
> +        self.bitmap_directory_offset = bm_header_ext.bitmap_directory_offset
> +        self.bitmap_directory_size = bm_header_ext.bitmap_directory_size

Honestly, I don't like duplicating attributes between different objects.

> +
> +    def read_bitmap_directory(self, fd):

Why not do it in constructor? The only use of the class

> +        self.bitmaps = []
> +        fd.seek(self.bitmap_directory_offset)
> +        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
> +
> +        for n in range(self.nb_bitmaps):
> +            buf = fd.read(buf_size)
> +            dir_entry = Qcow2BitmapDirEntry(buf)
> +            fd.seek(dir_entry.extra_data_size, 1)
> +            bitmap_name = fd.read(dir_entry.name_size)
> +            dir_entry.name = bitmap_name.decode('ascii')
> +            self.bitmaps.append(dir_entry)
> +            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
> +            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
> +            fd.seek(shift, 1)
> +
> +    def get_bitmaps(self):
> +        return self.bitmaps

Why we need getter for this field?

> +
> +
>   class Qcow2BitmapExt:
>   
>       uint32_t = 'I'
> @@ -33,8 +115,21 @@ class Qcow2BitmapExt:
>               print("%-25s" % f[2], value_str)
>           print("")
>   
> +    def read_bitmap_directory(self, fd):
> +        bm_directory = Qcow2BitmapDirectory(self)
> +        bm_directory.read_bitmap_directory(fd)
> +        self.bitmaps = bm_directory.get_bitmaps()
> +
> +    def load(self, fd):
> +        self.read_bitmap_directory(fd)
> +
> +    def dump_bitmap_directory(self):
> +        for bm in self.bitmaps:
> +            bm.dump_bitmap_dir_entry()
> +
>       def dump_ext(self):
>           self.dump_bitmap_ext()
> +        self.dump_bitmap_directory()
>   
>   
>   class QcowHeaderExtension:
> @@ -79,6 +174,10 @@ class QcowHeaderExtension:
>               self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
>           }.get(magic, 'Unknown')
>   
> +    def load(self, fd):
> +        if self.obj is not None:
> +            self.obj.load(fd)
> +
>   
>   class QcowHeader:
>   
> @@ -157,7 +256,10 @@ class QcowHeader:
>               else:
>                   padded = (length + 7) & ~7
>                   data = fd.read(padded)
> -                self.extensions.append(QcowHeaderExtension(magic, length, data))
> +                self.extensions.append(QcowHeaderExtension(magic, length,
> +                                                           data))
> +        for ex in self.extensions:
> +            ex.load(fd)
>   
>       def update_extensions(self, fd):
>   
> 


-- 
Best regards,
Vladimir

