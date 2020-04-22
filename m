Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B6EC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA9D20784
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uiZpYhwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA9D20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDgG-0005MZ-8V
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRDfQ-0004uR-8h
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRDfD-00062h-UT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:35:48 -0400
Received: from mail-eopbgr80110.outbound.protection.outlook.com
 ([40.107.8.110]:35042 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRDfA-0005gr-2s; Wed, 22 Apr 2020 07:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1imP1d3VZJ6ftG3LMmtCYntNApDiCkpLKwolfGnY7ELEj6ge1ngadCAne5zsFD4TPqJzAli/4tifjSgu/GdzVBaZ5OI2tbTjhqdQ1ieU51QbMDIQlLTqjSIc2p1Eq+tvfxaohAO6fN/wkpTmZjSJ4spguPxqwIvAoTjMYxOR4n9QfnSbM8E/LseGbaTY6kOFa93hMbJ6HxtS3OLEH3xmfDEEzhWPpQ3jzu2WC3gLf02HNt2AmTnR3KN2W2iTEe7FPYRnmkg+6OX3NBJPGLKL/ORwKsYg9+JFU5vHbzbTKRn94vPE4xKuGlywIIe0AvtYRCE8/aLNBnHssdQ7WVsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DMwP5VtH0ff0i4iYqMKgbxzEDexKhSGyTSOgxRVFHg=;
 b=mcpZR9yEubif2pko1tKzpCkCzHBfCNKntJZFioQwpaGKy5y6zfAS+WfOh4t8JK+Osd5SeI+0vhK3G9TmGWD9J8rnjk9O2YF1z4+zxPXm9ylmBGSgmz02d53CkvG/2furOO9JXzKi7luYPTkCRpToFEmte1EuP/wzwGcru5t+HU8IhWH4zyv45eKsLywzvwvA/Os5uT7/lqN57pyRtTLOHxhNNyCFUh3V39+28TV3bp6WZtjn/mnX0nLJj30XMLh8tRtdDehWxVnSZW6HJrnGUJ1s0wPse1zisdd8luyHOqMVdAmGL4B6j8mIEUKLlWvAoEslJtBYuUDo/T7KTjHC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DMwP5VtH0ff0i4iYqMKgbxzEDexKhSGyTSOgxRVFHg=;
 b=uiZpYhwNsPNp4TEheSbmYh5PTK5CGhTSAYw0YGLWXgQWcgSdbjyoEnJBHw1IV2vvstpTfp6QMshLtBzJE6/zDhw27cMFIx9TGYt4MPhXQEpU5dWDOChi/DfMogt6kIOXuMFLLUsvFndf5o27kuOTnR8dQjqi+VdvaaUDTbMuF2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 11:35:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 11:35:27 +0000
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422143525726
Message-ID: <2f284a39-64b8-ca64-4465-12f9f0f8f7e5@virtuozzo.com>
Date: Wed, 22 Apr 2020 14:35:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26 via Frontend Transport; Wed, 22 Apr 2020 11:35:27 +0000
X-Tagtoolbar-Keys: D20200422143525726
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e25af5-532b-4f3b-ebbf-08d7e6b14145
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53680FB98AF18CC67780E6DEC1D20@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39840400004)(376002)(366004)(346002)(396003)(31696002)(478600001)(5660300002)(54906003)(6486002)(4326008)(107886003)(16526019)(186003)(36756003)(66476007)(66556008)(66946007)(2616005)(26005)(86362001)(316002)(956004)(16576012)(8676002)(81156014)(31686004)(52116002)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1DkmUr7pinyWiQeE/lkAxx37WRQ8yl8acp4SIlLp6x7Yr5vc/USjdShpUDA1wb4pJN211yaiLtyzXyZdr8RR3sGDZYG9sqMI+URebF0UK0T3nGjuSMAR5LuSwVKuXwzWSs73Xu+SsYmWEA9Yze+5HF24qS1Of1mcpFrBXj/A68rwshg5JN0zt0irRQmB5JQhmDBARJsgqZAu6196wcNFO9wk5EeEVjnEW2MNfuC0BsWFF4lP0eyudMeWSDr+PUlanE9mNJ7xz5hzXO0imhZdMLmLA4Y8zefveMZjLvc+8mo9okS6+VX4Zs5RGHSpVzDdzRVT5dP9r1uexPKD/CT/szU5QN5Y+q4hSvu2j9Bs7PI72y69qArzB3BY8sCZlTZlctAqOniFmrQYDOGedoRJcotg5Wx0s48sze4OvkMGPSf7YXgJkVXlwsGQ1Xmko36
X-MS-Exchange-AntiSpam-MessageData: E8uWcgK93zU6m3WnCXU9WPJoZpHzZVi7D5mLS3PrJURF22dypmrRlen6BfMkzmF+lSmpR2iurNztE+hronj/Fc3w7ZEVpmNSnFb5Qg9R/sativ4g2cjK9ho8xln8/3R4rk78q1InSxdOXlAR9jo2Iw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e25af5-532b-4f3b-ebbf-08d7e6b14145
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:35:27.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFvlwioZssICQWs0PVAg5fC1oI+sBRckWXfNz0TheKgJE8EwzkpnuKcClKPYiPH+k32QE+6Nq0MN6mzqzqaoRrMPkDdUJFjR9k3bqJeuDJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.8.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 07:35:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.110
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

