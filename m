Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A64C34051
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109CB207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DcKojouR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109CB207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QnL-0002DK-2j
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Qlr-0000dx-2U
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Qlp-0004qE-Rg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:56:15 -0500
Received: from mail-eopbgr10135.outbound.protection.outlook.com
 ([40.107.1.135]:27520 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4Qll-0004mI-Nx; Wed, 19 Feb 2020 09:56:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXjGn+wr0zJXh+SJXS1jU8m9krbmYBEYhNhywBb6x/7628cBFdN+vqwVKoA42N9FKl2dmUO92GzZi0xKXki4FL1asTNh1A/Kwl/1GuM9/Lni5dCeleNpUz0Zd+gT7AyG59S5F6PCGnmXEykq+xk+2inAXMZj3QwVf72GZQDvKZvhjIkiZJ4qzFcFYjHlPKjif5s0Wj19CQ5SNXDHSujPYbMwF5DRNYdCIG/JNpD6P9guvtXDuTJ6gHVbPN59bXUM42mvD2mdVzlAS6r3/A8QLUgQLnOpMbEHc7DvCSdDd6FoC4hP73j1W3U3L5tLSQ1agHYdC8tF/7ttO6P1DhdC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeOSw8KjeqqWCZgOl1H9GRngSu4GUwzKz9lYtNsf3LY=;
 b=Lj/5827gmTppEVxOsnbwLLZP7XcEXsFP1vCjYrIA0Zw6GrPaQyo9PoHgxC+toUCkYqI+6IoXZU01tA/m4mN5B2q+D0/sToPlf7kyXKb3VzAXOecxL4T0izO4AUBYsUGAS/9GFzUsynSZ9Tw7xJpklLFBqInzi3k7Gg+MHevfS/8vCfhTFvfuh+IrqTuYLxpjCa3yMuVDrZWQcDtmD/uQXKSo00ixUqvaIvW1y4dA34D/mE+/E/Mkb39hgy/pKlG9iUcPDd9L5x1Mu0DsPshJ6bXAfl1EVu56KDLs2bTX1OXy9Vd0Gi3+g43cc/0GvbBNFdOlDdd+tdzj63fXj1Te7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeOSw8KjeqqWCZgOl1H9GRngSu4GUwzKz9lYtNsf3LY=;
 b=DcKojouRjdBK18/MHkJxFIsxcPO24RNqQfhvXcith4r2E5e/VlUlIgoait3AQFTF9+/m57FT5SRLkqHT10BGv3L5cpAtKIGVdXaVljU7BAx5EDKe8KywM23sUPaqWIhUYLaJb+HGvmRUp5ZrEuPNE1dEENLbgR35LrGiyJxWdO4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4023.eurprd08.prod.outlook.com (20.179.1.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 14:56:06 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:56:06 +0000
Subject: Re: [PATCH v2 17/22] qemu-iotests/199: increase postcopy period
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-18-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <e7202794-aebf-36d1-7855-8bebcdb43f92@virtuozzo.com>
Date: Wed, 19 Feb 2020 17:56:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0324.eurprd05.prod.outlook.com
 (2603:10a6:7:92::19) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0324.eurprd05.prod.outlook.com (2603:10a6:7:92::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Wed, 19 Feb 2020 14:56:05 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20591bd2-8999-4847-f902-08d7b54bd8ce
X-MS-TrafficTypeDiagnostic: AM6PR08MB4023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40238F590F8705615DEAE757F4100@AM6PR08MB4023.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39850400004)(366004)(346002)(199004)(189003)(66556008)(16576012)(316002)(31696002)(956004)(36916002)(86362001)(2616005)(6486002)(52116002)(36756003)(26005)(54906003)(66476007)(4326008)(81156014)(5660300002)(44832011)(478600001)(2906002)(31686004)(8676002)(66946007)(8936002)(53546011)(81166006)(186003)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4023;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4O/QgCylQpYmwKilfwzrNdmuojGmECS6Dm/U0MZ47llcqfx1p+J6trMRaS8KDS806x5RY0XtoKcHEUuzxn10Y2vZhdGEdgLDEQRTVLY2PvlLWK0Bp7rFejm0BVKMeu92sfggIeUnEvyLOHkuznGetBRWgsXJiRufB/6yqjr/9RHN+uSwIB/jNdBUM9B6zwWseRpXZO8a0gmFuGwzQLLme2j3X06alNiiT3xqCXGkWSukxam9eniVdZhjod/e4GJkmztKX3SIUEU660qetKNcIITP8SJW5TmbZuuots7otyVgLzXlKDrPvP3VMWDCzoNyDrYudTcrhlkzQym0HgE3HKxKf7Hp6M5C6uKuyBMSJhr+4m1IV3nn0vQOpZNSOzsr/cUQnoXz/gS1jTOswlZnQiP2TsT45BI91UFjToFfLnDN7nLOpBpN/SJCE8fYbyU
X-MS-Exchange-AntiSpam-MessageData: 6TNjcr2J7r0sOV63Pvd6W2TVCLqtcwvkqXyB06QJ/P0aru46x2rCNw3+6/t1JdNzqVdhv59kuBLiZq4XUfu9abQBp6nVAgWPAXyocyyS+qXim0Ax5wB9FKTyCKmkMcGW7/MvkugYBFj8RG9wo/R7RA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20591bd2-8999-4847-f902-08d7b54bd8ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:56:06.2930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qph2sXBVbpQTwEXY05acpRsuLZCLXaFnF3WEr6pVHTIKACerryUGxUXw/A0Zde5KV5lSDPoymqdmSklqcuK5KUNvYEdi5CZDqBg0pSxqbhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4023
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.135
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
> Test wants force bitmap postcopy. Still, resulting postcopy period is
> very small. Let's increase it by adding more bitmaps to migrate. Also,
> test disabled bitmaps migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 58 ++++++++++++++++++++++++++++--------------
>   1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 7914fd0b2b..9a6e8dcb9d 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -103,29 +103,45 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>       def test_postcopy(self):
>           granularity = 512
> +        nb_bitmaps = 15
>   
> -        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
> -                               name='bitmap', granularity=granularity)
> -        self.assert_qmp(result, 'return', {})
> +        for i in range(nb_bitmaps):
> +            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
> +                                   name='bitmap{}'.format(i),
> +                                   granularity=granularity)
> +            self.assert_qmp(result, 'return', {})
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> -                               node='drive0', name='bitmap')
> +                               node='drive0', name='bitmap0')
>           empty_sha256 = result['return']['sha256']
>   
> -        apply_discards(self.vm_a, discards1 + discards2)
> +        apply_discards(self.vm_a, discards1)
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> -                               node='drive0', name='bitmap')
> -        sha256 = result['return']['sha256']
> +                               node='drive0', name='bitmap0')
> +        discards1_sha256 = result['return']['sha256']
>   
>           # Check, that updating the bitmap by discards works
> -        assert sha256 != empty_sha256
> +        assert discards1_sha256 != empty_sha256
>   
> -        result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
> -                               name='bitmap')
> -        self.assert_qmp(result, 'return', {})
> +        # We want to calculate resulting sha256. Do it in bitmap0, so, disable
> +        # other bitmaps
> +        for i in range(1, nb_bitmaps):
> +            result = self.vm_a.qmp('block-dirty-bitmap-disable', node='drive0',
> +                                   name='bitmap{}'.format(i))
> +            self.assert_qmp(result, 'return', {})
>   
> -        apply_discards(self.vm_a, discards1)
> +        apply_discards(self.vm_a, discards2)
> +
> +        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> +                               node='drive0', name='bitmap0')
> +        all_discards_sha256 = result['return']['sha256']
> +
> +        # Now, enable some bitmaps, to be updated during migration
> +        for i in range(2, nb_bitmaps, 2):
> +            result = self.vm_a.qmp('block-dirty-bitmap-enable', node='drive0',
> +                                   name='bitmap{}'.format(i))
> +            self.assert_qmp(result, 'return', {})
>   
>           caps = [{'capability': 'dirty-bitmaps', 'state': True},
>                   {'capability': 'events', 'state': True}]
> @@ -145,6 +161,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           e_resume = self.vm_b.event_wait('RESUME')
>           self.vm_b_events.append(e_resume)
>   
> +        # enabled bitmaps should be updated
>           apply_discards(self.vm_b, discards2)
>   
>           match = {'data': {'status': 'completed'}}
> @@ -158,7 +175,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           downtime = event_dist(e_stop, e_resume)
>           postcopy_time = event_dist(e_resume, e_complete)
>   
> -        # TODO: assert downtime * 10 < postcopy_time
> +        assert downtime * 10 < postcopy_time
>           if debug:
>               print('downtime:', downtime)
>               print('postcopy_time:', postcopy_time)
> @@ -166,12 +183,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           # Assert that bitmap migration is finished (check that successor bitmap
>           # is removed)
>           result = self.vm_b.qmp('query-block')
> -        assert len(result['return'][0]['dirty-bitmaps']) == 1
> -
> -        # Check content of migrated (and updated by new writes) bitmap
> -        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
> -                               node='drive0', name='bitmap')
> -        self.assert_qmp(result, 'return/sha256', sha256)
> +        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
> +
> +        # Check content of migrated bitmaps. Still, don't waste time checking
> +        # every bitmap
> +        for i in range(0, nb_bitmaps, 5):
> +            result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
> +                                   node='drive0', name='bitmap{}'.format(i))
> +            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
> +            self.assert_qmp(result, 'return/sha256', sha256)
>   
>   
>   if __name__ == '__main__':
> 

The updated test passed.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

