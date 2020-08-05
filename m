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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1448C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DC722CBB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Frg02ZpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DC722CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3IGe-000146-L1
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3IFr-0000bp-H6; Wed, 05 Aug 2020 08:10:47 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:62240 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3IFo-00028q-KH; Wed, 05 Aug 2020 08:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih7COnIdoUeKYzdRyvd4sKtH5JVo4T/rEJJUYOGmr/nAqOgYnnfP9ZEXAekq/nwrWs+v46rrwtBdW95AcrVEMvr9V9aMeMFT6zDP8JhEwlfP5M48Lv5z5+nvqhseEnCJQTEmxC/kelcIMH5FOlF58JSeV69IZjqSuoB2ukUqD2qh6KhNnWUL4WXl/IcocfpPw/KxS1Mjse4N9b8K77OXJSLW+PQGlSxzpTSsvUd3ItXeK0nd+p0BXQTmr96BvSfKZaYfMKn5cco3/V8a+0rwD1cYpQvEV5eM0XA2KGC5o1J+vQzuiknXRMjpYfLN7AELro5ClyhCALQxYcPAiJNGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPE045jZlMbbkvgCb/LO9kd/DoNeBfbtiZY1ItZPA90=;
 b=B3aGFntd4+1nFcMMTcOSfeO6m95tHTWjKHCIf3/hSEm7r4Bbfia3sxXsLb6sqRPjL/ANW5zDazzp8xZfiE0JZfspbW4r4MnDgTCfeAiAWMVagE/zaf1IQT7LNCcAnfN29erXTQxVsz01IFC7+CRhR+tkn7kNujYgnMu6Z3CPliXj9je0T3z+NDlAy2GXkyQ66npgfu8UOtqViuDQLwFSaQYp18oALytj4+rH1geZ/yo6FcwE4B/LIUm9VUzWAbrKy9vfDgBwxTsciwZm/XlOxuTLKUFohnyzLoPafu3ZEbuutZAz2wZa+Eqe8AYjrktjdvzkLNdVPt5Rdk5Mvm7FJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPE045jZlMbbkvgCb/LO9kd/DoNeBfbtiZY1ItZPA90=;
 b=Frg02ZpLEnS09sPhtkZzyY5i6Q8ZDzA2k9xgVfq1B38Ei0IeFlrrxa1Sup65FsXNVtQtZCM4Ypx9UEdGUF2v1k4ufSfj4cOKMhD6szJyYKRQvOCrBj0jENBxfb1w/5JzaidHnsm8GL5V+Tt9A3FdFf+ix06bBQW/MQyJruplGr8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2778.eurprd08.prod.outlook.com (2603:10a6:7:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 12:10:38 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 12:10:38 +0000
Subject: Re: [PATCH v12 01/11] iotests: add test for QCOW2 header dump
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a7b1f113-a3b0-2026-b087-5d9865b183fd@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <5f6fd94a-173a-48e3-bc48-369f7f947c30@virtuozzo.com>
Date: Wed, 5 Aug 2020 15:10:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <a7b1f113-a3b0-2026-b087-5d9865b183fd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::33) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Wed, 5 Aug 2020 12:10:37 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d0c292-be9b-4020-f832-08d8393890a7
X-MS-TrafficTypeDiagnostic: HE1PR08MB2778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2778222F80ECF835550F6BCFF44B0@HE1PR08MB2778.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nERm73zmRPOtWrRZtmGkHLBz+ZomJof5ZUheEI26Q6xKkerITh/ObH7uE/ijCF7Dx26He0yg9pEEOMtxOC+TdUv+UeWZpQyBc/t1o09G60Bm8Ep+oSG0ipS7XpEJbfRFZTA93vDDhUmpi+HyenFmWyA5cm9uHmkR9bLimX5nzMlK2tFqo8fwZokek+ZdSfRuAz6NtZp7rqMP1TV8bCSUzoHqdocfZvfnCoMFxqjkAMaa78TYmy48fkFIFJO5FqDoXa1k8QNvRhtLzFnpZDzHNZRGutLzIGNoV0Av5as/MQIPOJCeRQjLFpac4l/F/RcJiuTxiJNZcaU4tcX+ciArzPEY58jqaNX6fM5iJ2kImOUt609B4sVRE4MYhcEjQJocnx4g7JgE0378CUYVzP2YqYzUshyslI9z/Vq3XN13iHdSudDfnxE+BWIzYpIcFXh5ySiuYhq4Fy4zeEzLge/Lj2TBADcxRtgkz5x549nRgOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(366004)(346002)(396003)(376002)(2906002)(956004)(2616005)(6506007)(44832011)(86362001)(53546011)(66946007)(6512007)(8676002)(5660300002)(316002)(66556008)(66476007)(36756003)(4326008)(6486002)(478600001)(107886003)(8936002)(16526019)(83380400001)(52116002)(31696002)(26005)(186003)(31686004)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QdUJH3DzDhfkFN14f5Eiz3rgwhaER82CDnfoTJnu52jllPVi50jIntzumxk5wdeFAqEUQIndfFha4VSn9cKSOoWc7J3h1HPE6NcKSnZ1BsISW/PEI/7OJ+o0kUfojcHvoju8SWFLs+a9FzKYnnwM/l6E677BsmMBThzM6zkLXsba6U0YSlte5r4w3FhzElJRzivIgvhKm7UZ5bv5RaMkjDBcDWzPp9V0PgzphMpVNXfDj+Ydf/AOtRCut4IclVpsYYH7doiVmo/LwsSrnFNw9mV40N05lmLobf2WEzQvSLRatUZfzDSEgLXw54SAUAVGFZFjGXrtkduuOI+gzTtzWAcusVGHLJsmrIAAX0hZ7zWPprg+yuSwOdxPVlYFJmYCr1usJd+SRsE6y6IS5EDOhyk0z9WVy+x98d2HWNE3DLIzE0tYqsV1Lx1JY3G69U9Qh7JJX2xGfZovvCss7boEPJx9X09hgUtxHEl0ZNWpPLhIUMXHGRrOGqeRSPGa3UjnBvnyXfqgX0GSmDrVOO0qOpusgmc6WpM1mDWv3Ry7ZqrG/trPPXrLeNIVlHeJzJE/v9wceprsWFWZyAMH5zh9VL57JDkYuE0rxWIy8kKX+pakNwPf+WuiplYFgKK+WEdRlalNiCT8xRvJt1TiIcv7jA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d0c292-be9b-4020-f832-08d8393890a7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 12:10:38.3203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAxYuzOXmg7qONiWlNfkuWOSoaQ1ixsVHoJxZQYcGZ1i2IiXf5UAnPJFU+fKbH2fILbb+fC+LOt4OC3xvPySZEak9VopM5sQX7Jy83JtLH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2778
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 08:10:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

