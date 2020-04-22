Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A5C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07E120774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eSdLu8E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDF7-0001zW-09
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRDE1-0001TA-Fp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRDE0-0002hj-Vo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:07:29 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:37281 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRDDx-00027F-Bj; Wed, 22 Apr 2020 07:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFuBQMRv5GHfcvL/nlEFxCJDn30WOBPuQr2aQPvdAFuyj6j2qQDCh9YrJySi0fRWMa0jLplTrLzT+mroYv5sUZyYi631Hcafya+EgP94MN8rLG9ib0IEE7zIpJfLNV/NHl433XIkuhcuJ2Kht6UugjWxoRr8mXSolYXfNitte1yJn7j5wr3aYddfwfMVKxGkkd/gYy1ZqkFUmUB9yBFz2X75eRRTSiH9N2NR0q3hnkbnuBIUi4XxIwpmVVH861YaZtr1I+AnuLap/OWzJrTQ141Xy6//HlOxvpiOqvLjvCfYnlK7t3bVp46kl3aXyYUDKAgvprF5KoCAmyPPE3htTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=era7li/a3xMLayMgXqJVo2xUi1J+/zFH0XtYmPFHjvM=;
 b=fnmbxnFngTVbeHNK7hLhHVVWgO69y/O5LAcXPTU0CQW9rQ0pjcuut40Ev8fDRhmmg7TBKXjnDUlwtjrGkG9R5OUULvA5Q8fY2O7kdsQsP+mF3B5AinqOA+OrJ5wU5C05jF7c3NbstUMNfYYXcNRkewn09TsSrP4NT0ftRthmp2J6M2oLWOp+d9hTvU9SJMnd8F+Vdo3hwUge7+FgWdBJm1s8CgJpUR7FQvuPnt2tTiPgaKDvb2T8jOCFoHzgsx7a3AcKjZ9H/gU0ZXS02g6VcPqp3kahfP/1Wz9DjAUSc+2SwbLIQjT1wmBXL6tsSyCiGk/y9f/IX1wzKbfnuWRcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=era7li/a3xMLayMgXqJVo2xUi1J+/zFH0XtYmPFHjvM=;
 b=eSdLu8E7+rcbcuT/Se5vFHUXmrn7D5nH0uoQRHsGsAzL1rA6569813Fc50e9O+HYB/CbchyXVH4nFhpcaaTeLy1q+0mHxlxD1ulNfoxeoiQaNSdG3Olfs01ziOpaKK+ud/T5KesS/4mAfzOD9I1UpOVd7MPyRfqdwnDjDPoYSn8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:07:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 11:07:21 +0000
Subject: Re: [PATCH v4 19/30] qcow2: Add subcluster support to
 zero_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <f1d8c4bcf7c94e0cedbd96f1d7df9ea9905bddb3.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422140642331
