Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D45A206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bKjc0B75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D45A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixChO-0003vv-MK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixCcI-0003Xb-NO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixCcG-0004RS-Ev
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:24:30 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]:32128
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ixCcF-0004Or-Ng; Thu, 30 Jan 2020 11:24:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEAIXJjIdg06J535pMgDwkkSWhuNAOBD6NuV6O814cF3PEhMOzAhoNY41/9OmqN23McwkiLTnGS0uf5x2rx0jALQKTmk9HELv9AyuSNZkmNdIInTc6Q8gEf/H7w85X6X9qMnwQfGxdWL69lLZcH2QQQ2yHQzqhpZslEpOGQMibJRu0+oT3h7i6ZbtxpBbc/eBobmmsynRpWWbZ4zC5w3EEsV4Y0DTIkDxun8DoFfxAzKjJuj6KZ6LkHwtw/ni/eQn08CH0NawEE3PQ6O2IXaYZ5xkmu6GDB+DCZba3i2vtyL554Uk8BUu4459ap2lnVw0wnCFjFFfBy46uFxJCml+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtJs1BVb4JzV6ZNjAhE+hxydlKU51wnt7itCvw+/SS0=;
 b=QuiCPyHxibAzvHXn5UITMAt87XUeu39B/HQROXjhLRRDKhFlkgdZ5Xi1LsZ+o+vLQ4MBU3G4IVCDNuFlvNIBuuyGpbjRWjy3wQ3Rgxs2vpclHZjvOdouUcQpT9pIHhItlOL36QcGbabDbLUY5zjwnjhyJIbCBbyrBakkJ8fJJ7U0ZBXnxhTOc6nCXK6+s1k2BsPSEY8swcXXeNdaNPy2MOD+RnJDbB+3fSwSKrJi4hPtyW63sOMhKx68hc1nZ8UfBBbvFkBtY9dBimJHPM+lIhg26Wag+0+snhfKeGGGv8w5s0LvJ8AUBEiKmlq2kVF3N58UM2nm8k9nEhWr5Iw2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtJs1BVb4JzV6ZNjAhE+hxydlKU51wnt7itCvw+/SS0=;
 b=bKjc0B75AZudtlm/OmreABhhFLwG2dSz2N6UOS6iE5SN1dQfKvubkeOElNTWV68Pwy0LnJAYJdZlmAVZR4LzGNXBlsyuOJC0jY6A/vfRc7+qEi3WbwbevWu4uXV473KWVeL/g4KsQi5OBszfrpTIvXr8856DCoEUAuvfpSvDDvI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3717.eurprd08.prod.outlook.com (20.178.91.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 16:24:21 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 16:24:21 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <632dfc93-5d42-2a9a-64f3-d6b0fca9e8dc@virtuozzo.com>
 <61f94246-4f74-c9ba-05a5-0da1c88be541@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <d451b4b9-27b9-bc43-afb9-eecc682c5586@virtuozzo.com>
Date: Thu, 30 Jan 2020 19:24:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <61f94246-4f74-c9ba-05a5-0da1c88be541@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::13)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Thu, 30 Jan 2020 16:24:20 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de0fb9ad-fadb-46dc-8aeb-08d7a5a0dcd1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3717F5C9035C237EAF6805FCF4040@AM6PR08MB3717.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(376002)(136003)(366004)(199004)(189003)(2906002)(52116002)(110136005)(16576012)(31696002)(36916002)(316002)(86362001)(66946007)(6486002)(66556008)(66476007)(31686004)(478600001)(53546011)(5660300002)(54906003)(186003)(2616005)(16526019)(956004)(44832011)(4326008)(26005)(8676002)(81166006)(81156014)(36756003)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3717;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVqDKJdI7HdlTxWGRV4vYEadZAZKwug8eFlq01uoWhsaNzDrBsOWWuyOH3j9NKo4+pbmH/OP6O0JLB7Jt+ifu3e76xSCkiUDiigDHYCg26YIAwj4VHjk67lOpnAZwwTTBSKK4HrycWDpIHJvNVZ1zRIxBrXTZ4STk9Pm0jJ3rg9OBfonxH4i3Rzw6mb/sIi54dw6wVwmjBUr65U1ZI623AhWmGU+mx30DQownFxgKgsJXB6t9Bn3yyELTA5OTe3WFJFaxXJqAghTZmgTM67Zxr8P4sSwP5N3L/91r9fJtWhcF1ITN0G1kdbJT2Oo/4UYULy8bzvi0RFLOrwwRq5WsG1/w/rEFIgb3QfYKLNfGizLe8gcPjV01YrfTcl3+s3Pl0zh+MtYlfUHBu84jTDuRYb9dm1xe//gJ4WMLUImKJSo8of7Ugkwas5BMWevQeKV
X-MS-Exchange-AntiSpam-MessageData: w6LEOgSUIlA9Opn5MaXyDRkvDP79LeKltrZWWrxWYo9xa0efjrwfL7oUFz9mus+07434WXAGdKgZB4DjZsq2ni1WpWZoG+IEwWRPpeO7kWn8JZNaaLUefbCBI38yffbJcLLq+JC9rlbDv9+YfuNGQw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0fb9ad-fadb-46dc-8aeb-08d7a5a0dcd1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 16:24:21.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+83eiz05DZXnrH+utXoQzEo1+fbO1JpZCC8olFKhpGdBtddsFnIaDYv9q9Nu3kkI2VRcvJ4zSLHuG4wonp5Ws9kUTCDsdQyMCkm2aUv7xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3717
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7d00::707
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



