Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F886C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5052468E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PaiFAgOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5052468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Z5s-0007XI-C1
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 01:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Z58-0006lq-J0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Z57-0000CQ-F9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:25:06 -0500
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:51939 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Z53-0000AE-O1; Fri, 28 Feb 2020 01:25:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WepKdpBuuhPsNZ70/xF5y1GzT7zCYhnzMqYHzdXOcpzNkRu/tn2pklPabThzmKpNUS/r6+P9Ezd2gw56Eq09JVAKc2kpYfstA91V92oxxKmWPv4rUhASdr+GYR3UI2DNwQjUZjirF7GPdndG71K5sZbp08jWlX8VmPh3Xllsh9t5wOA+JCVaB+3uIcWNjDyJLWVHZ1mfgwS7GNkFuEHYLfu/IrKlGjT+25KyLHycIVYV44Pky6rRo2wP3eseWSvvmCbEPlb75k6DbUidv/CxJrMOSiDez9gKrW+WeZ9hPcE/bHVAUZ9SYhXbX1vOc0RCGmDTSYKSWCVsDedzUbxtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niTiyMCeZ3V8hsGXg9likO6h21uY9riAu3MX+AIsKXc=;
 b=bXr4ln9SaUyxHJxfidqYg9LG3jgfyA8H2u+RwEZEyU5P93Ow0iLVI+AIZ0iBgoJnus4OCN+Gdd4Bfv8noIqGox72SAIZOpa88Is5+5ML+Ux4+Mg9v/u4C6y8t2KFYc5rT7ujUd7f+twkSzsPtxipnFqlOKDc+NiTPlavoiJh0mJxCUePHFC4FxCcHC8iUH/iJqKQfwVAzqN57/b3AlgAFtteI5fOHzUuDVerDDZaQtE+XTabRUl3d1fUd/DYu0Wl0REIrKZz6mMyF+xVkXToRhIHF7bUFT6vntuUWBPyPlkHtm/9nLl2Bs9GyiiiJHDDp23gbLAN5XIV+PACuV0Mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niTiyMCeZ3V8hsGXg9likO6h21uY9riAu3MX+AIsKXc=;
 b=PaiFAgOTexMlJNkKBkh3MretArvdq49sl2gdIRM4JYO33hHURY+JhmEHJcjz42SMpKHR9Pc/tKwmk71vyl7MZ8uHrH8NqBE7rePaKj9rqsTgeb56/lzMeB0LEZPWq6Y0AURQZuwXuazZwik6KJfepwlLviLe087AIY11gRhUMG0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3671.eurprd08.prod.outlook.com (20.177.113.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 28 Feb 2020 06:24:59 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.024; Fri, 28 Feb 2020
 06:24:59 +0000
Subject: Re: ping Re: [PATCH for-5.0 v2 0/3] benchmark util
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
 <e1efd3d2-b623-292b-67a9-e3cdd479f104@virtuozzo.com>
 <fca8ced2-b3c6-74db-0d70-11ac3304b273@virtuozzo.com>
 <1ae79aad-5405-cf95-1401-e93191e94033@virtuozzo.com>
 <20200227200912.GE4440@habkost.net>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200228092456923
Message-ID: <6db21690-941e-b9e0-c1cf-56b6b6ddb806@virtuozzo.com>
Date: Fri, 28 Feb 2020 09:24:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227200912.GE4440@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::34)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 06:24:58 +0000
X-Tagtoolbar-Keys: D20200228092456923
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18f3265-6862-46b4-9767-08d7bc16ef95
X-MS-TrafficTypeDiagnostic: AM6PR08MB3671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3671A675A6A915423FE34383C1E80@AM6PR08MB3671.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(86362001)(8936002)(81166006)(81156014)(8676002)(31696002)(6486002)(36756003)(4326008)(31686004)(6916009)(2906002)(26005)(478600001)(5660300002)(316002)(186003)(52116002)(16526019)(956004)(2616005)(16576012)(66476007)(66556008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3671;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPYgoIvgd3x6W2g21FIz/3N6tIv3qTr27LnYB5GxTgBhjgxpgoa30MAbFZowV7rPaA6ogvLaa2LPkWavpj2g9ukBSODp416sEGw34HDwUbi+YoiDP9NRuchE7kK7+r2ByTR2sRQxGjJ/1IVdyc6O3P1TXZQs8Qe25pbjhctwYZfmgFan2PjqM2fjsHYTMpv6mwmYeVU2Q1JxKZSG6sEkiFAKsEqu8GWMYUlT0NiRc8dhJ+EwSJ5UWmUN4O4PQxa6GpkX3yqo19ux2qayYsUsUX3VvV8ZtGyzW9B9ohOMVfrlV1Bipkwy78irQhv8uG604UHYBJKDsyaWyDjWK7t2BAjFM1RQ/wyWQiaCdjSE6y2iesZHgm8Cm5y2XraMoZYnEG1FqLn+2nAPcqG++6rOVZQtip1/SVyip4ahrMX0EXGRU87/fwyTPBycHjmINvQf
X-MS-Exchange-AntiSpam-MessageData: dv4efSz3PLIRCxOnAS5HCjZfRD79aQs2ubEAX4pmpdjs0G9RbOq3fQPa2ycfOtJKLE3oVXyy47EZXh5X/xnODzY7J+d1wmX3OllY3svRE77R8KCUy61Lnib7nf1BIkXq96o35GCerqCZukzagU/A2w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18f3265-6862-46b4-9767-08d7bc16ef95
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 06:24:59.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk+rBRSK83Oke85heQJQYj1A9t31j0mkO4VzM0ejn+2oTF/iNmUaL5GbV6gVaowEWUN6PqoomxX7hSAg5/wXzbFXOw61ZBjE9PE9c0ViIIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3671
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.130
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, crosa@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 23:09, Eduardo Habkost wrote:
> Sorry, this is due to lack of bandwidth of maintainers who can
> review those patches.
>=20
> I have one suggestion: if you make your script self-contained
> inside a scripts/ subdirectory, it would be simpler to merge it
> without detailed reviews from others.

That works for me

>=20
> The python/ subdirectory is supposed to appear on sys.path, so

Hmm. Ok, I think, we'll always be able to move shareable parts of simpleben=
ch
into python/ if needed. So it's OK to keep it in scripts. I just
thought that python/ is a new home for python scripts :) So, it's OK
to keep the whole thing at scripts/ for now.

