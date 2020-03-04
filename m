Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4567BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001E1207FD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VT9EJYL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001E1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9On0-0007XS-5X
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 02:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9OmI-0006t6-7t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9OmH-0005EQ-4C
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:49:14 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::700]:1601
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j9OmE-0005BX-H5; Wed, 04 Mar 2020 02:49:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdF8R6kE1Y3Ml7z9fBW2alVl3B4r5iaYylFO7oMjGBZsOZo7/NVnS05o79OLdPgtKcw4TNAiKOwyYVyDinHhY5RxJw+gKaCq8dH6A6r8ItmM3JfAv0IPt8/VDJV5LfR10R0BrmkaH5YLM5UWgBuXtEJ6t9Tv5m/N1ap2wlgNYI5uw4SxIgsEuczguRbQLkGnn96t8wXpB7FpGNejYfUsNE/g0vetcYUeuOxUVpPkNgKEFqppYk7n/KYNffWCeGWqVVYPKqNWL3A7/XVyZU3FBcjIbXuqgQM6QPM76xRU1YEVndor7+vDJp4duOs1W7Q3N3QW0hTDpEgiNwXtsUHY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8t1w6SNm1ZE+sXGcQ+O3bfbiFWL2b1/aWGq4tIEMlE=;
 b=YeEHV1j2+jM/qkj25yeSm/DHmFTIRlRCvqoGaKFP1zudnSBNXuyl76YZwCXGJqybC2KwPlipLqsyAadixl3N1KHiiVWU+AhRzJfOb8O/Yc6PxLThUp8MwXanct4A6rprqDFWWLT/GJBlPnnQpvL7xr3HzEzudtf4i8xi8QJzpdXt1SH3EFAgKehIOcEdW4M5O3Uenr3w7VFJN4XMv/On04P05MVALtvNsMOjYW7xNLaATNpqxJscC4TL29mVJa98ZmsFRHGf+mj6w37KV9u3STvOC/Ep2hjORhcQXWvs6SU7kvNMDUwU0dYL4hutNIf6N3uCxDOMOQuqA924n/AyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8t1w6SNm1ZE+sXGcQ+O3bfbiFWL2b1/aWGq4tIEMlE=;
 b=VT9EJYL0rXA7N7Pckw/WMcUdlNokz0xuwBxsObYtFL/s6WXEBUEKj6hWAk7Tq2RSe/bqvjikn0Qo9qIZ9lm33kahd1ycYfhAk5LskJJI510ATB3CwQSHEdk1lR1XSIA5COK0sGZoR7S9NGh7jwr5IpyvxSepDH/RC+1VRaytoWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3669.eurprd08.prod.outlook.com (20.177.116.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 07:49:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 07:49:08 +0000
Subject: Re: [PATCH v4 4/5] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200304104905924
Message-ID: <3cbc685e-f606-daab-6dab-84e8fb80662e@virtuozzo.com>
Date: Wed, 4 Mar 2020 10:49:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200303133425.24471-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0044.eurprd04.prod.outlook.com
 (2603:10a6:3:19::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0044.eurprd04.prod.outlook.com (2603:10a6:3:19::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 4 Mar 2020 07:49:07 +0000
X-Tagtoolbar-Keys: D20200304104905924
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d870b05a-ca11-4bd2-b189-08d7c0108504
X-MS-TrafficTypeDiagnostic: AM6PR08MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB36697267F488002CBF530F58C1E50@AM6PR08MB3669.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(39850400004)(396003)(376002)(199004)(189003)(956004)(2616005)(6486002)(26005)(31686004)(31696002)(36756003)(81156014)(186003)(2906002)(52116002)(478600001)(81166006)(5660300002)(8676002)(86362001)(8936002)(66946007)(66476007)(66556008)(16526019)(16576012)(316002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3669;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gN6OicU2lkyCbUVOu02QgFBkZYHVRo68QDgpeMREYcoHbFS3ciggl8WQHXUiwlMh7bUb917wcP+Y4knwWdAGbu/g+rH4ohOGJdGdORMIB696kLE7oXYdeZ4C7xBifmMwY+yPfcw7a/I+Z+k0VG0S0WykdYYgggsZzm6+h+PtkIRzLyjY/C08yMNI/6ofaG19S/shRIQsSLtL+LwS0q/kWqXU8vI+kNMAjBi6EFlZPyM1Jxy674lvzd3Vc683B74ILupJpn7eR8Rzzf8Goi33bvfEDxeRNyu14oyInbzTomnkydd78Dhqf3lwM6NHmLyZbSmF0JUkWWrWj20/CdxESnm465x+8KvrYumk9kPBtvUmqyZy4CAcYK54UqWmHhnwDLe4FxE5p/sI7PUUpX9aNbtTAu7KxawLGp88tQPeVdDHui85Cnmk/pC3rvaVZWW7
X-MS-Exchange-AntiSpam-MessageData: WWM9HfqyPefVbA0YC6uuLHUJMzx/LWTb4zcVpn6mECUE899nWrzmhwDo6t0tnSCf0UjQtpg/ELv3LN9JyOI084FiJkllOOj3pF4iOntUhdA0G31J4u+0nwYWCDgz7q4U/dTp/ogf9PC5f61AtdGGSg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d870b05a-ca11-4bd2-b189-08d7c0108504
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 07:49:08.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0nDW03Y+prvp87bV/A9PCtqb0i88DTWchzTTgsNcdPRIZCpDeSPH0Fz+4XLQcLf/f3QeODft0LUiUmu/JmsQML+agbNW7dI4T/lgzpOlRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3669
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::700
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.03.2020 16:34, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                    src.img [zlib|zstd]_compressed.img
> decompress cmd
>    time ./qemu-img convert -O qcow2
>                    [zlib|zstd]_compressed.img uncompressed.img
> 
>             compression               decompression
>           zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

[..]

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    size_t ret;
> +
> +    /*
> +     * steal ZSTD_LEN_BUF bytes in the very beginning of the buffer
> +     * to store compressed chunk size
> +     */
> +    char *d_buf = ((char *) dest) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can store the compressed data length,
> +     * and there is some space left for the compressor buffer
> +     */
> +    if (dest_size <= ZSTD_LEN_BUF) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -= ZSTD_LEN_BUF;
> +
> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);

You may want to define ZSTD_COMPRESSION_LEVEL constant instead of raw number.

anyway,
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>




-- 
Best regards,
Vladimir

