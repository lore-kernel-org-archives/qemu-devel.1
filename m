Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D67C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B7B2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uwjj6++E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B7B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKrb-0005AV-0a
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKqc-0004Kr-Tu
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKqc-0004nr-1O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:39:26 -0400
Received: from mail-db3eur04on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::700]:52803
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOKqY-0004jB-EY; Tue, 14 Apr 2020 08:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDCJe/yrxjlBhGm/Xn1qzjyE7X96ORg37uAUcYqd8XyYQ0eUTIxsGKfm9hHiwN2Xzp4dsW0U0v49tA+GOiyHjlfdWwQMrFgrbw7HCAprm6bocx1foFNhFcKLehoh2/ovU/vb6DAiaGvcwLUJqnywBNkc4DKt692PMGozyNgTrXhH24nxH6rvjWJgS3yrpMMR17ybhYuDYeLQUEtggeJamelp/nz354nt2gMIOZDb4QN1A9007Xg7oK+QgcQTxU81IS5Rlerwzxp6IQghqN+xFDkq+nX/cciaboEpIJzbswzmGuQEbftwO6VGa/yLLN+wDvclFvHvvtWtIa99obrPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrZoHjAIPqgtPK6EuovedyBdDhHTBtInlYizI/otFTA=;
 b=H9H0P0nQ5e/PfiEBGU+x4fJv3rm9q8tlwZxbQOZeHE0eamVxTzACza7SmQmJ6NASihtgYuaotGJoXGbjVDULZpxoBoFST1ZndmTomeooT9UU9jppk5wNB3GPzoE2sYXM4BzKVv7ke8+XJXbGl6dDCemROXNOZIIXb5nsZgIGF9xIJSm6sHRRDE+pQo/+w6FLSFeTx8a6LpxJqTmRU3penfzDvbgSYrUk4L4si0dNtmWumHoSt2JV+671E8N+MhNhPpopNA7f5luUKFZP4lZ9Rwvyc3sHQQZqNR0QlFR6fdyq0mWvZN6pPZakkWpwPt5+2XXaw0A1ccCu+dXlRxGZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrZoHjAIPqgtPK6EuovedyBdDhHTBtInlYizI/otFTA=;
 b=Uwjj6++Ep0BRID5RaIJNAC0BV9EXbqyMf/sMNOe3wLIKrQPksCJcszaAU27N50sWpeRNCYqqOs0dxLkaKYu+LmwvuLynt2hW8rCheZV2kb0y5actP7DVoLbk/+4JYFg8hA6EtIOXhmh2GmRQzUnq2Gtn3BzZd6h6nb6oogtbltM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 12:39:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:39:20 +0000
Subject: Re: [PATCH v4 11/30] qcow2: Add l2_entry_size()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
 <58d1fa17-91ea-9f8d-c39a-4141783d1234@virtuozzo.com>
 <w51y2qy5kd6.fsf@maestria.local.igalia.com>
 <9695a347-b490-12b2-8a01-09ad8bdb8eb9@virtuozzo.com>
 <w51v9m25jrh.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414153918021
Message-ID: <625013cc-c646-2a7c-283b-ae30e49bb078@virtuozzo.com>
Date: Tue, 14 Apr 2020 15:39:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51v9m25jrh.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.20 via Frontend Transport; Tue, 14 Apr 2020 12:39:19 +0000
X-Tagtoolbar-Keys: D20200414153918021
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b244e74d-5c1e-4baa-e696-08d7e070da2e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54474AAB9E47AEE0AD51E84FC1DA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39830400003)(376002)(396003)(366004)(346002)(136003)(186003)(316002)(31686004)(4326008)(36756003)(478600001)(16576012)(16526019)(6486002)(2616005)(107886003)(54906003)(956004)(31696002)(2906002)(66946007)(66556008)(5660300002)(66476007)(81156014)(8676002)(8936002)(52116002)(86362001)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVnBpjayAOBcsMY6g1VLgf2WL5YucrlMnqWYoWdRE0nMBzc0E33lPLgczUsXSridY5ZKtzDUz9u6VUvPJcfXYppCDdL8RVt/1jxD6RpZb+bR+A8mEs7Wr48/Y+gAEkzlPNpTJD7nxRkeOgkh88AhhcSowS73YYGbTkz6m9u3RmXlm0RyVj6S+WpzumwUgkGddNtoeaZYYBiNz+xH/m/X5rFdzNjnzA/N3Cyom+zpYwAktBEof3x3tn9cHDSEXjL0d4T66VORZAT+DqKiEYc2FEvhwX3zgBKK1PQmlzLEpZpLp2JPET7vZ+QqEH1n1LqKMl0ywOZiGYHH4kk/PYSTxtY2/SmguGo9MjlM79bJ26kMxlYujRsXhrtHCLT1z8cLeR8Mv2mEO7PDdgR0JCg22KMD3kKKt0rsPXmfiwHJs/HFnUaSBGpVH+sVW3DvMnsS
X-MS-Exchange-AntiSpam-MessageData: od21mNBZNJhiSAdqGEJ/oeSMmiCX0EBpojNvlsLyz4AHKAEh89bu92WtVDXwCTHe9w0BnX6LD1NIHvY+3LGh0kyuWyJ1rOn5hUP3XRiSlfJMBb7TSrU5Rb7ZSUcC8FbEjQcoYPf7IYj2WyY4ELiBbQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b244e74d-5c1e-4baa-e696-08d7e070da2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:39:19.9243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n0V/9yL315pOgY7KDVfKYs2DPQ74RklLDz68opCNgclwgc8bivbW6Gd0mdmH4IMdTwrKTZegUNvLycjSn1iV8R//l89a8eH/k65vaYtIlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::700
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

14.04.2020 15:33, Alberto Garcia wrote:
> On Tue 14 Apr 2020 02:29:13 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hmm. How to avoid it? Maybe, at least, refactor the code, to drop all
>>>> sizeof(uint64_t), converting them to L2_ENTRY_SIZE, L1_ENTRY_SIZE,
>>>> REFTABLE_ENTRY_SIZE etc?
>>>
>>> That wouldn't be a bad thing I guess but, again, for a separate patch or
>>> series.
>>>
>>>> And all occurrences of pure '8' (not many of them exist)
>>>
>>> I think most/all nowadays only refer to the number of bits per byte.
>>>
>>> Maybe there's a couple that still need to be fixed, but we have been
>>> removing a lot of numeric literals from the qcow2 code (see for example
>>> b6c246942b, 3afea40243 or a35f87f50d).
>>>
>>
>>
>> git grep '\<8\>' block/qcow2*
>>
>> shows at least
>>
>> qcow2-cluster.c:            s->l1_table_offset + 8 * l1_start_index, bufsize, false);
>> qcow2-cluster.c:                           s->l1_table_offset + 8 * l1_start_index,
> 
> I see, worth replacing with L1_ENTRY_SIZE as you suggest. I can take of
> writing the patches if you want.
> 

That would be great, if not too burdensome :)


-- 
Best regards,
Vladimir

