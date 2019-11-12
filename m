Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFE7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B2D21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GJOcYJj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B2D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT7E-0008IB-7P
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUT65-0006vz-7j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUT64-0003tG-0b
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:08:29 -0500
Received: from mail-eopbgr50125.outbound.protection.outlook.com
 ([40.107.5.125]:43349 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iUT63-0003sx-Pl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps2QAmv1z2jflmI9M1VY6blbOaAKnzlKOV7oZ2KaNmvGBJqlt918xRI6P8BuTSL+3duuXWXL0S/uekFm+CU7uVRVb/mWqIyIuJ0kibw/ZoumLKw1Jl1H+F9s/YLrCYuaWsy4/j1XCcL6bqBdD6CrX6bCbU7tan72iyHw2DPX9qyp9hskVGBtQxyNXJGWa8XqzUHRRlK3hRFp1VaOS261Csms+3iEQCt1Gc4VVBQ67YQNWU7f2iiJH2rIP0IUAsK119ZOYOWPlu1bK22Y4ZpzWGfuRem7C227ToJW8Kgfcb1XA1m96Fbfldv7zd8HWp94wYz/bvP70dDxfCC72qRFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1bX5unqhpQKieJa+AV71Uf9WOL+JpN9HL6VqPZWX/I=;
 b=b2JPWwEX25UkqxWItxyGkqQH0Cia4W1QGtZ00QF4oGKHe8bATXihvAEsznaCTTbDFZ7Zwg+yBcf/oOx4CPpN28C5MtbB2G0pHGo7/FOysrl3OAIEmmUG+zFgowCPJBfrIxnQhcbkR/E2YQhl+th70ndrLVPzi4Zkw81MecTfsCkSzWR9C55kPRVQ53H+2Sp2cptvKaWud/k+MV1K3wEjen4NSD+TAf2g5ZkvvEYwcT3kHsZJgNalOxqMu0XE4p83ur0YtZfoP35T1jAF8QYgnqmUuvYRwrPxiJCtjOQUupwOU1AoJvyuh6YlQ80bqa0XuYVmXa6oUJ4xiifXeUmlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1bX5unqhpQKieJa+AV71Uf9WOL+JpN9HL6VqPZWX/I=;
 b=GJOcYJj+Ufpu+TXPUj/8+/QmANYJ0K6LjJhfOstdO031/aZ+URSTV6/MTU1keYWS29okSczT3SUjEFR6rGW29tr5EGEswWj2Cs19rFCcngW3Djn/vGV/7iYaO79Ykb5jHcxuAUbaTyvrRAj88nRCrkMHbug/rG59p1vyWDJwko8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3125.eurprd08.prod.outlook.com (52.135.164.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 10:08:25 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:08:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
Thread-Topic: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
Thread-Index: AQHVmM+U9laNqp2pZkywys5l+H8GrKeHUJyA
Date: Tue, 12 Nov 2019 10:08:25 +0000
Message-ID: <9f0f8f87-3025-67be-d423-51e2e910f5f5@virtuozzo.com>
References: <20191111203524.21912-1-eblake@redhat.com>
In-Reply-To: <20191111203524.21912-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191112130823291
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb95877c-7568-447b-ec23-08d767584187
x-ms-traffictypediagnostic: AM6PR08MB3125:
x-microsoft-antispam-prvs: <AM6PR08MB3125C53491D4665C11FF4434C1770@AM6PR08MB3125.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(39840400004)(136003)(346002)(124014002)(189003)(199004)(478600001)(8936002)(81156014)(81166006)(6436002)(8676002)(14454004)(2906002)(229853002)(305945005)(7736002)(6486002)(25786009)(186003)(26005)(66066001)(99286004)(4326008)(6246003)(36756003)(2501003)(6506007)(52116002)(386003)(76176011)(14444005)(476003)(486006)(2616005)(6116002)(316002)(256004)(11346002)(446003)(71200400001)(71190400001)(3846002)(6512007)(110136005)(54906003)(5660300002)(31696002)(86362001)(102836004)(66476007)(66556008)(64756008)(31686004)(66946007)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3125;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/VpNZBG1/u9ZHDe+w4rUO83sJEsFMLUaKlLf2s2TwXijMCVoWpVUku/Wh6Z6+gw4IIuXFiIsp3IjnldafWy0NhFgUoJjfJ1wtVA3FIldeWEZycMk/HaVDJyGBzf+pBr7u4xuA0qycBrqEJC4uKzj5LJtPin4BV3NXm+HeMXZDB7DJMP8h3LWDyzjZ2UmZ/mdn77ZCDUF9QlslsonArxVFB6Pc6Y8Zb6xTVure9ySVhzZ+H9Tw/oVu3SKgoF9EzLncgxRdLSaACN/4HIfV9COWkVkOgYs2NTI37MHMB9SFxsOzviucuJswkz/GQXwimgo/hENLtNuRCkb1o7dXR8MZzIKtA9F52q5VpYFo0lE7dGvW1cx6PErrZGwrCbiWU+qrK+0LDsNzm/NwoPdnwYTqjvFYiA/SXgoFLDrwrHvUMF5w9THaPsTcTCT/ILq23k
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7E618CC132E2354B9CABA8206E899C59@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb95877c-7568-447b-ec23-08d767584187
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 10:08:25.1883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tk89OAk0dEm1UgAYnmdT/j5AJtgbxZ5iUfaxOnUfSfm7Sy5dNU/rNGfZAtloUsZ/3Wi/I+HU+Uj3Qz2ZP00DXrApEMWLRcDOljWt+CHz/8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3125
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.125
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 23:35, Eric Blake wrote:
> Coverity warns that we store the address of a stack variable through a
> pointer passed in by the caller, which would let the caller trivially
> trigger use-after-free if that stored value is still present when we
> finish execution.  However, the way coroutines work is that after our
> call to qemu_coroutine_yield(), control is temporarily continued in
> the caller prior to our function concluding, and in order to resume
> our coroutine, the caller must poll until the variable has been set to
> NULL.  Thus, we can add an assert that we do not leak stack storage to
> the caller on function exit.
>=20
> Fixes: Coverity CID 1406474

Hmm, I doubt that it will fix it.. Do Coverity pay attention to assertions?

> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> I don't know if this actually shuts Coverity up; Peter, since you
> reported the Coverity issue, are you in a better position to test if
> this makes a difference?  At any rate, the tests still pass after
> this is in place.
>=20
> I'm not sure if the compiler wants us to insert a 'volatile' in any
> of our uses of QemuCoSleepState.user_state_pointer.
>=20
>   util/qemu-coroutine-sleep.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
> index ae91b92b6e78..769a76e57df0 100644
> --- a/util/qemu-coroutine-sleep.c
> +++ b/util/qemu-coroutine-sleep.c
> @@ -68,5 +68,12 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockT=
ype type, int64_t ns,
>       }
>       timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
>       qemu_coroutine_yield();
> +    if (sleep_state) {
> +        /*
> +         * Note that *sleep_state is cleared during qemu_co_sleep_wake
> +         * before resuming this coroutine.
> +         */
> +        assert(*sleep_state =3D=3D NULL);
> +    }

Hmm.. sleep_state is not owned by this code, and this is possible that user=
 of the API may want
to reuse the variable (for another call to qemu_co_sleep_ns_wakeable) immed=
iately after calling
qemu_co_sleep_wake (which don't call qemu_coroutine_enter but aio_co_wake).=
.

Seems, current usage in nbd code is not the case, so we may add this assert=
ion, but I'd add a comment
to qemu_co_sleep_ns_wakeable, that sleep_state must not be reused until qem=
u_co_sleep_ns_wakeable
finish.. It seems obvious, but actually it isn't, keeping in mind that qemu=
_co_sleep_wake() call
may be interpreted as a point where sleep_state is freed..


>       timer_free(state.ts);
>   }
>=20


--=20
Best regards,
Vladimir

