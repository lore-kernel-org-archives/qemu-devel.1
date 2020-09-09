Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3269C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5182021D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FamX+bRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182021D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5hn-0001WP-7H
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5h9-0000zl-PL; Wed, 09 Sep 2020 15:23:51 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:28320 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5h5-0004yJ-1D; Wed, 09 Sep 2020 15:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbyVktTF1cx+FJB1/oRQjR7iYTOhP3PB/OsOv//04NWqUhb1GLLjx7z5ix0q2revU0An/cs8oPtEeOEYeeY12gj48XHGc8+1cCxwbN3Sjo0AE+JaPow5hIfPkf1rsle5gvf/wY9zEzWh3iXBZ3dZVP7rEq1MkpFDSPwaEMCJSDljz8/Zci2tNr4ESZOOexlGabsRf5t6gGiPm/Z3/fn+37TdlXccd+Ope5w0VuuLcwCgirpO8YKEQ/IxLFvcx6rEKOEvWwCw3mgMcWp8rVjgRjruNdSQOP9zbadodEmj/7wN/bFjKYGM2nTkiOt/2KynXm8xzpckYO/c47SCIwF5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKbVeO9w0pSpy3C9ISlBMC6jH531HZlSSrPhM9XblII=;
 b=EYKRdbKGkMHt22jk2PApAubpeufYV2+MwFUxn4QnAvvZM2Y4r+Hd80A3BOtszz61Q4vDhX+YHF46P8llux7BXCdPL7jBhK+sDyRa8PKzzHAd3FhbxdgDQI52LTiz9iF37k2G0eMWjlKK5SCVviAI7W88rTuBS5JKq641kEAn1F+eqxN6tDVC4hengz7HDpHvAiWiwRS6AytFjwJGgdIK0c7HFUjH+FS5SNocBReekferd1e5FDMYE3tuEe9mWDk9epxj9rg9zt+HJER0zsCGCti9e26CAoX6OPHvV1NFr0KOxUm+GsDYsKJl3pvpFXIDWtLnOyROuJQdaD/j8EQBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKbVeO9w0pSpy3C9ISlBMC6jH531HZlSSrPhM9XblII=;
 b=FamX+bRurf1w8QXC6O6gQzNqXkDK0xTICDpXy7mIIr7Yurrms6wMVG0SE3hza8LTP3URL5h2eka9oYW3BElqxKyi83fz9F1D/vL4i6vwboskFCqWLOuFTL2OG1oPdBVgvJpjuiLxuNivGTG3uIrjiQjdtvLcpRrp36Pq5IUoRvs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2451.eurprd08.prod.outlook.com (2603:10a6:203:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 19:23:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 19:23:42 +0000
Subject: Re: [PATCH v2] qcow2: Skip copy-on-write when allocating a zero
 cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <20200827145350.26686-1-berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1cc85e0a-56b9-8eea-548b-ca7db83dd0ad@virtuozzo.com>
Date: Wed, 9 Sep 2020 22:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200827145350.26686-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:208:122::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.136) by
 AM0PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:208:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 19:23:42 +0000
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b67ddb0-7780-46af-ccda-08d854f5dd2b
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24514A5C1C4DDA6A28CC6409C1260@AM5PR0802MB2451.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEXejiwLsKzoCO4r1mOUd+bLdI7eIU9l+Rm/kNvvZZpAQrDLnjxForXeF8xXcB9ndbkIbGTFJXn5Cd/pBIT04jz+lspCkbLE/jV3zeL6TRQTHj+f6at//yTbB8rJKOxbCj1KJPOdcyWAiWT7uEHDmIOb86DNjTo+nJ+SicQHtvH8poOdOB5AIdvKrnurkZ6p9O3ne7+XOlcI//hR09dOVF8K/QdEuBEjH3hRi115vcdA4g29lVPWcXv8JJ57Q2u1BOTrsetAD3v07smlHXWo0qTNthmfUQGnZL9iGwO+fLvTNasZcZj8k6BHql4fLGaLPpHvRLsNkOF7thLL66Bpd4DC/vT8lp9r+5CCFdNrElfMz2KExzgy6hfzIRc/MPaB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(2616005)(83380400001)(86362001)(316002)(52116002)(16526019)(8676002)(4326008)(6486002)(186003)(66476007)(66946007)(26005)(8936002)(31686004)(31696002)(66556008)(16576012)(54906003)(956004)(5660300002)(478600001)(2906002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: txTDtZDzbESkLUr51TVzv/xwULEkA4urztWNLWyeFn6a9j5W6ziHw205AMOBi0248xlWkHpPLTdvw7Hoq5h/+m+UhpAwBMiiXmmwmjlmL1pff8uiWlinOdSZet7lU6NiD48LH//obwVS3SxykXJTIHmc4B66DbBAJ0NwpevxV1ibXyJeNrzJA3lKgVOzdywDre+EwIlLy7dU3Oi+z+tSqxW+h8/yZGzIzXCPKG9IBX08hf4z4ROGaRvvRxBhgK9hcqb1+C4JJqNmcSZ0b1XP0KC0A/UhGdAVN9jrCSPMtdSjZs4wwidgfffEc5Vg82/A2Pw2jWniFCjQR862T5myk3emKtwdMRteNIGVFAr1VZBabg74xfd56NnXSp5enUsLXsDMT3LuGn3WoYQMMC80/IO/AHndpo1NQpgNV+KvOU46M+rAXv/JpGCvVlPsR0jTE5VEBSFLdcKq5YC8Qm61VC7kCJp0HBEH+tbK4OW7GMvNwX8Do5ma1h2Cdr/9kSoMOpYtbsEtEW/jmDlAEzujO4G+KY5K+Gaubv0RJYVZV0A34S78iNFOphGLQrTNihJKRWNztrzD0bD/tuKW+u911Jt5kKWbyAbHngRblbCR1czDWGLqWcV4yp4RuGLeJ4UdjOJMdwwBn2VIuVcYHN7lqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b67ddb0-7780-46af-ccda-08d854f5dd2b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:23:42.8107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/SrdU+d9BEKvuczhXIMyWytYqkqFgWtY9tjJjXTVenmF5b/nNv9xyHBPqGUQ5Zcn4/ataYzk7SNB3SRREeo3etVyS0bzo38cCvhb5YctJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2451
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 15:23:44
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

