Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA957C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAC92084D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="enzo1uah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAC92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREfX-0005Vx-Od
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREee-00050S-1d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREed-0005mE-Jq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:39:03 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com
 ([40.107.20.131]:49953 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jREea-0005Pz-6M; Wed, 22 Apr 2020 08:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBpt/BfKypf6BYGGvrCZ7Rijo8mLDmv/J3zgpab/hPUMtupZF7vUj0YPX9K8oPfyCxkutXtwOWA1MG4puICx/u+XlV5Ezk/wK9IHb3M0Rt4Dtnuml9C4ohZSoeAkOmRa5rRHplMfD5Gq7zsWuCdgpNgysQ+OBNCBRj2LczW5XkiCpBKlNeOoAY1U6hxFst9QyTdJ/RouxIJmTM789HeG9ytJAXd5VkzP8ueQSSri3qFTZk0uOddLXg3Yyg00nAnS/0r/M3fRUpl6HLPk5Z43zg5S6KEUju9VInuGsdh/JGnkdAj43t/pGOupb8Scl/6/j00s+r21HXuKJ65LrEW+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZl72+D31wA0JmvnommsjNNphoRmQh4VmndxAjaASq4=;
 b=SaEjQf0HWv0il43kTdsKdTFmQaPj9PBEbWRakj6pW6DKSx5pEhD1Y/ioA3MzOjgw+195cKmAYB94vQrewuGrLUOWLHjeir1x46Ip/JsEd7+nc7QBDCeiextSu90w809IgANgL6/3hsSAlIu7piyfdNd/+zSqMu9o/c7D3r1ZrYjBbqWo7YjQ+f1QrsG9q22upmL4YGpTwYpSXbo040mSyvtFZtRJ1137+Zs6fAEurKwBYj08MJJFo5EW+KSawdiUsf+1DLTLDa5GavIjAC/sQsZU46O6AIYX0SIDHKtxL58mWo6iHupL7q9haaNAsZujVLs7Ci+OmNC/lujiL4H93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZl72+D31wA0JmvnommsjNNphoRmQh4VmndxAjaASq4=;
 b=enzo1uahxLb0sw30XbWI1g/JvJf5rGjVG659A05RhraOi2V7N+s8s+8lcIAVSwbsX57zCvb/QzVprzCXqMME+oSGFHZQI4IqPI/1561iWEg2Z73fwes0eyqfComGpBFLsJotiHNeN8iYPdQgiB2VCRPMjB35tR+7IJ2RkMwCC3s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 12:38:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 12:38:56 +0000
Subject: Re: [PATCH v4 22/30] qcow2: Fix offset calculation in
 handle_dependencies()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <46d9ec6dca0b054a529ee776d1c04b002098c127.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422153854280
Message-ID: <35b102b8-d443-ec4e-ddf2-e2528ebd145a@virtuozzo.com>
Date: Wed, 22 Apr 2020 15:38:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <46d9ec6dca0b054a529ee776d1c04b002098c127.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0074.eurprd05.prod.outlook.com
 (2603:10a6:208:136::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR05CA0074.eurprd05.prod.outlook.com (2603:10a6:208:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 12:38:55 +0000
X-Tagtoolbar-Keys: D20200422153854280
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c35bb4-687e-4542-671b-08d7e6ba1f42
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB542912956D62D58D6FA9F64DC1D20@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(136003)(39840400004)(16526019)(186003)(36756003)(6486002)(26005)(478600001)(52116002)(5660300002)(2906002)(81156014)(8676002)(4326008)(8936002)(107886003)(86362001)(31686004)(2616005)(956004)(66476007)(66946007)(16576012)(54906003)(31696002)(316002)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt/XsCYg7D9d8cVkH1j14pQrhFKYh9t8ph8eWuQiUdoqZpBzJWBKNfRGIX2WnEmIs6szh9URLRA9Tq3wd+L0l3W22XricVHckHjWFVuQ6XhNKc/yBLhmyelUctm/umNF6Vp+jkgZEt4rOsCMacQq7FELIqYYrK4xrqRqVhp098r3d7LxHoI4RhFSYjdt9c84n4f1LbOUjwH87Y8DYsxccAK5yjyRJLdnLFWoM7KZmpnejMEmqkj2piDPzPjUDQ4Npz0KqLGg7CHy+KJ8iDx7aJyibu5yCPJ8V4N2BGsgocZ5ErNsZjCOfby46C69Q758OtBy7JvthxDS7tYZcAwB2eAnrMVJFUOluWMPcj8kec8A0Nhf/rplrINOQFvbVEoOVgsl2RsGsjib0mJ73EGifbEFxzTGSDEsHSupdwT3ueBFXKhK/Z6+ynympbHjkngb
X-MS-Exchange-AntiSpam-MessageData: wKUyt7a7U930K97jh9sf4SW4wtVo4iqIBzDAtvSHZY6KhAelH6OTBgkFyLDW0AmNgFeaHTJW8E6IxmO+AbZW+zqaZLzAdbH1dXYETYjHdFtQ6NJXAZyhZ7W/s7ctAyD0hkW0y6Sre8YD7s5A8PCxyg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c35bb4-687e-4542-671b-08d7e6ba1f42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:38:56.0359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cguFRggxCctEPAHPXXKhSKEu/G/a0BdVmxfqaAQdJwlARMhHhFzDsz8Z5Hs/0EYn5LBp2GrNimGJpxofc0ZjDP+7V3oaBEd8Pqailc+9Rdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.20.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 08:38:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.131
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
> l2meta_cow_start() and l2meta_cow_end() are not necessarily
> cluster-aligned if the image has subclusters, so update the
> calculation of old_start and old_end to guarantee that no two requests
> try to write on the same cluster.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Somehow, this patch say me "hey, there may be a lot of other small places, which we forget to fix about subclusters, and you have no idea, how to find and check them all" :) Probably the only way is reviewing the whole qcow2 code, but it's too huge task.. [this is just thinking out loud]

Actually, you call it "Fix", and it seems to be a fix for your "[PATCH v4 17/30] qcow2: Add subcluster support to calculate_l2_meta()". Shouldn't it be squashed in?

> ---
>   block/qcow2-cluster.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 824c710760..ceacd91ea3 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1306,8 +1306,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
>   
>           uint64_t start = guest_offset;
>           uint64_t end = start + bytes;
> -        uint64_t old_start = l2meta_cow_start(old_alloc);
> -        uint64_t old_end = l2meta_cow_end(old_alloc);
> +        uint64_t old_start = start_of_cluster(s, l2meta_cow_start(old_alloc));
> +        uint64_t old_end = ROUND_UP(l2meta_cow_end(old_alloc), s->cluster_size);
>   
>           if (end <= old_start || start >= old_end) {
>               /* No intersection */
> 


-- 
Best regards,
Vladimir

