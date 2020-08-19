Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B6CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA4F206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sc59IJoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA4F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Kbx-0005MT-0X
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8KbI-0004oN-93; Wed, 19 Aug 2020 05:41:44 -0400
Received: from mail-eopbgr10090.outbound.protection.outlook.com
 ([40.107.1.90]:44529 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8KbD-0002xo-Vk; Wed, 19 Aug 2020 05:41:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeoEeSR79cOfmQOYbi24lJXEU+Bcq1JEKJengAf7ueXCgUWsYYjRiYxA+NOe/Xmb3RG8x5zzvi25avqwhbTRC8laVyyJe/stUF9oKOOBkzhmKg5mGK1/Dw4m0Wwm8FB8mp7VLhLlj1QFTAU8lFWRGeE66HByqJCe06hQehJR2n70MJ9Oau8Bimii4W8/9VitCQHCebvGPp8zf5LXvjQMTrj+QkKHKFQt7iapAmvjwoYnRHBVLGvpXfDgb098bCV+segVR9pQ4KAyZzn9boeZlTO7oIsqYV4nPPoXmNCLV7w+wD3nGcxvmXnqCnQhRfGePJug/QTJXz+DRJU34w8wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXi0JLL75q6zXOpdr/8AHBVVYggRnGNHuVRqWTZGws4=;
 b=PKW5YEl4hAXuiagojtKj6iovE1ShdXe9RC+WnNEJ06BFD1cjMzrDq1t4e5SzNh2ZMvfB2qbUzWQ1UMjjNVjfqFcvJRToePX1oxKTA5Al8/4638FaZy660VavKMkMrIv25tov0/dDHsslTaqWDbuCqbYDLSIF3AobbenzFs7qrFvqMYI1gOJeKrcTBPDLs33Hs6NltNAhypUsEiZtzyoYeD3fRbg1PJEAymX9gSxiB6AELbmxVpIqgDmwEceM1FF1gsGmYz+9p+Zrf2rIHIHH6pLH1aZH0oHovQkb9tNmbLaFmXRh6Rsa7YVRWmWJHcqFZbjzclwWmuCsfRbHHKi6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXi0JLL75q6zXOpdr/8AHBVVYggRnGNHuVRqWTZGws4=;
 b=sc59IJoIocUAQtG8GFLp2pY6NjN5jOHMT3roLYVftg75I2XrRVBDc+h0/byZCNQUm3h0Y+uVQK2ZmiNyRbuQsSSAyQiJ7y7sVKEp3mVNttq8S40DMpOFFHHDEAmPeH77SoDDZZvOZVa+y51PSlX44mRxWKMNQgm9HbKsZF5OIho=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 09:41:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 09:41:29 +0000
Subject: Re: What is bs->reqs_lock for?
To: Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
 <2c237be3-7e28-f61a-d339-5765089fe65c@redhat.com>
 <e6d75774-300d-c38d-3f07-0cbc39aff54e@virtuozzo.com>
 <8d337bc3-e3a7-d941-aa70-642f9ce0fcbe@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <089f919f-01fc-447d-be84-6e269fc16e54@virtuozzo.com>
Date: Wed, 19 Aug 2020 12:41:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <8d337bc3-e3a7-d941-aa70-642f9ce0fcbe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR10CA0018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 09:41:29 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c77acb07-3cac-4e60-ab42-08d844240cc0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448CF982B4080A8DAD52E13C15D0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+gI+IjSrbFCSHiELGQ5J2RTk8Jxokzmxeh6s6nZPH71rnYdTn2YSh0pQcBhE40BvyqUhpELLZUklLEMWOZcUv0YxusNV3wfzt9hOqBb7S2Jo2H9o9sdH/1uYGQCtrzSbTq4GLEKHKx5VhSmu3zCwgCM0PUOM7aupU994uWsD62imrvzpJ1UxqXuSQ0/rp/k6QNbbUtrfkmw6Yoi5/hg+6AxiknAXqf/wiMyFwvLVUkaWgs3GyLku7RRUhudgvrlCHtyTBiTaHJJcwt/5SMivNZyLWK/Fz6OOqJJPIfsTPHD8DuUxy0B03t1eyAgU6BhgTphhGIywAgdE4x+vZRxVGE1I2o/GtKVGkxAZ/V1OQSrFDoBscgHOxkC4qANZzb1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(396003)(346002)(376002)(136003)(478600001)(956004)(54906003)(316002)(110136005)(66556008)(16576012)(66476007)(31696002)(66946007)(4326008)(86362001)(52116002)(2616005)(83380400001)(26005)(8676002)(53546011)(5660300002)(36756003)(6486002)(31686004)(16526019)(2906002)(8936002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GoXFpZMkjSOAraydaZfoue/yh/CEeLgq2TLFY2gTXmaUnbDTb6y0EmEeIWByFmeMY+fLPJZJmK2m7UE01WB0aCdaYRXnYw/Ih+dGWPRoJiWdShbLkyM8mpllbsctpz9pUQcxGyi69SxQMw/tsHzuBGJwxjqqZYCZwcDNupnnZ5sbcPo1pegMIQLQydgB2dBV9gq9iUzS/loPqoUejHECThwgjhy2bg3J5WV0JlXvl3TJ35n45QbcAkxYUmuhihiqstOksKZpBtZI1Hlo0GA599UisCDsAT2Ra4r5yH60FlkgcnH3JaBfFOxtLAsRdNSty+ndkbNP3S6zinPXAmF7EOEOzE1pwQzTpBnonqwrEjcEE3Lxw4Yo35dkgtzO4WIvX8I9Wd5UlTOMtLZRce61c7d1cHBGnW9oe/lv6SR+eAnuQ7SrrsnLPAM8CrbPuKObAoLTmjECcCljuygviQZz5WSpCtms7eQZUq5ZFUKew1PhJ+zGWzfYZfH+6MnXz8jQsNUloxBLYfi7iC5ikfwCp5Cr2CAGhgjri15YUT99FgSX/DiboaraSp2z+xibeNQq/iNyJ8Gq5gKCGPQM7STrkw6Trl4ekCDHK+IYeZ7hSeDT5isODYB+3yaG0uT1jL6umUqrd9HSKP2wdsXMiRmvcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77acb07-3cac-4e60-ab42-08d844240cc0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:41:29.8450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtJrnCJszaS4aIyC2vaHtwE/iCx4cmMDfyZGgBFcpEzZetYW//YUclKoYrV24JKngnlnC+bJttwT6scgP3hg/d2yUHzHJYHnNyHtREY+SYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.1.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 05:41:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.08.2020 09:16, Paolo Bonzini wrote:
> On 13/08/20 18:34, Vladimir Sementsov-Ogievskiy wrote:
>> I thought bs is attached to one aio context and aio context attached to
>> one iothread.
> 
> For now yes, but with multiqueue there would be many iothreads sending
> requests to the AioContext.  The BDS would still have a "home"
> aiocontext to request socket readiness events, but
> io_uring/linux_aio/threadpool requests could be issued from any iothread.
> 
>> And all normal request processing of the bs is done in this one iothread.
>> And when we need to access bs externally, we do it in
>> aio_context_acquire / aio_context_release, which protects from parallel
>> access to BlockDriverState fields...
>>
>> But you say, that block/io.c is not protected by AioContext lock..
>> Does it mean that everything must be thread-safe in block/io.c and all
>> block drivers?
> 
> Yes.
> 
>>
>> Are tracked_requests different from other fields? A lot of other
>> BlockDriverState
>> fields are not protected by any mutex.. For example: total_sectors,
>> file, backing..
> 
> Rules are documented in include/block/block_int.h. 

I should have guessed on my own..

> It seems however
> that never_freeze was blindly added at the end.
> 

Thanks for your answers!


-- 
Best regards,
Vladimir

