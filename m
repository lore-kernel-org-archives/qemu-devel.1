Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3CC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1F621741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QHKMpNKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1F621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Aw-0004bF-8D
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j050d-00022Y-Le
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j050c-0003xN-FH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:53:31 -0500
Received: from mail-eopbgr80110.outbound.protection.outlook.com
 ([40.107.8.110]:3320 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j050Y-0003eO-7O; Fri, 07 Feb 2020 09:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6e6GYD4BB/O5O6xQc9eaoZUwFzVSxd3ShSrBQwNkntN4sQAzxzvYEGlwBuMN2PMvuqiS9WoqBToZzDuna5SksPfGwn38xF56/NIWUjCfFSpkv2QGf6gUxEs/2byeq5eCG7pfsGxd0HZHSHpprhUrcg8cmnN9KCqP9BCv/zye7V4M7uUq2I/7VTs8BUHkTeaTxcJp0WeQ475SwWnoXMxTWHx839wu1+87HiwKBgJu5ikBI2a4ijOo8LKsB2mDOz8yuc8w7b06xzCd9qv0YayP9Ik+taaOLE2v1Cj6R1DKvdOcILkyKI2d8pwnEH0qGMAprsS6qCC8ismwX79I/+2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06oVgLbcn/mpLeFfk6cdXd72HZOfMAqAqN3Xms4wfMA=;
 b=S2Q5jvZH/Cew6PgSnw3ufIp0Yvza/ChTAqKAjOiZqSiU92qgw72u0zcuEjzIlp0RymBQDJ+GB/VuYZ5LkowqrGWzyI+6pooX4ckTHP8gtlJWbLyziqXfjeNM4+PFgA1+1yD1Sf1p8cYVFB+8xeegz+hvFv+VPMB7ZH6+5CEDtGJTXLEXTo3VipdL+/KLNVlqQJREH4wPREl95bsfuhq4TBlYruqV8PVdk/Owy1gKU2t/s0T90IgnZiNBVGMQ3Ee8pGTBZPmkWb+nEIEnciBYn0dRI2vcEvJJ9H1utpbOIeog0IVYlxC3vYmhrEDhauPX+slavBH3UxysQ1zQQTjl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06oVgLbcn/mpLeFfk6cdXd72HZOfMAqAqN3Xms4wfMA=;
 b=QHKMpNKOJofhyocEJr2xb8c5xTFTDg+nIQMV8x3rAjaYZCjnNghaOlk4DUUJfh4nAjszPvVQmN68tH1gDDHNLDk5s/rh2neSq2WucrmR3nJA4cwOI3ekBtqwxx6A/g+Egh73ehjK6rfdSgFxX/RLe/0bZAbBvFrL1diyTFVmdfc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4280.eurprd08.prod.outlook.com (20.179.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 14:53:23 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 14:53:23 +0000
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
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207175321466
Message-ID: <99dc03a7-f93a-bdee-f38d-ac5aae8a3ca9@virtuozzo.com>
Date: Fri, 7 Feb 2020 17:53:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0215.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0215.eurprd05.prod.outlook.com (2603:10a6:3:fa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 14:53:23 +0000
X-Tagtoolbar-Keys: D20200207175321466
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2724e587-032d-492c-a3a1-08d7abdd7ae2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4280:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4280042DFB3E8E83725BA179C11C0@AM6PR08MB4280.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39850400004)(189003)(199004)(4326008)(52116002)(8676002)(81156014)(26005)(81166006)(186003)(2616005)(86362001)(66946007)(66556008)(66476007)(16526019)(2906002)(8936002)(31696002)(53546011)(956004)(6486002)(478600001)(31686004)(110136005)(16576012)(36756003)(5660300002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4280;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgb+ZiKeoWkNx25qkdcL/3X8M8gkBBlBX1SER7FsQqr45xf5kW5QIjh2doylcmDQCWIQjzM1rqLP5BkXYr7TbKoPzWQaeSdASOpDoHl6lSmggcjUR3duzD+U1yC3ZNXWu9ffCta6sMPnnMrZzZuF5WEGQbgpnLTAMrAcWH2YyhP8Y3E7RWoNozlTKAoN+jb/ll6pH+I7XuICQVk1ZoOcrBOhiNCUSGYjfwScxq1qzPZ1vjfZpoXeJ1UT7Y3jpS6nm/4X7SHPlDTiKw9K0cy2I9rBynnFLORa+4w/64yzVgq5yB+h76/lEh4GZDM8fwQxMCMhchBHGqXcYEgmI+QpkFoklqRXm8yG9qIGM+ZgihRm+a7GPbg67laMX+DZP5+PI4jHd9gY7Ro4ShZ+1C0Unj7ep30QTulzYWEzl0XsWC+4uU1wzoApGvXI7CyLHtch
X-MS-Exchange-AntiSpam-MessageData: V5qHplhPt4cny7njPaKq+WN7oLacuaRKAKqlzyBEVRFqpjLHqonHu+p1gSnJuSTgU3ZLNS9mJAAhNvrDxBDkfKZJngGI3wNZy9VqqFJ9NrHaFVhKf1H19TqAcrmWmjjnOW2ODZYMFIkmq86hCOu5bg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2724e587-032d-492c-a3a1-08d7abdd7ae2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 14:53:23.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L12EbgxkvuVZJ9U7+oe/kjE+i4Xka2WdOL5OILMvVdfeBPfH13kp63Kw3yhIRimCm1OUdQeTiJcY6N8boY+zd21Q5VvAPigWJPOVElPWSmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4280
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.110
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

07.02.2020 17:41, Max Reitz wrote:
> On 07.02.20 13:07, Vladimir Sementsov-Ogievskiy wrote:
>> 07.02.2020 13:33, Max Reitz wrote:
>>> On 04.02.20 15:23, Eric Blake wrote:
>>>> On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>
>>>>>> I understand that it is safer to have restrictions now and lift them
>>>>>> later, than to allow use of the option at any time and leave room fo=
r
>>>>>> the user to shoot themselves in the foot with no way to add safety
>>>>>> later.=C2=A0 The argument against no backing file is somewhat
>>>>>> understandable (technically, as long as the backing file also reads
>>>>>> as all zeroes, then the overall image reads as all zeroes - but why
>>>>>> have a backing file that has no content?); the argument requiring -n
>>>>>> is a bit weaker (if I'm creating an image, I _know_ it reads as all
>>>>>> zeroes, so the --target-is-zero argument is redundant, but it
>>>>>> shouldn't hurt to allow it).
>>>>>
>>>>> I know that it reads as all zeroes, only if this format provides zero
>>>>> initialization..
>>>>>
>>>>>>
>>>>>>> +++ b/qemu-img.c
>>>>>>
>>>>>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv=
)
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_=
report("This will become an error in future QEMU
>>>>>>> versions.");
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-=
is-zero requires use of -n flag");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> So I think we could drop this hunk with no change in behavior.
>>>>>
>>>>> I think, no we can't. If we allow target-is-zero, with -n, we'd bette=
r
>>>>> to check that what we are creating is zero-initialized (format has
>>>>> zero-init), and if not we should report error.
>>>>>
>>>>
>>>> Good call.=C2=A0 Yes, if we allow --target-is-zero without -n, we MUST=
 insist
>>>> that bdrv_has_zero_init() returns 1 (or, after my followup series,
>>>> bdrv_known_zeroes() includes BDRV_ZERO_CREATE).
>>>
>>> Why?
>>>
>>> I could imagine a user creating a qcow2 image on some block device with
>>> preallocation where we cannot verify that the result will be zero.=C2=
=A0 But
>>> they want qemu not to zero the device, so they would specify
>>> --target-is-zero.
>>
>> If user create image, setting --target-is-zero is always valid. But if
>> we in
>> same operation create the image automatically, having --target-is-zero,
>> when
>> we know that what we are creating is not zero is misleading and should
>> fail..
>=20
> bdrv_has_zero_init() doesn=E2=80=99t return false only for images that we=
 know
> are not zero.  It returns true for images where we know they are.  But
> if we don=E2=80=99t know, then it returns false also.

yes, but we don't have better check.

>=20
>> If we want to add a behavior to skip zeros unconditionally, we should
>> call new
>> option --skip-zeroes, to clearly specify what we want.
>=20
> It was my impression that this was exactly what --target-is-zero means
> and implies.
>=20

For me it sounds strange that user has better knowledge about what Qemu
creates than Qemu itself. And if it so - it should be fixed in Qemu,
rather than creating user interface to hint Qemu what it does.



--=20
Best regards,
Vladimir

