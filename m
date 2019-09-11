Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1395FECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1C820872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VkdWBVfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1C820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xT0-0002gQ-02
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7xSE-000290-Au
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7xSC-0001Kj-GL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:54:17 -0400
Received: from ozlabs.org ([203.11.71.1]:34625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7xSA-0001Ix-Vw; Wed, 11 Sep 2019 03:54:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SvLB3s5Tz9sCJ; Wed, 11 Sep 2019 17:54:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568188450;
 bh=WCGYvzndzRbaynsQ+9Sac7dNBrHjDHEvRihKGHoKy1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VkdWBVfBGOhv5PmMvXDmVlbeVS/QxbwPvShapayjCkb7v7I8v90dSuipPgcVf+jLN
 mK/9A3GgkmZhRqsOBLxpsvoYnrcWP9FHwikIqvSy60SMgcqwYzNobN5DmSFkzPsUm9
 NutW6fXSofGLzhbVj2wz/2hgmIbpC5c1pFJdVgpY=
Date: Wed, 11 Sep 2019 17:51:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190911075142.GA13785@umbus.fritz.box>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-8-david@gibson.dropbear.id.au>
 <b727dcb2-3cdd-77f9-b772-3253e52f2133@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <b727dcb2-3cdd-77f9-b772-3253e52f2133@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 7/7] spapr: Perform machine reset in a more
 sensible order
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 05:40:58PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 11/09/2019 14:04, David Gibson wrote:
> > We've made several changes in the past to the machine reset order to fix
> > specific problems.  However, we've ended up with an order that doesn't =
make
> > a lot of logical sense.  This is an attempt to rectify this.
> >=20
> > First we reset global CAS options, since that should depend on nothing
> > else.  Then we reset the CPUs, which shouldn't depend on external devic=
es.
> > Then the irq subsystem, then the bulk of devices (which might rely on
> > irqs).  Finally we set up the entry state ready for boot, which could
> > potentially rely on a bunch of other things.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>=20
> Breaks console on P8 and asserts on rebooting a P9 guest.

Yeah, I jumped the gun on this one - I need to rethink and test more thorou=
ghly.

>=20
>=20
>=20
> > ---
> >  hw/ppc/spapr.c | 47 +++++++++++++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5a919a6cc1..1560a11738 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1724,6 +1724,28 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >      void *fdt;
> >      int rc;
> > =20
> > +    /*
> > +     * If this reset wasn't generated by CAS, we should reset our
> > +     * negotiated options and start from scratch
> > +     */
> > +    if (!spapr->cas_reboot) {
> > +        spapr_ovec_cleanup(spapr->ov5_cas);
> > +        spapr->ov5_cas =3D spapr_ovec_new();
> > +
> > +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > +    }
> > +
> > +    /*
> > +     * There is no CAS under qtest. Simulate one to please the code th=
at
> > +     * depends on spapr->ov5_cas. This is especially needed to test de=
vice
> > +     * unplug, so we do that before resetting the DRCs.
> > +     */
> > +    if (qtest_enabled()) {
> > +        spapr_ovec_cleanup(spapr->ov5_cas);
> > +        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
> > +    }
> > +
> > +    /* Reset the CPUs */
> >      spapr_caps_apply(spapr);
> > =20
> >      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> > @@ -1741,34 +1763,15 @@ static void spapr_machine_reset(MachineState *m=
achine)
> >          spapr_setup_hpt_and_vrma(spapr);
> >      }
> > =20
> > -    qemu_devices_reset();
> > -
> > -    /*
> > -     * If this reset wasn't generated by CAS, we should reset our
> > -     * negotiated options and start from scratch
> > -     */
> > -    if (!spapr->cas_reboot) {
> > -        spapr_ovec_cleanup(spapr->ov5_cas);
> > -        spapr->ov5_cas =3D spapr_ovec_new();
> > -
> > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > -    }
> > -
> > +    /* Reset IRQ subsystem */
> >      /*
> >       * This is fixing some of the default configuration of the XIVE
> >       * devices. To be called after the reset of the machine devices.
> >       */
> >      spapr_irq_reset(spapr, &error_fatal);
> > =20
> > -    /*
> > -     * There is no CAS under qtest. Simulate one to please the code th=
at
> > -     * depends on spapr->ov5_cas. This is especially needed to test de=
vice
> > -     * unplug, so we do that before resetting the DRCs.
> > -     */
> > -    if (qtest_enabled()) {
> > -        spapr_ovec_cleanup(spapr->ov5_cas);
> > -        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
> > -    }
> > +    /* Reset other devices */
> > +    qemu_devices_reset();
> > =20
> >      /* DRC reset may cause a device to be unplugged. This will cause t=
roubles
> >       * if this device is used by another device (eg, a running vhost b=
ackend
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl14p44ACgkQbDjKyiDZ
s5JaSBAA4fFGFfnwRDLvmzKt6BxORnDsvyRb5Ydgt++IXCGSApGPDPw0HBemBaTf
m+DGKkIT7VnKU10ZXN03rMS0zcWVMuBoqQi8gb/VOd+pWFxR4axkPCk94qZYNLKY
d25JZYUrfwMvBO8asv+GVcgOd/C3QPkf8wtIp0d4os8SdqVcbO3PpLWIn5Q3wvJE
k+E+C2405uynu6cb4dmUOR1T3Z3s6Nxt3WHQ4/xXg7VZXXLaFmH1vz/rli7MYvuR
BFOhaUcz7GjOZDnD/vQC47q6Ldj+dsHIzRhb4Xzsj/i0r5tC9TFOpOWtAc0S+45v
O/d2jCG6exYOfDD4US31iKikv14YqE5bTqn/VOXBl8zq+u/92tph6MjtfN1y3r4O
7nl2VbMRmsG3lw4qLDV7loSkmeL6ACCBbASfqarAeKsN70xQP2SnBFBPOWy4Gld3
3i9mfSYEw0u7owvUuKCYExpf3UuFzOUc/fLD0bDwNYj/mjUW5J3Y77yh6ICzHb0d
kJu536wMowAifbYoDNqV/yFtUMF1ZUjcTgSVzW32XVZzykCbRbNUnS3OzoddJqf1
VkcMhI6Bn/GVwj6Lof+Tir+lrKL7hKCqyb6UQy2vVJRM0qV+26F+mqGk6psLQH/0
g3Y3EnxN0DO6K5nVzuwF/L7q7/1OIP+mFMZFEMX8aoL3+YWXkoQ=
=4aMD
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

