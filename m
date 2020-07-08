Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366BC206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sl6ZpUOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366BC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDoM-0006dC-NF
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDnU-0005oF-Rj; Wed, 08 Jul 2020 13:23:52 -0400
Received: from mail-db8eur05on2135.outbound.protection.outlook.com
 ([40.107.20.135]:63841 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDnT-0004rn-7d; Wed, 08 Jul 2020 13:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6kB8OzsfrimW/w+ZW5h6dVM6jsn/94fq5wM2T5hecgEDDv71fVM9CKv1/w+yZVKPI1AJA3C06j0U46BoWlWMa7iWg7BXQJW7zeA1MEaKc6bfai0OIrGadz+CrQRIVM+kVgohIVbprahD/2lF9D7cLNRWcnrAD2xZkkUPPXtT6j2T2gfI0XXZ8V/Za2Pr58eJIQQL8tpAEXll4gVOC8elsSuRWOCi0Hc7Zbmk+grCODz2Om8saoB7BFxsLk9rgbcrq3GiIgKwmUL4dvgsldIgollVlcOZ3Berlg9ufp9f3wLrJ6sWwMKQUw42ISjrPuB+f3FIjY3YmV6uKwqFlkN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZjQhVg52aqLh/n1eTFDITJjMZACXba8xEQMyTLsc3Q=;
 b=VCRkA+QoO2W23lbRrUfvjUHnw2HA4zGTUQgIZY2Q2McibGhdU42rsvSxw5oHvEYCBL8kJy0YqG/zfF3mExFDbPdCtK1WBHvQV/ScKDfe60qEQKzorAVHnm4iMerHKXxhkUxCR8BmslZnRLSV4kW6FEYTl0m+a/Pb3L3/cBsWddBjWM6DJy/ngIotoF53Mbv/VhzooP/drivqTcQW1qIPOuyvIIwBJZGjoeS09PQWY3zgYrwf8tT6nAIWfcTiMb7u/M9LvR2Xwj6GinGIX/DiiTQGo6mYUGt5kFA3sGSoErHdlDQvw4+X0qmSHYseFs9Wf25xiRZqdBFtNcD/CaAU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZjQhVg52aqLh/n1eTFDITJjMZACXba8xEQMyTLsc3Q=;
 b=sl6ZpUOndin9fEg1E8ylzNlqWpnW6JzB0JOlIb0PjfxE3L6/Dl1IobnGii/9ckEBeoKuDzFE7JCYE6VZ+lqhYQ3FweMd6Qx4Z5Di+TZY1S4zld3u2pO5UVFCP8gIa3za2ExxVUVZDXavFm/xutyRy36WsVtlk7SJ2YvoKOA+Ln4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:23:48 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:23:48 +0000
Subject: Re: [PATCH v7 03/47] block: bdrv_cow_child() for bdrv_has_zero_init()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-4-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <41d3931d-2dd1-05ae-e23e-1db71c652384@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:23:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::37) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 17:23:47 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5026d98c-b53b-4fda-423a-08d82363ad11
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29842274DC5ECDDF64E12C59F4670@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+Bw8mBC9izTPjDtxPCPIiHGHURcxzBMAKxa/13/ONRTq80vIQSIfT4/V9yQV0usjiHR9w69dfmYFJcBstjN6kgwPum5ahNgbcyVT/11YaIvW1K0xk7n5gWJWJWZQ6R4zfhjzy4rEbGB035QnvjH2/NqbNIcJlIagiY1UQZjdC9ElO1nXcKgRnpFBZc3KmqKAREm4CYkOX9va+ioD6J4c+sVfV8mmajzdeyNy2m16bxso+/cJ0BXgSNkmzy/GuDStazEyW8tJSTvyrCp8rGszEQQULouH+4Gt3OxhGykA1sJrPywZjVfz15R1CYGvHv0Jefh3MyaZgQ/BVkFaYJclCiLeEG9BCT4sWAHjNw5Sptvoc7Mh8l0W1wppnHGYZgo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39840400004)(8676002)(16526019)(956004)(316002)(6512007)(2616005)(8936002)(54906003)(26005)(186003)(44832011)(31686004)(2906002)(53546011)(478600001)(4326008)(5660300002)(66556008)(52116002)(6486002)(83380400001)(86362001)(66476007)(66946007)(6506007)(4744005)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AGzqTyep2jfFWdwUGiLWESHWZTbWo16KCALv26U1FEbhTby2zQTxjDe91/SdKPdXXaN5DFbrV3jR3RktM9hY5QFyy2yKdywQKRnQRQ+2jFMWAiCHb9yjdPnteqEueeAHuzPf0b5OEEvm/zXZfW3tNk08fs1R5ODr1/8N2f03vP3So6NPzty3CnrQsJ1nGisKZhPNVYyhFcLg0DnJ+4riQYRvzzv4jpovcdfKf0mqnasHT5Qp5tQz+5P4DNDsD/Lw2cXz3MwV3XxqQs7NR3CkgrP2beu69Zgjz/6oi2K5EdverZvrTL06WyyQ6Ds8UaUGYOa81EZd+DbUkwAwiB4i0KPV+eY+PZja/kBTZiAHU+uMkwYGkD7gLgcCNebcomzOYUyW4+jOfaJ4iioUeTktFrpikGOqV+MBvkDWTilF4wG5k81eox84L0z91Hat0Myz0AduCDZSf4DvuW7GYDfQ3oDKwL1MXMSV8KUS8Ks2gJE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5026d98c-b53b-4fda-423a-08d82363ad11
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:23:48.6618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAdvjhnV5t93Sg0OGUj2UMD+tPNv/jUrNfgvRazoWVD+gRnSRBJyvouBRmyGiCLqbFGwXDSPI4VM2X4+YN4k51gvL+VIczjR/122N96y+T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.20.135;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:23:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 25.06.2020 18:21, Max Reitz wrote:
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
>   {
>       BlockDriverInfo bdi;
>   
> -    if (bs->backing) {
> +    if (bdrv_cow_child(bs)) {
>           return false;
>       }
>   
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

