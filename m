Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A05C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FBD20663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GZrhgu+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FBD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijGyd-00011W-JK
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 01:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijGxY-0008AL-0l
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijGxW-0007Pl-GZ
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:12:51 -0500
Received: from ozlabs.org ([203.11.71.1]:33597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijGxV-00078O-Cp; Mon, 23 Dec 2019 01:12:50 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h8Cd0kmJz9sP3; Mon, 23 Dec 2019 17:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577081565;
 bh=cKhZnFqkTcB/Y+VtivNJH0/eSHboQ5sJv/GCCBoCeiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GZrhgu+Vucrvo8jlqFlNOf78Pi/ltOOcLEboYp6L1rVS/JgYS1sJcXoJWQdkja85F
 zOYoa2wcXpMzeAS4IU9mWI4fIH7u0LZUfq3KttS78Sk3vE5yB0E9mtICySajvZPnLk
 Jayar97GE4vboddx9kRBZLBYqxDPpRnn3Mb+jE3w=
Date: Mon, 23 Dec 2019 17:11:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 08/13] xive: Use the XIVE fabric link under the XIVE
 router
Message-ID: <20191223061128.GD38380@umbus.modem>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-9-clg@kaod.org>
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


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:50PM +0100, C=E9dric Le Goater wrote:
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

LGTM, but will need rebase.

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

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AWpAACgkQbDjKyiDZ
s5LPvQ//bdCi8S2uGGSKGaYfZ3GgjbRx5VhGNveCWtN5QyZWFThxPjzyiPJV/Eju
7NJA+p7WaRUfBjOzM0DXAkILvqL6XCr2hJZgkC2nebnBXgYO8lTsfyY7vTcKFzHi
F+txFe8PR+b9/GpGf6NNQGZmZNpbzeSU1jOngUJ7OeKR50Ljhcdc9lhCjHZ6asSG
KykbV+WJsbVMgXf8BVLguEYiVB01epko/b2prdoDjed9eyNRRbqJJ27RGJikUq3h
GAi0uQibZ2t8YcpwNUQLS2EKYSlb6+Yu00HSAsPigM3eiLnPvzy9RROC3zwhNHo0
TQI7B8r1tLVvNcoMeXx8qTs6yPqLNoy/ZGKWGyMaZ9aD7dyVBlZT9ZCc/TGW5YY2
akgzbuiY/5SWxHpNcb7baOJJ2bg2ruY6JV6dXUjewCfRlP5YziL1EFToeEZ3ReYA
jHQbWc1WrVHcpiCIN27iQQMmAk2Nl+yhciRMmChzIWSS+KpHEU+r1Sy5tefKR/op
hl1hRW6bFfNhdY7XORjuzQX/a7rrHVZ9SiO4xtFPLnaPKGJYwAQ82Ux7lqbdRDW9
xR++/UIlUR+aJ7UjnIJWSC3LiZQef/gNHdZQXs/MadXH/4/anE7cuPNvO1HJW+Fd
h63U3RQ5RidLyLIL08djs3FUouWrInVfMDLyciRb76OlzZln6ig=
=22E2
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

