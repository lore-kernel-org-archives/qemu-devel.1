Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4046C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D37F2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OtE1dG0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5fO-0005DX-91
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:34:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dP-00046O-Ms
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dO-0001Z1-8j
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36543 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hP5dM-0001XS-Vc; Fri, 10 May 2019 09:32:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450rjX6ttMz9sD4; Fri, 10 May 2019 23:32:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557495136;
	bh=ZPYdKTxRS7EweEfjJPGa0MFYCiBOyvqhDBPObu1NCC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtE1dG0eHjeR1gY+70JCnWoeftkuFatxoNoT9fIkfl0u/8xijk6wxZw/dj+vrEy4u
	AoHg7wM1ilURxw28+6lJjNupvggBdeH1RoRkoXjJ6mmqq/MwqRxWf8NNxtaI54U/Ab
	xajLlvuDpmvqh6TCXFCh/Xfwvemz4K5VE4DYnCyQ=
Date: Fri, 10 May 2019 19:54:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190510095439.GC5030@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591657807.20338.12115795588476734752.stgit@aravinda>
	<20190510110604.67c0d18d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20190510110604.67c0d18d@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 1/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 11:06:04AM +0200, Greg Kurz wrote:
> On Mon, 22 Apr 2019 12:32:58 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>=20
> > This patch adds support in QEMU to handle "ibm,nmi-register"
> > and "ibm,nmi-interlock" RTAS calls.
> >=20
> > The machine check notification address is saved when the
> > OS issues "ibm,nmi-register" RTAS call.
> >=20
> > This patch also handles the case when multiple processors
> > experience machine check at or about the same time by
> > handling "ibm,nmi-interlock" call. In such cases, as per
> > PAPR, subsequent processors serialize waiting for the first
> > processor to issue the "ibm,nmi-interlock" call. The second
> > processor that also received a machine check error waits
> > till the first processor is done reading the error log.
> > The first processor issues "ibm,nmi-interlock" call
> > when the error log is consumed. This patch implements the
> > releasing part of the error-log while subsequent patch
> > (which builds error log) handles the locking part.
> >=20
> > Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c         |   18 ++++++++++++++
> >  hw/ppc/spapr_rtas.c    |   61 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/spapr.h |    9 ++++++-
> >  3 files changed, 87 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c56939a..6642cb5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1805,6 +1805,11 @@ static void spapr_machine_reset(void)
> >      first_ppc_cpu->env.gpr[5] =3D 0;
> > =20
> >      spapr->cas_reboot =3D false;
> > +
> > +    spapr->guest_machine_check_addr =3D -1;
> > +
> > +    /* Signal all vCPUs waiting on this condition */
> > +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
> >  }
> > =20
> >  static void spapr_create_nvram(SpaprMachineState *spapr)
> > @@ -2095,6 +2100,16 @@ static const VMStateDescription vmstate_spapr_dt=
b =3D {
> >      },
> >  };
> > =20
> > +static const VMStateDescription vmstate_spapr_machine_check =3D {
> > +    .name =3D "spapr_machine_check",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
>=20
> This VMState descriptor is missing a .needed field because we only want
> to migrate the subsection if the guest has called NMI register, ie.
> spapr->guest_machine_check_addr !=3D (target_ulong) -1.
>=20
> > +};
> > +
> >  static const VMStateDescription vmstate_spapr =3D {
> >      .name =3D "spapr",
> >      .version_id =3D 3,
> > @@ -2127,6 +2142,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >          &vmstate_spapr_dtb,
> >          &vmstate_spapr_cap_large_decr,
> >          &vmstate_spapr_cap_ccf_assist,
> > +        &vmstate_spapr_machine_check,
> >          NULL
> >      }
> >  };
> > @@ -3068,6 +3084,8 @@ static void spapr_machine_init(MachineState *mach=
ine)
> > =20
> >          kvmppc_spapr_enable_inkernel_multitce();
> >      }
> > +
> > +    qemu_cond_init(&spapr->mc_delivery_cond);
> >  }
> > =20
> >  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index ee24212..c2f3991 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -348,6 +348,39 @@ static void rtas_get_power_level(PowerPCCPU *cpu, =
SpaprMachineState *spapr,
> >      rtas_st(rets, 1, 100);
> >  }
> > =20
> > +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> > +                                  SpaprMachineState *spapr,
> > +                                  uint32_t token, uint32_t nargs,
> > +                                  target_ulong args,
> > +                                  uint32_t nret, target_ulong rets)
> > +{
> > +    uint64_t rtas_addr =3D spapr_get_rtas_addr();
> > +
> > +    if (!rtas_addr) {
> > +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > +        return;
> > +    }
> > +
> > +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > +}
> > +
> > +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> > +                                   SpaprMachineState *spapr,
> > +                                   uint32_t token, uint32_t nargs,
> > +                                   target_ulong args,
> > +                                   uint32_t nret, target_ulong rets)
> > +{
> > +    if (!spapr->guest_machine_check_addr) {
>=20
> Hmm... the default value is -1. It looks like the check should rather be:
>=20
>     if (spapr->guest_machine_check_addr =3D=3D (target_ulong) -1) {
>=20
>=20
> > +        /* NMI register not called */
> > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +    } else {
> > +        qemu_cond_signal(&spapr->mc_delivery_cond);
> > +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > +    }
> > +}
> > +
> > +
> >  static struct rtas_call {
> >      const char *name;
> >      spapr_rtas_fn fn;
> > @@ -466,6 +499,30 @@ void spapr_load_rtas(SpaprMachineState *spapr, voi=
d *fdt, hwaddr addr)
> >      }
> >  }
> > =20
> > +uint64_t spapr_get_rtas_addr(void)
>=20
> Shouldn't this be hwaddr instead of uint64_t ?
>=20
> > +{
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > +    int rtas_node;
> > +    const struct fdt_property *rtas_addr_prop;
> > +    void *fdt =3D spapr->fdt_blob;
> > +    uint32_t rtas_addr;
> > +
> > +    /* fetch rtas addr from fdt */
> > +    rtas_node =3D fdt_path_offset(fdt, "/rtas");
> > +    if (rtas_node =3D=3D 0) {
> > +        return 0;
> > +    }
> > +
> > +    rtas_addr_prop =3D fdt_get_property(fdt, rtas_node, "linux,rtas-ba=
se", NULL);
> > +    if (!rtas_addr_prop) {
>=20
> Just for curiosity: this is ok for linux, but what about other OSes (eg. =
AIX) ?
>=20
> > +        return 0;
> > +    }
> > +
> > +    rtas_addr =3D fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
>=20
> Also this assumes the OS called RTAS instantiate-rtas, but some other
> OS might have called RTAS instantiate-rtas-64 instead. I guess it is
> ok for now because SLOF only provides the 32-bit variant, but a
> comment would certainly help IMHO.

I have a feeling kvm-unit-tests may not call instantiate-rtas at all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVSl8ACgkQbDjKyiDZ
s5L36RAAjJImQwdn6OOLbTmAM+OeM/nRfi1kQVXujAVfTrJico58HNa5EBmKlrWU
CemIY7ZwCIpKALXso9Onyz/cIGl1B69v+lRuCc0/Xg8xUAPyA3z8vmUNQfyLFHLS
zgS2jFFw4Mf8ApWsKNm0fiw9Opi8chMzkkjs1e/nDPCjbDSZHJFsw1AKqOk1xaIR
R/JQzIcJOBcMmRJ0739zks/dg5RjcWuZvhxKAd5EPKM2DIS91+ZYoZJgqrnOilKC
DRwneYvqX6Z2WV0lKxQ1fmsqoiXM0IR0jjPwORXRelHVG/MHbLUmFG9zMPprmOnA
A5rZtTeL/N2+bSSu/pIXFE+lLetFTTbWTijZahq7UZPTH7Fv3uOkNMD5KgLOzY1v
BMLGhUILRiZY8tNM585/g26qLdKeXQ2C069XmvA362FHZoq9BI6E+BNuxNztgF0w
ynyhjHTygFE/Is7AlhJa2cc6aazBA8N5L0cJHMyavbTMXTBTjQaaMav+dHM9t6+i
fzXT5pA7V5yfOzrHmU/WrlxhhZFBiG2dsZUR2m71tX3woyMYBqNdfcIHr529LjOr
TUNwHhoxJ5yF0c/L3uYG2TVi+gXHocPYzN6qGMsuZCdZfdZh7lpUvAooNtfQ/nCG
DM8RlGxavxoy069NoOHxJo9SS12goIWt+GHrgKuDInNMSKooOIk=
=wR86
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

