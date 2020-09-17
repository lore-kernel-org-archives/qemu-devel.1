Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283DEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AAF2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WLW+L7qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AAF2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpnq-0001oB-Of
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIpmF-0001Dd-5S; Thu, 17 Sep 2020 05:00:27 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com
 ([40.107.22.105]:12833 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIpmB-0002KO-MO; Thu, 17 Sep 2020 05:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp7nONj66kbY2vGIjCAKPfdPp1cG77YMLBRVgj+llAk1Vk5/HLBGNAKkpA0THTG3I3pTYrPS/6pP15MT/kek/mfDbwL2Hx27uCvqyiiE1aIKtJPqzmFtni2ouun6pBpJRt+or5bblU9U0Vaj6IPRHQQYqMqszbQYFVcOxlBaLYGiwn7Tmbs2hitVQp5sP43RwVqK8iEdRijPp1VjGIN2+YViy/BZ+x/1npxNxIfz5JUKdKOFouIa1WP29ee0L3Zw/Sfio1k4w0x4KOgJ14PhP+MHTjC6TYShIUSp6eR6OrfwJ350jwuzusSnxTeDH2sGz0zcsuuIhICqW4/hvY8yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd0O1c74XGP8OxjZSI0oTMxvoAAXk8yY6UtWY34JtWg=;
 b=ewd2dKQCR0ZpFHgDwNBFug7TRwGX7vZC1fSEAa40zzBuPJA/FdiLlus7Pej1aoLIkCcTgKFyeo7PmhU5i/DMolIlXn9N5G11Dm2omhbO6R0suSmo/lo0mS1/pJA/sPXVkisn3YL93MIiFz0nUCUhvAQ/Vil1Dc3mdkleOV8NJoRpXefh3bXRz4qnr6cv9SXWhO8pzEF9LKcean7Tax5TMJFGHiv6GYX+zoF9h3Cz1LcNLPWHIZL5yZ2N0Z87nwnC5UTTAEydCBJLJB3VXm/I1dgxX3lu/1SvaH4RNXM3f4UVfSEGCkjkOXEM2RgT8bgGlsUfYl/OOSYlANiRa75cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd0O1c74XGP8OxjZSI0oTMxvoAAXk8yY6UtWY34JtWg=;
 b=WLW+L7qxsTb6laLeKsDIMNvahqiyt53DUhEAgDgkWgHlpxP743TDqfT5KiROmKFBMLuoCOIasQtKK4QI9TndfnIvNd5A1idGEhpCDj6sepCRj5raMNmmt5ZQZx8UlBfnfF0qQK3LQ1pLJ1WPOb7eh7dQyk3QNkJODzoy2mlKDew=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3448.eurprd08.prod.outlook.com (2603:10a6:20b:50::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 09:00:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 09:00:18 +0000
Subject: Re: [PATCH v5 00/10] preallocate filter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org,
 nsoffer@redhat.com
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <3a810fb7-eedc-bd54-4319-f1862b5382c0@virtuozzo.com>
 <1c027e2c-651c-7077-09e3-f94c71c6dde7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <443207f5-b6e6-0e4e-e3c5-80d2fb0ddcb1@virtuozzo.com>
Date: Thu, 17 Sep 2020 12:00:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <1c027e2c-651c-7077-09e3-f94c71c6dde7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0061.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0061.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 09:00:17 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f79b0c4-aa31-47ad-7f1f-08d85ae819d5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34488126D45124F3E867E24DC13E0@AM6PR08MB3448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68oqziVjaLhwLpgYfVpKpRVczV3owodtWNhrzK285j9CqfdUns+Dq+wUM0jidb0nFKp2vyxl8uFgCgA8RicICvbmCmo0K2+DpK5NbNDtbpYtrSacvuXj2SqiV/4FerBMcKFPYLT9Yxt+OaGHhh/cJiy2C7tH/wvoTkUQ2opRVZ8u/SkYpnH5dTmyYIMqZVPUmlJPiBaUt+yMx/p9DbnVNRCPYzdtv+/bhGpggJu8pJF14ln7mvXYJG+9PSfxwDo5XP5rHamzLoJq4jpSRxUBIfVHMmB3VuWbhVa2FOmCBnAqELjfOc3BzVXIoNZrL07Zf6sAioz0uH2c3sHYk2LcXD+I64chhXmTAxPar5uYCXvkONTFka3SaxKP7NRu7MwN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39840400004)(396003)(83380400001)(2616005)(16576012)(8936002)(31696002)(478600001)(16526019)(31686004)(8676002)(316002)(26005)(86362001)(186003)(4326008)(36756003)(6486002)(956004)(2906002)(5660300002)(66556008)(66946007)(66476007)(52116002)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EKFNYIFu3dVSasvC2u9Av21hxN3WLlxKfdBqL193Toq7RT1mjvqJgDVjWuT1t4ndK4X5Jgr+ffeBXf9+hTl0KLDN+Mc3LYhxqnn8cwvW/T8uOU34GxsfIKUdQ82UbjUQWD/UgmyoZbIZzfLnTujd7mB+4Ar19SN1j+FfEuKMia18uTUGRoZjfRKhrEBoswVtXT56uZdO/3FbSKrbdHuLtec3h4wWILANH2fzL+eerjJPsZpHPj24iZ2pEhtcc9W0oail/t9XN3PCKni9WFq+BOGTquC7sKBDItoV0QUjOwAsjfC7czxQIEUnLTxGMWiLKTKxwp1F/wBB9FZU0Hg61kWMfUSkinZ840elH4GjbTJPXEppoCbTi8Dj1yTALwp+VYHSZovRyNk9K4hD4mYT2foNtNnZAtATArQFILAwc9Qx9/3Txih0LMoe9eYev68eM9T5lnPhZP5dcpJNSwAmjYmhLlk+llr+MpiA6YqCKJkz1orXSmBEaEinuRFKyHSyYbGnKToqRsc6YdSTbQffyhuNvUZfRzehSP0hcCz+xKL+wveLZ+wIjs1Q9z8xoPA24YEUV82C9P1lYm3jeGkP5jAalOb9Lb1agmmO0tX1L+cRkzSunsxQ24+mRb4vwSZZhvWmmzdGGRHy1kRlosR0ZA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f79b0c4-aa31-47ad-7f1f-08d85ae819d5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 09:00:18.9302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Piqtd0HF4/x3sqVFB71qnESRc/tHr91zEOeeYFKI1m9Xd22FZzS5JqXxTWno6LVUmDtVClFdPwXdyPjQk9wRxSNTd1EpLlN9HbCKKm6D0h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3448
Received-SPF: pass client-ip=40.107.22.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 05:00:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_LOW=-0.7,
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

01.09.2020 18:07, Max Reitz wrote:
> On 27.08.20 23:08, Vladimir Sementsov-Ogievskiy wrote:
>> 21.08.2020 17:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here is a filter, which does preallocation on write.
>>>
>>> In Virtuozzo we have to deal with some custom distributed storage
>>> solution, where allocation is relatively expensive operation. We have to
>>> workaround it in Qemu, so here is a new filter.
>>
>> I have a problem now with this thing.
>>
>> We need preallocation. But we don't want to explicitly specify it in all
>> the management tools.
> 
> Why?
> 
>> So it should be inserted by default.
> 
> Why?  You mean without any option?  That seems...  Interesting?
> 
> (Also like a recipe for reports of performance regression in some cases.)
> 
>> It's OK for
>> us to keep this default different from upstream... But there are
>> problems with the implicitly inserted filter (actually iotests fail and
>> I failed to fix them)
> 
> I would suspect even if the iotests passed we would end up with a heap
> of problems that we would only notice at some later point.  I thought
> you too weren’t too fond of the idea of implicit filters.
> 
>> 1. I have to set bs->inherits_from for filter and it's child by hand
>> after bdrv_replace_node(), otherwise bdrv_check_perm doesn't work.
>>
>> 2. I have to set filter_bs->implicit and teach bdrv_refresh_filename()
>> to ignore implicit filters when it checks for drv->bdrv_file_open, to
>> avoid appearing of json in backing file names
>>
>> 3. And the real design problem, which seems impossible to fix: reopen is
>> broken, just because user is not prepared to the fact that file child is
>> a filter, not a file node and has another options, and don't support
>> options of file-posix.
> 
> Well, what should I say.  I feel like we have made efforts in the past
> years to make the block graph fully visible to users and yield the
> responsibility of managing it to the users, too, so I’m not surprised if
> a step backwards breaks that.
> 
>> And seems all it (and mostly [3]) shows that implicitly inserting the
>> filter is near to be impossible..
>>
>> So, what are possible solutions?
>>
>> In virtuozzo7 we have preallocation feature done inside qcow2 driver.
>> This is very uncomfortable: we should to handle each possible over-EOF
>> write to underlying node (to keep data_end in sync to be able to shrink
>> preallocation on close()).. I don't like this way and don't want to port
>> it..
>>
>> Another option is implementing preallocation inside file-posix driver.
>> Then, instead of BDRV_REQ_NO_WAIT flag I'll need to extend serialising
>> requests API (bdrv_make_request_serialising() is already used in
>> file-posix.c) to dupport no-wait behavior + expanding the serialising
>> request bounds. This option seems feasible, so I'll try this way if no
>> other ideas.
> 
> Possible, but you haven’t yet explained what the problem with the
> management layer inserting the preallocation filter is.
> 
>> Filter is obviously the true way: we use generic block layer for native
>> request serialising, don't need to catch every write in qcow2 driver,
>> don't need to modify any other driver and get a universal thing. But how
>> to insert it implicitly (or at least automatically in some cases) and
>> avoid all the problems?
> 
> I don’t understand why inserting it implicitly is important.
> 

You are right. Thanks for strong point of view, this makes me to revise my own. Now I'm working on v6.

-- 
Best regards,
Vladimir

