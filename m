Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAF0206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RsocJ24s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAF0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDLe-0001mY-0R
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixDJx-0000Tj-4i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixDJu-0007iI-V6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:09:36 -0500
Received: from mail-vi1eur05on2116.outbound.protection.outlook.com
 ([40.107.21.116]:34561 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixDJt-0007fl-Us; Thu, 30 Jan 2020 12:09:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1u48YAxa/WFYXSayqfZGBdvwTqSUOOvR3VegRUH4BWdJDNkALookN3KY7NjQrxET8ipS+6RYXneqFN102bZgeWdcRqLtrrLhNbo7HC9YA54wv47uVbtJQIY498+Rdh7JdtvR1K1Y26i/BbLAeBXBfdFpz1sTCglqX0q68uJoRMQwMfucJyed95I0uBmeX/m5oxpNreR91Uy3uFl0jwL2EeOc1XpSc8F4WFxu6IA0gJoL3ICjJZL/p/tbPwCxdZZ5sDVNA2Mz0jmh2EtdJxxBJhaME0hHuoW9yP6Y9+b6NcLW4WwX2tWY+o7Qid2F+BsRMlBHdGuESR87L4lB/FTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ep4YK/d0as+Eo8fOw7KoisYgAdV+Za4Pi7z2jGyKOk=;
 b=ds9TCvKSEUG/YeD2ATCuoM5Og8ovvEvMH3GD7PrK2zrkY1O4MIdCq8m0fmY/00iRttRK3L9OZ7SBWEEAhCLK+/TPty2dGRbvTuC8rLOsxJOYrKEfhffn9NHXSdCiQpR8KBEFzNNkLDa0uQsHnHqLcIzU9i/QzRHFSixWcy4DDUufHaeLX82zYSup/3d49YYjTPCjTwNDB589hiJaUccUs9KQDfCKogZKrkP9LSUihCOh0qXv5xtt9A1Xv25W1wApqBQh7zJeeJImHW7J2i4AIBZupo4y5w/Yp01ANGjzcgA4+Sj3qNQ/4gS6Y7Ov4UAEi9EV0fYd5W+UA4CndZ59HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ep4YK/d0as+Eo8fOw7KoisYgAdV+Za4Pi7z2jGyKOk=;
 b=RsocJ24s5j9nVZ/UdDQ8MDhfJ1H4UXgTDjeCbc1vVfYihD+ZfO9FTGqaykIpj/thGMpRba3ywFdY6sNQqk6Uyp0j+Z69RM5j4UMZHg8HBoWdpeF0EhojHJhXin/0vs4lz2NhJccPDPlczziw5Y94mEJTddiXStQiZ/jAzv47l4A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4673.eurprd08.prod.outlook.com (10.255.96.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 17:09:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 17:09:31 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <632dfc93-5d42-2a9a-64f3-d6b0fca9e8dc@virtuozzo.com>
 <61f94246-4f74-c9ba-05a5-0da1c88be541@virtuozzo.com>
 <d451b4b9-27b9-bc43-afb9-eecc682c5586@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130200928747
Message-ID: <f3179b45-19a2-a604-5552-30839bdcc509@virtuozzo.com>
Date: Thu, 30 Jan 2020 20:09:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <d451b4b9-27b9-bc43-afb9-eecc682c5586@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::38)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 17:09:30 +0000
X-Tagtoolbar-Keys: D20200130200928747
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a666f304-3a17-482f-1f8c-08d7a5a72bca
X-MS-TrafficTypeDiagnostic: AM6PR08MB4673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB46735944CABF36E627038E54C1040@AM6PR08MB4673.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(2906002)(52116002)(110136005)(16576012)(31696002)(316002)(66946007)(86362001)(6486002)(66556008)(66476007)(31686004)(478600001)(53546011)(5660300002)(54906003)(2616005)(16526019)(956004)(186003)(26005)(4326008)(8676002)(81166006)(81156014)(36756003)(966005)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4673;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu+Hxz8pRGpI/PmvXIIdL0q9T1fSgQC31oHoXQGjs3Gjo7FCnrjRBV1ZyzWo+QuJSW6+ZhYVaiCeU1vSy/WxlDTA3ELdUo/U6iCKtoZ/BcmfohOR/xezXeISrQWgKZO8z8ZXBkeckAXANmK5RIQL59HiRlOcozwwV7IKUQtz+3+e6Z+7Do+TQq/WKw0m3/4sQdJCz+9GjM+PXHzKWxOcSrWTWMwbHo59svZOqMSv1VSV50vrAraZ2YiOK0EHiXNqrgvCcS16oLT6lTIeEngVojDZEFCmyfNJQhSzXs0NfV43usGCm7iQPre9462C+tEVdriS5zENwUozvfI0rI582yGOxHoFmb4x9JA3qB8NNs/5Sq6zVp/dMPnPzLX2naXWv8LKHm6oUii/IB33uhtpJdtooSwzYnVCC1/Den9x0L1aDqcjDiL/Eo0SKwzXAX44eMthdbyu0RtPqCCzmTpYq0357NBq42h1SqK6Cu7wijtaJlM4keF3LyxUcx+UoQ6FM9Q86MSluDXccMj8POWK7g==
X-MS-Exchange-AntiSpam-MessageData: 87BjsgeW6+JmUJrk4dhOJS0e7K0TKILlOmGq4urE6MBL6tjPiLVvvx40wirMVc90AttnTMNJo+uow8l0tYBo4lgLN0F/FDySHVTr61eveTuhh4hp2MWXNbBfp993kFu1mheqL7iZjRXBH3127HoQWg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a666f304-3a17-482f-1f8c-08d7a5a72bca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 17:09:31.2120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s7I4k0UQQsISj+l1AzavPfx8hr5VbZTvaQJAI6m08jHIbK9pv+0jqq1vB9ap+1ADkfyuLfRkr1ajj0rrBpTvwq7PSEy7lIgcvOqg/gBpic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4673
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.116
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

30.01.2020 19:24, Andrey Shinkevich wrote:
>=20
>=20
> On 30/01/2020 16:45, Vladimir Sementsov-Ogievskiy wrote:
>> 29.01.2020 23:05, Andrey Shinkevich wrote:
>>>
>>>
>>> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>>>> Currently, block_copy operation lock the whole requested region. But
>>>> there is no reason to lock clusters, which are already copied, it will
>>>> disturb other parallel block_copy requests for no reason.
>>>>
>>>> Let's instead do the following:
>>>>
>>>> Lock only sub-region, which we are going to operate on. Then, after
>>>> copying all dirty sub-regions, we should wait for intersecting
>>>> requests block-copy, if they failed, we should retry these new dirty
>>>> clusters.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> =C2=A0=C2=A0 block/block-copy.c | 116 ++++++++++++++++++++++++++++++++=
+++++--------
>>>> =C2=A0=C2=A0 1 file changed, 95 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>>> index 20068cd699..aca44b13fb 100644
>>>> --- a/block/block-copy.c
>>>> +++ b/block/block-copy.c
>>>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_infli=
ght_req(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> =C2=A0=C2=A0 }
>>>> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState=
 *s,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t bytes)
