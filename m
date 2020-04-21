Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D86C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDBD2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FzRd5t4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDBD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQo6L-0002D2-8i
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQo3u-0000Ze-IS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQo3t-0003Cd-S2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:15:22 -0400
Received: from mail-vi1eur05on2114.outbound.protection.outlook.com
 ([40.107.21.114]:61408 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQo3t-0003AM-EE; Tue, 21 Apr 2020 04:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJGeGZdM6KeKvhJUwURxH0eJ6L/YrsUU0eAdIJAY8SW7B6ZBsGQoSKfDeinH+Mf63EJv791QYF0KkP9tzpnriLbEm8ZX+KVUQDWZsGyCIUso4I6ugwFKdPQyQxT1M7Bg10Ve34yPljAOC3jJEx3OPqXWvZgQqxCyd/PXK0Y93edGw1lBMkwvWEDkjgf8iICy0CziAuqimdP8TRxOsgy81ZBvqb/8hRmWejOBl7/HRXAhtJzdpfcV8RJeR++oFCBXj/6M1XLgMNwM9EqIr6GU2ILSyRiFLV6V+6MGeR/SUjmHDrEnK5j9t1gkZ8CtTe5l7vs9Hsu/G5uZVwkj8MZGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE138tM7UMpeqaYla1fHkAbrNUK3XarQGczwVSo/kb4=;
 b=hGy1kDVxKcrp2kknOU0amLPyX3tre7RWcDDg4yL7ceStHv51RNQeMpE1Qdo2yUakgSLYa1Ivx19FJylQbX3akpCzy7sqxq+qbKaAn4SiHzIZn6qO5a5te86qc7UhVVrH6+GhEFMlJqXd6Bhzs7P2UWcUxx1MUVbHJhPOBBsI3wthE0zfbkTw9ioimuSwwXfPeO8CNB1Oroc+dpNMwp4BC2kuOXRUiRYkfsdXpE8eMNe4i47XYeOJSH4U9blh2QIyk/Xbl5rb5bzNIiajNM7j4WWAgeiF9p9ZoEV2c+N0BNPlZEjS/xTpLyaSmyegHLSEjStEL9/ke+IbZ6zL6wyFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE138tM7UMpeqaYla1fHkAbrNUK3XarQGczwVSo/kb4=;
 b=FzRd5t4SqMdMcQ+uopDD2ZB93ol9n61r0IQ5z3SidKmMRPu10hGcoT731By0v6S1WN5jP/0hymg0gArEX0AmSnkzIrY78qn/3upEdR64hPNRzJX9gGZC56LPiIAOIAfFYmLhUj6LH7aRTt9QeGbO/OriWX9JlQohxWS4GN1W4/8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 08:15:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 08:15:16 +0000
Subject: Re: [PATCH v4 1/9] block: Add flags to BlockDriver.bdrv_co_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-2-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421111514272
Message-ID: <b4f753d8-2d0a-e62b-d047-ae4ba20310f6@virtuozzo.com>
Date: Tue, 21 Apr 2020 11:15:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29 via Frontend Transport; Tue, 21 Apr 2020 08:15:15 +0000
X-Tagtoolbar-Keys: D20200421111514272
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1baa5f6-62c5-4bee-08c8-08d7e5cc1f67
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5368EEEFD82EEBE2478580D2C1D50@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39840400004)(66476007)(66556008)(16576012)(86362001)(36756003)(4326008)(5660300002)(316002)(31686004)(8676002)(8936002)(6486002)(81156014)(956004)(31696002)(478600001)(16526019)(52116002)(66946007)(2616005)(2906002)(26005)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5YViT1K4zdXjW3LWf6j+IWrc99zQSTYtrhK8/q6c9cFtRQ/O1c7bu1fU9TCdELCo/SoIAa3nuSd5t/kCUWNl6y1lLUnY4wFY6g/8LPjwxk6wUWETBpO226vcUGXVhURTapProEFPzR+V8+BeE9hhrn3VVoWZo+NFQs5OS23iQxvn3uFPx3gbZITjtgJOOgWhIPJf0lHPYYgU28URFJS4LEg2R5Tk0Qrd2yqTWNHH3r2Rs7Wu/kpI8scR+JflF4ofNWPqoqXF+FA+iBX/M0K1Muw8JG7G4/+3oF8mvNpGwFxuTyvSvzBZVMATCHXbIer4m+tuFL6c+TBO/NM9xcgMeHacglm7e6PRUETc/WXx/ICE9y7QWTKWRGWrZdmA9gy+uYjDFPNp8ewTdsL3a+RTHbFxb79s72pU7o1trhXXCTocP2J0E+0+I3tXDJ3uB5v
X-MS-Exchange-AntiSpam-MessageData: 7LBcgm/yoH6E3LbgCIIxxz5s1xtmFtj+5/3VwH8suY9x9kki9/TaPZOLraWB8qgEjXUV7+aRozoDayxoiRbpOuyTyh79XYdMb/pXvtnO91FOdVppFxwY+NMCzulH3vFeh23Z/eLnzW8yKuBIk1pPUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1baa5f6-62c5-4bee-08c8-08d7e5cc1f67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:15:16.0125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81YvGlXAhDPqTW6FwN1/SDPeu3UFp499BwEU/z/VqSs57SG8Z5k+lXbjfuge9K66fouahJdXhPxGVjtEOY3nYH2e6ipP0Toc14b+xtnEJTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.21.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:15:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.114
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
> This adds a new BdrvRequestFlags parameter to the .bdrv_co_truncate()
> driver callbacks, and a supported_truncate_flags field in
> BlockDriverState that allows drivers to advertise support for request
> flags in the context of truncate.
> 
> For now, we always pass 0 and no drivers declare support for any flag.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> ---

[..]

> --- a/block/io.c
> +++ b/block/io.c
> @@ -3344,6 +3344,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>       BlockDriverState *bs = child->bs;
>       BlockDriver *drv = bs->drv;
>       BdrvTrackedRequest req;
> +    BdrvRequestFlags flags = 0;
>       int64_t old_size, new_bytes;
>       int ret;
>   
> @@ -3394,7 +3395,12 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>       }
>   
>       if (drv->bdrv_co_truncate) {
> -        ret = drv->bdrv_co_truncate(bs, offset, exact, prealloc, errp);
> +        if (flags & ~bs->supported_truncate_flags) {
> +            error_setg(errp, "Block driver does not support requested flags");
> +            ret = -ENOTSUP;
> +            goto out;
> +        }
> +        ret = drv->bdrv_co_truncate(bs, offset, exact, prealloc, flags, errp);
>       } else if (bs->file && drv->is_filter) {
>           ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);

Hmm, I think it's incorrect to silently omit flags here.. But in current patch flags are always 0, and you update this place in the following patch. OK

With updated block/file-win32.c:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

