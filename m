Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7445C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFEA20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q2uEbtiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFEA20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRELq-0006pz-Lo
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREKY-0005Sy-1n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREKX-0006wx-In
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:18:17 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:5510 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jREKU-0006qb-5j; Wed, 22 Apr 2020 08:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5lkAYvjytD9ZL82bCVguklnUFQW2wvnfnfVLbVO7lct7xG4rwMa8VUahIPiPhD7wlfiDlpoUhoo5+kNLi/rj6/49APsIjXZbz0GrkDXmVKkGkduhuOeU/Hc7UZ3c2s8ZCWdSJdPKS9V93mZgERiqtmPb2NYx1Z7eRHTcEqaEFMx8JeMZPdptj3cyvYXA6Y5IhZjf2Tb9n+JqTY8Hxizt4HlftN2a4jVDnFUXxaa+tfU5lWqII296eb7UzfI8HYaDR4wUqpYpcfTq1OMKCqg0UQ0M/ZKcLXC+K87JLfSrOyqptBVYM9WD5jZ3O8UM4oLolaD4dwf3yw6nT6V2QaiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJqNkPxML+uIUhahwgJu2EtZHmfIwYlD9zINCUIgAkI=;
 b=j/l48nI9+EkBFavRfzhLBM/UMcu9zOuxuBGqdLYYLteGxBICFL4EB9sb8g02XCQQJn6WlWre7/jQz4v+lXOZobs5CqDwqjMARzuxr28br/bGftpVx8mrBShjKmKUYwsL+Yehv4FK2Y3mh1Yriva3UVmQt9KuXWB6QiQxHZfDaTGuXJhKwjh8KFSM9uafgfLKsE/hmHMq2BkUURBUCQjuge1v6vpMxneEtNQSwiytsjTTGRaEn8bpadAFcUPMf8UUmOH5DIu6sEAEp8pwDuXILvz446mc2sdDL7qNHmFoovT0/I9TMu0BJO9dSaCO+LFlACnNB90gos00Chm943+sWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJqNkPxML+uIUhahwgJu2EtZHmfIwYlD9zINCUIgAkI=;
 b=Q2uEbtiC0bJNbXGiEBatoLOdnsMk1PKvkGfhKSjKEan9XT+4+Pck8kvIXG+0hLKXeKmzjW7XcAShm5LT4V2ghjYa7ounnSgJ95xraEHNNfIfpbUCRMGZHuq8k6KXZ0b0yzAoWfUNqT3ykQkXvGIUTKWc8gIXG7CfFACUlk2uqW0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 12:18:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 12:18:10 +0000
Subject: Re: [PATCH v4 18/30] qcow2: Add subcluster support to
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <1cc780f735044ac9138808234589d2c278c9cfbf.1584468723.git.berto@igalia.com>
 <b3f2ddad-2053-0839-ae97-3d886790a131@virtuozzo.com>
 <w51tv1bsplx.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422151807112
