Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256BCC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 06:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD0C2065D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 06:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CbUFgqNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD0C2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7C9X-0006y9-2g
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 02:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7C8g-0006Ns-5v; Sun, 16 Aug 2020 02:27:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46389 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7C8d-0007Q5-Bv; Sun, 16 Aug 2020 02:27:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BTnK021nxz9sTT; Sun, 16 Aug 2020 16:27:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597559236;
 bh=GnCTrJDIDXx4Ri4O8qEMoUbXNLOwVz7GZ54H3POHSJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CbUFgqNOUVdwIkGZQ+DqqX+XRrrtPppb5gjckApknzP/VbN9FEGjnzKmclwy5dc94
 CPOND4xM5ypmXlC8l5NLkinDYfBB2grXp9c1yfRw/lKksGXKIyEj4xmLtrmwlaCHTD
 y6GYCkirzEFinqUQPCBnf/9L8+Zh08sZSNQsNyB4=
Date: Sun, 16 Aug 2020 14:30:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: Allocate IPIs from the vCPU contexts
Message-ID: <20200816043000.GH12805@yekko.fritz.box>
References: <20200814150358.1682513-1-clg@kaod.org>
 <42e8bb9f-c052-5abb-9ffe-0700bfe3904d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline
In-Reply-To: <42e8bb9f-c052-5abb-9ffe-0700bfe3904d@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 02:27:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:08:13PM +0200, C=E9dric Le Goater wrote:
>=20
> This works as expected with a 128 vCPUs guest with pinned vcpus. The
> first 64 IPIs are allocated on the first chip and the remaining 64
> on the second chip.
>=20
> Still, this is more an RFC. We have time before the end of the merge
> window.

It looks reasonable to me.  AFAICT it makes things better than they
were, and even if we can improve it further, that won't break
migration or other interfaces we need to preserve.

>=20
> Thanks,
>=20
> C. =20
>=20
>=20
> On 8/14/20 5:03 PM, C=E9dric Le Goater wrote:
> > When QEMU switches to the XIVE interrupt mode, it performs a
> > kvmppc_xive_source_reset() which creates all the guest interrupts at
> > the level of the KVM device. These interrupts are backed by real HW
> > interrupts from the IPI interrupt pool of the XIVE controller.
> >=20
> > Currently, this is done from the QEMU main thread, which results in
> > allocating all interrupts from the chip on which QEMU is running. IPIs
> > are not distributed across the system and the load is not well
> > balanced across the interrupt controllers.
> >=20
> > Change the vCPU IPI allocation to run from the vCPU context in order
> > to allocate the associated XIVE IPI interrupt on the chip on which the
> > vCPU is running. This gives a chance to a better distribution of the
> > IPIs when the guest has a lot of vCPUs. When the vCPUs are pinned, it
> > makes the IPI local to the chip of the vCPU which reduces rerouting
> > between interrupt controllers and gives better performance.
> >=20
> > This is only possible for running vCPUs. The IPIs of hot plugable
> > vCPUs will still be allocated in the context of the QEMU main thread.
> >=20
> > Device interrupts are treated the same. To improve placement, we would
> > need some information on the chip owning the virtual source or HW
> > source in case of passthrough. This requires changes in PAPR.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/intc/spapr_xive_kvm.c | 50 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >=20
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index c6958f2da218..553fd7fd8f56 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -223,6 +223,47 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uint=
32_t lisn, Error **errp)
> >                        NULL, true, errp);
> >  }
> > =20
> > +/*
> > + * Allocate the IPIs from the vCPU context. This will allocate the
> > + * XIVE IPI interrupt on the chip on which the vCPU is running. This
> > + * gives a better distribution of IPIs when the guest has a lot of
> > + * vCPUs. When the vCPU are pinned, the IPIs are local which reduces
> > + * rerouting between interrupt controllers and gives better
> > + * performance.
> > + */
> > +typedef struct {
> > +    SpaprXive *xive;
> > +    int ipi;
> > +    Error *err;
> > +    int rc;
> > +} XiveInitIPI;
> > +
> > +static void kvmppc_xive_reset_ipi_on_cpu(CPUState *cs, run_on_cpu_data=
 arg)
