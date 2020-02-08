Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F71CC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6475520726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jTysmf3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6475520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PfL-00071t-L5
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0Peb-0006Rw-2v
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0PeW-0006Wx-Rt
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:56:06 -0500
Received: from mail-db8eur05on2114.outbound.protection.outlook.com
 ([40.107.20.114]:59616 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j0PeV-0006PP-KV; Sat, 08 Feb 2020 07:56:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaanUKMhdJHrF3DFDX8NBVmssqEoZVbyPWyg3yh6vYsCOy4y7gX8QmfXKmdhx7PidGurflT5XcKwUh7Wl80kW0zm67WPnI68Gjlpif4rQmMCTMfA8QGw+tX3Dc2RIQEdbet4Awad4EcSrmm/pjWw0kjbsyF4d9HXB1U+MpT3SVsIo8uHHvE9o1hoBn5ocuf1MmWMoRrEuEnGvQAjPxF0rc3mb8PWuCyoOP2T73l5dpX8XzCdLjq92oKUq/NPv9wzSVl8EqSf443PVDJIZl/0preBpTRY+Q4nic9OPMmxcugzQLF3YCoyHH8UccKMv2QWyNQbkXyEIaKtIcrdaXa3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfozLtDnbILPhvV7/1WZAnYlctOOyurNwKBLF2Au47I=;
 b=Lf414+/vikTTkzC1pPOdTuNsZJbIL+dWJYG+IrCM4ZO3bdRYBZ/TeJ2yk9f7pjEHxWG3VkDCdFnBzT08hGnABhdcQ3mNcAI9EcFsl7J6PvQ6VSTCPGhGDz4RQY2duoptQZF0kTcyY1dQl/qihKaaUCqECYOlebWvn35F2QZPQjgmcOGpPlgiqTANZOiVafGjQ/7hy1xnoCFIM8jateHag8Qvu6lKiF+w5i0aYrKLsbf98bBSWkS1091e02EFWBEKWgqf8RLtTLrglUMo6SFmf9eHljxwQ3ak3tmxmkbaeMpOcVofg/rD2p14bvZ6BTvsTKKIR9RHgQR/JPhHxK3m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfozLtDnbILPhvV7/1WZAnYlctOOyurNwKBLF2Au47I=;
 b=jTysmf3AkhvF3bK54411zLl3AtUSNZt2SERyKwOLd9nDm9tusVaqSgXgpf023Lj1JvbC/rZ5qVrv6igrUA/252CGJAzEgOsGzHOr4seDvE0MqElHH99VovzKqZ5pzz4XXPmG0udAjM/SHOJu63TEVwVqeOsF4/L3mXCM8PjvFmQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4772.eurprd08.prod.outlook.com (10.255.99.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Sat, 8 Feb 2020 12:55:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 12:55:53 +0000
Subject: Re: [PATCH v2 4/7] block/block-copy: refactor interfaces to use bytes
 instead of end
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-5-vsementsov@virtuozzo.com>
 <b41bd0ca-07f6-27e5-b6c7-eefa2a4826ba@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200208155551141
Message-ID: <8e787b7a-6997-fcd4-1eec-4cf3b52c5c2a@virtuozzo.com>
Date: Sat, 8 Feb 2020 15:55:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <b41bd0ca-07f6-27e5-b6c7-eefa2a4826ba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0701CA0086.eurprd07.prod.outlook.com
 (2603:10a6:3:64::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0086.eurprd07.prod.outlook.com (2603:10a6:3:64::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.9 via Frontend Transport; Sat, 8 Feb 2020 12:55:52 +0000
X-Tagtoolbar-Keys: D20200208155551141
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 048909a4-a9e5-4bf5-30c3-08d7ac963afe
X-MS-TrafficTypeDiagnostic: AM6PR08MB4772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB477297360A0C621338C9BC1DC11F0@AM6PR08MB4772.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(346002)(39850400004)(376002)(189003)(199004)(6486002)(86362001)(186003)(478600001)(16526019)(26005)(53546011)(81156014)(81166006)(52116002)(31686004)(8676002)(8936002)(956004)(2616005)(31696002)(316002)(66476007)(66556008)(66946007)(16576012)(2906002)(5660300002)(4326008)(107886003)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4772;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekfMowjgau4NhkYDH2dQR16WTsF14FwTd/fMFF8RQp7EXkmBIK0kRq8sB1lasDRNsJPdWPpEcguYa+StXukpP8mIY74Wjce30p4zrLn3lBBXM5HOwdLKMRWb6r3OXFNSgOEBXaWZC4vsX5zYqYs/QViJsnLYI8dFHpZqqknegyMO87SyTTN2qv9zKZ9GD+C3nHCxJdi2eq1ULq60AhR3ReFPtGK1/5EjytZuK47GcNVWVfzpwn53myRBglToxmPOdt2hTC/X1SLnUetDXMhTQhih4vUi2f0MVTZfQll8Lr+vXOWn5B/00cbl3/y5KZKj9+ZoT7FtbnEovmuj1iQHA5VDL9XWaa7d3GXUddgRh7Q+ZJiJnNSWM5SYM982FBD0+72Jt2bpmKb9hEuYnhdLYXtXxwNV6PBoAPq+ZLiDBfZcQeqyAeLbNVzI9IwQakEF
X-MS-Exchange-AntiSpam-MessageData: GLBEjW60A6HZ6rgWgK4EBpEY3RBpIfRnDpgjeXoGr4exTR9UFJRT3DOFC/LU7cCrzfH4+EUSZxnpMvB96nGEG+Naeu4f1GfshCzClov4gu6Yn/UO5CDJw05zAoWRko38eB2D8zdgbhYuQHhgLo+uow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048909a4-a9e5-4bf5-30c3-08d7ac963afe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 12:55:53.2112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pkQoVx9kOrn0dD7bLtXzK7oQB+RNUAD4WRtGgxq/z227EgZg+ABTrW7I+qM6GsCj3Z7CWWXtGwA7kdasDXDpoekhFxoZIG3+uyV9OOgjyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4772
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.114
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 21:01, Max Reitz wrote:
> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
>> We have a lot of "chunk_end - start" invocations, let's switch to
>> bytes/cur_bytes scheme instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h |  4 +--
>>   block/block-copy.c         | 68 ++++++++++++++++++++------------------
>>   2 files changed, 37 insertions(+), 35 deletions(-)
>=20
> [...]
>=20
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 94e7e855ef..cc273b6cb8 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>=20
> [...]
>=20
>> @@ -150,24 +150,26 @@ void block_copy_set_callbacks(
>=20
> [...]
>=20
>>   static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
>> -                                           int64_t start, int64_t end,
>> +                                           int64_t start, int64_t bytes=
,
>=20
> I wonder whether it would make more sense to make some of these @bytes
> parameters plain ints, because...
>=20
>>                                              bool zeroes, bool *error_is=
_read)
>>   {
>>       int ret;
>> -    int nbytes =3D MIN(end, s->len) - start;
>> +    int nbytes =3D MIN(start + bytes, s->len) - start;
>=20
> ...things like this look a bit dangerous now.  So if the interface
> already clearly shows that we=92re always expecting something less than
> INT_MAX, it might all be a bit clearer.

Hmm, yes. And it's preexisting, just becomes more obvious with new semantic=
s.
All block-copy tasks are limited to s->copy_size so it's actually safe.
I'd better add an assertion, as I believe that 64bit write_zeroes will appe=
ar in not far future.

>=20
> I=92ll leave it up to you:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20


--=20
Best regards,
Vladimir

