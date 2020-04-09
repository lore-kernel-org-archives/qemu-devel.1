Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965CC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B8020757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M9wAumrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B8020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcER-0000P2-Gj
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMcCz-0007aM-Cl
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMcCy-0000Fd-7R
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:47:25 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:61605 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMcCq-00009w-NV; Thu, 09 Apr 2020 14:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJREU6yaD09lgBjWxSL2nBXkifdK87sC78Do+BH1YwNdXIaagQphI/DAWgfzL0UEglr4Y4lbM2Ht/gkKWSMSwKljgdYeVPkkcey/xi1fi2mwos3LqVEYhpu2F5chKa3IDfJNCxm1g8PfdWDjRKaRVcdNQxh3fkhSPLJJmAcGIarYAolTiMbWcnAU5B5rARqNujPLXrBq/RML7txo2Xdagzs0liGMXCTIbJb8iO4UCAx8UR+gdzWF8Ubn0EyYrIm4gmpQTMVzNDvoziE3Pk7NWPzrnqWEbIvWI3o60p71UO9awO5tOAUIEjKkGKyrG8V48hFIObJuKB50XOGkGhL2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBlIaDzw6j5oHxrv9t0eJD6F8dSfd0LL/49F4HXMjI8=;
 b=GzaktvSd7VizWYj0LdAfGReCx9ud9f1b7Z/0O3Gl+06YRizMqisTH+2VsoBtB7DUT0jWE1F34MfeKXP5iGEZtPra49gTzKTqky++EZvnL6LI7xnMJ38GPgkHJ+0XaZbULjjWVzMIqoEAAHIYQ3KaiDv7szpk/YaWmHZZx9mTPaND2qXNiFMGWue14mI7BEbq6qUC3C+k+VT4G7RE5Pz8mBeITyZIfLqHncNeLeFep0cJqHgAZWsBnHELuJOCJOgXSmZNCbLghpSrldKMzd0Dcansb7f7MFa2b5Vg8AaH052IYppMSIFgYnkhwynvanQ1ZDm9ZKfZPguYHUay4aue1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBlIaDzw6j5oHxrv9t0eJD6F8dSfd0LL/49F4HXMjI8=;
 b=M9wAumrruVcEoqOWDefoto6Bf6O20TBZIaTJC1eLWYp1BUqO47aqQaUovWukPdBvALRIQk0rs7zHTM7Cl7XYRJgb9HC+KlwRJr5RPmXztXZ/vMWgqMMDRBoHtWqtdmwyidCAbknrc3AFbS7zJmLpTxLb59Gf2bT61mW7k4dhpEw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 18:47:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 18:47:14 +0000
Subject: Re: [PATCH v4 03/30] qcow2: Add calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <627da7ad090c0b166f3d0294312d956fcddc5a2a.1584468723.git.berto@igalia.com>
 <6a3a60be-9d15-5005-d492-f350f1a150aa@virtuozzo.com>
 <w515ze83d8f.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409214704724
