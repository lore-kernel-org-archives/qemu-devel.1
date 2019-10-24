Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71743CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CFC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mWJxL1Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CFC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTZ9-0006Sj-K8
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTO-0006c1-3t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTM-0002wX-8x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:38 -0400
Received: from ozlabs.org ([203.11.71.1]:49299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTL-0002tE-Rf; Wed, 23 Oct 2019 23:07:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxT1qkYz9sR3; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886445;
 bh=3R3HeDqGaZPwzunyW2itnsrghvhlEnmP4G/Fguo9lUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mWJxL1GmeIJLdI8OuEc4dXtMla1Qzr9/QjhZE1XSs3yoFM/+iBJlK7bwEoPHH97e3
 uQTb/MgNwLKVRlN81IRwjGBfZDODSEYKmcZ2yZ+ZU+0VAspzY9zB8rrXmpiwzMuS98
 VbDGLgCzkGtGShSE/E4nH3mzazbKAMUKfJZyyFTs=
Date: Thu, 24 Oct 2019 14:05:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 6/6] xive: Don't use CPU_FOREACH() to perform CAM line
 matching
Message-ID: <20191024030536.GW6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184234731.3053790.18369348907304339634.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JaUdphvQ2+4F/M7k"
Content-Disposition: inline
In-Reply-To: <157184234731.3053790.18369348907304339634.stgit@bahia.lan>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JaUdphvQ2+4F/M7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 04:52:27PM +0200, Greg Kurz wrote:
> Now that the TCTX objects are children of the XIVE router, stop
> using CPU_FOREACH() when looking for a matching VCPU target.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xive.c |  100 +++++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 62 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 40ce43152456..ec5e7d0ee39a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1403,55 +1403,79 @@ typedef struct XiveTCTXMatch {
>      uint8_t ring;
>  } XiveTCTXMatch;
> =20
> -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> -                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                                 bool cam_ignore, uint8_t priority,
> -                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
> +typedef struct XivePresenterMatch {
> +    uint8_t format;
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool cam_ignore;
> +    uint8_t priority;
> +    uint32_t logic_serv;
> +    XiveTCTXMatch *match;
> +    int count;
> +} XivePresenterMatch;
> +
> +static int do_xive_presenter_match(Object *child, void *opaque)
>  {
> -    CPUState *cs;
> +    XiveTCTX *tctx =3D XIVE_TCTX(child);
> +    XivePresenterMatch *xpm =3D opaque;
> +    int ring;
> =20
>      /*
>       * TODO (PowerNV): handle chip_id overwrite of block field for
>       * hardwired CAM compares
>       */
> =20
> -    CPU_FOREACH(cs) {
> -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> -        int ring;
> +    /*
> +     * HW checks that the CPU is enabled in the Physical Thread
> +     * Enable Register (PTER).
> +     */
> =20
> -        /*
> -         * Skip partially initialized vCPUs. This can happen when
> -         * vCPUs are hotplugged.
> -         */
> -        if (!tctx) {
> -            continue;
> +    /*
> +     * Check the thread context CAM lines and record matches. We
> +     * will handle CPU exception delivery later
> +     */
> +    ring =3D xive_presenter_tctx_match(tctx, xpm->format, xpm->nvt_blk,
> +                                     xpm->nvt_idx, xpm->cam_ignore,
> +                                     xpm->logic_serv);
> +
> +    /*
> +     * Save the context and follow on to catch duplicates, that we
> +     * don't support yet.
> +     */
> +    if (ring !=3D -1) {
> +        if (xpm->match->tctx) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thread=
 "
> +                          "context NVT %x/%x\n", xpm->nvt_blk, xpm->nvt_=
idx);
> +            return -1;
>          }
> =20
> -        /*
> -         * HW checks that the CPU is enabled in the Physical Thread
> -         * Enable Register (PTER).
> -         */
> +        xpm->match->ring =3D ring;
> +        xpm->match->tctx =3D tctx;
> +        xpm->count++;
> +    }
> =20
> -        /*
> -         * Check the thread context CAM lines and record matches. We
> -         * will handle CPU exception delivery later
> -         */
> -        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
> -                                         cam_ignore, logic_serv);
> -        /*
> -         * Save the context and follow on to catch duplicates, that we
> -         * don't support yet.
> -         */
> -        if (ring !=3D -1) {
> -            if (match->tctx) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
> -                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
> -                return false;
> -            }
> -
> -            match->ring =3D ring;
> -            match->tctx =3D tctx;
> -        }
> +    return 0;
> +}
> +
> +static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> +                                 bool cam_ignore, uint8_t priority,
> +                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
> +{
> +    XivePresenterMatch xpm =3D {
> +        .format     =3D format,
> +        .nvt_blk    =3D nvt_blk,
> +        .nvt_idx    =3D nvt_idx,
> +        .cam_ignore =3D cam_ignore,
> +        .priority   =3D priority,
> +        .logic_serv =3D logic_serv,
> +        .match      =3D match,
> +        .count      =3D 0,
> +    };
> +
> +    if (object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
> +                                  do_xive_presenter_match, &xpm) < 0) {
> +        return false;

Hrm... xive_presenter_match() is potentially a pretty hot path, it's
called on every interrupt delivery - especially since we don't have a
usable KVM irq chip for Boston machines.  I'm concerned that using
something as heavyweight as object_child_foreach() might have a
noticeable performance impact.

>      }
> =20
>      if (!match->tctx) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JaUdphvQ2+4F/M7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xFQAACgkQbDjKyiDZ
s5Lc7w//a1+tmKZ+DusI2GCQYk+0gOD+z9QvOQFGpusYzmAC6FEiTBAkoHEWP7lg
CJXF4FVxnmOVM2nUzQyUi2RJfWqKU85nE+dmQBfeMcvEksv+Q4i/TZv3DWHmm312
Yey+34uY6sdMMGmjU4Xx1qkNUBVYZq2f6jeTzQVyn75pT+Gv58AXTjuk1TK8uvw9
Sj88ROJOt28ySUYMD9oUFAM/it/x7ANtPt3VwiqlQUmacW2gGdLt7h+vj6midcCJ
tCOG6+8w3aHRW5tuT35cHcPbSXrTZcL8Gx8j9NLXdHd6mgfbi1X6xh9aPFemT2S1
MHo0SUAuYB+FlI7x8mdabWkXGPADIcbKf6rh2Kt+/mxITcqnyxcTMm1JruDbBk6v
lDmADm8Jf1Ff6inaJB05tDevAyJYKqGYjPkkKmDM+sAfQEMrnrpnhLxf0EoUcCvr
0In1i53zT7ifp1CDpMA2kEhL/yeFzf6cgsC6daRi+o1SyXt+ivT0N5LOHb2kWJPN
ulthW/2K1b50kEJtWBB1v/jRxCQVau/MsduUuZkx40YDNFEuBAeV75e7K3UHhczP
ox0d5mvk6ckTOqsxMkiGNGnVbI7/GoMURMD+LC5wq9xnp0BclLWqoNQJyeQdua8/
3FLtw3vUbpf4TPd8toHOBfzTFOK3Tipdkj5K9PtuB4DY9I54T94=
=lgbM
-----END PGP SIGNATURE-----

--JaUdphvQ2+4F/M7k--

