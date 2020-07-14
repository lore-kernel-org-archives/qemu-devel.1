Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F792C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194C222515
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D9IqbgoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194C222515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNSe-0006lB-Ah
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNQg-0004UK-VX; Tue, 14 Jul 2020 12:05:15 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com
 ([40.107.8.92]:51171 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNQd-0008Lb-I1; Tue, 14 Jul 2020 12:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNAaVvwU4HSzi/3d94UFgepb4dw81S3PNtV+92c+ryMUPJ1+EOZ27w5+n5vRYZQSKXveiq08uqKaaSy3BueBeJrOSg1/2VX/FwjkzLApmn8fqw1GWPq87fR3cnWFSQlP/I1PxrR6j/UElyeBLb5dI1xJonB6iXq5m9cL2HVmI0Iqz+wCcDw2tWaw0xjs4/xhiyP1CUffjggzQDTqndsLSEhZtn9e5ahDHJHGobR6Cow7UyCgYKvQ0spAHiMlB4w9oU3E9y0vCXGbIfdUBnfpK3oLT8jaV/Ty0yIppx8dfxPXqiOl5lJSv9oU8hlnSALlDGuwsdPwSenxjnhMoxjbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GZW+sXIXSY2KvJT5DNLK4+vvE0rxuUD6w2aZRq5p/I=;
 b=QXb0GmoC12D30pyKwyKWPJe71/Nin1K3zs1AMP4uqKhUbdhS7BpMFj4BDhxXmsXHgt1syhELGO7X1H9Q/9rcHu4wZVXFV190RKDVZ8IkRMbClA1QyZcZN7JN+2+0yZZWQGiElF6+4TOFQEG4iR03GlMx8jIm18RP5a3b+aUrROOJg+i/o8J4SHetLe5/MJSHGSgIxjdN6CQzjRGTBvkiqLyxSDoRRMgDpUb1zvAk5aYPiHFrB9eF9gHY1JcUKOeiwQzK0+BXxQHGyYdIye0QnlYRVPPDVbo7L6WUlGFs6qM4sSGyftCXrMAVSSNWRIlPDmWLVQdy6FGfBwmK2psHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GZW+sXIXSY2KvJT5DNLK4+vvE0rxuUD6w2aZRq5p/I=;
 b=D9IqbgoOMpJncx/4HM/Ot3H1qQ4fIfgYUE2pElQ+GvQ2Z9ef/MU2nwjG/8RAVjW1odhKhN+YXoHNeqwqdDozQMo2N0VUv4gAx/wy1t9mfX8xSzZhzlfRPd5tiFS28J/nqBQgD3xBl3k753wP4u5ASfm+Vw3l3JiHj9Yr7NQcSRQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2449.eurprd08.prod.outlook.com (2603:10a6:203:9c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 16:05:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 16:05:07 +0000
Subject: Re: [PATCH v6] scripts/simplebench: compare write request performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-block@nongnu.org, ehabkost@redhat.com
References: <1594741846-475697-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <895cc194-04fd-344a-1fb6-7f17be0f0a30@virtuozzo.com>
Date: Tue, 14 Jul 2020 19:05:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594741846-475697-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0113.eurprd07.prod.outlook.com
 (2603:10a6:207:7::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR07CA0113.eurprd07.prod.outlook.com (2603:10a6:207:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 16:05:07 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40f072c-8f6d-49ff-e9e6-08d8280fad88
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2449724C99CED6116F4683FFC1610@AM5PR0802MB2449.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWAh0eYK/ErxCv7YGn2Ez6BnvPx9Cre0HM2opwn/r01Vcfgu5JvIH1tJAXROrQITtT852QmZbx/5SXms4xGYWIndtbHtir913ODgrIS9p+7CNGmPYtqi1WkFNcF9W38HaJqbStXdA9PxMrq0IEYEcyp/WOzQbOMIvUsP4iFpIPZ7YJ2CRzeyGDVRDHxc6u7G8PTpx9PF5XvF6LXnIGO9wvRF4IOYwaqfoKzhm7EJkjm1qpKROp8FtoWYSyMCwrpwwKpuGkTJc8ZH2daG9USmbwA3usIapgTgDMvNxHiyQRzZcVRIAfHg5WjEfqBKJjEcVGbquLJEEVDNxXZ8a5+TID1+mu3UdcjThMaLaW2Ysbcioah3/CKkP6tDOiirQVPXjfLsFaikYd1H+iKJf3emZBWmE3eXD/P7TPwTO131xEffDt9e9Z5jg7radDa70HLiZkM8YQGYmNU8ILiv3sn9F0qPEpMES2MdUYnb/GPi7Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(39840400004)(396003)(376002)(66946007)(186003)(8936002)(16576012)(66556008)(66476007)(86362001)(16526019)(478600001)(107886003)(31696002)(4326008)(26005)(36756003)(5660300002)(52116002)(31686004)(2906002)(6486002)(8676002)(2616005)(956004)(83380400001)(316002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: J5OUq/ISeRTzTFVPv+zRyM6x6L9Q7IT6ODGbYuxMlNWJxh7/rP27nDRXvexv3SOtJFbzoLfPeA8GBmv9vwfS0T50AE2ohdoHI149q3BxZdI8X+PdLqazS7Zcg9Kqc3jI5Q1N+UBNr0N/wSCx6Z0gS+pfFS7jdu3Y9ef+C2mIusuG1pmWx2MPrSjxCeOVD0puNlue0iBjhbNgBrzPO4pUu4Aa8MlRljlfHl/SiNMlneIO+N2ThemF/JUFsNZCS0huonJaZu8yezgQsCsjegxVWkxmorVM7zXO2VtZlZDfVx8u/9+IXHecBHoi5FfpX7bkbXTm43m58KHAkjhJFOc0+B6agl+yDw4hCs/SO9c3H8QgdMEOLcb5fmE5KMbKXhFLwdPZBbyFLgQ7/xOSET2P1aYUeqbOZitAZOBAeN0jfgOcfSxgNHc5WtbBakfaQY0EUHLPcLOKn66kQDLXhDuBJWprx/p/HTDVL13glxCJcxnPFZZe9ijGE+vBUFoFXGAE
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f072c-8f6d-49ff-e9e6-08d8280fad88
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:05:07.5191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht3H4YVA6zmON6HQuWPBF8DPdrW22SoNg/SKxcEGU7k3DUKWaAtPSzGXs2jKqCGoWg3zt0F108XPSJRk01AIooXu4iUB0QUprBR7rdagAvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2449
Received-SPF: pass client-ip=40.107.8.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:05:09
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
Cc: den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo!

Could you please stage this in your branch, to be pulled for 5.2 later?

14.07.2020 18:50, Andrey Shinkevich wrote:
> The script 'bench_write_req.py' allows comparing performances of write
> request for two qemu-img binary files.
> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
> applied patch "qcow2: skip writing zero buffers to empty COW areas"
> (git commit ID: c8bb23cbdbe32f5) has the following results:
> 
> SSD:
> ----------------  -------------------  -------------------
>                    <qemu-img binary 1>  <qemu-img binary 2>
> <cluster front>   0.10 +- 0.00         8.16 +- 0.65
> <cluster middle>  0.10 +- 0.00         7.37 +- 1.10
> <cross cluster>   7.40 +- 1.08         21.97 +- 4.19
> <cluster 64K>     2.14 +- 0.94         8.48 +- 1.66
> ----------------  -------------------  -------------------
> HDD:
> ----------------  -------------------  -------------------
>                    <qemu-img binary 1>  <qemu-img binary 2>
> <cluster front>   2.30 +- 0.01         6.19 +- 0.06
> <cluster middle>  2.20 +- 0.09         6.20 +- 0.06
> <cross cluster>   8.32 +- 0.16         8.26 +- 0.14
> <cluster 64K>     8.20 +- 0.05         6.26 +- 0.10
> ----------------  -------------------  -------------------
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   scripts/simplebench/bench_write_req.py | 170 +++++++++++++++++++++++++++++++++
>   1 file changed, 170 insertions(+)
>   create mode 100755 scripts/simplebench/bench_write_req.py
> 
> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
> new file mode 100755
> index 0000000..ca1178f
> --- /dev/null
> +++ b/scripts/simplebench/bench_write_req.py
> @@ -0,0 +1,170 @@
> +#!/usr/bin/env python3
> +#
> +# Test to compare performance of write requests for two qemu-img binary files.
> +#
> +# The idea of the test comes from intention to check the benefit of c8bb23cbdbe
> +# "qcow2: skip writing zero buffers to empty COW areas".
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
> +                           case['cluster_size'])
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
> +def bench_write_req(qemu_img, image_name, block_size, block_offset,
> +                    cluster_size):
> +    """Benchmark write requests
> +
> +    The function creates a QCOW2 image with the given path/name. Then it runs
> +    the 'qemu-img bench' command and makes series of write requests on the
> +    image clusters. Finally, it returns the total time of the write operations
> +    on the disk.
> +
> +    qemu_img     -- path to qemu_img executable file
> +    image_name   -- QCOW2 image name to create
> +    block_size   -- size of a block to write to clusters
> +    block_offset -- offset of the block in clusters
> +    cluster_size -- size of the image cluster
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
> +    image_size = 1024 * 1024 * 1024
> +
> +    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
> +                   f'cluster_size={cluster_size}',
> +                   image_name, str(image_size)]
> +
> +    count = int(image_size / cluster_size) - 1
> +    step = str(cluster_size)
> +
> +    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c',
> +                  str(count), '-s', f'{block_size}', '-o', str(block_offset),
> +                  '-S', step, '-f', 'qcow2', image_name]
> +
> +    try:
> +        qemu_img_pipe(*args_create)
> +    except OSError as e:
> +        os.remove(image_name)
> +        return {'error': 'qemu_img create failed: ' + str(e)}
> +
> +    try:
> +        ret = qemu_img_pipe(*args_bench)
> +    except OSError as e:
> +        os.remove(image_name)
> +        return {'error': 'qemu_img bench failed: ' + str(e)}
> +
> +    os.remove(image_name)
> +
> +    if 'seconds' in ret:
> +        ret_list = ret.split()
> +        index = ret_list.index('seconds.')
> +        return {'seconds': float(ret_list[index-1])}
> +    else:
> +        return {'error': 'qemu_img bench failed: ' + ret}
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
> +            'id': '<cluster front>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cluster middle>',
> +            'block_size': 4096,
> +            'block_offset': 524288,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cross cluster>',
> +            'block_size': 1048576,
> +            'block_offset': 4096,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cluster 64K>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'cluster_size': 65536
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