> > +{
> > +    XiveInitIPI *s =3D arg.host_ptr;
> > +    uint64_t state =3D 0;
> > +
> > +    s->rc =3D kvm_device_access(s->xive->fd, KVM_DEV_XIVE_GRP_SOURCE, =
s->ipi,
> > +                              &state, true, &s->err);
> > +}
> > +
> > +static int kvmppc_xive_reset_ipi(SpaprXive *xive, int ipi, Error **err=
p)
> > +{
> > +    PowerPCCPU *cpu =3D spapr_find_cpu(ipi);
> > +    XiveInitIPI s =3D {
> > +        .xive =3D xive,
> > +        .ipi  =3D ipi,
> > +        .err  =3D NULL,
> > +        .rc   =3D 0,
> > +    };
> > +
> > +    run_on_cpu(CPU(cpu), kvmppc_xive_reset_ipi_on_cpu, RUN_ON_CPU_HOST=
_PTR(&s));
> > +    if (s.err) {
> > +        error_propagate(errp, s.err);
> > +    }
> > +    return s.rc;
> > +}
> > +
> >  /*
> >   * At reset, the interrupt sources are simply created and MASKED. We
> >   * only need to inform the KVM XIVE device about their type: LSI or
> > @@ -230,11 +271,20 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uin=
t32_t lisn, Error **errp)
> >   */
> >  int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **=
errp)
> >  {
> > +    MachineState *machine =3D MACHINE(qdev_get_machine());
> >      SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
> >      uint64_t state =3D 0;
> > =20
> >      assert(xive->fd !=3D -1);
> > =20
> > +    /*
> > +     * IPIs are special. Allocate the IPIs from the vCPU context for
> > +     * those running. Hotplugged CPUs will the QEMU context.
> > +     */
> > +    if (srcno < machine->smp.cpus) {
> > +        return kvmppc_xive_reset_ipi(xive, srcno, errp);
> > +    }
> > +
> >      if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >          state |=3D KVM_XIVE_LEVEL_SENSITIVE;
> >          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl84tkgACgkQbDjKyiDZ
s5JPPxAAyEEqNtAIiwni87CTMuycjyMAuYOcvpxMXKk3SLYLXQEmJDL1eq8nXGlU
q5MQEEycU8nO134Xupe3VYtW76nUk89jUXF08Cvvk4fqvIZAVXnlevR0Ek7p5iJ9
zki7DShbBrjNtJBVGpIJYSjGfAcfGpOEuxZLsXO6rGxtjJMjEgucQzSjsr1DDODy
0sjH30dwwInM8x16TeNnY++NiBaPxFkHCXNwytjV3DFXPqCLRYLPboi47xfUn8l8
eyhlb8t73pVggV6Xvati0c6EgTHwFIAsJ3zsJYeD3eBHo301x7ZTUHtsOgQtfY2F
dKuJPiZjWvYcwAbt17S1ldBjvCy4pUjSpJZ2UEzFJrAM7cjE4cSVlJt6L048kKtD
EPZLz6B+LmkjuzEvXEA3v3Qh7oywbEATvwIYXy+j3nxqYBZcM9Jwa759oO3TVyhU
nj1EF000K26hH6HnQS9VcguC7Gg/Y6htLLkebxUQ1yWcSq5IM52sYb5Lty/biXWI
ek2rxP+WxqQuOlajrYXAtfz9yP6yVpVsfrV7uoax1dT9Tg5xqLLK1rkzCcS6EUeL
U+2ImI0NSBtZgZTUJeNKDp3ut8G0FsfbYVpASvXSrvQzxt2zZ8pZ+WGLkVyORC6d
Z3nih0Urg6maXi8sAz4Jy1A2ZcbJiyLPrI8ghIlKLnu5IXJYj+g=
=d504
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--

