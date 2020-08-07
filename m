Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB28C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138F0206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MrMxhn3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138F0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yp6-0004K4-Cb
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3yoO-0003qU-KL; Fri, 07 Aug 2020 05:37:16 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com
 ([40.107.21.107]:42208 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3yoL-0003ag-47; Fri, 07 Aug 2020 05:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAadDrJ6RxSWPEbe+flVpmAe5QaxEESrjk9UQxTIVk9tuIkJDSrK8MS3J+uhRaLDhIifDKLPeagly+WDYixAJeAaegbfj/KlTV05i54otPys93qikiIsUhpiGWq0FiDEEoIjPgpfNuY+bZqkcPpNw9K14nyWe2GWdPIyAODbzXG714BXJW16Jw01XYBxCiue2eXsRSVBNnGW10G5zEcaDK1EKImyuHMtWCWeX9Xl0nCgNwxF8dhS/E5zHbnjyKjkC1H0lE9FYkcGeyN7isyPQv5LedwSv0kPBe4gkanEFKVBsuH2X0jmwEGdi2tG398eMNbIUwA8zNOvmX6/ZLK9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG2Ou7bHzjbQk5u6X0h/FPFa7iZWrAmOddVBE0dzztI=;
 b=kDndFrjgCbtlFd10h3EfIealKd2J/OCkJWIQc/seKt7+EbJ+1yetG6ATRMGdvYuUoGqvt5f5qOSE9gV2qQ1aitBli/5d626LIAmY+zkADhLVTc+m11uxEP3fyyIQw0tWhh4xmVyz3bB2ALVEGS6CX3v0pHQ7DVry7LhT9SQXj2Ld/RaJ9BBOgW3f50N/PTTVpBgOOKcQMCPoukiR75ApYH+QDzdoCwxcuCNsaXNzmIitqH9r2NJw9V1FPdeeaSdgsMN3M+idoiCbLlgnHXG5ya9zsxTz0PV3qWe8phVt0A/9AZOzTREQNG2itSTpYMh2M5MvC8cQeGe3MKNSpWzHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG2Ou7bHzjbQk5u6X0h/FPFa7iZWrAmOddVBE0dzztI=;
 b=MrMxhn3DFFQUYmy1ipK26mooTItAqfW/64UYP9gaHm4JP1St/o3poDjB4lNg9S3uDTL+a/4L6GBm03hqsZKVdY9FuR+C7vSUGakkDguIjfux8qhaggpCx04bRfZKe3kI+iXCri6l2wJDoQEHvYGxFPMjmSmUg8dOzTxDEM8S6AY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3448.eurprd08.prod.outlook.com (2603:10a6:20b:50::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 09:37:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 09:37:09 +0000
Subject: Re: [PATCH v7 03/47] block: bdrv_cow_child() for bdrv_has_zero_init()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e250cd60-27f9-5c15-e045-4d758ddcafc2@virtuozzo.com>
Date: Fri, 7 Aug 2020 12:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200625152215.941773-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Fri, 7 Aug 2020 09:37:09 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c2ffda-1913-4b16-c847-08d83ab574d8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3448:
X-Microsoft-Antispam-PRVS: <AM6PR08MB34481C8B0C9E5F4AC254E2F6C1490@AM6PR08MB3448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axI+3Jtu5ligFOC54DV/PSheUilZcK91iROSEin3IlGI6YXp7QE9Fyf449Hs9UT1IJHiS4yOihUdMNmGTAOpIUjMwZSsAAe4m0DdO9Sct+ZP32eexmiloLVaYRVIJDkngCydbtP5CDAe85O1f7eMg45UOWQrhmGF43EtWa8zNGg8iLRbWI4iWZ5FUFO9BT+BMlTxiAesKzDMibCOqhtr5PN81+SPf5sUdG3TiYZ/Bc/Yk6OReGiPB92jnTy5SGxN5PCD3gfcVaOkRiFhs2N0ECrHSEqhL0ekf++AxesbMtI9Yio1ezKhI7HstyRJw1U8Aa3W7xmTKEGoalZN0zy3b3juSx9/lwaguY7TsMWz0c/70aTdazrMo8HTBoj4hAcV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(4326008)(2906002)(5660300002)(16526019)(316002)(16576012)(31686004)(186003)(52116002)(8676002)(66556008)(31696002)(478600001)(86362001)(2616005)(8936002)(26005)(83380400001)(66946007)(956004)(36756003)(6486002)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ESaeRtCRWU6t3tkmk48Cutvg0DwJ5/xq/YNvXHI/PsRtWeWsdqWJO5FOkOKXB2OgZfM3JmZIq3xNv/MCrNWYx4qTUW+0lOAy/OO5G3s6/mxXy24lIvlSxF+jASbMYopBKr4Jt9Jzaio9yn3D4aA+Mqb2ZyPgEWFLpGJe/XcMVfGKlzVJBaFfUbl+D1ZD5qPmRq7MH+g9uaqI3DWxsx9Y/UtTnNwA93glFkMx5nEOpuckygVuCo02zqumr8yVkdLqxX42al6ACN4ZzJI5mmoTTuI1MPHz7DC/tySP7C3G8Js84cW4uzmh1fwD72OjobeiaMg7gm4CxROyydO/C8QuImnq4TrbZq7OPeQrXwWzzlPsbeRhLQb+0ake8Eq8Y/maLMYjhJQwzZ9/MieprKZ1a+q1j+z4UIjkM6p7nqyCr2lR8sX+ao4ELzITT+q/bsYF5D126bO1MgAlfYnYmyhKuE7/37aiqzv/S5DKr6ruGlY79fS7FD011Sh52h+Deya5uQP7mvDlJjJ5U7vKTAaUMWjRVy6GxUIY4xmC7mNsW9gpvfCCcHItxtEpaH2q9HABOf3qaOqCgTay5EskMyAv2ZxP/7vn+kUTXG6aH9/6uEuWxYVW9bwmIE+Lz4u+pKt01HzXTczIDPWdmhUgfFcxaw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2ffda-1913-4b16-c847-08d83ab574d8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:37:09.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q210L+JSIx/fBsH42IZBcoo85NeTAiajLZKVhTYHxQyZLWGTmawaKc0SLbH8tjP3We1drtzBIWSsW+Qa7n1lhj5OBOrtA6lSLuPJiwQT1Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3448
Received-SPF: pass client-ip=40.107.21.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:37:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 18:21, Max Reitz wrote:
> bdrv_has_zero_init() and the related bdrv_unallocated_blocks_are_zero()
> should use bdrv_cow_child() if they want to check whether the given BDS
> has a COW backing file.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 0a0b855261..f3e2aae49c 100644
> --- a/block.c
> +++ b/block.c
> @@ -5394,7 +5394,7 @@ int bdrv_has_zero_init(BlockDriverState *bs)
>   
>       /* If BS is a copy on write image, it is initialized to
>          the contents of the base image, which may not be zeroes.  */
> -    if (bs->backing) {
> +    if (bdrv_cow_child(bs)) {
>           return 0;
>       }
>       if (bs->drv->bdrv_has_zero_init) {
> @@ -5412,7 +5412,7 @@ bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)

the function is removed, so, this chunk should be dropped or rebased..

>   {
>       BlockDriverInfo bdi;
>   
> -    if (bs->backing) {
> +    if (bdrv_cow_child(bs)) {
>           return false;
>       }
>   
> 


-- 
Best regards,
Vladimir

