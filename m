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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB26CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8842D20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vpCGy2Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8842D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvgux-0001SK-MU
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvgtW-0008Ox-Fg; Wed, 15 Jul 2020 08:52:18 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:52740 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvgtT-0000ih-Ft; Wed, 15 Jul 2020 08:52:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx0LxhMoi9Ip7rxYwjwnO7IAaHg5uU44U2G0BWXQO98RNxzwZ/DD+9TRhiV8tEWYehhOz9jHgsjzAugC+300SWkf6XvoPxLWzqaOJ/T/HIUXAuhO1GEAZ2tL8hIxmmuZOKnoq8DZaueqvZeiHiII94LfVxsD0kFySqzRsqlh6c32Xhdyan5RXcKPRoL5y1MOCHmvrRaWqY0XlqiDqQAZpD2RHPc0NHiP1eWIPn7CwZJysfmIdYPTmO+psAcWGHPSNvJ3Ut0rn9PG22sAWxXjMeT+wBMx2gvVi5wfBQpmWVzbnHHlj5372suf3PFcPJGFkBYK+8jqxJFxaAuHv5BZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/yYjf7gIWvIzLCoEBrqzB0ViN4GPmaqdokQdMEAmyA=;
 b=IS5K5jP4CAw3XlFKDVF7tluqYwq03hQ7+J8bM5shWwpBo1J4PEiefKZQ+BmZbHoHfKSKlqQt0xP6gWY8OCI3btQviZmIgFgnCLNmXaXnTaFiiBkTZAS6s/6lLE8iKrVNvUV0zV0+Cf8Twg5z4BpzioOHuflPCzm06o2G75ERNCPxCFboRKgq8dg9Sle0ZClu9M+llUONYiPFKETuVV4lv2gt+8NT4mo+OuaIzTt6+f+3d7UcXnlTT2xXh+RDCz7wEjaU0LzUHg6JOezWbsvrlLZyuR133zadc09qc1PDN34gGknGWNVj6mxjneHXTOrLFUtgUvULxskkn/szpvrJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/yYjf7gIWvIzLCoEBrqzB0ViN4GPmaqdokQdMEAmyA=;
 b=vpCGy2Xg1ghsK84993473S7R4H5zxFKHgr+w0ghMwgU8IFb9Bn/aa54fezpj43AOVEK+EGwRrU35SldnmptwnA3qAStzpzceM1RgjQAEuFKNhV9s9+XgYa2ENaU1YWKH4LIGBGFY6Jct3sRxwlqYuBBztZ3L7+ERscudBdE/XlY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4278.eurprd08.prod.outlook.com (2603:10a6:20b:71::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 12:52:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 12:52:12 +0000
Subject: Re: [PATCH v7 21/47] block: Use CAFs in bdrv_refresh_filename()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-22-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <71aca7a2-ebb0-92f3-c943-6a876cf9f57c@virtuozzo.com>
Date: Wed, 15 Jul 2020 15:52:08 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-22-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 12:52:10 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3420008e-69e1-406b-614c-08d828bde43d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4278FF4FA7BAFDDD685FD876F47E0@AM6PR08MB4278.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTX1sT3K+WlOY4GbjkdVSY2FF3D8cwn0oSPZTygSwDrHa3zEbHj/XW6HVFwSwrgArOlnizdf8JA8yrrlS9/lNiZQJy3PXCB3k8WPWRyFCKQ2+GQDF/i7llX4hq8eJaosIJN/XU/YYIwtduXa4CQOl/yRXMn03Jombm/y7G34DI0MIUulWtKF6YNSy0umtc3kGzFJgUJvdmnf649bq/hPjnkRav2BUHwimYzdL52Ejbn6LLjW3vtxXmmTTZYyQAXs8d4AxukQMMOpTgxJ5kZHHIUrlvrKxvCYGARPy12g7jtgH8LyMHPBK6DAwnKGdcvbF0YQQvLBypIz0HJZs6eebM85FQhJZ1mOXI9fKf+ckzBPNlt5tuJU9JzHerRXfH32
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(316002)(54906003)(2616005)(8936002)(6512007)(956004)(186003)(66556008)(2906002)(16526019)(66476007)(44832011)(52116002)(26005)(66946007)(6486002)(83380400001)(31686004)(36756003)(53546011)(8676002)(5660300002)(478600001)(86362001)(31696002)(4326008)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: U5RAkvnfnpXofwHgh9g/oqnxiENnrVAndAunA7qZNaQH7CSnLp2eidu2i7KT55IEUIHWXPmtddltdfipE1w5ugGmET2CS8dngLu4slh8Tgk9Frdmjz7+IFvad2ZGAKgiTTUob533g5jmg35FaF0U6YCcAT6naANiJU+ru6T2NE5jDeGezYBU5nPJfnV/v98h8DnflEmXSubq+LH8UbmLDJKATOvGpKPgewQ6pSOOFgB6mKpT+JJA/5Fm5QxOPpHVzEIX+lR9hDdqes415qVg/TAhKCNPvZpU8nG1B4+NneBN4htQUxefG8QRJzKCimUMxkrNzG/A1yJuKoWAiuYG7y3ob4iOfzeehVznZMUqTUk+d0GzzEGQBRBEezfnCKrVyXQlWWah2L4dMvlzrWzxJdkrO4j62C6s+sfzm/v7Z8/ms4czRFSzC885r1RUAQ+jXJLCLWqWPxEvhcJCFFtINzOSMsNqJyJOwL7SRI10VCgPbizQ86si6ZTM1giGot5S
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420008e-69e1-406b-614c-08d828bde43d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 12:52:11.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8H24ah/3icZWo1iPWHHv4dXupRh36OTxGztg830LSrEdRpPSgyPuOU63S8u4ILkpaZa1fu567IaWV0bD0gGn1BYKorhBIjssp3owYm1gXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4278
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 08:52:12
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
> bdrv_refresh_filename() and the kind of related bdrv_dirname() should
> look to the primary child when they wish to copy the underlying file's
> filename.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/block.c b/block.c
> index 8131d0b5eb..7c827fefa0 100644
> --- a/block.c
> +++ b/block.c
> @@ -6797,6 +6797,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>   {
>       BlockDriver *drv = bs->drv;
>       BdrvChild *child;
> +    BlockDriverState *primary_child_bs;
>       QDict *opts;
>       bool backing_overridden;
>       bool generate_json_filename; /* Whether our default implementation should
> @@ -6866,20 +6867,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>       qobject_unref(bs->full_open_options);
>       bs->full_open_options = opts;
>   
> +    primary_child_bs = bdrv_primary_bs(bs);
> +
>       if (drv->bdrv_refresh_filename) {
>           /* Obsolete information is of no use here, so drop the old file name
>            * information before refreshing it */
>           bs->exact_filename[0] = '\0';
>   
>           drv->bdrv_refresh_filename(bs);
> -    } else if (bs->file) {
> -        /* Try to reconstruct valid information from the underlying file */
> +    } else if (primary_child_bs) {
> +        /*
> +         * Try to reconstruct valid information from the underlying
> +         * file -- this only works for format nodes (filter nodes
> +         * cannot be probed and as such must be selected by the user
> +         * either through an options dict, or through a special
> +         * filename which the filter driver must construct in its
> +         * .bdrv_refresh_filename() implementation).
> +         */


The caller may not be aware of a filter node and intend to refresh the 
name of underlying format node.

In that case, the filter driver should redirect the call to the format node.

What are situations the name of the filter itself should be refreshed in?

If there are any, should we do both actions or choose either?

Andrey


>   
>           bs->exact_filename[0] = '\0';
>   
>           /*
>            * We can use the underlying file's filename if:
>            * - it has a filename,
> +         * - the current BDS is not a filter,


Should we check the function input parameter for being a filter's BS 
here, in this function, and handle the case here or let the filter 
driver function do that or else the caller should check it?

Andrey


>            * - the file is a protocol BDS, and
>            * - opening that file (as this BDS's format) will automatically create
>            *   the BDS tree we have right now, that is:
> @@ -6888,11 +6899,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>            *   - no non-file child of this BDS has been overridden by the user
>            *   Both of these conditions are represented by generate_json_filename.
>            */
> -        if (bs->file->bs->exact_filename[0] &&
> -            bs->file->bs->drv->bdrv_file_open &&
> -            !generate_json_filename)
> +        if (primary_child_bs->exact_filename[0] &&
> +            primary_child_bs->drv->bdrv_file_open &&
> +            !drv->is_filter && !generate_json_filename)
>           {
> -            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
> +            strcpy(bs->exact_filename, primary_child_bs->exact_filename);
>           }
>       }
>   
> @@ -6912,6 +6923,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>   char *bdrv_dirname(BlockDriverState *bs, Error **errp)
>   {
>       BlockDriver *drv = bs->drv;
> +    BlockDriverState *child_bs;
>   
>       if (!drv) {
>           error_setg(errp, "Node '%s' is ejected", bs->node_name);
> @@ -6922,8 +6934,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
>           return drv->bdrv_dirname(bs, errp);
>       }
>   
> -    if (bs->file) {
> -        return bdrv_dirname(bs->file->bs, errp);
> +    child_bs = bdrv_primary_bs(bs);
> +    if (child_bs) {
> +        return bdrv_dirname(child_bs, errp);
>       }
>   
>       bdrv_refresh_filename(bs);

