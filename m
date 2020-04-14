Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263BC352B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF30F2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jtqb7tT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF30F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOI9D-0004Rh-Vt
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOI7w-00037f-I1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOI7v-0001UQ-6W
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:45:08 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com
 ([40.107.3.105]:44869 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOI7q-0001Rq-Rq; Tue, 14 Apr 2020 05:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUTAcg3ZsB755G20KqP3uSXyPDOlGate+abgcOOBvDFoWmV4WuJF+DpDYxVxzcRlBrpIZ9aLV1dzkkwvXICg4//tef+IFapL8eJmpoeBslbBteWJknTBRM05w7h9hYLvIpr1m+HK/ySEQS/noLCY4SPChb9ZfylWYQjuAXoNOSooqCiUp5rjOQ4dH3xVz2lqsLWKSOq/daRqnL4vDRzVOGHN8w9quYXcGO1IMPMt4tipqe4HY8R6kVB6jZhHMr0aWMnbaJPMLDUUqf6jAYRw49HjuUVfet6qbW6fMSjB4OWZpkvQyXNz2eyj0scAMDReCsA692B73kuFqhVWRztZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMhC+ip8lgbn7vbTUdsfqiYKjxuZqPj0zEDXED8/vIU=;
 b=Zk8qs7ww6x/xG/YC/tRhQNCiCf6InyhVr0qu/qq5o0B/ctR+zvRUzSKO9zR5nF133EIzr8FuZSQOYPtQsU21Q+IbMBPNoYmkGhhEE+6wRJvgSlTK7PWcSa+ERFkwTDFu63KuFVdhJ10foVpyUaRMEdLKkPa8yewIjkMHg4KHnU6dR/yOU6Q52eGXV3akAz9FX1+Jf6Vg7kLjaapkNdoEXn3bvmfCc9YZHVnmCda+FBWgYSy2gDnn8R6Aa7MwFEiscErTiK+LGxYZvdSdAmGREId5F0RWSKtMKrkqYbQqQK29G1UyXNzbLaHq717e8GU1UnUjb//BhcZvtmpTN6mEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMhC+ip8lgbn7vbTUdsfqiYKjxuZqPj0zEDXED8/vIU=;
 b=Jtqb7tT0ISY0DRmh8i64aU5GPGBYTblEFqFLkU5Fqcq5oiaE0BB2KKhnhRBp3Gi+Ub1Z5nH7O+0W0plTftbU6Ts/tAeunRqqPiaaW5h2na6Sz0k3oyb9fW4y9aPn9ZF2zszQxVqvWuiGnF68X81rw3a1Nl8k1FH5KMMuV3msXH4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 09:44:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:44:59 +0000
Subject: Re: [PATCH v4 11/30] qcow2: Add l2_entry_size()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414124457255
Message-ID: <58d1fa17-91ea-9f8d-c39a-4141783d1234@virtuozzo.com>
Date: Tue, 14 Apr 2020 12:44:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0110.eurprd07.prod.outlook.com
 (2603:10a6:207:7::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM3PR07CA0110.eurprd07.prod.outlook.com (2603:10a6:207:7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.14 via Frontend Transport; Tue, 14 Apr 2020 09:44:58 +0000
X-Tagtoolbar-Keys: D20200414124457255
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62b4416-94ed-4b40-25b1-08d7e0587eff
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447C13F3BA43EE11DBD8A39C1DA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(8936002)(66476007)(81156014)(8676002)(31696002)(52116002)(66946007)(2906002)(66556008)(5660300002)(26005)(86362001)(16576012)(16526019)(6486002)(478600001)(316002)(186003)(4326008)(36756003)(31686004)(54906003)(956004)(2616005)(107886003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5sdgoJ3AESdxD3p7W6YvdZ5kRzLxrxeOiFk7VC2PUQgrFEjWGDTYf/YShaRtkmRlwtk9X2f5o7Zjh/OVAqcdAsuQezGWIfObYXrWe5LOJU6lngc8uVq8JR+ZFXg7NE9XuT+afhrvlKJLHk60dcqH+II4rbidAatGkhoswxMzqYyXMQcyp+mEMbhIjCu8AOSWYsslV6yxjTqJpTTWUK2pyVGsSLdETUzfkSTwHB2d00pRRI6FSDo5kBD2nwzsq+nlH1Y2BRJ+4dl4tvc3hsDdXsoBQvqOBHpf7M0R3ITvZgy/EyH5CTzD29odL0aB9x1iV+uJQfcvLZXvvBJBzlI6WFAFRVdT7qPm6NG3YltsBq424rJ1y+9LIeCAxtiTmwYbJxf3wePFTjSbf6gezdLVCjKVPa9AYCRfxi4fzKud5G7gcz7YsiXoOnEWUAqO6/N
X-MS-Exchange-AntiSpam-MessageData: 6iMNhi9yTk74u5xVFUZpFiawlpszo8nsRnkFjdCCDmNDx5Df2GTnqVn9nUkBRsoYScgp7JzCYgY4OJccszsd9iPWvbmlA6YNASUuWxYA28A/aMAdIjkGqs+ldjp9Q7GsazWtUxnXme+Mg4v2JH7uag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62b4416-94ed-4b40-25b1-08d7e0587eff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 09:44:59.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FpLgW7Y4dKVlVUhV/iiUuQBUdZ2ZjYHaiNByAzD6CISB7dQlFssyc1tQkwcE0bWz3JF5Hk73tbMzT30Vpol/y7x8H1eRjy9K6cjxbkCp9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.105
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
> qcow2 images with subclusters have 128-bit L2 entries. The first 64
> bits contain the same information as traditional images and the last
> 64 bits form a bitmap with the status of each individual subcluster.
> 
> Because of that we cannot assume that L2 entries are sizeof(uint64_t)
> anymore. This function returns the proper value for the image.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2.h          |  9 +++++++++
>   block/qcow2-cluster.c  | 12 ++++++------
>   block/qcow2-refcount.c | 14 ++++++++------
>   block/qcow2.c          |  8 ++++----
>   4 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 06929072d2..1eb4b46807 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -80,6 +80,10 @@
>   
>   #define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
>   
> +/* Size of normal and extended L2 entries */
> +#define L2E_SIZE_NORMAL   (sizeof(uint64_t))
> +#define L2E_SIZE_EXTENDED (sizeof(uint64_t) * 2)
> +
>   #define MIN_CLUSTER_BITS 9
>   #define MAX_CLUSTER_BITS 21
>   
> @@ -506,6 +510,11 @@ static inline bool has_subclusters(BDRVQcow2State *s)
>       return false;
>   }
>   
> +static inline size_t l2_entry_size(BDRVQcow2State *s)
> +{
> +    return has_subclusters(s) ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
> +}
> +
>   static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
>                                       int idx)
>   {
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index cd48ab0223..41a23c5305 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -208,7 +208,7 @@ static int l2_load(BlockDriverState *bs, uint64_t offset,
>                      uint64_t l2_offset, uint64_t **l2_slice)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    int start_of_slice = sizeof(uint64_t) *
> +    int start_of_slice = l2_entry_size(s) *
>           (offset_to_l2_index(s, offset) - offset_to_l2_slice_index(s, offset));
>   
>       return qcow2_cache_get(bs, s->l2_table_cache, l2_offset + start_of_slice,
> @@ -281,7 +281,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index)
>   
>       /* allocate a new l2 entry */
>   
> -    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * sizeof(uint64_t));
> +    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * l2_entry_size(s));

hmm. s->l2_size * l2_entry_size, isn't it just s->cluster_size always? Maybe, just refactor these things?


>       if (l2_offset < 0) {
>           ret = l2_offset;
>           goto fail;
> @@ -305,7 +305,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index)

[...]

> @@ -1425,7 +1425,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>           bs->encrypted = true;
>       }
>   
> -    s->l2_bits = s->cluster_bits - 3; /* L2 is always one cluster */
> +    s->l2_bits = s->cluster_bits - ctz32(l2_entry_size(s));
>       s->l2_size = 1 << s->l2_bits;
>       /* 2^(s->refcount_order - 3) is the refcount width in bytes */
>       s->refcount_block_bits = s->cluster_bits - (s->refcount_order - 3);
> @@ -4104,7 +4104,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>            *  preallocation. All that matters is that we will not have to allocate
>            *  new refcount structures for them.) */
>           nb_new_l2_tables = DIV_ROUND_UP(nb_new_data_clusters,
> -                                        s->cluster_size / sizeof(uint64_t));
> +                                        s->cluster_size / l2_entry_size(s));

Isn't it just s->l2_size ?

>           /* The cluster range may not be aligned to L2 boundaries, so add one L2
>            * table for a potential head/tail */
>           nb_new_l2_tables++;
> 


Conversions looks correct, but how to check that we have converted everything?

Trying at least

    cd block; git grep 'sizeof(uint64_t)' qcow2* | grep -v 'l1_size \*' | grep -v 'l1_sz \*' | grep -v refcount | grep -v reftable

I found this not converted chunk:

     /* total size of L2 tables */
     nl2e = aligned_total_size / cluster_size;
     nl2e = ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
     meta_size += nl2e * sizeof(uint64_t);


Hmm. How to avoid it? Maybe, at least, refactor the code, to drop all sizeof(uint64_t), converting them to L2_ENTRY_SIZE, L1_ENTRY_SIZE, REFTABLE_ENTRY_SIZE etc?
And all occurrences of pure '8' (not many of them exist)

-- 
Best regards,
Vladimir

