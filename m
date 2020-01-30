Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC3D20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d3JTZy/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC3D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCKR-0005XT-AY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixCJe-0004xV-Dn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixCJc-0001Ze-Ae
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:05:14 -0500
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:33091 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixCJb-0001Tt-C3; Thu, 30 Jan 2020 11:05:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSofFuRo7A9py7nBv9X0PrtaUcsHxTVoRvvJi+QmBDmUk7dOAewC6aU3ysWxryNMGmWcTl41jtxLBM6FpdW71dwVxC1VVEVTQVd2Q/v1jDkTmBdehI+1pp5Xtopyv8CCBMijNP8RcF671llOM/8bopqCNiEk4g91MzJwY62XtUBLr6DoCYrQQ10Zi6R89/E+kMZZum1ERRMMCuQiRrx/YRNdUuqpptwmpGzbW6rrJ9yh1z8wJr9Jiot4RiP8VrH9TXup3HWJWxCeKnJrqZWLIQZ4Ucme+wE4U3iG5qIgInjkoCZ/AxlnpH7gkwQ57Z861CB9Kxv3Hl3Ye8lT8nC1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+1GfuR0pNXIUxtOx9RQN3CXxFHXPIozExZ06wkNAtE=;
 b=Vxv7tzCi1DElqF+A693lXgVStcR+X4z5kJrUEIA0NdGIiZVk8YeUjXMdWg4+6bHWY502D5JC+ZnFJL8Rbms2AeO3WJiSa0OBvruQw2svXvaeLjfgTS+wYPB0YdgAkNRkr1SIlcFJjRD9XvevAbiRPBytvpkNwoan4emQ30YWOAVW4oE/dduqwps+bqngA8uw616xwX966vF0PsRg4hCrbGB3d/Nh9uAQouSHOE9Aj3RNz2YNNNL1xlu+y3MRwtYDClZ+yfwe4wgv57HOYvp9EVEHPJUoMwyPHeVi/Zmfvg/aRYVU6EoZGthRrJlUKU6HVpoJHX+tCi7EPG0L5TyV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+1GfuR0pNXIUxtOx9RQN3CXxFHXPIozExZ06wkNAtE=;
 b=d3JTZy/Wb/GDeKXVtfxhQpNvYZOIuoj0MR3spaJ4WYhiylkQNOeTyTT7qj9HWX83OnA537Y3kApO7LVu7BxEXog1jqBSIXvIWbcFAEQGwQigCu49cjb1iroBDP5Ja+fHnSxoevJsejCGh/PXptdq59o7OmP9ZvxRLvZWcvyHJK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4086.eurprd08.prod.outlook.com (20.179.1.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 16:05:07 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 16:05:07 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <6c548cdd-f8c5-20a3-cce2-101e2f4436b0@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130190504903
Message-ID: <33973892-44c0-cd4c-ecac-e0a1a1d9a761@virtuozzo.com>
Date: Thu, 30 Jan 2020 19:05:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <6c548cdd-f8c5-20a3-cce2-101e2f4436b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 16:05:06 +0000
X-Tagtoolbar-Keys: D20200130190504903
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94c4637e-54df-41df-e1e8-08d7a59e2cf9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB408699F670293EAB4CDE4049C1040@AM6PR08MB4086.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(4326008)(31696002)(6486002)(478600001)(86362001)(36756003)(26005)(16576012)(5660300002)(8936002)(316002)(66946007)(52116002)(66556008)(16526019)(2906002)(53546011)(186003)(8676002)(66476007)(2616005)(81166006)(956004)(81156014)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4086;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VN+5xfXhy5hyv57JKTB01/utea09HfAvFct1DelNsbEdmqcNMJuddBkUyViiuOEheDXJ0S4js4WWhr5ZuMPoH2A+OxLAtmntQqB7o9kKLNIF8sldJ9OMB5UOXPXl1MxKfJxG+SpN2NR2L8Q3p4Lft03nU8fnugn3icZ8icDsorMYV9QNKmClxL3/zsuylwq0MM2sAYzeSV+EC18ibm3LZKhfAfk/nE6M2ht3i1hKhDj8pQtFINkuBIo8E0fvWy6rbjBxHFZctPeePfXMd+zNUcn4g0v57+OZfA5qy5H4QuzZIvJdXgwpV8t4wtdDtS0Fj2/lptBNopRIFE4JuDFT0EEI5dSXPJhAp27G8a7WZ+4XSv69gJY1YkdcvKdfxqgC9qQRs4Hrm8YBy7wzaSnn0T/4G1qAHua3An9/jgrNHzsVLpt2MH+dV7Bsq7BCL7O
X-MS-Exchange-AntiSpam-MessageData: lkYRZ6PebSqr4GwZX5ywGcbUAjBT8WPeEc4V6j5oEwL/y0DgXN69yVFSW8nNWvxQ5J+tZPTVnHgJT+xaIoxFmCU+XUndKeU3lQ2tkATM5G7S+WkNGT0LFZiqOI7Hc+u9atoIJTe2j1wD2HVOOOCd6Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c4637e-54df-41df-e1e8-08d7a59e2cf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 16:05:07.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4trIPSFGaTjY9e5ahK4j4mN+nbaHSBepz3l+POVpqb9UdIme13s3zmG3LTb9J8o6LUhGxbPaaeZ1P26qoT+da/eCRCQfIq4Niy9a63wOas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4086
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.01.2020 18:53, Andrey Shinkevich wrote:
>=20
>=20
> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>> Currently, block_copy operation lock the whole requested region. But
>> there is no reason to lock clusters, which are already copied, it will
>> disturb other parallel block_copy requests for no reason.
>>
>> Let's instead do the following:
>>
>> Lock only sub-region, which we are going to operate on. Then, after
>> copying all dirty sub-regions, we should wait for intersecting
>> requests block-copy, if they failed, we should retry these new dirty
>> clusters.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++---=
-----
>> =C2=A0 1 file changed, 95 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 20068cd699..aca44b13fb 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_infligh=
t_req(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0 }
>> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *=
s,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t bytes)
>> +/*
>> + * If there are no intersecting requests return false. Otherwise, wait =
for the
>> + * first found intersecting request to finish and return true.
>> + */
>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t=
 start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t end)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req;
