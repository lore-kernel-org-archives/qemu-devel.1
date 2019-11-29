Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A113C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5278B2176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P9oz9FkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeHV-000559-H9
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeDu-0002uE-E6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iae7V-0000DL-Dd
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:07:31 -0500
Received: from mail-eopbgr150112.outbound.protection.outlook.com
 ([40.107.15.112]:60580 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iae7U-0008Jm-VP; Fri, 29 Nov 2019 06:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6ACfmI7/vF8aoHo/8QutRzZa2MXu7iERn1j7KsDqs1eGypcJR2/pu0FvAwfoIKTQ2C3A0WcDb6q+sVTyHZtkV1nPMdqCbLNdN5VE/C2siJACxH13aQ1SJ1WxvZJEKMuy9E4d6TiprF+SEMo5f/3LPMNl7xpuxBiS7owvQt43dk+JJ0pGZ13O3gTdJNSKhrRNHDPvELrGDKZkMN3iGp4qn8C+1cDiu7eHfnoDlwirZqSyHO4KhdUsXq2LobEdKYuvX3jJ/K8CG4gGfN7t8fMiYsyjPQLb7MJoDme7qxNlQnkQwybPZlVwLtIEk0FZ2HPr1T2OIKUzWRLxv8Nr2pAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cp5QCdwTgBbNFn5WtHNu8Y96rz8vq24fyUyG/CRR1I=;
 b=RnBDcWSOtbBIAF9PG3KNng4YQGtfVNHoqBU+ySnMEk0xwOv/ckkVWsX5AVm+rytol1p5Bi6iVkPXD0HqodUCSawLDao+JFASM+TfYMJLWNd0Wds+smgWrRzM0vVM7Ws9ya1UTr+l1skOu10fGdbLsWmi2GEGrqAGdCDIutaDzt8S+u9bQJxMvb7An4hkI/Cd4tcbPOQC7uA6Je1M0ZZD6amStSlwY11O+cRUnEaAqnWYq6gWzSCmw25aHLvnw+cU70n9IGWFBizbPfdUHH6HVTXQc3gglzbfs9ZODLkzz2RB9HVyKvljgkfoe9HxcyYyFxp5/Xhkrcg2ccpLdbfMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cp5QCdwTgBbNFn5WtHNu8Y96rz8vq24fyUyG/CRR1I=;
 b=P9oz9FkVaiq4UtbNxcXh9phd5RQFgeJfgI4fiq1H6a+zlJMiBxP383fsCqjGsDgjY2yksmJj9HKv4Jkd6lwyXlK4gUg4Z5KVAgfQ4IPokDWDyg7Osmm5Aip3BbODxrVeBx2TdafbYTgkgkTQJ/eN8J1RUTYLtmdOQ7lX/QboXJk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4642.eurprd08.prod.outlook.com (10.255.22.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 11:07:23 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 11:07:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 11/23] block: Use bdrv_recurse_can_replace()
Thread-Topic: [PATCH for-5.0 v2 11/23] block: Use bdrv_recurse_can_replace()
Thread-Index: AQHVmKl85zGf9jZeAEO7AyqHglq3C6eiGQSA
Date: Fri, 29 Nov 2019 11:07:23 +0000
Message-ID: <81e6ac08-2f89-9606-0642-4f4f92aeba2e@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-12-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-12-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:7:67::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129140721442
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ed3db3a-5a50-4f0a-5a9d-08d774bc4f47
x-ms-traffictypediagnostic: AM6PR08MB4642:
x-microsoft-antispam-prvs: <AM6PR08MB46423E7266289FA4B0954C19C1460@AM6PR08MB4642.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(376002)(136003)(199004)(189003)(31686004)(76176011)(102836004)(186003)(2616005)(11346002)(52116002)(26005)(8676002)(8936002)(6246003)(66556008)(6116002)(446003)(2906002)(3846002)(71200400001)(386003)(6506007)(14444005)(4326008)(71190400001)(2501003)(86362001)(14454004)(256004)(81156014)(81166006)(66476007)(36756003)(31696002)(305945005)(66946007)(7736002)(25786009)(6512007)(99286004)(6436002)(110136005)(54906003)(66446008)(5660300002)(316002)(66066001)(478600001)(6486002)(229853002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4642;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yN+rv6x9W5B+fJWPc/aeHF/uXAQAWRcnyh7p1W1EnwDC0l18iUMIH4iBlmOg0E1CnaWZ6f38jNz11Kf/nvOFnsRE527TAcHgu95TgMGhb71GzkaL6rYauXVDE3wsx0rdSpbInfy4kB+2YCr+wlT20EvxCC3pSgG2sB1IlWHHOtrnkwukkCtTV89Nrk2ao606jN8zWEyj2WsR3NMdR35Vw/7bUIqCwZPuneTF5zjbMoYz1Rp/n05IKosK7/u6XcfuwG1q2Ebg2EYORNTc1Ryppsk145cEhCuBaefyMbrn8DXxPTyOQyOOcDjS76GYMfwsNpkXfe7gOLijt3ydkZm9Qh6N2Pz8IKIM7iNJA8NHcsbRMb+/xByLlzabu5NIu4Th5ecH6ndKf0XiWraESBCYU6JOVaVDo9xVbPeetSW+0u2qpireSreuncwhDOiAIuwI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <75EF53EF687C8F439D311CA11EAE70D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3db3a-5a50-4f0a-5a9d-08d774bc4f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 11:07:23.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g71UU+lU+svNVORYqRqaTs7ypTm0DingSAFNMoz/EpzxeG7uQJhHsZ92o5Zkz5ekyafkzXaZgUEjCVXeBgLUg1SKQ4eaXRbJnTYowf4f3i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4642
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.112
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> Let check_to_replace_node() use the more specialized
> bdrv_recurse_can_replace() instead of
> bdrv_recurse_is_first_non_filter(), which is too restrictive.

or not enough restrictive in case of quorum

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index de53addeb0..7608f21570 100644
> --- a/block.c
> +++ b/block.c
> @@ -6243,6 +6243,17 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs=
,
>       return false;
>   }
>  =20
> +/*
> + * Check whether the given @node_name can be replaced by a node that
> + * has the same data as @parent_bs.  If so, return @node_name's BDS;
> + * NULL otherwise.
> + *
> + * @node_name must be a (recursive) *child of @parent_bs (or this
> + * function will return NULL).
> + *
> + * The result (whether the node can be replaced or not) is only valid
> + * for as long as no graph changes occur.

actually, no graph changes neither any permission changes or updates.

> + */
>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
>                                           const char *node_name, Error **=
errp)
>   {
> @@ -6267,8 +6278,11 @@ BlockDriverState *check_to_replace_node(BlockDrive=
rState *parent_bs,
>        * Another benefit is that this tests exclude backing files which a=
re
>        * blocked by the backing blockers.
>        */
> -    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
> -        error_setg(errp, "Only top most non filter can be replaced");
> +    if (!bdrv_recurse_can_replace(parent_bs, to_replace_bs)) {
> +        error_setg(errp, "Cannot replace '%s' by a node mirrored from '%=
s', "
> +                   "because it cannot be guaranteed that doing so would =
not "
> +                   "lead to an abrupt change of visible data",
> +                   node_name, parent_bs->node_name);
>           to_replace_bs =3D NULL;
>           goto out;
>       }
>=20

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

