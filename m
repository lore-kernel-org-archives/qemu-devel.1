Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F3E206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F0yqUUn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F3E206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHIU-0001si-BT
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJHGj-00005D-Ny
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJHGh-0002R4-Nb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:49:29 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:4427 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJHGg-0002PP-V9; Tue, 31 Mar 2020 09:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7D9HcvqCj3yNa5SbsrKpWCiewBBZoMdJxljq2lKHcd9PbKQmZWaKnoLDaHCX+meatqCroWDND+ENa5RydCcq5AGo/OwDma1A9j+Ip7wxCQbkVuwYdOM0mvKNUTl+AzIWHSqnx1EcJbN7m9kWhqi2O9yKJcG9rbWHoHOVjbzn6rpJ6mpNn+4EQpy/139Xds1V0pMP0xqbw+8SAWtIOM2EuzOAtb4VyVdSQeYLfbgqskajZGeVT+RBuuER2cfHF9XevsxEgAhMFhTz8cwYS3BWFh8CjGDFSqlBOb3Z1OB9w7WpyVdoJisppizzMyCkxxIaQEQE/tKVak5e7aB4eTIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOw7EKBhv6aZPmd4N3dPrSAr+5SGuu9jJAlnhvM/SfU=;
 b=is/uJf3TzEF7G84KaU6WFJTLLBV3M9gC7p3XE6wuIyAAlC1YZsTWXyuJf8n2xQ/oztCRUNfcNP7U1Ql4fieq+ObT8wz/w0ECeUAbfWithjCDDtzVKaqLXldtclsAxY8hJwRXuJVxI3D7kW2vKqesavel06C2dcbMAS+KpaTFV07+ohn1bLH4Ml/ughr35BCHlbashr+2v7phZ3RBqZvQSFJH+YUOAZClLB5gMDsPoRfjtFUD0hpqzZMPbf5fGPc8acFWlV7ZHkcbadam2ul2G+DgytzTobETTyEhixpZasLHfVs7P+MCCLPuZQJvA+szEtqTswvkaEMmq0/XmnZwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOw7EKBhv6aZPmd4N3dPrSAr+5SGuu9jJAlnhvM/SfU=;
 b=F0yqUUn007xvCHkMg+g/C0F0/8br38nDAjmtTL+d34fm2NnOUx2Q6F3xnVkKg8JMq+0S3tInlshyUGjTAvjG96VXMCv8wxREWUnslCl2L3HGB18Shee7j+Uv1ddwJWBzi/2jZ0+mP/UluFlsfx6q66EB91TBM7uONLt6ohZ1U+4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5320.eurprd08.prod.outlook.com (10.141.171.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Tue, 31 Mar 2020 13:49:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 13:49:23 +0000
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <767ea74a-5964-ce3c-a6c1-b9bebaf4c930@virtuozzo.com>
 <874ku4wtsd.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331164921033
Message-ID: <a2137d1b-7633-6ce2-baa0-f97d3128dc02@virtuozzo.com>
Date: Tue, 31 Mar 2020 16:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <874ku4wtsd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR01CA0115.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 31 Mar 2020 13:49:22 +0000
X-Tagtoolbar-Keys: D20200331164921033
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32690b18-fb79-43c5-b0ea-08d7d57a5199
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5320D692C8F61AC629BC5753C1C80@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(39840400004)(396003)(478600001)(316002)(16576012)(6486002)(31686004)(81166006)(956004)(52116002)(16526019)(2616005)(8936002)(36756003)(26005)(186003)(8676002)(81156014)(66556008)(7416002)(66946007)(66574012)(31696002)(86362001)(5660300002)(6916009)(66476007)(2906002)(4326008)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI+mHw+XTP06tDna1qilsjCvqPTRx+KK33sHqCxWVJoWGVPiKC6kpErUZjmD0EwBP9vdkIzXQPm4EylYrqyWZeuBrNVzYWkVT9Zh0gKhUp++arZerQPbyA7IttGNRaKUaK60Jbsu3wUdxmpVQP1iVohfz2a0XjW2iJxBEOpYWNsI+HclaioS8oH6LPn6eS0WlKFS7r9IEkBpfetuxIJL/SupfcSHSK1LrMgUkrepvPC+SabhFH3m20kxDX/6VThTi73HAQGkdkpLamo4TWfIbfL2Zsu+Cn9hmX4qyZEN8WV7C1hGbEY+k4SNMWv4KIMVeh42fUaRUKOvj3cC8VRbQzlQ39RbGs4ye2zTBYeXfbRIvEK5/JOPHdpGtjrTsYGdx9T01v0ApQ7Tdxrdh58WethS7k6jeRqfkWalWHwr+JSKUGoFM5wp3y+VXJJA9dX1p24Po1qFkavz8zpcC3nEx93eS2ZCps1baSMpFcWY4g4nX2ROeNCNjoI8OwaphnWdgvrOx0RG1xL/T0O/qPwfieOqQGsWt8S8dCLExDGKuWLFRxBIC2IaJXO5eSaTzFlx
X-MS-Exchange-AntiSpam-MessageData: Mn4Ig8PRTf0dPsGjQf3lRiWEoId8SUEaAZkUsA3vYvNJZUd7E0rjNisBflgivLdvs+bhQGDT6kAg/NkUtagV7Uc1yKu79d0a8yqj7zuNTZQa1B+msye+xYEw3ntsyuzOIPMW5rNwhOeA7laNEOlAgA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32690b18-fb79-43c5-b0ea-08d7d57a5199
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 13:49:22.9948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbXxQnhc6U3HtdQY5EYedbGy5qgApdwjRk1BtzQwKqVQ/XZ38flk7KcNi8n2oM5ZyM+PkRvzYe2WSSgLTTglaioVThvDc4xAJkzgnTNKFYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.133
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org, marcandre.lureau@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.03.2020 16:14, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 31.03.2020 12:00, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> Add script to find and fix trivial use-after-free of Error objects.
>>>> How to use:
>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>    --macro-file scripts/cocci-macro-file.h --in-place \
>>>>    --no-show-diff ( FILES... | --use-gitgrep . )
>>>
>>> Pasto: you mean scripts/coccinelle/error-use-after-free.cocci.
>>>
>>> --use-gitgrep is just one of several methods.  Any particular reason fo=
r
>>> recommending it over the others?
>>
>> :)
>>
>> In my occasional coccinelle learning, every new bit of information wande=
rs me, and I think "wow! it's tricky/weird/cool (underline whatever applica=
ble), I should note it somewhere".
>>
>> So, no particular reasons. It's just good thing too use.
>>
>>>
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    scripts/coccinelle/error-use-after-free.cocci | 52 ++++++++++++++++=
+++
>>>>    MAINTAINERS                                   |  1 +
>>>>    2 files changed, 53 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/error-use-after-free.cocci
>>>>
>>>> diff --git a/scripts/coccinelle/error-use-after-free.cocci b/scripts/c=
occinelle/error-use-after-free.cocci
>>>> new file mode 100644
>>>> index 0000000000..7cfa42355b
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/error-use-after-free.cocci
>>>> @@ -0,0 +1,52 @@
>>>> +// Find and fix trivial use-after-free of Error objects
>>>> +//
>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>> +//
>>>> +// This program is free software; you can redistribute it and/or
>>>> +// modify it under the terms of the GNU General Public License as
>>>> +// published by the Free Software Foundation; either version 2 of the
>>>> +// License, or (at your option) any later version.
>>>> +//
>>>> +// This program is distributed in the hope that it will be useful,
>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +// GNU General Public License for more details.
>>>> +//
>>>> +// You should have received a copy of the GNU General Public License
>>>> +// along with this program.  If not, see
>>>> +// <http://www.gnu.org/licenses/>.
>>>> +//
>>>> +// How to use:
>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>>>> +//  --no-show-diff ( FILES... | --use-gitgrep . )
>>>
>>> Same pasto.
>>>
>>> I doubt including basic spatch instructions with every script is a good
>>> idea.  Better explain it in one place, with proper maintenance.
>>> scripts/coccinelle/README?  We could be a bit more verbose there,
>>> e.g. to clarify required vs. suggested options.
>>
>> Agree, good idea.
>=20
> I'd like to get your fixes into -rc1, due today.  Possible ways to get
> there:
>=20
> * You respin with such a README.
>=20
> * We take the script as is, and move basic spatch instructions to a
>    README at our leisure.  Less stressful, slightly more churn, and we
>    need to remember to actually do it.
>=20
> I favor the latter.  You?

