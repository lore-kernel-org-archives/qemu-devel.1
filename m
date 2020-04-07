Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4515C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE91206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RCv/h4/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE91206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLns3-0000tX-Mh
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLnrM-0000Fs-MT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLnrK-0007DD-BX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:43 -0400
Received: from mail-eopbgr150105.outbound.protection.outlook.com
 ([40.107.15.105]:2371 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLnrJ-0007C1-Jo
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR3Zos0cTMAyMgD82VyClk9YvwpmqCbiSw7khtc2W1+JGK9J/evn6mYAdNSzr4yWYT2jpsRFybkhkSCq0RC/0YPbfY+/UT2sZrHtKLLgzSsa+rP/SZQk5UkIAFgnDqVFjnjiGTXO2W1Rx/WSESHsFN8lyOj+xLSQcN0EVV34g4KegkfyJmRdI2g8I7hprERX3gT7rRNCWlQYfTLseLP/qgGs237BACkdGs/XWz55KRbLOsQVFc7Rq8TmWLQ9E4L+xMGrw4gPyI0U3aCUiBLCMelh5ORt9euE8O+22FAUDYmbtIEiH/l0s8So4sLG3RWsgC/naDPysMMn4r45sQoylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpMef6SDBX9vbBz+K5XMq2EgOXQnL2Ayn5j+c5Ff2Mo=;
 b=lA/4zEf8IfNg6WSHg+jwdWs3LUH/EKFaLt6CTFRNrPOj9N5esZQUde8jYNucF2Gmq5zghhnmwwMId8fqma3QqIzO5tb0m+H36yLRBUZ/mW9vyAHNvKEjuTkbNXYLdEtX9rMaW3YvUojCIYV4UFno/GrgNlyM+PISvzTd1OHdxjBBr2XFjAcCjO4tanBVqc9Ew+xsTUVPHqu5zu2V+GhPu3SnYAAHiVVcysjlMY46sqsVPJ2GNRQnYbIZXKCETzl6VFY2ni+Vh7SF/KFSbwjRfw0nxfQDy4nlDJ7fNDV1fQcMS5Ur75lR57VtYUKFPpYbWZnzwekgTGX76kegEzwEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpMef6SDBX9vbBz+K5XMq2EgOXQnL2Ayn5j+c5Ff2Mo=;
 b=RCv/h4/yS/sWXo9FhGrIQaWW9M32+20Q+AJE2L0wifAwT3kYwK+4yQocRX1wwMlQ/h/Q7xPlE1VQM5TAslciefwrpRwnN4f9YwqhJAo4VauY4n/5RpPVoA7unhD4UjSKUQeE97lNzgehW9Sqy7LrzTWEIY0BqVnWX1e3SgXxxS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5512.eurprd08.prod.outlook.com (10.141.175.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Tue, 7 Apr 2020 13:01:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 13:01:39 +0000
Subject: Re: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-49-f4bug@amsat.org>
 <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
 <ac7213fd-3ea2-e80c-7308-5f2de02c341c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407160136390
Message-ID: <ae9ced39-f039-ffb5-b33b-df93b0f35e36@virtuozzo.com>
Date: Tue, 7 Apr 2020 16:01:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ac7213fd-3ea2-e80c-7308-5f2de02c341c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P191CA0101.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6P191CA0101.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 13:01:38 +0000
X-Tagtoolbar-Keys: D20200407160136390
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b9ca2b-b0bf-48b6-b205-08d7daf3cf3a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55128B774C60A26A6715B50CC1C30@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(956004)(53546011)(31686004)(36756003)(66946007)(66556008)(66476007)(26005)(5660300002)(110136005)(52116002)(478600001)(16576012)(316002)(966005)(16526019)(8936002)(6486002)(2616005)(81156014)(4326008)(186003)(86362001)(2906002)(81166006)(31696002)(8676002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLMpiBPu0KPuBfwDYIRjneC6/C/dJlPoYbFWjnxd8ic5lEHWBGgFfbDHHYRJw/6o4fPE0SqMN4iLcfTNsbdZ4mIsiEOciD3FA6O8OopLjgXKBCLLKxDYQfvZ+J+8jmScLckYnScyaNnRe46yRoppF645VvSHfGeOV99GYBbS4NC+p0f6XL+/aF6bDEaJSDh3ifCyaVcaVqMD5KdcS+sW1nYkpv/WFzDPQ4lcTpQJ2DKf49npR1TF/4gjZBHQDzx5yj7ACfXzP6EclJq0noImgXnLQgk8+OAWkGGXkpAcg1D/ddELpVXzhSm1HqJCh+EQB/oLUFEz9XFB1hpqjaD0e1ykDPDVYt8pvEuMH2RMQz4obi6FCLMjUH8tn/hHuJIm7CJ7ZGSAjBhfBHHz+H6DXJd7r9E7ni2RBjjl17XkAN0+ZdGUSg0Op5HP6Ysrbkw099ODwCpqSxOHUCkHYPRubnGnvy4JunNlvSb296ceW4PSfj5AA8E/Av4k+klAmr7yTevdL++JVzHVBBqdfteBOQ==
X-MS-Exchange-AntiSpam-MessageData: 1fhG3icfabfSE2Yjl3f0VwEXqLcJWlen/CSFz9UVSvpahpI1R1avMoef0YZjGPNIBL9/5qS0+nxDg8k25XDirNQ5OYFVhYbQWZODKue1T9IwxoH9iqEkgWw9e6/cPTFeEu+DcZl4yvs/ItW0alcRaw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b9ca2b-b0bf-48b6-b205-08d7daf3cf3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 13:01:38.9771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exw+gfB9bqpmSt1j0bkrF4ygKXbeJKIwwSvR0guqO2jAqX1SxMbkDof1kgI6GIPyO4ndRfluZ2B/vNNVAzGD3OICKQdxkdNCq7vzHBUfUO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.105
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 14:03, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/7/20 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 06.04.2020 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The instance_init() calls are not suppose to fail. Add a
>>> Coccinelle script to use &error_abort instead of ignoring
>>> errors by using a NULL Error*.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> =C2=A0 .../use-error_abort-in-instance_init.cocci=C2=A0=C2=A0=C2=A0 | 5=
2 +++++++++++++++++++
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 2 files changed, 53 insertions(+)
>>> =C2=A0 create mode 100644 scripts/coccinelle/use-error_abort-in-instanc=
e_init.cocci
>>>
>>> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci =
b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>> new file mode 100644
>>> index 0000000000..8302d74a0c
>>> --- /dev/null
>>> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>> @@ -0,0 +1,52 @@
>>> +// Use &error_abort in TypeInfo::instance_init()
>>> +//
>>> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
>>> +// This work is licensed under the terms of the GNU GPLv2 or later.
>>> +//
>>> +// spatch \
>>> +//=C2=A0 --macro-file scripts/cocci-macro-file.h --include-headers \
>>> +//=C2=A0 --sp-file scripts/coccinelle/use-error_abort-in-instance_init=
.cocci \
>>> +//=C2=A0 --keep-comments --in-place
>>> +//
>>> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg6=
92500.html
>>> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.ht=
ml
>>> +
>>> +
>>> +@ has_qapi_error @
>>> +@@
>>> +=C2=A0=C2=A0=C2=A0 #include "qapi/error.h"
>>> +
>>> +
>>> +@ match_instance_init @
>>> +TypeInfo info;
>>> +identifier instance_initfn;
>>> +@@
>>> +=C2=A0=C2=A0=C2=A0 info.instance_init =3D instance_initfn;
>>> +
>>> +
>>> +@ use_error_abort @
>>> +identifier match_instance_init.instance_initfn;
>>> +identifier func_with_error;
>>> +expression parentobj, propname, childobj, size, type, errp;
>>> +position pos;
>>> +@@
>>> +void instance_initfn(...)
>>> +{
>>> +=C2=A0=C2=A0 <+...
>>> +(
>>> +=C2=A0=C2=A0 object_initialize_child(parentobj, propname,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 childobj, size, type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 errp, NULL);

I think, it doesn't actually differs from just object_initialize_child(...,=
 NULL); and you don't need all these metavaraibles

>>> +|
>>> +=C2=A0=C2=A0 func_with_error@pos(...,
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &error_abort);
>>> +)
>>
>>
>> Hmm. I don't follow, what are you trying to achieve by this ( | ) constr=
uction? The second pattern (func_with_error...) will be matched anyway, wit=
h or without first pattern (object_initialize_child...) matched. And first =
pattern does nothing.
>=20
> Expected behavior :)
>=20
> If object_initialize_child() matched:
>  =C2=A0 do nothing.
> Else:
>  =C2=A0 transform.

Ah, understand, thanks. Checked, it works.

Possibly simpler way is just define func_with_errno identifier like this:

identifier func_with_error !=3D object_initialize_child;

>=20
>>
>>
>>> +=C2=A0=C2=A0 ...+>
>>> +}
>>> +
>>> +
>>> +@script:python depends on use_error_abort && !has_qapi_error@
>>> +p << use_error_abort.pos;
>>> +@@
>>> +print('[[manual edit required, %s misses #include "qapi/error.h"]]' % =
p[0].file)
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 14de2a31dc..ae71a0a4b0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
>>> =C2=A0 F: scripts/coccinelle/error_propagate_null.cocci
>>> =C2=A0 F: scripts/coccinelle/remove_local_err.cocci
>>> =C2=A0 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocc=
i
>>> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>> =C2=A0 F: scripts/coccinelle/use-error_fatal.cocci
>>> =C2=A0 F: scripts/coccinelle/use-error_propagate-in-realize.cocci
>>>
>>
>>
>=20


--=20
Best regards,
Vladimir

