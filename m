Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD4C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7224E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wcGIYjaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7224E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoZf-0000Gl-K5
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoYu-00081K-Bm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoYt-0007yt-8W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:47:23 -0400
Received: from mail-eopbgr20103.outbound.protection.outlook.com
 ([40.107.2.103]:36430 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQoYs-0007xT-Gy; Tue, 21 Apr 2020 04:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOr9Otr0xynzmTLpLRMXqNWwEfXASm0++8vL08puqpUb1S+dyBgqtrb4lMkDLy4EsMT9XXR5cpqGqOvEwDgWHtzNZ6EZK9MVP8jwcUIKSQop/NX0PEjFpsYdaSauWkEKhLhYpMikxtszg+CG1rzyQi5I8S7D/PVh05Y0cU8TCM2yjuSRSq53+WYcc00D0Iy2+dHXaQlNsMZ0Nsd6QcTDGEoup/Caf/fu3k5ThAvYDue92zLFxFNoUVDOI8L7V/87IdbX0ZFRzpyzQDqjsoWu4+aXJTZk+0gW+WsRohtb9dIgzDtbI3L17hP+lSIYB6NgUnDbnINzrHrZfja7JYvKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xdhib2ES5jPrg8yA1EcJq2RR3UFtSCXPVf/iSGur5I=;
 b=e98LLCfLfUbh/h3KgLamxuIF/259CL9wOfWuJdqwdpEStwrpuLFiDbC8uO/70cvddehIXdcTqOwnd214wiclrsIf1KlMnw+Mrm32if7xLKf7BgXmQFEm0VqDchZRmUxpu3ZLowvNVIVQz046zlivRhW71f4dhKywgnrCpZ/ed6Sh6H02IHh38mqPctqglDbCJ5Iu+ispecpqeoNHQSQmOnpDmNaCK75qXP70VtWJ57EJRifm2h3LZRuXZv5imtYDLk524bXZBW2XAkXyxt3tF/ByKA+pSfu3EEC29SAhWs2XZs3UIp+CYd/lgkGMXeha5vLli0NBcxXIAkxz/4wGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xdhib2ES5jPrg8yA1EcJq2RR3UFtSCXPVf/iSGur5I=;
 b=wcGIYjaFvMT4KJJGB6SZgFvqfJ7mb7QGPbtQAAbMxgCb3KrwldbC2c4D2Lcy/vBUy61oLhDZlTHX83cuHAqltwprHzcf9SaBxhH8xmkJRAAw0OKclSDsV1HDGIs4c+e446k3yM2iDueUSulah03/kr2cX5QScuFkzfKyrJU+82w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 08:47:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 08:47:19 +0000
Subject: Re: [PATCH v4 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-5-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421114717260
Message-ID: <59085a98-338c-fb6c-db2b-0636a03d3190@virtuozzo.com>
Date: Tue, 21 Apr 2020 11:47:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR01CA0137.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Tue, 21 Apr 2020 08:47:18 +0000
X-Tagtoolbar-Keys: D20200421114717260
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e70409e6-00bb-469a-e00d-08d7e5d0998e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381AD63879E9FD4E5ED68A5C1D50@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39840400004)(376002)(366004)(136003)(346002)(52116002)(186003)(8936002)(316002)(86362001)(26005)(16526019)(6486002)(2616005)(36756003)(16576012)(956004)(2906002)(4326008)(478600001)(5660300002)(31696002)(66476007)(66556008)(8676002)(66946007)(81156014)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq0oEy8BETNn6odN6olvWFg7GSMjGb1uXnudijXiFlIk2ObWdevBgJb9X9VyemY4sAojjVvDOxS0gJFH7/sELW+6gxxf4Dj+fo4tIHbPNiqfUYYAM/R96Lhl2lFBMawWVcj5Aovi8CjCG+GHI3vpJTSPpMkOI3anMeG7R/y94YpYmyMyqUQLtIt+UMkvlb6V8N1D/c0tQYxXDpPdwdPYrJc/322ugMkSn1VHhv6eZ56Osde8NdjFXY8jQ17jKRLYppuAhMgnev55KEHYSy0kBG0veFrNpfJAvJa95zlVTz7AUClwbQ7sEG3uZIFFo1IqB3rVNG6RGKQCbrGhhbdg7CifEV20gWCXD0G67GEQUgBj2joThCBfN13x0TbfYNPjr+gIkt1HCREWm50F6V7a88yypDE+E9/0cfT3lCNrdnwJ2e2q1ABkBoK8Of6Fg8/m
X-MS-Exchange-AntiSpam-MessageData: DDTWuM+L1rH7ButN7frdSz5Y1tbeMFhaezh6WOc3Kcac72igh1KqnZEsOYWaipW4JRIjeo8I17sAIWcr5n6s+nxT3PN6jtZ5lvsuMbuGPElipzqG9mhLNRgcC8Q6LobSrzuQh9MSYt9nfgwDEbzMGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70409e6-00bb-469a-e00d-08d7e5d0998e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:47:18.9754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTAQVPRcEwrpGCFgAM3TGmcDJmOZDV/S8vygpRAO3XPoPCHveXNLNMljiPr1gCrIMFnLvJImIaaEFHRSDAH7wdMy82l7HtDInT5EHl9+ZL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.2.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:47:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.2.103
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6c6d6101ce..7a70c1c090 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>   
>       bs->supported_zero_flags = header.version >= 3 ?
>                                  BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK : 0;
> +    bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
>   
>       /* Repair image if dirty */
>       if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
> @@ -4213,6 +4214,14 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>           g_assert_not_reached();
>       }
>   
> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> +        ret = qcow2_cluster_zeroize(bs, old_length, offset - old_length, 0);

Hmm. As I understand, qcow2_cluster_zeroize is unprepared to cluster-unaligned offset/size. I think we should handle it somehow.

> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to zero out the new area");
> +            goto fail;
> +        }
> +    }
> +
>       if (prealloc != PREALLOC_MODE_OFF) {
>           /* Flush metadata before actually changing the image size */
>           ret = qcow2_write_caches(bs);
> 


-- 
Best regards,
Vladimir

