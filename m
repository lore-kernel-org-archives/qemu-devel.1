Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD9C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B224520678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UZTpUu1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B224520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLiLa-0001Cr-SX
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLiKw-0000nb-DO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLiKn-0003Ft-0v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:07:53 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com
 ([40.107.20.101]:11264 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLiKm-0003DB-ET
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx1m4uPQV/OAgChcdqfwqWC75ewAE4ODjwV3M2sZMIGbK/DbKnp5ZgzsABbDa3Xjzqk9+Jd4MWo+lOKn1fjPZKexjYKpJeTm68chciVhsx7fBKAijIFWIJMl4mdFGXwkB3WvscxPun8Rr7ki7EhUHAKo/w4V1lGGL1kPo1AKdLZuAqk04hATsMbqR6ccUZFXGOeB1eDn7fw7Aozl3qo76FGsS1r/dUolhVOeg4n78qdyK4A0gT4Pyauzyzry5EUJb5pPd4lYKBX+kL1W19c64fZx14YuTWd68kcIrUpWOiEJ/tbkzUFxHsiSu4S/2JFJMlWWNf7R6tCsLv4ZbyKw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW3ue19kfaMFZxryoWtWHaQHDqeSX4KlqARmdJtDgZs=;
 b=ACztuIoYEISk6Iz1BaXfgIJmWxU1Dd80pl1qDklDR+LGqRk8k6DedvVrsui/g/u+sRNqJSmw5rIswSHXYB53v2ZLu8qaMlI/xVK2OQf9xOTrOgrIYerBL4egMYCDTVdnlWgHbc/q4qZ0L4MffZFCVfxxUDgvFitFs4AKus4vbxrvSNbN7yiyHqtn5BQm34WO4DhGoB5RtqlnEwgZeEfQsO+5uduRpg6yba1N/LXqG0QXL3p3ht7rUt1Wh12UndBfJeIeqmG8ZHiRcAc2QNykYkhjhS5zNdH287Q4JA27RxYBhsTYT54Du5Z0Zt9ej4mJHFKQAmucq5HL1m34MTzsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW3ue19kfaMFZxryoWtWHaQHDqeSX4KlqARmdJtDgZs=;
 b=UZTpUu1dclvUGIF3dvmhSy8731kR/KZH+GxW46zgbVDy/eoT+u+9UyUw1peN9tH1OflAKkH1F7HCgViJUz7dXxzgKIWaEcElBmO93IfoS0IoOxaFr3hU3eW+OhGMlio4OreVXc6adpWY99cNhTkne/qWouDdGSy8zrZJ5jnR2Os=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5382.eurprd08.prod.outlook.com (10.141.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 07:07:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 07:07:40 +0000
Subject: Re: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-49-f4bug@amsat.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407100719651
Message-ID: <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
Date: Tue, 7 Apr 2020 10:07:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406174743.16956-49-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 07:07:39 +0000
X-Tagtoolbar-Keys: D20200407100719651
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55890b0a-f6e0-4cb6-d083-08d7dac25c0b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53829093FFC6F7443A963BFAC1C30@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39830400003)(366004)(346002)(396003)(376002)(8936002)(4326008)(2906002)(16526019)(2616005)(26005)(186003)(5660300002)(956004)(16576012)(316002)(110136005)(52116002)(478600001)(86362001)(31696002)(81166006)(8676002)(6486002)(31686004)(966005)(66946007)(81156014)(36756003)(66476007)(6666004)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypLDc0J9RL8Z16PBz43h0hLCyexaGKRumnMVG5l2PN3egka9nLoSuEPrtsZ18Sj3CJ4XWtxv7fMoMkYeoqkd5RUvySyfZjyf0O7I7gdhM0WP6iZsiZklep7QrkASdCySoVRyxhCivzbjEVgf5bVo0N+RqxzrUm+pXyGqq9JTafBxvZFWqgF0TTPrIlDP5oOA5oJpQi7xXE8j7BJ9jaAMEQs7Q/Ijlscfl74BWBkeSRmn+byUmJ+sXpqSCGy1fzDSCNFseGVDVVAasK52N7ISwvCFnqjJMay4nU2bH96ou8dHgHj/S4ANUKjyE44tvbxkKKkETi8+B4tDW27Nobi/6kap5uosTu3Ta3LAsYYkWfqx6z+l7xYR3B/l9Gjhe7MDIrwhNctdW/c0NI4qF/m9By8md5nqj0uoq7AkgMyb/Py+pO3f3zt320SWczHtHNo3HyYyG45/iQwxYVr3OQnI5untACa+5BGIN7bcjhhYtxijV3DFRQ2tDOHIlPyYQ6dAdMjkgzl86JzKTbcQje5rpA==
X-MS-Exchange-AntiSpam-MessageData: E/xe2BOg8Wv1Yusfwl1mBtgkJMcydU8xkJrY0BsY7pYVcE2X2vtMI4swPCthineXkmh3cvig/Z4sOWu4J71drH+Wpmi66A+bQa+B2BWXmkh6PspHYCPxigtubVVShWI6BOWZWfoVn58Qm2kBT2iJhg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55890b0a-f6e0-4cb6-d083-08d7dac25c0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:07:40.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUbUy8oLPr4r7f4QaJ/l6tW/eleLUNOZ0Dlo4Z+YI5hCaa8n+j4+Eql+yPSdSnhZLXf5LxgYTGeHpcSBW+ZOdszH/O+FC9BtnG9AnvZL4Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.101
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

06.04.2020 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
> The instance_init() calls are not suppose to fail. Add a
> Coccinelle script to use &error_abort instead of ignoring
> errors by using a NULL Error*.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   .../use-error_abort-in-instance_init.cocci    | 52 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 53 insertions(+)
>   create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.=
cocci
>=20
> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci b/=
scripts/coccinelle/use-error_abort-in-instance_init.cocci
> new file mode 100644
> index 0000000000..8302d74a0c
> --- /dev/null
> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
> @@ -0,0 +1,52 @@
> +// Use &error_abort in TypeInfo::instance_init()
> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci =
\
> +//  --keep-comments --in-place
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692=
500.html
> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.html
> +
> +
> +@ has_qapi_error @
> +@@
> +    #include "qapi/error.h"
> +
> +
> +@ match_instance_init @
> +TypeInfo info;
> +identifier instance_initfn;
> +@@
> +    info.instance_init =3D instance_initfn;
> +
> +
> +@ use_error_abort @
> +identifier match_instance_init.instance_initfn;
> +identifier func_with_error;
> +expression parentobj, propname, childobj, size, type, errp;
> +position pos;
> +@@
> +void instance_initfn(...)
> +{
> +   <+...
> +(
> +   object_initialize_child(parentobj, propname,
> +                           childobj, size, type,
> +                           errp, NULL);
> +|
> +   func_with_error@pos(...,
> +-                           NULL);
> ++                           &error_abort);
> +)


Hmm. I don't follow, what are you trying to achieve by this ( | ) construct=
ion? The second pattern (func_with_error...) will be matched anyway, with o=
r without first pattern (object_initialize_child...) matched. And first pat=
tern does nothing.


> +   ...+>
> +}
> +
> +
> +@script:python depends on use_error_abort && !has_qapi_error@
> +p << use_error_abort.pos;
> +@@
> +print('[[manual edit required, %s misses #include "qapi/error.h"]]' % p[=
0].file)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14de2a31dc..ae71a0a4b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
>   F: scripts/coccinelle/error_propagate_null.cocci
>   F: scripts/coccinelle/remove_local_err.cocci
>   F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>   F: scripts/coccinelle/use-error_fatal.cocci
>   F: scripts/coccinelle/use-error_propagate-in-realize.cocci
>  =20
>=20


--=20
Best regards,
Vladimir