Message-ID: <01b68581-182f-a2bc-d280-ef58205a16e1@virtuozzo.com>
Date: Thu, 9 Apr 2020 21:47:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w515ze83d8f.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:200:89::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM4PR0202CA0014.eurprd02.prod.outlook.com (2603:10a6:200:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 18:47:13 +0000
X-Tagtoolbar-Keys: D20200409214704724
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145a4d5e-3d77-42bf-1449-08d7dcb66b81
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544526A8AE5F825916C53BDBC1C10@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:55;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(66476007)(5660300002)(66556008)(8936002)(86362001)(31696002)(2616005)(81156014)(81166007)(6666004)(26005)(8676002)(31686004)(16526019)(186003)(4326008)(316002)(478600001)(66946007)(956004)(107886003)(16576012)(6486002)(36756003)(2906002)(52116002)(54906003)(966005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKtsq0grp2nDbmHNxJ/m02gXLLge0M8s44SEpdfXY/i+nSP1h68r1C1ZC+iLBCTIuMowJoApnBkxae5fuS5oJlR5IEmh6evFflE3yfJDkSWYKT2vnFWQ3KueK/UST8YTQJiB6orEhzL5toTn4FRsVYKK0C6rpR93Ghyc/j9d0IKIZeMhUFelgIp+dCyLxLrLb3sFujzH925LSn1NOEG9+CIwGXZUgfdC4dRdwmuyL+W0TTxMx8uYV5/i8x02Ov7wdICHR1miLeg6djNQWWat4BCr841A9HOhBxClKvOa2XebhUG6j0V5Sq5pf/PLHP+V8dgNIEe9kNIWLBeOqVRfVYy4h+ELWX2ytw88XzqKgSd3FdN2WAwIy/d7sYGFe7ueVKyAcaqOlmSc4+iaL7BUrdKLrzjmuHX8zFQQMkpPmDo6vKNd861bFUG68UQ4JUMTGXVT4Ogeg4uUQE6F7BM6gmzPZD7+McMwVut15eGFnwAXV/bPkf7KYgJfQRLYv1UrKzxXKrM3AsfuQKZ/j5MJpg==
X-MS-Exchange-AntiSpam-MessageData: stlaKvzR6RYf1uXGDxIA2Jgjf8oxGJmr1APr1LAcbx3S2BJJVQ/t9x+cCX1zwHU1YMY3Tv0YrV+h3E9nV08UU0gr0PMO3zfcLCft4zZtlERLxClrVeCkjgsUVmdPYxqXrlkaRPipp39rc7imKHoP5g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145a4d5e-3d77-42bf-1449-08d7dcb66b81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 18:47:14.4722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuTSt0YuSEy3pD1nGaVEyl4GIo5brspjcrK979bgsG6W5uMTzDQ5iAnyemBkietAPWB+TwupGU+Gqp7TwmhCe45Jz3/UAFi1nAIQAucFGek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.107
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

09.04.2020 18:12, Alberto Garcia wrote:
> On Thu 09 Apr 2020 10:30:13 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> +static void calculate_l2_meta(BlockDriverState *bs,
>>> +                              uint64_t host_cluster_offset,
>>> +                              uint64_t guest_offset, unsigned bytes,
>>> +                              QCowL2Meta **m, bool keep_old)
>>> +{
>>> +    BDRVQcow2State *s = bs->opaque;
>>> +    unsigned cow_start_from = 0;
>>> +    unsigned cow_start_to = offset_into_cluster(s, guest_offset);
>>> +    unsigned cow_end_from = cow_start_to + bytes;
>>> +    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>>> +    unsigned nb_clusters = size_to_clusters(s, cow_end_from);
>>> +    QCowL2Meta *old_m = *m;
>>> +
>>> +    *m = g_malloc0(sizeof(**m));
>>> +    **m = (QCowL2Meta) {
>>> +        .next           = old_m,
>>> +
>>> +        .alloc_offset   = host_cluster_offset,
>>> +        .offset         = start_of_cluster(s, guest_offset),
>>> +        .nb_clusters    = nb_clusters,
>>> +
>>> +        .keep_old_clusters = keep_old,
>>> +
>>> +        .cow_start = {
>>> +            .offset     = cow_start_from,
>>> +            .nb_bytes   = cow_start_to - cow_start_from,
>>> +        },
>>> +        .cow_end = {
>>> +            .offset     = cow_end_from,
>>
>> Hmm. So, you make it equal to requested_bytes from handle_alloc().
> 
> No, requested_bytes from handle_alloc is:
> 
>     requested_bytes = *bytes + offset_into_cluster(s, guest_offset);
> 
> But *bytes is later modified before calling calculate_l2_meta():
> 
>     *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
> 
> More details here:
> 
>     https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01808.html
> 

Ahah, me again, sorry :)



-- 
Best regards,
Vladimir

