Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63654C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2C52065F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bf7qsPrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2C52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvosY-0007sy-CK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 17:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvora-0007Mx-2p; Wed, 15 Jul 2020 17:22:50 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com
 ([40.107.8.99]:40963 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvorW-0000bD-W9; Wed, 15 Jul 2020 17:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrf7w0YQPcy/5CNPrL5vsiyQkRxIuohj9KXvqRrdjQJXTmKOgbccfKD1Yy8BOBAhM5sJr3jvNhi1fWYDXSjJ0V4nWP/0vCX+0UCp3qYopPwIs54ghtMJe02XeaxWiVknHR2IjP3etmCvzO6mFrXwHFGwkDg0CmOF38CazJlXYvFCmFuaSNCLedJ5GPple8plGsORrtFB7KMyLbPFZ2MPpPtmPDajKcPqx3+MliRBIpT5q4H9rfzjIylBdxiAUo7X2KZ75F5ZW+BcKUHexXBHtr4WDdlTNdYjv7JeYEeRTmHV4/wySWfuF/d3tgJIIieSFecV6c3EG9mtgO1A7l6RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWR8gGIvUDJFM5l7rrMpSa83lOvpX8R6kEsQPVMNfQQ=;
 b=fJxU6FSzqh+c488RQyQ7heDeqhZgCtvanoTNAyTyedLINczGdo4w7BPC9j+NWXmSb55W983gwR9roU7wYBGVoDiwPUgy9P4jZX+wznGntY2FXVs8HlZML0Nvjn9NdqxJILpCrXI66M/yW0ZzxhW4O0rzfT34IFlVSmktIk+M+pYZyJrZ9KVdTEbf4BAPSGuCrMxSjfnYslaCAIdYh9oWDOQCHVvDlF0Fmp1ky5wx8D5m2oRk+7PbRZO0K5V8tNJmwvhFIPAVN1voJ/9lBcZIj8PsxE1VlHRGjxp4uAQKlgeA2Zvifr4wQK9JcYzQskoTy7RX9eDki/N25uOrBaK3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWR8gGIvUDJFM5l7rrMpSa83lOvpX8R6kEsQPVMNfQQ=;
 b=Bf7qsPrJhxEWYbTDg7oMkQGwUnkZrWQ0zVPdm3lM6DfgQ8q1aMBdrFQfezKHpk5UqCDIFTqNjdZebiSuipwb/q3WIYR9qETNtIDawG8Iu4CDObismyDru8uNRwRlm1k/xzLI+QdIXYcyJinrszkySzyAEXsHoSrlqLFOr22ZKv0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4471.eurprd08.prod.outlook.com (2603:10a6:20b:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 21:22:42 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 21:22:42 +0000
Subject: Re: [PATCH v7 23/47] block/snapshot: Fix fallback
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-24-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <4b87c07c-f907-129e-3019-5aec59ec476f@virtuozzo.com>
Date: Thu, 16 Jul 2020 00:22:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-24-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0127.eurprd07.prod.outlook.com
 (2603:10a6:207:8::13) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR07CA0127.eurprd07.prod.outlook.com (2603:10a6:207:8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.16 via Frontend Transport; Wed, 15 Jul 2020 21:22:40 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563cf135-9bfb-4956-5617-08d829053540
X-MS-TrafficTypeDiagnostic: AM6PR08MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB447148FF577968FD65F92E7CF47E0@AM6PR08MB4471.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU2wCv/n6l9MdxRhH7mDiMU+tWB4ZXpVzPOCn+RP44kyPfWX3bSVZcYfvYdRfjFdubVUlHQ0wUJXVa38MhbmqohsFlnaw2RN2A+5eulSChX1Uy3McJgasT/jD5f4e2Oj1S+2S7q1iQQ8cc7T1t0q2GndJTGVqgB4pg6NjbrqaxN9TU6GsIiIMwDOWIN72GRk6kCVm7ffJT2ePX2/tVVI99wjmoikWwUTdwHCpJTIK+e/KkrTYet7hSmDZryUc8UPXdN+PrPGIOQ2uJ6s9ai4tsEIFxyLy5jML4pT7+WFIkoE/8ENVa5P6I/Sm8JKxCd0lMVvFjD6tDKNF6svwwWS8CXs3L0PHsYRNzGgUnITEfl4TQKU5ZYoAzTBQ0WUH0gD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(478600001)(956004)(2616005)(44832011)(31686004)(2906002)(52116002)(8936002)(8676002)(54906003)(316002)(36756003)(53546011)(6512007)(6486002)(31696002)(86362001)(26005)(4326008)(186003)(5660300002)(16526019)(6666004)(66946007)(66556008)(66476007)(6506007)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gNAfprkA2O1tSurwifGj/3pBMmOQHjBzMjN5MyzCiiIsiYLP12sOUp0qPxePOtHgNwrCiqfFrigs3fnOOHuUSIVp22qBlMGlIuyy4sdcRi6bJY/XGVAqjDDYIZet83soUNiPZv82Ir3DliTuAFUtlDj13Q5wd1sdUQfyBbQfIoCBt5EgkvWyDxTfw/DpWci/goQAmTzinO435UP+Y+t7qAOaV5rUA8mgBIQfU0VUifu/EL2ncKL5qNRNi/8sNQmia7JjP+Npn8i5p+GU9Ixax0r4Y0nws+imcHOqAkjXbt1xrM1KhtVZvkGyWbt/1afobXHBPjI2KLLAB0H8DBwhD86J4uDwxqNcXlOvKuDRBTsPznxzQMvmai+iLYcz4zwhJfRI1XFQWc6qIQj9FEuZalY3u/4OP1/bbA4H2QI+EKa0Cm/cIbevdzg/2eh2Hd3Wsk+5aBX9P2mgzOt3OJ+NqYkCyZAe+8JKt66rvRGBYr6GVp3SnSpxCKc5VwfeKVGw
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563cf135-9bfb-4956-5617-08d829053540
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 21:22:42.1657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4I7p47TH7m9mrqXtM3zpU7xFAo292NwNPnAXPHVhl+1NF/H86q+NJgenfyxmpRp+S745dUcuPUc6dqowWrXdhyE4YI4bkAlFq7PTBaQGfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4471
Received-SPF: pass client-ip=40.107.8.99;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 17:22:43
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> If the top node's driver does not provide snapshot functionality and we
> want to fall back to a node down the chain, we need to snapshot all
> non-COW children.  For simplicity's sake, just do not fall back if there

I guess it comes to COW children like BDRV_CHILD_DATA | 
BDRV_CHILD_METADATA  rather than non-COW ones, does it?

Andrey


> is more than one such child.  Furthermore, we really only can fall back
> to bs->file and bs->backing, because bdrv_snapshot_goto() has to modify
> the child link (notably, set it to NULL).
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/snapshot.c | 104 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 83 insertions(+), 21 deletions(-)
>
> diff --git a/block/snapshot.c b/block/snapshot.c
...
> +    /*
> +     * Check that there are no other children that would need to be
> +     * snapshotted.  If there are, it is not safe to fall back to
> +     * *fallback.
> +     */
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> +                           BDRV_CHILD_FILTERED) &&
> +            child != *fallback)
> +        {
> +            return NULL;
> +        }
> +    }
> +
> +    return fallback;
> +}

...

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


