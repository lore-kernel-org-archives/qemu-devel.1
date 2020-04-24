Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A37C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77A720736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dkdSo6vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77A720736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu6l-0006V9-Rs
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRu5q-0005E7-TZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRu5o-0002Sy-Tl
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:53:54 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com
 ([40.107.5.123]:20351 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRu5o-0002Qk-5R; Fri, 24 Apr 2020 04:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZbUu2JeY4k3mAivk+6Y1tE/IVANHUKY4iJIu+9MbHw7loYEN+UqELcwknpozJzcrQDlkEA7EIxds/Ldpxueb8sPAF+wNYIpbjaoeOzbslWxEAKUI2Ke5r7dMnK3w/ixosUvFGzDKvQQxdOxszctOiyKD+kHKfDPpjRCeJ/BPPY7Zut1mEa2eQxukR6c2mENW/ExH1ycr/epOCxJi334F8kFZIw5xjLQmJfUHRIJSBbrq8VnYWcwGK/sJ92Ywz+ndU5zJvn1t0F8LH3vFBH5POsCY5BvFRWKTn3DxCqEdiXiqM8d2UsDlm3L4Qd/9BDVt6o+T/no3Ck/GViXhNJbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcfQbjN4qCdNVXPB9zcs1KG6/isexyOegU3mb/TksVc=;
 b=F5fqfAWTWnzPz/f0X33GPjk49WYvVWj0N0G6vf/8OKDcIWz0ovWur8T5E1FLPh2FXnpmGdFwh36Ve8b2SbNxlsqH+gHk47wNnOiq2hphSXkKQLYFNznKeVxYr3CEjhLY9nOovres/54wHi///VvpY+0RlqMY1cHCmMt9BOsddrxUOACwrEYNvjXCf3oZectMVAwhNfGrRgZ4JM7gzr9se1jNqvFJ7pcE9aCucxLNZJB/CdCvl+ad62eCAIn3u7bZNdozrxHhhzISvmOub+aYi8xdRNPstqBcf9RaZ+nzEoXBN711Irsed46IL4uQbQjxhAvvpPKoJ5kGW7zIXiWmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcfQbjN4qCdNVXPB9zcs1KG6/isexyOegU3mb/TksVc=;
 b=dkdSo6voTg9PtVWuF3ZV6CxITlzF3CBsxe07EY0TnCZI+swvVDTNtDPXJR/DiFW/tltHp3PkigS8J3n4zcp3BJU63O9k27UOuqhs1AVDm/qPUsRQP5tuJ00c+XTr4WhmHAMnLMFLi7zQulQ+xOZzc6lFbETJVtuJ68CrQNUof7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 08:53:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 08:53:48 +0000
Subject: Re: [PATCH v6 09/10] iotests: Test committing to short backing file
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-10-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424115344207
Message-ID: <ef721906-8ea7-b86e-f47e-31a85122d1b5@virtuozzo.com>
Date: Fri, 24 Apr 2020 11:53:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200423150127.142609-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 08:53:47 +0000
X-Tagtoolbar-Keys: D20200424115344207
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e915fcd0-bafb-44b5-0472-08d7e82d00da
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5301058FEA5F541B68DCECC4C1D00@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39850400004)(136003)(5660300002)(66946007)(478600001)(66556008)(31696002)(36756003)(6486002)(66476007)(6666004)(86362001)(8936002)(52116002)(4326008)(2616005)(956004)(186003)(2906002)(81156014)(16526019)(16576012)(316002)(8676002)(31686004)(26005)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnAqMGggzgDgcyvV+pKC0F8VESVi9RhhlJHX9zIQOEIjGo6BY23z61uorSiwuyDqw8upEby2rftcpSP9ivCbtD4E327Hb4oBXxVQ08NddWw4nici690uAekhuhyRRg4BcuSkD5Hi/q0K/TEvT850You36yzmSYyfHgtZbYknHO5JN7TLKdFvvYzW6vAbRAjQA9QiTxoFvnm4R9n/rKI1F6/hnHg3y6XN9Zb5dYZHOVVP2L+Lzb1TxEf6L07qq7GJxuspiF6XVDHVqqdBGKXtBJBXdIifyBLJieMQsa+Amwi4l7kReA0mXa94eYDglSn9Wcl0viDoy8ouoHli3uHZzBKlgO9NYzUXXuTRAbwnok+toa2KOzuQi+5MdHDm51hchLespMCg58q0bBDKj8FH4iom3UvSUsUEItEkzjzKUTqaJ3s2TU36x2edSLOrQF4xwbiL4g8ECxanWfCYPq2pL0CthVFk2wAd5vOoS6UAN2Qla1NL8Avl8ajGhN3W7933cumyK3lJrhLiR5El8sQGnL85x9OIE5JxA7Xz/UWRAAcwaHXmIZ0n1hiifywwIoYc
X-MS-Exchange-AntiSpam-MessageData: gc9LmXwuT1b0TfU3Rm//E4Rds1HvXuwHk2N4+gvCYklXupZamycsGyBhOqG8ue7ulAQEGmdcMXxfWPYuTmwXpmd1d5DEQN2l3dwGvZ3HLmI/NZFwK48XCvoxDFi0AhdmWC62Hdx2NJCVjTVn02p5hw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e915fcd0-bafb-44b5-0472-08d7e82d00da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:53:48.2978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEuBeS9tjjWpXTPiPz/ruBgsQVL6TY4qhLOlLCXA7oq9+avONuTeC9/lbyRwToTvDbNyiIDkrqxwyaL8mN+ZUKtkK0IKIqVWG6d6nBak82c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.5.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 04:53:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.5.123
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.04.2020 18:01, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/274     | 157 ++++++++++++++++++++++
>   tests/qemu-iotests/274.out | 260 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 418 insertions(+)
>   create mode 100755 tests/qemu-iotests/274
>   create mode 100644 tests/qemu-iotests/274.out
> 
> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
> new file mode 100755
> index 0000000000..8bf7ff3122
> --- /dev/null
> +++ b/tests/qemu-iotests/274
> @@ -0,0 +1,157 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
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
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> +#
> +# Some tests for short backing files and short overlays
> +
> +import iotests
> +import os

