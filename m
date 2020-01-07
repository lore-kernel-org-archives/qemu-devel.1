Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90300C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBB42075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="efSmjN1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBB42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioci0-000685-P8
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfT-0003g8-1I
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfR-0001aE-LP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48553 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocfQ-0001TL-IS; Mon, 06 Jan 2020 19:24:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCmX3SNXz9sR0; Tue,  7 Jan 2020 11:24:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578356652;
 bh=1bHsKSBS3bKUQ2pR9M825T3Fa2TU9dWNO+YnKsEB4Dk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=efSmjN1Z/9qdcZy54g0tnXs8XXCPkvdgP5iPrZ91hdDsIhm+iF1On4eQt3aJvrORk
 0jq5J7n1zevedBQuR3zmuLruTiJotvoDAXvXVVok/j81iPqY/C2LN0s+u+LZR2cnhw
 vWxi3n4QuWA3BS4pkMRxJJIMDsdbukN54oHMBf6A=
Date: Tue, 7 Jan 2020 11:11:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 05/12] xive: Use the XIVE fabric link under the XIVE
 router
Message-ID: <20200107001106.GE2098@umbus>
References: <20200106145645.4539-1-clg@kaod.org>
 <20200106145645.4539-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CkAEuVknXa3V+za6"
Content-Disposition: inline
In-Reply-To: <20200106145645.4539-6-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CkAEuVknXa3V+za6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 03:56:38PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> Now that the spapr and pnv machines do set the "xive-fabric" link, the
> use of the XIVE fabric pointer becomes mandatory. This is checked with
> an assert() in a new realize hook. Since the XIVE router is realized at
> machine init for the all the machine's life time, no risk to abort an
> already running guest (ie. not a hotplug path).
>=20
> This gets rid of a qdev_get_machine() call.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

1..5 applied to ppc-for-5.0.

> ---
>  hw/intc/xive.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6df89b06da38..12a362b681a6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1378,6 +1378,13 @@ static int xive_router_get_block_id(XiveRouter *xr=
tr)
>     return xrc->get_block_id(xrtr);
>  }
> =20
> +static void xive_router_realize(DeviceState *dev, Error **errp)
> +{
> +    XiveRouter *xrtr =3D XIVE_ROUTER(dev);
> +
> +    assert(xrtr->xfb);
> +}
> +
>  /*
>   * Encode the HW CAM line in the block group mode format :
>   *
> @@ -1470,12 +1477,11 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
>   *
>   * The parameters represent what is sent on the PowerBus
>   */
> -static bool xive_presenter_notify(uint8_t format,
> +static bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>                                    uint8_t nvt_blk, uint32_t nvt_idx,
>                                    bool cam_ignore, uint8_t priority,
>                                    uint32_t logic_serv)
>  {
> -    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
>      XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
>      int count;
> @@ -1607,7 +1613,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
>          return;
>      }
> =20
> -    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
> +    found =3D xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
>                            xive_get_field32(END_W7_F0_IGNORE, end.w7),
>                            priority,
>                            xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
> @@ -1727,6 +1733,8 @@ static void xive_router_class_init(ObjectClass *kla=
ss, void *data)
> =20
>      dc->desc    =3D "XIVE Router Engine";
>      dc->props   =3D xive_router_properties;
> +    /* Parent is SysBusDeviceClass. No need to call its realize hook */
> +    dc->realize =3D xive_router_realize;
>      xnc->notify =3D xive_router_notify;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CkAEuVknXa3V+za6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4TzJoACgkQbDjKyiDZ
s5JR2g/8DJtL0mr3NpyzuXJbaNuC9GVQLfVgcEljXEVHqsXUzx3aFk6igCQ2IwX/
5vG+36+YltR+3BZDGJX14xwhYNExuMnPokGTlJN4As5dhKd8KZ9K+mIsEv0TPBj1
XUCx7tOQR94+DoDE6vb4Yt9RBU56mrAwkcSzN0ZSLiBCVdYjb+dbMjSDL3+YGqyY
ozEr6z/SgsO/mtvtn3/a37JA7Rp7t27JUIDbRp+sJSv1jGetSmZMsICr5EmmH1N3
Y2yvqxWhQ+/m+9RFVlNV9A3CZJACOkHKfaz/AU+j/ENMvIyljsDwNa6yJ5NYGXlp
zt1J+UcKNt1y0Kqq21brtHStR1SRfuqefPhb0fCchhekPF+04DUViTKRB1DNnf5b
y9w865mFUOdgQdf1GvKxSKfDlGvj+gDLbyz9MVzMAolQRLMmFi2oBOUkXN4kHlde
rjTYSh5kx9Y+ploucRMVUWoQcpn5mbvyPdAFp/q9b9uZQ5tVL7CCUQmm36iq7TRT
m8ZL3AgM8mUu1Jvy0GT2MpkgwdKVK8N9V6EmvpUexv7lVzcoclR1Ho83WR0BNC0r
/YPTtAxdnsZ7Tsboi/QCK2Gmb+FcVBZI6xiayLda/ErXuGoBAKC2l553VIhDrPya
teYuxKFUYlKGJ1LI/LUQ8Tk9Wq+Urb1Jq4/uBVu5Gh5PCY3mwUk=
=7zXV
-----END PGP SIGNATURE-----

--CkAEuVknXa3V+za6--

