Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C84C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F12222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E6PMnVY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F12222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FyL-0000Bd-M1
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7FxG-0007vd-6A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7FxE-0003LH-Nm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:59:42 -0500
Received: from mail-ve1eur01on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::713]:63461
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7FxA-0003B0-OJ; Thu, 27 Feb 2020 04:59:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7L19T8oKSHoP9fn9t7q6svKjGR0Ga1j77YsK3Sp4o2/u5eRQT0yHR6weZZOzOZ1U82OYmgrR0f0kEBW0FiPDDMX3cV3zSRz4usTSRzqH0dnzZCD1p6Z85IsUp4d4CubktHAtUknm0xHycdFrq/OYqPP5bTZ9PjuqRgvYLPzngHGyq8z+YaLPpeHD+z0xsKmOqLc4L+v4EIUFEkZAnd2Ldxn7Unn5KFPn+2nW9Pcb+mzWNpxDhfxDsaolwlMNoNueLv5nnH49Ws0/U627kN7Z6mdw8jbRxDEInZM0KDr6RXbPunz866oYQoGcxR82ZBu02TVyfJYzxpqkqRWl+8P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIyzuWVIv4nH1hUD3QDkLxpUFVnMjyeTQ251TygA9iA=;
 b=mzDN72z4yltRHcEpeE43jkfkz+gZdGnz2MQZkBjQlwhEHWsh08668muuFDO5XRFvOrzfd1+21+6EMwuN95p6ZlFd3DXqK8YfciPEoD4+pYB7Ojtwc64SjCGPIp7rdzdKM5oa49B+iif7ooaQNo1/v+I1TD7hjyfW7dF0InU74KUSKhfQsUbbN0RjEizqI9V1rtWu6WkpAHpvZpIDo2SrN1kWpIDHeOk7sV2sQrXyFxB7v498tjCGL337AfOfwH4UhDAsrwl1aPMWOI1HGOwnOySleFLMrBdHERq5ODtkKBCfYgzXww2eMJzCuLeKyAsAA9pugbbx5PgEs44O2K7ZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIyzuWVIv4nH1hUD3QDkLxpUFVnMjyeTQ251TygA9iA=;
 b=E6PMnVY3L08vazUJ/EbxCwr+j1sgLIEvV8hb+E2WdN+OfvKIQHS8hU1MMOf+hpri0YTJpA4JmERiKj0w4o1c4up/cGqcxWxB8qPYaq3N50DHszPXVGlkzHyQqtWeUUAN6woAjxAmDNGuwjhM1RGLu/KrReaE1hqDzd3EHK8043Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2895.eurprd08.prod.outlook.com (10.175.243.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 09:59:32 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 09:59:31 +0000
Subject: Re: [PATCH v1 5/8] iotests: fix header size, feature table size and
 backing file offset
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-6-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227125929062
Message-ID: <1df0c759-22e4-264d-852f-5187be7b4abd@virtuozzo.com>
Date: Thu, 27 Feb 2020 12:59:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-6-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:7:29::37) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0108.eurprd02.prod.outlook.com (2603:10a6:7:29::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Thu, 27 Feb 2020 09:59:31 +0000
X-Tagtoolbar-Keys: D20200227125929062
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a71137-bc73-41cb-f804-08d7bb6bbdda
X-MS-TrafficTypeDiagnostic: VI1PR08MB2895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2895D5F0E1AB2DEB789D039FC1EB0@VI1PR08MB2895.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(5660300002)(4326008)(8676002)(31696002)(16576012)(2906002)(6486002)(478600001)(186003)(16526019)(81156014)(26005)(2616005)(956004)(81166006)(66476007)(66556008)(31686004)(66946007)(316002)(8936002)(86362001)(36756003)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2895;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXB4YwQEN+wSRnyvCyRCzTA2XGZW7uEot2jp/XOAmb2xHvccMalOA2cl9LeEDBSkalvWAY45xTJSKD/Yl25ncOpNGz28kH54L91tkX68t3Wk3oiBBzpA99TcvTtjYP+l0aFOKOGTJsorlhZyTDMLAPFZ3hQ2loTc6EpwbwantIAfdTLwdbMgpIS2qrXIlBKiIa+YGRDvoIb+gSCQkPcoj1o1CoV6SVI+qPrX+i2JxxQWRgk4vYQP1mRycPdR9uHENFtLu4oinImbPHe32z3zdQiBRZLCFYhElSOhjhmByrK1Sr5K9ArYbDGiPEU6F/ELuy4y7AISdWab0DazS/bNa2IsGb0rwR5rqyyAJ6j1uRsdK562A1EdGKCrsutn2yx4DuerrmoZ2/gcsG/+mHFGE4Jh6e8CmB+h3GjX3OtBGguWcVfyqqtMm+ziidxI8fYZ
X-MS-Exchange-AntiSpam-MessageData: e1xI1FTU0gZqEtMnAjTWCf6/OAVGmCde+KTDKhpUk0ImJKua3sgM+ZS60dK9EXVUXOK5uPVwoDM4INAfeBhTLonwhfsrLysdeJUpc7T/S1Q8OIQuUVZAt9KiWLRth8EZRCLCaEw7p/ZV90fi44/RoA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a71137-bc73-41cb-f804-08d7bb6bbdda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 09:59:31.8542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a92UzTum/NMpzLnkBzEyuJVZ3nQ4mXxDviwhRgLc7nbHGy+yPfV53EbBdnPtibWZyWryXUF9j56XhThwfGD66TrVoxp6xLTEyUYXNSE4JEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2895
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::713
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
> Affected tests: 031, 036, 061
> 
> Because of adding the compression type feature, some size values in the
> qcow2 v3 header are changed:
> 
> header_size +=8: 1 byte compression type
>                   7 bytes padding
> feature_table += 48: incompatible feture compression type
> 
> backing_file_offset += 56 (8 + 48 -> header_change + fature_table_change)
> 
> Change the values for the test output comparison accordingly.

Again, this should be merged to the patch, which actually break iotests.

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/031.out | 14 +++++++-------
>   tests/qemu-iotests/036.out |  4 ++--
>   tests/qemu-iotests/061.out | 28 ++++++++++++++--------------
>   3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index d535e407bc..ed51afe9ce 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -113,11 +113,11 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   Header extension:
> @@ -146,11 +146,11 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   Header extension:
> @@ -164,7 +164,7 @@ No errors were found on the image.
>   
>   magic                     0x514649fb
>   version                   3
> -backing_file_offset       0x178
> +backing_file_offset       0x1b0
>   backing_file_size         0x17
>   cluster_bits              16
>   size                      67108864
> @@ -179,7 +179,7 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0xe2792aca
> @@ -188,7 +188,7 @@ data                      'host_device'
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   Header extension:
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index 0b52b934e1..fb509f6357 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -26,7 +26,7 @@ compatible_features       []
>   autoclear_features        [63]
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   
> @@ -38,7 +38,7 @@ compatible_features       []
>   autoclear_features        []
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 8b3091a412..cea7fedfdc 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -22,11 +22,11 @@ incompatible_features     []
>   compatible_features       [0]
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   magic                     0x514649fb
> @@ -80,11 +80,11 @@ incompatible_features     []
>   compatible_features       [0]
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   magic                     0x514649fb
> @@ -136,11 +136,11 @@ incompatible_features     [0]
>   compatible_features       [0]
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   ERROR cluster 5 refcount=0 reference=1
> @@ -191,11 +191,11 @@ incompatible_features     []
>   compatible_features       [42]
>   autoclear_features        [42]
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   magic                     0x514649fb
> @@ -260,11 +260,11 @@ incompatible_features     []
>   compatible_features       [0]
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   read 65536/65536 bytes at offset 44040192
> @@ -294,11 +294,11 @@ incompatible_features     [0]
>   compatible_features       [0]
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   ERROR cluster 5 refcount=0 reference=1
> @@ -323,11 +323,11 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
>   refcount_order            4
> -header_length             104
> +header_length             112
>   
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    240
>   data                      <binary>
>   
>   read 131072/131072 bytes at offset 0
> 


-- 
Best regards,
Vladimir

