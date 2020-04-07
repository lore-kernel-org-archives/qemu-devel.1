Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C0AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3972078C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="shHnq79A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3972078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLsBI-0007lA-IL
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLs9j-0006t7-0N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLs9h-0003Jk-7N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:36:58 -0400
Received: from mail-eopbgr140103.outbound.protection.outlook.com
 ([40.107.14.103]:27873 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLs9g-0003H6-Jw; Tue, 07 Apr 2020 13:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMNef3vwOxPpvaLKFUKUs4G/uzMbq6zWeiPJO4Jdut4w64S/OxjSdjh59yYqoRPgeU5bRMCC6gwqbsit8uiBVxP4E1yw2na1FH3otyMPxCPKwmK6Qb3moCCKx4kFWRsuqULqEdyscMAkGDj6HFVWO0jXz3338s+RD8iMfHLh4zAJRWlVBHECyfGkxtd53w5Wd/CLMYh6N+fcVPgves9559Debbdg0+qAk2sPR7dYtGrkWm7IM9CeebwcFlfa9O40DXhBXMLl8EnOPMuTTZTqPovq9CrvhXjlp/6RlyvBAlp/vHKeMic1Je0cO9u5u4w4DoXmMxZIjKDUJTo9HGU6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9OTHr1EJ8y3lmcWqbnG9vdG4WgzzxXVV7W4oySqdAU=;
 b=ezP3Dr5CyDytBoyK33ku7ms6Ozd62W8xZ+mW44i+iKqhLNnQoXhvv5gubzZ7g23IpA8PYd9QAlavwMOWRIurMwi0YEYpugCV6ZnKGrossX7sfR1evElspXKENic36nm6V3FTs3GPOpJvhq/LindbmQgxcScrJOn08Z5O8NUDNLZPbYAA9giWFQK1fOdR3fV0cMP6G6roJnymcqCioh1lrpmCBhmrEDsDLxzoB+wTwSS1roE4B8SUdv4njgYM+NpBRI00BVoleeVetb5yEw9ooXoRqiPSgCkBGeoyZGm/Z1ngj7pzsCKXUB384VJEhVjHo+WJnTI6L+BK28Up4EPkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9OTHr1EJ8y3lmcWqbnG9vdG4WgzzxXVV7W4oySqdAU=;
 b=shHnq79AgwRNOnUH4jsYtLlFgMPBn2GQs5JYmIxzzIBi/PtRiHPg8y2cAButAgx8ih3u0qj14CsX2f02gv+upivPONj74rz/4hnoVhPz/VW9EqauKrVAaNDWl94kNQkN3xBmW9qjpzZUmYTKq/pSaQl+mLDZTnYQ3E+M0T3G2rk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (52.133.246.147) by
 VI1PR08MB3597.eurprd08.prod.outlook.com (20.177.61.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Tue, 7 Apr 2020 17:36:52 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::28ab:e81:c912:8931]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::28ab:e81:c912:8931%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 17:36:52 +0000
Subject: Re: [PATCH for-5.0 v3 2/3] block: Increase BB.in_flight for coroutine
 and sync interfaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200407121259.21350-1-kwolf@redhat.com>
 <20200407121259.21350-3-kwolf@redhat.com>
 <2a1985c1-5d36-6537-86f5-e95baaca7416@virtuozzo.com>
 <20200407144212.GG7695@linux.fritz.box>
 <399cb66a-528e-b92b-546f-a712608bcc14@virtuozzo.com>
 <20200407162759.GH7695@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407203650161
Message-ID: <e6b72555-54be-ab60-1bc0-d58da93aa668@virtuozzo.com>
Date: Tue, 7 Apr 2020 20:36:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407162759.GH7695@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17 via Frontend Transport; Tue, 7 Apr 2020 17:36:51 +0000
X-Tagtoolbar-Keys: D20200407203650161
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52333cd8-840e-4abc-e051-08d7db1a423e
X-MS-TrafficTypeDiagnostic: VI1PR08MB3597:
X-Microsoft-Antispam-PRVS: <VI1PR08MB35973E0EAB05B5987810EF5BC1C30@VI1PR08MB3597.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(39840400004)(346002)(136003)(186003)(6486002)(6916009)(2906002)(2616005)(16576012)(26005)(16526019)(31686004)(31696002)(66946007)(81166006)(86362001)(956004)(8936002)(66556008)(8676002)(478600001)(52116002)(5660300002)(316002)(4326008)(81156014)(66476007)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCTiCWfTJEh5ugrwCFBLzYd6VsuyKDQORJ4rIA6gC2Tg6zA0zhOkmJFEZezVOFPtVOab4IEDxkoOax0dIptW9MdhTjqaJ7HsmKIreiOohAFYih6PfmC3ii/D+N942ewYitE4AXKcCiLnukx42AGQngo7mbcel3eVB93aapvdmmTESLC/FWE32yKaettDGjRrsnmaemkgbIPWdED4pSF16s46ADprqAZQ+6oqyOMDVPttlboOLlFsR7tOFWaO/iL6JAH0cGDVWNgQSbKCX8faU9BOQ3Go95HHvfVRcX9xJpXrbqFVveho0PUc0uZVk+mENNAEzxoSrRON/3kYRaAO63U19Vw+CYgRaAH3V3+R5HTLO7AsPhAH46lJ1AsQ+u7L2bL4kunDUE0jlKDCEhk7M3MRlIOJM+EF2Tf7rsprwsgp5UQeKr4baUR/7ZJ/lTar
X-MS-Exchange-AntiSpam-MessageData: wa3huQEfXc5s6Gn99jfrQiQUv0PrvnGmmO9TeqluTAJsZYl/mq8OsP1BZCC3vH91lZ/gSDRpR0qenn597yN8pcpHhGnY/FVaNaHYZeKgydEK3xiFmMewgzvdC69lxk+pi48IYdnQ0rh4Rd0z4Hi1KQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52333cd8-840e-4abc-e051-08d7db1a423e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 17:36:52.5892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i37Cvg5HcQr1tx5hhMlxK6LrhWbIGda9GXXXOdPKKcz7R5KUKaUK7L+Xv0TQHj02s6phWvNWUk6hQNtYFDB/kd3fekJoJpBC59xjmNHGilk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3597
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.103
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 19:27, Kevin Wolf wrote:
> Am 07.04.2020 um 16:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 07.04.2020 17:42, Kevin Wolf wrote:
>>> Am 07.04.2020 um 16:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 07.04.2020 15:12, Kevin Wolf wrote:
>>>>> External callers of blk_co_*() and of the synchronous blk_*() functions
>>>>> don't currently increase the BlockBackend.in_flight counter, but calls
>>>>> from blk_aio_*() do, so there is an inconsistency whether the counter
>>>>> has been increased or not.
>>>>>
>>>>> This patch moves the actual operations to static functions that can
>>>>> later know they will always be called with in_flight increased exactly
>>>>> once, even for external callers using the blk_co_*() coroutine
>>>>> interfaces.
>>>>>
>>>>> If the public blk_co_*() interface is unused, remove it.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> side question:
>>>>
>>>> Should we inc/dec in blk_make_zero, blk_truncate?
>>>
>>> I don't think it's necessary. They call into their bdrv_* counterpart
>>> immediately, so the node-level counter should be enough.
>>>
>>
>> bdrv_make_zero is not one request, it does block_status/pwrite_zeroes
>> in a loop. So drained section may occur during bdrv_make_zero.
>> Possibly, nothing bad in it?
> 
> It would potentially be a problem if it were called in coroutine
> context. But it's a synchronous function that must be called in the main
> thread (and also only used in qemu-img), so I don't see how drain could
> happen while it runs.
> 
> If we did want to make it safe for use in coroutine context, it would be
> by using bdrv_inc/dec_in_flight() in bdrv_make_zero().
> 
>> blk_truncate may do coroutine_enter before incrementing node-level
>> counter, which may only schedule it..
> 
> This is bdrv_truncate(), not blk_truncate(). If you address it in
> blk_truncate(), you miss the direct callers of bdrv_truncate().
> 
> But you're right that it could potentially be a problem. Not sure if it
> really is, but maybe better safe than sorry, so if you want to send a
> patch, go ahead.
> 

Hmm. Same thing may be said about all other coroutine-enter wrappers in block/io.c. OK, I'll make a patch.


-- 
Best regards,
Vladimir