Message-ID: <b44d1bb3-d838-cd66-fcf9-7419e694e9f2@virtuozzo.com>
Date: Wed, 22 Apr 2020 15:18:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51tv1bsplx.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0059.eurprd07.prod.outlook.com
 (2603:10a6:207:4::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM3PR07CA0059.eurprd07.prod.outlook.com (2603:10a6:207:4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Wed, 22 Apr 2020 12:18:08 +0000
X-Tagtoolbar-Keys: D20200422151807112
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb15e48-35a3-41ec-b7d0-08d7e6b738f8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536618DD5EFE8DCF1A64F3FFC1D20@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(478600001)(107886003)(66556008)(66946007)(5660300002)(26005)(52116002)(66476007)(6486002)(8676002)(36756003)(81156014)(316002)(2616005)(4326008)(956004)(16526019)(31696002)(8936002)(186003)(54906003)(86362001)(2906002)(16576012)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXNtPxOqxjvD31I7N/6POaPkWhSV3/kL9YdDp79EQuMevNtTZBnphJy8oO+zr6svgbMJknUaLiEfxH0MpFQ9Q/pb6wusmDWwU2PJpHvTlglsYDzi+RcWv8/qveAxEl9hm4Nlm0+oKBzqH40Kx25YNjCsSAOvtbVRufx32J2c+MNXDTa6/IJAbhLRazevLf+jfvzKnQ7UhNGYvNeU78FXVBPUyb9+4vJNhmxm+FH6ljtr73lpJkJY93gTkjxGayTQTk2SI9o37NZqLLGkjZEvSLnMRPxFnuD1xHflVUqjdacBlQUE3nFM+IHQf4EYBA9fONKQIt7tK/go54a8eu8bq++euZ7QXEh9xnUevTrJ5K9yvgkGywo1pQv86TOu/q1t2+vPuOaUQF34f5JSDgNaSHGT7dJMmMqXnxPD3ySAC9uOT+T2R3fLnE1rjpeswnG4
X-MS-Exchange-AntiSpam-MessageData: 57hT60WCUSB8Gq/bjlqZdLie6Viapp6WsnUIpoj2NjGvuIzm+QXpY9vsi9SD17yOYz+iGFhXnO6iJWLSf5DiDAciX/DFs36DMCQzr09TTFxAVROobad6viQ8911IESmlKQlMKzq9GtRtD082e4PNcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb15e48-35a3-41ec-b7d0-08d7e6b738f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:18:10.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocBqhLtn5TaiBjTcF4XR812N+3gNJLscml1J5cNwdwJp/btctrpOsq86b4ho831fNRm3+IV8nE9o7DVaX81Yy3iXjpuMX8DV0Aonk8RLXjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.3.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 08:18:11
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.101
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

22.04.2020 14:54, Alberto Garcia wrote:
> On Wed 22 Apr 2020 10:07:30 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
>>> +                                        unsigned sc_index, uint64_t *l2_slice,
>>> +                                        int l2_index)
>>>    {
>>>        BDRVQcow2State *s = bs->opaque;
>>
>> preexist, but, worth asserting that nb_clusters are all in this
>> l2_slice?
> 
> Ok.
> 
>>> +        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
>>> +            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
>>> +                goto out;
>>
>> why not just return count from here? And then you don't need goto at
>> all. Hmm, may be out: code will be extended in further patches..
> 
> It's not extended in further patches. I generally prefer having a single
> exit point but you're right that it probably doesn't make sense here.
> 
>>>            /* Compressed clusters can only be processed one by one */
>>> -        c = 1;
>>> +        sc = s->subclusters_per_cluster - sc_index;
>>
>> should not we assert here that sc_index == 0? Otherwise the caller
>> definitely doing something wrong.
> 
> No, no, the guest offset doesn't need to be cluster aligned so sc_index
> can perfectly be != 0.

Hmm. yes. The only caller actually doesn't call count_contiguous_subclusters for compressed cluster case, but it may be refactored to do so, and then it does

   bytes_available = ((int64_t)sc + sc_index) << s->subcluster_bits;

so, even if intermediate sc is not very meaningful for compressed clusters (as we can't access sub-chunk of compressed cluster in any way), the resulting bytes_available is meaningful and it rely on sc being exactly what it is..

Ok

> 
>>> +    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
>>> +    case QCOW2_SUBCLUSTER_NORMAL:
>>> +    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
>>> +        sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
>>> +                                          l2_slice, l2_index);
>>>            *host_offset = l2_entry & L2E_OFFSET_MASK;
>>>            if (offset_into_cluster(s, *host_offset)) {
>>
>> Hmm, you may move "sc = count_contiguous_subclusters" to be after the
>> switch-block, as it is universal now. And keep only offset calculation
>> and error checking in the switch-block.
> 
> That's actually a good idea, thanks !! (plus we actually get to use the
> QCOW2_SUBCLUSTER_COMPRESSED check in count_contiguous_subclusters(),
> which is currently dead code).
> 
> Berto
> 


-- 
Best regards,
Vladimir

