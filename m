Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E9C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC34205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S6N2Fp7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC34205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDzGU-0003kk-0W
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDa-0007dT-Jd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDZ-0005eA-2X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDzDY-0004xm-9I; Mon, 16 Mar 2020 19:32:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hCJJ2WWlz9sPR; Tue, 17 Mar 2020 10:32:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584401536;
 bh=IDSI4xzL+lXC/mEF1E4aAmSm1bBfVS8TPh3uAqHMVbY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S6N2Fp7dl3RIrAa+Py803R7gOVcbvfjvq/2zHUI2PNXCXLK24UyfZjtY9unGuMo7a
 CHLrC4YQYgESoKW6GX4o417YWKR4fjVba4WIO0dmgpUI6zvOcam6sxhSQ7+sMPU7PB
 9/5gXWxr+tjsne/iKuH+HGayImV4lUo6A2vk/hEg=
Date: Tue, 17 Mar 2020 10:28:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
Message-ID: <20200316232858.GF20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-7-npiggin@gmail.com>
 <85cfff63-88e3-b5a5-75e3-aa29ac13ff60@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <85cfff63-88e3-b5a5-75e3-aa29ac13ff60@kaod.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 07:15:14PM +0100, C=E9dric Le Goater wrote:
> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> > Provide for an alternate delivery location, -1 defaults to the
> > architected address.
>=20
> I don't know what is the best approach, to override the vector addr
> computed by powerpc_excp() or use a machine class handler with=20
> cpu->vhyp.

Again, in the interests of getting this in for the soft freeze, I've
applied this now.  We can clean it up later.

>=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/spapr.c           | 2 +-
> >  target/ppc/cpu.h         | 2 +-
> >  target/ppc/excp_helper.c | 5 ++++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5f93c49706..25221d843c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3400,7 +3400,7 @@ static void spapr_machine_finalizefn(Object *obj)
> >  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
> >  {
> >      cpu_synchronize_state(cs);
> > -    ppc_cpu_do_system_reset(cs);
> > +    ppc_cpu_do_system_reset(cs, -1);
> >  }
> > =20
> >  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 3953680534..f8c7d6f19c 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunct=
ion f, CPUState *cs,
> >  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> >                                 int cpuid, void *opaque);
> >  #ifndef CONFIG_USER_ONLY
> > -void ppc_cpu_do_system_reset(CPUState *cs);
> > +void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
> >  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
> >  extern const VMStateDescription vmstate_ppc_cpu;
> >  #endif
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 7f2b5899d3..08bc885ca6 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -961,12 +961,15 @@ static void ppc_hw_interrupt(CPUPPCState *env)
> >      }
> >  }
> > =20
> > -void ppc_cpu_do_system_reset(CPUState *cs)
> > +void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
> >  {
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      CPUPPCState *env =3D &cpu->env;
> > =20
> >      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
> > +    if (vector !=3D -1) {
> > +        env->nip =3D vector;
> > +    }
> >  }
> > =20
> >  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wC7kACgkQbDjKyiDZ
s5ICpxAAnc1rRI/6Q330XmhUq2pNrAeukoVEWZV7wDFqEKATesM7WftGWesK0lcy
sPrbAU0A5JHkIB1PnoBZY/CY0OZVvqzhXG5BL8ybZcuepsocZ7aEzqbWhjhhvowu
wf3/KIIUv8Sy+z8JZi5wtz1ZyEnl2+f/POCRVfCBXv0Di18TvRzwb1XD0HUsz78+
zzPEcl5VtmmkyvJtlZnwoNcaa9QjsVoaLB78AvzTNQNM3e6nWXe7M4Js2Ca4b3Ek
vkbqCMnbYG59n9UoLb7Hx0nCXb0Vz830nogrzK/0SxJ3kb3w+vjT5hJUH0ET0+bB
WIwCiNJhHJfBp/L3re6gNZBB53UnZDphGLplJSZP5InbpzcXqB0VtcRFVMbH95Bc
bntZ0HhSAqOYV9f4E77jyqbtUdAmAAKMDUEErtxrooH4uei4VbGimSc0/qmA9HUB
TWQHe9zTg6+g2mrzMWbIPXEHdPYVbuRfeRRBCDeh76BCmwT2WPTtV67tVVk/9Ffk
i+AfpDLR1EE/HTKytcwKfVg7XfrJ6t+KSy2VgWTotuCdqWpsHulWPdp/5cqAe2Dw
FlD8fSQeWTOBvzPhkeo270HXl5nbqKgEBktWdWO7iwdq7PLX/IOGgpMkMj2nc7hu
tMj/1xnNdaZB7BORo0Bgpigk3SMAl+qYdpkrCgawYk96XZBFbYc=
=H0r5
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