On 30/01/2020 16:45, Vladimir Sementsov-Ogievskiy wrote:
> 29.01.2020 23:05, Andrey Shinkevich wrote:
>>
>>
>> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>>> Currently, block_copy operation lock the whole requested region. But
>>> there is no reason to lock clusters, which are already copied, it will
>>> disturb other parallel block_copy requests for no reason.
>>>
>>> Let's instead do the following:
>>>
>>> Lock only sub-region, which we are going to operate on. Then, after
>>> copying all dirty sub-regions, we should wait for intersecting
>>> requests block-copy, if they failed, we should retry these new dirty
>>> clusters.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0=C2=A0 block/block-copy.c | 116=20
>>> +++++++++++++++++++++++++++++++++++++--------
>>> =C2=A0=C2=A0 1 file changed, 95 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 20068cd699..aca44b13fb 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq=20
>>> *block_copy_find_inflight_req(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> =C2=A0=C2=A0 }
>>> -static void coroutine_fn=20
>>> block_copy_wait_inflight_reqs(BlockCopyState *s,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t bytes)
>>> +/*
>>> + * If there are no intersecting requests return false. Otherwise,=20
>>> wait for the
>>> + * first found intersecting request to finish and return true.
>>> + */
>>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s,=20
>>> int64_t start,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t end)
>>> =C2=A0=C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req;
>>> +=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req =3D block_copy_find_infli=
ght_req(s,=20
>>> start, end);
>>> -=C2=A0=C2=A0=C2=A0 while ((req =3D block_copy_find_inflight_req(s, off=
set, bytes))) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wa=
it_queue, NULL);
>>> +=C2=A0=C2=A0=C2=A0 if (!req) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wait_queue, NULL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return true;
>>> =C2=A0=C2=A0 }
>>> +/* Called only on full-dirty region */
>>> =C2=A0=C2=A0 static void block_copy_inflight_req_begin(BlockCopyState *=
s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset, int64_t=20
>>> bytes)
>>> =C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 assert(!block_copy_find_inflight_req(s, offset, byt=
es));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, byt=
es);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->offset =3D offset;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->bytes =3D bytes;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_init(&req->wait_queu=
e);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&s->inflight_req=
s, req, list);
>>> =C2=A0=C2=A0 }
>>> -static void coroutine_fn=20
>>> block_copy_inflight_req_end(BlockCopyInFlightReq *req)
>>> +static void coroutine_fn=20
>>> block_copy_inflight_req_shrink(BlockCopyState *s,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req, =
int64_t new_bytes)
>>> =C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 if (new_bytes =3D=3D req->bytes) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 assert(new_bytes > 0 && new_bytes < req->bytes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->copy_bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 req->offset + new_bytes, req->bytes -=20
>>> new_bytes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 req->bytes =3D new_bytes;
>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wait_queue);
>>
>> Won't we get the performance degradation with that function frequent=20
>> call?
>=20
> Why do you think so? In IO most of performance depends on disk speed and=
=20
> how
> we organize requests sequence. The whole original series shows=20
> performance improvement.
>=20
> This patch reduces lock around request, locking only the part we are=20
> working on now,
> this is for better interactivity. After calling block-status, the=20
> request is shrinked
> to possibly unlock some other requests, waiting on the tail of our=20
> request.. Do you
> have a better suggestion on this synchronization?
>=20

