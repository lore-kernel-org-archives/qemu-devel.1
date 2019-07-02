Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B645C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE3320881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R5UZVV9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE3320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAJd-0000Bo-CU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAA8-0008Cc-NV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAA4-0005JE-Gr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:00 -0400
Received: from ozlabs.org ([203.11.71.1]:39239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiAA0-0005GI-LU; Tue, 02 Jul 2019 00:12:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45d9nX5w48z9sLt; Tue,  2 Jul 2019 14:12:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562040768;
 bh=qHG1cneKbVlVmk07NBWhHRd943M4whdgWepql8wqWhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R5UZVV9SHnc7uK/iE+YttaIvrX2lnBu7E/LA5IvTid1rNu0/OW7sq8yTfZ52p0Ml2
 vX8eVqRA3geA77YpWhD8zMyxseZl2d3etRl10zJazUE7i5ODHP2CVd1Fzk2cjgRLeN
 ifrHddCZ38sj2Z9v6wmEWk0KXt8RxYhj4sTZwnjM=
Date: Tue, 2 Jul 2019 14:11:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190702041129.GJ6779@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <156033129836.26635.3348706829139659071.stgit@aravinda>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 02:51:38PM +0530, Aravinda Prasad wrote:
> This patch adds support in QEMU to handle "ibm,nmi-register"
> and "ibm,nmi-interlock" RTAS calls and sets the default
> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> type 4.0.
>=20
> The machine check notification address is saved when the
> OS issues "ibm,nmi-register" RTAS call.
>=20
> This patch also handles the case when multiple processors
> experience machine check at or about the same time by
> handling "ibm,nmi-interlock" call. In such cases, as per
> PAPR, subsequent processors serialize waiting for the first
> processor to issue the "ibm,nmi-interlock" call. The second
> processor that also received a machine check error waits
> till the first processor is done reading the error log.
> The first processor issues "ibm,nmi-interlock" call
> when the error log is consumed.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    6 ++++-
>  hw/ppc/spapr_rtas.c    |   63 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    5 +++-
>  3 files changed, 72 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3d6d139..213d493 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *machin=
e)
>          /* Create the error string for live migration blocker */
>          error_setg(&spapr->fwnmi_migration_blocker,
>                  "Live migration not supported during machine check handl=
ing");
> +
> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> +        spapr_fwnmi_register();
>      }
> =20
>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;

Turning this on by default really isn't ok if it stops you running TCG
guests at all.

>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;

We're now well past 4.0, and in fact we're about to go into soft
freeze for 4.1, so we're going to miss that too.  So 4.1 and earlier
will need to retain the old default.

>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index a015a80..e010cb2 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -49,6 +49,7 @@
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
> +#include "migration/blocker.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
> =20
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  SpaprMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    int ret;
> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> +
> +    if (!rtas_addr) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    ret =3D kvmppc_fwnmi_enable(cpu);
> +    if (ret =3D=3D 1) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);

I don't understand this case separate from the others.  We've already
set the cap, so fwnmi support should be checked and available.

> +        return;
> +    } else if (ret < 0) {
> +        error_report("Couldn't enable KVM FWNMI capability");
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +
> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        /*
> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status =3D -1;
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);

Hrm.  We add the blocker at the mce request point.  First, that's in
another patch, which isn't great.  Second, does that mean we could add
multiple times if we get an MCE on multiple CPUs?  Will that work and
correctly match adds and removes properly?

> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -496,6 +551,14 @@ hwaddr spapr_get_rtas_addr(void)
>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>  }
> =20
> +void spapr_fwnmi_register(void)
> +{
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
> +}
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0dedf0a..7ae53e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -637,8 +637,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> @@ -894,4 +896,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_fwnmi_register(void);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0a2XEACgkQbDjKyiDZ
s5JWpxAA4V9hMBdoTkjtZK9M56OrywP++L0dqZwJkYbX1+DsC9oUsrNLfO+w6oH5
rvO9VJlJ7G/vyC1LaAwo2idhhVGI9mzzRS3GyAZhS4KayaQ5DITKtrb+wYj8XaCv
njRnVYdScuGoQnjuVsXWcU7n69LFHvvYIFhgWmNiwUl/V1R2IuMfjX0Dt28zdLHb
+mX/p9PlTEUvTOA/X2xZuwKkAN3BvsoZkprO6kT3n7VHJ9K/PdIVuy4BsG2WWffe
xD2Czei+i68SmY7Wdb+kM929o2l3HGCJiNzFvdWIs8l5W6Nuw0cpk5Sl3e4X1UxW
OAN+GY8NI9IaMJEHfcxNktPvfGgfN/n03TzTn7DVdOwN78OoTL8C7k578cZmS6Wd
zaV0v9pJnrDgryuOF4TY52w7kegnJnmwO99EqmLg0FJhQJ3NnyomxhP4jaDaNeoa
kUzsqeTKuBF8HDsyPQDatJYzL1vuAvx6AWD06/zvJS/F8yn5DHeeQWDrx4thSQPw
HKGG4gjo9l05lUVc1zML4FtWyPJa1YDOtgdRnpL9+XrmswqdWvyN5SJNPtefpb9n
0wrFpblNGhPcalkTo/hiEJ9S5+c6YIsxkaiagA+VdvV5HvSWRjwGaMhicvy5FqMi
f2oHYalTh33Gard+BjPw2YA2HSzp+T0TMC7IsqcJ/xq8YpLkVag=
=DVLQ
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

