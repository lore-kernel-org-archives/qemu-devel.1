Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3FEC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB7E20782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y5ZQLQ58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB7E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBhP-00047n-Si
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQBfN-0002gv-5V; Wed, 07 Oct 2020 11:47:45 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com
 ([40.107.7.95]:52754 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQBfG-00075A-6p; Wed, 07 Oct 2020 11:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODdnZzC9tGrwUEABy36cf2Z2lmD8x3tHUL5tbpEu2TQmRsa4xMcG4muwH5SxlX0TyQCXja8ndmnvf7NNauzvCnoSxjkogT2ZFCQs9BFTvssd7mMBoW1ZYU7cNraD0ngaxnmIK365kp9y4g+aJPMJ/k3v6MvROVR127JdOLSqCYtUFVE90yIr9xoLIdK+w5jt8w/Nf41lYXqV5yUhi3gx2C4Mf6Kv3hqK+hqiT+fsDy5rOl/BDqTcOWax6EIRjrWyGc/L9lLFR2xnq9aXeR+bzVMQCw9RmyuQ9Ha+YlIjGeajlsS6UsrBj4DYWlH2Sdh90qPJ/R8eALeSeOBX4WNRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTqFiVBJCOW19G8e52mLhViB6aVt/lZ7AUasG83uPR8=;
 b=koQc/0m2f5JLf1QbCPSvnQymUaFzkIQw6oUoqR+8nUpkOm7iMDN3qSZWIa+csg1B/OBiCPFu6TaUnFXZl6gAHrPLjHbuAAz+3E1xMTjxJjfjPp3eOJZx5u0wsQ8D6hp3P6VR0WSlQFQWGEKqpbZk3zeyvVe9/nrTCGAlDG6j64x9axMenMee5w2/7Huv+iBurTtPeGr3StlFLvaINvmDlG/pR8QhBeQ75y2/zoSXegd6XjPlgxNvkZgB8NWlAvddj7zzB+t6Y9BOCqDVyvW0Drmpbf9vvlP1n+5/hl3Ksr8NUosMmTY9xhFWD4NO8Jl/rgVnxebGc+nk3oaEqKV4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTqFiVBJCOW19G8e52mLhViB6aVt/lZ7AUasG83uPR8=;
 b=Y5ZQLQ58TPLfFWgocJeEPKc3XM/INc/eZwQI+HZpRjU3U75SNgy+3rEXRBlvZ8zM5ZRUh3emmj5JDzSX+CZIWpYkOrqI9kooKeLGkBRriVRw2ukUMn0zQQAjBFtbk14NlXc+ahFtpyjAzYHeu6xdFn0v5NeDFlPaLnZTIB2FxjI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1971.eurprd08.prod.outlook.com (2603:10a6:203:45::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Wed, 7 Oct
 2020 15:47:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:47:33 +0000
Subject: Re: [PATCH] qcow2: Document and enforce the QCowL2Meta invariants
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <20201007115217.18013-1-berto@igalia.com>
 <f53af87c-15e3-4de5-42e0-213363759231@virtuozzo.com>
 <w51d01uavxi.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9105bbe6-dd05-4568-b2ee-9eb8f943c535@virtuozzo.com>
Date: Wed, 7 Oct 2020 18:47:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <w51d01uavxi.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR04CA0077.eurprd04.prod.outlook.com (2603:10a6:208:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 15:47:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93d4386-8308-4329-5112-08d86ad84e9d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1971:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1971E11F8B1429B3982053FDC10A0@AM5PR0801MB1971.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTjDI5ei71SqBB0OJLXeBboWJ4YJY/A0WP14lsLBFhL0HXoWQT/3one8JXZI4Oaf2sYnKewHHVZOUijYvK7s+sb1x+Jwv4vn/tTXiE67aijJbvdDRcDAcgbq0MaBgsuQevMw7CBg27mEm2qw8u9YAgEoj1JlFbuncWIkrAlSpZlv1MNxqkA3zH9hl/QtIr6IClWhutTq2bAIWC/K+EODxPz5NzWvDIvgJ/CVeiTaoD0tx8vE7usDrEZ0ULX+6jk+IP5zesNZxX5SGxgO8SnR7JHlUpTy3Io3Lcf6IJdEG7NtaGzNpcrIZevGth2mCvayB1KwJ6oITwDhrcnjPnbkxPKb55UTyAuZBThWTnWaRRNCY+OANphM/RzbTC9tshk2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39840400004)(136003)(346002)(54906003)(2616005)(6486002)(52116002)(31686004)(956004)(316002)(16526019)(186003)(16576012)(478600001)(26005)(4326008)(8676002)(2906002)(5660300002)(8936002)(86362001)(83380400001)(36756003)(31696002)(66476007)(66556008)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Xp3Mo4SiAREN9T/W/DGMrqLeRMemm84Rt3/e3fcaK1KM7V1FuhyPhJ96YDXphej31bgKf5/OfdzP3oJqmlIlFGHSHwuFFTuNfEkfG6+BqGmTm70T2o1e/rMyqXvKVZphUPIDZ8dAPphozqJlvVqM+j2YZv8EtV2cwsc3fZSw0G6BaB+UDzbK3FwlodvPRoDP5mYR6pvh7bP6OsTVgAV7BOPFCrmImDCOW1ghwme3Tk+uGV+dU2+O8+TOJZyIMqmirXeDC0N4WwzGW2pNpbdaJmn1JBtvRVvzj61AKYjEyJAmGwdDB2f57MR1wwb+sSnw0CKDPpsz1Tm3NxiDrhYpmO7HQnZ4YldAZAtaelTo7BoNdvxk2oFOr9SrzQMobxQjOYvGn9PoKksNTIy7B8xy6GKvl7LMHYNdF5dNAXijG2Y1hVxmL8OqPfp6e0AMDuaP+7cFGbNLrjlr++a9tC7odidqHPVma5iLRM4x7t69cSIfslAvifyvuyzHCZJWaDwEpkaCioxTVzGRiW/WALLsOgiol3UIgCp1pz7OQzBnJiqE/aob9j9ZKNZLKd9N55QRK2hKDk3J8qKJol1a+LaNOXMJeflG7jtDRaye2YSbWQW35LcwQcNJ3tz3pbNxsjPeFZJYkhps7eHDbHAnXNGvRg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d4386-8308-4329-5112-08d86ad84e9d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:47:33.8054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUbiLzLo7/UVMnaddg5iZPzBSmr2Nmq9Mx+Fm8532fM/NoDMO+H9c1vPv6QbtFBpo8ojAsA01YBV8OGEuFsOtc3c9Eli1OxRaJqnrw0rUao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1971
Received-SPF: pass client-ip=40.107.7.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 11:47:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

07.10.2020 18:38, Alberto Garcia wrote:
> On Wed 07 Oct 2020 04:42:37 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>        /**
>>> -     * The COW Region between the start of the first allocated cluster and the
>>> -     * area the guest actually writes to.
>>> +     * The COW Region immediately before the area the guest actually
>>> +     * writes to. This (part of the) write request starts at
>>> +     * cow_start.offset + cow_start.nb_bytes.
>>
>> "starts at" is a bit misleading.. As here is not guest offset, not
>> host offset, but offset relative to QCowL2Meta.offset
> 
> I thought it was clear by the context since Qcow2COWRegion.offset is
> defined to be relative to QCowL2Meta.offset
> 
>>> @@ -1049,6 +1049,8 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>>>        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>>    
>>>        assert(l2_index + m->nb_clusters <= s->l2_slice_size);
>>> +    assert(m->cow_end.offset + m->cow_end.nb_bytes <=
>>> +           m->nb_clusters << s->cluster_bits);
>>
>> should we also assert that cow_end.offset + cow_end.nb_bytes is not
>> zero?
> 
> No, a write request that fills a complete cluster has no COW but still
> needs to call qcow2_alloc_cluster_link_l2() to update the L2 metadata.

but cow_end.offset will not be zero still? I suggest it because you actually rely on this fact by dropping written_to conditional assignment.

> 
>>> -        /* The end region must be immediately after the data (middle)
>>> -         * region */
>>> +        /* The write request should end immediately before the second
>>> +         * COW region (see above for why it does not always happen) */
>>>            if (m->offset + m->cow_end.offset != offset + bytes) {
>>> +            assert(offset + bytes > m->offset + m->cow_end.offset);
>>> +            assert(m->cow_end.nb_bytes == 0);
>>>                continue;
>>>            }
>>
>> Then it's interesting, why not to merge if we have this zero-length
>> cow region? What's the problem with it?
> 
> We do merge the request and the COW if one of the COW regions has zero
> length, visually:
> 
>   1)
>      <>                      <--- cow_end --->
>      <--- write request ---->
> 
>   2)
>      <--- cow_start --->                      <>
>                         <--- write request ---->
> 
> In this case however the problem is not that the region is empty, but
> that the request starts *before* (or after) that region and that there's
> probably another QCowL2Meta earlier (or later):
> 
>      <----  1st QCowL2Meta  ---->         <---- 2nd QCowL2Meta ---->
>      <--- cow_start --->       <>         <>       <--- cow_end --->
>                         <---- write request ------>
> 

In this picture it still seems possible to merge "write-request" to "1st QCowL2Meta",
keeping "2nd QCowL2Meta" in separate.. Or, in this case we should create additional
relation between these metas? OK, it's not so simple, thanks for the picture.

> What we would need here is to merge all QCowL2Meta into one, but I don't
> think that we want to do that because it looks like complicating the
> code for a scenario that does not happen very often.
> 
> Berto
> 


-- 
Best regards,
Vladimir