>> +=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req =3D block_copy_find_inflig=
ht_req(s, start, end);
>> -=C2=A0=C2=A0=C2=A0 while ((req =3D block_copy_find_inflight_req(s, offs=
et, bytes))) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wai=
t_queue, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (!req) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_wait(&req->wait_queue, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> +/* Called only on full-dirty region */
>> =C2=A0 static void block_copy_inflight_req_begin(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset, int64_t bytes)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 assert(!block_copy_find_inflight_req(s, offset, byte=
s));
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, byte=
s);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->offset =3D offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->bytes =3D bytes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_init(&req->wait_queue);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&s->inflight_reqs, req,=
 list);
>> =C2=A0 }
>> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightR=
eq *req)
>> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState =
*s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req, i=
nt64_t new_bytes)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 if (new_bytes =3D=3D req->bytes) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(new_bytes > 0 && new_bytes < req->bytes);
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->copy_bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 req->offset + new_bytes, req->bytes - new_bytes);
>> +
>> +=C2=A0=C2=A0=C2=A0 req->bytes =3D new_bytes;
>> +=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wait_queue);
>> +}
>> +
>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int ret)
>=20
> I suggest substituting the 'int ret' parameter with someone like 'bool se=
t_dirty' and pass the expression 'ret < 0' as the input parameter in callin=
g function. The 'int ret' is used in QEMU as a local return variable tradit=
ionally.


"int ret" is normal practice also for completion functions, look at bdrv_co=
_io_em_complete, bdrv_co_write_req_finish, do git grep 'int ret)'

>=20
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_dirty_bitmap(s->cop=
y_bitmap, req->offset, req->bytes);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_REMOVE(req, list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(&req->wait_queu=
e);
>> =C2=A0 }
>> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyStat=
e *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> -int coroutine_fn block_copy(BlockCopyState *s,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int64_t offset, uint64_t bytes,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>> +/*
>> + * block_copy_dirty_clusters
>> + *
>> + * Copy dirty clusters in @start/@bytes range.
>> + * Returns 1 if dirty clusters found and successfully copied, 0 if no d=
irty
>> + * clusters found and -errno on failure.
>> + */
>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int64_t offset, int64_t bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool *error_is_read)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> -=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>> +=C2=A0=C2=A0=C2=A0 bool found_dirty =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * block_copy() user is responsible =
for keeping source and target in same
>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset, s->cluster=
_size));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(bytes, s->cluster_=
size));
>> -=C2=A0=C2=A0=C2=A0 block_copy_wait_inflight_reqs(s, offset, bytes);
>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_begin(s, &req, offset, bytes=
);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bytes) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCopyInFlightReq req;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t next_zero=
, cur_bytes, status_bytes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_dirty_b=
itmap_get(s->copy_bitmap, offset)) {
>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue; /* already copied */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_dirty =3D true;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes =3D MIN=
(bytes, s->copy_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_zero =3D bdr=
v_dirty_bitmap_next_zero(s->copy_bitmap, offset,
>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cur_bytes =3D next_zero - offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_begi=
n(s, &req, offset, cur_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D block_cop=
y_block_status(s, offset, cur_bytes, &status_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_shri=
nk(s, &req, status_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->skip_unall=
ocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bloc=
k_copy_inflight_req_end(s, &req, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->progress_reset_callback(s->progress_opaque);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 trace_block_copy_skip_range(s, offset, status_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 offset +=3D status_bytes;
>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_block_copy_=
process(s, offset);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(s->c=
opy_bitmap, offset, cur_bytes);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_get_from_shres=
(s->mem, cur_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D block_cop=
y_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_is_read);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co_put_to_shres(s=
->mem, cur_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end(=
s, &req, ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->progress_bytes=
_callback(cur_bytes, s->progress_opaque);
>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=3D cur_by=
tes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 block_copy_inflight_req_end(&req);
>> +=C2=A0=C2=A0=C2=A0 return found_dirty;
>> +}
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t =
bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>> +{
>> +=C2=A0=C2=A0=C2=A0 while (true) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D block_copy_dirty=
_clusters(s, start, bytes, error_is_read);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * IO operation failed, which means the whole block_copy request
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * failed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Something was copied, which means that there were yield points
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * and some new dirty bits may appered (due to failed parallel
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * block-copy requests).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here ret =3D=3D 0, w=
hich means that there is no dirty clusters in
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requested region.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!block_copy_wait_one(s, =
start, bytes)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* N=
o dirty bits and nothing to wait: the whole request is done */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>=20


--=20
Best regards,
Vladimir

