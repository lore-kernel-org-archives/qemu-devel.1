Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40852C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B848B20643
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LTPdRHVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B848B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUKD-00062k-L2
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXUIa-00052f-1z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXUIY-0006jm-K3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:01:51 -0500
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:38941 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXUIY-0006iH-BW; Wed, 20 Nov 2019 13:01:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLfhcH7eLdVB6cyMIxrlLTm7FmcutZohA5nWR09H8QGIdpBA847jbOYDpbRBFHXQrn3Nv4G73cro6J0xqmOnoq0EaNqeH4l0eJsDplZwYq9HGMO5Wg4CW88dSIhD0SVesuCMmMD6aviPQAaXZqbm0/AvHbAzE/9Oy6N5AcDWpcDRGzctd+igFW0HyiB+ZQhVTAcVuRCj1k9qt+XkZqbba8dEAlso9UqmWLhrYM0r8AM7EIlcRCKODV+4AvroCt3op+O/amSmroUFsSNdoGQ2SPhwQPqJVwJ7vmE2pNGiCxWZIUxFRjtC1oq9PxkZwtPicQdhV0RUptx0Lz93/3Ozog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKikWfdUUhRLsk/hpa3Z6e+2shCIN+N5kNScAySiLs0=;
 b=BW0Nwntwph0RLKw8kYsARzQ6H+TcCtiDU3n+EdX8ds8WnM+kn5d9Agu2W9rLrr3ErtJvXtd/2ywLfJDyVpcOJdS/JrJWAmwv6u9W6OXZY2ZZzunPHqu51iD3QanE8omLbkLfTiif8SRQiA+FCWTJ9q4Cac5XfuiyAwJRUGZc5QrF5NJThx0M22VO+8ffUwFzROExaXkJreziy9x7SrDE9Uzy7B865xfBVCmt+FIBnlMQW9TdljQcQRkSRE7cAqUsGtqng5nHEVedCdGt0XcEW3lb6dyeAu61IXlKQW0juwUa5LwHDOsiB2NgBpvpPhKecz/ZbilJbcB0veMbxr5uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKikWfdUUhRLsk/hpa3Z6e+2shCIN+N5kNScAySiLs0=;
 b=LTPdRHVNZbSHVZHDTbSc+VkFyBn2N1zxWj/1CYhIegMTsGY6zXxD/eLvF48ge7dj4POyZfC3QO/zwBDux3QkYeWkaAoOcFRfUGGBzJJ1RzKCakW14/oMbtv7lQa+uopMkh/OFU0LSXXoY8u1mpbyDNNUtCX+XdgPqJ+p7svxgf8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3333.eurprd08.prod.outlook.com (52.135.163.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 18:01:47 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 18:01:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/6] block: truncate: Don't make backing file data visible
Thread-Topic: [PATCH 2/6] block: truncate: Don't make backing file data visible
Thread-Index: AQHVn6tWfO4qk+G27kuJNGXuHPps36eUWcwA
Date: Wed, 20 Nov 2019 18:01:46 +0000
Message-ID: <57c28fd7-4949-3da3-37c5-e2db0914ccae@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-3-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-3-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0231.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120210144451
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3077932d-9a26-4059-7455-08d76de3b532
x-ms-traffictypediagnostic: AM6PR08MB3333:
x-microsoft-antispam-prvs: <AM6PR08MB3333538F2AF0D42293344DBEC14F0@AM6PR08MB3333.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39850400004)(366004)(376002)(199004)(189003)(6486002)(81166006)(81156014)(8676002)(76176011)(14454004)(52116002)(66556008)(6506007)(2906002)(102836004)(4326008)(229853002)(5660300002)(386003)(11346002)(26005)(2501003)(2616005)(476003)(486006)(54906003)(31696002)(86362001)(6436002)(6246003)(6512007)(6116002)(316002)(3846002)(31686004)(7736002)(66066001)(8936002)(305945005)(186003)(446003)(110136005)(71190400001)(71200400001)(99286004)(256004)(66946007)(478600001)(66446008)(64756008)(66476007)(36756003)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3333;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+AwwEZ7ga/3ojSrAI5h1wzja0hVJWEpKDeHzlTM2jdA624TcsIBwLTu/KSvlXYTUFwjaQvh2RWKma4ye3al2O5kzLFauo8BXKwoYjP3doED9PIClIWdi/Q7NG8VkYKq8fGwZ6DOCBiRCYWV0A1TBoWveiRFxhCQN6We8wOINU9rX8CPshzthzvYlJxPNH8Nax8Nqc0rIH1KAfC3PZhvXH501Ye3/0fgp1FVB9GapaoZO0AOVVufYv3OKn6Xary3G25aTdTk4K7HEghkYz7R5/0Lwfw+90mydXNnGmk52t0f98krtu0oNLHkvLASyDwu2vqgLNjMQyE2lE+z2OjYDm1zyHCRt6S6NXTNsxpO7Qn3cs7SeVGIyE8hPQ1dxVpTnTY7lHXHMXL7HExkGUabhPAd74tH1tp5V9Owc64UJnWMusHEjjL9bPKRRfSg9FnB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BAE9E57177F4D84592CB0DAC40B19C1D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3077932d-9a26-4059-7455-08d76de3b532
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 18:01:46.6018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7anzrSlbF64xTGEGz/ypA9u7AwkKX9qp98q5NmijvD67XmkZ9nunR+VBucwB6hztG1lAe7XS8prF3w8NPRntWom7HMXkTzVce3PooxG8Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3333
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.97
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 17:03, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
>=20
> The old behaviour made a difference in 'block_resize' (where showing the
> backing file data from an old snapshot rather than zeros is
> questionable) as well as in commit block jobs (both from active and
> intermediate nodes) and HMP 'commit', where committing to a short
> backing file would incorrectly omit writing zeroes for unallocated
> blocks on the top layer after the EOF of the short backing file.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>=20
> diff --git a/block/io.c b/block/io.c
> index 003f4ea38c..8683f7a4bd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3382,6 +3382,31 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child=
, int64_t offset, bool exact,
>           goto out;
>       }
>  =20
> +    /*
> +     * If the image has a backing file that is large enough that it woul=
d
> +     * provide data for the new area, we cannot leave it unallocated bec=
ause
> +     * then the backing file content would become visible. Instead, zero=
-fill
> +     * the area where backing file and new area overlap.
> +     */
> +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF) {
> +        int64_t backing_len;
> +
> +        backing_len =3D bdrv_getlength(backing_bs(bs));
> +        if (backing_len < 0) {
> +            ret =3D backing_len;
> +            goto out;
> +        }
> +
> +        if (backing_len > old_size) {
> +            ret =3D bdrv_co_do_pwrite_zeroes(bs, old_size,
> +                                           MIN(new_bytes, backing_len - =
old_size),
> +                                           BDRV_REQ_ZERO_WRITE | BDRV_RE=
Q_MAY_UNMAP);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }
> +
>       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Could not refresh total sector co=
unt");
>=20


Hmmmm. I'm think that for commit, we also should zero truncated area if !bd=
rv_has_zero_init_truncate(bs).
But we should not do it here, as it should not be done if we just resizing =
disk..

What formats are that bad?

--=20
Best regards,
Vladimir