I cannot answer right away. One need to measure the performance in each=20
case.

Andrey
>>
>>> +}
>>> +
>>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s=
,
>>> +                                                    =20
>>> BlockCopyInFlightReq *req,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int ret)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->co=
py_bitmap, req->offset, req->bytes);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_REMOVE(req, list);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wa=
it_queue);
>>> =C2=A0=C2=A0 }
>>> @@ -344,12 +377,19 @@ int64_t=20
>>> block_copy_reset_unallocated(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0 }
>>> -int coroutine_fn block_copy(BlockCopyState *s,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int64_t offset, uint64_t bytes,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>> +/*
>>> + * block_copy_dirty_clusters
>>> + *
>>> + * Copy dirty clusters in @start/@bytes range.
>>
>> %s/start/offset/ ?
>>
>>> + * Returns 1 if dirty clusters found and successfully copied, 0 if=20
>>> no dirty
>>> + * clusters found and -errno on failure.
>>> + */
>>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int64_t offset,=20
>>> int64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool *error_is_read)
>>> =C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>> +=C2=A0=C2=A0=C2=A0 bool found_dirty =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * block_copy() user is respo=
nsible for keeping source and=20
>>> target in same
>>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset, s->=
cluster_size));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(bytes, s->c=
luster_size));
>>> -=C2=A0=C2=A0=C2=A0 block_copy_wait_inflight_reqs(s, offset, bytes);
>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_begin(s, &req, offset, byte=
s);
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bytes) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t ne=
xt_zero, cur_bytes, status_bytes;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_=
dirty_bitmap_get(s->copy_bitmap, offset)) {
>>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue; /* already copied */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_dirty =3D true;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes =
=3D MIN(bytes, s->copy_size);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_zero =
=3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap,=20
>>> offset,
>>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 assert(next_zero < offset + cur_bytes); /* no need to=20
>>> do MIN() */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cur_bytes =3D next_zero - offset;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_beg=
in(s, &req, offset, cur_bytes);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bl=
ock_copy_block_status(s, offset, cur_bytes,=20
>>> &status_bytes);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_shr=
ink(s, &req, status_bytes);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->ski=
p_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_reset_dirty_bitmap(s->copy_bitmap, offset,=20
>>> status_bytes);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blo=
ck_copy_inflight_req_end(s, &req, 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 s->progress_reset_callback(s->progress_opaque);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trace_block_copy_skip_range(s, offset, status_bytes);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset +=3D status_bytes;
>>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_bloc=
k_copy_process(s, offset);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->=
copy_bitmap, offset, cur_bytes);
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_get_fro=
m_shres(s->mem, cur_bytes);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bl=
ock_copy_do_copy(s, offset, cur_bytes, ret &=20
>>> BDRV_BLOCK_ZERO,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_is=
_read);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_put_to_=
shres(s->mem, cur_bytes);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end=
(s, &req, ret);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < =
0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->progres=
s_bytes_callback(cur_bytes, s->progress_opaque);
>>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=3D=
 cur_bytes;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end(&req);
>>> +=C2=A0=C2=A0=C2=A0 return found_dirty;
>>> +}
>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start,=20
>>> uint64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 while (true) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D block_copy_dirt=
y_clusters(s, start, bytes,=20
>>> error_is_read);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * IO operation failed, which means the whole block_copy=20
>>> request
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * failed.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Something was copied, which means that there were=20
>>> yield points
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * and some new dirty bits may appered (due to failed=20
>>> parallel
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * block-copy requests).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here ret =3D=3D 0, =
which means that there is no dirty=20
>>> clusters in
>>
>> there is no dirty cluster in
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requested region.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!block_copy_wait_one(s,=
 start, bytes)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
No dirty bits and nothing to wait: the whole request=20
>>> is done */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0 }
>>>
>>
>=20
>=20

--=20
With the best regards,
Andrey Shinkevich


