Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC122C33C9A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76551206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YIYbvTwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76551206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRIN-0007is-GJ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRGB-0005VW-1e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRG9-0001Eo-Cf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:47:10 -0500
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:26262 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXRG8-0001DT-K9; Wed, 20 Nov 2019 09:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUd8Kw23cBL2i0AbKiDkDcUuzBsE1wyJLmsPb+9O2bvC0gqpURwDJiGyCdnFRkhy2DmE1lc8EChkNdL9obvHDkuxw/QR90FSwmzz0IU6e+a9BvzYAG/Qd82QBZoKyZ7R/3SheDzs32Bd7Xp6vRO4zqjP8y/X/iloa2kAUHwk61PKBpk6zoK3Oy2MCYMc4CJlbLitkOdcOeQiBmY8EWBPh3zv+p0h4wsab3mFJ/C4v1UVsyirtQ6e9ycN6cJAtIU2tgo88JqXdNrKNU0WnoB74iM9d+oMiPBj3kUnPphpqcD3K0Lo2e7B75bCr/Iznf2TX8E3fzZ7vP14LEbPI2GITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SrI9Asb1v4BPOT/e6jAMEgNQv3bIfIWCMRrood0hSs=;
 b=QskpxdIm+i7xWSxB9bMNOxVxYD0yf/tEs1vqrcSneDncmPK9udUDd9nnHtLKOayRzJH01EFlsyxbVx5UdPI3U30nb9qrC3MZk2mGlJYOJWjb48K3cR+y1SF3ITx3OK8GISRwVrOeQD0ZctzH6JqEZwbity1m4yLTTvlfepKv5mVW5sRp+R1Wk5hPISt0X/1quSqTLv3cFaby3khkO21+lfQZupvz6c+d4M1R6tU8U2hgUfdllt3vmHuCJnAjAEePN06OCkrSi2lvqE4CdeIJDNbDv29GDo2CunBHEH4i+l5qKkE5ZMNrud7CZ7PfTi1MIAf/IS+hbPvaFgGFx8R8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SrI9Asb1v4BPOT/e6jAMEgNQv3bIfIWCMRrood0hSs=;
 b=YIYbvTwRLdmJBnGaM9ytsI8uxUA93/zAa3CNq446jjE7wOByOZDi9gTlq3JACWPxJaLASaIR0hkK91LbnQ1qUJM/I9HEOzUyKxPLTCsMqHCHa/vp1zUAxWA6IDfJTa9dw0oAgPor05HM0X2Kq3wIEiWRSiF0oBuC62/Ipc71seU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4215.eurprd08.prod.outlook.com (20.178.91.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 14:47:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:47:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/6] block: truncate: Don't make backing file data visible
Thread-Topic: [PATCH 2/6] block: truncate: Don't make backing file data visible
Thread-Index: AQHVn6tWfO4qk+G27kuJNGXuHPps36eUI2gA
Date: Wed, 20 Nov 2019 14:47:05 +0000
Message-ID: <5f37eeef-2a2c-dcdc-0e2c-b1d49bc9a3d7@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-3-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-3-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0074.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120174704026
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 185dbc67-7652-444c-fd48-08d76dc8831f
x-ms-traffictypediagnostic: AM6PR08MB4215:
x-microsoft-antispam-prvs: <AM6PR08MB421576E57A8EB2DAC619E87DC14F0@AM6PR08MB4215.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(366004)(376002)(136003)(189003)(199004)(110136005)(8676002)(386003)(6506007)(81156014)(54906003)(102836004)(81166006)(478600001)(66066001)(6486002)(229853002)(476003)(99286004)(8936002)(6436002)(25786009)(14454004)(2906002)(36756003)(7736002)(486006)(31686004)(186003)(31696002)(2501003)(64756008)(66446008)(66556008)(66476007)(66946007)(256004)(26005)(316002)(3846002)(6116002)(52116002)(5660300002)(446003)(305945005)(71200400001)(2616005)(11346002)(76176011)(71190400001)(86362001)(6246003)(6512007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4215;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTV8mM1IefqvcEAuHOx8CBsyyXMt/kytL9C9c37m0q3mBx6oZCNl36uxcaS6U7l1m+bjjPu8T5dvjnAk3w8lmAfAZhT2Z9htVOs5lWJAvlmbCaneHijG+e2+Y993MVlBDt7NWQrt38chnFBz8UC65WpPU/XWREyRsOBYFTe+weKEqEIg63jZG5GlPY3TWXzCCArH5nl2U4gl1pNgXkpTWmkDpOykZIJFad3RJ6GRnT2jVCPVirqv2HzMPMiywQ8ytfItwan4fiDhft+p172KckNFGHlTKTfvr/I8odyH7BdXKB8480Yw5Dl4lvFG6xlpZ+mTdmTrtqzESqsJI+ZD352bq6Auv/+DTLbbkUWwV5XXan7ObXKA6JM4dJb91UabKyqS8Tj4ORQtRYy5ALxCsTxXTttJeEVLmzA63Zs74PHKdnZwvpQEUlAfjSWfrazS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0C3E1B0644AB1E4AAF316EB9DBBFB6C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185dbc67-7652-444c-fd48-08d76dc8831f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:47:05.9091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etQSgAP8YYeZTkU+5JpDDFlC39AX+4EpcXFsJKcGY6fi+VEppuljYVX86xPBG8Wq5gXDFaGO5qQYUkDytVmpCLppsQGugDhmexch/V8Q6Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4215
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.90
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

Should we mention that, still, we don't care if user for some reason will c=
hange
backing file in future?

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

two over-80 lines

> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }

should we improve "off" mode specification in qapi?

> +
>       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Could not refresh total sector co=
unt");
>=20

Hmm. is it correct to call write_zeroes before refresh_total_sectors?
Note that qcow2_co_pwrite_zeroes rely on bs->total_sectors...

--=20
Best regards,
Vladimir

