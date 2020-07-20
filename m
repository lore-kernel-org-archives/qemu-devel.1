Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE261C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2592073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BS89I8cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2592073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxa8k-0004Uv-NV
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxa7w-0003zq-Hr; Mon, 20 Jul 2020 14:03:00 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com
 ([40.107.3.125]:32578 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxa7s-0000o9-86; Mon, 20 Jul 2020 14:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od/VZ91QLtvKZctk5qwTNzrZN7t+jS4QZMP63ox95F0QjYyZ6Ilfc9UffxJiIl+nh80p/npg21UflaqXKO5FCT7q6kRIzjK+LOvGedqWw6KqoZy377YNIhu2hbY7mg6h+5prOy2YpjNCNtKyVDN2BuJB5WpeOMH7Canp/TIFGIL74fP+Oe0SpwUNjbgEsPjm5iR5Nb6nRYHMivgsphau+PICN5yjafNfli90I26kxTI8HXKyOaY4UCyuqQ/lfYdPxHZGbwZ2Og9DiaDypYfqt5RyPD5bidoyk2QODQc7+GWuEV7t3ieqVQZBQGcOoTjmIrWZ63msz7WWR7Uia53hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu8N9lHOTdc2htYVXhrBfZnH/DzdWZxI/WqNCjeFibg=;
 b=Ma5ArsFplQJVzoytMXBWU0Eu4xbON3mv9IMEhlJ8s9jEZqT00tr5nWiFhcnykT+nxffF46sfFrqm8RaIiXb1BMKQoSocer/fruCfEhjCKAYbtHzrPesF6ECZPqG3LadDLGmDt6svkI7FFnKe8tq7Utd78Kaj5WxyoEePeydqw3chmeiDXPAHbLrbdoTNGAiIKQ3oa4SZ4MYJ6IATuoVUXFM36dnOUCWsOiwqCBfT45VWzcX2e5VKbCaECqg3+7ItELq1C+KiLUQ1gt3XRaZFlgi15h5r0huOGYisN/eE+0ATz0VrbzzCmEgaHOvLGB9YdAH4NE8c/s8GWV6j4CyVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu8N9lHOTdc2htYVXhrBfZnH/DzdWZxI/WqNCjeFibg=;
 b=BS89I8crwCorY8HeU6t/sSozZrj3HgGYUY5RVEOpFWYL9Bnsd8F/oH5s6ffu8auup+Nz7teqNJZgnafSOQ2BD9NHFLzcFZZWYVXGm7XHfhZau2jIPs6WbaJMPKzhtCPi/26KGQMS4Dlo7oJ/SkbOXMoeHJTT/6fEAdUNxdjsZM0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:02:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:02:51 +0000
Subject: Re: [PATCH v2 3/3] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200716135303.319502-1-mreitz@redhat.com>
 <20200716135303.319502-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4cada895-7634-4b15-d03b-9f0f72995895@virtuozzo.com>
Date: Mon, 20 Jul 2020 21:02:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200716135303.319502-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0078.eurprd02.prod.outlook.com
 (2603:10a6:208:154::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR02CA0078.eurprd02.prod.outlook.com (2603:10a6:208:154::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Mon, 20 Jul 2020 18:02:50 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9979f86-95d4-442f-aa6d-08d82cd71e72
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-Microsoft-Antispam-PRVS: <AM6PR08MB43421DECB1E6EBF7CC804154C17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZdJ521IkFROItTcD946Gy4m8e2++duKXhepsMFMkksA+AMFNzS80OOpPFeDWXOw61yKRadvkJtlTe9rl539Rcca4genVPwkSFYC/9ATHoi9velkYZAX9qGU9Cbghmp5UKNchSCrTDvHZ+diI9fsq7Pl5gr3jpoW2+xaFrZG7PbsP8mWKJNAAn+BqLCCGTeg77+GdHSOjEriQKr6UOXzNznlW6EDeCL5fp1SwGv1A+V0ss1pTgo7DzhaJINa0TgNcBY4reN6KYnnxr4eVZh0PbCVbJ2q2mTGKXG0/jwjyjsoOqOgwbtDZwYxvJjk2N57LBNWXFaoliYj4y4IoqqKDIHmGesqZDY6Mnkgn4WQlGhGwXBCWTHf9NC3er0PK9QWbUeyn+riotrfUXhfAi7IsH+wLoUTtlZV/f7FUFmCenqfyWYjMyhULsKtQhVBuRhep83VIVArqBFm2XWGtlCiY5DlO7LQUTiDXt7/2dgJEGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(31696002)(86362001)(4326008)(316002)(16526019)(30864003)(83380400001)(2616005)(956004)(16576012)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(54906003)(31686004)(36756003)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: a5/cgUL51DD0yFWdQtnm4MlevEgD1QQcPhMBC41lh0RqzyXYs2S4NeA4aV4KwqtWSPnuXptvFOSuVWnGsXfPAmbWFZTXnVd0XdJAZZbmRrWPP9II3plvijYDoce7qoR2ylBGiO3RVdnqZJlfg9Cp3Dsse5KDx0USa2DsfzxrQ5yXzR5bNR8PkemHKme3haVrTEgm3qftyN168yRakQpOclSH0kOHQzbC8zr8ZdIvPDGawZiJ+TSyc5VOIi6bQfq2INjCK87y6A/btwJdZN0c6x/PELhe5p+ixe9GICIhMp6qSgGYd0AU9+R3D8bkIniXeHwLDY8OI4sdB6uLjUiekjtO+CE7RT+HTz+dIPMvDnivIMmu8KUKovPpOcXPnQ3ASY4V6QmCwPxd6UyA+IeR4AZHQjTG7myQFdC3u/At4yAfr8YtbMsV7YziOjVoNqJhkvf4YaLTZropN9vDJtR01N4G8aTviYElaNELA4F2uOxjwQLgEvnlWtHyVmjq1JDP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9979f86-95d4-442f-aa6d-08d82cd71e72
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:02:51.5169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2kitmLJO6DRcoR+mcR9aWi0DvvKp4CeSYd/aUAIs/2BSzb91rKSg6Ak88CViEMe7w6BEEbM/npgbPM8O55t7bfJFTBAIiLdoJ/8NGF5V+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.3.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 14:02:52
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 16:53, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/300     | 511 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/300.out |   5 +
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 517 insertions(+)
>   create mode 100755 tests/qemu-iotests/300
>   create mode 100644 tests/qemu-iotests/300.out
> 
> diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
> new file mode 100755
> index 0000000000..68714b7167
> --- /dev/null
> +++ b/tests/qemu-iotests/300
> @@ -0,0 +1,511 @@
> +#!/usr/bin/env python3
> +#
> +# Tests for dirty bitmaps migration with node aliases

copyright?

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
> +import os
> +import random
> +from typing import Dict, List, Optional, Union
> +import iotests
> +import qemu
> +
> +BlockBitmapMapping = List[Dict[str, Union[str, List[Dict[str, str]]]]]
> +
> +assert iotests.sock_dir is not None
> +mig_sock = os.path.join(iotests.sock_dir, 'mig_sock')
> +
> +class TestDirtyBitmapMigration(iotests.QMPTestCase):
> +    src_node_name: str = ''
> +    dst_node_name: str = ''
> +    src_bmap_name: str = ''
> +    dst_bmap_name: str = ''

Hmm, I hope, typing actually not needed with such an obvious initialization

> +
> +    def setUp(self) -> None:
> +        self.vm_a = iotests.VM(path_suffix='-a')
> +        self.vm_a.add_blockdev(f'node-name={self.src_node_name},' \
> +                               'driver=null-co')

Hmm, you don't specify disk size.. How can it work? Aha, it's 1G by default. OK.

> +        self.vm_a.launch()
> +
> +        self.vm_b = iotests.VM(path_suffix='-b')
> +        self.vm_b.add_blockdev(f'node-name={self.dst_node_name},' \
> +                               'driver=null-co')
> +        self.vm_b.add_incoming(f'unix:{mig_sock}')
> +        self.vm_b.launch()
> +
> +        result = self.vm_a.qmp('block-dirty-bitmap-add',
> +                               node=self.src_node_name,
> +                               name=self.src_bmap_name)
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Dirty some random megabytes
> +        for _ in range(9):
> +            mb_ofs = random.randrange(1024)
> +            self.vm_a.hmp_qemu_io(self.src_node_name, 'write %dM 1M' % mb_ofs)

May be, use f-string for consistency

> +
> +        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> +                               node=self.src_node_name,
> +                               name=self.src_bmap_name)
> +        self.bitmap_hash_reference = result['return']['sha256']
> +
> +        caps = [{'capability': name, 'state': True} \
> +                for name in ('dirty-bitmaps', 'events')]
> +
> +        for vm in (self.vm_a, self.vm_b):
> +            result = vm.qmp('migrate-set-capabilities', capabilities=caps)
> +            self.assert_qmp(result, 'return', {})
> +
> +    def tearDown(self) -> None:
> +        self.vm_a.shutdown()
> +        self.vm_b.shutdown()
> +        try:
> +            os.remove(mig_sock)
> +        except OSError:
> +            pass
> +
> +    def check_bitmap(self, bitmap_name_valid: bool) -> None:
> +        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
> +                               node=self.dst_node_name,
> +                               name=self.dst_bmap_name)
> +        if bitmap_name_valid:
> +            self.assert_qmp(result, 'return/sha256',
> +                            self.bitmap_hash_reference)
> +        else:
> +            self.assert_qmp(result, 'error/desc',
> +                            f"Dirty bitmap '{self.dst_bmap_name}' not found")
> +
> +    def migrate(self, migration_success: bool = True,
> +                bitmap_name_valid: bool = True) -> None:
> +        result = self.vm_a.qmp('migrate', uri=f'unix:{mig_sock}')
> +        self.assert_qmp(result, 'return', {})
> +
> +        status = None
> +        while status not in ('completed', 'failed'):
> +            status = self.vm_a.event_wait('MIGRATION')['data']['status']
> +
> +        self.assertEqual(status == 'completed', migration_success)
> +        if status == 'failed':
> +            # Wait until the migration has been cleaned up
> +            # (Otherwise, bdrv_close_all() will abort because the
> +            # dirty bitmap migration code still holds a reference to
> +            # the BDS)
> +            # (Unfortunately, there does not appear to be a nicer way
> +            # of waiting until a failed migration has been cleaned up)
> +            timeout_msg = 'Timeout waiting for migration to be cleaned up'
> +            with iotests.Timeout(30, timeout_msg):
> +                while os.path.exists(mig_sock):
> +                    pass
> +
> +                # Dropping src_node_name will only work once the
> +                # bitmap migration code has released it
> +                while 'error' in self.vm_a.qmp('blockdev-del',
> +                                               node_name=self.src_node_name):
> +                    pass

Somehow I would feel calmer with s/pass/time.sleep(0.5)/ in such loops.

> +
> +            return
> +
> +        self.vm_a.wait_for_runstate('postmigrate')
> +        self.vm_b.wait_for_runstate('running')

Actually, bitmaps migration may continue in postcopy, so more correct would be to wait for completed status for migration on target. Still, shouldn't be a big difference when migrate small bitmap data.

> +
> +        self.check_bitmap(bitmap_name_valid)
> +
> +    @staticmethod
> +    def mapping(node_name: str, node_alias: str,
> +                bitmap_name: str, bitmap_alias: str) \
> +        -> BlockBitmapMapping:
> +        return [{
> +            'node-name': node_name,
> +            'alias': node_alias,
> +            'bitmaps': [{
> +                'name': bitmap_name,
> +                'alias': bitmap_alias
> +            }]
> +        }]
> +
> +    def set_mapping(self, vm: iotests.VM, mapping: BlockBitmapMapping,
> +                    error: Optional[str] = None) \
> +        -> None:
> +        """
> +        Invoke migrate-set-parameters on @vm to set the given @mapping.
> +        Check for success if @error is None, or verify the error message
> +        if it is not.
> +        On success, verify that "info migrate_parameters" on HMP returns
> +        our mapping.  (Just to check its formatting code.)
> +        """
> +        result = vm.qmp('migrate-set-parameters',
> +                        block_bitmap_mapping=mapping)
> +
> +        if error is None:
> +            self.assert_qmp(result, 'return', {})
> +
> +            result = vm.qmp('human-monitor-command',
> +                            command_line='info migrate_parameters')
> +
> +            hmp_mapping: List[str] = []
> +            for line in result['return'].split('\n'):
> +                line = line.rstrip()
> +
> +                if hmp_mapping == []:
> +                    if line == 'block-bitmap-mapping:':
> +                        hmp_mapping.append(line)
> +                    continue
> +
> +                if line.startswith('  '):
> +                    hmp_mapping.append(line)
> +                else:
> +                    break

Let me try:

hmp_mapping = re.search(r'^block-bitmap-mapping:.*(\n  .*)*', result['return'], flags=re.MULTILINE)

> +
> +            self.assertEqual('\n'.join(hmp_mapping) + '\n',
> +                             self.to_hmp_mapping(mapping))
> +        else:
> +            self.assert_qmp(result, 'error/desc', error)
> +
> +    @staticmethod
> +    def to_hmp_mapping(mapping: BlockBitmapMapping) -> str:
> +        result = 'block-bitmap-mapping:\n'
> +
> +        for node in mapping:
> +            result += f"  '{node['node-name']}' -> '{node['alias']}'\n"
> +
> +            assert isinstance(node['bitmaps'], list)
> +            for bitmap in node['bitmaps']:
> +                result += f"    '{bitmap['name']}' -> '{bitmap['alias']}'\n"
> +
> +        return result
> +
> +
> +class TestAliasMigration(TestDirtyBitmapMigration):
> +    src_node_name = 'node0'
> +    dst_node_name = 'node0'
> +    src_bmap_name = 'bmap0'
> +    dst_bmap_name = 'bmap0'
> +
> +    def test_migration_without_alias(self) -> None:
> +        self.migrate(self.src_node_name == self.dst_node_name,
> +                     self.src_bmap_name == self.dst_bmap_name)
> +
> +        # Expect abnormal shutdown of the destination VM on migration failure
> +        if self.src_node_name != self.dst_node_name:
> +            try:
> +                self.vm_b.shutdown()
> +            except qemu.machine.AbnormalShutdown:
> +                pass
> +
> +    def test_alias_on_src_migration(self) -> None:
> +        mapping = self.mapping(self.src_node_name, self.dst_node_name,
> +                               self.src_bmap_name, self.dst_bmap_name)
> +
> +        self.set_mapping(self.vm_a, mapping)
> +        self.migrate()
> +
> +    def test_alias_on_dst_migration(self) -> None:
> +        mapping = self.mapping(self.dst_node_name, self.src_node_name,
> +                               self.dst_bmap_name, self.src_bmap_name)
> +
> +        self.set_mapping(self.vm_b, mapping)
> +        self.migrate()
> +
> +    def test_alias_on_both_migration(self) -> None:
> +        src_map = self.mapping(self.src_node_name, 'node-alias',
> +                               self.src_bmap_name, 'bmap-alias')
> +
> +        dst_map = self.mapping(self.dst_node_name, 'node-alias',
> +                               self.dst_bmap_name, 'bmap-alias')
> +
> +        self.set_mapping(self.vm_a, src_map)
> +        self.set_mapping(self.vm_b, dst_map)
> +        self.migrate()
> +
> +
> +class TestNodeAliasMigration(TestAliasMigration):
> +    src_node_name = 'node-src'
> +    dst_node_name = 'node-dst'
> +
> +
> +class TestBitmapAliasMigration(TestAliasMigration):
> +    src_bmap_name = 'bmap-src'
> +    dst_bmap_name = 'bmap-dst'
> +
> +
> +class TestFullAliasMigration(TestAliasMigration):
> +    src_node_name = 'node-src'
> +    dst_node_name = 'node-dst'
> +    src_bmap_name = 'bmap-src'
> +    dst_bmap_name = 'bmap-dst'
> +
> +
> +class TestBlockBitmapMappingErrors(TestDirtyBitmapMigration):
> +    src_node_name = 'node0'
> +    dst_node_name = 'node0'
> +    src_bmap_name = 'bmap0'
> +    dst_bmap_name = 'bmap0'
> +
> +    """
> +    Note that mapping nodes or bitmaps that do not exist is not an error.
> +    """
> +
> +    def test_non_injective_node_mapping(self) -> None:
> +        mapping: BlockBitmapMapping = [
> +            {
> +                'node-name': 'node0',
> +                'alias': 'common-alias',
> +                'bitmaps': [{
> +                    'name': 'bmap0',
> +                    'alias': 'bmap-alias0'
> +                }]
> +            },
> +            {
> +                'node-name': 'node1',
> +                'alias': 'common-alias',
> +                'bitmaps': [{
> +                    'name': 'bmap1',
> +                    'alias': 'bmap-alias1'
> +                }]
> +            }
> +        ]
> +
> +        self.set_mapping(self.vm_a, mapping,
> +                         'Invalid mapping given for block-bitmap-mapping: ' \
> +                         'The node alias common-alias is used twice')
> +
> +    def test_non_injective_bitmap_mapping(self) -> None:
> +        mapping: BlockBitmapMapping = [{
> +            'node-name': 'node0',
> +            'alias': 'node-alias0',
> +            'bitmaps': [
> +                {
> +                    'name': 'bmap0',
> +                    'alias': 'common-alias'
> +                },
> +                {
> +                    'name': 'bmap1',
> +                    'alias': 'common-alias'
> +                }
> +            ]
> +        }]
> +
> +        self.set_mapping(self.vm_a, mapping,
> +                         'Invalid mapping given for block-bitmap-mapping: ' \
> +                         'The bitmap alias node-alias0/common-alias is used ' \
> +                         'twice')
> +
> +    def test_ambiguous_node_mapping(self) -> None:
> +        mapping: BlockBitmapMapping = [
> +            {
> +                'node-name': 'node0',
> +                'alias': 'node-alias0',
> +                'bitmaps': [{
> +                    'name': 'bmap0',
> +                    'alias': 'bmap-alias0'
> +                }]
> +            },
> +            {
> +                'node-name': 'node0',
> +                'alias': 'node-alias1',
> +                'bitmaps': [{
> +                    'name': 'bmap0',
> +                    'alias': 'bmap-alias0'
> +                }]
> +            }
> +        ]
> +
> +        self.set_mapping(self.vm_a, mapping,
> +                         'Invalid mapping given for block-bitmap-mapping: ' \
> +                         'The node name node0 is mapped twice')
> +
> +    def test_ambiguous_bitmap_mapping(self) -> None:
> +        mapping: BlockBitmapMapping = [{
> +            'node-name': 'node0',
> +            'alias': 'node-alias0',
> +            'bitmaps': [
> +                {
> +                    'name': 'bmap0',
> +                    'alias': 'bmap-alias0'
> +                },
> +                {
> +                    'name': 'bmap0',
> +                    'alias': 'bmap-alias1'
> +                }
> +            ]
> +        }]
> +
> +        self.set_mapping(self.vm_a, mapping,
> +                         'Invalid mapping given for block-bitmap-mapping: ' \
> +                         'The bitmap node0/bmap0 is mapped twice')
> +
> +    def test_migratee_node_is_not_mapped_on_src(self) -> None:

is migratee a mistake or an abbreviation for migrate-error ? :)

