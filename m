Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0618FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E5920773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T8GCst15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E5920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvYG-0002nt-2B
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juvXa-0002JE-P9; Mon, 13 Jul 2020 06:18:31 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com
 ([40.107.2.104]:65054 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juvXW-0006El-T0; Mon, 13 Jul 2020 06:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN5kSlSTuKO8BMd8oFG8JhmMPbRDvWDAxgssnylxccVZ165rwI6S/DnxoHso0WJ+AzxQBRu4E3kSlNU8VDdouj5WsVgc0UvufQmVpIZmRzA3hnG9OwpJDyir2x6UdcRM0E7Ts9q2bLcRsSSRYzEIiUEAnvyiyNcpgirDZ5MPUocbFbj2kzU/C/ijAZP3kTaZ3kWRhbMbNY2DNqfLvwaEgdNxoHXrDkL5SJZmfBBQgMUMnF6bQSRXhkpFp8Hqc3oObfazfMbkK1QCjnhpzKvSiALaFyA9p7zOXJh5bCIOz3ZIsIUPJs7sK/66AcZRHhfwFq8/8khhZdYlj2gIiUrjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93ldpRfedNxo68gpdRossExp4FHblUDGSChjUoIuG5k=;
 b=DXxTvgc1Oy3NM4NrJGcHUc4PcF3o90GuFFrmh8v6i8PoFSnkT5C5UhV59A0fQlPahXnVv90l5Eu+6MH8JXEW/EWblO6zrgObsB1Yi+MpwcjLdRPRg1N3LBnxXxyfCL4gqM90WWd1cK6eAyrt6W5JjTRrJsFI94oBK/I84rcgIYxg6em/5KioxP9HoKBirMvYCc+J+EC1RUWuWefJ1WvTfbfkS7O9a1a4xvavfDAzYNvHeXl7zGLtDvjyKY+Jypz6lxVKMHxJI+mzhXU+BEVXbSGddRx50DbeyZpEJmvio8+ccsPM2J7ehRNpzFJLTcnk4H6qJVxs0CapnP/AlGVIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93ldpRfedNxo68gpdRossExp4FHblUDGSChjUoIuG5k=;
 b=T8GCst15o/nwmY8OMSeapVIqOESzmrjYhl3Nt5mQYkLK5hNjqfrjiH8/6uFq0+3D68KmcbZuloiM/YbmCRRhC/KAgvjXnRE/1bSRYP463t4w+DcFlZfc4YDu90Wz/Y0GHHtHLGz2b+5/txykc6MmBPzXTQOp60zXzW+twIFCQ00=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4021.eurprd08.prod.outlook.com (2603:10a6:20b:aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 10:18:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 10:18:20 +0000
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <697fa19f-b68f-f45d-7fab-a0d746c44557@virtuozzo.com>
Date: Mon, 13 Jul 2020 13:18:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200625152215.941773-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0080.eurprd05.prod.outlook.com
 (2603:10a6:208:136::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR05CA0080.eurprd05.prod.outlook.com (2603:10a6:208:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 10:18:20 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f322c0f-2eb2-46d3-a30f-08d82716115d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4021D08DEE84B264D79B1161C1600@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdeJ/QtYVRUl6sLOYWojIZ58PaFuzSCne7lOYMwgz24u1eCyMfBfZOFP44wavnhfMx+FUf9aYIc7qZVjS6r4CL2wXFHAHjJ4z65I/83Uj9/x8+XgE8a7PxjyzH6XCKpX6BmGWj23wIaoQtlY0ZNUDRrvifNN8+Pv6t2GTnsNkJybq7qFcHbWLTwu1MI5MrYYjmS4uZm9tMt0inZFYhtpmrLASSRkqfdBOA61XbTwRdtTeatUMRqmfNxhHjU0Jb/NqeFmBq1GM9Nf44gvvKAUIeHEQNm7ZGhRVDRFMAUK69kZZj617eW3V0iru2mUqsxU7mHogAbxKHLSEZf2YA/RCvTgGiIV0enbfMzTTVxkxwseHmv/1qSp4gZDhmpcM0075P2Tg9szLAJjFcNZs4aCtjJUh5Iwb2+t5D2TERbDATk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39840400004)(136003)(2616005)(5660300002)(316002)(66556008)(52116002)(6486002)(66946007)(8936002)(8676002)(66476007)(86362001)(2906002)(956004)(478600001)(83380400001)(31686004)(16576012)(186003)(16526019)(36756003)(26005)(4326008)(31696002)(245554002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zb/4Ybr8sn0OxIKw4pDas88uPUXv19p5bB7e7RzdeSyV5dXfJ3+uYGMvFlMiHP4pcA37efWLERCOXkWhYAaMoxXI+NVjFhvOi7Oln7FH10h78/3UcqHD0Hz9Bovol9N01mL5pGE0xCNVwx06chq7iyQUK54ylTERPuuciJZs1xRo5ZoLcVSOyfTRg51ZdWVfoZGR2wqRd3MS+jvHHKW2njyFIhX/92bbLD5t7BC6mNfC8irklNNYuisUKMuCw+Nvl58kRzm/YSlyYBXJQw6QifSpkdLQtIsram8C6D49WK6XJ0nuT6jh6+DfYDXE+YVAwN8Z8jhlnjAwVaDhEoWSA2hMFlOfNafxMiD03VyBd2aykw/p+VLs3XpQPpb6SaZroBwGlZoSGzpOU0102IsAnXo0IL75nCwPBux7ZPgKuOacXbTHEGtMFMi0Ct0M90cpL8GNXTshEcKJOkOhYH6hHcW8Lo8pPdEPTRsVQDWzKtRuIonur8p6rd1udFLeYWnV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f322c0f-2eb2-46d3-a30f-08d82716115d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:18:20.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6sesqVHATxcqcZ9o62IYRZKOpFfRB0BzTrJ2zfbqGc6SgcnRfEGg/Dc8OgO5jLJ4MEE1wXZLimHrziDXgkRaR3inmE9PQiufbcCNbMG3bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
Received-SPF: pass client-ip=40.107.2.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:18:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 18:21, Max Reitz wrote:
> Add some helper functions for skipping filters in a chain of block
> nodes.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h |  3 +++
>   block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index bb3457c5e8..5da793bfc3 100644


This patch raises two questions:

1. How to treat filters at the end of the backing chain?

- child-access function will return no filter child for such nodes, it's correct of course
- filer skipping functions will return this filter.. How much is it correct - I don't know.


Consider a chain

top --- backing ---> filter-with-no-child

if bdrv_backing_chain_next(top) returns NULL, it's incorrect, because
top actually have backing, and on read it will read from it for
unallocated clusters (and this should crash). So, probably, returning
filter as a backing-chain-next is a valid thing to do. Or we should
assert that we are not in such situation (which may crash more often
than trying to really read from nonexistent child).

so, returning NULL, may even less correct than returning a filter..


2. How to tread nodes with drv=NULL, but with filter child (with BDRV_CHILD_FILTERED role).
- child-access functions returns no filtered child for such nodes
- filter skipping functions will stop on it..

=======

Isn't it better to drop drv->is_filter at all? And call filter nodes with a bs->file or bs->backing
child in BDRV_CHILD_FILTERED role? This automatically closes the two questions:

- node without a child in BDRV_CHILD_FILTERED is automatically non-filter. So, filter driver is responsible for having such child.
- node without a drv may still be a filter if it have BDRV_CHILD_FILTERED.. Still, not very useful.

Anyway, is_filter and BDRV_CHILD_FILTERED are in contradiction, and it seems good to get rid of is_filter. But I may miss something.

[..]

> +
> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
> +                                              bool stop_on_explicit_filter)
> +{
> +    BdrvChild *c;
> +
> +    if (!bs) {
> +        return NULL;
> +    }
> +
> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
> +        c = bdrv_filter_child(bs);
> +        if (!c) {
> +            break;
> +        }
> +        bs = c->bs;
> +    }
> +    /*
> +     * Note that this treats nodes with bs->drv == NULL as not being
> +     * filters (bs->drv == NULL should be replaced by something else
> +     * anyway).
> +     * The advantage of this behavior is that this function will thus
> +     * always return a non-NULL value (given a non-NULL @bs).

I don't see, how it is follows from first sentence? We can skip nodes
with a child of BDRV_CHILD_FILTERED and drv=NULL as well, and still return
non-NULL bs at the end...

Didn't you mean "treat nodes without filter child as not being filters, even if they have drv->is_filter == true"? This is a real reason for the second sentence.

... and the disadvantage is that we may return filter node, which may be not expected by caller ...

> +     */
> +
> +    return bs;
> +}


I think, I can live with it as is for now. If we don't drop is_filter, I think it worth documenting these corner cases somewhere (may be near .is_filter definition).

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