Message-ID: <047f52a9-72c5-785d-4c7b-f4bc9410bc80@virtuozzo.com>
Date: Wed, 22 Apr 2020 14:06:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <f1d8c4bcf7c94e0cedbd96f1d7df9ea9905bddb3.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM4P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 11:07:20 +0000
X-Tagtoolbar-Keys: D20200422140642331
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b443ccd-07f1-49e4-85c1-08d7e6ad53f0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5429EDE4E4A02946DBF730A2C1D20@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(366004)(396003)(376002)(136003)(39840400004)(16526019)(186003)(6666004)(36756003)(6486002)(26005)(478600001)(52116002)(5660300002)(8676002)(2906002)(81156014)(86362001)(107886003)(4326008)(8936002)(31686004)(2616005)(956004)(66476007)(66946007)(16576012)(54906003)(31696002)(316002)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4w4WgAkQwal+S1/rJYcl+Un2TSosE+iA9GOmwfb5lQ5c8o0bSUrv7T0hCNQ1Jbo+qq+zqqtndHUWuj5kZlKJ4Z//XO1tyoK/CIba6y4ZUr5EVk80FP67m+Nb7R7/twvcnzCTi+8jaz1PUAFfztAeAXa2h609AN14sURSIojW4rNNWcfGh0gm/DeUctCbsvFcpJWyfnUQYAgCciW7PJ7Ib5eLf23dtiCdFdUyCyO6iib9URgm3Ilmi93YLWIXGipB9XPZgDSQYc8Xxuss1Y/19ePQLBMXGS4tKoPG7i3lKv+o/EXcSekFsmnsUEov3mzAOH6XlgtayQ6Zyxz6pARi3gZfvHBPBhGITTPaaSYd0JdjUxTo846dnsTSuJ0vnbJtskYlpAnad116QSZWoXHYrDk+qDEWmqSrZlqiltPvu57bsz/bdFr0aC0e0IItJyX
X-MS-Exchange-AntiSpam-MessageData: UcP+zCY428D7I1nkn4j36xWxErIt6pHCSfn90IWsTk5zDNfzq0/ynWjrZ4rEiHOf/wMRN04PSsIwHkdVCszDh5XGuLnQ2KiMR2Seg2ZWOEnYyPC7/g5G2km3Cqu88SXkN4vVOaXvn54Xg5VoyVy1zQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b443ccd-07f1-49e4-85c1-08d7e6ad53f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:07:20.9640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgFWd2Lr5+i1kQDOQzNQIKVV8uSbO/JHCqPhyu12TjGSu126RKC+s9Ol5icik99YTsJxuOpuaEeMVedueZr2EiZt6jorQEujMk2SPzb1QpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 07:07:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.118
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
> Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
> image has subclusters. Instead, the individual 'all zeroes' bits must
> be used.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

still, some comments below

> ---
>   block/qcow2-cluster.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 6f2643ba53..746006a117 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1897,7 +1897,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,

As I see, function is not prepared to handle unaligned offset. Worth add an assertion while being here?

>       assert(nb_clusters <= INT_MAX);
>   
>       for (i = 0; i < nb_clusters; i++) {
> -        uint64_t old_offset;
> +        uint64_t old_offset, l2_entry = 0;

I'd rename s/old_offset/old_l2_entry

>           QCow2ClusterType cluster_type;
>   
>           old_offset = get_l2_entry(s, l2_slice, l2_index + i);

more context:

 >         /*
 >          * Minimize L2 changes if the cluster already reads back as
 >          * zeroes with correct allocation.
 >          */
 >         cluster_type = qcow2_get_cluster_type(bs, old_offset);
 >         if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN ||
 >             (cluster_type == QCOW2_CLUSTER_ZERO_ALLOC && !unmap)) {

Worth assert !has_subclusters(s), or mark image corrupted?

 >             continue;
 >         }


> @@ -1914,12 +1914,18 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>   
>           qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>           if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
> -            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
>               qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
>           } else {
> -            uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
> -            set_l2_entry(s, l2_slice, l2_index + i, entry | QCOW_OFLAG_ZERO);
> +            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
>           }
> +
> +        if (has_subclusters(s)) {
> +            set_l2_bitmap(s, l2_slice, l2_index + i, QCOW_L2_BITMAP_ALL_ZEROES);
> +        } else {
> +            l2_entry |= QCOW_OFLAG_ZERO;
> +        }
> +
> +        set_l2_entry(s, l2_slice, l2_index + i, l2_entry);

For subclasters & !unmap case we set the same value.. And we even don't need to get it.

may be

           if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
               qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
               set_l2_entry(s, l2_slice, l2_index + i,
                            has_subclusters(s) ? 0 : QCOW_OFLAG_ZERO);
           } else if (!has_subclusters(s)) {
               uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
               set_l2_entry(s, l2_slice, l2_index + i, entry | QCOW_OFLAG_ZERO);
           }

           if (has_subclusters(s)) {
               set_l2_bitmap(s, l2_slice, l2_index + i, QCOW_L2_BITMAP_ALL_ZEROES);
           }




>       }
>   
>       qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> 


-- 
Best regards,
Vladimir