17.03.2020 21:16, Alberto Garcia wrote:
> Two changes are needed in this function:
> 
> 1) A full discard deallocates a cluster so we can skip the operation if
>     it is already unallocated. With extended L2 entries however if any
>     of the subclusters has the 'all zeroes' bit set then we have to
>     clear it.
> 
> 2) Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
>     image has extended L2 entries. Instead, the individual 'all zeroes'
>     bits must be used.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 746006a117..824c710760 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1790,12 +1790,20 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>            * TODO We might want to use bdrv_block_status(bs) here, but we're
>            * holding s->lock, so that doesn't work today.
>            *
> -         * If full_discard is true, the sector should not read back as zeroes,
> +         * If full_discard is true, the cluster should not read back as zeroes,
>            * but rather fall through to the backing file.
>            */
>           switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>           case QCOW2_CLUSTER_UNALLOCATED:
> -            if (full_discard || !bs->backing) {
> +            if (full_discard) {
> +                /* If the image has extended L2 entries we can only
> +                 * skip this operation if the L2 bitmap is zero. */
> +                uint64_t bitmap = has_subclusters(s) ?
> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
> +                if (bitmap == 0) {
> +                    continue;
> +                }
> +            } else if (!bs->backing) {
>                   continue;
>               }

Hmm, so you do continue if full_discard is false AND bitmap != 0 & !bs->backing,
but you do not continue if full_discard is true AND bitmap != 0 & !bs->backing (as you will not go to "else") branch.

Seems it's a mistake.

I think, correct condition is

if (!bs->backing || full_discard && !get_l2_bitmap(s, l2_slice, l2_index + i))

, but, for doing so we also need


--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -565,6 +565,7 @@ static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
      return be64_to_cpu(l2_slice[idx]);
  }

+/* Return l2-entry bitmap if image has subclusters and 0 otherwise. */
  static inline uint64_t get_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
                                       int idx)
  {
@@ -572,7 +573,6 @@ static inline uint64_t get_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
          idx *= l2_entry_size(s) / sizeof(uint64_t);
          return be64_to_cpu(l2_slice[idx + 1]);
      } else {
-        /* For convenience only; the caller should ignore this value. */
          return 0;
      }
  }

or if you don't want, keep it explicit

if (!bs->backing || full_discard && (!has_subclusters(s) || !get_l2_bitmap(s, l2_slice, l2_index + i)))


=====

In case QCOW2_CLUSTER_ZERO_PLAIN, worth assert !has_subclusters(s) or mark image corrupted ?

>               break;
> @@ -1817,7 +1825,11 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>   
>           /* First remove L2 entries */
>           qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
> -        if (!full_discard && s->qcow_version >= 3) {
> +        if (has_subclusters(s)) {
> +            set_l2_entry(s, l2_slice, l2_index + i, 0);
> +            set_l2_bitmap(s, l2_slice, l2_index + i,
> +                          full_discard ? 0 : QCOW_L2_BITMAP_ALL_ZEROES);
> +        } else if (!full_discard && s->qcow_version >= 3) {
>               set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
>           } else {
>               set_l2_entry(s, l2_slice, l2_index + i, 0);
> 


-- 
Best regards,
Vladimir

