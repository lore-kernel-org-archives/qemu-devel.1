Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEF52242E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="irZ7Kkb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEF52242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPod-0001CS-Ht
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvPno-0000EK-FW; Tue, 14 Jul 2020 14:37:16 -0400
Received: from mail-vi1eur05on2126.outbound.protection.outlook.com
 ([40.107.21.126]:8160 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvPnm-0007yq-0Z; Tue, 14 Jul 2020 14:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYI2gm2XfTLAiG7+R5pG3+9oYFAA8OTVLXKnFR6+TDMWw2K2rH7487sZ0lD1pQcHXMnxe4//dEX+gqVXt8vRFF6q2+khoRlRIQmzk4J3x9UyZQ0BwVA3yN9hBl1cbHb4k6i4Tyc2OIEBQFIIzhqxSdDHS6TQbIzqRNT9GOk1pDOZsSLGBDBDTAyqUEp94HgqThfkfHEoJ6JNOAx5mp+9sdAz5GKcGUuW8ixZIrd08QkY5x5cGRmw49pPJ3lgGT4RUxTDeoa8igkf34q6MSylcD/krGIH8/DdCmoLTamXGiK2cvlTmGcEl+EuxdzEhEFZxeSLL88wEG7Q+4cOv2Mrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ9TT/sYmFeOAcRwI8xj+vHB5k75C81bQBnzRzBOi1k=;
 b=VshFoo6vtA2AiDmk0g0mEax4wSPLxM7bbkzp+PuV5lt/AJ3rat/5fp835hGMyJRwyAMu2JjlZNR99829mL2zhZb2UjWRsRo+wOOeuHEiEJYw1vT8G5ug6TOP7aBSzgfvIqzIaRWrKaobzgFL5gjxzptfX2Bvy0ruvozhf5V1UPkLj7UuuAbJbDYBLrFZAuFVehdQrL8+DdfyPhUAH8VBHv8Hc7HPLqRUBqmjAxQnkPjlgKI2d95sykRDcYAbpgrcBLEG7CwFTZEQRxNhUOybXFRlcnNcAT2GFusv9F+m61eG/RzWW1RmoBxwL+ghWHvsHx0nOEewtJXL0aBg0SGbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ9TT/sYmFeOAcRwI8xj+vHB5k75C81bQBnzRzBOi1k=;
 b=irZ7Kkb/Vj3ILPdVLYrnw1Bh/kli2+2oHe6VQvTSNimICGtq1+/jYIlRqdRVvu0vnT1FMwkmD08UzCkYDMWNRJ6OWizkd2g7hKuHT9E6VY5LfzmlidHvR9BB5ayHh+fNCP3k6Gopw/7kVGs/ex8a4fzMa30d1fOfcntKdy8hinE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5030.eurprd08.prod.outlook.com (2603:10a6:20b:e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 18:37:09 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 18:37:08 +0000
Subject: Re: [PATCH v7 20/47] block: Iterate over children in refresh_limits
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-21-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9e4dc3da-2c5c-8da5-2d03-c144b9d8b4fd@virtuozzo.com>
Date: Tue, 14 Jul 2020 21:37:05 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-21-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 18:37:07 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4451a69-24c0-4616-ff87-08d82824ea2d
X-MS-TrafficTypeDiagnostic: AM6PR08MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5030775C92F07CC92597AAC7F4610@AM6PR08MB5030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BTPmkMdAAnHRICFpmPyHrZxGh7RArMFk2GfPDDtNfgjcI+ihQmjdEoI2/OQ+9Gxz9PjwDxdgVUyh9UotDMknGhNUspKDsdE4zvxEI2hEuQIiHB+Y2+LuGhcxVr8+1Hg8I/vHNOvJ3xSjsM5ZrgmZAvtghE2J3lGMQEVRFBaETyrfGfZCs3cz2UQodjI42m9FOTHseChAj8LZmcYqGYuX+7H0UCFpLCieSyPifDnkVGlQP7fSLiPlYgkuBvdVIkZ/blJ+IFNfMIwS/UMY6PvmoSCuqRbkv2LIJUy4Mv/Nrkq+42xGhifupnlKMZry2ZYOx0bh3tK7e2Sj7jC6klczoa3bgKq2gCW5o/LLhHD2UuGFuzJDno1BFDH5QGVJ27+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(376002)(346002)(136003)(366004)(44832011)(52116002)(316002)(5660300002)(31696002)(16526019)(86362001)(186003)(2906002)(26005)(53546011)(6512007)(478600001)(66476007)(6506007)(36756003)(66556008)(66946007)(4326008)(956004)(2616005)(6486002)(83380400001)(54906003)(8936002)(31686004)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WkkMyYWmPrU8SFAiaS4D+q2eQuOKpXhT6QIP5U908n3fupV89JpZUik/5OxPRCJSybZXvcHXH6QTM4iVffVYtvut0pzRz7IArFBNyyX4wLlocyTjaIuL0t/461R4agPs/Cu6UWvofuXq9vF1M3P5GDcSQzXzO7vSpiwvMJfzOTlDGPnY25qzjm3s/DhlsdMyf/v2ZOybo9w7unp6a2ij88XF33wcm32NhlVKKCfNdP1/BuCkg5rvtz49gHDwfcfN/QndOCX4rdg+tlj3uleqFXp336NLNW3gQ663rT75xhDG0dYge5wzT6d0bscA2+k9s6w6p/4ltaFDN62zFuO8/29uZv2xH/Ecu9pwIbLlrP/sRnoeHMMQfHF3VGwXmSx7MgckhmAarAp/TJ/GHzO6tvxKo0DmoF52wtu/pJC6Q/ZPBRaw3mKfBhMaQqDnvMwiDIXUKvFXQ6Dkd4R6OFCPU71yh0GsJyV+qFmsqdxOwqdrxnm6qpC+fS5z/nis7rfa
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4451a69-24c0-4616-ff87-08d82824ea2d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 18:37:08.7710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14a3okrX0SBYxDleC7M2re9CTQkGuaxo/BPUW/VcTDhRzNUV45sLKZvg1J9EnlE/4UlDdUF9dz5OA4Qv+8pwcL/NuUmChZLOXjl7wM7V+iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5030
Received-SPF: pass client-ip=40.107.21.126;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 14:37:10
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
> Instead of looking at just bs->file and bs->backing, we should look at
> all children that could end up receiving forwarded requests.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/io.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index c2af7711d6..37057f13e0 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -135,6 +135,8 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
>   void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>   {
>       BlockDriver *drv = bs->drv;
> +    BdrvChild *c;
> +    bool have_limits;
>       Error *local_err = NULL;
>   
>       memset(&bs->bl, 0, sizeof(bs->bl));
> @@ -149,14 +151,21 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>                                   drv->bdrv_co_preadv_part) ? 1 : 512;
>   
>       /* Take some limits from the children as a default */
> -    if (bs->file) {
> -        bdrv_refresh_limits(bs->file->bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +    have_limits = false;
> +    QLIST_FOREACH(c, &bs->children, next) {
> +        if (c->role & (BDRV_CHILD_DATA | BDRV_CHILD_FILTERED | BDRV_CHILD_COW))
> +        {
> +            bdrv_refresh_limits(c->bs, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +            bdrv_merge_limits(&bs->bl, &c->bs->bl);
> +            have_limits = true;
>           }
> -        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
> -    } else {
> +    }
> +
> +    if (!have_limits) {


This conditioned piece of code worked with (bs->file == NULL) only.

Now, it works only if there are neither bs->file, nor bs->backing, nor 
else filtered children.

Is it OK and doesn't break the logic for all cases?

Andrey


>           bs->bl.min_mem_alignment = 512;
>           bs->bl.opt_mem_alignment = qemu_real_host_page_size;
>   
> @@ -164,15 +173,6 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>           bs->bl.max_iov = IOV_MAX;
>       }
>   
> -    if (bs->backing) {
> -        bdrv_refresh_limits(bs->backing->bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
> -    }
> -
>       /* Then let the driver override it */
>       if (drv->bdrv_refresh_limits) {
>           drv->bdrv_refresh_limits(bs, errp);