>>>> +/*
>>>> + * If there are no intersecting requests return false. Otherwise, wai=
t for the
>>>> + * first found intersecting request to finish and return true.
>>>> + */
>>>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64=
_t start,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t end)
>>>> =C2=A0=C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req;
>>>> +=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req =3D block_copy_find_infl=
ight_req(s, start, end);
>>>> -=C2=A0=C2=A0=C2=A0 while ((req =3D block_copy_find_inflight_req(s, of=
fset, bytes))) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->w=
ait_queue, NULL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!req) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wait_queue, NULL);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return true;
>>>> =C2=A0=C2=A0 }
>>>> +/* Called only on full-dirty region */
>>>> =C2=A0=C2=A0 static void block_copy_inflight_req_begin(BlockCopyState =
*s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset, int64_t bytes=
)
>>>> =C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 assert(!block_copy_find_inflight_req(s, offset, by=
tes));
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, by=
tes);
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->offset =3D offset;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->bytes =3D bytes;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_init(&req->wait_que=
ue);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&s->inflight_re=
qs, req, list);
>>>> =C2=A0=C2=A0 }
>>>> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFligh=
tReq *req)
>>>> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyStat=
e *s,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req,=
 int64_t new_bytes)
>>>> =C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 if (new_bytes =3D=3D req->bytes) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 assert(new_bytes > 0 && new_bytes < req->bytes);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->copy_bitmap,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 req->offset + new_bytes, req->bytes - new_bytes);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 req->bytes =3D new_bytes;
>>>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wait_queue);
>>>
>>> Won't we get the performance degradation with that function frequent ca=
ll?
>>
>> Why do you think so? In IO most of performance depends on disk speed and=
 how
>> we organize requests sequence. The whole original series shows performan=
ce improvement.
>>
>> This patch reduces lock around request, locking only the part we are wor=
king on now,
>> this is for better interactivity. After calling block-status, the reques=
t is shrinked
>> to possibly unlock some other requests, waiting on the tail of our reque=
st.. Do you
>> have a better suggestion on this synchronization?
>>
>=20
> I cannot answer right away. One need to measure the performance in each c=
ase.