> +        self.set_mapping(self.vm_a, [])
> +        # Should just ignore all bitmaps on unmapped nodes
> +        self.migrate(True, False)
> +
> +    def test_migratee_node_is_not_mapped_on_dst(self) -> None:
> +        self.set_mapping(self.vm_b, [])
> +        self.migrate(False, False)
> +
> +        # Expect abnormal shutdown of the destination VM on migration failure
> +        try:
> +            self.vm_b.shutdown()
> +        except qemu.machine.AbnormalShutdown:
> +            pass
> +
> +        self.assertIn(f"Unknown node alias '{self.src_node_name}'",
> +                      self.vm_b.get_log())
> +
> +    def test_migratee_bitmap_is_not_mapped_on_src(self) -> None:
> +        mapping: BlockBitmapMapping = [{
> +            'node-name': self.src_node_name,
> +            'alias': self.dst_node_name,
> +            'bitmaps': []
> +        }]
> +
> +        self.set_mapping(self.vm_a, mapping)
> +        # Should just ignore all unmapped bitmaps
> +        self.migrate(True, False)
> +
> +    def test_migratee_bitmap_is_not_mapped_on_dst(self) -> None:
> +        mapping: BlockBitmapMapping = [{
> +            'node-name': self.dst_node_name,
> +            'alias': self.src_node_name,
> +            'bitmaps': []
> +        }]
> +
> +        self.set_mapping(self.vm_b, mapping)
> +        self.migrate(False, False)
> +
> +        # Expect abnormal shutdown of the destination VM on migration failure
> +        try:
> +            self.vm_b.shutdown()
> +        except qemu.machine.AbnormalShutdown:
> +            pass
> +
> +        self.assertIn(f"Unknown bitmap alias '{self.src_bmap_name}' on node " \
> +                      f"'{self.dst_node_name}' (alias '{self.src_node_name}')",
> +                      self.vm_b.get_log())
> +
> +    def test_non_wellformed_node_alias(self) -> None:
> +        mapping: BlockBitmapMapping = [{
> +            'node-name': self.src_bmap_name,
> +            'alias': '123-foo',
> +            'bitmaps': []
> +        }]
> +
> +        self.set_mapping(self.vm_a, mapping,
> +                         'Invalid mapping given for block-bitmap-mapping: ' \
> +                         'The node alias 123-foo is not well-formed')
> +
> +
> +class TestCrossAliasMigration(TestDirtyBitmapMigration):
> +    """
> +    Swap aliases, both to see that qemu does not get confused, and
> +    that we can migrate multiple things at once.
> +
> +    So we migrate this:
> +      node-a.bmap-a -> node-b.bmap-b
> +      node-a.bmap-b -> node-b.bmap-a
> +      node-b.bmap-a -> node-a.bmap-b
> +      node-b.bmap-b -> node-a.bmap-a
> +    """
> +
> +    src_node_name = 'node-a'
> +    dst_node_name = 'node-b'
> +    src_bmap_name = 'bmap-a'
> +    dst_bmap_name = 'bmap-b'
> +
> +    def setUp(self) -> None:
> +        TestDirtyBitmapMigration.setUp(self)
> +
> +        # Now create another block device and let both have two bitmaps each
> +        result = self.vm_a.qmp('blockdev-add',
> +                               node_name='node-b', driver='null-co')
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm_b.qmp('blockdev-add',
> +                               node_name='node-a', driver='null-co')
> +        self.assert_qmp(result, 'return', {})
> +
> +        bmaps_to_add = (('node-a', 'bmap-b'),
> +                        ('node-b', 'bmap-a'),
> +                        ('node-b', 'bmap-b'))
> +
> +        for (node, bmap) in bmaps_to_add:
> +            result = self.vm_a.qmp('block-dirty-bitmap-add',
> +                                   node=node, name=bmap)
> +            self.assert_qmp(result, 'return', {})
> +
> +    @staticmethod
> +    def cross_mapping() -> BlockBitmapMapping:
> +        return [
> +            {
> +                'node-name': 'node-a',
> +                'alias': 'node-b',
> +                'bitmaps': [
> +                    {
> +                        'name': 'bmap-a',
> +                        'alias': 'bmap-b'
> +                    },
> +                    {
> +                        'name': 'bmap-b',
> +                        'alias': 'bmap-a'
> +                    }
> +                ]
> +            },
> +            {
> +                'node-name': 'node-b',
> +                'alias': 'node-a',
> +                'bitmaps': [
> +                    {
> +                        'name': 'bmap-b',
> +                        'alias': 'bmap-a'
> +                    },
> +                    {
> +                        'name': 'bmap-a',
> +                        'alias': 'bmap-b'
> +                    }
> +                ]
> +            }
> +        ]
> +
> +    def verify_dest_has_all_bitmaps(self) -> None:
> +        bitmaps = self.vm_a.query_bitmaps()

