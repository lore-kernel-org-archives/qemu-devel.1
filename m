Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD1C2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B620B20678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vl2tdkYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B620B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMRyX-0000qk-VK
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMRxp-0000LL-78
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMRxn-00078B-UE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:51:05 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:57406 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMRxi-00076C-T3; Thu, 09 Apr 2020 03:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMhbbopmcKeS6uAWNQLiir3lOqe/XFwaBJOqZlJY9BMXiWLA+Pq2zJYYHPTZ+ItMVrcgJFtPaIv5PboqxAeuI0GWqiganlM+8965wd4oSP6tNo/D1YCiiqZSfPfoEYMRNOJe9ARJBGEC5t96JeBIhZl72EuzGj1xF1bj3UPmE5sp+cqWwsV8MiBjNtll87MT+ViIW9lA42nEqhcyFvLO7R+PRrIuaeSiobYhiMFByHPSZep0wZ5uXjWgPLxteBleTP/yShiXiqr/t4ay99UlPnR0rlZOiS8IiD+FhuNkRrN7TEiwpYFfk/YZAquGChaxgMSOlh47RfmNxMj2m+kC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33NLVpuyA9gf0SqIKYH7LutKZQvXm8+O4QKYygWxsoQ=;
 b=meIieLNdLBrCvKp5gkDzTfMVn0ifN8l9JcouvlMtMTqxBAVJCbYzfnxfeVQjOdph+uqxwVamrE5J82z+Ou75VDapBlIxGZFB5NvIrL5Bt8QCwz/mcgGndL2bRLEBzFi+aIPpXPlTt6PDJMTRFvBjIqeONdkM9nvAYGKRIAkcLGXCGTrlXbt3Pyx7ZtG24YNbmbM5PVuBbEh8MasZ346ovgri9e1nvPNlsRsX4G1lPLoaPdLX0JDav1idJA1rGAlTmi8ABzyq1d3U0xGFyrJ9aZ2dtxskxdB51UF/e0xhNLNtCFIfgnnPT5G8Inni1ihJBpI3tNvtnGUV2MAWQwSH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33NLVpuyA9gf0SqIKYH7LutKZQvXm8+O4QKYygWxsoQ=;
 b=Vl2tdkYPIEmVPGy242xARzVCQq6aJCWkFSJvWfp8RnpGAulAfS3QfndjRTUPnNrTQUChhjEGdRoteallsJGiaZpcEYxdIT8oS/mrhW6NCiP8bHp/lDdl6rmgNWIp5M9W1ousrUySoOxf4f5r8Z1Fy0wSIJzLGeWqxtRHo3sSx5g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 07:50:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 07:50:54 +0000
Subject: Re: [PATCH v4 02/30] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409105052838
Message-ID: <71d9c655-90c9-f22d-a640-12551ac690a6@virtuozzo.com>
Date: Thu, 9 Apr 2020 10:50:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM6P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 07:50:53 +0000
X-Tagtoolbar-Keys: D20200409105052838
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708f4ff7-b1a9-44c0-6490-08d7dc5abb58
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54486A5D6A563B1E6E7A56EFC1C10@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(39840400004)(376002)(396003)(136003)(366004)(478600001)(8936002)(16576012)(5660300002)(8676002)(6486002)(26005)(956004)(16526019)(81156014)(2616005)(186003)(54906003)(66556008)(66946007)(316002)(2906002)(66476007)(31696002)(4326008)(81166007)(107886003)(36756003)(52116002)(31686004)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmYq85BpGSoXdYbjAIUbIR1J8JSEkfqg2tkYK3KM99oXhx1oHBA1NWE3s0EHKrbpw+q2lzstuoB9chwee4y4mPGj+QfSpwVkCmdQQI1nj31rjhyef5bCIMMBIuJkbWiGPs/v4bBMGuarZfrTiuZONC8NMsNeAzmRnQSFNOqoUiT7GiKaKcwfRQgvaTbxRRUoQ/YWBpL/bLNY6QTeM3q530l8EHefcji/OM9ELdN0sklGgcUbz+OJBKHHzc+dDfGReH2lUeIfN5ZiJI56UbIHEQ8bSti4lCp7n8XADNysKw1EId7OQ975vO91pEnaeY00m8PdpMu+uRxDUKtrh7nL2/V7UL4ZwEylIgV5/sDboW83N/1gQLoRxzaFSca8eY9vuXxDRym9xHfXspf8pO7t38EifI/kaE5W4HQcV2IT+V8/xUsrYKEs2IeEpYgS5Zhf
X-MS-Exchange-AntiSpam-MessageData: G8A99SCmv6R/xqPRidVYCEg0hCy/yAGYRUSg4Psv1XdP9R0UdaZoux6+0qel/6OB5WtYj/K003yl185XnNTEh2LPWnApc2ONH8PlrlWq1JzMNN+DFJbfLBBRvEUoev3nkjC2qPkRJ3pbwDX+Jn+sBw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708f4ff7-b1a9-44c0-6490-08d7dc5abb58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:50:54.7431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL2Dc1FFuqxscJdraoXsSLPxotTzVlPI2dP1sjrJUJi+8Uwcc4Xs5RcQUPXtocvrLr2jXfuzioKjExgzoqExJZzboqJsZekoN9dVvTsADpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.123
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:15, Alberto Garcia wrote:
> qcow2_get_cluster_offset() takes an (unaligned) guest offset and
> returns the (aligned) offset of the corresponding cluster in the qcow2
> image.
> 
> In practice none of the callers need to know where the cluster starts
> so this patch makes the function calculate and return the final host
> offset directly. The function is also renamed accordingly.

