Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318D020700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HDSlOjPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318D020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRre8-00042k-AA
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 02:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRrdP-0003OL-A5
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRrdN-00081k-BU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:16:22 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com
 ([40.107.4.92]:2115 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRrdM-0007bQ-I5; Fri, 24 Apr 2020 02:16:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m44R+/p66TqVWDsNJjnpMDz4zF/EltSDexv9lNEtw16N2EC5rwdESVfMnUlIqW/ppBqnOrB7nfbW1CA7wPD+0i1vFG54Rkh7GExjePuSHtuuZIgn0KIuWyenlqpJK7IUIW+r8fj9nH8zYR3kDpVOSDYuI3PoxhWzvzElYX11ZdbnJmeseKUNMglbDcQY70TbMA83ZKhDCRTeeD99yFaGcXhksPDpWXrTVoJqYM548A1C+zSPqCJ9FIHLDt7TI2cRDz/6FH8AXqLiILRxXgVxX8CSKRIC/2amUEYm91n5hoozj+NWp8P6dufJjqsiBV1TgNLp0EJsVxH+DkViVscfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6bMLtU4MWqmxqGZQuFRiSMpEC0yX7OVNz8UZamP8iE=;
 b=lcWCFMDB1XGK2gVv5F85X30tfi0qjpWESsWu0V59hRhHwAhOBEiq1hL/32i4ombkFCs3Ls9ojdWeOkKiRX2EmfzeDn88Ug+uueeJajYBFPjC6iHgrFPSesI7w89hLj0dHzzZqN0dQAyOPIKwkF20x4vBWS5cGL1gCXKLz/hacjeoQG/zhwLGp9/lgFjmN+nwrA45Oy7SRLKbw0qPfstFDSDuC05BL8gWXkVPxtIyO0egleRrUvR2qbG/EhQAYQ5QdYpV2cxSpm4BOb0+d63Bp9jUufOuM8SdNDlixbspfSUY2ahLb4xR6nCIloAo9D8fP9xrx1YkMojkH9TGa+G3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6bMLtU4MWqmxqGZQuFRiSMpEC0yX7OVNz8UZamP8iE=;
 b=HDSlOjPYfGSEfmM0I0jk5NKqbPYpT09K7CYD7+EjGEePTxwyYzGjCPyeBaTyjtyRMWXJy/JhXwjz+RUY6vb3nWVHjdVRS2CdqbCoA+r1+D0frmpKSUsFfgrxJpNGmHw1I9wKWEfgEgwaK3sv2TzWzFslA+I6uRoH2PcDJez4g8w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5365.eurprd08.prod.outlook.com (2603:10a6:20b:109::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 06:16:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 06:16:13 +0000
Subject: Re: [PATCH v6 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-5-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424091611157
Message-ID: <436f15ce-da79-7016-6478-c5ab8642ee25@virtuozzo.com>
Date: Fri, 24 Apr 2020 09:16:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200423150127.142609-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 06:16:12 +0000
X-Tagtoolbar-Keys: D20200424091611157
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06017a0e-4f6a-4c0a-7ff2-08d7e816fd2d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5365C06EA42BD0BA51A33AA3C1D00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(4326008)(66556008)(6486002)(316002)(16576012)(66946007)(478600001)(5660300002)(66476007)(36756003)(52116002)(26005)(16526019)(2616005)(8676002)(81156014)(956004)(31696002)(186003)(8936002)(31686004)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKyIs+bNsl6NrSZPdBiDQKYcg21leDsBKnY9rYTqAFa3YxgHu96QGoWVSRrRFDw+pD0zLD69z9cmBzRIYu9ojnDU4eCWfk5JTjWJ1zwFQCBp2W9fgnDidCn7TbWZyO1SnshFhyEj+vih2ed2JmWh51pbnxGSJnhJZCElOKk72GNCrwYIWgUtgARMDgBsMabX86boGRnBzrCUKJJzeXaIOBO43mkepEngzi9LTocbZtNAbogFHls4rH00JQ6vh4VYhaRI5Bs0HB3HqSPxhpTk3dojsOuvpkd6Dfqc7LPas47ZcQj4NrjeK59L/9hrqLMNSYYi9VNjYTNQjAJsX3Yb5aE8a5xaWpXFWAu4MLfJTnaJSbhCFj1EJ10KeD5+6UWuYv6svNDX4T3EMiDOgB5aWsnFnmDl1G6U6ZR3uSD9ipBBfI1a9+D/IQxxJ8K+sEKr
X-MS-Exchange-AntiSpam-MessageData: h1861I7CUKPsDMUai93SegThbdCYHSAWMfyPaPU0Prk+PxoYo8fGrmTOQeVLxr3kCeylnHpidNM50Bkk0/HOlSwaJ+E5PTH/j5g0c0mY0v4fFtS4wWFQGPLwcYvjar4TpLk5KYRQxQ21Qm5yDTBXsg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06017a0e-4f6a-4c0a-7ff2-08d7e816fd2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 06:16:13.6003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mLEcrhBMLBYG0bt3yzQ91GqrmYabcpCOecOUtO0S5h9IVtBtXOSXJ/qKsa3IhcPg3dHfGjuV4ybeBbf3fAEByyDhM9DeFImER5pqe6YME0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
Received-SPF: pass client-ip=40.107.4.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:16:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.92
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

23.04.2020 18:01, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-cluster.c |  2 +-
>   block/qcow2.c         | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 17f1363279..4b5fc8c4a7 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1795,7 +1795,7 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
>       /* Caller must pass aligned values, except at image end */
>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>       assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> -           end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
> +           end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
>   
>       /* The zero flag is only supported by version 3 and newer */
>       if (s->qcow_version < 3) {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9cfbdfc939..ad621fe404 100644
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
> @@ -4214,6 +4215,38 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>           g_assert_not_reached();
>       }
>   
> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> +        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
> +
> +        /*
> +         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
> +         * requires a cluster-aligned start. The end may be unaligned if it is
> +         * at the end of the image (which it is here).
> +         */
> +        ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to zero out new clusters");
> +            goto fail;
> +        }
> +
> +        /* Write explicit zeros for the unaligned head */
> +        if (zero_start > old_length) {
> +            uint8_t *buf = qemu_blockalign0(bs, s->cluster_size);

Why not s/s->cluster_size/zero_start - old_length/? We may save a lot of pages if cluster_size is large.

> +            QEMUIOVector qiov;
> +            qemu_iovec_init_buf(&qiov, buf, zero_start - old_length);
> +
> +            qemu_co_mutex_unlock(&s->lock);

We are in intermediate state here. Is it safe to unlock? Anything may happen, up to another truncate..

> +            ret = qcow2_co_pwritev_part(bs, old_length, qiov.size, &qiov, 0, 0);

Better not do it if this cluster is already ZERO.. But it may be a later patch to improve that.

> +            qemu_co_mutex_lock(&s->lock);
> +
> +            qemu_vfree(buf);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Failed to zero out the new area");
> +                goto fail;
> +            }
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

