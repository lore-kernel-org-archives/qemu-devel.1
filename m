Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A6B2078A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hipo4+e+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A6B2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdaj-0002Ds-RL
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOda7-0001kN-I1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOda5-00035n-Qw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:39:39 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:14657 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOdZy-0002yp-V1; Wed, 15 Apr 2020 04:39:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idFM0yQ987P0WCGCy4w05bPbGFPXQK51n9JyZir5qmQEFtU2Bf7Y07i0ZJ3dSTK41Zx9iM+vZfFzlGN5xVpYIZBtG2TrKspRMe6te29FxtUcWie1eJlw9DEpqr9Yl4cchwCibnJ7RorZfmk3Onmfj10JKEMRVa9UTSPP1GxELLoaNYE576r1TD7Js8WZEmOELn7IUjGca+igukgNh8eK9hKUesZDYx/J4UQXKJj5fNiTov+2G3bUGLgKZgsXdNFyhleAS/GHKs1kzVwt86HP7hzFykqbSRN2rEHdDp15EsC/INdhbFPSPMdjaXBY+BlKlOuHheEmv/rLCOugCURKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4hxyQY84Xg58qu+Nq8IZKlx91Ccd1Wf9iIfn0YbeIo=;
 b=mcfO40RqfQE2eGrv/IbtPtL199h2SFve8/fHakscFd6zLPm+UVE6syJY5hLSuUE55VPcmY3HHiIuRoJ5mTYwbrXHOlCYjS2CMqXswCEaCBVeJu4WCcMLSsrWrnbcPls9K9/0GnkxDw+XpEGgxICLyLOBqbWL77PBLhEF6wLwfq+o5itCSTOy8afk83xbIAz5G3SRSBPWIdoGF4rFsy9osFNSNZhJaU1PjUaRagMIEuJbGvrYZyzSVuVL4skVmHIPLCC/6D5D3WcINvuuDpxSVm/sZ/sjZuFAX86UwPGO3hogxdBPPLRmj18w4Q0lN/LXQ9/mHthjwLdPy1cGnttyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4hxyQY84Xg58qu+Nq8IZKlx91Ccd1Wf9iIfn0YbeIo=;
 b=Hipo4+e+7vOy+pudyJhBkHA5fQ4l+rJoIzt7WS1EvVgE5vJLb8XyAW6qVQ2+QqKHbvc4/EnRD08hQHq31gNUuFVig/2ZsfimHJ29nrR9ugCbVA5DBcfNK4jzbmYXx7nLGKXZYOkdCfZGyB/3FE5DRgCss0sYle+gMQnYXh2SA4c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5303.eurprd08.prod.outlook.com (2603:10a6:20b:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Wed, 15 Apr
 2020 08:39:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 08:39:28 +0000
Subject: Re: [PATCH v4 17/30] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6f179204ed9ab6274a9d30b6aa9a63865a16035a.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200415113926696
Message-ID: <376b9add-b074-0020-61ae-d19d76876fb8@virtuozzo.com>
Date: Wed, 15 Apr 2020 11:39:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <6f179204ed9ab6274a9d30b6aa9a63865a16035a.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM6PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:20b:2e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 08:39:27 +0000
X-Tagtoolbar-Keys: D20200415113926696
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85afc8d2-1ab8-4f09-7ce4-08d7e1188284
X-MS-TrafficTypeDiagnostic: AM7PR08MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530349C4204C1E65A51E3946C1DB0@AM7PR08MB5303.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(346002)(396003)(376002)(366004)(136003)(2906002)(81156014)(6486002)(956004)(316002)(2616005)(16576012)(86362001)(66556008)(31686004)(66476007)(66946007)(26005)(186003)(52116002)(8936002)(54906003)(31696002)(478600001)(16526019)(4326008)(8676002)(36756003)(5660300002)(19627235002)(107886003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG/iGMICj3oVmzbLIas23xaaR9WL/nerQ61CTVKuxvQYjbjNRjZza1DeO2U51EhkYBw95TcdR2Flai3Mvd33jISBGjuaB7Fg7Ep1mJKnWs3PeFAXxA8VJxHV+dsw8Zd+3TzY4IcxM5o5RRU/4X67SvwugvKVqP2Z0YyB8GbjAZL1JCfOS2P8dVLEKLZtyRVMyvNXnh42hvOSm1IPujvXFW5lg3Fa+nIRHQQk/xYxiJYpoVStiUajnHBTUAD7+t7YHC1HtAN8zOBmBHfuEQR1Yf/RsHtofVBGfcZRrtP0fg/OaOa5dXZ3zyvNQMpigJTOlDPes3uGLGsxkRamvT+6VAt7tJOvrjWR3JNji1hBFXKfBQEc10n73sjAq1QRnEQ05jMRl50KgISkkEB2QhZEsXmmNPOQD4ShvmvL8UjpKg0LfDlnhb/TxRueD3oINSEf
X-MS-Exchange-AntiSpam-MessageData: qOTKxIC4PTcKya044+t2pvFsicJ7ffS+a8s9PEZlLjF8QFt0V8r98Iu++wNhX2auY7Xm7p/HiJoN6wcGDIl6LYgTrUDUgZQOgH3+4l8Of3eLnc7AuBSJFoU7FDPktOnT6+x+Zy6XzowFHgAio2J89w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85afc8d2-1ab8-4f09-7ce4-08d7e1188284
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 08:39:28.3212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85oRA2eglrMkQ9xJYWzh/iYIPvoWBOP22E4bm8fQaRsuXdlH2Q2dboh+OLW8uO6/Kb4F7svukOudEJYajdbbCZ7C4k6+IUElpBRCeK7l0vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5303
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.128
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
> If an image has subclusters then there are more copy-on-write
> scenarios that we need to consider. Let's say we have a write request
> from the middle of subcluster #3 until the end of the cluster:
> 
>     - If the cluster is new, then subclusters #0 to #3 from the old
>       cluster must be copied into the new one.
> 
>     - If the cluster is new but the old cluster was unallocated, then
>       only subcluster #3 needs copy-on-write. #0 to #2 are marked as
>       unallocated in the bitmap of the new L2 entry.
> 
>     - If we are overwriting an old cluster and subcluster #3 is
>       unallocated or has the all-zeroes bit set then we need
>       copy-on-write on subcluster #3.
> 
>     - If we are overwriting an old cluster and subcluster #3 was
>       allocated then there is no need to copy-on-write.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-cluster.c | 140 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 110 insertions(+), 30 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8cdf8a23b6..c6f3cc9237 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1061,56 +1061,128 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
>    * If @keep_old is true it means that the clusters were already
>    * allocated and will be overwritten. If false then the clusters are
>    * new and we have to decrease the reference count of the old ones.
> + *
> + * Returns 1 on success, -errno on failure (in order to match the
> + * return value of handle_copied() and handle_alloc()).

Hmm, honestly, I don't like this idea. handle_copied and handle_alloc has special return code semantics. Here no reason for special semantics, just classic error/success. Introducing new semantics (I think, no similar functions are in qcow2-cluster.c and may be in the whole qcow2 subsystem) just because the function is used only on return-1 paths of its callers, to save several lines of code - this doesn't seem good reason for me.

Or, may be the reason will appear in the following patches? I'll see.

>    */
> -static void calculate_l2_meta(BlockDriverState *bs,
> -                              uint64_t host_cluster_offset,
> -                              uint64_t guest_offset, unsigned bytes,
> -                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
> +static int calculate_l2_meta(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                             uint64_t guest_offset, unsigned bytes,
> +                             uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    int l2_index = offset_to_l2_slice_index(s, guest_offset);
> -    uint64_t l2_entry;
> +    int sc_index, l2_index = offset_to_l2_slice_index(s, guest_offset);
> +    uint64_t l2_entry, l2_bitmap;
>       unsigned cow_start_from, cow_end_to;
>       unsigned cow_start_to = offset_into_cluster(s, guest_offset);
>       unsigned cow_end_from = cow_start_to + bytes;
>       unsigned nb_clusters = size_to_clusters(s, cow_end_from);
>       QCowL2Meta *old_m = *m;
> -    QCow2ClusterType type;
> +    QCow2SubclusterType type;
>   
>       assert(nb_clusters <= s->l2_slice_size - l2_index);
>   
> -    /* Return if there's no COW (all clusters are normal and we keep them) */
> +    /* Return if there's no COW (all subclusters are normal and we are
> +     * keeping the clusters) */
>       if (keep_old) {
> +        unsigned first_sc = cow_start_to / s->subcluster_size;
> +        unsigned last_sc = (cow_end_from - 1) / s->subcluster_size;
>           int i;
> -        for (i = 0; i < nb_clusters; i++) {
> -            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
> -            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
> +        for (i = first_sc; i <= last_sc; i++) {
> +            unsigned c = i / s->subclusters_per_cluster;
> +            unsigned sc = i % s->subclusters_per_cluster;
> +            l2_entry = get_l2_entry(s, l2_slice, l2_index + c);
> +            l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + c);
> +            type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc);
> +            if (type == QCOW2_SUBCLUSTER_INVALID) {
> +                l2_index += c; /* Point to the invalid entry */
> +                goto fail;
> +            }
> +            if (type != QCOW2_SUBCLUSTER_NORMAL) {
>                   break;
>               }
>           }
> -        if (i == nb_clusters) {
> -            return;
> +        if (i == last_sc + 1) {
> +            return 1;
>           }
>       }
>   
>       /* Get the L2 entry of the first cluster */
>       l2_entry = get_l2_entry(s, l2_slice, l2_index);
> -    type = qcow2_get_cluster_type(bs, l2_entry);
> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> +    sc_index = offset_to_sc_index(s, guest_offset);
> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>   
> -    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
> -        cow_start_from = cow_start_to;
> +    if (type == QCOW2_SUBCLUSTER_INVALID) {
> +        goto fail;
> +    }
> +
> +    if (!keep_old) {
> +        switch (type) {
> +        case QCOW2_SUBCLUSTER_NORMAL:
> +        case QCOW2_SUBCLUSTER_COMPRESSED:
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +            cow_start_from = 0;
> +            break;
> +        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
> +            cow_start_from = sc_index << s->subcluster_bits;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       } else {
> -        cow_start_from = 0;
> +        switch (type) {
> +        case QCOW2_SUBCLUSTER_NORMAL:
> +            cow_start_from = cow_start_to;
> +            break;
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +            cow_start_from = sc_index << s->subcluster_bits;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       }
>   
>       /* Get the L2 entry of the last cluster */
> -    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
> -    type = qcow2_get_cluster_type(bs, l2_entry);
> +    l2_index += nb_clusters - 1;
> +    l2_entry = get_l2_entry(s, l2_slice, l2_index);
> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> +    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>   
> -    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
> -        cow_end_to = cow_end_from;
> +    if (type == QCOW2_SUBCLUSTER_INVALID) {
> +        goto fail;
> +    }
> +
> +    if (!keep_old) {
> +        switch (type) {

Hmm, big part of code mostly copied from handling first sub-cluster.. But I'm not sure that it worth refactoring now, may be later..

> +        case QCOW2_SUBCLUSTER_NORMAL:
> +        case QCOW2_SUBCLUSTER_COMPRESSED:
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);

Hmm. Interesting, actually, we don't need to COW  QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC subclusters in cow-area.. But this need more modifications to cow-handling.

> +            break;
> +        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
> +            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);


This is because in new cluster we can made previous subclusters unallocated, and don't copy from backing.
Hmm, actually, we should not just make them unallocated, but copy part of bitmap from original l2-entry.. I need to keep it in mind for next patches.

> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       } else {
> -        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
> +        switch (type) {
> +        case QCOW2_SUBCLUSTER_NORMAL:
> +            cow_end_to = cow_end_from;
> +            break;
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       }
>   
>       *m = g_malloc0(sizeof(**m));
> @@ -1135,6 +1207,18 @@ static void calculate_l2_meta(BlockDriverState *bs,
>   
>       qemu_co_queue_init(&(*m)->dependent_requests);
>       QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
> +
> +fail:

maybe, s/fail/out/

> +    if (type == QCOW2_SUBCLUSTER_INVALID) {
> +        uint64_t l1_index = offset_to_l1_index(s, guest_offset);
> +        uint64_t l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
> +        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry found "
> +                                " (L2 offset: %#" PRIx64 ", L2 index: %#x)",
> +                                l2_offset, l2_index);
> +        return -EIO;
> +    }
> +
> +    return 1;
>   }
>   
>   /*
> @@ -1352,10 +1436,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>                    - offset_into_cluster(s, guest_offset));
>           assert(*bytes != 0);
>   
> -        calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK, guest_offset,
> -                          *bytes, l2_slice, m, true);
> -
> -        ret = 1;
> +        ret = calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK,
> +                                guest_offset, *bytes, l2_slice, m, true);
>       } else {
>           ret = 0;
>       }
> @@ -1530,10 +1612,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>       *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
>       assert(*bytes != 0);
>   
> -    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2_slice,
> -                      m, false);
> -
> -    ret = 1;
> +    ret = calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
> +                            l2_slice, m, false);
>   
>   out:
>       qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> 

Anyway, patch should work as intended, so. if you want to keep it as is:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

