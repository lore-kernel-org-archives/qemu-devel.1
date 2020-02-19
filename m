Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565CC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F53824671
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RhmDhs27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F53824671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QRF-0001DH-9Z
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4QQD-0000aV-Vb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4QQC-00050e-Pc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:33:53 -0500
Received: from mail-eopbgr60137.outbound.protection.outlook.com
 ([40.107.6.137]:24249 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4QQ6-0004ne-IT; Wed, 19 Feb 2020 09:33:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3bm3TRUZ22BrgR6jr2TPpad6m64jerRrKpt956oYowlfMLdLKd+IANX7x/YPBqcgrBcifkeoOd0ZKFwbyG5pBslfYRSJDfQvELo2MgjAkatVktGgM8JMAxRvKKxUBx7ukEz3H6bbHlC5dyj7bbM2c68FXgYelyFpTl5VFgUJuUvO5cyqgcfTO9xqfGUdch69FZO2NWgafZnLoIFuoSc14mT8SxQBOoHHSFDDrxM0A79jkMDR5UCpY1Cl0RrfloHJLniIfX7cLAMKf/5IpGGlOh8N+SP7NdODqTdacUd8Oz5bxbPce3n2BbnglgC62wOJ4gxzzT+VXPOyLcHuTiPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfGGumpPynmiFw4Jeab+tJYLGK2qZfXYk2fG2lFjCoo=;
 b=VKcPnttYFd7Nm+15HgMtZl2IxZjcCqNcPWGX7F5qnKXBESJy+dfwjFe24xt+SxrWWdRKRNgid0mLkrxyMbxEqAtxBfJWyVBH3BvR3sqctR+yGs+jJCpmnLJkMEiBER+XXj4XtxVRf9NznFo/I/3j1KVHxgA9eo6flSsNExgA6vetBacRIvZ8DpIZ82XN+mgMRyoE7YChdyhggEH5Q0EbBVWW/Fwf2Y6W+PgDnZ4vlQePd2m4eJCjF2hk85UkGMNpWyS18uTQZeVPkIvrJZR/tYTxJBzhW33KY6kIL6jRiJmjxaDgRH6GnUCExMWSb050M6a3WSSSANowNOvuIdliJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfGGumpPynmiFw4Jeab+tJYLGK2qZfXYk2fG2lFjCoo=;
 b=RhmDhs27mY1MZJc43imA1raCHPNm63DhLoGDqRhvIocbJiv6Xcbkh0R6qLk7khDDWhL0zJU7UdogaJmgLL0xw8BEYI5o6B1qu1tWll4Z7qf2M8OCRTOpfC1d9yqwz5HugXd/GYUAcsPkbJ0mCXbTG/ieJWR8BzbQu0rw0tIz/Fw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4167.eurprd08.prod.outlook.com (20.179.3.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:33:43 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:33:43 +0000
Subject: Re: [PATCH v2 16/22] qemu-iotests/199: change discard patterns
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-17-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <a2f512b5-ea33-a063-56e7-20fd250e867e@virtuozzo.com>
Date: Wed, 19 Feb 2020 17:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-17-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::28) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0101CA0018.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Wed, 19 Feb 2020 14:33:42 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1611a3ff-e782-4bc7-5cd0-08d7b548b83b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4167DCD5486B08F9F16C93DDF4100@AM6PR08MB4167.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39850400004)(199004)(189003)(2616005)(956004)(54906003)(66556008)(53546011)(81166006)(478600001)(66476007)(8676002)(16576012)(31696002)(44832011)(316002)(81156014)(31686004)(36916002)(52116002)(8936002)(4326008)(86362001)(66946007)(6486002)(5660300002)(186003)(16526019)(36756003)(26005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4167;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK+A3GL0znVoJnFIS8z/9XYlWnGbj72+LBa8eNG0CCzcwYyA+dW8wjPspmDIpD3H7/wToGOzWwIbqsohwSTct1MASon6uIA6iOt1NQY/UROGJ44yVXkh8NE2pSnnpAd0ny60YZRb67xU/ZKumNBQ4XC4ZIJNBvvwdxHNn0pw43g4vgqg1L2M/7vxMb7ac4S2PlA1uTx20oi1YbQ+nZOUgBlnr22nqOhnrukZ7ogQKmA7Olpl/ZaLlPyb7cDdEj5gTCMFgVcvj3qVI2JC5B1YoRl8/p3ZxXQoms7Q2oIXlcbs+Uq4ThRss5vPl+4SEs50s8KeTMiVH5Ikm5RBwFxO60Vb8bOdtCQlAm330rDkoUOOJoyPzup0MamaryOeq+mBApgQ7SgsgwjOiqT2GFNRrfAjMEZAofz4VKvm5/6b4ZMGWF3PqxcaCIAZZcLECBGl
X-MS-Exchange-AntiSpam-MessageData: +KAfD68CxMG3ZmDy2SCBQspNGUir0sU0la3NjX5IjbuX3qO2xPnJf2gCB3ZC0EVSWgrDtUFeTXwIPYdZi7lQKJxiRoozW1IFdm0hdFfaylbjzjqGKkWZOcokWstv9DFGUKjQj5wGCMeS/qBgyYxz+Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1611a3ff-e782-4bc7-5cd0-08d7b548b83b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:33:43.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaVek/ASIsgbBrM3fI53wL0DUVZUU5j0eYk3kN8TRGZi4CJD4geRdlEtCoxLJ5hBVRDlfNEgl0VFxymUvBT0rcXSxfKN9qynW3Ay5mtZorY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4167
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.137
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
> iotest 40 works too long because of many discard opertion. On the same

operations
At the same time

> time, postcopy period is very short, in spite of all these efforts.
> 
> So, let's use less discards (and with more interesting patterns) to
> reduce test timing. In the next commit we'll increase postcopy period.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 44 +++++++++++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index d78f81b71c..7914fd0b2b 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -30,6 +30,28 @@ size = '256G'
>   fifo = os.path.join(iotests.test_dir, 'mig_fifo')
>   
>   
> +GiB = 1024 * 1024 * 1024
> +
> +discards1 = (
> +    (0, GiB),
> +    (2 * GiB + 512 * 5, 512),
> +    (3 * GiB + 512 * 5, 512),
> +    (100 * GiB, GiB)
> +)
> +
> +discards2 = (
> +    (3 * GiB + 512 * 8, 512),
> +    (4 * GiB + 512 * 8, 512),
> +    (50 * GiB, GiB),
> +    (100 * GiB + GiB // 2, GiB)
> +)
> +
> +
> +def apply_discards(vm, discards):
> +    for d in discards:

If we run qemu-io only once, it will update the bitmap state and will 
speed the test performance up. Is that wrong idea?

> +        vm.hmp_qemu_io('drive0', 'discard {} {}'.format(*d))
> +
> +
>   def event_seconds(event):
>       return event['timestamp']['seconds'] + \
>           event['timestamp']['microseconds'] / 1000000.0
> @@ -80,9 +102,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_b_events = []
>   
>       def test_postcopy(self):
> -        discard_size = 0x40000000
>           granularity = 512
> -        chunk = 4096
>   
>           result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
>                                  name='bitmap', granularity=granularity)
> @@ -92,14 +112,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>                                  node='drive0', name='bitmap')
>           empty_sha256 = result['return']['sha256']
>   
> -        s = 0
> -        while s < discard_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
> -            s += 0x10000
> -        s = 0x8000
> -        while s < discard_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
> -            s += 0x10000
> +        apply_discards(self.vm_a, discards1 + discards2)
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap')
> @@ -111,10 +124,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
>                                  name='bitmap')
>           self.assert_qmp(result, 'return', {})
> -        s = 0
> -        while s < discard_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
> -            s += 0x10000
> +
> +        apply_discards(self.vm_a, discards1)
>   
>           caps = [{'capability': 'dirty-bitmaps', 'state': True},
>                   {'capability': 'events', 'state': True}]
> @@ -134,10 +145,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           e_resume = self.vm_b.event_wait('RESUME')
>           self.vm_b_events.append(e_resume)
>   
> -        s = 0x8000
> -        while s < discard_size:
> -            self.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
> -            s += 0x10000
> +        apply_discards(self.vm_b, discards2)
>   
>           match = {'data': {'status': 'completed'}}
>           e_complete = self.vm_b.event_wait('MIGRATION', match=match)
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