s/vm_a/vm_b/

Ha! I've already thought, that I'll not find any mistake :)

With it fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(other my notes up to you)

> +
> +        # Extract and sort bitmap names
> +        for node in bitmaps:
> +            bitmaps[node] = sorted((bmap['name'] for bmap in bitmaps[node]))
> +
> +        self.assertEqual(bitmaps,
> +                         {'node-a': ['bmap-a', 'bmap-b'],
> +                          'node-b': ['bmap-a', 'bmap-b']})
> +
> +    def test_alias_on_src(self) -> None:
> +        self.set_mapping(self.vm_a, self.cross_mapping())
> +
> +        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
> +        # that is enough
> +        self.migrate()
> +
> +        self.verify_dest_has_all_bitmaps()
> +
> +    def test_alias_on_dst(self) -> None:
> +        self.set_mapping(self.vm_b, self.cross_mapping())
> +
> +        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
> +        # that is enough
> +        self.migrate()
> +
> +        self.verify_dest_has_all_bitmaps()
> +
> +
> +if __name__ == '__main__':
> +    iotests.main(supported_protocols=['file'])
> diff --git a/tests/qemu-iotests/300.out b/tests/qemu-iotests/300.out
> new file mode 100644
> index 0000000000..6d9bee1a4b
> --- /dev/null
> +++ b/tests/qemu-iotests/300.out
> @@ -0,0 +1,5 @@
> +...........................
> +----------------------------------------------------------------------
> +Ran 27 tests
> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index c0710cd99e..6b8910a767 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -307,4 +307,5 @@
>   295 rw
>   296 rw
>   297 meta
> +300 migration
>   301 backing quick
> 


-- 
Best regards,
Vladimir

