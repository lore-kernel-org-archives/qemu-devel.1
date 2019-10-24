Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4BA20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LoplJj7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4BA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfv2-00087v-42
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNf9g-00058e-D2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNf9f-0007IT-9n
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:36:04 -0400
Received: from mail-eopbgr140124.outbound.protection.outlook.com
 ([40.107.14.124]:31625 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNf9Z-00079x-ML; Thu, 24 Oct 2019 11:35:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+o4rr06Cdv1uNur/nBRXBjZFhU99lJTlfugbQni4XlD59yDudkZLcQjvybpLVC3CL1nieYMENYVE5jbJ3PEvTPz7B1y8XBTcUYs8Yw3YzF1iaDd1Os82DsyLW+YGriF/um/4S5Ln7KXRqpInnXfKTxk828Bkk/rLm5D+eGKfVS+1v4V33N922cfr6Rd99JIYCe5rYW5R8Bvnyr7+WoFxV0SOh8FqDusWU3WBajJucJW4g0a8BV2EWU2vOTz0UH50IkW/vaupiGLd5T+m4ZZM7lun+tGOVY4YmVQRgoV7afOeWWF8eCnfbKZND+qwFU7BWMdiX1BqKIZMs+2N/5EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+4o90liPwl/6hfookt/09j/6VcTn8gCBIWB3ObCnZk=;
 b=CzKfaWq0L0J2qfhHQ4DhM38bjzOAci6ltCKAYA8u+il4JwHhtTEsflRQLrYgt2qhQSRkRbVs2EbyKkomtrDqBZbSW591On/EZk52pp0D4WYkpBno5wR0EXQprAYRq0D+hmRzhyF0JApw016yHitbM97IZ1De7yxFpAoEXhCTGyada5aEnE2ntkWoVCegzOLySD+PEkex6p47IGHIHBE2aC9eb2ECjxVDVg+KVtAnGMS5tNazdV64jMvx0eYQy6bt48a5GyqtOJet07DPCz48GCpB9O0nygGmYuMymf8ND0C3g7OQaB+EAXzgKNgkLTfutuSCUFKyKWkQl+mDY0Az0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+4o90liPwl/6hfookt/09j/6VcTn8gCBIWB3ObCnZk=;
 b=LoplJj7d2cmt97/vS+eMnEpkHUUAfVN++vRCRkHu8r8Ysgkqc/m4kGTyL+c/+7HqFS357X+kb++3Rzv9oaP4igQwZysuXdJoCd5y6+Ewz2eIPEttYPB4AEQCqnLIGfsCyraxbbcmGdlQLXk6Ah2rr5Q7nsDuKqXcYw+bVWG+x4U=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5154.eurprd08.prod.outlook.com (10.255.29.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 15:35:54 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 15:35:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/2] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Topic: [PATCH v2 1/2] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Index: AQHVinvHvXCpnsFASkKqEU6ua/i9dadp7HaA
Date: Thu, 24 Oct 2019 15:35:53 +0000
Message-ID: <1c120c98-2693-5e92-2dbb-4037d3472b63@virtuozzo.com>
References: <20191024142658.22306-1-kwolf@redhat.com>
 <20191024142658.22306-2-kwolf@redhat.com>
In-Reply-To: <20191024142658.22306-2-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0301.eurprd05.prod.outlook.com
 (2603:10a6:7:93::32) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191024183551801
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 071ca739-909b-45f4-81bb-08d75897db44
x-ms-traffictypediagnostic: AM0PR08MB5154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5154429F7E0B0698B8A03B72C16A0@AM0PR08MB5154.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(136003)(39840400004)(376002)(189003)(199004)(14454004)(2906002)(66476007)(6486002)(229853002)(31696002)(6512007)(71190400001)(31686004)(66066001)(6436002)(86362001)(476003)(99286004)(54906003)(110136005)(186003)(71200400001)(76176011)(478600001)(386003)(6506007)(6246003)(26005)(446003)(102836004)(52116002)(2616005)(11346002)(486006)(8936002)(316002)(4326008)(36756003)(6116002)(64756008)(7736002)(66446008)(81156014)(305945005)(5660300002)(8676002)(81166006)(3846002)(66946007)(66556008)(256004)(14444005)(25786009)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5154;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cuyP9U4a61bXc8aIO38lY6ucCecIVovdlBF1t7cX114gKl0wI7uhB0p4MrsMCspDApq+tfxrjaskpvhti0eMa091ZZJEiUf1jIN1LbXRWiNQClBVl/nLSz4dO12QwqYNo5ZgoAjBgleBoNhj/C970P0M1LEbAZPyANORPk3QNj6Sd44cAoziY+SVcQRMDeTxhoaKHpD3/V9uYLI2ho9IEWhlEKSJ0j3KIS9DI92AJIwZawZGrzsL7sAjid4E+TJ8qyUFZtVoGa2Fuj+ILRR4JErR4Br/2WeSIXVwMY7uCZkGRIgOizQtMtGsyO0gHnkCUIV/P/7yd8hq9W+O3wxBoj0DPqzVXjjcPcznWeTslwPhXvJTWZc7jbp6II98YzO1A3lAvrf+OjUnxNV+T5NRg97L6KQ2SsdozLXSX2CY7GtD0vWphB1W+eqd3x1NHsi
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A8D73AFA3E074046B543721CC5DD003F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ca739-909b-45f4-81bb-08d75897db44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 15:35:54.0049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j45Xjx7VdEK/DOobMMl7v+j3iAKL4MvImAMfN6+4uvaTGn814XuAQIYdcy2MvbH8mG2Xfo9QGZVzX8qZ+Xj121BDcfn0J8/L/TdIUP6djr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5154
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.124
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.10.2019 17:26, Kevin Wolf wrote:
> Some functions require that the caller holds a certain CoMutex for them
> to operate correctly. Add a function so that they can assert the lock is
> really held.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   include/qemu/coroutine.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>=20
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a4..f4843b5f59 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -167,6 +167,21 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex)=
;
>    */
>   void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
>  =20
> +/**
> + * Assert that the current coroutine holds @mutex.
> + */
> +static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *mut=
ex)
> +{
> +    /*
> +     * mutex->holder doesn't need any synchronisation if the assertion h=
olds
> +     * true because the mutex protects it. If it doesn't hold true, we s=
till
> +     * don't mind if another thread takes or releases mutex behind our b=
ack,
> +     * because the condition will be false no matter whether we read NUL=
L or
> +     * the pointer for any other coroutine.
> +     */
> +    assert(atomic_read(&mutex->locked) &&
> +           mutex->holder =3D=3D qemu_coroutine_self());
> +}
>  =20
>   /**
>    * CoQueues are a mechanism to queue coroutines in order to continue ex=
ecuting
>=20


--=20
Best regards,
Vladimir

