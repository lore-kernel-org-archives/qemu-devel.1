Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7AFC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A0B20874
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S2DyZzwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A0B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCwJt-0007Qp-Hz
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHb-0005TZ-N1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHZ-0003Hr-ND
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43437 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCwHY-0003HF-Bs; Tue, 24 Sep 2019 21:39:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dLMn0DRtz9sP6; Wed, 25 Sep 2019 11:39:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569375589;
 bh=x+sRBFHqnXCgc/6a41Wnij1JrbedpYLHWEbLTX3XELQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S2DyZzwxFnAHyD63qPzePw0b0AZrJQgF68d75lF6sf5+ZWOzRVV3Z36XG9lC2Ogut
 a0iFmcfkwS4xC5YdHf6C7ni7E/ZVYVsp5QKB90fyqB9wflUWg34jCVjZeClSYZXTdi
 m5t6tHCjyrBlO6BG5DuaXxa9ntraiO20t/VytYPY=
Date: Wed, 25 Sep 2019 11:39:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH v14 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20190925013914.GI17405@umbus>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879437195.18368.2222030761877686909.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Content-Disposition: inline
In-Reply-To: <156879437195.18368.2222030761877686909.stgit@aravinda>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:42:51PM +0530, Aravinda Prasad wrote:
> This patch includes migration support for machine check
> handling. Especially this patch blocks VM migration
> requests until the machine check error handling is
> complete as these errors are specific to the source
> hardware and is irrelevant on the target hardware.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_events.c  |   16 +++++++++++-
>  hw/ppc/spapr_rtas.c    |    2 ++
>  include/hw/ppc/spapr.h |    2 ++
>  4 files changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6992b32..a72a4b1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -46,6 +46,7 @@
>  #include "migration/qemu-file-types.h"
>  #include "migration/global_state.h"
>  #include "migration/register.h"
> +#include "migration/blocker.h"
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
>  #include "cpu-models.h"
> @@ -1829,6 +1830,8 @@ static void spapr_machine_reset(MachineState *machi=
ne)
> =20
>      /* Signal all vCPUs waiting on this condition */
>      qemu_cond_broadcast(&spapr->mc_delivery_cond);
> +
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -2119,6 +2122,60 @@ static const VMStateDescription vmstate_spapr_dtb =
=3D {
>      },
>  };
> =20
> +static bool spapr_fwnmi_needed(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    return spapr->guest_machine_check_addr !=3D -1;
> +}
> +
> +static int spapr_fwnmi_post_load(void *opaque, int version_id)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON) {
> +
> +        if (kvmppc_has_cap_ppc_fwnmi()) {
> +            return 0;
> +        }
> +
> +        return kvmppc_set_fwnmi();
> +    }

I don't see that you need this.  The spapr caps need to be set the
same on source and destination (the caps infrastructure handles that),
so setup should already be handled by the caps .apply hooks.

> +
> +    return 0;
> +}
> +
> +static int spapr_fwnmi_pre_save(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    /*
> +     * With -only-migratable QEMU option, we cannot block migration.
> +     * Hence check if machine check handling is in progress and print
> +     * a warning message.
> +     */
> +    if (spapr->mc_status !=3D -1) {
> +        warn_report("A machine check is being handled during migration. =
The"
> +                "handler may run and log hardware error on the destinati=
on");
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_machine_check =3D {
> +    .name =3D "spapr_machine_check",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_fwnmi_needed,
> +    .post_load =3D spapr_fwnmi_post_load,
> +    .pre_save =3D spapr_fwnmi_pre_save,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> +        VMSTATE_INT32(mc_status, SpaprMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

So, I know I suggested earlier that you postpone the migration support
to a later patch in the series.  But at least for the actual vmstate
stuff, I think that was due to considerations that have since gone.  I
don't see any reason you can't put this in as soon as you add the
machine_check_addr and mc_status fields.

The migration blocker stuff might have to come in a later patch, but
that's ok.

> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -2152,6 +2209,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> @@ -2948,6 +3006,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>              exit(1);
>          }
> =20
> +        /* Create the error string for live migration blocker */
> +        error_setg(&spapr->fwnmi_migration_blocker,
> +            "A machine check is being handled during migration. The hand=
ler"
> +            "may run and log hardware error on the destination");
> +
>          /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>          spapr_fwnmi_register();
>      }
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ecc3d68..71caa03 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -43,6 +43,7 @@
>  #include "qemu/main-loop.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
> +#include "migration/blocker.h"
> =20
>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>  #define   RTAS_LOG_VERSION_6                    0x06000000
> @@ -844,6 +845,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(cpu);
> +    int ret;
> +    Error *local_err =3D NULL;
> =20
>      if (spapr->guest_machine_check_addr =3D=3D -1) {
>          /*
> @@ -873,8 +876,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
>              return;
>          }
>      }
> -    spapr->mc_status =3D cpu->vcpu_id;
> =20
> +    ret =3D migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_e=
rr);
> +    if (ret =3D=3D -EBUSY) {
> +        /*
> +         * We don't want to abort so we let the migration to continue.
> +         * In a rare case, the machine check handler will run on the tar=
get.
> +         * Though this is not preferable, it is better than aborting
> +         * the migration or killing the VM.
> +         */
> +        warn_report_err(local_err);
> +    }
> +
> +    spapr->mc_status =3D cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index b569538..c652ec3 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -50,6 +50,7 @@
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
> +#include "migration/blocker.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -446,6 +447,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>       */
>      spapr->mc_status =3D -1;
>      qemu_cond_signal(&spapr->mc_delivery_cond);
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index dada821..ea7625e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -217,6 +217,8 @@ struct SpaprMachineState {
> =20
>      unsigned gpu_numa_id;
>      SpaprTpmProxy *tpm_proxy;
> +
> +    Error *fwnmi_migration_blocker;
>  };
> =20
>  #define H_SUCCESS         0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2KxUIACgkQbDjKyiDZ
s5IskA//c66sLaUsq0f6+EF9Z8XZddw6XMU5uLiD4cYFvgaKV3Z8svAaz9zH0SRG
P0n5cqIqo/szlT3W9cQmeGrxV/3XcYAjpThAtx1S5zaPJ47ZcG/56fbR9caGPGTA
DSAvlZm+WsMdL5MfWyy5JA1bo29wvFdYHhsj2SEtdM1P+ctidBtt6xcXpd2HFSCk
NJJAMlNHBX6vmr49a7Vvg1ZfI4vDYNMj1mH+PYdCnKZI8GtqvTujfR+T/HpPjHZ6
5ahbqRn3DFcUqxjrYCBOeuL1GVFiZR91fUlhNQMqjXGS6PHR1nVNXQJ2NM8lE3/9
1xI96lvCiesi2tm8tqVJqS851Czdukke1HIZAo8pDWjD8e+kMwYEHRAoyRcUSAoT
NQv54pfypay/1JYeMHnfr4mvpUmTku3+xwokMm7efU+7VUbuJwRiHsvWK5zV1WtH
Vhe/wB32UxFm9Zs3cKGj425TQ5mGBhlqvFVQzwZAtPqMvAsP7CUEOXEFFAb5w67B
I+OYSJRLSwIuwiS8wuNusuCaBrjZzMsY08g94Rq5KpHweUI5F2BYQ3SCrQEhP6Ug
/Nuvd0xKeyKzx5Xb8quirclxwgcDZxaDcwninXxAqPhVVBMq5LHtlb7yb5WFBgkF
XIQhPZOBAsFOjRbjitk4Hs1i6zH3CodKWvtsy8DnewMVXO/F694=
=907/
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--

