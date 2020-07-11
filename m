Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E5DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD3120748
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uh2S9QVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juCOO-0007N8-Fn
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juCNg-0006oV-45; Sat, 11 Jul 2020 06:05:16 -0400
Received: from mail-eopbgr130108.outbound.protection.outlook.com
 ([40.107.13.108]:16499 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juCNc-0007VK-8D; Sat, 11 Jul 2020 06:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdNyX40RVV/gRiAGYXAR1yHz0HiUU8L5JJfNBXrLCO6q4vLZ+VkZr7hxjpMwKtdR3idfoT6pqV7HuffGOEehYIYspCSRGBVhMpcYv9I1706Csolo5QGOpgI6GWbM3e2HsVzwYqLlu2ubyihd7UCpWcGf17hwdEiZA1FlrQgxARIhPMxwpVYcuulgUHxafjN9nRsHcOT9YzMaRgiT01tJwq2UrLZTPK/tjmjyXFSyUdaU9hM8hU/TMVZjEjw/d20+Kdw+Wn0+aKBlg9/LFp5aFK+GpsVbL9I/ud5aGLzqQIH2LY0S1VzG9DbIELH4dHOKMguN2QqWTp4AJF4e7LI0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xrerJi4o/Ql+SjuINHkuIKGIH7QQXq4TX8qe2eL1SY=;
 b=AkWUQ3dWH5dz+QDFzo/tuEL7T6o4l7kpmV7GEobGpldmQLnt6uo7xkYf8U9ajKy2wIEbyd54M0oskpPlOzAVsMToKLQ7hS6RmtwzZihyzuMC/X5vNu6zRxXaEfBjGaTyMZS0LYul6hm6yV1MfhjLBEAiUWoBNIpb/hbubGQg7oYY5jjhMZqo5+chFZmnYpj71r65ABK0gvZxWUKvmckCk1P6N5YjKfND7uPcKBGGH+0gp3E0FX1ivXU6k1+CvN7TxOo/qyxue84fD+ZNd+NCPJyu4Za31eacYelCDR/7zwEo9FuFkoUgCfbZNJR4zxLUT4OVkv4kMHFUN9oV2Soi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xrerJi4o/Ql+SjuINHkuIKGIH7QQXq4TX8qe2eL1SY=;
 b=Uh2S9QViDaoq80/LWzg4UfGOvFn7agB7J/2Dtjr53CHwDb9KdHgyGq/l7csO4zxb/LpVmpt7fAwL2hLJJ4GYzK7373eHPUYjG4Nd+F+RZmx6BwelBh9ZEtVR3RVRYyUgWKPOtjCY9Ve3ErRx3ILtvhfi3QSaLmKLQ3eky/cn26A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3542.eurprd08.prod.outlook.com (2603:10a6:20b:4b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Sat, 11 Jul
 2020 10:05:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 10:05:07 +0000
Subject: Re: [PATCH 1/2] block/block-backend: add converter from
 BlockAcctStats to BlockBackend
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200710172711.8059-1-den@openvz.org>
 <20200710172711.8059-2-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b9fb8507-bafd-5e60-accf-c3d01c2c611a@virtuozzo.com>
Date: Sat, 11 Jul 2020 13:05:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200710172711.8059-2-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR01CA0125.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Sat, 11 Jul 2020 10:05:06 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d8f600-1478-429d-4906-08d82581e3a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB354292F88B549A1D2BC0DE51C1620@AM6PR08MB3542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFxxx/lcRs/M8yN6y0Rg47fdQ60i+q34r0BqztS6hyemIuBqUO6DmFlyulqdSmInsheI2dPuJeWsN8+AZzKY0YfHKDMWENDWMT3qKUiefGTmLkYizxupFxFONlCdfbXJTAtQFi7GYTAFH8t8GIi4587WDlVXclLvWXj3Z9ZwRBe6BEMdglIeTjidHje9AvOO8jwj1UpqE2+b0a2Hz1hh1YYEGZHKzGGcZe/By4vmApYhIMOVv+W4AeBP9zAAVM0IZuTLDoG6vsyQLkiJkxz/zR2lnvRV5MvOZ4UQovhrsPoL2Q5BZlnL+696g7uSMEkuBoF2e+xVphd9INKabIrI8jVslVy0uKl9QTbArgIdBnDdsoPKwCKzdFFNApDnIiEj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(136003)(396003)(16526019)(956004)(2616005)(66556008)(66476007)(186003)(5660300002)(4326008)(54906003)(52116002)(2906002)(83380400001)(66946007)(26005)(6486002)(8936002)(8676002)(16576012)(316002)(86362001)(36756003)(31686004)(31696002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: adF3oQiZsi8UJp+q6lTdQSRZvcsPosJThLa0uM2RpUhRZt7671VM7IyREx7BC8tg1BBhR0sdVch/TLy/M4o/JohVZnAi3A6Tkk0hl+mD+SW7noBP5BTjl6AipsOPCLMm5n3aOIt59+6kNPQ0cAT0WmbWwkHU7xOkchzDqLl0R1COEdftvmJ1ojM0sg8OsVDQl9vJQowe9GZfO3xIDD6jhyKflebzMt0VwwaMdbxH7x+aop0jeiikNlCNS22onebTMIm/FiVxXxkfQfMteLBD4FSOIdcsGxIll8OFSZVcuVOv9/itZSHKaQLAiZ9buDCBsAG2/nAf377lYlGF0r62Et7d/6nVBnaZ8+xGqmgkmwTATp+Y8KugVJcyBkk/WRyMAZ4JSZeVf9d0SE3L4paptxzVt+sHwHgUVlo1V/Ywn9zwqbwszMVU51FSZlpZtqUjZPgvlrCXs8e4U3SGuXSSzfElyFoWIS5LSrKHKT341UHqwk1TJK97n9Ad+rE+GWrF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d8f600-1478-429d-4906-08d82581e3a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 10:05:07.5212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmW5X33jJyV3JbRIvC5asg36MTLGcfen6wuWb3K9FguLjgb9cY/mukRgfYvwNS9TiHAxaoblnKUxfbOcR8ZL8SOpK0/ND7ycUQnKdQFqSOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3542
Received-SPF: pass client-ip=40.107.13.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 06:05:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.07.2020 20:27, Denis V. Lunev wrote:
> Right now BlockAcctStats is always reside on BlockBackend. This structure
> is not used in any other place. Thus we are able to create a converter
> from one pointer to another.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>   block/block-backend.c          | 5 +++++
>   include/sysemu/block-backend.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 6936b25c83..e77a7e468e 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2143,6 +2143,11 @@ BlockAcctStats *blk_get_stats(BlockBackend *blk)
>       return &blk->stats;
>   }
>   
> +BlockBackend *blk_stats2blk(BlockAcctStats *s)
> +{
> +    return container_of(s, BlockBackend, stats);
> +}
> +
>   void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
>                     BlockCompletionFunc *cb, void *opaque)
>   {
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index 8203d7f6f9..bd4694e7bc 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -227,6 +227,7 @@ void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify);
>   void blk_io_plug(BlockBackend *blk);
>   void blk_io_unplug(BlockBackend *blk);
>   BlockAcctStats *blk_get_stats(BlockBackend *blk);
> +BlockBackend *blk_stats2blk(BlockAcctStats *stats);
>   BlockBackendRootState *blk_get_root_state(BlockBackend *blk);
>   void blk_update_root_state(BlockBackend *blk);
>   bool blk_get_detect_zeroes_from_root_state(BlockBackend *blk);
> 

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

