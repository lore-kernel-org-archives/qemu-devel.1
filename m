Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4BC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB9A20747
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XMtZ6R0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB9A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLiTE-0003lp-9w
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLiSa-0003Mq-NL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLiSY-0008EJ-RR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:15:48 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:12129 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLiSY-0008DE-GC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:15:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNBIbdD53YmN/P+CErgGmZC5D/KNX2D26Tv5m+JX2plwG4vlyqtvpKmfPMjaBFIy4qOmPNTbydST7tr4MwGgJjdnHwq+LiXmR5SX6IiYTD+MHn49qtHdQzy8e+Gy4mdDZeM7HBjx/oCNQAtKo4Cx41gAyxoboOvMxYTn4xYaPcIxCqOwjNfGmxP3FyB6GbF/qIWR8CDOdUUtrHOF858cvR/9ebcfUs5N8iNDk0IdYbe+O5fw0iXbiFkaYUGZ/RF05NBwdaCnJWUyuPhVsXo/FWEGJXLqAwD19Cxk7qzdSaColZ4X8S7Aev7mXDxTLsltHNgPSoRpJTE6huOE8OWTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG+d4O6YERhca/d9hJWmo/s2m22bvQ2L1gqS7lkP7SY=;
 b=FFD00YWqoORHOYKXe0T3du7S3KB6SPgfZh9YY4DdzCb99pVUfWGyTHZAMIFxF8vJ14JwjJar2IF+lU7kUxujJ0Ch8agSfTh3QMlU1VmGbpUGjUy7OMShc9m0gc2uqRFAi6tAEtUUUVZcTaYqLFsB2AkeCGv2ph9rudtQy3eAsuGlNIzcyZ6QlBeiGTWnkOQPjiP4Um29B6lLYZ11FkISj2ZWXWdpleAWm+LWi2F5JGn0Fv/oBdusCEwl5jCIH7LrobUdJ1PDYCkqfUHZUhZ3dfFNa1/c10Did9NIVnnhVfe/xFyDATE2pqQRmTyFYg+UeyALAjVtLtN4ySK89kcNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG+d4O6YERhca/d9hJWmo/s2m22bvQ2L1gqS7lkP7SY=;
 b=XMtZ6R0bhFRnvq/8C3i+K83La6HZDGwLIeoE4ubGgQ1lZn0UkQawtydHSBi3aRfRedifpv5rIHTMjIOJVn4Hka9iraW7Dhz+aV7gotTeMib/ySBUuYEA3vin5mhcrsd/3uJr6BYTwUKRSRBL0DDYEnyV+uD0g4Y/z20sViC88iE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5382.eurprd08.prod.outlook.com (10.141.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 07:15:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 07:15:44 +0000
Subject: Re: [PATCH-for-5.1 v2 50/54] scripts/coccinelle: Find eventually
 missing error_propagate() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-51-f4bug@amsat.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407101541467
Message-ID: <9eea0efd-eaba-738b-560c-02cc878cb4c3@virtuozzo.com>
Date: Tue, 7 Apr 2020 10:15:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406174743.16956-51-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM7PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:20b:110::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 07:15:44 +0000
X-Tagtoolbar-Keys: D20200407101541467
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b87fe711-f733-4897-cd26-08d7dac37cd3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382DB92A44EEA1EC4A1C214C1C30@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(8676002)(6486002)(31686004)(966005)(81166006)(478600001)(86362001)(31696002)(66476007)(36756003)(66556008)(6666004)(66946007)(81156014)(2906002)(8936002)(4326008)(52116002)(316002)(110136005)(26005)(186003)(16526019)(2616005)(16576012)(5660300002)(956004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWtUSjh1EycKY8ctTfz+JYv+cgmLFOCct1kyRvS+7bxgiFwqoZXYdzX3aQm5NRScTMWW1lqAQBO2W12guz9wK5LYXjpMBOTyzSA4g9v6rOJ6eEqIz6Vob7nVzLoPhKWYFuGfD/g4xEJHvED6jWjz5xHeIINO63klWWmanbwbWhs8g4zn+jtXCTnkrKQgbBD9Krs7MiHaBccbywDC4H1717Cb6Dfbf8c5nPKwWk6I+ny/AbaKoQ3NYHxt0u7pwNxM9cKri1nCACcXmXKo6uIfCkTzz0a4gOG0j9hQsjQIAcs0mQgh/ppoYm9Ow3Z9gBOrl2p9h2SLqWvLQXwqTNPmkXEUX9keud44XGdQ3lbQw6z8s5tbtqvQN4+qbkvdiJoozcCdD/UDdML0qQygZJCnRzClosEa3nDSueHvbyrlf+Ive4C2V2AXVQ+3CarEwCdw2zDXdxEIrhxD3oo26r7x6lxe9j/dHbipR8l+QeytL7Jd8MEiKsdshFwMxD4klq8Zs5GyPSzZJHQPqokqLMJRjw==
X-MS-Exchange-AntiSpam-MessageData: KqSaXXVQXgVvXBDLbo9rUrrZMFxTekpRMzaeUFmvOxyUHsCxf88lTMEZXsuFXD5A+aGjcDaVI6AIS9TLf42O8t08HbZArTI0ivjdGM/TN2o1LrHGVUn2tgF3HT+aAb4zYAwCEQV/epYuukVHvrOeQw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87fe711-f733-4897-cd26-08d7dac37cd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:15:44.5461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs0AsjwrHvql8q5/L6/cz6xTwsx4c9xWPs/gXRtZPbtyN5ef2KsF9ZwdSDSYZRlflGtV1Erif+RpqPRki1Xaf978hrb2uDa+FIBpY8fVb4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.113
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
> In some places in we put an error into a local Error*, but
> forget to use it. Add a Coccinelle patch to find such cases
> and report them.
>=20
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   .../find-missing-error_propagate.cocci        | 53 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 54 insertions(+)
>   create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocc=
i
>=20
> diff --git a/scripts/coccinelle/find-missing-error_propagate.cocci b/scri=
pts/coccinelle/find-missing-error_propagate.cocci
> new file mode 100644
> index 0000000000..8b75b37b64
> --- /dev/null
> +++ b/scripts/coccinelle/find-missing-error_propagate.cocci
> @@ -0,0 +1,53 @@
> +// Find places likely missing error-propagation code, but code is too
> +// complex for automatic transformation, so manual analysis is required.
> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/find-missing-error_propagate.cocci
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691=
638.html
> +
> +
> +// First match two subsequent calls using local Error*
> +// in function provided a Error** argument
> +//
> +@discard_func_with_errp_argument@
> +typedef Error;
> +Error *local_err;
> +identifier func, errp, errfunc1, errfunc2;
> +@@
> +void func(..., Error **errp)
> +{
> + <+...
> + errfunc1(..., &local_err);
> + ... when !=3D local_err          // local_err is not used between the c=
alls
> + errfunc2(..., &local_err);
> + ...+>
> +}
> +
> +
> +// Again, match two subsequent calls using local Error*
> +// but ignoring within functions provided a Error** argument
> +//
> +@manual depends on never discard_func_with_errp_argument@

What depends on never does? As I can imagine, it checks that previous rule =
never matched in current file (or all files given to coccinelle as paramete=
rs?) ? Couldn't we miss interesting case that way? When both patterns are i=
n one file?

> +Error *local_err;
> +identifier errfunc1, errfunc2;
> +position p;
> +@@
> + errfunc1@p(..., &local_err);
> + ... when !=3D local_err
> + errfunc2(..., &local_err);
> +
> +
> +// As it is likely too complex to transform, report the hit
> +//
> +@script:python@
> +f << manual.errfunc1;
> +p << manual.p;
> +@@
> +print("[[manual check required: "
> +      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
> +            f, p[0].file, p[0].line, p[0].column))
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae71a0a4b0..29d29461f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2057,6 +2057,7 @@ F: scripts/coccinelle/add-missing-error_propagate.c=
occi
>   F: scripts/coccinelle/err-bad-newline.cocci
>   F: scripts/coccinelle/error-use-after-free.cocci
>   F: scripts/coccinelle/error_propagate_null.cocci
> +F: scripts/coccinelle/find-missing-error_propagate.cocci
>   F: scripts/coccinelle/remove_local_err.cocci
>   F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>=20


--=20
Best regards,
Vladimir