27.08.2020 17:53, Alberto Garcia wrote:
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
> v2:
> - Add new, simpler API: bdrv_is_unallocated_or_zero_above()
> 
>   include/block/block.h |  2 ++
>   block/io.c            | 24 ++++++++++++++++++++++++
>   block/qcow2.c         | 37 +++++++++++++++++++++----------------
>   3 files changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 6e36154061..477a72b2e9 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -496,6 +496,8 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
>                               bool include_base, int64_t offset, int64_t bytes,
>                               int64_t *pnum);
> +int bdrv_is_unallocated_or_zero_above(BlockDriverState *bs, int64_t offset,
> +                                      int64_t bytes);
>   
>   bool bdrv_is_read_only(BlockDriverState *bs);
>   int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
> diff --git a/block/io.c b/block/io.c
> index ad3a51ed53..94faa3f9d7 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2557,6 +2557,30 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                                      offset, bytes, pnum, map, file);
>   }
>   
> +/*
> + * Check @bs (and its backing chain) to see if the range defined
> + * by @offset and @bytes is unallocated or known to read as zeroes.
> + * Return 1 if that is the case, 0 otherwise and -errno on error.
> + * This test is meant to be fast rather than accurate so returning 0
> + * does not guarantee non-zero data.
> + */
> +int bdrv_is_unallocated_or_zero_above(BlockDriverState *bs, int64_t offset,
> +                                      int64_t bytes)

_above prefix for block-status functions usually assume existing of "base"
parameter, otherwise, it's not clear "above what?"

Also, actually the caller doesn't care about it it allocated or not. It only wants to know is it read-as-zero or not. So, probably better name is bdrv_is_zero_fast()

> +{
> +    int ret;
> +    int64_t pnum = bytes;
> +
> +    ret = bdrv_common_block_status_above(bs, NULL, false, offset,
> +                                         bytes, &pnum, NULL, NULL);
> +
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return (pnum == bytes) &&
> +        ((ret & BDRV_BLOCK_ZERO) || (!(ret & BDRV_BLOCK_ALLOCATED)));

Note that some protocol drivers returns unallocated status when it doesn't read-as-zero, so in general, we can't use this function as is_zero.

I think, that better to keep only (pnum == bytes) && (ret & BDRV_BLOCK_ZERO) here, and to make it work correctly improve bdrv_co_block_status like this:

diff --git a/block/io.c b/block/io.c
index ad3a51ed53..33b2e91bcd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2408,15 +2408,15 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
  
      if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
          ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero && bs->drv->supports_backing) {
-        if (bs->backing) {
+    } else if (bs->drv->supports_backing) {
+        if (bs->backing && want_zero) {
              BlockDriverState *bs2 = bs->backing->bs;
              int64_t size2 = bdrv_getlength(bs2);
  
              if (size2 >= 0 && offset >= size2) {
                  ret |= BDRV_BLOCK_ZERO;
              }
-        } else {
+        } else if (!bs->backing) {
              ret |= BDRV_BLOCK_ZERO;
          }
      }


- we can always add ZERO flag to backing-supporting formats if range is unallocated and there is no backing file.

> +}
> +
>   int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>                                      int64_t bytes, int64_t *pnum)
>   {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index da56b1a4df..29bea548db 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2391,26 +2391,28 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
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
> +     * Instead of is_zero(), use bdrv_is_unallocated_or_zero_above() as
> +     * it is faster (but not as accurate and can result in false negatives).
>        */
> -    return is_unallocated(bs, m->offset + m->cow_start.offset,
> -                          m->cow_start.nb_bytes) &&
> -           is_unallocated(bs, m->offset + m->cow_end.offset,
> -                          m->cow_end.nb_bytes);
> +    int ret;
> +
> +    ret = bdrv_is_unallocated_or_zero_above(bs, m->offset + m->cow_start.offset,
> +                                            m->cow_start.nb_bytes);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    return bdrv_is_unallocated_or_zero_above(bs, m->offset + m->cow_end.offset,
> +                                             m->cow_end.nb_bytes);
>   }
>   
>   static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
> @@ -2436,7 +2438,10 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>               continue;
>           }
>   
> -        if (!is_zero_cow(bs, m)) {
> +        ret = is_zero_cow(bs, m);
> +        if (ret < 0) {
> +            return ret;
> +        } else if (ret == 0) {
>               continue;
>           }
>   
> 


-- 
Best regards,
Vladimir

