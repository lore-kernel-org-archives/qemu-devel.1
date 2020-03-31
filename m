Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ACBC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB69E20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mCGoSuxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB69E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCxZ-0002KW-0D
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJCwi-0001Mj-E2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJCwh-0004OW-0B
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:12:32 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com
 ([40.107.6.97]:55877 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJCwd-0004LZ-6p; Tue, 31 Mar 2020 05:12:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWvA4By1Vn/a2y8UCO9y5oFvxVx26WttXCB1uz+DbbLQ3+jFdCO1UqubLQXtk0DrTnsc+nYGz4sgFvKHjet4oomcMboW36ZoZzTBdsyKy4aPwfe2WU77I83qtLdV5SHYud2Mw21npqkSfg0smdMXkhkENHE5fYc8bfj0Au92RcKp188SO4suMglcXbzBDRwilUhlGRnDCBvLBmAy9E9mKb5v0BJffHC4b1C99yZfunbexwk1XxRHllpGJJv1W0NKFYAhQvr/aR+4bpM6mkNureDhYQdXj2WR+vjZyMVx2KK9FAAD0vOcxBrFLafgI4GYGD/gsO2+tgxKZ4nB81Wh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVhp+ciQuLNV54xx9liM0vjpNkH0RgXHnaZm4g28+l0=;
 b=UAR/vfJhtrnCrp0OQZA6kIvw50qj+qEQs27aPSpfqB1tCi5FcWkpMZcyrl8D15UhdcP8a5DWTFX3J4dHcTmrDeQT3vbQkRtHRjCHYThaf1I1m023EAv+2pgbnHxibyPtw2hP6ESzvfLwk/dpgYiPbVfAU+6zl7sClVGlo1YspS2/8mirpLPMkFiXVey+K81cNPGCY93BlVF0glOd3FVFhuhhXp1gbuzt/6f+ClX9VsqsCm6WcUWaOenvK3HbYUnDO1Pw3kWSMHxo9mWOTpg31oPiK8b9UlBYBiBp0uNrxwFs4Th56Njl79Bv/DZbSmj6bT5XicPBGG632Iw+0g2YoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVhp+ciQuLNV54xx9liM0vjpNkH0RgXHnaZm4g28+l0=;
 b=mCGoSuxP9jOFa7h+A6EWdVWgJfOJi2KCMXmnE4DTakbtfMqVLfuHxlfIdAfdBi1iKIzcBDYnDFdgJPzfhahHVol9Gjq8wKEm20xT/JXGxD946QuvQBDoWYnEJdPiL8Yqjh8ftOHuLw2ZTLXhtV6M+HU5dUKH/4K0viu0zfBmyXg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5509.eurprd08.prod.outlook.com (10.141.174.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 09:12:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 09:12:24 +0000
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331121222859
Message-ID: <767ea74a-5964-ce3c-a6c1-b9bebaf4c930@virtuozzo.com>
Date: Tue, 31 Mar 2020 12:12:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87bloc3nmr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR0402CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:15::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR0402CA0029.eurprd04.prod.outlook.com (2603:10a6:208:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 09:12:23 +0000
X-Tagtoolbar-Keys: D20200331121222859
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d117928b-23f0-492c-61de-08d7d553a061
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5509986224C088152A98C768C1C80@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(346002)(396003)(136003)(366004)(316002)(16576012)(5660300002)(36756003)(86362001)(6916009)(478600001)(66946007)(186003)(2616005)(7416002)(66476007)(16526019)(31696002)(26005)(66556008)(31686004)(956004)(2906002)(66574012)(4326008)(52116002)(8936002)(81166006)(81156014)(8676002)(6486002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eG1iC1KYrm2XQad1RgsD+WqGmdPgM2hpOW07X3q7ocX3yfb6b9Pv24sEzeon6jdNiUdepHSjP86XCzyAzB5jW3dlspfIzZn3kWd7TskQo3Nft/UXo46aq8CRxHsRi+G/WcLygKXntcyWltutar9SwMlCYm3n7KVm1OhkC1ro7YmfRdnvDKiFvqs4ejNVTvJ1W1ycaeZ4qUadiNPdJ0PQviz5Y+tRKxOFdwdU4g/Oaf6acMiKNhvZSXLlKVsqS2VQLePPROQXyXjBGc4RFQR48GrOVzn1A5MLY0eY5GV2jQqSRBgbbRxQk0b2y2eci+BdxZz+T5QhGryU2oHiaD9MScqOAkIY3/HzJNuDxa/gTEHL5rQy+hHp1JsaRU+Q0W9s+iNXg/fm6L7pVyabZwt32JH5Xhe5YjCuSyTJoU98VuOO7uPD+EeORwnlOloM/xNY+N9cfwjq+egxsLiRiY6W37NtpbYL7JVl7QHiiYYNTje+KOimEduQN3sAP1qCozSXz5IQhn1V5zFa3LYVj8sN86s3vQmMATuA8WfOCpdeYSr+2wQqYBJp96iA7PzdLomY
X-MS-Exchange-AntiSpam-MessageData: PtFJThZ/uSEuH9TRYWwX18mf9KBmZvLqEMhI9gyaWEWY+6RpZKB8+z/fLDaAwEyV0FXE41f8VqNZMa+yL9R2DQyc7lcA1v99OqegEy+vmgzrrYELXfXJPH6jPQCO5eoI2uurvWtMkeafG5cidhat7g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d117928b-23f0-492c-61de-08d7d553a061
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 09:12:24.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouxB5YwbuS8CxIoWoEeOypno3+5G76TT+LMpTJAO7zs21dXrfkUJ22vwwdXe9Xx6kwx06MM1irQaBgCZ49WpLt+5KlXA9C6X2rLGY9KWgxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.97
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
 marcandre.lureau@redhat.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.03.2020 12:00, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Add script to find and fix trivial use-after-free of Error objects.
>> How to use:
>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>   --macro-file scripts/cocci-macro-file.h --in-place \
>>   --no-show-diff ( FILES... | --use-gitgrep . )
>=20
> Pasto: you mean scripts/coccinelle/error-use-after-free.cocci.
>=20
> --use-gitgrep is just one of several methods.  Any particular reason for
> recommending it over the others?

:)

In my occasional coccinelle learning, every new bit of information wanders =
me, and I think "wow! it's tricky/weird/cool (underline whatever applicable=
), I should note it somewhere".

So, no particular reasons. It's just good thing too use.

>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/coccinelle/error-use-after-free.cocci | 52 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 scripts/coccinelle/error-use-after-free.cocci
>>
>> diff --git a/scripts/coccinelle/error-use-after-free.cocci b/scripts/coc=
cinelle/error-use-after-free.cocci
>> new file mode 100644
>> index 0000000000..7cfa42355b
>> --- /dev/null
>> +++ b/scripts/coccinelle/error-use-after-free.cocci
>> @@ -0,0 +1,52 @@
>> +// Find and fix trivial use-after-free of Error objects
>> +//
>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>> +//
>> +// This program is free software; you can redistribute it and/or
>> +// modify it under the terms of the GNU General Public License as
>> +// published by the Free Software Foundation; either version 2 of the
>> +// License, or (at your option) any later version.
>> +//
>> +// This program is distributed in the hope that it will be useful,
>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +// GNU General Public License for more details.
>> +//
>> +// You should have received a copy of the GNU General Public License
>> +// along with this program.  If not, see
>> +// <http://www.gnu.org/licenses/>.
>> +//
>> +// How to use:
>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>> +//  --no-show-diff ( FILES... | --use-gitgrep . )
>=20
> Same pasto.
>=20
> I doubt including basic spatch instructions with every script is a good
> idea.  Better explain it in one place, with proper maintenance.
> scripts/coccinelle/README?  We could be a bit more verbose there,
> e.g. to clarify required vs. suggested options.

Agree, good idea.

>=20
>> +
>> +@ exists@
>> +identifier fn, fn2;
>> +expression err;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +(
>> +     error_free(err);
>> ++    err =3D NULL;
>> +|
>> +     error_report_err(err);
>> ++    err =3D NULL;
>> +|
>> +     error_reportf_err(err, ...);
>> ++    err =3D NULL;
>> +|
>> +     warn_report_err(err);
>> ++    err =3D NULL;
>> +|
>> +     warn_reportf_err(err, ...);
>> ++    err =3D NULL;
>> +)
>> +     ... when !=3D err =3D NULL
>> +         when !=3D exit(...)
>> +     fn2(..., err, ...)
>> +     ...>
>> + }
>=20
> This inserts err =3D NULL after error_free() if there is a path to a
> certain kind of use of @err without such an assignment.
>=20
> The "when !=3D exit()" part excludes certain "phony" paths.  It's not a
> tight check; there are other ways to unconditionally terminate the
> process or jump elsewhere behind Coccinelle's back.  Not a problem, the
> script is meant to have its output reviewed manually.
>=20
> Should we mention the need to review the script's output?

I think it's default thing to do.

>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b5c86ec494..ba97cc43fc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2037,6 +2037,7 @@ F: include/qemu/error-report.h
>>   F: qapi/error.json
>>   F: util/error.c
>>   F: util/qemu-error.c
>> +F: scripts/coccinelle/*err*.cocci
>=20
> Silently captures existing scripts in addition to this new one.
> Tolerable.  The globbing looks rather brittle, though.

hmm, may be better to rename them all to "error-*.cocci"

>=20
>>  =20
>>   GDB stub
>>   M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20


--=20
Best regards,
Vladimir

