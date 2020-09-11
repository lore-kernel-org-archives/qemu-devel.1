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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E477C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492C421D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m02New66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492C421D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfTp-0007EA-8B
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGfS9-0005iJ-Vg; Fri, 11 Sep 2020 05:34:45 -0400
Received: from mail-am6eur05on2119.outbound.protection.outlook.com
 ([40.107.22.119]:46209 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGfS6-00011X-Km; Fri, 11 Sep 2020 05:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwqQ6tVsHwa0zL2zpLAYw5a2U38uQB2e8ZPW4JFmoMYqU8OjpYREIvzWVG08X7VK0Ktrdj/70uVUETxAvKHdOrVRuOO+UD2E5HWwFD7testfiiKIc/TgE/538ddSSvWhj4G2EZpNOHiR9DMJU97a3O0YFSYqQ5J4WunQ4i0fgu1USEpVtTR56+pyDVKflc8yTnUPLNFZPaLnCy8Vx6l6p5SAbT036lCuuKb0cwi1c+gm40+cS9MKdNSjK+LAx9/aulzoWnzr4WYNhFE4XavVX25rqsqLBPv5wFzwn1uRpf6OAr8Byfcf41izlUrO6jZwsm8DiluxsTUflSdrwmRNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGpQOkli5vmCRhEs26Q6AqOlJYduk8D0/5R4a0hvWDA=;
 b=CDxXhXUsD/aXj7DFghksCUxvTnHoPdH2+2sVbuYBYp95awdi9QvqkU5goiD/4/ymn1BkECiYFmrC4kMfS3c1ss6Z+SwMVqhI+LV9P32zbtISzn7xJhQBZv6RwSvu87sAdqZW3BERr0NQ8N96ZrDve9RiBlj3vlDStrBg4/Xvntfo2iMEQ/ewPvwYH57/vuVIKUf72gUOaUKPfM1F/VQ3CyVuc+XV7bbEtZmQba2qlp+cmwmH+c8sxniWBED0nRPy7sR5siZOAPqkYR3NOxZ/xLAzw2RbVt0FE+yQUJXEYUHH3Rqef3AjAuCDZzf5kFpr7/xdLuiKwaYSOpLeZops3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGpQOkli5vmCRhEs26Q6AqOlJYduk8D0/5R4a0hvWDA=;
 b=m02New66Q/IjLByOWPt9vEFVjLI936gpVX7OJekQ+UMkrFDxkViGKnN+vONKZTsob5NQjv/gdHnIWWNukcVv+w1b6EAkv+2zEq6BsZyJS4wTHMp34xUzrghjZI+B7YAeYGGc3KzofsCHKfxtorKPwQRarjLvrbJeh+CaAv5OAb0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4023.eurprd08.prod.outlook.com (2603:10a6:20b:a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 09:34:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 09:34:39 +0000
Subject: Re: [PATCH v3 2/2] qcow2: Skip copy-on-write when allocating a zero
 cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <cover.1599759873.git.berto@igalia.com>
 <0350dd55702eacd701e0aea924b101db7448a517.1599759873.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7f0ae868-07ca-2267-eb27-2787ff86e801@virtuozzo.com>
Date: Fri, 11 Sep 2020 12:34:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <0350dd55702eacd701e0aea924b101db7448a517.1599759873.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 09:34:38 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7de14389-5895-47cc-ffee-08d85635e784
X-MS-TrafficTypeDiagnostic: AM6PR08MB4023:
X-Microsoft-Antispam-PRVS: <AM6PR08MB40237A154C6D5F2F03F3A31DC1240@AM6PR08MB4023.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teeaZwxkqrtcVMPsHTNc9gzfHlE/qQW9yvmG5OOE1aN3Xq8qG8cG3UJmPonXbwCkT3/jCRCyQlK1LZKd1TMuglIJv/9cbxpqPqnlLrb2CWju9pbQwkVzVr9FwsD4Cn9t+dxcPKqG8uUJhTiuxIV93+6B27r2dx5JTRVYxJITghKY+X+eoGpcGURaOZAFAo168xVEMfn2nbYs5KRLhWKgIGdbI8y96tgfGHlW2toJ/HfLB0qnRQeVJ0Rn/EO18On+OolKJVuERxVYCu0fPtFQorbjeKOQoLN1nyQZskW3ev2IUQIe6uGJlQHDcSOUoqtNI4pCQANHMArQbVzROzhR9MpZgTYyPKqWcY+mzzGRkcD8YhxVfimt3tbCYKsYEPiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(31696002)(8676002)(6486002)(52116002)(956004)(86362001)(2616005)(83380400001)(36756003)(478600001)(54906003)(4326008)(66556008)(8936002)(16576012)(316002)(26005)(66476007)(31686004)(66946007)(2906002)(5660300002)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 32UJH6MLMFV6YkopcpvR6EFeHSkA4p1TWIQ6Odl2gMG0slsx0lD1mROaxE2uOBiK71JcgupUCs/SZ2lqCC/6B0CiphyOcHV88DfhG4R7QZSAdxwKsDQ0h+TubskK8YTDRAG/hsikn6NIlfqwAjWxTQdvT0CfJ6XN+H1jVjW1Xp4Ye9PvNxy6Fz3jtZgL4ciOoUmA0jBP3LWp+TyJVg3aQm7RHDp9etax8TM3WmIP6SjzNHjCQhlnNYpYL6icATdsiMtJUtUpY0XQ7o/lJIAwaIJc+P2txM3aes8hADhpd3sC8aW+qa/9eXIzH+Lh05znn6YSBCwvDX8TTbsozEPmp2QSy0luPNMPi0znEUrXtKuBwgiDASeLrV78W3PYO55JeYVZP0TqrMc51eGjZm0Mtbtlhlvx2MdwcuBglINaYBWLZAimU30hP+lqapowZyIgE2/t1MIHn8fbhwrotRGUA67oBUwARkZOjSTKK7cewWbkFo2Z15A4aS0+GCYN3ClLEsyI2h83nGPXa95v/aTj5tl7N6yyN/1Fxmbfz4y/NA/DzVGSaboUSczcVZf8IpKbFmhHkup1pH9YIMxsdb9ivL6/I08l6/cVt6M4De3erygP01vfWq/kf0qCBpdnKwuKpOWX9t5fdfTR9/BA42k7kg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de14389-5895-47cc-ffee-08d85635e784
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 09:34:39.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU4kl0AQ6c2wl/cwkno1xMD+cqWgFUo4vjK9Z39s8Qh8ViNOJEB2Aan3FxWMm1ymhoKcFhqPrEOVzi4mvKUjOsoTA93TOCx7VbjwxIC4cW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4023
Received-SPF: pass client-ip=40.107.22.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 05:34:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001,
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
> Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
> request results in a new allocation QEMU first tries to see if the
> rest of the cluster outside the written area contains only zeroes.
> 
> In that case, instead of doing a normal copy-on-write operation and
> writing explicit zero buffers to disk, the code zeroes the whole
> cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.
> 
> This improves performance very significantly but it only happens when
> we are writing to an area that was completely unallocated before. Zero
> clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
> are therefore slower to allocate.
> 
> This happens because the code uses bdrv_is_allocated_above() rather
> bdrv_block_status_above(). The former is not as accurate for this
> purpose but it is faster. However in the case of qcow2 the underlying
> call does already report zero clusters just fine so there is no reason
> why we cannot use that information.
> 
> After testing 4KB writes on an image that only contains zero clusters
> this patch results in almost five times more IOPS.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   include/block/block.h |  2 ++
>   block/io.c            | 27 +++++++++++++++++++++++++++
>   block/qcow2.c         | 35 +++++++++++++++++++----------------
>   3 files changed, 48 insertions(+), 16 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 6e36154061..71f5678de7 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -496,6 +496,8 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
>                               bool include_base, int64_t offset, int64_t bytes,
>                               int64_t *pnum);
> +int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
> +                                      int64_t bytes);
>   
>   bool bdrv_is_read_only(BlockDriverState *bs);
>   int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
> diff --git a/block/io.c b/block/io.c
> index 1b0ae29610..5950ad87be 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2557,6 +2557,33 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                                      offset, bytes, pnum, map, file);
>   }
>   
> +/*
> + * Check @bs (and its backing chain) to see if the range defined
> + * by @offset and @bytes is known to read as zeroes.
> + * Return 1 if that is the case, 0 otherwise and -errno on error.
> + * This test is meant to be fast rather than accurate so returning 0
> + * does not guarantee non-zero data.
> + */
> +int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
> +                                      int64_t bytes)
> +{
> +    int ret;
> +    int64_t pnum = bytes;
> +
> +    if (!bytes) {
> +        return 1;
> +    }
> +
> +    ret = bdrv_common_block_status_above(bs, NULL, false, offset,
> +                                         bytes, &pnum, NULL, NULL);
> +
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return (pnum == bytes) && (ret & BDRV_BLOCK_ZERO);
> +}
> +
>   int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>                                      int64_t bytes, int64_t *pnum)
>   {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index da56b1a4df..68ab6562e3 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2391,26 +2391,26 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
>       return false;
>   }
>   
> -static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
> -{
> -    int64_t nr;
> -    return !bytes ||
> -        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &&
> -         nr == bytes);
> -}
> -
> -static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
> +/*
> + * Return 1 if the COW regions read as zeroes, 0 if not, < 0 on error.
> + * Note that returning 0 does not guarantee non-zero data.
> + */
> +static int is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
>   {
>       /*
>        * This check is designed for optimization shortcut so it must be
>        * efficient.
> -     * Instead of is_zero(), use is_unallocated() as it is faster (but not
> -     * as accurate and can result in false negatives).
> +     * Instead of is_zero(), use bdrv_co_is_zero_fast() as it is
> +     * faster (but not as accurate and can result in false negatives).
>        */
> -    return is_unallocated(bs, m->offset + m->cow_start.offset,
> -                          m->cow_start.nb_bytes) &&
> -           is_unallocated(bs, m->offset + m->cow_end.offset,
> -                          m->cow_end.nb_bytes);
> +    int ret = bdrv_co_is_zero_fast(bs, m->offset + m->cow_start.offset,
> +                                   m->cow_start.nb_bytes);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    return bdrv_co_is_zero_fast(bs, m->offset + m->cow_end.offset,
> +                                m->cow_end.nb_bytes);
>   }
>   
>   static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
> @@ -2436,7 +2436,10 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>               continue;
>           }
>   
> -        if (!is_zero_cow(bs, m)) {
> +        ret = is_zero_cow(bs, m);
> +        if (ret < 0) {
> +            return ret;

It's a common practice to treat block-status errors as "unknown" status and not error-out immediately:

  - really, it's not critical, we can continue assuming non-zero
  - if there are real problems with IO, we'll most probably fail on real read or write operation, and report its status, which seems better for user than block-status error

So, I'd keep existing logic in handle_alloc_space(). And, if you agree and resend, probably good to split this patch into two, one for block.h/io.c and one for qcow2.c (still, I'm OK with it as one patch).

> +        } else if (ret == 0) {
>               continue;
>           }
>   
> 


-- 
Best regards,
Vladimir

