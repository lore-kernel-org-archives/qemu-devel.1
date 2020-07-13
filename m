Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E105C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6B320738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rYspEhe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6B320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxee-0003FW-Tx
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juxdt-0002jS-5A; Mon, 13 Jul 2020 08:33:10 -0400
Received: from mail-db8eur05on2112.outbound.protection.outlook.com
 ([40.107.20.112]:39520 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juxdp-000183-SQ; Mon, 13 Jul 2020 08:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjcZiFZMHa7kNsDWYeh9CGfR8z/EqR73X/fX2FrR7tv29/N/2YlmCuDnN/92uvgX+rpKDshLch7pLuXEpnV3Hu989WXsU8T4ZbX6QVaWwu8Y3+FFxiJ52303IIAU9pwWKWyA5VH5sDTV4pTnUX3gSVnzyhx6i9bCxEVt/wJqCLyV/06329eOqYmtQ4jCNVeZJMCN6nGMyqe5d7QY6h+Ki0jeWfEk86TlfVXGt3/pS4jZ79GX4Gyx+J88uTZNcey4IGPQNr8t/4SMSv1wfLOVzDb5HHBfX3o/sNU0EWXvJX4ihzBxVetItPMJYDIJdPZEN77iiqP03x79ATSlg5UDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqT8jetWJzP6s6gmbFRDMpLrbHuQnAkzGLIM2KzPOvQ=;
 b=UMVY9zp+RY/pxDSW1/2uxJVmMn4iCdWpYOb5xASW6UE+kQL43qOw4Qo7jx7ObhthAyk1FK9wHEgdCMJ9EVzgVbkWI0w402ClWty8TnVtWVCQrk66sIO2grjnkueHd4YDAVZsyq5Y/QnR+SSDqhgeZ6FFfqWm6+WB8A5XG4lOliVZCFKJIVvz581EIKEcEMCmIVKEeQu0v9gXZjcBGgv/NewEDyVpmBuRdx+ajKJypD6+efm5DJeOGKst5tApE1ZitYW5tGtPP4BHIpLDtN8HqA/0X9c4kth61qhjplo42YyAA8RWn51pMSIqRIjh1g0JdiPv026Po5zAE32MQN349w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqT8jetWJzP6s6gmbFRDMpLrbHuQnAkzGLIM2KzPOvQ=;
 b=rYspEhe8hC8EauzlgaDl1VBiBK85Ba9jTB7lKWnVO23PR1oe8Y9DAqYikaTrEki4UPzw3pMWjkpPvbFtWmd+DOduVuVVYQnNtQdwg6zTe1LqRcOUxHOismymFrNwy8lphRx1vMbH7FyIF32k3yaFz4u44MSV0mOi5ttXwfNdkbg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3543.eurprd08.prod.outlook.com (2603:10a6:20b:48::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 12:32:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 12:32:56 +0000
Subject: Re: [PATCH v4 1/3] scripts/simplebench: compare write request
 performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594576158-75884-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594576158-75884-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <24fef7f3-d59b-49c5-de8b-8298f9dadf86@virtuozzo.com>
Date: Mon, 13 Jul 2020 15:32:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594576158-75884-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0106.eurprd03.prod.outlook.com
 (2603:10a6:208:69::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR03CA0106.eurprd03.prod.outlook.com (2603:10a6:208:69::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 12:32:56 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2e365d-ea1f-4caf-74cb-08d82728def2
X-MS-TrafficTypeDiagnostic: AM6PR08MB3543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35439889B35877CAD1FDAB12C1600@AM6PR08MB3543.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCRsioBgYZKGq6QL2tA0brjUKdPxl+odbsCeYipjQyjbQ+uTKOMqJlsNFM89RsQxZ8Yn9ob5yN4gMWcvpjoc06FwK3iAEhFCfmd4elBq5dRKGz9P0MnlrQQDqcYn/QljBk+IM8npmcPqmCGtPFVHWmR9tHIJCXANaySIuMvGuuYFf182CDCe08w3Nd1SeiPIwrw8LKq0dD2Bh+u9+A1NJK6bFZ3GpjRIs2w7kutiH6p7QVwzIkl5hNaDmcgG5SQKMdsFX0kYg5T3O7LkvHg13neAcVzsya4EyuByIGocbFNErMUGYcpUp7rUHV86vWO0RXrqb2FRI8Q/taj3KoA8spgrgxDBvK03FGw85hjcNrwO/diy152/c4TkFoRiOo3tz4H2TwY1+bJztRFijjehtmHwCL/ekfnXHBDWjTEJnaxXtlE7UVseMKxioZIZr3tQHYqOXoB4myyKEy9xTzNF4L+YLNO2383JEX6/MGt6d0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(346002)(396003)(2616005)(316002)(6486002)(36756003)(2906002)(31686004)(4326008)(956004)(16576012)(66556008)(52116002)(107886003)(31696002)(8936002)(66476007)(83380400001)(66946007)(5660300002)(186003)(26005)(16526019)(86362001)(8676002)(478600001)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NEA9ZiuKVl969ZebaafGPP5C95Gp89vtAB9MFEQllAKWNxbZZsAlP6BQnAzCyGt1wNdTXKxu+kbkgdPAZSzOI9KzYocqVVALWABd5fqYZo/SN5t9TMyQ4kyK700Ck3ehj3wLnMla5jYMvu+zYHKLevm32+5hhsb5fwYYfG4adPQOi5WxGPsdQSa9KBdpf+QpQSTKwkTz7Lw/7dpSJ9WrJiy8smKpEKWeh72DKSkYT9TuEU7bvTYhaf2KNALAnOkg+nQ/W5ADEdA29CuX3LFjGHt7ejt2J+EnXT8O/qzWJ6gAKiy4RJB++cOJz0pLmbMjjLcHMhMj/BNOR//kSNjRSqBtGEdAbidsnY8yf1zq29nrtF/gFL11oih2r9rqMK3dgPOJc48TKJC84VcdKwr0A4M1HY9pamXkAN05XXMRMB3hHaiLa1pOGelqPhH4tDJgTCuqRPd2G7KKQref2TywFu6kblscJtID7hZMnvCpJUez32ICytpSx+4QZBR66lUA
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2e365d-ea1f-4caf-74cb-08d82728def2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 12:32:56.8528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRmy8NjXORf/aZ/wl8Mt097ci12y2n9oNPKXGznmac6SzjjnszNeLf8N4kYyI6lr18h1O7RgLfsjrAjHKbogVAfsF3Eda1hbYlBDUOLWBxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3543
Received-SPF: pass client-ip=40.107.20.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:32:58
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

12.07.2020 20:49, Andrey Shinkevich wrote:
> The script 'bench_write_req.py' allows comparing performances of write
> request for two qemu-img binary files.
> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
> applied patch "qcow2: skip writing zero buffers to empty COW areas"
> (git commit ID: c8bb23cbdbe32f5) has the following results:
> 
> SSD:
> -----------------  -------------------  -------------------
>                     <qemu-img binary 1>  <qemu-img binary 2>
> <simple case>      0.34 +- 0.01         10.57 +- 0.96
> <general case>     0.33 +- 0.01         9.15 +- 0.85
> <cluster middle>   0.33 +- 0.00         8.72 +- 0.05
> <cluster overlap>  7.43 +- 1.19         14.35 +- 1.00
> -----------------  -------------------  -------------------
> HDD:
> -----------------  -------------------  -------------------
>                     <qemu-img binary 1>  <qemu-img binary 2>
> <simple case>      32.61 +- 1.17        55.11 +- 1.15
> <general case>     54.28 +- 8.82        60.11 +- 2.76
> <cluster middle>   57.93 +- 0.47        58.53 +- 0.51
> <cluster overlap>  11.47 +- 0.94        17.29 +- 4.40
> -----------------  -------------------  -------------------
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Andrey wants to drop 02,03 in v5, so this patch is a candidate for v5. Below my notes.

> ---
>   scripts/simplebench/bench_write_req.py | 173 +++++++++++++++++++++++++++++++++
>   1 file changed, 173 insertions(+)
>   create mode 100755 scripts/simplebench/bench_write_req.py
> 
> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
> new file mode 100755
> index 0000000..a285ef1
> --- /dev/null
> +++ b/scripts/simplebench/bench_write_req.py
> @@ -0,0 +1,173 @@
> +#!/usr/bin/env python3
> +#
> +# Test to compare performance of write requests for two qemu-img binary files.

Let's note that patch is intended to check benefit of c8bb23cbdbe
"qcow2: skip writing zero buffers to empty COW areas"

> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH.
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
> +
> +import sys
> +import os
> +import subprocess
> +import simplebench
> +
> +
> +def bench_func(env, case):
> +    """ Handle one "cell" of benchmarking table. """
> +    return bench_write_req(env['qemu_img'], env['image_name'],
> +                           case['block_size'], case['block_offset'],
> +                           case['requests'])
> +
> +
> +def qemu_img_pipe(*args):
> +    '''Run qemu-img and return its output'''
> +    subp = subprocess.Popen(list(args),
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
> +    exitcode = subp.wait()
> +    if exitcode < 0:
> +        sys.stderr.write('qemu-img received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(list(args))))
> +    return subp.communicate()[0]
> +
> +
> +def bench_write_req(qemu_img, image_name, block_size, block_offset, requests):
> +    """Benchmark write requests
> +
> +    The function creates a QCOW2 image with the given path/name and fills it
> +    with random data optionally. 

No, it doesn't fill..

> + Then it runs the 'qemu-img bench' command and
> +    makes series of write requests on the image clusters. Finally, it returns
> +    the total time of the write operations on the disk.
> +
> +    qemu_img     -- path to qemu_img executable file
> +    image_name   -- QCOW2 image name to create
> +    block_size   -- size of a block to write to clusters
> +    block_offset -- offset of the block in clusters
> +    requests     -- number of write requests per cluster
> +
> +    Returns {'seconds': int} on success and {'error': str} on failure.
> +    Return value is compatible with simplebench lib.
> +    """
> +
> +    if not os.path.isfile(qemu_img):
> +        print(f'File not found: {qemu_img}')
> +        sys.exit(1)
> +
> +    image_dir = os.path.dirname(os.path.abspath(image_name))
> +    if not os.path.isdir(image_dir):
> +        print(f'Path not found: {image_name}')
> +        sys.exit(1)
> +
> +    cluster_size = 1024 * 1024
> +    image_size = 1024 * cluster_size
> +    seek = 4
> +    dd_count = int(image_size / cluster_size) - seek

seek and dd_count are unused

> +
> +    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
> +                   f'cluster_size={cluster_size}',
> +                   image_name, str(image_size)]
> +
> +    count = requests * int(image_size / cluster_size)

requests is number of requests per cluster..

> +    step = str(cluster_size)

but step is one cluster. So, we have several requests per cluster, but still, step is cluster?

It sounds strange to me. Assume requests = 5 and we have image with 5 clusters. count would be 5 * 5 = 25. Trying to make 25 iterations with step=cluster will go far beyond the image size..

> +    offset = str(block_offset)
> +    cnt = str(count)

extra variables. Let's just use str() in args below.

> +    size = []
> +    if block_size:
> +        size = ['-s', f'{block_size}']
> +
> +    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c', cnt,
> +                  '-S', step, '-o', offset, '-f', 'qcow2', image_name]
> +    if block_size:
> +        args_bench.extend(size)

1. You may just write here

if block_size:
    args_bench += ['-s', f'{block_size}']

No reason to create extra "size" variable to be used only here.

2. Why do you need this logic? If user pass block_size = 0, we instead rely on default bufsize of img_bench() which is 4096. And in two test-cases you use explicit 4096 constant, and in one you use 0 to be implicitly changed to same 4096. Let's instead specify block_size explicitly.


> +
> +    try:
> +        qemu_img_pipe(*args_create)
> +    except OSError as e:
> +        os.remove(image_name)
> +        return {'error': 'qemu_img create failed: ' + str(e)}
> +
> +    try:
> +        ret = qemu_img_pipe(*args_bench)
> +    finally:
> +        os.remove(image_name)
> +        if not ret:

ret may be not defined, if exception shot prior to assignment of ret, isn't it?

I suggest to not bother with "finally", and just make similar "except" like for previous case, and then just parse ret at function end.

> +            return {'error': 'qemu_img bench failed'}
> +        if 'seconds' in ret:
> +            ret_list = ret.split()
> +            index = ret_list.index('seconds.')
> +            return {'seconds': float(ret_list[index-1])}
> +        else:
> +            return {'error': 'qemu_img bench failed: ' + ret}
> +
> +
> +if __name__ == '__main__':
> +
> +    if len(sys.argv) < 4:
> +        program = os.path.basename(sys.argv[0])
> +        print(f'USAGE: {program} <path to qemu-img binary file> '
> +              '<path to another qemu-img to compare performance with> '
> +              '<full or relative name for QCOW2 image to create>')
> +        exit(1)
> +
> +    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
> +    # for the row, other fields are handled by bench_func.
> +    test_cases = [
> +        {
> +            'id': '<simple case>',
> +            'block_size': 0,
> +            'block_offset': 0,
> +            'requests': 10
> +        },
> +        {
> +            'id': '<general case>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'requests': 10
> +        },

Hmm I don't understand, why simple case and general case are different? As I already noted, if you don't specify -s for bench, as you do if block_size is 0, the default value is 4096 anyway in img_bench(). So, how there can be so different results in commit message? Or what am I missing?

> +        {
> +            'id': '<cluster middle>',
> +            'block_size': 4096,
> +            'block_offset': 524288,
> +            'requests': 10
> +        },
> +        {
> +            'id': '<cluster overlap>',

What is overlapping here? you just write half of cluster with a small offset from start of cluster. I'm OK with the case itself, I just don't understand the naming.

> +            'block_size': 524288,
> +            'block_offset': 4096,
> +            'requests': 2
> +        },
> +    ]
> +
> +    # Test-envs are "columns" in benchmark resulting table, 'id is a caption
> +    # for the column, other fields are handled by bench_func.
> +    # Set the paths below to desired values
> +    test_envs = [
> +        {
> +            'id': '<qemu-img binary 1>',
> +            'qemu_img': f'{sys.argv[1]}',
> +            'image_name': f'{sys.argv[3]}'
> +        },
> +        {
> +            'id': '<qemu-img binary 2>',
> +            'qemu_img': f'{sys.argv[2]}',
> +            'image_name': f'{sys.argv[3]}'
> +        },
> +    ]
> +
> +    result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
> +                               initial_run=False)
> +    print(simplebench.ascii(result))
> 


-- 
Best regards,
Vladimir

