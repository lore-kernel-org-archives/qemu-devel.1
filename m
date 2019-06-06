Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC74C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA5E2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KO8Eq2jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA5E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYhzz-0005Y1-72
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 22:19:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy9-0004SV-HV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy7-00074M-Ux
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44163 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYhy6-00071V-Tv; Wed, 05 Jun 2019 22:17:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K8SN20hSz9sNT; Thu,  6 Jun 2019 12:17:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559787444;
	bh=D/usM0bwWSkkGpV1RqayGcup8jvn4jIAApALRgv3u3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KO8Eq2jBt+oXTwW3oj7auTgyUfQg/9w/+odjdbLVZ5r4uOC2PDNBQ9OjLA4kPhYa7
	oKvmIg/AdKoFo8n+pww7le8W33Qxz49NkwN3zMtprcecWGuYlz5DYr+C/9ZSrYAz+6
	mvTmWOawvWjsdW5ZdwYJKuCd1dvaPZdJvXUqpvW0=
Date: Thu, 6 Jun 2019 11:35:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190606013536.GE10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910841478.13149.2830700794862210739.stgit@aravinda>
	<20190603121243.687d8d75@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190603131723.261eba99@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20190603131723.261eba99@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 1/6] ppc: spapr: Handle "ibm,
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


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2019 at 01:17:23PM +0200, Greg Kurz wrote:
> On Mon, 3 Jun 2019 12:12:43 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 29 May 2019 11:10:14 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >=20
> > > This patch adds support in QEMU to handle "ibm,nmi-register"
> > > and "ibm,nmi-interlock" RTAS calls.
> > >=20
> > > The machine check notification address is saved when the
> > > OS issues "ibm,nmi-register" RTAS call.
> > >=20
> > > This patch also handles the case when multiple processors
> > > experience machine check at or about the same time by
> > > handling "ibm,nmi-interlock" call. In such cases, as per
> > > PAPR, subsequent processors serialize waiting for the first
> > > processor to issue the "ibm,nmi-interlock" call. The second
> > > processor that also received a machine check error waits
> > > till the first processor is done reading the error log.
> > > The first processor issues "ibm,nmi-interlock" call
> > > when the error log is consumed. This patch implements the
> > > releasing part of the error-log while subsequent patch
> > > (which builds error log) handles the locking part.
> > >=20
> > > Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > --- =20
> >=20
> > The code looks okay but it still seems wrong to advertise the RTAS
> > calls to the guest that early in the series. The linux kernel in
> > the guest will assume FWNMI is functional, which isn't true until
> > patch 6 (yes, migration is part of the feature, it should be
> > supported upfront, not fixed afterwards).
> >=20
> > It doesn't help much to introduce the RTAS calls early and to
> > modify them in the other patches. I'd rather see the rest of
> > the code first and a final patch that introduces the fully
> > functional RTAS calls and calls spapr_rtas_register().
> >=20
>=20
> Thinking again, you should introduce the "fwnmi-mce" spapr capability in
> its own patch first, default to "off" and and have the last patch in the
> series to switch the default to "on" for newer machine types only.
>=20
> This patch should then only register the RTAS calls if "fwnmi-mcr" is set
> to "on".

Yes, I think this is a good approach.

