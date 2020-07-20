Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB5BC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D1E20709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v9apvYU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D1E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxQoZ-00011I-81
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxQnm-0000Lb-5s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:05:34 -0400
Received: from mail-eopbgr10129.outbound.protection.outlook.com
 ([40.107.1.129]:5604 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxQni-0007oV-Uq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:05:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9KUw+SFqwJLdFDOKMxQi1Qz4fW0dLuuTHTaK1UlZO71KZoFDeK7trfisi1Gm0Jvcx99gFpDQOKXLnnoBqiHrbOPOh16BpSWLFgbm0qjhqMbYS+OWrh2HAW+F+oPZn3ExOkMoOQIl7XRut2lXVeABJRGhIeUilJ3onJyYG+41oihFyslzITbkJ6JcxAT5xSvIOM5ccVY+o3VkCSafH83FSlSJlx7XPnW73FIMYUWObH6Qya2FV6uPaxxnRd+B6zBdT46JM2DKEaNifYG7S86G6gJEloFUJKX4fY74bN3oTl/kVHYQA1gPGhTEAkiuMAuOeHPnPHyAEkhY5/3neP3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3iIZPj9h3G7hmAk0WxR2yZVaQIFeR6ViB82q4eJyos=;
 b=HgtqC4wUNPcAbXo7za7A1iso/yb1Nb2KpxjzALtlm2Efhanp7y4zdml8EtjXFvo/uRysVI1QfM8A+u1hUSTfrXrJrA2RJbXu9rUVEDwbtgEzpiQogRW6tqMJJ4I6Xcf1JG9yLYgSaGM8r6bymx0EcJ2WRulZyhBmSvbifjURk6Yke+Nr6wYHdGZbqX+d9nsKuc+4/d2vPB02cUdWXAjyf/XRt4bXDKZXovzgYHVoqg/AsV7Z9ObLOM16ubWpbpZd4dtQPqbUkDcR1zf3OeCtmLyoNMUQqGg/ZQMpQEqECcPChUE7gOCX3FAqbfXJf/ZBfWbael/SvKjUxaNYwY0+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3iIZPj9h3G7hmAk0WxR2yZVaQIFeR6ViB82q4eJyos=;
 b=v9apvYU0n9XeZ55jwcw7AyNLtVSSeLBrHUgBYuqCY8j2CDcPzIJJ+S30RAuJXfYSkeQq6Mb8FnAOPg+F9oW4eIpbVBgy9ydHgFIyMdDtwF2xRYPYPbuSyX4CGTS3Pj8S7rOhD4iWoaNl3/AU3xQ6YicXmlSVcFYpCrMrIr8DN9s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3573.eurprd08.prod.outlook.com (2603:10a6:20b:4b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 07:50:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:50:25 +0000
Subject: Re: Memory leak in bitmap code?
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>
References: <5f14a0997a4e8_4e6d3fcbdd8e41b010815d@sidekiq-catchall-05-sv-gprd.mail>
 <16102b4a-160a-a400-a332-4477b83468d8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <90825871-7259-d516-e103-176d0433c4e6@virtuozzo.com>
Date: Mon, 20 Jul 2020 10:50:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <16102b4a-160a-a400-a332-4477b83468d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:207:5::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM3PR03CA0068.eurprd03.prod.outlook.com (2603:10a6:207:5::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 07:50:24 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 824a7e18-bb62-4082-4e40-08d82c818fc6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3573:
X-Microsoft-Antispam-PRVS: <AM6PR08MB357340803E6128F6D85ADFBEC17B0@AM6PR08MB3573.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/gwewLBCENa6/kIsIY70HBv0tqItqxUbtAZXChVyzqbfs5qGmBnjKUFH1rJQwviWg8bwJK2pJ1cU04EJRmW7+nxdVkZWJA/M6eWMFPHgBfXYNjqrAST4gj1FPvGs1JM9XtUIS3jFepIY0Mcg0XB5+HiZJyhcrf6fBBlmmAvPZ8X/P1ZQZe7NkrJbneuCoONMY0ldqx3bXTBKS4o2OgsLifZCxlzFbGB6G6SqIesvTpHVTnTGRJeEErQonHLHDSr92IJkB7nX9kcc7y2C5cv+qQlBnje8KbCVJi5kG+7QoJT7edmx4pzmbvWN887kT6TOlOZ1C4cuNPPrbbloGIDI3PLiildToAhE9iJX6tEqFq2z+7Y6G2orlsW22UCO+tPfSzLP7lT8GgyT6wJ05M3xr8WE3eFJITDxilIwBI5CAiz8wtUxu+pMW1Ax0Hw4QV+lXneMh3BJEHPBqdlcRULdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(346002)(376002)(136003)(366004)(2906002)(52116002)(54906003)(16576012)(8676002)(110136005)(316002)(5660300002)(478600001)(83380400001)(66574015)(66476007)(66946007)(86362001)(31686004)(2616005)(956004)(26005)(8936002)(16526019)(4326008)(186003)(36756003)(31696002)(66556008)(6486002)(966005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zKQk5KkPaN6vmguiyhZzhE72PLz7WC5GkRKErqkEmel0dhyRD7wXfGtfTpSQImNZUwD1fFdU9D0MUa5CK0Za4SHOCkgZicLwNL85+06vPbdgf0Hhkq8lWhLVS0ARUurFs1guRurKy6P4uBw/lP5mfS6NLVtWIlPclPggQTc0UyYn0lqH0xz0WEHhZSKRN4k2Usrer81ZyvPwGV+IX9UswkmZsSU30FVDo0CLztkH+M0u6/ic1C1xXOloud7JQ2Td5IHD7hpxqneBHnu0yX/ccamJAucBecX9t9mc88caGOazlI1VS/DLupDIZwgdR9nXfVnZMZONPY/f2y2/TsnU67+jn3gdGYuaQh0kGf1X/WcYwUnJaNvcG1IygQ/YyoKCsdyUExCl99PnPhwQHkXgs2sX4C9wvWXQI6zjWyywm3hcbVaschrsm35pzEID+PKePoxOyvD6kv7oJWxmoEr3cbNBtcsEk00ldsjTezZJEUk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824a7e18-bb62-4082-4e40-08d82c818fc6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 07:50:25.1160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJVQs0O9ZvKH/RUJOAayzpXxQ+Io9M0QB8GvvDdawbz5HV0dwBvzoWg87SpvMtYIe9RL6igOB7DyONPOItxmGDSnHrcKRtAZfwP7N4rtrK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3573
Received-SPF: pass client-ip=40.107.1.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 04:05:28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.07.2020 09:16, Thomas Huth wrote:
> 
>   Hi,
> 
> looks like the LeakSanitizer spotted a memory leak in the bitmap related
> code ... not sure why it just triggered with Richard's pull request, and
> I can also not reproduce it... But since there is a nice backtrace in it
> and there have been some bitmap-related patches recently, could you
> maybe have a look whether this rings a bell by any chance:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/645799805#L3282
> 

Hi! Hmm. bitmap.c/bitmap.h is a simple bitmap library, which was not changed this
year. The last commit I see is about a year ago.

So, I assume the problem should be somewhere below in the stack trace.

I don't know this code, but try to look at:

OK, sanitizer reports that we loose the memory allocated at exce.c:2219, i.e.

new_blocks->blocks1[j] = bitmap_new(DIRTY_MEMORY_BLOCK_SIZE);

Hmm. And where is this bitmap released? I can't find the place. May be the leak
was introduced in far 5b82b703b69acc67b7 with this bitmap_new()? Add Stefan to
CC.

> 
>   Thanks,
>    Thomas
> 
> 
> On 19/07/2020 21.35, GitLab via wrote:
>> GitLab
>> ✖ 	Your pipeline has failed.
>>
>>   
>> Project 	QEMU <https://gitlab.com/qemu-project> / QEMU
>> <https://gitlab.com/qemu-project/qemu>
>> Branch 	
>> 	master <https://gitlab.com/qemu-project/qemu/-/commits/master>
>>
>> Commit 	
>> 	9fc87111
>> <https://gitlab.com/qemu-project/qemu/-/commit/9fc87111005e8903785db40819af66b8f85b8b96>
>>
>>
>> Merge remote-tracking branch 'remotes/rth/tags/...
>> Commit Author 	
>> 	Peter Maydell <https://gitlab.com/pm215>
>>
>>   
>> Pipeline #168317253
>> <https://gitlab.com/qemu-project/qemu/-/pipelines/168317253>
>> triggered by 		Alex Bennée <https://gitlab.com/stsquad>
>>
>> had 1 failed build.
>> Logs may contain sensitive data. Please consider before forwarding this
>> email.
>> ✖ 	build
>>
>> 	build-fuzzer <https://gitlab.com/qemu-project/qemu/-/jobs/645799805>
>>
>> ==11111==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 2359296 byte(s) in 9 object(s) allocated from:
>> #0 0x5570060105d7 in calloc
>> (/builds/qemu-project/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x2bdb5d7)
>> #1 0x55700605ddf9 in bitmap_try_new
>> /builds/qemu-project/qemu/include/qemu/bitmap.h:96:12
>> #2 0x55700605ddf9 in bitmap_new
>> /builds/qemu-project/qemu/include/qemu/bitmap.h:101:26
>> #3 0x55700605ddf9 in dirty_memory_extend
>> /builds/qemu-project/qemu/exec.c:2219:37
>> #4 0x55700605ddf9 in ram_block_add /builds/qemu-project/qemu/exec.c:2268:9
>> #5 0x5570060611b4 in qemu_ram_alloc_internal
>> /builds/qemu-project/qemu/exec.c:2441:5
>> #6 0x557006061567 in qemu_ram_alloc /builds/qemu-project/qemu/exec.c:2460:12
>> #7 0x55700675d350 in memory_region_init_ram_shared_nomigrate
>> /builds/qemu-project/qemu/softmmu/memory.c:1514:21
>> #8 0x557006bdd127 in ram_backend_memory_alloc
>> /builds/qemu-project/qemu/backends/hostmem-ram.c:30:5
>> #9 0x557006bd9733 in host_memory_backend_memory_complete
>> /builds/qemu-project/qemu/backends/hostmem.c:333:9
>> #10 0x557007a20ffc in user_creatable_complete
>> /builds/qemu-project/qemu/qom/object_interfaces.c:23:9
>> #11 0x557007a2178a in user_creatable_add_type
>> /builds/qemu-project/qemu/qom/object_interfaces.c:93:10
>> #12 0x557007a219dc in user_creatable_add_dict
>> /builds/qemu-project/qemu/qom/object_interfaces.c:134:11
>> #13 0x557007ee7eb6 in qmp_dispatch
>> /builds/qemu-project/qemu/qapi/qmp-dispatch.c:155:5
>> #14 0x5570077452a8 in monitor_qmp_dispatch
>> /builds/qemu-project/qemu/monitor/qmp.c:145:11
>> #15 0x55700774411d in monitor_qmp_bh_dispatcher
>> /builds/qemu-project/qemu/monitor/qmp.c:234:9
>> #16 0x557008065c66 in aio_bh_poll
>> /builds/qemu-project/qemu/util/async.c:164:13
>> #17 0x55700800235c in aio_dispatch
>> /builds/qemu-project/qemu/util/aio-posix.c:380:5
>> #18 0x55700806a62c in aio_ctx_dispatch
>> /builds/qemu-project/qemu/util/async.c:306:5
>> #19 0x7f93662807ae in g_main_context_dispatch
>> (/lib64/libglib-2.0.so.0+0x527ae)
>>
>> SUMMARY: AddressSanitizer: 2359296 byte(s) leaked in 9 allocation(s).
>> /builds/qemu-project/qemu/tests/qtest/libqtest.c:166: kill_qemu() tried
>> to terminate QEMU process but encountered exit status 1 (expected 0)
>> ERROR qmp-cmd-test - too few tests run (expected 51, got 50)
>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:650:
>> check-qtest-x86_64] Error 1
>> ERROR: Job failed: exit code 1
>>
>> GitLab
>> You're receiving this email because of your account on gitlab.com.
>> Manage all notifications <https://gitlab.com/profile/notifications> ·
>> Help <https://gitlab.com/help>
>>
> 


-- 
Best regards,
Vladimir