> maybe simplebench.py and qemu/bench_block_job.py can stay there,
> but bench-example.py is not a loadable Python module and
> shouldn't be there.
>=20
> I see two possible options:
>=20
> a) Moving everything to a scripts/simplebench subdirectory.
> b) Moving only bench-example.py to scripts/, and do the sys.path
>     hacking the other scripts do.
>=20
> On either case, please add your name to MAINTAINERS as the
> maintainer of those new files.
>=20

OK, thanks!

>=20
> On Thu, Feb 27, 2020 at 04:18:00PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi!
>>
>> Is problem in "S: Odd fixes" in Python section of MAINTAINERS?
>>
>> Will it be correct, if I send a patch to MAINTAINERS, proposing
>> myself as maintainer of Python scripts and s/Odd fixes/Maintained/ ?
>>
>> And then just send pull request with this series, as "nobody minds"?
>>
>> 08.02.2020 13:36, Vladimir Sementsov-Ogievskiy wrote:
>>> pingg..
>>>
>>> Hi! Could it be merged at all?
>>>
>>> 20.01.2020 12:10, Vladimir Sementsov-Ogievskiy wrote:
>>>> ping
>>>>
>>>> 26.11.2019 18:48, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> Here is simple benchmarking utility, to generate performance
>>>>> comparison tables, like the following:
>>>>>
>>>>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 ------------=
-
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 backup-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup-2=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mirror
>>>>> ssd -> ssd=C2=A0 0.43 +- 0.00=C2=A0=C2=A0 4.48 +- 0.06=C2=A0=C2=A0 4.=
38 +- 0.02
>>>>> ssd -> hdd=C2=A0 10.60 +- 0.08=C2=A0 10.69 +- 0.18=C2=A0 10.57 +- 0.0=
5
>>>>> ssd -> nbd=C2=A0 33.81 +- 0.37=C2=A0 10.67 +- 0.17=C2=A0 10.07 +- 0.0=
7
>>>>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 ------------=
-
>>>>>
>>>>> This is a v2, as v1 was inside
>>>>>  =C2=A0 "[RFC 00/24] backup performance: block_status + async"
>>>>>
>>>>> I'll use this benchmark in other series, hope someone
>>>>> will like it.
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy (3):
>>>>>  =C2=A0=C2=A0 python: add simplebench.py
>>>>>  =C2=A0=C2=A0 python: add qemu/bench_block_job.py
>>>>>  =C2=A0=C2=A0 python: add example usage of simplebench
>>>>>
>>>>>  =C2=A0 python/bench-example.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 80 +++++++++++++++++++++
>>>>>  =C2=A0 python/qemu/bench_block_job.py | 115 ++++++++++++++++++++++++=
+++++
>>>>>  =C2=A0 python/simplebench.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 128 +++++++++++++++++++++++++++++++++
>>>>>  =C2=A0 3 files changed, 323 insertions(+)
>>>>>  =C2=A0 create mode 100644 python/bench-example.py
>>>>>  =C2=A0 create mode 100755 python/qemu/bench_block_job.py
>>>>>  =C2=A0 create mode 100644 python/simplebench.py
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>> --=20
>> Best regards,
>> Vladimir
>>
>=20


--=20
Best regards,
Vladimir