Measurements are done in the original (big) series
  "[RFC 00/24] backup performance: block_status + async"
  <20191115141444.24155-1-vsementsov@virtuozzo.com>
  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02335.html

and this series (part I) is a first step to it.

Currently, improving interactivity of parallel block-copy requests is not v=
ery
meaningful, as all requests from backup are one-cluster-sized, and improvin=
g
performance of parallel intersecting guest writes is a strange thing.

But finally, backup is refactored to be the only one call of block_copy for=
 the
whole disk, so this new locking of sub-requests becomes critical.

The only degradation I see, is that with this qemu_co_queue_restart_all, we=
 may
restart requests, which still intersects with shrinked request, they wake u=
p,
and go to the block_copy_wait_one again for nothing. This may be improved b=
y
dropping coroutine-queue, and use own list of waiting requests, and wake-up
only requests which do not intersect with shrinked request. But I think, th=
at it
is premature optimization which complicates the code. So, it may be done la=
ter
if needed. But I think that it doesn't worth it.

>=20
> Andrey
>>>
>>>> +}
>>>> +
>>>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *=
s,
>>>> + BlockCopyInFlightReq *req,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int ret)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->c=
opy_bitmap, req->offset, req->bytes);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_REMOVE(req, list);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->w=
ait_queue);
>>>> =C2=A0=C2=A0 }
>>>> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopySt=
ate *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0=C2=A0 }
>>>> -int coroutine_fn block_copy(BlockCopyState *s,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int64_t offset, uint64_t bytes,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>>> +/*
>>>> + * block_copy_dirty_clusters
>>>> + *
>>>> + * Copy dirty clusters in @start/@bytes range.
>>>
>>> %s/start/offset/ ?
>>>
>>>> + * Returns 1 if dirty clusters found and successfully copied, 0 if no=
 dirty
>>>> + * clusters found and -errno on failure.
>>>> + */
>>>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int64_t offset, int64_t bytes,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool *error_is_read)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>>> +=C2=A0=C2=A0=C2=A0 bool found_dirty =3D false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * block_copy() user is resp=
onsible for keeping source and target in same
>>>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset, s-=
>cluster_size));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(bytes, s->=
cluster_size));
>>>> -=C2=A0=C2=A0=C2=A0 block_copy_wait_inflight_reqs(s, offset, bytes);
>>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_begin(s, &req, offset, byt=
es);
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bytes) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t n=
ext_zero, cur_bytes, status_bytes;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv=
_dirty_bitmap_get(s->copy_bitmap, offset)) {
>>>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue; /* already copied */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_dirty =3D true;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes=
 =3D MIN(bytes, s->copy_size);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_zero=
 =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
>>>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 assert(next_zero < offset + cur_bytes); /* no need to do MI=
N() */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cur_bytes =3D next_zero - offset;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_be=
gin(s, &req, offset, cur_bytes);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D b=
lock_copy_block_status(s, offset, cur_bytes, &status_bytes);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_sh=
rink(s, &req, status_bytes);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->sk=
ip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bl=
ock_copy_inflight_req_end(s, &req, 0);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 s->progress_reset_callback(s->progress_opaque);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trace_block_copy_skip_range(s, offset, status_bytes);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset +=3D status_bytes;
>>>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_blo=
ck_copy_process(s, offset);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s-=
>copy_bitmap, offset, cur_bytes);
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_get_fr=
om_shres(s->mem, cur_bytes);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D b=
lock_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_is=
_read);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_put_to=
_shres(s->mem, cur_bytes);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_en=
d(s, &req, ret);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=
 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->progre=
ss_bytes_callback(cur_bytes, s->progress_opaque);
>>>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=
=3D cur_bytes;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end(&req);
>>>> +=C2=A0=C2=A0=C2=A0 return found_dirty;
>>>> +}
>>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_=
t bytes,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 while (true) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D block_copy_dir=
ty_clusters(s, start, bytes, error_is_read);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * IO operation failed, which means the whole block_copy request
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * failed.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Something was copied, which means that there were yield points
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * and some new dirty bits may appered (due to failed parallel
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * block-copy requests).
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here ret =3D=3D 0,=
 which means that there is no dirty clusters in
>>>
>>> there is no dirty cluster in
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requested region.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!block_copy_wait_one(s=
, start, bytes)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 No dirty bits and nothing to wait: the whole request is done */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0=C2=A0 }
>>>>
>>>
>>
>>
>=20


--=20
Best regards,
Vladimir