unused import

> +
> +iotests.verify_image_format(supported_fmts=['qcow2'])
> +iotests.verify_platform(['linux'])
> +
> +size_short = 1 * 1024 * 1024
> +size_long = 2 * 1024 * 1024
> +size_diff = size_long - size_short
> +
> +def create_chain():
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
> +                         str(size_long))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, mid,
> +                         str(size_short))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, top,
> +                         str(size_long))
> +
> +    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
> +
> +def create_vm():
> +    vm = iotests.VM()
> +    vm.add_blockdev('file,filename=%s,node-name=base-file' % (base))
> +    vm.add_blockdev('%s,file=base-file,node-name=base' % (iotests.imgfmt))
> +    vm.add_blockdev('file,filename=%s,node-name=mid-file' % (mid))
> +    vm.add_blockdev('%s,file=mid-file,node-name=mid,backing=base' % (iotests.imgfmt))

over-79 line

> +    vm.add_drive(top, 'backing=mid,node-name=top')
> +    return vm
> +
> +with iotests.FilePath('base') as base, \
> +     iotests.FilePath('mid') as mid, \
> +     iotests.FilePath('top') as top:
> +
> +    iotests.log('== Commit tests ==')
> +
> +    create_chain()
> +
> +    iotests.log('=== Check visible data ===')
> +
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, top)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), top)
> +
> +    iotests.log('=== Checking allocation status ===')
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        base)
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        mid)
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        top)
> +
> +    iotests.log('=== Checking map ===')
> +
> +    iotests.qemu_img_log('map', '--output=json', base)
> +    iotests.qemu_img_log('map', '--output=human', base)
> +    iotests.qemu_img_log('map', '--output=json', mid)
> +    iotests.qemu_img_log('map', '--output=human', mid)
> +    iotests.qemu_img_log('map', '--output=json', top)
> +    iotests.qemu_img_log('map', '--output=human', top)
> +
> +    iotests.log('=== Testing qemu-img commit (top -> mid) ===')
> +
> +    iotests.qemu_img_log('commit', top)
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
> +
> +    iotests.log('=== Testing HMP commit (top -> mid) ===')
> +
> +    create_chain()
> +    with create_vm() as vm:
> +        vm.launch()
> +        vm.qmp_log('human-monitor-command', command_line='commit drive0')
> +
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
> +
> +    iotests.log('=== Testing QMP active commit (top -> mid) ===')
> +
> +    create_chain()
> +    with create_vm() as vm:
> +        vm.launch()
> +        vm.qmp_log('block-commit', device='top', base_node='mid',
> +                   job_id='job0', auto_dismiss=False)
> +        vm.run_job('job0', wait=5)
> +
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
> +
> +
> +    iotests.log('== Resize tests ==')
> +
> +    # Use different sizes for different allocation modes:
> +    #
> +    # We want to have at least one test where 32 bit truncation in the size of
> +    # the overlapping area becomes visible. This is covered by the
> +    # prealloc='off' case (1G to 6G is an overlap of 5G).
> +    #
> +    # However, we can only do this for modes that don't preallocate data
> +    # because otherwise we might run out of space on the test host.
> +    #
> +    # We also want to test some unaligned combinations.
> +    for (prealloc, base_size, top_size_old, top_size_new, off)  in [

extra space before "in"

> +            ('off',       '6G',    '1G',   '8G',   '5G'),
> +            ('metadata', '32G',   '30G',  '33G',  '31G'),
> +            ('falloc',   '10M',    '5M',  '15M',   '9M'),
> +            ('full',     '16M',    '8M',  '12M',  '11M'),
> +            ('off',      '384k', '253k', '512k', '253k'),
> +            ('off',      '400k', '256k', '512k', '336k'),
> +            ('off',      '512k', '256k', '500k', '436k')]:
> +
> +        iotests.log('=== preallocation=%s ===' % prealloc)
> +        iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, base_size)
> +        iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, top,
> +                             top_size_old)
> +        iotests.qemu_io_log('-c', 'write -P 1 %s 64k' % off, base)
> +
> +        # After this, 0 to base_size should be allocated/zeroed
> +        # base_size to top_size_new should be unallocated with

the comment is outdated. base_size to top_size_new is allocated zero too.

> +        # preallocation=off and allocated with preallocation enabled
> +        iotests.qemu_img_log('resize', '-f', iotests.imgfmt,
> +                             '--preallocation', prealloc, top, top_size_new)
> +        iotests.qemu_io_log('-c', 'read -P 0 %s 64k' % off, top)
> +
> +        # Metadata preallocation doesn't have a defined result on the file
> +        # system level with respect to holes, so skip it here

this is outdated too, as we should have zeroes for any case now.

> +        iotests.qemu_io_log('-c', 'map', top)
> +        if prealloc != 'metadata':

so, we may drop the condition and print 'map' always.

---

I've looked through img/io "map" outputs, they look correct.



-- 
Best regards,
Vladimir

