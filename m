Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8762C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50082071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pp/NP8j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50082071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZq4l-0001MM-9j
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 00:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpzc-0005Qm-6z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpza-0000Jb-H4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:35:59 -0500
Received: from ozlabs.org ([203.11.71.1]:33875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZpzZ-0000DC-NE; Wed, 27 Nov 2019 00:35:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N8d24xG8z9sSw; Wed, 27 Nov 2019 16:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574832950;
 bh=Mvh09Vm/J2IXnalg8BbOymoNpcowOUoByIveRV4xx2U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pp/NP8j3BvvnuNJhjpibDbFkaXrSGC2izbyjtSCJCeaQ1Hoi9RcrHTT90/ktXvU8f
 BtnU+L0GaRP5EJhpULSCo78H1f4LpQShkOTsIqEfubF1uRpR9i3LGCd/6WKncUPCpN
 H0YHD0oOuXvw0PjJu+O61B0znq+GRUGIn+Z8pO+E=
Date: Wed, 27 Nov 2019 16:07:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 11/20] ppc/xive: Use the XiveFabric and XivePresenter
 interfaces
Message-ID: <20191127050751.GQ5582@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cB4CxVy2Gp1bd2mA"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-12-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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


--cB4CxVy2Gp1bd2mA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:11AM +0100, C=E9dric Le Goater wrote:
> Now that the machines have handlers implementing the XiveFabric and
> XivePresenter interfaces, remove xive_presenter_match() and make use
> of the 'match_nvt' handler of the machine.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

8..11 applied to ppc-for-5.0.

> ---
>  hw/intc/xive.c | 48 +++++++++++++++++-------------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 1c9e58f8deac..8e683847bf81 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1423,30 +1423,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
>      return -1;
>  }
> =20
> -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> -                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                                 bool cam_ignore, uint8_t priority,
> -                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
> -{
> -    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
> -    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> -    int count;
> -
> -    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
> -                           priority, logic_serv, match);
> -    if (count < 0) {
> -        return false;
> -    }
> -
> -    if (!match->tctx) {
> -        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched\n",
> -                      nvt_blk, nvt_idx);
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
>  /*
>   * This is our simple Xive Presenter Engine model. It is merged in the
>   * Router as it does not require an extra object.
> @@ -1462,22 +1438,32 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
>   *
>   * The parameters represent what is sent on the PowerBus
>   */
> -static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
> +static bool xive_presenter_notify(uint8_t format,
>                                    uint8_t nvt_blk, uint32_t nvt_idx,
>                                    bool cam_ignore, uint8_t priority,
>                                    uint32_t logic_serv)
>  {
> +    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
> -    bool found;
> +    int count;
> =20
> -    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
> -                                 priority, logic_serv, &match);
> -    if (found) {
> +    /*
> +     * Ask the machine to scan the interrupt controllers for a match
> +     */
> +    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
> +                           priority, logic_serv, &match);
> +    if (count < 0) {
> +        return false;
> +    }
> +
> +    /* handle CPU exception delivery */
> +    if (count) {
>          ipb_update(&match.tctx->regs[match.ring], priority);
>          xive_tctx_notify(match.tctx, match.ring);
>      }
> =20
> -    return found;
> +    return !!count;
>  }
> =20
>  /*
> @@ -1590,7 +1576,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
>          return;
>      }
> =20
> -    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
> +    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
>                            xive_get_field32(END_W7_F0_IGNORE, end.w7),
>                            priority,
>                            xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cB4CxVy2Gp1bd2mA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eBKYACgkQbDjKyiDZ
s5KiXRAAuK82z7yATDi7iMKCRF3dA9yextq2g3xBQyMOInQ73c+Ad67NECkYM5RQ
7M6HLhRHIhwODynA3AxO4HNbu+jMgD5jn4nobx3eW0Efv4nr9ntMoyI7s1+xzKfT
hc+9joN+peCEGfib1C7/92qFr1IHsdYFlm9LZiU1+QrF8zHFO74jwxfJL30pKO6A
CA6PHzaVcvG75a+AXE3/lvtJDEFcGBtZ1zHku7kEV442JWDtYF9BL1wQgRNTTOiQ
tzXrz5BNaLblirf7/Tsjp3uelSmkcyhZDNsYm7TueQIGm7xYhXHkLmcmWRXggZp7
AQF2AQxXiq4qiV1ARaAzdEmAbKzVzTN4+1eZefpIAkm4H8qgq21g/hVCJyeEp3AH
VFvcWu6h6LGOvTet3GZ2ye9v4jmUerUuVSKt2t0KqWSY0DLsQHeNkYJamX4TOWI7
7UsdBjPGuwUK5VDHlpypA6fWguBKbkZRp8XcEFQna2DaLzXKuGrDMdJqKou9ce68
cOujbJm5r3+M8Xp/ExqM7xGmsJEk/va6szBLvgXKY4bXETc73NHTRxt9eCRUiS3Q
v+xSjxrcoTzB5uvBrZ3IH4I3jPN8AFW57L3jObJxgC5QdG3AwZ9GWrBED4wJrlB5
nN5ls3cc2Av262FfAgIa/UNRQPZDr6M76j7v/O71N+rvA0/n1Ig=
=0E7P
-----END PGP SIGNATURE-----

--cB4CxVy2Gp1bd2mA--

