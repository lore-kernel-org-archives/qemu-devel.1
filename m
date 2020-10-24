Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D57C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496ED2226B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EixFW0Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496ED2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWGLs-0001qt-5B
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 06:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGKw-0001Kx-Cq; Sat, 24 Oct 2020 05:59:46 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:48737 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGKt-0001D1-Rb; Sat, 24 Oct 2020 05:59:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itVW8ddvy5TmN8EmY/3t2WVGvipuQoGTypOYTi4NyMrIHhvgOX2AGAAi8XSbQb2sUfqrdl94J7zNbmr3BBkZGhlaKOniCNDuNhXIZo5YcQAgvg0OePRk3QxIU9Bnm4e8BkYM6hmW/4t6yBLcVIaWnO3seCZntHc0aYgqFTpSwNhBVX7aDbL4fKdLxfeRXWJog+clAlwjWglJd3wSF5mkD+U9Xbr9kngsho5xp/HU2M0T24FrGsbHfIx9sOqWcMkU4x9EJEgoa/n1qEg7K3OixUYzpZlwyeDnfkFfiK7z1Ayyi1lviaiJY0EcrymoH5PwupcYese/4QTBdPIn8l1pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo1blpL46KP9wSRIedzNvoiXnP66X5PvoQ9mdw06zGI=;
 b=MZIiZcV8jFNT2JA5s43AN31OXnKACIYcBDQ9hkrraGJ6H2w0K+pCwk7OkonwZ4U1LrwMzXtwcz1AGDbQk8D/4vp4FXsEA0z34Wq+nY2+RPD69bHp2wKngAdjOHXmxi5hVrRDbOZ8FFhCDwMPKj1w4e+0X8jhu/mWdiWYfAl3neLXJSsQWufskUB+05yVMiQh9vyakT3CNJiG064tFkYncrK5iCQSFVgNyN78/hZ3xaTR/ChP/zmUIfHbzDeQE2bOv7YAfuhDoPv+ai5X25BCqqNjXp6aCMNWj22zREKNjrnuuqj3oaxS93UqIoCHTlCfuUIXv8OapzdJ5njZqapWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo1blpL46KP9wSRIedzNvoiXnP66X5PvoQ9mdw06zGI=;
 b=EixFW0WqlIP1GE9fVj/7y8cemEsV0JnPegPg9phUY5EP78ZXsuea45R5FZnR4xcX7RuiLH0yvbvPG89FgiFcVaA9k6WanbeRoItCMhx5ZSzzS2UEEzsXgPSnuJ0C5w5I47VK9JnWwdfdhhRLVLQ875gaae2+r8IACYYZxArLyVA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4279.eurprd08.prod.outlook.com (2603:10a6:20b:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 24 Oct
 2020 09:59:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 09:59:39 +0000
Subject: Re: [PATCH v5 11/12] nbd: Expose actual depth in qemu:allocation-depth
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-12-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <909e397b-ebee-7380-717c-7800c32195ce@virtuozzo.com>
Date: Sat, 24 Oct 2020 12:59:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201023183652.478921-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR02CA0080.eurprd02.prod.outlook.com (2603:10a6:208:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 24 Oct 2020 09:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97885f2-3094-453f-27a4-08d8780385bc
X-MS-TrafficTypeDiagnostic: AM6PR08MB4279:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4279D80E77006DB3C5B5D41EC11B0@AM6PR08MB4279.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwuYYOcKBwic0C60RXUPljU7mftjGgudV8mnr/4OzmUVBKrrYY6XSE2+XlG3xyeBFNfyu1UgsUhhu7w+yoSBbu2LOIjoLqn1ycxgWNzcjAilRzW3nn1g+klSmBYTrNtbZ3Tm1M33kc0GUGVrXYEg41Z19o5+QEvaOapY4rLyrWgCm4+FNvgmbZ7Pd/ppbuwqbMVlvflys0mpsq6mE0vLLuH9z79tRI9pq3XBCTpqHr/U6kzsyYcHv/nJF8fi229eU6K1sYaUW3IB5vIOdZcPrZYiIHi7PznuyiDyacZOdsioWeqhskywipQcfhN/vvqoM8dEYWQKQlY6Pm7j3NP183+65NFH2oICTEE4yCtX490H2v9tIOPNyv+0ywpIZF6Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(52116002)(36756003)(83380400001)(186003)(8936002)(2906002)(86362001)(4326008)(8676002)(316002)(478600001)(16576012)(31686004)(16526019)(26005)(66476007)(66556008)(66946007)(956004)(2616005)(5660300002)(6486002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fhyNZlXJPuGqmDQQqCYsEpNeQTsIFUrs6QFmL1+4kPH2Uhj23nNJaxIQvB+dLjpSN2zRTodKX/VarvBHXFj5JUkCl82p5+tjIGaghisIKAifZVeQosXJNc1L7ISqXsfo6RRTSN2iqVaj+aR3oKstIPfUKrk/XWyVpJWBOWzHMWnbsQuL/nfm2ETutaUriF1CRTgRUaiD5s3U06r/nO/HRPp6ZQquvwScDVhX0t61J63UWBCE0/D7fbhDSoAVgs64lxfnY5vVMre8fWaN7VxgnjNdqu7PC8s4gxBddlEnebclyyhsodaHBrsjYzkJBLkzFLBhpeaJL1VnWClp8n0CRUajFiQjGHxchpg/tncrpxm4kr7/rvwO7/zYAmjFpE9Ju1/w5Y6aOEz5XadDIKABAAP6fxrZedJB0CafIVZQ1+z0Q/ZlKn8b/aawet9ZJa8y546QuMz8F5/O1qQhGBYsXXx4u4wS6XnXAugbw6VY1AI+iFFStMTpraDC6q61i4Ay8xIQ/ASuYlbBXn3h5cyYveFFj9oAsx1wyj2IypIqFeJ7BXphzApAiI717eq++Kzl9JzPPhTZr+IzUIvLL/zu5iQijUIBkY9rD/3AmMEOaVtRb1cSvpt9Ij7EGUUb+Wmoy/Cs0BxJ0p83TLQHlSJjrQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97885f2-3094-453f-27a4-08d8780385bc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 09:59:39.7926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsJelIwYPwiBRMEOPE6gnQ6m1jh2z8u7hXmbJhcrnsVDnsf7k0vHHPiuEFbLiw1SIAHGV/DqK+zEuxZEcTrQ9pYmY2ynU8VoDETvLHF4o6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4279
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:59:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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

23.10.2020 21:36, Eric Blake wrote:
> Preserve the tri-state encoding in the low bits, as that still remains
> a valuable way to utilize qemu-img map with x-dirty-bitmap for
> accessing quick information without needing a third-party NBD client.

Hmm.. that doesn't sound as a good reason for redundant information in the protocol. Previously good reason was additional effort needed to implement sever part, but you've implemented it. And if we export depth anyway, it seems better to hack a bit nbd_client_co_block_status to convert extent.flags appropriately if metadata context is "qemu:allocation-depth" (to keep x-dirty-bitmap working), than have a workaround at the protocol layer.


> But now that the block layer gives us an actual depth, we can easily
> expose it in the remaining bits of our metadata context (leaving two
> bits reserved, to make it easier to read depth out of a raw hex
> number).  This assumes no one runs a backing chain larger than 256M
> elements.
> 
> iotest 309 remains unchanged (an example of the above-mentioned
> x-dirty-bitmap hack); actually testing the new bits requires libnbd or
> a similar client, and I didn't want to make iotests depend on libnbd
> at this point in time; rather, see the libnbd project for interop
> tests that exercise this new feature.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/interop/nbd.txt |  6 +++++-
>   include/block/nbd.h  |  2 ++
>   nbd/server.c         | 27 +++++++++++++++------------
>   3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> index 7e948bd42218..d90723ffe991 100644
> --- a/docs/interop/nbd.txt
> +++ b/docs/interop/nbd.txt
> @@ -34,7 +34,8 @@ the image, with a single metadata context named:
> 
>       qemu:allocation-depth
> 
> -In the allocation depth context, bits 0 and 1 form a tri-state value:
> +In the allocation depth context, bits 0 and 1 form a tri-state value,
> +along with 28 bits giving an actual depth:
> 
>       bits 0-1: 00: NBD_STATE_DEPTH_UNALLOC, the extent is unallocated
>                 01: NBD_STATE_DEPTH_LOCAL, the extent is allocated in the
> @@ -42,6 +43,9 @@ In the allocation depth context, bits 0 and 1 form a tri-state value:
>                 10: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
>                     backing layer
>                 11: invalid, never returned
> +    bits 2-3: reserved, always 0
> +    bits 4-31: NBD_STATE_DEPTH_RAW, the backing layer depth (0 if
> +               UNALLOC, 1 for LOCAL, 2 or more for BACKING)
> 
>   For NBD_OPT_LIST_META_CONTEXT the following queries are supported
>   in addition to the specific "qemu:allocation-depth" and
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 956687f5c368..3c0692aec642 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -264,6 +264,8 @@ enum {
>   #define NBD_STATE_DEPTH_UNALLOC      0x0
>   #define NBD_STATE_DEPTH_LOCAL        0x1
>   #define NBD_STATE_DEPTH_BACKING      0x2
> +#define NBD_STATE_DEPTH_RAW_MASK     0xfffffff0
> +#define NBD_STATE_DEPTH_RAW_SHIFT    4
> 
>   static inline bool nbd_reply_type_is_error(int type)
>   {
> diff --git a/nbd/server.c b/nbd/server.c
> index 53526090b0a2..afa79e63a7a6 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2037,22 +2037,25 @@ static int blockalloc_to_extents(BlockDriverState *bs, uint64_t offset,
>       while (bytes) {
>           uint32_t flags;
>           int64_t num;
> -        int ret = bdrv_is_allocated(bs, offset, bytes, &num);
> +        int depth = bdrv_is_allocated_above(bs, NULL, false, offset, bytes,
> +                                            &num);
> 
> -        if (ret < 0) {
> -            return ret;
> -        }
> -
> -        if (ret == 1) {
> +        switch (depth) {
> +        case 0:
> +            flags = NBD_STATE_DEPTH_UNALLOC;
> +            break;
> +        case 1:
>               flags = NBD_STATE_DEPTH_LOCAL;
> -        } else {
> -            ret = bdrv_is_allocated_above(bs, NULL, false, offset, num,
> -                                          &num);
> -            if (ret < 0) {
> -                return ret;
> +            break;
> +        default:
> +            if (depth < 0) {
> +                return depth;
>               }
> -            flags = ret ? NBD_STATE_DEPTH_BACKING : NBD_STATE_DEPTH_UNALLOC;
> +            flags = NBD_STATE_DEPTH_BACKING;
> +            break;
>           }
> +        assert(depth <= UINT32_MAX >> NBD_STATE_DEPTH_RAW_SHIFT);
> +        flags |= depth << NBD_STATE_DEPTH_RAW_SHIFT;
> 
>           if (nbd_extent_array_add(ea, num, flags) < 0) {
>               return 0;
> 


-- 
Best regards,
Vladimir

