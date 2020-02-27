Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED41AC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DCF24670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Btp2d+MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DCF24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G4a-0006gB-RA
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7G2F-00041i-SM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7G2C-0000o5-Ci
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:04:51 -0500
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:13280 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7G24-0000BF-BH; Thu, 27 Feb 2020 05:04:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E43n3/aKml8YDbqGjiXZ0OdbG++hdlAGkyevqKAWLDVqF6zCrCI8EFHwG6gViCzYKE4ene1s1Fse95UsITiyOK+9YJKRmLJ28kAanfNTWN2d0cSvXVpHFO3FBi+n6jYswrnRxe7gKqQQczwWhXKq+SeY/3OmKLcajxYintEZtCjkqndj1e20VXX9PX2JRjgrhABRdLu1YpODAm9mdhvhGjvTdoSWYvv3MBzDyuczefRAB5cYfxGWxVpZlJl2gKpW5Cg/BqPHy93VRTbcQ6Szi0+mM/3chSPV81GUjhc6fxfvAcbwdKHvO47FPipwu7qRr4awTRS8Rg0pfZmDS0XQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRPt8mPmAvi2DmOWB7xiYRbkN1JQ0aPN40SL8NXqmSY=;
 b=PCUkcn8fykUMUcIk2G3p7pdUVRoXWpM4+yGjXDRAgQDdFFcjw9cEnqG3Rp+sDuocXAWEy4M7+P+rtuFXSQtoHj5z8kwDCAa+64LJ82YuNrgqcEqSfnGCDw1Xa8cixEN0py1K8ktPSj1qkHk4odRpJruCaVLltlsPHJyOBCkuqV4bOJQ+q6OWZJXpENIdbrlVX9VsJoXnp7J+cKXslxax7/Kf5kQhgjlrQplfOcK2FBKS6kxXEfvj9FQ75mih9boAOKgi+r9P3CKXud4ScgaTPV2r8DLlAbTII3wFxpERF0dGVQ8YEsHg5NEN8Af+EL0hsBennyGWeM7+4OCrOfqDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRPt8mPmAvi2DmOWB7xiYRbkN1JQ0aPN40SL8NXqmSY=;
 b=Btp2d+MSTpUV5ZbW0+7K49A5Q21s9h+PerXRmwg0YpF4TQ+76FeCaHOdCkczKaPIt7uPdDuxumoMVnUTekMZzyXZdblXfq4VbjptBXpskC35Q1Oou4VtgZA5LbVo3bhOj9jbrwf2aO/ZS0hoTbamf1OnExttVZCkzxmH65ntxyg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2895.eurprd08.prod.outlook.com (10.175.243.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:04:38 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:04:38 +0000
Subject: Re: [PATCH v1 6/8] iotests: add "compression type" for test output
 matching
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-7-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227130435310
Message-ID: <8003b87c-0d0d-6b00-0065-0b227ec97221@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:04:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-7-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::27) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 10:04:37 +0000
X-Tagtoolbar-Keys: D20200227130435310
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bd0cbae-c0df-4fd4-87c0-08d7bb6c7451
X-MS-TrafficTypeDiagnostic: VI1PR08MB2895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB28957089737E95A24C435D10C1EB0@VI1PR08MB2895.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(376002)(39840400004)(396003)(189003)(199004)(316002)(8936002)(31686004)(66946007)(66476007)(66556008)(36756003)(52116002)(30864003)(86362001)(16576012)(2906002)(31696002)(5660300002)(8676002)(4326008)(81156014)(26005)(478600001)(186003)(16526019)(2616005)(81166006)(956004)(6486002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2895;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6y6hFLTDLZmYUqPcr/UvDi0bfe8Hb3buKqjlc8moksx1bwic4Psjc7Q6VdEUrnTal3CBJiqu/4hGjofSM3VunPbTRxU4qNh584TE5xEmOdDbPsLaL6NLTPuhqFW5Wlyb6Q6Z5i+zBssEBugX5jgt0M1IDMzwCr2UMft0oAJWGEz8qRfR86eaHxd+YA9gLDn1yMjrjtOzjD7diQcHjfn2D4bbS/1Z1IcRlevE1tH4Mh5xiXbklABdTutaoBB4fK0VjwZogVwkfIf6qoDqFaytv1MKXaJcup61melJRbZeZZ+SbCeQuLDCV5D0fXao24Ocm/NpXk82Rjkb3TsThyJEWRrPu2FOKyu1Zcg5QW/h8pFLVqoVmSE9HUEZi2wqrfbtN0EVXpQaOWgKiFcbUpl/euw5lo5OOVqYLDX9HAy9G/ed9nQnaLIVZ9uSM/mm1Zuvdxz3VNGhQBFxNnl4G7X74Pl3nAJNlEMiZwqjuge5MdM0AzjqSltMQeS1kJVWDXR
X-MS-Exchange-AntiSpam-MessageData: mJMNkTZyxIkq/+NFcfAIYkl4cHbtme4dcMUaXdMLneiM/oIIJ667rjBXGYMAOllDVSialIM8T65wgis2X24rByQ2u+nOLaLvQvPbLKVgdKsVYxE/aBOD+k4cG7xyFAob3bnMnMGXG6LoRauVN8x2Yg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd0cbae-c0df-4fd4-87c0-08d7bb6c7451
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:04:38.0615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF4PvU7hg3HGNC6PIDtOUHi3XB1kwxH5P2o9Hs+UKMazaUF2OD5cOz4vv+klKpfeBET7lX34ZCdwLHRYCw0g8Obfn7MfqGJUO6UWELD2zE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2895
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.100
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
> Affected tests: 049, 060, 061, 065, 144, 182, 242, 255
> 
> After adding the compression type feature for qcow2, the compression type
> is reported on image quering.
> 
> Add the corresponding values of the "compression type" for the tests' output
> matching.

And this and the following patch.

Ideally, patch should not break any iotests. This means that all iotest updates
should be merged to the patch which changes their output. Probably, you can split
behavior-changing patch, to reduce iotest-updates per patch, but anyway, big patch
with a lot of iotests updates is better than patch which breaks iotests.

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/049.out | 102 ++++++++++++++++++-------------------
>   tests/qemu-iotests/060.out |   1 +
>   tests/qemu-iotests/061.out |   6 +++
>   tests/qemu-iotests/065     |  20 +++++---
>   tests/qemu-iotests/144.out |   4 +-
>   tests/qemu-iotests/182.out |   2 +-
>   tests/qemu-iotests/242.out |   5 ++
>   tests/qemu-iotests/255.out |   8 +--
>   8 files changed, 82 insertions(+), 66 deletions(-)
> 
> diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
> index affa55b341..a5cfba1756 100644
> --- a/tests/qemu-iotests/049.out
> +++ b/tests/qemu-iotests/049.out
> @@ -4,90 +4,90 @@ QA output created by 049
>   == 1. Traditional size parameter ==
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == 2. Specifying size via -o ==
>   
>   qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == 3. Invalid sizes ==
>   
> @@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
>   == Check correct interpretation of suffixes for cluster size ==
>   
>   qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == Check compat level option ==
>   
>   qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
>   qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
>   qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == Check preallocation option ==
>   
>   qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
>   qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == Check encryption option ==
>   
>   qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   == Check lazy_refcounts option (only with v3) ==
>   
>   qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
>   qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
> -Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
>   
>   *** done
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index d27692a33c..3e47f537e8 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -17,6 +17,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       corrupt: true
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index cea7fedfdc..c913f02ad6 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -491,6 +491,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file: TEST_DIR/t.IMGFMT.data
> @@ -511,6 +512,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file: foo
> @@ -524,6 +526,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file raw: false
> @@ -538,6 +541,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file: TEST_DIR/t.IMGFMT.data
> @@ -550,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file: TEST_DIR/t.IMGFMT.data
> @@ -563,6 +568,7 @@ virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       data file: TEST_DIR/t.IMGFMT.data
> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
> index 6426474271..106303b5a5 100755
> --- a/tests/qemu-iotests/065
> +++ b/tests/qemu-iotests/065
> @@ -88,23 +88,25 @@ class TestQMP(TestImageInfoSpecific):
>   class TestQCow2(TestQemuImgInfo):
>       '''Testing a qcow2 version 2 image'''
>       img_options = 'compat=0.10'
> -    json_compare = { 'compat': '0.10', 'refcount-bits': 16 }
> -    human_compare = [ 'compat: 0.10', 'refcount bits: 16' ]
> +    json_compare = { 'compat': '0.10', 'refcount-bits': 16, 'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 0.10', 'compression type: zlib', 'refcount bits: 16' ]
>   
>   class TestQCow3NotLazy(TestQemuImgInfo):
>       '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
>       img_options = 'compat=1.1,lazy_refcounts=off'
>       json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
> -                     'refcount-bits': 16, 'corrupt': False }
> -    human_compare = [ 'compat: 1.1', 'lazy refcounts: false',
> +                     'refcount-bits': 16, 'corrupt': False,
> +                     'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 1.1', 'compression type: zlib', 'lazy refcounts: false',
>                         'refcount bits: 16', 'corrupt: false' ]
>   
>   class TestQCow3Lazy(TestQemuImgInfo):
>       '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
>       img_options = 'compat=1.1,lazy_refcounts=on'
>       json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
> -                     'refcount-bits': 16, 'corrupt': False }
> -    human_compare = [ 'compat: 1.1', 'lazy refcounts: true',
> +                     'refcount-bits': 16, 'corrupt': False,
> +                     'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 1.1', 'compression type: zlib', 'lazy refcounts: true',
>                         'refcount bits: 16', 'corrupt: false' ]
>   
>   class TestQCow3NotLazyQMP(TestQMP):
> @@ -113,7 +115,8 @@ class TestQCow3NotLazyQMP(TestQMP):
>       img_options = 'compat=1.1,lazy_refcounts=off'
>       qemu_options = 'lazy-refcounts=on'
>       compare = { 'compat': '1.1', 'lazy-refcounts': False,
> -                'refcount-bits': 16, 'corrupt': False }
> +                'refcount-bits': 16, 'corrupt': False,
> +                'compression-type': 'zlib' }
>   
>   
>   class TestQCow3LazyQMP(TestQMP):
> @@ -122,7 +125,8 @@ class TestQCow3LazyQMP(TestQMP):
>       img_options = 'compat=1.1,lazy_refcounts=on'
>       qemu_options = 'lazy-refcounts=off'
>       compare = { 'compat': '1.1', 'lazy-refcounts': True,
> -                'refcount-bits': 16, 'corrupt': False }
> +                'refcount-bits': 16, 'corrupt': False,
> +                'compression-type': 'zlib' }
>   
>   TestImageInfoSpecific = None
>   TestQemuImgInfo = None
> diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
> index c7aa2e4820..885a8874a5 100644
> --- a/tests/qemu-iotests/144.out
> +++ b/tests/qemu-iotests/144.out
> @@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
>   { 'execute': 'qmp_capabilities' }
>   {"return": {}}
>   { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
> -Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   {"return": {}}
>   
>   === Performing block-commit on active layer ===
> @@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
>   === Performing Live Snapshot 2 ===
>   
>   { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
> -Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   {"return": {}}
>   *** done
> diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
> index a8eea166c3..ae43654d32 100644
> --- a/tests/qemu-iotests/182.out
> +++ b/tests/qemu-iotests/182.out
> @@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
>   {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>   {"return": {}}
>   {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1' } }
> -Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   {"return": {}}
>   {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>   {"return": {}}
> diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
> index 7ac8404d11..091b9126ce 100644
> --- a/tests/qemu-iotests/242.out
> +++ b/tests/qemu-iotests/242.out
> @@ -12,6 +12,7 @@ virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       refcount bits: 16
>       corrupt: false
> @@ -32,6 +33,7 @@ virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       bitmaps:
>           [0]:
> @@ -64,6 +66,7 @@ virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       bitmaps:
>           [0]:
> @@ -104,6 +107,7 @@ virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       bitmaps:
>           [0]:
> @@ -153,6 +157,7 @@ virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
>   Format specific information:
>       compat: 1.1
> +    compression type: zlib
>       lazy refcounts: false
>       bitmaps:
>           [0]:
> diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
> index 348909fdef..a3c99fd62e 100644
> --- a/tests/qemu-iotests/255.out
> +++ b/tests/qemu-iotests/255.out
> @@ -3,9 +3,9 @@ Finishing a commit job with background reads
>   
>   === Create backing chain and start VM ===
>   
> -Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
> -Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   === Start background read requests ===
>   
> @@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
>   
>   === Create images and start VM ===
>   
> -Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
> -Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> +Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>   
>   wrote 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 


-- 
Best regards,
Vladimir

