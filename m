Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698A3C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CB4246D8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mkUox7Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CB4246D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05PF-0004Mh-CT
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j05Mj-0001qB-2m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j05Mh-00081B-Kj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:16:20 -0500
Received: from mail-eopbgr60122.outbound.protection.outlook.com
 ([40.107.6.122]:17294 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j05Mc-0007df-2F; Fri, 07 Feb 2020 10:16:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F80G26xsuMUdIPLRlnDgPRzliFXB6wX8e/AFbRFL5q+2CKFjKR2dKIdVe/HkEEsS46TwQ+f8eQ6Xk2bKdqHrd0elQkHAks/Or9Jil6gnlJy6RbxiN0MOG/Cye+fwUpVPa19XpVrJtROWCvYD+iUUUDHDTYkOOgMDd3FVHy032pNMFlBycnnRguVDAZcTm+r8pit5h/h1W4fbnPS99ljRCaVFB5mOwpFm7Bh4cNBKDg2q2NOYkkm+HEgNiY1zOBgMZTCnR0wSYN0PIAA3ido0ZSbTLuxPkioNUvqWQL3Qi4yPSo/MWxxhv7EThIuOQdqVaSgexliK2LMSoWZnFJwFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny2Kb8Ln/pkcHG3qOvGVt5VIRRcLetWKRE2V88l7Ms0=;
 b=b7Bm4fXZYOSQFgRFj+3uouSp8NsGYK+ER9AJfaRbSRJa116ZdexIdTGa8dO28u5NzN+szZ20BZ6HYQ0NgOQylLd4/ekzlleGZiKm6jtMyjjpOFKDtly8ADXQupc7y5f39FhYEjKbRaEXgqkvgq+wQLrdN4Pie17uMVLCqt6RzSMabpByquH1pg/jEhRZOC8GQZrkipV/bXC3R/Mhl/pJjaTLKkAdSuLB2u/FbHQkLAFrFdzc7by0S+mk+PtNqV+Yc8X1l6Zu/6ILVN3zP2NJUdJrVg7PQ9HShREQOE4E1BiIuLmsTFirP46VfGXOt8TDRQELarDRjpjnXVCKJBYejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny2Kb8Ln/pkcHG3qOvGVt5VIRRcLetWKRE2V88l7Ms0=;
 b=mkUox7NvKNQSNAbnCoTS/rAOZ0SViA+vNs1HH7GiP/u7PjCIKfZoO9bD3932aTMfmnMWTBeHXhqZerkLkzSrdjIl6MkxsYdI770WJMCrxvx/FT8u2cXZnTFrAkXxxXfXG0pAB/TWTVoBx0MQGiGrKcrHaz0EXDjb6OECETVL7Rg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3176.eurprd08.prod.outlook.com (52.135.164.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Fri, 7 Feb 2020 15:16:11 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 15:16:11 +0000
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
 <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
 <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
 <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
 <99dc03a7-f93a-bdee-f38d-ac5aae8a3ca9@virtuozzo.com>
 <33849f7f-1ae9-126c-28b8-f9a5602aa2d0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207181610209
Message-ID: <96aab671-23db-1917-983e-182312a41220@virtuozzo.com>
Date: Fri, 7 Feb 2020 18:16:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <33849f7f-1ae9-126c-28b8-f9a5602aa2d0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR02CA0088.eurprd02.prod.outlook.com
 (2603:10a6:7:29::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0088.eurprd02.prod.outlook.com (2603:10a6:7:29::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Fri, 7 Feb 2020 15:16:11 +0000
X-Tagtoolbar-Keys: D20200207181610209
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d810c301-0278-460a-7036-08d7abe0aa83
X-MS-TrafficTypeDiagnostic: AM6PR08MB3176:
X-Microsoft-Antispam-PRVS: <AM6PR08MB31766B0DFDFFCD11594CE931C11C0@AM6PR08MB3176.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(39850400004)(136003)(199004)(189003)(66476007)(66556008)(66946007)(86362001)(5660300002)(31696002)(2906002)(36756003)(81156014)(81166006)(478600001)(8676002)(8936002)(31686004)(4326008)(186003)(52116002)(26005)(53546011)(2616005)(956004)(316002)(16526019)(16576012)(6486002)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3176;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRS06HqZ2MqZy7hVvNeLxbdERfaq71JAEEnUXGKheMxJJ2d2z6VmXlE6bWV46AzYhcmlNQKTjTvvyWVPVkfY8gsegjQNtZTIGmWXnEmc9mj7g5/CKhEosQ/IsslOtUIXFRsLaxIzxpZTkusN80ZFL91RMPMqEZ/OnT4miLMvkqfRjBs197a0lW+7wnf60SXz4v3SWeiyXOUK2sIhqf0KEZsOa4JuhL6h2yIYpdYgCSxxo22+j8G6A8rg5Fl8hwBQAMhKYRxj/WlFoTCt3vMYnHmYGrxZKGN6fcDCfs5dG5MQIwx/PIeyMr/MKGugZHXlA4WUT5O6LFZzf6FMVaF/T0uOYroQNGOsGYzpq7JYgrSHGe//36NqLe0p+GCxccT/vYSATY9uPm4NiyV1A7novBG96So1dbg2vmMqGmUtJgm0Y3ZqNLDg51j4+qpThyP5
X-MS-Exchange-AntiSpam-MessageData: WQ7bi+MFPsX5n3HPMd1UFTzME0DTf3mx65xrdvb24XkK0eGeXkImWaaDoK34yZ5LiH8r7S5vMyXNzN9YuTx4MQjMTl61UCZXL148yWAeHHOrWH4I/6bPyONKBbqdrKAXkqbAmd4ylecWhqKag7K6+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d810c301-0278-460a-7036-08d7abe0aa83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:16:11.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An4pXidsCYDW33/7iExhMWWgInG7+qzxlPu8AEAkSPNUAI3R39oUtyqPcU7DPu8XLZeshp86BNGDrtVrMnarZKuATEcUxGkb5NGX7zzHJHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3176
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.122
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 18:03, Max Reitz wrote:
> On 07.02.20 15:53, Vladimir Sementsov-Ogievskiy wrote:
>> 07.02.2020 17:41, Max Reitz wrote:
>>> On 07.02.20 13:07, Vladimir Sementsov-Ogievskiy wrote:
>>>> 07.02.2020 13:33, Max Reitz wrote:
>>>>> On 04.02.20 15:23, Eric Blake wrote:
>>>>>> On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>
>>>>>>>> I understand that it is safer to have restrictions now and lift th=
em
>>>>>>>> later, than to allow use of the option at any time and leave room
>>>>>>>> for
>>>>>>>> the user to shoot themselves in the foot with no way to add safety
>>>>>>>> later.=C2=A0 The argument against no backing file is somewhat
>>>>>>>> understandable (technically, as long as the backing file also read=
s
>>>>>>>> as all zeroes, then the overall image reads as all zeroes - but wh=
y
>>>>>>>> have a backing file that has no content?); the argument requiring =
-n
>>>>>>>> is a bit weaker (if I'm creating an image, I _know_ it reads as al=
l
>>>>>>>> zeroes, so the --target-is-zero argument is redundant, but it
>>>>>>>> shouldn't hurt to allow it).
>>>>>>>
>>>>>>> I know that it reads as all zeroes, only if this format provides ze=
ro
>>>>>>> initialization..
>>>>>>>
>>>>>>>>
>>>>>>>>> +++ b/qemu-img.c
>>>>>>>>
>>>>>>>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char
>>>>>>>>> **argv)
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 warn_report("This will become an error in future QEMU
>>>>>>>>> versions.");
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--targe=
t-is-zero requires use of -n flag");
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>
>>>>>>>> So I think we could drop this hunk with no change in behavior.
>>>>>>>
>>>>>>> I think, no we can't. If we allow target-is-zero, with -n, we'd
>>>>>>> better
>>>>>>> to check that what we are creating is zero-initialized (format has
>>>>>>> zero-init), and if not we should report error.
>>>>>>>
>>>>>>
>>>>>> Good call.=C2=A0 Yes, if we allow --target-is-zero without -n, we MU=
ST
>>>>>> insist
>>>>>> that bdrv_has_zero_init() returns 1 (or, after my followup series,
>>>>>> bdrv_known_zeroes() includes BDRV_ZERO_CREATE).
>>>>>
>>>>> Why?
>>>>>
>>>>> I could imagine a user creating a qcow2 image on some block device wi=
th
>>>>> preallocation where we cannot verify that the result will be zero.=C2=
=A0 But
>>>>> they want qemu not to zero the device, so they would specify
>>>>> --target-is-zero.
>>>>
>>>> If user create image, setting --target-is-zero is always valid. But if
>>>> we in
>>>> same operation create the image automatically, having --target-is-zero=
,
>>>> when
>>>> we know that what we are creating is not zero is misleading and should
>>>> fail..
>>>
>>> bdrv_has_zero_init() doesn=E2=80=99t return false only for images that =
we know
>>> are not zero.=C2=A0 It returns true for images where we know they are.=
=C2=A0 But
>>> if we don=E2=80=99t know, then it returns false also.
>>
>> yes, but we don't have better check.
>=20
> Correct, but maybe the user knows more, hence why it may make sense for
> them to provide us with some information we don=E2=80=99t have.
>=20
>>>> If we want to add a behavior to skip zeros unconditionally, we should
>>>> call new
>>>> option --skip-zeroes, to clearly specify what we want.
>>>
>>> It was my impression that this was exactly what --target-is-zero means
>>> and implies.
>>>
>>
>> For me it sounds strange that user has better knowledge about what Qemu
>> creates than Qemu itself. And if it so - it should be fixed in Qemu,
>> rather than creating user interface to hint Qemu what it does.
>=20
> I brought an example where qemu cannot know whether the image is zero
> (preallocation on a block device), but the user / management layer might
> know.
>=20

It sounds unsafe for me. User can't know how exactly Qemu do preallocation,
which syscalls it calls, etc. How can user be sure, that Qemu produces
all-zero image, if even Qemu doesn't sure in it?

Otherwise, we should document, how exactly (up to syscalls, their
parameters, flags, the whole logic and algorithm) preallocation is done,
so user can analyze it and be sure that produced image would be all-zero
(when Qemu can't determine it because some specific block device, for which
Qemu doesn't know that its preallocation algorithm produces all-zero, but
user is sure in it)...



--=20
Best regards,
Vladimir

