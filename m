Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBEBCA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAA720684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hV/7iGds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAA720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTYr-0005vy-2m
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTK-0006QL-2o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTI-0002ro-AX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:33 -0400
Received: from ozlabs.org ([203.11.71.1]:56529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTH-0002nA-43; Wed, 23 Oct 2019 23:07:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS2Psdz9sPL; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=8pjwWQUWsQW3llwRkyHkaqkI0sayQjKPH1tiQ+fn4N8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hV/7iGdsnoNiyR6l4ktlXCqg4zrnzgtG8o5bSZ4EnWBONVTgTCaohFjUAfn+kFvRd
 y57WlToACYTuQKWCRD5YgHOa3cs1ltSxD+9RdqkK7Y4/ObZaudgcxdb7acoVSbO3/1
 nmtKHooNPTNVuR8wSSjYSFmgVJP+elWYi9/ofCbI=
Date: Thu, 24 Oct 2019 13:33:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 3/7] ppc/pnv: Introduce a PnvCore reset handler
Message-ID: <20191024023322.GM6439@umbus.fritz.box>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-4-clg@kaod.org>
 <21ea9a84-0a26-0ff7-c2a3-458c2c9016a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <21ea9a84-0a26-0ff7-c2a3-458c2c9016a1@redhat.com>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 01:18:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi C=E9dric,
>=20
> On 10/22/19 6:38 PM, C=E9dric Le Goater wrote:
> > in which individual CPUs are reset. It will ease the introduction of
> > future change reseting the interrupt presenter from the CPU reset
> > handler.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/pnv_core.c | 19 +++++++++++++++----
> >   1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index b1a7489e7abf..9f981a4940e6 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -40,9 +40,8 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
> >       return cpu_type;
> >   }
> > -static void pnv_cpu_reset(void *opaque)
> > +static void pnv_core_cpu_reset(PowerPCCPU *cpu)
> >   {
> > -    PowerPCCPU *cpu =3D opaque;
> >       CPUState *cs =3D CPU(cpu);
> >       CPUPPCState *env =3D &cpu->env;
> > @@ -192,8 +191,17 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvC=
hip *chip, Error **errp)
> >       /* Set time-base frequency to 512 MHz */
> >       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> > +}
> > +
> > +static void pnv_core_reset(void *dev)
>=20
> Here the opaque pointer is a 'PnvCore *pc'.
> If you don't want to call it 'opaque', maybe 'pc' is better.
>=20
> > +{
> > +    CPUCore *cc =3D CPU_CORE(dev);
> > +    PnvCore *pc =3D PNV_CORE(dev);
>=20
> This type conversion is not necessary.
>=20
> What about:
>=20
>    static void pnv_core_reset(void *opaque)
>    {
>        PnvCore *pc =3D opaque;
>        CPUCore *cc =3D CPU_CORE(pc);

Those suggestions look good to me, but they can be done as a follow up.

>=20
> > +    int i;
> > -    qemu_register_reset(pnv_cpu_reset, cpu);
> > +    for (i =3D 0; i < cc->nr_threads; i++) {
> > +        pnv_core_cpu_reset(pc->threads[i]);
> > +    }
> >   }
> >   static void pnv_core_realize(DeviceState *dev, Error **errp)
> > @@ -244,6 +252,8 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >       snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
> >       pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_op=
s,
> >                             pc, name, PNV_XSCOM_EX_SIZE);
> > +
> > +    qemu_register_reset(pnv_core_reset, pc);
> >       return;
> >   err:
> > @@ -259,7 +269,6 @@ static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> >   {
> >       PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > -    qemu_unregister_reset(pnv_cpu_reset, cpu);
> >       object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
> >       cpu_remove_sync(CPU(cpu));
> >       cpu->machine_data =3D NULL;
> > @@ -273,6 +282,8 @@ static void pnv_core_unrealize(DeviceState *dev, Er=
ror **errp)
> >       CPUCore *cc =3D CPU_CORE(dev);
> >       int i;
> > +    qemu_unregister_reset(pnv_core_reset, pc);
> > +
> >       for (i =3D 0; i < cc->nr_threads; i++) {
> >           pnv_unrealize_vcpu(pc->threads[i]);
> >       }
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xDXAACgkQbDjKyiDZ
s5J4Lw//ZC+EGUia4i9D861gIRQ0lW5QIq885ie/md0dA3t+wrGXJTAJE0Awz/qq
DfJCktmFlzC0i5oSI+NZhhaolhrVNs4+CPRS3YjDYmEAokfTPY5EaUE+z72sUK/B
SbOzk36z18XutHot67nETydfA1OjK0ZRivVtrLLGdH5RdAC9WzFt2PE2TJ9v873p
7rICouthznWJN31tIQCUmfKZJCR3TYPYukHBcdqpVU1cypDhjXdaBjqNMP48vMGS
Oh2sa1k6AMbqXufTmpNx4kJoP9QjI2oghw26ps4Io0FYNtP6A9TE2AK59NV7Cxg0
mno8UuuDeWytDcDlgMLscXIstm3xqr06Y90RigkoS+tXFFSRQfJhn5x85S67aLNd
cJFMYDzcqNm2Gu7Ol3BHNlr3Mzkb5ruTTEnNwLtpOByQaD4W3XQwv1S/QUq4SU+z
Q0WxXM1Jj6mriGyr2s/FssvUJNgJ0m0xoBkLbbs939yb1rPObBA89PfEMf2snRAC
X3bXgI/8zazI+s0jQhGGcGa/DY1cyfLt+MiJKl0ubeUIgY0DeQ+9IVLEqFFomKPf
GjgvgzTKT2/Up+4YK+XeM059K9OhJkYT9S6a2JjxQfFnblzgznVmLC+FmenBsDfJ
ilvjV3v5rYW9cL19WPmCruwRH9gMalAUtZqbiN/zrwJEOYUBUNs=
=pefC
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--

