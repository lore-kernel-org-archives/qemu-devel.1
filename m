Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E887C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356D220756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vGUJp32t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356D220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakoA-0004vy-Dv
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaknH-0004RP-7y; Mon, 18 May 2020 14:47:19 -0400
Received: from mail-eopbgr150134.outbound.protection.outlook.com
 ([40.107.15.134]:63459 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaknF-0006Q7-69; Mon, 18 May 2020 14:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAho3JIZWOqNms0e+mlJO6BPhzC+Ss2+3XkNCkhvZDjKXBCPJjCPOAIc/OXov08/ttQ/Smmx5/d30auf3FjFaLrT7mABXpPdWpZNKPF5RZhPP/yyjnx222ZQHL6xMgNxqCzFkBWsQ8PMTuOzEBW1erEN5WiW2rCX6Oyfk+P4j+z7MjvInhDLVP5+3px/iYzf7dsYbs/rVg0yD8i4k0d4EaFX8rdxJMJElZ3uHQqotCdd2c3L9ef/ZOxnbcU+XRBr6hL8IA1JzE0P+UPz6dljvJ6BXWqrUtVL//aJuuTmcjzQe9u/jiD4k0Ow45bjubGFC2nO/uGXQhhfcJmzjEZ+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZCE5KYM2j9WcAhNGs7zZtU0yaac5BEWL0Ez6CyvZVM=;
 b=in4wSgPU1gmKx619ZTm5hkOBqwDzWOaE7dB1L0SRLnOhwUlFXhA14XCv79eMZmDIyN2fPJ7VaXJiWsrV0aHAoU6IEHYAl7A7T+HStF8212tBiRubUsJHBjzQ9LxcfU1eX7yKHDhT7iybjOzVzh7FUtKZL8q0QfOabaHJwwxUciUJKZkN96mbv1EJT1ee9UnyIpFX3/FDuDJdzHJIYdjTKDoMl0mBQGECRq8HVZNBaLKC41c/V3zHFgFNXZrhjBWB1BJhTb6won402RJZNHZwY8ykL+l5SU8ARQAvaf4F0rvDcb14qp8AYqkr0poRHaSsc1shy1KELcEv5uGMjCYvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZCE5KYM2j9WcAhNGs7zZtU0yaac5BEWL0Ez6CyvZVM=;
 b=vGUJp32tnPYZt0XSxzozGK+hUowlUwJ+F9HpLb+jpAZV+dcE8b4mqkSIgViH60qvF2Ykne8G3gRxEgECw1Q/IxoE61/APsDfdQz/lXwzsMLtH3zsReXjOqS/bDSJ/xjaDS3Ry8Xd7NCXNcvnSUEuPgHn19zRPpftMeV0fJCxBkI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 18:47:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 18:47:13 +0000
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Peter Krempa <pkrempa@redhat.com>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200518162648.GC2995787@angien.pipo.sk>
 <de0ee410-d5bd-f59a-6e20-0c10ccd54ccb@virtuozzo.com>
 <20200518182056.GD2995787@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d89ca3a3-00c9-1c0b-89a5-9c83f30545fe@virtuozzo.com>
Date: Mon, 18 May 2020 21:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200518182056.GD2995787@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR01CA0141.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Mon, 18 May 2020 18:47:13 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0cae79f-c6e5-4c48-e06c-08d7fb5be130
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5429859CD6FFCC7979DFF0B2C1B80@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7ojPxLFfl09dkJN+9x+Z8C4zXLIWx+KdvaTnz2DZuKgACuX9BFA3BfAagL0ejPfMmTMYaG7qHAuFdXLAKY0pWVvagC0wD7EjIH0vTxua8DTrTnJLltw+GZsjOMLRGXG+oj+3fQXyRiHzYWvAsN4e9+C2L3z7jWyi52vBgmgovGcQZ9nuPaG8ZcjN4C0OcNmnRE/mTqYPZ0JD7bXkli1eIjpfXYrdayE6tq3xru2cm+tCTgnUYR+ybNVAcZeut+ycnH/ykn8LcY4UiKDEuC19ZElpuujFUzjTo84H6zODmXn8+uk/pPijYCW011k6ZOVrM5PSS9xs8BCeF8xXkf35C9eQ7kRR8LPcL/vk8nLHizT1G4QYihKoI8NTNoM4OWbaPvO0zB0d5A3mJHZO9OZAl+/SV8BKtqGfN8a/PeDtpMMuXPVnHjEcP8t5Izc8cT3tPM/fihjFYYxpX3P0M9SKz5/MjBL9x879rCAIq5yVU+BvhjKDotysVA8Zl99KH6J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(376002)(396003)(366004)(346002)(66476007)(66556008)(2906002)(107886003)(86362001)(26005)(52116002)(6916009)(16526019)(186003)(54906003)(31696002)(956004)(31686004)(478600001)(66946007)(316002)(6486002)(4326008)(16576012)(8936002)(36756003)(8676002)(2616005)(53546011)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XTtNU4oGu8tmxOaP8kQVZhyAKyKBr49yYOdg23JnUSYsNIpati09rbMLjml1HUB1gsgYcwncHmdY479RRlwcTaDvopv3pvYAVndM9TwiuNhzp2VeJsiPYD2xchq9oQQS2/mZvzEWmMGezEQRPcXClkMDqsBYm8+OpQG8PcQAZ4+xISvVXAReCMwfWjAKVhwTi6nuMjEYyWONnhZJTBrEVNTTIpOIw3DxPpmwTxKbv/A3xtHm0N8UE0ppVI960E9tjpr9nx15Rohu6m3K1kCBaXT/isQv8UbvI4QkTCSwo0mc3lOS7HZ8HBevb/YgfVW6MQLyrhWVPkyiy6VDbCCfRhOOdOQ5sTWUo2xUJh+jmVqBKobVb7/NYQTL7FvZ8NtghGCu/H5vISf4zqUQ17OEOcBuDyXOMp8x+uvH3JD3EiHLUPerHJOjz3HfX7JSO7ejnwpCGckuFsoNYLWPzudc9IqFdjxuabFJN/LZdocxHcAL1O2Coqrz6Egh2pn0mlGn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cae79f-c6e5-4c48-e06c-08d7fb5be130
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 18:47:13.5872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtCXl+L0f4stLrwnzYT1DfTQ+0JpObo4QVwecoq9um45B4jkXYmFb+UrSG6LnuSId3zpyJ58XprCptpKvorX/UKUeHsuDmFktNdlrfApIbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.15.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 14:47:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 21:20, Peter Krempa wrote:
> On Mon, May 18, 2020 at 20:52:32 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> [add Nikolay]
>>
>> 18.05.2020 19:26, Peter Krempa wrote:
>>> On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:
> 
> [...]
> 
>>> Is there any difference of handling of persistent and non-persistent
>>> bitmaps? Specifically I'm curious what's the correct approach to do the
>>> shared storage migration case when the source and destination image is
>>> the same one. Should we also instruct to migrate the active ones? or are
>>> they migrated by writing them to the image and reloading them?
>>
>> About migration of persistent bitmaps with shared storage: both variants are possible:
>>
>> 1. if you do nothing (i.e. not enable bitmaps migration capability), persistent bitmaps are stored on inactivation of source Qemu and loaded on activation of target Qemu
>>
>> 2. if you enable bitmap migration capability, then bitmaps are _NOT_ stored, they migrate through migration channel
>>
>> The difference is in downtime: if we have a lot of bitmap data (big disks, small bitmap granularity, a lot of bitmaps) and/or slow shared storage, then with [1] downtime will increase, as we'll have to store all bitmaps to the disk and load them during migration downtime. With [2] bitmaps migrate in postcopy time, when target is already running, so downtime is not increased.
>>
>> So, in general [2] is better, and I think we should always use it, not making extra difference between shared and non-shared migration.
> 
> Thanks for the explanation! What about the inactive bitmaps though? Are
> they treated the same when opened? Should we consider them for migration
> through the migration stream?

Yes, we should migrate them, as even disabled (inactive) bitmap may be diverged with its on-disk version: user may disable it after some modifications.

And again, we don't want to save/load them during downtime. Another option would be implement a way to flush-and-unload inactive bitmap when it is not needed (e.g. prior to migration start), and do not load inactive bitmaps at Qemu start, but only later on demand... But this is another story and may have own underwater rocks. So, may be we implement such logic one day, but let it be separate.

> 
>>
>> ==
>>
>> And in this way, no difference between persistent and non-persistent bitmaps migration, let's always migrate them by postcopy [and we go this way (I hope ;) in Virtuozzo]
> 
> Yeah, that's probably going to be what libvirt does as well.
> 
> 
>>>> +# @migrate-set-bitmap-node-mapping:
>>>
>>> qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
>>> of migrate-set-parameters. Is it worth/necessary to add a new command
>>> here?
>>
>> Hmm probably, we should include mapping into MigrateSetParameters structure?
> 
> IMO yes. I think it also conveniently sidesteps some of the issues that
> were discussed in the other threads regarding addition/multiple calls
> etc. The mapping will be set at once and any other invocation sets a new
> mapping and that's it. Setting nothing will clear the mapping.
> 


-- 
Best regards,
Vladimir

