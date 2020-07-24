Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0258C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F15B20737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CTAYCx3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F15B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jywEZ-0005Za-9h
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 07:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jywDX-0004e1-R0; Fri, 24 Jul 2020 07:50:24 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com
 ([40.107.20.123]:56064 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jywDU-00047S-Jk; Fri, 24 Jul 2020 07:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCJC0vj+B2/dvSB323FOB0cWlG12kEUOcgTL5a7wPcHyJwFxZvXQemvTmB2+Z+2XqKJiZniWqcLigs4Jw8x+WBwOdGz1FE43HN4zPVq8YlULZbOSNh0nlQykp6MFly6Cd7xkPs5ZJXJ19MeA8Nvgzpb+fSvYDaaYO++sKClz7NmiLXETNUx0FtCy5sJeNVxW8lKGTTAN+3/gxpXNKXgqh3AAnwiV73ELSbh43L1sksy+tJFvqe36JfO6up+Hc3uVmEOV5GC5qelZtvvbpvcZWLsDwSdXvBU8LLgpc7xt6pjwXK8j4ihIGXU61m2OPNccttpsFXu7O+50rRfv2yV21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwdO5yInyWZmWDwfNW3JSTHXcumji4bJ7nVYs85fAOo=;
 b=NJ+cdEkJ4caPoeK/etPxN6ezU/00pD8osI7aaFW+seagt8VzlSYfx8tN81TKBhM/V54DTkmMbhLwPhkTNoSgZxw+TahdLF5E2dBUFYRqxISdKKJPfRix0FPulH4LdAmmNTS4WFUGOSeWi9DM6iuqOJS0GFw8rXmE1eNgJVqQfUtPBwo3ThFK+xuvSKNhQjaweW/j9mLa1/qLwnnIyid1PmyETG4BYF8S8WRwsk/80e/KAnM2Blk2jun6RshP9rzOBF75/nbnmOuzWw3BqhgpOxYHenRUpr5lx7GjNGoIU++TM5qMhOxni81wag8RqGNu39MSHbby1ERBSKQVxZhYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwdO5yInyWZmWDwfNW3JSTHXcumji4bJ7nVYs85fAOo=;
 b=CTAYCx3HaEnJyV+7xYmstDCV10soy3dBmUMD/urXgR0A4xXg+qNFy5aLdTxA47W+cA9RojeVCZwOXe+RcRtnehzKs3O8KsZTcqwIZcEkM8aYTXYB4mih/f4Z3McI5ODzBUmbU3icAgUjAZGuiwvlMbHaDXLH4OW6+xwzu0RBXqM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4168.eurprd08.prod.outlook.com (2603:10a6:20b:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 24 Jul
 2020 11:50:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 11:50:16 +0000
Subject: Re: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-2-vsementsov@virtuozzo.com>
 <7211b25e-94b8-de52-a2da-66f480af9a2a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9727dce8-41a0-256e-df0f-b11bd8219cc4@virtuozzo.com>
Date: Fri, 24 Jul 2020 14:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7211b25e-94b8-de52-a2da-66f480af9a2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 11:50:16 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e5093d-2f56-438a-28b7-08d82fc7bbb9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4168E0E842F92F038F974253C1770@AM6PR08MB4168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOov7P+AzUhSa+UHGPRmdd9osKxASjBtNXeGG2IHgjz7cnYXYxw4McxPlrHbMtKRNtBb0WvPYqtw87Xtw51SgRqtkM2kvBGPj1rgJhx3+mGl4uLVu7Rra28iVk/5WcdbJrNqfXBvo7QvOG5DxpIdDM/ksRs1pJSBmuWk3cXXX5sv/lOfiHg1OTOX572ijHgUe9ihXmVNlqRyAKAjqO/shVPl/ixuCMLwS8jEwG0K3bXaLn86FF4Sy8VMHtGMBCpNt0hSNj8dvgKMofFHopHsBUqO+IJ1mKKnuYlrcb+IidaNVJD0d0JNizaQYVcdIADMC7NXbpbDdMR1QGert3afIrszhzAzHyDBtbDCCkALxzJtR7oig+ur4OtvQl3jwCqC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(31686004)(186003)(16526019)(52116002)(83380400001)(53546011)(31696002)(66946007)(5660300002)(956004)(2616005)(66556008)(8936002)(16576012)(66476007)(6486002)(26005)(107886003)(36756003)(316002)(478600001)(86362001)(2906002)(8676002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kds7WAW+x6u8KD0eU9U1a9DjLrBYye8VujlAdlYdBnZZm5lkXNKGm+TxRamrdziCKhKkt7FkeZ0YHtiodfIGLT+Jm3lqPBxu9a5ctzXXwKzEH2+AF1FgF8ewVv4EzoF3/fnvyQmjPVJR7ZGv4Yh4iZc8ouwSaOPuPrcpn359VECDmdOURmU0xwTUT1HywYuhymrK0eW0VtLKiD5C18RaN6e3CnkH78tV8ITvO0iULhK0XY2ypZi5Z2BD/q95HtCpIvd2jzGOWL6k75QiFU3mJ86CHqUlR1xDb6fntL2JZljQRALS4F08KD6wWGdpKDr61/hCXs7A7MWqg+0AqCaon14FQrasZhNE57N5fi2RpCQD/Bf8do8CyKqWZ0rmXjtKfYBf/UjWruwKjk8KWs+HAphTtmFDoOxlaxmXPZj00JLBC/KOGMMhdYP9xw3g4SlASt/MymhclKeDHchlk+Dbh+S3WwBkYexslgLAu00PtvVk4+Uc+GlYNOzIGDLdXDYP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e5093d-2f56-438a-28b7-08d82fc7bbb9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 11:50:16.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8y/gG95q9euMjIzBtgG4JnGN8lSqlu7DTLXqdfUac5+Ze3mS/WPOwyxHWD5mgap7tu+hBMOnJUngzumZmXDalvSmBmqu4FzKBOS7f/kVKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4168
Received-SPF: pass client-ip=40.107.20.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 07:50:17
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.07.2020 21:47, Eric Blake wrote:
> On 7/20/20 4:00 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It should be to reenter qio_channel_yield() on io/channel read/write
>> path, so it's safe to reduce in_flight and allow attaching new aio
>> context. And no problem to allow drain itself: connection attempt is
>> not a guest request. Moreover, if remote server is down, we can hang
>> in negotiation, blocking drain section and provoking a dead lock.
>>
>> How to reproduce the dead lock:
>>
> 
> I tried to reproduce this; but in the several minutes it has taken me to write this email, it still has not hung.  Still, your stack trace is fairly good evidence of the problem, where adding a temporary sleep or running it under gdb with a breakpoint can probably make reproduction easier.

I've tried to make a reproduce, adding temporary BDRV_POLL_WHILE, but I failed.

One time, it reproduced for me after 4000 iterations, but other times a lot earlier.

It may help to start several qemu-io loop in parallel.

Also, iotest 83 for -nbd hangs sometimes for me as well.

-- 
Best regards,
Vladimir

