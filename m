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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193C722D04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bUffhTVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193C722D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3HWX-0005ow-9h
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3HVw-0005Jx-Vi; Wed, 05 Aug 2020 07:23:21 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:25733 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3HVt-0003nA-3k; Wed, 05 Aug 2020 07:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ13/Uyml7e/hpwFeDmYOdZZRbU0CKHPVp7yqMqCZ9kz2POxr7Oov5kzSlrYevjQ00dRaoXPuD38/xf6IDVrolm3gRkuLRhPUmydyKTyUIAv/4dlJ/TdxFzKLFpm5AgUfzq38tsMOhoJMdetjlcW2VyABi/zfUVyZFT9I7HOD007q5Uy96xa6smMi2FWfxeoD/CWCS8VDtT4retSB5CIpBhkdxaXqUuUmaXRt5Xt1VKxyQBq+JxDvZjvx6qjImEc3uxGooYhxoXVpCFnYT8o3C8gh+L6lkhjz45xXMTwBxxlZKI8qf7j6CUZWLapS4GIr4skchZftW/pE1PFMN1rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoI8MbxeQViWB3tn2WZ40901Ia3JOJlNyjHfbCCGRJk=;
 b=DEGJrnypP5ShaxC70wsdD40Z/D9bniVxJzMx9HTCdnIz1L4SmqLSiX3cueohnM14UMgvuo513wKSM/Xm7lQlAbKBQLt7vUKQwKgX3okszgwommhkU1b2UyG96HH2h2rCNYsMmSbZgpGVrGqyCk+x7pcOZ8/cDrley9TWsIwkIWD1P9A3n9teAmNyd2t7JQu42HjevkfJvKAfqYZ+Vt2bZSNyNlt2ZkoFgQgcCvJC+Ox9tVtUeMpwKVmIVowwuL32AMneT15CoYEPSKVGm3dTBx47IujzSi0z4CtC2C1U5d+g3J2+IB0k7emupKT+dGwtskM8B49h8T9NrFNqJsIaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoI8MbxeQViWB3tn2WZ40901Ia3JOJlNyjHfbCCGRJk=;
 b=bUffhTVBrxseVvpTFHji4zuo9Jwdz4hIGJYKU7AlQ8kgw6YYfTOuDHdzIDVwBuNWd+0aVIzj/2xKZDaxFVHfaGaWc2NA01elDEnoak+l9xUH6tQhiqqpxqAbCAtU7QRyCo7cbixw6i1YCtGruB7n5IDvPtr0J9pyWUMOQRhyq3o=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3765.eurprd08.prod.outlook.com (2603:10a6:20b:8f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 11:23:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 11:23:06 +0000
Subject: Re: [PATCH v12 01/11] iotests: add test for QCOW2 header dump
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a7b1f113-a3b0-2026-b087-5d9865b183fd@virtuozzo.com>
Date: Wed, 5 Aug 2020 14:23:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 11:23:05 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793e2772-7df2-4fdf-92b0-08d83931ecc8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3765E97B08E84AE7BDDAF27FC14B0@AM6PR08MB3765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/nwevkKHIL3hKy/qj9KEwlVaewwkS9YC9MAtWIt/OH/pyuuAy3U/DBXLLiUU9c0LQh8tgGiELJBv+2YkSxtZe8EsGOepny5fMbR8QO1Xfr+XztW+HplJnwUIySYEgSRnlAhg+56uKcIw8ad6hKoG+scBNc06GBBigM4lOiIB6EVxWAJvj6n3f+fxW20fNF3BEHP6y2PjczZOxi4Y4OAp0mCv6rYyqCXKAVyUvQyX/gExxNimPM6wHl/LuvP1tcGZvLb0+CEXTs2Z6sbYZD6KcXvCIbJkRo/HTZIxzZBnOUZuw4UufE0cGGAuud5Us6Gstn3Kf/pbtNgrEYuakfezMdMDXRAoeYIaXnZuu1IHQP8DQApEwxlykFmbB+VRBLz7cpMQ38NBU6+PDimYawKN6Jr8ilWK1RlUIbvVp6Vr5MBz3GG8bZzakxBDqB2jsRnPD0AcibTgkCIvqWtxgqUX+UedeesQjYzeETVbn8MkF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(376002)(136003)(366004)(396003)(16576012)(36756003)(52116002)(5660300002)(316002)(6486002)(31686004)(16526019)(2906002)(478600001)(186003)(83380400001)(31696002)(956004)(2616005)(8676002)(66946007)(66556008)(8936002)(107886003)(86362001)(66476007)(26005)(4326008)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e9XHmc/75AVOijMZgPVAJ7aUafvfRK0bUAvd9e8pfvnzld1ULZzIQMS8yAJx3GABfBLvzwIRe5zGawb2v94U33AuJ+z5qeSZmB0A25vFSWVMI+UQypsxtaoAtU7aCmQegpautL8tAWp4r28wjexSnjdPnJxF4tFjQMNLyYS738fuoagDKd454dB346apURVQKBwpHOCa7rfI+SyTHSsv3u552OzVk+qQKkMW8XeUiNjxUrJsAQ5F0l2s3q+Cb7yWSUAOORR5w21wcIWkbnNI9PRrQQWhEIbAoC9+74j9Zddx82RNlYVX3h++QLWuRIq4JUVmh55u0QOLLwgNdD+6ir4Q/bz/LaWHZ9VYcMVuk6WJxRHDITG9mR/p3UWPZhV11+t9NEq9FSIu9MjIGmEsIVAdUfR/ERetYSCbVEfhMsxSI1+o+60wGNYqVAQrMsIOhdjKHZOLqPFw1LG7bbk7znHio5RKRy/EvTCk770ejfy7kzVvmGI+241r1MF3SmTNwzbGcgJ4dqv1zghsWbNe1JlVUyODofMdNh0Upl1He3IzreUYdeB1rXu8pl8jsb424zhmU8ca6VdrQxkIj/xwbid45NC4BdXtWTvelqglg3jruuZ8iz6mdgr4djb2kqjh+WIuPN4F7qVY92cJsLpiVQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793e2772-7df2-4fdf-92b0-08d83931ecc8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 11:23:06.6472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRdWOyKCl9kaCHRDZsdjWwQrLois1ATe2ZWdiWUHFyDzeb7gkHgSOHCc5m5CNSew0ct7MPPUqlePFynnPrJhwWIBZceLqdrWhkk5ZLdfCTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 07:23:14
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

30.07.2020 17:15, Andrey Shinkevich wrote:
> The simple script creates a QCOW2 image and fills it with some data.
> Two bitmaps are created as well. Then the script reads the image header
> with extensions from the disk by running the script qcow2.py and dumps
> the information to the output. Other entities, such as snapshots, may
> be added to the test later.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/303     | 59 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/303.out | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 124 insertions(+)
>   create mode 100755 tests/qemu-iotests/303
>   create mode 100644 tests/qemu-iotests/303.out
> 
> diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
> new file mode 100755
> index 0000000..3c7a611
> --- /dev/null
> +++ b/tests/qemu-iotests/303
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# Test for dumping of qcow2 image metadata
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import iotests
> +import subprocess
> +from iotests import qemu_img_create, qemu_io, file_path, log, filter_qemu_io
> +
> +iotests.script_initialize(supported_fmts=['qcow2'])
> +
> +disk = file_path('disk')
> +chunk = 1024 * 1024
> +
> +
> +def create_bitmap(bitmap_number, disabled):
> +    granularity = 1 << (14 + bitmap_number)
> +    bitmap_name = 'bitmap-' + str(bitmap_number)
> +    vm = iotests.VM().add_drive(disk)
> +    vm.launch()
> +    vm.qmp_log('block-dirty-bitmap-add', node='drive0', name=bitmap_name,
> +               granularity=granularity, persistent=True, disabled=disabled)
> +    vm.shutdown()
> +
> +
> +def write_to_disk(offset, size):
> +    write = f'write {offset} {size}'
> +    log(qemu_io('-c', write, disk), filters=[filter_qemu_io])
> +
> +
> +def add_bitmap(num, begin, end, disabled):
> +    log(f'Add bitmap {num}')
> +    create_bitmap(num, disabled)
> +    for i in range(begin, end):
> +        write_to_disk((i-1) * chunk, chunk)

a bit unusual to count chunks starting from "1"..

also, any difference with just

write_to_disk((i-1) * chunk, (end-begin) * chunk)

?

> +    log('')
> +
> +
> +qemu_img_create('-f', iotests.imgfmt, disk, '10M')
> +
> +add_bitmap(1, 1, 7, False)
> +add_bitmap(2, 7, 9, True)
> +dump = ['qcow2.py', f'{disk}', 'dump-header']

No reason to put disk into f-string, it's a string anyway: f'{disk}' is equal to just disk.

> +subprocess.run(dump)


And you may use just

    subprocess.run(['qcow2.py', disk, 'dump-header'])

without additional variable.


Still, I'm OK with it as is:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

