Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733CDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393F020729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iPPA3wsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393F020729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0A5A-0003QC-9E
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0A4J-0002ob-Hb; Mon, 27 Jul 2020 16:49:55 -0400
Received: from mail-am6eur05on2138.outbound.protection.outlook.com
 ([40.107.22.138]:27104 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0A4G-00042B-DW; Mon, 27 Jul 2020 16:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRVNw+7yrLizZ2v83dRKJ3upEgSD94m2lSMHI4t62G0Fxxz4c3FwrP+HQwJ0f+K84CHrczTSCeRqPeYBcrQmUMtan8MB1H3opIIwFJBpv+3yTRj3K37UyqW3qWd/VzRpkDo4rfBGqElZabRNQXnLZVXxbyDya3dRo+WpbZDWLFGl+hwMW8EzWBWJKz8Qw1eRX6pk3SSXe2QdQPcj0qdIcphh1kGbTBzOeLlndXG0+v7I0WbTeuX3Zqw5Bubd7bUqqMWe+5jND/qgaT879q7nkiEleo1jps7qVDsINUxUIzo92zhr07HZ0TUEh27+31+6UWqLGvgm1lf4314FlCltaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKcGOQhuVDquFgZHvTXIBvc+lFCwsd5Jan/jRXs/xWk=;
 b=Sg+T4QbcX6kripy+E7IxellXuFg7rb9ZgUR0PG7UCURHBJgDCb1hWSHWqM2Aijc8LIIHYD//h9ff3p1IvDqamDYQfy3DzEKps6bGy+oAPNapKO8tGAvQl8gJkBzxRv0BwmONPI4sHsgL6EEFOsp279ICQ9wmR0TECIsDRIQCHKol88Pc6cYUlEblVldNdHrgqTIWu6Ezq0L0sZfejz4yzEXP0bfh2UTN5l1HiZ2yXZpPHCjwaTxp3SHoSYjRsnPp0pBhKX/sq8WYkD1aKi7uKQ84P9Jb4HL1UaYfgR2sXblZzNB0k3ubEI8yE8DOf8aQQ64qXo58NqGObAflqT00Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKcGOQhuVDquFgZHvTXIBvc+lFCwsd5Jan/jRXs/xWk=;
 b=iPPA3wsgvj0YHDGRUgG0cYDohe+l43rjBuA49oMOzIdv2GiNZ4ugdhZfgZojp3CCUDFvPxiywxIgqeOQdOgBwIzGQt9Hbxr5Thqs/8DOr1AmdF/76KfffvB8JHpL5n0af9FjTzUQ8Q7HN4hA9UzC79dDEOGYECOjGYH9B3EFZaI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2035.eurprd08.prod.outlook.com (2603:10a6:203:4a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 20:49:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 20:49:48 +0000
Subject: Re: [PATCH] migration: Fix typos in bitmap migration comments
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200727203206.134996-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8aac7e3b-11ed-296e-5308-110901e9e090@virtuozzo.com>
Date: Mon, 27 Jul 2020 23:49:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727203206.134996-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:208:14::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR03CA0007.eurprd03.prod.outlook.com (2603:10a6:208:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Mon, 27 Jul 2020 20:49:47 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34e8ba9a-19b9-4447-955a-08d8326e99b2
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2035:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2035C15C447CCFB95B3EB92FC1720@AM5PR0801MB2035.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8dW1TX3Y9MV5X5XPhKXHm80h7wgHaIOCAioXZw10alwOJcpbkWDB77Lz+g4Ot6Hf9emBukCSZ3IcDYPOwFbKoshPISaAY5mWEIhya8fPvcccg7fywbg5RxPDJemFaZf7KmkxSjTtElbmV87HAqQOb/I336JcnOOtecblj3Z3PZPBLvdiepNK+yzgV/FUJv4C+NtF1X7BVUW783Lhi3R9+0KK9KHIFgck8NpLi/7p7BX5MIyul0eztG3h1LAqSpJeOlP4c5X9U6INz49Mjc9nDDDf48jQOijOA1U798B3v1vV0lKdH0x1q9rlM0qQM7r1nwa+v3QvuMpoXL5PMkeE4R7tx4raKA785wA11BazxjY6rHoscnSj5Jg4wYA50Hf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(136003)(376002)(396003)(346002)(31696002)(66476007)(83380400001)(8936002)(8676002)(86362001)(52116002)(31686004)(66556008)(36756003)(316002)(54906003)(186003)(956004)(2616005)(478600001)(26005)(5660300002)(4326008)(16576012)(6486002)(2906002)(16526019)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KspHb1bB6gppsC5NdIqKpYmqG9OtGEzUbdnX7Gswome0dfj3sabWaxv8z25xU03Q2Db9TPRYwaEClkLNVWAz9SmytU5DAoI6uDJPocdZSoUK4JAEm4lEBQ34/G8RJczC6T+QNiI96079ZwJIvh47X9+A7ix2t/+swN4jle8j3exMNtaVfSRhsO5jHZDxn+4Rg98RyA0JkzvMjsrr6MRZ8cdbQ+u+y1rc2E866vW7+eagoCh9kaDIx3kIEv19X2YbI0+TLymYRFLlXBc9vXgo1VoONmuhJ1M3fJvGAoVojFxCvsM5huDED0oSs65Wqs8VaHQve18O3OPliGQE2x7DxF/JMcWNYgqwM4Llxv6IZH4X5R+AUq34bKIjyyScx65LTRjuWX9Ex0PSZ3ZLKaqKlATg1Zws2X5SG+m7HOaoL0XJCfRzK0xozLJ3sO55z6Wh0DNSCs8BK49c8qilFQ6eY7CkWGCekQUDGMJZH3k+3Z2Ofo6fOHCgRohibhP1zjnT
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e8ba9a-19b9-4447-955a-08d8326e99b2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 20:49:48.0578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/H6K0Z2zP4jeGOJToo4iWuYLbNJ1nLk9RMwA/m5vspiQxP/OvMWmDuTjdK0BKT6EJqhZGGAA32HuUoqZB7EJcPrwbGXUwFQgTg9Lip16tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2035
Received-SPF: pass client-ip=40.107.22.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:49:49
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 23:32, Eric Blake wrote:
> Noticed while reviewing the file for newer patches.
> 
> Fixes: b35ebdf076
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> This is trivial enough that I'll throw it in my pull request today.
> 
>   migration/block-dirty-bitmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 1f675b792fc9..784330ebe130 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -97,7 +97,7 @@
> 
>   #define DIRTY_BITMAP_MIG_START_FLAG_ENABLED          0x01
>   #define DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT       0x02
> -/* 0x04 was "AUTOLOAD" flags on elder versions, no it is ignored */
> +/* 0x04 was "AUTOLOAD" flags on older versions, now it is ignored */

may be also s/flags/flag

>   #define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8
> 
>   /* State of one bitmap during save process */
> @@ -180,7 +180,7 @@ static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
> 
>   static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
>   {
> -    /* The code currently do not send flags more than one byte */
> +    /* The code currently does not send flags as more than one byte */

Hmm, why "as more than", not just "more than"?.
(this note is about the following: the protocol allows adding more than
one byte of flags with use of DIRTY_BITMAP_MIG_EXTRA_FLAGS. Still,
currently this possibility is not used and we assert it.)

>       assert(!(flags & (0xffffff00 | DIRTY_BITMAP_MIG_EXTRA_FLAGS)));
> 
>       qemu_put_byte(f, flags);
> 

Anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

