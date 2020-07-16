Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C09C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B00D20775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OOGifmRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B00D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzYn-0000SS-9x
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzY7-0008P8-Lw; Thu, 16 Jul 2020 04:47:28 -0400
Received: from mail-eopbgr10125.outbound.protection.outlook.com
 ([40.107.1.125]:5237 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzY5-0007Ds-2h; Thu, 16 Jul 2020 04:47:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzEGf8kBULugNqqxMtvr4+NHQzrW8Js8Fw1LB8T2tKbtI/DJL5LtNf/+4pq++cyUokDk957wmZuGxa212OKFmDpbdCnTZCmBp5l2D1bIoMwGLyO9etm+eq4fhOGU6DTQnzF/G9ZPDJhlapSzC/OC1vPkepVRDOcClTALLmQQOIV62jAHsftTtJn0gf+O6NmmraKoL9ADU7RR5NnxvtNuhRMUiMHPKanV4bBVj5/P0DdjBaLZpGOEIcDNDTx71g19UyoGSxXMsX2nQUVPaobRx3dnTcYEDTWqGtVLto2qs7Je8odT/nuxZdC2fQxruOnAAGWmCXZKbMB2mdB0UJ+sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdNVTJHDpkQkP6ftEkWYL/A+7jDdm1SdTHOwdWIXWVA=;
 b=AXtDlXEy8Ox0oGtSYf0JrrsYB/j98wh1AbbtkAPqFXE+6U2KBf2H5VgtWE8GdyCWNlmFdcDPGu8Oy+zyvoNqRo7r9qmO9IWoVGNPGRJFmLsswNPZ3sXM7N6ZejDMxyWvSXnqpLv6aaJ8cqRoBfbmp8DRRirVUqK9uIXtrC7YwBJqLsxovdjzkVl9ivHfa4lGeHfGKvfEEFzdfTVZxoiwQGBJuIHjjrntlvKSOsukbCS0eOCDRzw8guO8ipIPQDlBUJW7Gs02dQZ27sAIgK2clHGfBgnwZMTq/zAYx37ahPv02ZHDPM64gV4Hz15aERMpCQP9GjV9H+1WusDN3D1nIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdNVTJHDpkQkP6ftEkWYL/A+7jDdm1SdTHOwdWIXWVA=;
 b=OOGifmRcKT97vvZGcyQJe6pvxhxYmh/hseyMqvJdP+FbhY2HRpKE/t0HVbXW2h8THzQj0/a4ea+4T572C1B6GRUM8gBvHaFGh8fGa9Z70xFATmrfXS3nSIWqV4ZaFzGsZXY+mPOBU5KJz1vxc1W8P3ZJKjN4o3ari/Dc9bc4zgw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2449.eurprd08.prod.outlook.com (2603:10a6:203:9c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 08:47:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 08:47:19 +0000
Subject: Re: [PATCH v10 03/10] qcow2_format.py: change Qcow2BitmapExt
 initialization method
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4eba577b-2c71-79bf-d011-0e2c4d43e8fc@virtuozzo.com>
Date: Thu, 16 Jul 2020 11:47:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:208:14::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 08:47:18 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd78ede-4efb-42a0-898d-08d82964d92f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2449B99A1FB81D62527F3599C17F0@AM5PR0802MB2449.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QZWl5xkWosYdiM7VJSd5xb0qLnFMX/SqDinc8GzFzezW3Ow8xXoN13FaOhx1fgIYoemsIjIX3pnsk4wFzRq7BecH5JM3N70xYfpmmK/B6bMFGnIFVjxQQm2f+n9IxpeS51BcPvK0DXwEQOHCZiFrgSBf2htxFWQ5cpOAdBVLWo9dUWBVl9G0jzMBto4oMwOTEocxBxzenQLZd0tjd88BSDhSHVnG49urvja8AT/WIeLVxE1Wa6lmYzAn73a1z7nDIe8ygVap2bh5kAgLIO9keuXmfDeQ6N1bXm9GYwWiWcpe3Y2tk/4xPXD/Wl3cbPFlb8Nl8asR0Wrd9DTA5ev8lK62cOL60flrn9SLJIFkPqur+pCUkse0dbbGsjMzlDy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(4326008)(2906002)(2616005)(83380400001)(16526019)(5660300002)(186003)(86362001)(31696002)(956004)(26005)(8676002)(31686004)(8936002)(16576012)(36756003)(316002)(478600001)(66946007)(107886003)(66476007)(66556008)(52116002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uyBedQzuVciRBWTjlKhpXPbh0iW7O65sMHjC3TkhqrGRKCJvRYk0872pCy4NyOdSC4nl6HNgVG9DvvEcm/F8MMbncaEqWoIn0L48C0hkxvrinKAoLOzbw1ikG6iB+3tYgVLz7YnFwW212blg4NoOnkyCWzUPkZXOM4nwJYVG/cYngGnh9iwe7QLnt4RsCkASjEvx2Eghle0MXpVBWDY4fpbakNJIiDjd4peTZgNX6Cva8UgsXo2dNaSni4dVTP90ocCZNCVEcNFRtr9SuCTAA1zyBUbWGX2ZQo2n2iih2y4ZvungyKMapj4H3lq50cPj5og9p+sJla2tLOdzUQprR8rz7yGlfbYjFqLprg5Qls5Cv6x+DwO350sHAbgdTWwllvNBUIsRxLzbc1dkm87u1P9vBFJrjoMPRkMYkTKOjh9HH0vUJgw3vdiF7o8Bxhc7+HnWoDbvOOOK8xwbG5tnjmJctDjV3Fi9DFX7Qef3DINHJf3Q8PsLgP1FhXaccwcP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd78ede-4efb-42a0-898d-08d82964d92f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 08:47:19.1240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ficMptYiip3FxnxF8UdKcoAeM1KilIZwQG0yDYqhS3lyW1eWDCCYBhIQr1sODnHna/p2LsxGj2We2yVOtlK4bwi6qdGgOWBDeCikT755ryk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2449
Received-SPF: pass client-ip=40.107.1.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:47:20
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
> There are two ways to initialize a class derived from Qcow2Struct:
> 1. Pass a block of binary data to the constructor.
> 2. Pass the file descriptor to allow reading the file from constructor.
> Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
> support a scattered reading in the initialization chain.
> The implementation comes with the patch that follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 2f3681b..cbaffc4 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -113,6 +113,11 @@ class Qcow2BitmapExt(Qcow2Struct):
>           ('u64', '{:#x}', 'bitmap_directory_offset')
>       )
>   
> +    def __init__(self, fd):
> +        super().__init__(fd=fd)
> +        pad = (struct.calcsize(self.fmt) + 7) & ~7

It's a size of structure rounded up to 8-bytes boundary. But after super init, we should alread be at the end of the structure and need to add only padding, not the whole structure rounded up. I think, correct code should be:

    tail = struct.calcsize(self.fmt) % 8
    if tail:
        fd.seek(8 - tail, 1)


> +        if pad:
> +            fd.seek(pad, 1)
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
> @@ -161,21 +166,21 @@ class QcowHeaderExtension(Qcow2Struct):
>           else:

Hmm, you parse data now only for this "else:" branch. Prior to this patch, it was parsed for "if fd is None:" branch as well, after the whole "if" statement. This is wrong.

>               assert all(v is None for v in (magic, length, data))
>               super().__init__(fd=fd)
> -            padded = (self.length + 7) & ~7
> -            self.data = fd.read(padded)
> -            assert self.data is not None
> -
> -        data_str = self.data[:self.length]
> -        if all(c in string.printable.encode('ascii') for c in data_str):
> -            data_str = f"'{ data_str.decode('ascii') }'"
> -        else:
> -            data_str = '<binary>'
> -        self.data_str = data_str
> +            if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
> +                self.obj = Qcow2BitmapExt(fd=fd)
> +            else:
> +                padded = (self.length + 7) & ~7
> +                self.data = fd.read(padded)
> +                assert self.data is not None
> +                self.obj = None
> +                data_str = self.data[:self.length]
> +                if all(c in string.printable.encode(
> +                    'ascii') for c in data_str):
> +                    data_str = f"'{ data_str.decode('ascii') }'"
> +                else:
> +                    data_str = '<binary>'
> +                self.data_str = data_str
>   
> -        if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
> -            self.obj = Qcow2BitmapExt(data=self.data)
> -        else:
> -            self.obj = None
>   
>       def dump(self):
>           super().dump()
> 


-- 
Best regards,
Vladimir