Great that you rename functions and variables which change their behavior, it simplifies reviewing!

> 
> There is a pre-existing exception with compressed clusters: in this
> case the function returns the complete cluster descriptor (containing
> the offset and size of the compressed data). This does not change with
> this patch but it is now documented.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

[..]

> -int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
> -                             unsigned int *bytes, uint64_t *cluster_offset)
> +int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
> +                          unsigned int *bytes, uint64_t *host_offset)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       unsigned int l2_index;
> -    uint64_t l1_index, l2_offset, *l2_slice;
> +    uint64_t l1_index, l2_offset, *l2_slice, l2_entry;
>       int c;
>       unsigned int offset_in_cluster;
>       uint64_t bytes_available, bytes_needed, nb_clusters;
> @@ -537,7 +542,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>           bytes_needed = bytes_available;
>       }
>   
> -    *cluster_offset = 0;
> +    *host_offset = 0;
>   
>       /* seek to the l2 offset in the l1 table */
>   
> @@ -570,7 +575,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>       /* find the cluster offset for the given disk offset */
>   
>       l2_index = offset_to_l2_slice_index(s, offset);
> -    *cluster_offset = be64_to_cpu(l2_slice[l2_index]);
> +    l2_entry = be64_to_cpu(l2_slice[l2_index]);
>   
>       nb_clusters = size_to_clusters(s, bytes_needed);
>       /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
> @@ -578,7 +583,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>        * true */
>       assert(nb_clusters <= INT_MAX);
>   
> -    type = qcow2_get_cluster_type(bs, *cluster_offset);
> +    type = qcow2_get_cluster_type(bs, l2_entry);
>       if (s->qcow_version < 3 && (type == QCOW2_CLUSTER_ZERO_PLAIN ||
>                                   type == QCOW2_CLUSTER_ZERO_ALLOC)) {
>           qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
> @@ -599,41 +604,42 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>           }
>           /* Compressed clusters can only be processed one by one */
>           c = 1;
> -        *cluster_offset &= L2E_COMPRESSED_OFFSET_SIZE_MASK;
> +        *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
>           break;
>       case QCOW2_CLUSTER_ZERO_PLAIN:
>       case QCOW2_CLUSTER_UNALLOCATED:
>           /* how many empty clusters ? */
>           c = count_contiguous_clusters_unallocated(bs, nb_clusters,
>                                                     &l2_slice[l2_index], type);
> -        *cluster_offset = 0;
> +        *host_offset = 0;

Actually, dead assignment now.. But I feel that better to keep it.

Hmm. May be, drop the first assignment of zero to host_offset? We actually don't need it, user should not rely on host_offset if we return an error.

>           break;
>       case QCOW2_CLUSTER_ZERO_ALLOC:
>       case QCOW2_CLUSTER_NORMAL:
>           /* how many allocated clusters ? */
>           c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
>                                         &l2_slice[l2_index], QCOW_OFLAG_ZERO);
> -        *cluster_offset &= L2E_OFFSET_MASK;
> -        if (offset_into_cluster(s, *cluster_offset)) {
> +        *host_offset = l2_entry & L2E_OFFSET_MASK;
> +        if (offset_into_cluster(s, *host_offset)) {
>               qcow2_signal_corruption(bs, true, -1, -1,
>                                       "Cluster allocation offset %#"
>                                       PRIx64 " unaligned (L2 offset: %#" PRIx64
> -                                    ", L2 index: %#x)", *cluster_offset,
> +                                    ", L2 index: %#x)", *host_offset,
>                                       l2_offset, l2_index);
>               ret = -EIO;
>               goto fail;
>           }
> -        if (has_data_file(bs) && *cluster_offset != offset - offset_in_cluster)

[..]

> @@ -3735,7 +3726,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
>           offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
>           bytes = s->cluster_size;

Unrelated to the patch, but.. Why we change bytes?? So, we can finish with success, but zero-out only first cluster?

Ah, found, generic block-layer take care of it and never issue unaligned requests crossing cluster boundary.

>           nr = s->cluster_size;
> -        ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
> +        ret = qcow2_get_host_offset(bs, offset, &nr, &off);
>           if (ret != QCOW2_CLUSTER_UNALLOCATED &&
>               ret != QCOW2_CLUSTER_ZERO_PLAIN &&
>               ret != QCOW2_CLUSTER_ZERO_ALLOC) {
> @@ -3800,7 +3791,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>           cur_bytes = MIN(bytes, INT_MAX);
>           cur_write_flags = write_flags;
>   
> -        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &copy_offset);
> +        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes, &copy_offset);
>           if (ret < 0) {
>               goto out;
>           }
> @@ -3832,7 +3823,6 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>   
>           case QCOW2_CLUSTER_NORMAL:
>               child = s->data_file;
> -            copy_offset += offset_into_cluster(s, src_offset);
>               break;
>   
>           default:
> 

with or without first assignment dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

