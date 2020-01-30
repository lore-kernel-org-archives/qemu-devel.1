Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EABC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0E1214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mYP4w4k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0E1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixE9C-0007tf-24
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixE7i-0006fI-N5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixE7g-0001op-7Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:01:02 -0500
Received: from mail-vi1eur04on0701.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::701]:61858
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ixE7f-0001bD-9T; Thu, 30 Jan 2020 13:01:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHpOOtzLHqLqojymlmWgr6UauQ+BQp7c6F0wmpViwVxgCWcjDB6PTx0V6dBNOq97zw0TOt0Pg6k4AtGYJMmMVW0pjes2epT462CHcBMoGA01IwlHpV0KkwxNVnncbmb3IqxKDc5psdukl4XqMlJjMPIRBrtjtDugP4L7N9M0tpXRiaGzktM3cc5thLac4EqWyhVIMEVZjnNo1G2vJwoXNRJUjc8nDdMeKODpTwyJFcq5OCLJXchOmY6vrSciwwuT25m2v1uxAFxqM1em5oZNK3hAg/btbABdnyrC4Fz9oaZT77r1oEcbVgv6NTobG3p4cTXqMsEGqxxUIVFwTTLQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+HWKYiKCC2gbzM5j6+12SjL3drxb9O2rVwQHfSYF14=;
 b=oWhMU6f1gXcOUipN0wpi9Ad4eT+hcpff8HGidsicedjICyXL7zg7i7oV6erB6iGmSt9nT13qx7TqmHNCHWvkziA0BMp+mYKWluOhP+BslBcCC1ItPk/CZ9q29FJ7tBAWNoQLobtce17XPvyTHMqPs3wmp2M4yeC32+/83Nn0zv8Xw1FO6NBlo6kVftIDqVOd+reg3Y6xWKum8cYqJgkWdgi2dmDhikPoIafNY6267yoqbG3lbrTwP9Bh4mIbPKTLgQCVALAZROj9hp2iuxlJlu02wexQACHPKWvd4Tv/ETu++IXLQJMe5wVhrbjb8blw6a7Dnia8yU/1wnsudnpIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+HWKYiKCC2gbzM5j6+12SjL3drxb9O2rVwQHfSYF14=;
 b=mYP4w4k2dl+pG7eQsi5uLu7cvQat00cHIUJCiAS5Ckcd0cbmCKWmDD+8wiLvkZ9N5D2JUOEvps6Dl2ue0kTQ+31hOou+FXageo9OUxlT4BjGxpTHBwSzdeTou79trBEilsXKvTHgnke8v8Er6gvaHle0fwEwQpia2OD0gkbjGDg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4470.eurprd08.prod.outlook.com (20.179.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 18:00:55 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 18:00:55 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <632dfc93-5d42-2a9a-64f3-d6b0fca9e8dc@virtuozzo.com>
 <61f94246-4f74-c9ba-05a5-0da1c88be541@virtuozzo.com>
 <d451b4b9-27b9-bc43-afb9-eecc682c5586@virtuozzo.com>
 <f3179b45-19a2-a604-5552-30839bdcc509@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <0fd59a89-ac30-38a3-c9d8-b965696c595a@virtuozzo.com>
Date: Thu, 30 Jan 2020 21:00:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <f3179b45-19a2-a604-5552-30839bdcc509@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::31)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 18:00:54 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e24a61-cb26-4eb2-4e2b-08d7a5ae5a07
X-MS-TrafficTypeDiagnostic: AM6PR08MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4470718173F2005552F63458F4040@AM6PR08MB4470.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(39850400004)(396003)(136003)(199004)(189003)(86362001)(16526019)(186003)(53546011)(36916002)(478600001)(26005)(81166006)(81156014)(4326008)(6486002)(8936002)(52116002)(8676002)(966005)(31696002)(66946007)(66556008)(66476007)(956004)(36756003)(5660300002)(31686004)(2906002)(54906003)(110136005)(316002)(2616005)(44832011)(16576012);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4470;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoct3sd6WeaBkifcIEMkbCoeCS5A2bYXY5COUTr6MZW1kS/feIR344WwKeharF9bZilxSyTcV6XNzbjUZRgLl383asVb7o0qnWbcRU0iY+myJxW41sQKdAq65llPflkRKZec3u9IvtfqHeiALaIC25nqL5UngqAZIVN3/OoGR+IWNKeQEL3ZiQ4ObhzymXplXW3BB478XKA32D6rBWRwvCn5q/tgJPs/7r/r5o3WRQyor/YNKDZTRkRIm4yr74wOd+cV4kajTh/VTKs9ayFlcI+J07T82ZT+LzkXkYLAUSK+X6z18t7eJM/CQ5Z5xeVd3ld4Kir/GMwL/+bFU20XJy1IO0CzpNYBNPWxmxoQCv9+v3S6I2FbkH1LNHEqlQAIGkLAu2X8xz5ihH9D6Mtmf59Ve3nUBFX7yHuTZKuttFe4OnJjyLgZoSPbXWUhakECAV9G5WsbOM1ckTfB8dgeNjBd6PDjgv0Q5mBgr8Vs0OtYgE1b7S42lfJewvyq3alT6aOL6xjtw9cUlrCJl3iaLw==
X-MS-Exchange-AntiSpam-MessageData: ZXDEJ0QDSc57LfN8azRtykFcQTysVe0SstJIQU2/AJmZ58WlHVwt6AU6BkzfeaiYIpF8FdN5vU6PvkKjHu3GnYLeeYWzBg9ckWSAsos82x9jEzZHOXEbAE12RRQVGldr+ixAwrGJoWsXbUgHeCTTQw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e24a61-cb26-4eb2-4e2b-08d7a5ae5a07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 18:00:55.1124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seWLjEBWmTIxYBTqMWLJ3BlKKbuG/4MIrAzmEfWj7fOd1gnLfBaRuuUxHaEz/4wH9TImln/OhfWSt95oaDRR8otCRqmBQYOoWHTO9Nl43b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4470
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::701
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30/01/2020 20:09, Vladimir Sementsov-Ogievskiy wrote:
> 30.01.2020 19:24, Andrey Shinkevich wrote:
>>
>>
>> On 30/01/2020 16:45, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.01.2020 23:05, Andrey Shinkevich wrote:
>>>>
>>>>
>>>> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Currently, block_copy operation lock the whole requested region. But
>>>>> there is no reason to lock clusters, which are already copied, it wil=
l
>>>>> disturb other parallel block_copy requests for no reason.
>>>>>
>>>>> Let's instead do the following:
>>>>>
>>>>> Lock only sub-region, which we are going to operate on. Then, after
>>>>> copying all dirty sub-regions, we should wait for intersecting
>>>>> requests block-copy, if they failed, we should retry these new dirty
>>>>> clusters.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>> =C2=A0=C2=A0 block/block-copy.c | 116=20
>>>>> +++++++++++++++++++++++++++++++++++++--------
>>>>> =C2=A0=C2=A0 1 file changed, 95 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>>>> index 20068cd699..aca44b13fb 100644
>>>>> --- a/block/block-copy.c
>>>>> +++ b/block/block-copy.c
>>>>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq=20
>>>>> *block_copy_find_inflight_req(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>>> =C2=A0=C2=A0 }
>>>>> -static void coroutine_fn=20
>>>>> block_copy_wait_inflight_reqs(BlockCopyState *s,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t=20
>>>>> offset,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t bytes)
>>>>> +/*
>>>>> + * If there are no intersecting requests return false. Otherwise,=20
>>>>> wait for the
>>>>> + * first found intersecting request to finish and return true.
>>>>> + */
>>>>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s,=20
>>>>> int64_t start,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t end)
>>>>> =C2=A0=C2=A0 {
>>>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req;
>>>>> +=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req =3D block_copy_find_inf=
light_req(s,=20
>>>>> start, end);
>>>>> -=C2=A0=C2=A0=C2=A0 while ((req =3D block_copy_find_inflight_req(s, o=
ffset, bytes))) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->=
wait_queue, NULL);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!req) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wait_queue, NULL);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return true;
>>>>> =C2=A0=C2=A0 }
>>>>> +/* Called only on full-dirty region */
>>>>> =C2=A0=C2=A0 static void block_copy_inflight_req_begin(BlockCopyState=
 *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq=20
>>>>> *req,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset,=20
>>>>> int64_t bytes)
>>>>> =C2=A0=C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0 assert(!block_copy_find_inflight_req(s, offset, b=
ytes));
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, b=
ytes);
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->offset =3D offset;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->bytes =3D bytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_init(&req->wait_qu=
eue);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&s->inflight_r=
eqs, req, list);
>>>>> =C2=A0=C2=A0 }
>>>>> -static void coroutine_fn=20
>>>>> block_copy_inflight_req_end(BlockCopyInFlightReq *req)
>>>>> +static void coroutine_fn=20
>>>>> block_copy_inflight_req_shrink(BlockCopyState *s,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req=
, int64_t new_bytes)
>>>>> =C2=A0=C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0 if (new_bytes =3D=3D req->bytes) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 assert(new_bytes > 0 && new_bytes < req->bytes);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->copy_bitmap,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 req->offset + new_bytes, req->bytes -=20
>>>>> new_bytes);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 req->bytes =3D new_bytes;
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wait_queue);
>>>>
>>>> Won't we get the performance degradation with that function frequent=20
>>>> call?
>>>
>>> Why do you think so? In IO most of performance depends on disk speed=20
>>> and how
>>> we organize requests sequence. The whole original series shows=20
>>> performance improvement.
>>>
>>> This patch reduces lock around request, locking only the part we are=20
>>> working on now,
>>> this is for better interactivity. After calling block-status, the=20
>>> request is shrinked
>>> to possibly unlock some other requests, waiting on the tail of our=20
>>> request.. Do you
>>> have a better suggestion on this synchronization?
>>>
>>
>> I cannot answer right away. One need to measure the performance in=20
>> each case.
>=20
> Measurements are done in the original (big) series
>  =C2=A0"[RFC 00/24] backup performance: block_status + async"
>  =C2=A0<20191115141444.24155-1-vsementsov@virtuozzo.com>
>  =C2=A0https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02335.htm=
l
>=20
> and this series (part I) is a first step to it.
>=20
> Currently, improving interactivity of parallel block-copy requests is=20
> not very
> meaningful, as all requests from backup are one-cluster-sized, and=20
> improving
> performance of parallel intersecting guest writes is a strange thing.
>=20
> But finally, backup is refactored to be the only one call of block_copy=20
> for the
> whole disk, so this new locking of sub-requests becomes critical.
>=20
> The only degradation I see, is that with this qemu_co_queue_restart_all,=
=20
> we may
> restart requests, which still intersects with shrinked request, they=20
> wake up,
> and go to the block_copy_wait_one again for nothing. This may be=20
> improved by
> dropping coroutine-queue, and use own list of waiting requests, and wake-=
up
> only requests which do not intersect with shrinked request. But I think,=
=20
> that it
> is premature optimization which complicates the code. So, it may be done=
=20
> later
> if needed. But I think that it doesn't worth it.
>=20
>>
>> Andrey
>>>>
>>>>> +}
>>>>> +
>>>>> +static void coroutine_fn=20
>>>>> block_copy_inflight_req_end(BlockCopyState *s,
>>>>> + BlockCopyInFlightReq *req,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int ret)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->=
copy_bitmap, req->offset,=20
>>>>> req->bytes);
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_REMOVE(req, list);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->=
wait_queue);
>>>>> =C2=A0=C2=A0 }
>>>>> @@ -344,12 +377,19 @@ int64_t=20
>>>>> block_copy_reset_unallocated(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> =C2=A0=C2=A0 }
>>>>> -int coroutine_fn block_copy(BlockCopyState *s,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int64_t offset, uint64_t bytes,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>>>> +/*
>>>>> + * block_copy_dirty_clusters
>>>>> + *
>>>>> + * Copy dirty clusters in @start/@bytes range.
>>>>
>>>> %s/start/offset/ ?
>>>>
>>>>> + * Returns 1 if dirty clusters found and successfully copied, 0 if=20
>>>>> no dirty
>>>>> + * clusters found and -errno on failure.
>>>>> + */
>>>>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int64_t offset,=20
>>>>> int64_t bytes,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool=20
>>>>> *error_is_read)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>>>> +=C2=A0=C2=A0=C2=A0 bool found_dirty =3D false;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * block_copy() user is res=
ponsible for keeping source and=20
>>>>> target in same
>>>>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset, s=
->cluster_size));
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(bytes, s-=
>cluster_size));
>>>>> -=C2=A0=C2=A0=C2=A0 block_copy_wait_inflight_reqs(s, offset, bytes);
>>>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_begin(s, &req, offset, by=
tes);
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bytes) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t =
next_zero, cur_bytes, status_bytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdr=
v_dirty_bitmap_get(s->copy_bitmap, offset)) {
>>>>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue; /* already copied */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_dirty =3D true;
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_byte=
s =3D MIN(bytes, s->copy_size);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_zer=
o =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap,=20
>>>>> offset,
>>>>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 assert(next_zero < offset + cur_bytes); /* no need=20
>>>>> to do MIN() */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cur_bytes =3D next_zero - offset;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_b=
egin(s, &req, offset, cur_bytes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D =
block_copy_block_status(s, offset, cur_bytes,=20
>>>>> &status_bytes);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_s=
hrink(s, &req, status_bytes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->s=
kip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_reset_dirty_bitmap(s->copy_bitmap, offset,=20
>>>>> status_bytes);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
lock_copy_inflight_req_end(s, &req, 0);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 s->progress_reset_callback(s->progress_opaque);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trace_block_copy_skip_range(s, offset, status_bytes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset +=3D status_bytes;
>>>>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_bl=
ock_copy_process(s, offset);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s=
->copy_bitmap, offset, cur_bytes);
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_get_f=
rom_shres(s->mem, cur_bytes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D =
block_copy_do_copy(s, offset, cur_bytes, ret &=20
>>>>> BDRV_BLOCK_ZERO,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_is=
_read);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_put_t=
o_shres(s->mem, cur_bytes);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_e=
nd(s, &req, ret);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =
< 0) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->progr=
ess_bytes_callback(cur_bytes, s->progress_opaque);
>>>>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=
=3D cur_bytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end(&req);
>>>>> +=C2=A0=C2=A0=C2=A0 return found_dirty;
>>>>> +}
>>>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start,=20
>>>>> uint64_t bytes,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 while (true) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D block_copy_di=
rty_clusters(s, start, bytes,=20
>>>>> error_is_read);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * IO operation failed, which means the whole=20
>>>>> block_copy request
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * failed.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * Something was copied, which means that there were=20
>>>>> yield points
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * and some new dirty bits may appered (due to failed=20
>>>>> parallel
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * block-copy requests).
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here ret =3D=3D 0=
, which means that there is no dirty=20
>>>>> clusters in
>>>>
>>>> there is no dirty cluster in
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requested region.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!block_copy_wait_one(=
s, start, bytes)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* No dirty bits and nothing to wait: the whole=20
>>>>> request is done */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>
>>>
>>>
>>
>=20
>=20

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
--=20
With the best regards,
Andrey Shinkevich


