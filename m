Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8485C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922FD208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NIA5om+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922FD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4JQd-0005Rh-RB
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 02:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4JPy-0004gr-FJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4JPx-0003dX-EI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:05:10 -0500
Received: from mail-eopbgr60107.outbound.protection.outlook.com
 ([40.107.6.107]:8342 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4JPt-0003bB-3v; Wed, 19 Feb 2020 02:05:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwRG+QNmQHZAOGD+A0008KJfw7PEFypdDexn7Nz4HhbQdCunD4R0HSs/qGAW812sP+el0Jp8zvn397wtRcv2jJe51UgCd097ktg1GDnVn5BsNUKjdSpEF2CON/yS2Ta3Q6xkzktNfp0EypNLh39r2PJhP+G4iGKpF+Q/XxyqU6OUUEEYCWsGGYott1VWoyzQKuTb9oOkJmt+XoIQ5iOFKXHqRw/8UjvLtvNQ/k3hWR12/OIN2xw2MBVUi2xXKwncFuDXltFLFTvkd0PXqI4FiO0dzLbvYgpQKjRsF2w6foRJup6fufrwSmhg9dq8a4NvPN/2nMbqwF5QZhW+tarBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+16U3K09fZ7MZBXjBNhVLx6R+JDPRGBPPhc2J0UUBeE=;
 b=eVQj2R6s3jQcuMKD1QcQEqsT7AVwowGw3BbtL3La14VC9IjtaCd2lQujdoh4uMYLWHAFK0yCrKE1NMzTHhN4meypsdVPN+CCFELPx3yqrNSdh7jgOS0cKX2Ml8v8WghBvR9b6BPBu5e/X+n5U/SF+USMUMyUOwRG7aYWz0VH8ubmHjtLCYv0NuWAmEzEOcWlhEK1y7rRcShzbDqePFDoHBONypDvR66TzpT1AWxvSnqdaU9QQK6M6tL0B90br/SYhHIjZeItiZQMeWkBqsxX36O5Jp7IgEHPbhRzjUZPmrRQXz2L24pzdWdV2JxAudIHrofDN8Tnf0j1R7QzjB5xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+16U3K09fZ7MZBXjBNhVLx6R+JDPRGBPPhc2J0UUBeE=;
 b=NIA5om+Q/eQ+L9Gs+nAzarhmMaCYu4HGtliJiszhYS+8ft3GWoebW8FGcdd47cjBGYsFv2TvC1Eff18kmUmDcSq0QuFCtcWtoe1ExzRFOYdJyN9zWseV6vedcAoEIbxgmcu6TxBYwQdrvSdeXr3uCyRy0i6kqGKj66x9GDo7Hco=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB2983.eurprd08.prod.outlook.com (52.135.167.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 07:05:02 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:05:02 +0000
Subject: Re: [PATCH v2 12/22] qemu-iotests/199: fix style
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-13-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <1f09b290-a3dc-a8a2-ff6d-a582ee8990ec@virtuozzo.com>
Date: Wed, 19 Feb 2020 10:04:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::19) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0502CA0009.eurprd05.prod.outlook.com (2603:10a6:3:e3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Wed, 19 Feb 2020 07:05:01 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34701bd-e173-4206-1090-08d7b50a0a03
X-MS-TrafficTypeDiagnostic: AM6PR08MB2983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2983AA47408F4A6AB7214047F4100@AM6PR08MB2983.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(39850400004)(376002)(366004)(189003)(199004)(6486002)(36756003)(52116002)(31696002)(2906002)(36916002)(86362001)(478600001)(16576012)(44832011)(31686004)(186003)(8936002)(316002)(16526019)(54906003)(8676002)(66556008)(81166006)(66476007)(2616005)(66946007)(81156014)(956004)(26005)(4326008)(53546011)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2983;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnFsIUp5fCpOd2lHWOIDcnKMJRSEuCY2AuO5Tp0rm2iUWPhxe6j5fRTPrNIPPCzpsdekl+eK+egZd9ThD6TVU1qM27+SJPLJ1voqm/KYnbKJcHxtmyYqnLgJcUlDbdVbo6tJyhkS+LtkC5JhKiT71VpHlYH08vcGIbkq40vf1qgqAAdIir2N0cOo5yK3GZXgcUSp1NhhOsdRLw3CqkAYik35Kk7wm8RINjYSMU7RDhQ/GBrZW+Wj8wDzxJRGBSZ28VTqkpKgEvvdboUZbeZsGliajjClB5rRkdCdtrZ5I8Dv3tz3R9h03yJYOO6BISNXP2Aceh3+4GB+5zSdgi9ZiMYpE5X34ukTeMBMsNZHgLhZ/f0Kk/XPZvVyQIMHhGGvZt4jv9WExhZtY7PMW3u2GcALQ3r+DmTe74NBan1uPkcimztgdXJmgAVHk1GQ5J3z
X-MS-Exchange-AntiSpam-MessageData: RxAoOLBTUHdapwFkZMkUbk/YR592gPmxhqdv7RFwGAbcsfF9tEdUIdv+70+8iz+74T8QpxyDBHkJy/abL4vD2BA9zm97f+CeO+Su57E8ZAfx77q087OrQ5NwUa2VCV28D+P/RS2PeHk1NCB1RzJEMw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34701bd-e173-4206-1090-08d7b50a0a03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:05:02.0266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdmN5t9ML49PQJJo5pKw5tJvrtopmXGxUb1CMuwN4PiTd4CSF6Bq/+Glul7i57ZNHhaPgYQn3IbN3wvpm/Hav8pVBVI/PdCJD4zR0EZm58g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2983
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Mostly, satisfy pep8 complains.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 40774eed74..de9ba8d94c 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -28,8 +28,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
>   size = '256G'
>   fifo = os.path.join(iotests.test_dir, 'mig_fifo')
>   
> -class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
> +class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>       def tearDown(self):
>           self.vm_a.shutdown()
>           self.vm_b.shutdown()
> @@ -54,7 +54,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>           result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
>                                  name='bitmap', granularity=granularity)
> -        self.assert_qmp(result, 'return', {});
> +        self.assert_qmp(result, 'return', {})
>   
>           s = 0
>           while s < write_size:
> @@ -71,7 +71,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>           result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
>                                  name='bitmap')
> -        self.assert_qmp(result, 'return', {});
> +        self.assert_qmp(result, 'return', {})
>           s = 0
>           while s < write_size:
>               self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
> @@ -104,15 +104,16 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>               self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>               s += 0x10000
>   
> -        result = self.vm_b.qmp('query-block');
> +        result = self.vm_b.qmp('query-block')
>           while len(result['return'][0]['dirty-bitmaps']) > 1:
>               time.sleep(2)
> -            result = self.vm_b.qmp('query-block');
> +            result = self.vm_b.qmp('query-block')
>   
>           result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap')
>   
> -        self.assert_qmp(result, 'return/sha256', sha256);
> +        self.assert_qmp(result, 'return/sha256', sha256)
> +
>   
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

