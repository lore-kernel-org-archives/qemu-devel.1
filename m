Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC99A21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OJC0N7Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC99A21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGf8y-0007Sy-GI
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGf8G-0006yZ-Nz; Fri, 11 Sep 2020 05:14:12 -0400
Received: from mail-eopbgr60117.outbound.protection.outlook.com
 ([40.107.6.117]:13134 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGf8D-0006pu-GW; Fri, 11 Sep 2020 05:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6ndzkQHa07YUzP34Cm6wEQ2IO9N4PhiYz4fICnYrgwEubI/unqo5zUSTE+PRxgCFZEE/OQouUrXe5/U1a6G8UryaKCXJ5e+a2lkw82ziu4Qr7NwGinXVF18LzVPJ/5xCX9zTMGzUH1SIXQ2ff9o5YClCKZh18Bx9m0IhFyo0Eu/fidRe06WPcFQxEGa/+k1MMVV9KgmITg/VEwoUySDsxGGuopAPty4fmaQ7bUdZ9TeYm3wgzH2nB8p9KvJkzQhUwJwfKxJEaIBW8OYHVVBiQu6K7rLodfnwfkiWO7eQwU8ZTkvXqyR/m8J5vSpOH43znvzQhI/7ij00mMvlK+12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO9X1TGFSGlMlkCgKM8zJ2h5/EnHqkJAMXc+cn0OHAQ=;
 b=DMcbBaV4v2Wo/PPZeOS+UpDmNCbxZh2XK1/EbosCSDvxYia9d58M7JM+vD8Mc7RFBU/ekqNx/TI4c2cE0R3/N8ayF06PkP034P0SqpfR3Wn886TBCK5EeInHk5vb3awdyjdbwgNcGu3wC4LIGGMlTHL4LaumUAho4HINfBdiPl2J4zQ08TSeZXjlUe/slMg0/u3Qr1LlIv15l+vsfl44QPnfg8vW/Y514xPyscC1W60CSWEOG68VDHCZ+2O0jAxkn/lRet0o5CfRcWHARTkr7LLK2kDSh37pD9xGoMriikFnFrx0WllFFLHMnnm0F/4U2wOnRT32TsBgrCDBzbn6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO9X1TGFSGlMlkCgKM8zJ2h5/EnHqkJAMXc+cn0OHAQ=;
 b=OJC0N7UvUv6A9xHnDRJ5ttm2L+zhE+01Z/S5Wx2kUl4hHjFXACsIhyJfQYjs9VbKI6Knyo/Pn1445ZfuZvZP4nBHuSG5/8wo1PL0HraOoKhec3brW59PMU7f20DlfVo0wZURwrBX76IKLhDCtU4V/410nWkqhtHhgxSNEKDNYdg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1651.eurprd08.prod.outlook.com (2603:10a6:203:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 09:14:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 09:14:04 +0000
Subject: Re: [PATCH v3 1/2] qcow2: Report BDRV_BLOCK_ZERO more accurately in
 bdrv_co_block_status()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <cover.1599759873.git.berto@igalia.com>
 <104cbe2dfac940e4c5ca0a7e2eb22a0245e206f7.1599759873.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3c60aece-51a5-c281-ebb1-f384d2ea244e@virtuozzo.com>
Date: Fri, 11 Sep 2020 12:14:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <104cbe2dfac940e4c5ca0a7e2eb22a0245e206f7.1599759873.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0029.eurprd03.prod.outlook.com
 (2603:10a6:208:14::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM0PR03CA0029.eurprd03.prod.outlook.com (2603:10a6:208:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 09:14:03 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274a108b-d3ad-435a-3461-08d856330766
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1651:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1651E38C8DB992AF2DB8A333C1240@AM5PR0801MB1651.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDKwtlE7cdzkTru31IYVDM3QXLIouJPcj4D5HZl1KyE1xvR1Zqin3WZ2SZoSRmpa7gG3eJZTWXFJAYU7QtmlJphBMQHIObF0c3b1nG67zyJZHglXONILrtpVj9O4ASzFRwXKRLYP9kHaZYMasRQn38EENNvvhPUxmGF1SPQAD25fO6ja8lDwbAH3vPV8p9aFU0+pPESGLwQpAoOdPM8D8Zewf3fXeP3/IxvKbWJ8C6Z9erX00cSQ0qBNEdfFZoB0Yku5NnhIUokyRw7IV+JUODWl+ORMRcjpb+7XUA9Pi4ahZWzNNr90n/BnUVmHB2f1C/uNlLzNfB7YE/1AQsJR6Zl+LNBMKDzZqjysOn0fKCILXTiWA6eIfj8UezCnOyXg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(4326008)(2906002)(956004)(83380400001)(2616005)(36756003)(54906003)(5660300002)(31686004)(6486002)(66556008)(86362001)(316002)(16576012)(8936002)(66476007)(66946007)(31696002)(478600001)(52116002)(26005)(16526019)(8676002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8hlT3GtcjLWJ5Pv3CMGXPdMiFU8YANjLlHud644V5F2+IQ+O4z5zfS5iYGzisxTGDxTp+C/gbrfGPnjls6R7hi8IObs+DQeZvu8YLCSrtnZ8WaWaC5p4uyPpb9TDMNA8v/dLVJ8Mq4GyRC7GIRgEjTmdC8NjGXR0HYAZFQtwDOKn1pbEYgU0pWbGDi4101Rj2z1rHKZlDbxOPjSuHG0l+i79btZHhRGWsTmY5Lpm7TUWH7m59CvVocb0bRNTOQ6kKPhIL7Ji2ELaMA62BJ4O/F/ien/UcIFulHakj5MbPy9U4ZTB2rW7b1wlPS9QosenayZ+1B3V0Ay785xRVPAbPDCacpjWLsdgwjoyTvIyUTe6S3fe6lyb35d6unpPB6B9lzh0VeWNUvAKkt8G22UusZLgTVjU6B46lJRXk518doUR1ESjKUv4JzeKXq4/rrOYM+nb5ulTpjkuz3sYWJcpfAWm6+vkwrk6xUzkDr8WvxKggcJiToYuUxU43eEN9cAlTpkTr++9nSHY+foN9onVz+S3X3WOP69wOVEdtNy+UREaKjT1e33ZfrDm7bBr0/O+ZzqucBmGCBx/CQ/78fn//j7tqIjRcf7VpmjnOEhXkmnsLyTvmi0mLjA+8kz9L0bM+dlJsICzhp2niW/MVDi06w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a108b-d3ad-435a-3461-08d856330766
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 09:14:04.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZtgzTGTTuu92sPoa1bqN2K2JIauLLZyAyHWqb6fMNP6yL2XL3TkukUy8zLObMqCcg/JD5lMv8A2hFEG0d9uqBZhLml0qc+jYMWYarf7dQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1651
Received-SPF: pass client-ip=40.107.6.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 05:14:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.09.2020 20:46, Alberto Garcia wrote:
> If a BlockDriverState supports backing files but has none then any
> unallocated area reads back as zeroes.
> 
> bdrv_co_block_status() is only reporting this is if want_zero is true,
> but this is an inexpensive test and there is no reason not to do it in
> all cases.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/io.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index ad3a51ed53..1b0ae29610 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2408,16 +2408,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>   
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |= BDRV_BLOCK_ALLOCATED;
> -    } else if (want_zero && bs->drv->supports_backing) {
> -        if (bs->backing) {
> +    } else if (bs->drv->supports_backing) {
> +        if (!bs->backing) {
> +            ret |= BDRV_BLOCK_ZERO;
> +        } else if (want_zero) {
>               BlockDriverState *bs2 = bs->backing->bs;
>               int64_t size2 = bdrv_getlength(bs2);
>   
>               if (size2 >= 0 && offset >= size2) {
>                   ret |= BDRV_BLOCK_ZERO;
>               }
> -        } else {
> -            ret |= BDRV_BLOCK_ZERO;
>           }
>       }
>   
> 


-- 
Best regards,
Vladimir

