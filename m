Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6ECC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377A921774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uuIphuZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377A921774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacUh-0002dV-FQ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacMT-0007g9-Tf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacMN-0001cN-Kw
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:14:45 -0500
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:19907 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iacMJ-0001SK-J1; Fri, 29 Nov 2019 04:14:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikVcYUtI1Y6aUyiNWAJNn2C+qQEwT04/p+zC6fhUaePgGyTt4lk/GSyaL6UJWCDYkMfDljyiu/Gw8GETFYVlxBdsafUNqe6z3DQKwq42S7JsMCxQK47ZUebempEPdTOV88OZJstoDPCB9x27SSnNiuTYX1nvwzmYgXX8S5wn4Uh0wYrJdaRz1aUeKN3VfQEhcWwTTMu58LYVqsVRUMnC+o11jMa+Dd3+cw21GEq3pRCIc3zHAWC1mdc70Hj9ak39bAW2aQ+/9H6IDFcID+/bUtY9xaI8KL81rxNun7QXnR6lSsUIE/7JkXZSVfG51wTQr/GDryY9XKtb/zhlUBMxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghlDpdzfFZW1b26aiZeMj6Wc9Y1fd4AUZUh72r7Rtv4=;
 b=THqJ2Sw4kdUdoPkuLIKZswU64W3JeG2UnNDQLDj0L1/+K8ZwAKCw3ICOrfB7RjttgoqQHK/FtTR+kdgDg68D5sn5qKSiN+cEh0y6ZEOnqlFqKZ1KajTUYE7cVR23n1cosuMhHxmlSXgUOdRlk2DWrCC3q7iMldfnqPyO45CrglBgZxRLXtuKdHJJ4vO8fFGz8fm6x5FZDtJK6QhOit5w3b33uCeunKbboq2/gxNl6j+XbB3o51it6YTTx8xLW1joebwiJHI/SN61KHx26CxpqWZl6wFZWPMkkkJ6NWsex22UMZs1X1EMYOy2ql66eMdncpWOYF/9MTtpKZGSISnjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghlDpdzfFZW1b26aiZeMj6Wc9Y1fd4AUZUh72r7Rtv4=;
 b=uuIphuZFOrYGhFB6MW/VWJBQ5k8v9giZTcfhRT2L8nDkx/xGXe6AefQ1wj/9Gexc8xb6Cq2S34bgVsnRe18E0070oXvJWbcUrIsOtdAIBUcRYSHHs3ZzUNNhkCaNmMTjToNZ92tK1JKVkTkYjU0hFtWDwHAcmT3YcbYGcWI6yvM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4900.eurprd08.prod.outlook.com (10.255.98.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 09:14:34 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:14:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 05/23] quorum: Fix child permissions
Thread-Topic: [PATCH for-5.0 v2 05/23] quorum: Fix child permissions
Thread-Index: AQHVmKlxf1fz9fVM0U+j3vx/qAXo2Keh+X6A
Date: Fri, 29 Nov 2019 09:14:34 +0000
Message-ID: <052900a8-9ff5-6144-592c-45d9a2eb6e5d@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-6-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-6-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0016.eurprd03.prod.outlook.com
 (2603:10a6:3:76::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129121431807
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a61a2c6-d30d-46a8-1b69-08d774ac8cc8
x-ms-traffictypediagnostic: AM6PR08MB4900:
x-microsoft-antispam-prvs: <AM6PR08MB4900ADE40D2DAEC5ABD2DB2BC1460@AM6PR08MB4900.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(39840400004)(346002)(189003)(199004)(25786009)(66476007)(64756008)(66946007)(229853002)(66556008)(66446008)(4744005)(14454004)(7736002)(8676002)(2906002)(478600001)(305945005)(71190400001)(446003)(26005)(186003)(36756003)(71200400001)(66066001)(6512007)(386003)(6506007)(54906003)(81156014)(81166006)(6486002)(2616005)(8936002)(11346002)(76176011)(86362001)(99286004)(110136005)(52116002)(256004)(5660300002)(2501003)(316002)(31686004)(31696002)(102836004)(3846002)(6436002)(6246003)(6116002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4900;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlgBCJZFxKijp5dyVfdK+im+ME6nCaw8y/5Q4jld1QBLnYNOtB76hNqG9Enb1Kcewcvl0D/Qk9VoSM3v+BZRkaxM/58a2b9uHPYBUP/7rFRffmLRo+GexQWovfoT7eEAgFhl9hu09CuL3+RzrKkahLGKOvDyQdOBNChx0D8CB3YzvnM/sx3omqn/Vlbw9YtN9r1UmFxcBp4BwfxblLj9IQPOrACzApki4MzOliv7QxxTK8QsBxFb3izPaFsS/GD0N72Q6ijK4282k9wqrpQBPV5ZTuHe5voG5/AAH/I6H/YT/vPwvJIPi/MTLDrBLrdOIZcD1leczfUOh3jEEUh52mheVI2s7A1K29TOK3ansoiHeKchKpOxI93bxS6yjpF6NBRqISiwrpAStxHfaAEIBnYDgBeMy3a3tsdYp/pFv+uBj5b6pY/Rdl0+E47uORRy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E0915D5D530017478FA1BBCDFCF54C7F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61a2c6-d30d-46a8-1b69-08d774ac8cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:14:34.3294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXIsmO4+quRNRwlQsSgWNfrtJxh3++vsPA1x5p0ue+mmiL3n51zmoHevHLRFCKt2MycrOrAKpbjkfGpMoUrgeGWwwqLHD1kQrHxR69q3ZaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4900
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.117
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

11.11.2019 19:01, Max Reitz wrote:
> Quorum cannot share WRITE or RESIZE on its children.  Presumably, it
> only does so because as a filter, it seemed intuitively correct to point
> its .bdrv_child_perm to bdrv_filter_default_perm().
>=20
> However, it is not really a filter, and bdrv_filter_default_perm() does
> not work for it, so we have to provide a custom .bdrv_child_perm
> implementation.
>=20
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

