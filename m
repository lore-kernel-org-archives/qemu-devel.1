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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D681C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9599204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o/C5TSv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9599204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw14p-0005tF-7o
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw147-0005Lf-PZ; Thu, 16 Jul 2020 06:24:35 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com
 ([40.107.13.113]:57934 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw142-0007HX-Te; Thu, 16 Jul 2020 06:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRaXOq1D2PDRc13gzJJ1J4sWGL8UOgpFRgC/UJ3FR799uEDfIC5ErSEWbbcC1bi1/rwwJRJH3J6MqDgDksIdtzfn3xv+zFDLFKBSKg1hFriMBbiw0g2TpjcvEFeckt9WVSXH1jaGI3hqpP+bf0aTwfA2fPEVlZ56j+S2B/c2wZI2srxYnnSl2nSfc1WxH/+HAeu5dwimp4pr+Bg+nZVxLwwnszzJKNs1QiIBZdofVqrfxuiMbXu76P27dw0JNz3zx0UdZ0eTnTXRS7ba67scX6EtWhJ2MONv79G4AtPJruxdeJ0wm21MbZIHNt+NbolETBnUGEluE3qtyjTwnFXZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lFg1A7BQ8TFRJeIThhCQngcdI+Ws7AAFuPMKIrK3I0=;
 b=HLwmogMOD22CKhWUWVJ0VSzXczFiSRMfGsM5DRCGgt7+s0r4spsxOfrAZkU1UEPmR4AFYvDrzwGNUl84Cruj8hnvaKWqs3uLE6mKudPJIxXNT6NQJPkt5+sk6NsqNJ+Q7x/p0LjRPCCW6pzCHn7y/OKXsXhvIXaOgt18UtgZ3QUfma6XyuWT1ykP4rd+aWWdPuXzFpo4NFjp0OYPNE9IDfILzkSWmYw/ur1dJ/pvYvSytHXQHAclP72K/3pZcWXISEaO8P6vCRi8SJy+fvIIcob+DnX8ybyQM89WPpzv7b9JzJ+Z1h3WN2QKOxlBGbS/Ffbs6E6ogvcNQCWMAI9pbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lFg1A7BQ8TFRJeIThhCQngcdI+Ws7AAFuPMKIrK3I0=;
 b=o/C5TSv8B3BADcDCvlTe7wK8b/N196xnVMn/RKk9DLugQAU6Bl5ienC8JDpnvihOVOkkKCyIYPZvDi2RV4weqBz+Qx5JEEbOv6rx5pOSnojsRpz6UVfbjMCGvZdyM9T5x2D7nD/sHGaPHxSrn2b5cHEAVFXA4xAaeMrt3jTJTMY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 10:24:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 10:24:23 +0000
Subject: Re: [PATCH v10 09/10] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
Date: Thu, 16 Jul 2020 13:24:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0008.eurprd03.prod.outlook.com
 (2603:10a6:205:2::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM4PR0302CA0008.eurprd03.prod.outlook.com (2603:10a6:205:2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Thu, 16 Jul 2020 10:24:22 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8547a763-e5e1-431f-dcfd-08d829726879
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841F69946AACFE6EA602DA5C17F0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXNAgP7mzfM/O+Y9mInM4Q4WFmwQHV/y55u/a1hzzsF4HL209Z/saWCRTpZcyn6J62C+yXZTvE6qvnPSYO7y4/DciAjUJwDBpt/NU9mpTbwNB6Lg/lyKn/eQ5yC07ggY1VKqN16nzOFanKgHzLMI5/WBoaDjdgQr8LloLCfhQzCy6eXim/veNmqUeXJVgq7AAYODEydgwoOOFhQ81Zki67LevzBS6BcUYCPo6yNbVhcfSkvelOdOyY4een2eKHhPAoXc7M0o0n0nsZj6W1z6h9i0uPJqRdg6mQVQZljqi9Y8WJp+XQNdXRQ+BWnENTLVJ3qO7o5DXpH80jDjM3TuPQPToPAssZCEGhQlfTGWjkfjzbcttToigT79lYpYKzJ+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(346002)(376002)(396003)(2906002)(478600001)(4326008)(107886003)(316002)(36756003)(8676002)(8936002)(6486002)(83380400001)(16576012)(31686004)(52116002)(5660300002)(31696002)(956004)(2616005)(66946007)(66476007)(186003)(86362001)(26005)(66556008)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r0Ajz6sxZfDmqNSpub67IlnkhyT9FTKteJLNlj2Xlsjcce1P9VgraDaQBwj8VZNWzTToMADb9Ogmb5FQhlbPs9TrzzV5/SwOceeUwqoDFvoR1ErvNhwuIq7TqZXTNSBi4ANUkThUnb6LtlQP+YutqoLN2cJdMkvX7tT3hHCXxM118mXGZltw/kuucmmyyjnKhmQWrgokMhxbVh+WlCrBRBnwR3KziXx+G++JH1EswI8a+cnMoHbtAAMKuavOiYnwJr5yDTWEkS0EZUuklcrnIO1HZsHVfNM3nYF8JUNPv676N/07p/DCxQ/QqskLWbm4PTvlvokL31/xBbZ60MspLUfj0Q0o805TGxEwA+27a7RZv0rRNpKwUNRqjsiYvcXr/k0ZGnQ2njXomvuIGpFSrP2ww3h8aqaXJ/6pwOdpf4MxA41cktTppIx+cQsdAj8XBILrh2/FFan3dcqyPt+Xtyhm3kF2ivZc6E0Io+GQ7r8t58Ndj8XaXHnqUXjQEpbg
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8547a763-e5e1-431f-dcfd-08d829726879
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 10:24:23.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AXdmLa5BzDZOPAborFrN2XWIYnOe+weEdHcCbAJYv5MEco7fej8NqLtGFaOYFU/dr2DMya5SoZlyLmPL1hQ7GILmasBJKQJSUeoVh6vgjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:24:28
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
> As __dict__ is being extended with class members we do not want to
> print, make a light copy of the initial __dict__ and extend the copy
> by adding lists we have to print in the JSON output.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index e0e14b5..83c3482 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -109,6 +109,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>           self.__dict__ = dict((field[2], values[i])
>                                for i, field in enumerate(self.fields))
>   
> +        self.fields_dict = self.__dict__.copy()

No, I don't like that. Keeping two copies of all the data is bad idea. If you want to select some fields, add a method (dump_json() ?) Which will collect the fields you want in a dict and return that new dict. But don't store object attributes twice.

> +
>       def dump(self, dump_json=None):
>           for f in self.fields:
>               value = self.__dict__[f[2]]
> @@ -144,6 +146,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>           self.bitmap_directory = \
>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>                for _ in range(self.nb_bitmaps)]
> +        self.fields_dict.update(bitmap_directory=self.bitmap_directory)
>   
>       def dump(self, dump_json=None):
>           super().dump(dump_json)
> @@ -189,6 +192,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>                                                cluster_size=self.cluster_size)
> +        self.fields_dict.update(bitmap_table=self.bitmap_table)
>   
>       def dump(self, dump_json=None):
>           print(f'{"Bitmap name":<25} {self.name}')
> 


-- 
Best regards,
Vladimir

