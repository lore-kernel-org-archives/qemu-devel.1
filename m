Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B6C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF29424671
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OkmFzFQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF29424671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4S93-0004uf-QU
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Rvr-00038Z-6N
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Rvo-0000oR-PV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:39 -0500
Received: from mail-db5eur01on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::71a]:27110
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4Rvl-0000ir-NL; Wed, 19 Feb 2020 11:10:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLMDWSUQ0Wnyvd8ZcWmkSqoUy6ClwTj50XDfKuFbsEjP/ECprGopi9CX/1bwBR/ymff9f2S/nhZyI2YluQU9lU2TRMFadSp/WvsGPcwK8jCahDB8ugfx3KfD3+1ClAf37OUCv/BhEEW/xe3eYP9SINb4HaY8b/j2rWUddzSOipCPSqR3/RDJzVMod4iiJ0WRtJipYl4WOz33pmS2txZegGmfzNZ09yAG1Xq7VheQR4AvkRfew42VavdkJOHQpTSnfz7jVOgnvRpzXJNj7RQyIIM5up4qy/QAz3C03hrk1x7s3pVxsDD3Y3cKe7EqFMfH1h25JficIu7f6TT/bPJX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnNkbqG+Beit3a1l3QFOwxwd81okpXpAFs83mB9GWjE=;
 b=UWe03vOhm40QP+h+XXJSxmjETPPITDy5MGizZ8EVce5Ww7/8ooPDhOla2693VQBcja+bbprRR2IJSctNkxwopc3xuyauFmHw29+nPWC/Uh2OQ9n0WG/aDAkZSWSR1mBtkouGbxIt/J7dMm0v/NBxIxio8mWB9WK23A05nc0cHKzprYIVVq11exONc+mLY2gpHrV5S/SC6K/tndbzOBBZLJK3UMxbfof8qU6Y9FTmz5/Yj6FybiRe7GPRwkgLtC9HUE46GIpFv+fO+1A98hN0C1uzYgQTp6Pj7gSIYT4fP1qLh82iwdrZ/U7bEofgDqheU+APMcC3abymk2Z7JzuBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnNkbqG+Beit3a1l3QFOwxwd81okpXpAFs83mB9GWjE=;
 b=OkmFzFQO5C7jGh4yl89BW1X2eRxDhokIi9F09VB5ZItfNvFGsNqvu9ZGaaIuYQd7ZNjpzZOUKxXq8XKs14FJ+JaGg95L7VxWoldO8I8XxpU7DXWL9b0bpkGO4dGvxkxfpuKvX2l2cP2qmR7JKqtxHURFWfJnciOa3RVd2lCVMUg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4643.eurprd08.prod.outlook.com (10.255.97.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 16:10:31 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:10:31 +0000
Subject: Re: [PATCH v2 19/22] qemu-iotests/199: prepare for new test-cases
 addition
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-20-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <fc384dff-93b3-28e8-aaef-fe83ad872902@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:10:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-20-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0083.eurprd07.prod.outlook.com
 (2603:10a6:3:64::27) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0701CA0083.eurprd07.prod.outlook.com (2603:10a6:3:64::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Wed, 19 Feb 2020 16:10:30 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80825db8-859d-4f89-6eed-08d7b5563e0b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4643AE08D673F074BCF1B0C1F4100@AM6PR08MB4643.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(31686004)(8936002)(66946007)(66556008)(8676002)(2906002)(36916002)(316002)(81166006)(81156014)(66476007)(54906003)(16576012)(6486002)(36756003)(5660300002)(16526019)(186003)(26005)(53546011)(52116002)(44832011)(2616005)(956004)(4326008)(31696002)(86362001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4643;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8c/P9ZlR9n4bKEIpE7OXpMKB3fX61o8Off7W4G2iY3POo/fQSbhljph7BOVABrh4RUEshxrYyiyqUWOqEldLQLtJ/DGInoNwNJRUstorYft2AsHCo03TWEcW6g6KDDYvvv4M4J/tQCyODkN5FFuX7YRuphKqB9mS1zcTgYF5Ghorg4rTZ7RkSOes2dX9Fz11EXR1RjlbJmqPsaArdb2wi6eDyyTVBYmjX5hJkBVKuVLLCfsisivN4UyChk3dRAkzhbOscvya5o67gLOvLbVR70in7DZH+p9JzZ7mcz1eAuO/KWMamGly36MVrgEqo0NcnYAB+izhdGDd3RvXumlWcjnJFG9UwV+46tHv6j1S1v23ezMwlLbLMItEFiGASSqrJR8GvO4L2XjER5KIGwNWzmOULYWY7Wh5IAahtGYKVFf1G09g2+FKornjPHRtSvxd
X-MS-Exchange-AntiSpam-MessageData: VXGywGyorgZP7u48LwfU8vBTIGjwSDkmfP+ZiZoezAAMjqGyktRjix5xG1S4A9AVMm7EYWP8svB46646QAOCevU3Tuy5n8789LWmPkrp1dbySd+4W1SDRE0hzXujEPIkQC2wDdD3YbHsEd7JvsI+xw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80825db8-859d-4f89-6eed-08d7b5563e0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:10:31.0595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrJKHnnsf83z2wbVg8knujBQGQnNdWJPr7xaX0vk/dFQriE8lLhafBDz28HcsmlPUI+qg3vvO/XER4pF7v/NMncistl86k0ieEjZc40hKuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4643
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe02::71a
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
> Move future common part to start_postcopy() method. Move checking
> number of bitmaps to check_bitmap().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 36 +++++++++++++++++++++++-------------
>   1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 9a6e8dcb9d..969620b103 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -29,6 +29,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
>   size = '256G'
>   fifo = os.path.join(iotests.test_dir, 'mig_fifo')
>   
> +granularity = 512
> +nb_bitmaps = 15
>   
>   GiB = 1024 * 1024 * 1024
>   
> @@ -61,6 +63,15 @@ def event_dist(e1, e2):
>       return event_seconds(e2) - event_seconds(e1)
>   
>   
> +def check_bitmaps(vm, count):
> +    result = vm.qmp('query-block')
> +
> +    if count == 0:
> +        assert 'dirty-bitmaps' not in result['return'][0]
> +    else:
> +        assert len(result['return'][0]['dirty-bitmaps']) == count
> +
> +
>   class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>       def tearDown(self):
>           if debug:
> @@ -101,10 +112,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_a_events = []
>           self.vm_b_events = []
>   
> -    def test_postcopy(self):
> -        granularity = 512
> -        nb_bitmaps = 15
> -
> +    def start_postcopy(self):
> +        """ Run migration until RESUME event on target. Return this event. """
>           for i in range(nb_bitmaps):
>               result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
>                                      name='bitmap{}'.format(i),
> @@ -119,10 +128,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap0')
> -        discards1_sha256 = result['return']['sha256']
> +        self.discards1_sha256 = result['return']['sha256']
>   
>           # Check, that updating the bitmap by discards works
> -        assert discards1_sha256 != empty_sha256
> +        assert self.discards1_sha256 != empty_sha256
>   
>           # We want to calculate resulting sha256. Do it in bitmap0, so, disable
>           # other bitmaps
> @@ -135,7 +144,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap0')
> -        all_discards_sha256 = result['return']['sha256']
> +        self.all_discards_sha256 = result['return']['sha256']
>   
>           # Now, enable some bitmaps, to be updated during migration
>           for i in range(2, nb_bitmaps, 2):
> @@ -160,6 +169,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>           e_resume = self.vm_b.event_wait('RESUME')
>           self.vm_b_events.append(e_resume)
> +        return e_resume
> +
> +    def test_postcopy_success(self):
> +        e_resume = self.start_postcopy()
>   
>           # enabled bitmaps should be updated
>           apply_discards(self.vm_b, discards2)
> @@ -180,18 +193,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>               print('downtime:', downtime)
>               print('postcopy_time:', postcopy_time)
>   
> -        # Assert that bitmap migration is finished (check that successor bitmap
> -        # is removed)
> -        result = self.vm_b.qmp('query-block')
> -        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
> +        check_bitmaps(self.vm_b, nb_bitmaps)
>   
>           # Check content of migrated bitmaps. Still, don't waste time checking
>           # every bitmap
>           for i in range(0, nb_bitmaps, 5):
>               result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
>                                      node='drive0', name='bitmap{}'.format(i))
> -            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
> -            self.assert_qmp(result, 'return/sha256', sha256)
> +            sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
> +            self.assert_qmp(result, 'return/sha256', sha)
>   
>   
>   if __name__ == '__main__':
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

