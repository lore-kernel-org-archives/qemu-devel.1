Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0827C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9B7207FB
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZJ7utb5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9B7207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgDG2-0004hl-NG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgDFQ-0004Cu-Cg; Tue, 02 Jun 2020 16:10:56 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com
 ([40.107.8.113]:27905 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgDFN-0005BW-Iw; Tue, 02 Jun 2020 16:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsCGLhVcRDkBfCJSAySYVQBMk8Yx8ONUFaN93FebK8pw6BE02S51bjoLDrBJ9Se3ocH0+aNZcMrQ5IaI9Dhxade8UkSODqanhd2C1oUWbZJCJMNHBYyEY1wxV5zyTvsB72eL/OUJ7doDBFuU7Atx0f0bob6WgOVt2xxKcMdSV4hoRS6uU7L6W4FigHtoCHd0fVmesIVTV9DgExM+daDyqbjvwisg7hWtHlq1cojs/2ULEaN+2Upw68YhCrhLNI0J0C6dCLqgG0ZaH3xgLRM7bE02CWcMssIsqurDw3aAhR+jGs08Qydn1WFtMT1LXvS3Ug3s8DqEIrIAHkFJChU4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMNVsFUTV/o+Xd2HqMTYH5mLlgXeDeSl9PqasjDm+Pw=;
 b=KnF3kde916I9Up9L73yMAOOiaaB7HfgK/1luGaIVgT75ZccJkPC4qRoRVgpQzgy8QXvRZ+GDMM8n9HR7glHVqzHnw+k/qNuwJvNJPpf+J6tyhcogg5z9eOMLUO52gvn0VhvDcI2OF1OkqdStIjDZKd2bga1VZ8kscT/940dVO2x6sJ2oqxLsh4Vs/IVj+2VzHk0iD9HaWcT6xp6itYuGG/yzh3/L2CQod5MJgcafyd+AP+z4cwsA8plkahu0Z2iTwiXdbBIeacTAw0BX19JXBK9SV7rHm9edP+kf75Eef0aLMqQX0q82bISW1xMx02OR8aWtSnsIXLIR5CS022GjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMNVsFUTV/o+Xd2HqMTYH5mLlgXeDeSl9PqasjDm+Pw=;
 b=ZJ7utb5n2K5hoqunMntnVW/yYX2eZ63kI1w1Pq925vMSEZgihTh1OqqVHsCXd4xHk4bbPoztuxgVlLZ+TShWkJVg/TPO/dSVVzQ7Uk6GpOFELoDuRMTEI61cpeTZ+ztYjsmNb1dKz8lY7KGRLNu/tiyKtKSmy9ZZuwp1FhRCi5E=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5303.eurprd08.prod.outlook.com (2603:10a6:20b:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 20:10:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 20:10:50 +0000
Subject: Re: [PATCH v3 3/6] iotests: dump bitmap extension data with qcow2.py
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f3c795d3-ec7f-48bf-ef2a-4d302d351636@virtuozzo.com>
Date: Tue, 2 Jun 2020 23:10:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0107.eurprd05.prod.outlook.com
 (2603:10a6:207:1::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM3PR05CA0107.eurprd05.prod.outlook.com (2603:10a6:207:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 2 Jun 2020 20:10:49 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df945812-da64-40a9-7321-08d807310b59
X-MS-TrafficTypeDiagnostic: AM7PR08MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53036AAAFACBBB9680864516C18B0@AM7PR08MB5303.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V/iPWAukgX7tkjfIgd6XRaHk6doGazPxW75/37UWTnj/CuzLCZAYW7KncELu15jlX3yG0bqGi3hV0O3qqdsYKtS96q3+kG9KAtVsM5/Kq4H2S0Td1T3t+1kybDCcG9AVKrW2jH7b07FVcGahBRmrHHk3ymaxjZOgAw3bBWyKTbsapbE2uT99xrxJRr3emQ7UCxM8MJb13YUxKq3gziMwgTQjg9AMIIwGRfwjfO94lO51mQMY2YyQkZFnEHUkp07KwpEfk6a3onWALCiIODyioFbQD15GQi3isDILrWcGmcqnem/MQ25x/thBckUo+nKkBBXvUYlXY9/IBmjuTkWh7pOyChtAYvUfEgMKcyyVFcKsZgiyQf2CAOBAkXQ+Zh8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(136003)(376002)(346002)(66476007)(66556008)(16526019)(186003)(31696002)(86362001)(66946007)(31686004)(26005)(83380400001)(2616005)(956004)(8676002)(8936002)(107886003)(6486002)(52116002)(478600001)(4326008)(316002)(2906002)(16576012)(36756003)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tvcKCB5Rdpg43837Wl75j6PBKiXhLr1vtWXYl1ooPj1JrGDUzbSR7FmsuF+GHeG8hDMxTMqH3i+GhiOtAJXfqClW8dpYz83eLfPZECQaki1E6okXlixdslj4AxbWPSceixIwFJq23tBnNkHXtZI7jGLvTCg2usgMyJZIjAizv0opHJYWW80UyJ/rt3+A5O6/oanv9bVpm6R1sohcgkh1VgNHFATE8GBEvGoy+J4DxrQCUyqHKI34heDbBLdTs7CBGHe9/HJ4jRf29AbE3tjoZbwd4qWY6HAlnwALEHGDpnBSj8f+Y3bplT8E7BHOE55fOrDC127MGjR0mr58C/kIpmaX7MP8Rw8mUhscPiiXSIQWaBFE9S+JGf1TcA9mGnTKLB1p2gGMG7HFHU+nS6pzKsR6segajy7kLc0VAO6jFcDFFNM0rSylE4h+c5iddMpTeswaKGAwM/mE1o2wNompfvrLULTWGE3+25qBHu+8HGxyNdvK3TC8XzqODJqYmHkN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df945812-da64-40a9-7321-08d807310b59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 20:10:49.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3W3SU1R1RTtPeS3Wb7/wmBYwUsMVLm1dhamY4Qo2oWGyVHfmH2+XmsOwxKjcayPYDkjbhU/Eb2A7Thi5NLaNd/Vny5a0RiAhJlOkbeokeIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5303
Received-SPF: pass client-ip=40.107.8.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 16:10:51
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
> Add bitmap header extension data, if any, to the dump in qcow2.py.
> 
> Header extension:         Bitmaps
> magic                     0x23852875
> length                    24
> nb_bitmaps                2
> reserved32                0
> bitmap_directory_size     0x40
> bitmap_directory_offset   0x100000
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 42 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 18e4923..8286115 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -4,6 +4,39 @@ import sys
>   import struct
>   import string
>   
> +
> +class Qcow2BitmapExt:
> +
> +    uint32_t = 'I'
> +    uint64_t = 'Q'
> +
> +    fields = [
> +        [uint32_t, '%d',  'nb_bitmaps'],
> +        [uint32_t, '%d',  'reserved32'],
> +        [uint64_t, '%#x', 'bitmap_directory_size'],
> +        [uint64_t, '%#x', 'bitmap_directory_offset']
> +    ]
> +
> +    fmt = '>' + ''.join(field[0] for field in fields)
> +
> +    def __init__(self, data):
> +
> +        extension = struct.unpack(Qcow2BitmapExt.fmt, data)
> +        self.__dict__ = dict((field[2], extension[i])
> +                             for i, field in enumerate(Qcow2BitmapExt.fields))
> +
> +    def dump_bitmap_ext(self):
> +        for f in Qcow2BitmapExt.fields:
> +            value = self.__dict__[f[2]]
> +            value_str = f[1] % value
> +
> +            print("%-25s" % f[2], value_str)
> +        print("")
> +
> +    def dump_ext(self):
> +        self.dump_bitmap_ext()

Hmm, don't see, why this can't be one function named "dump".

Still, I do think it should be moved to parent class of both Qcow2BitmapExt and QcowHeader,
I'll send refactoring follow-up, so it doesn't really matter now.

> +
> +
>   class QcowHeaderExtension:
>   
>       QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
> @@ -13,12 +46,16 @@ class QcowHeaderExtension:
>       QCOW2_EXT_MAGIC_DATA_FILE = 0x44415441
>   
>       def __init__(self, magic, length, data):
> +        self.obj = None
>           data_str = data[:length]
>           if all(c in string.printable.encode('ascii') for c in data_str):
>               data_str = "'%s'" % data_str.decode('ascii')
>           else:
>               data_str = "<binary>"
>   
> +        if magic == self.QCOW2_EXT_MAGIC_BITMAPS:
> +            self.obj = Qcow2BitmapExt(data)
> +
>           if length % 8 != 0:
>               padding = 8 - (length % 8)
>               data += b"\0" * padding
> @@ -172,7 +209,10 @@ class QcowHeader:
>               print("%-25s %s" % ("Header extension:", ex.name))
>               print("%-25s %#x" % ("magic", ex.magic))
>               print("%-25s %d" % ("length", ex.length))
> -            print("%-25s %s" % ("data", ex.data_str))
> +            if ex.obj is not None:
> +                ex.obj.dump_ext()
> +            else:
> +                print("%-25s %s" % ("data", ex.data_str))

this change make it more obvious that this should be method of QcowHeaderExtension.

Still, this works as is, nothing serious:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