> This should address the fact that we don't want to expose a partially
> implemented FWNMI feature to the guest, and we don't want to support
> FWNMI at all with older machine types for the sake of compatibility.
>=20
> > >  hw/ppc/spapr.c         |    7 +++++
> > >  hw/ppc/spapr_rtas.c    |   65 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  include/hw/ppc/spapr.h |    9 ++++++-
> > >  3 files changed, 80 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e2b33e5..fae28a9 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1808,6 +1808,11 @@ static void spapr_machine_reset(void)
> > >      first_ppc_cpu->env.gpr[5] =3D 0;
> > > =20
> > >      spapr->cas_reboot =3D false;
> > > +
> > > +    spapr->guest_machine_check_addr =3D -1;
> > > +
> > > +    /* Signal all vCPUs waiting on this condition */
> > > +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
> > >  }
> > > =20
> > >  static void spapr_create_nvram(SpaprMachineState *spapr)
> > > @@ -3072,6 +3077,8 @@ static void spapr_machine_init(MachineState *ma=
chine)
> > > =20
> > >          kvmppc_spapr_enable_inkernel_multitce();
> > >      }
> > > +
> > > +    qemu_cond_init(&spapr->mc_delivery_cond);
> > >  }
> > > =20
> > >  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 5bc1a93..e7509cf 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -352,6 +352,38 @@ static void rtas_get_power_level(PowerPCCPU *cpu=
, SpaprMachineState *spapr,
> > >      rtas_st(rets, 1, 100);
> > >  }
> > > =20
> > > +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> > > +                                  SpaprMachineState *spapr,
> > > +                                  uint32_t token, uint32_t nargs,
> > > +                                  target_ulong args,
> > > +                                  uint32_t nret, target_ulong rets)
> > > +{
> > > +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> > > +
> > > +    if (!rtas_addr) {
> > > +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > > +        return;
> > > +    }
> > > +
> > > +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> > > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > > +}
> > > +
> > > +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> > > +                                   SpaprMachineState *spapr,
> > > +                                   uint32_t token, uint32_t nargs,
> > > +                                   target_ulong args,
> > > +                                   uint32_t nret, target_ulong rets)
> > > +{
> > > +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> > > +        /* NMI register not called */
> > > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > > +    } else {
> > > +        qemu_cond_signal(&spapr->mc_delivery_cond);
> > > +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > > +    }
> > > +}
> > > +
> > >  static struct rtas_call {
> > >      const char *name;
> > >      spapr_rtas_fn fn;
> > > @@ -470,6 +502,35 @@ void spapr_load_rtas(SpaprMachineState *spapr, v=
oid *fdt, hwaddr addr)
> > >      }
> > >  }
> > > =20
> > > +hwaddr spapr_get_rtas_addr(void)
> > > +{
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +    int rtas_node;
> > > +    const struct fdt_property *rtas_addr_prop;
> > > +    void *fdt =3D spapr->fdt_blob;
> > > +    uint32_t rtas_addr;
> > > +
> > > +    /* fetch rtas addr from fdt */
> > > +    rtas_node =3D fdt_path_offset(fdt, "/rtas");
> > > +    if (rtas_node =3D=3D 0) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    rtas_addr_prop =3D fdt_get_property(fdt, rtas_node, "linux,rtas-=
base", NULL);
> > > +    if (!rtas_addr_prop) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    /*
> > > +     * We assume that the OS called RTAS instantiate-rtas, but some =
other
> > > +     * OS might call RTAS instantiate-rtas-64 instead. This fine as =
of now
> > > +     * as SLOF only supports 32-bit variant.
> > > +     */
> > > +    rtas_addr =3D fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
> > > +    return (hwaddr)rtas_addr;
> > > +}
> > > +
> > > +
> > >  static void core_rtas_register_types(void)
> > >  {
> > >      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> > > @@ -493,6 +554,10 @@ static void core_rtas_register_types(void)
> > >                          rtas_set_power_level);
> > >      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> > >                          rtas_get_power_level);
> > > +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> > > +                        rtas_ibm_nmi_register);
> > > +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> > > +                        rtas_ibm_nmi_interlock);
> > >  }
> > > =20
> > >  type_init(core_rtas_register_types)
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 4f5becf..9dc5e30 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -188,6 +188,10 @@ struct SpaprMachineState {
> > >       * occurs during the unplug process. */
> > >      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
> > > =20
> > > +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" c=
alls */
> > > +    target_ulong guest_machine_check_addr;
> > > +    QemuCond mc_delivery_cond;
> > > +
> > >      /*< public >*/
> > >      char *kvm_type;
> > >      char *host_model;
> > > @@ -624,8 +628,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, ta=
rget_ulong opcode,
> > >  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0=
x27)
> > >  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0=
x28)
> > >  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0=
x29)
> > > +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0=
x2A)
> > > +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0=
x2B)
> > > =20
> > > -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0=
x2A)
> > > +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0=
x2C)
> > > =20
> > >  /* RTAS ibm,get-system-parameter token values */
> > >  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> > > @@ -876,4 +882,5 @@ void spapr_check_pagesize(SpaprMachineState *spap=
r, hwaddr pagesize,
> > >  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the pla=
tform */
> > > =20
> > >  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> > > +uint64_t spapr_get_rtas_addr(void);
> > >  #endif /* HW_SPAPR_H */
> > >  =20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4becACgkQbDjKyiDZ
s5JYZRAAtssD2zgd16pCrneaW+4NuWi5o7C0is/7KDVD0OWAiHXu9Jj9wZ8i0FtE
XIaLKm66O7oC/14/YFvZQoU4Al2OsTDIoyIngn7tp7wXrb5K5GS2fX7vR6Esbbq5
pYtvik4RlkdXYcc420Fh/XD9EIkCG6GZDhCUYHr1QbyViY7FJNA+BElkiUaCS6hE
haYzHL0zfHdXNsu01b/IDbvmq9wUduvub+U7oGHtHljA5tT5lAGTCIeksIHjxsiv
fOwfKWjNRGuM3C2lKAG9+Q64A31ZOBNhBjr0zSvxOSwGdtet/Z7lzMt4IGnuvulV
tmyesCHG3t9qrzrNgx7QPm5Q+zwgBlihyBaySt8E18pS+O+tJp6QG8ARsRAWV3r8
ORqB7iQJj9Ky44utMye70nONO2d8vEr6d5M27MV4BBhro179UXj0xUGjmnQCH6AU
cL9H/prwfDW+rrc1lcIlBwsZ4dZ9+20xRK14t4sVt5bpPk90IIz61Yiy9lRRFip5
DLXYm5F3vJSvcsFM1JRhMMANyDB3b6GkfRce7vl9wrnlAuthgOc05J/vIHjV6gze
/uQXq5ANyv0yYh0vlg5b+ru5QFmmAhNC0Gyl7iXBT/LjM9j26W9UwObHDuLzwspM
5JQEy+JrA6iV8YUul4EahCeaQjsWhUPcKaG0mTd+FxXAIJxzoZE=
=l9Vn
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