Me too.

>=20
>>>> +
>>>> +@ exists@
>>>> +identifier fn, fn2;
>>>> +expression err;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +(
>>>> +     error_free(err);
>>>> ++    err =3D NULL;
>>>> +|
>>>> +     error_report_err(err);
>>>> ++    err =3D NULL;
>>>> +|
>>>> +     error_reportf_err(err, ...);
>>>> ++    err =3D NULL;
>>>> +|
>>>> +     warn_report_err(err);
>>>> ++    err =3D NULL;
>>>> +|
>>>> +     warn_reportf_err(err, ...);
>>>> ++    err =3D NULL;
>>>> +)
>>>> +     ... when !=3D err =3D NULL
>>>> +         when !=3D exit(...)
>>>> +     fn2(..., err, ...)
>>>> +     ...>
>>>> + }
>>>
>>> This inserts err =3D NULL after error_free() if there is a path to a
>>> certain kind of use of @err without such an assignment.
>>>
>>> The "when !=3D exit()" part excludes certain "phony" paths.  It's not a
>>> tight check; there are other ways to unconditionally terminate the
>>> process or jump elsewhere behind Coccinelle's back.  Not a problem, the
>>> script is meant to have its output reviewed manually.
>>>
>>> Should we mention the need to review the script's output?
>>
>> I think it's default thing to do.
>=20
> True.  I just wonder whether we wan to document the difference (assuming
> it exists) between "the output of this script is expected to be good
> (but do review it anyway)" and "this script makes suggestions for you to
> review".  Different levels of confidence in the script, basically.
>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index b5c86ec494..ba97cc43fc 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2037,6 +2037,7 @@ F: include/qemu/error-report.h
>>>>    F: qapi/error.json
>>>>    F: util/error.c
>>>>    F: util/qemu-error.c
>>>> +F: scripts/coccinelle/*err*.cocci
>>>
>>> Silently captures existing scripts in addition to this new one.
>>> Tolerable.  The globbing looks rather brittle, though.
>>
>> hmm, may be better to rename them all to "error-*.cocci"
>=20
> Would permit reasonably robust globbing.  Fine with me, but requires a
> respin.
>=20
> I'm also fine with enumerating the scripts here one by one.  That I could=
 do
> myself without a respin.

no objections

>=20
>>>>      GDB stub
>>>>    M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>=20


--=20
Best regards,
Vladimir