On 05.08.2020 14:23, Vladimir Sementsov-Ogievskiy wrote:
> 30.07.2020 17:15, Andrey Shinkevich wrote:
>> The simple script creates a QCOW2 image and fills it with some data.
>> Two bitmaps are created as well. Then the script reads the image header
>> with extensions from the disk by running the script qcow2.py and dumps
>> the information to the output. Other entities, such as snapshots, may
>> be added to the test later.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/303     | 59 
>> ++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/303.out | 64 
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/group   |  1 +
>>   3 files changed, 124 insertions(+)
>>   create mode 100755 tests/qemu-iotests/303
>>   create mode 100644 tests/qemu-iotests/303.out
>>
>> diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
>> new file mode 100755
>> index 0000000..3c7a611
>> --- /dev/null
>> +++ b/tests/qemu-iotests/303
>> @@ -0,0 +1,59 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Test for dumping of qcow2 image metadata
>> +#
>> +# Copyright (c) 2020 Virtuozzo International GmbH
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +import iotests
>> +import subprocess
>> +from iotests import qemu_img_create, qemu_io, file_path, log, 
>> filter_qemu_io
>> +
>> +iotests.script_initialize(supported_fmts=['qcow2'])
>> +
>> +disk = file_path('disk')
>> +chunk = 1024 * 1024
>> +
>> +
>> +def create_bitmap(bitmap_number, disabled):
>> +    granularity = 1 << (14 + bitmap_number)
>> +    bitmap_name = 'bitmap-' + str(bitmap_number)
>> +    vm = iotests.VM().add_drive(disk)
>> +    vm.launch()
>> +    vm.qmp_log('block-dirty-bitmap-add', node='drive0', 
>> name=bitmap_name,
>> +               granularity=granularity, persistent=True, 
>> disabled=disabled)
>> +    vm.shutdown()
>> +
>> +
>> +def write_to_disk(offset, size):
>> +    write = f'write {offset} {size}'
>> +    log(qemu_io('-c', write, disk), filters=[filter_qemu_io])
>> +
>> +
>> +def add_bitmap(num, begin, end, disabled):
>> +    log(f'Add bitmap {num}')
>> +    create_bitmap(num, disabled)
>> +    for i in range(begin, end):
>> +        write_to_disk((i-1) * chunk, chunk)
>
> a bit unusual to count chunks starting from "1"..
>
> also, any difference with just
>
> write_to_disk((i-1) * chunk, (end-begin) * chunk)
>
> ?
>

QEMU-IMG limits the maximum number of bytes written with one command by 
... 2M, if I am not wrong.

Andrey


>> +    log('')
>> +
>> +
>> +qemu_img_create('-f', iotests.imgfmt, disk, '10M')
>> +
>> +add_bitmap(1, 1, 7, False)
>> +add_bitmap(2, 7, 9, True)
>> +dump = ['qcow2.py', f'{disk}', 'dump-header']
>
> No reason to put disk into f-string, it's a string anyway: f'{disk}' 
> is equal to just disk.


Thanks


>
>> +subprocess.run(dump)
>
>
> And you may use just
>
>    subprocess.run(['qcow2.py', disk, 'dump-header'])
>
> without additional variable.


Yes, but further adding the '-j' key to the list looks more elegant to me ))

Andrey


>
>
> Still, I'm OK with it as is:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>

