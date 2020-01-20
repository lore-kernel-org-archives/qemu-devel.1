Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164AC33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356E3206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mvrC7Ylt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356E3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itLHP-0001PH-Cf
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFW-0007wk-8T
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFU-00036P-9R
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itLFT-00031N-BH; Sun, 19 Jan 2020 19:49:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481Cj24yB3z9sR0; Mon, 20 Jan 2020 11:48:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579481334;
 bh=o5TlmzqCQFMH3RE24u5TFllgtiwUrQEPEAK2vrQevuw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mvrC7YltZat0pzU/QgEfbrXVhxbjqBUdDVbfXmmE+b/OX/ShlYHAcmwdUy1Cy5VtQ
 u+jaxHfyv1uvfjqrTs3ID2buyuTJ22C3WgsNe7Jxinxa5VwRxit7WSI0DvNHTrP7CS
 J9wHml2Rvz5cAX7rpkxy1Vjheo4yVOvgyWVXycaE=
Date: Mon, 20 Jan 2020 11:48:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v20 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20200120004842.GJ54439@umbus>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-7-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7UxcOAJ07vnNm5/N"
Content-Disposition: inline
In-Reply-To: <20200117093855.19074-7-ganeshgr@linux.ibm.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7UxcOAJ07vnNm5/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 03:08:54PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
> This patch includes migration support for machine check
> handling. Especially this patch blocks VM migration
> requests until the machine check error handling is
> complete as these errors are specific to the source
> hardware and is irrelevant on the target hardware.
>=20
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> [Do not set FWNMI cap in post_load, now its done in .apply hook]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         | 47 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  | 16 +++++++++++++-
>  hw/ppc/spapr_rtas.c    |  2 ++
>  include/hw/ppc/spapr.h |  2 ++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 46bac1a83c..c8bc2fa9f3 100644
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
> @@ -1683,6 +1684,8 @@ static void spapr_machine_reset(MachineState *machi=
ne)
> =20
>      /* Signal all vCPUs waiting on this condition */
>      qemu_cond_broadcast(&spapr->mc_delivery_cond);
> +
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);

Thinking on our discussions about this earlier, there are
circumstances where we could add the blocker message multiple times.
IIUC, this will just remove one of them, but at reset, we need to
remove all of them.

>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -1965,6 +1968,42 @@ static const VMStateDescription vmstate_spapr_dtb =
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
> +static int spapr_fwnmi_pre_save(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    /*
> +     * Check if machine check handling is in progress and print a
> +     * warning message.
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
> +    .pre_save =3D spapr_fwnmi_pre_save,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> +        VMSTATE_INT32(mc_status, SpaprMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1999,6 +2038,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
>          &vmstate_spapr_cap_fwnmi,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> @@ -2814,6 +2854,13 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          spapr_create_lmb_dr_connectors(spapr);
>      }
> =20
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON) {
> +        /* Create the error string for live migration blocker */
> +        error_setg(&spapr->fwnmi_migration_blocker,
> +            "A machine check is being handled during migration. The hand=
ler"
> +            "may run and log hardware error on the destination");
> +    }
> +
>      /* Set up RTAS event infrastructure */
>      spapr_events_init(spapr);
> =20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 54eaf28a9e..884e455f02 100644
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
> @@ -843,6 +844,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(cpu);
> +    int ret;
> +    Error *local_err =3D NULL;
> =20
>      if (spapr->guest_machine_check_addr =3D=3D -1) {
>          /*
> @@ -872,8 +875,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
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
> +        warn_report("Received a fwnmi while migration was in progress");
> +    }
> +
> +    spapr->mc_status =3D cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 3f162d82f5..4ce8e48d2a 100644
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
> @@ -453,6 +454,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      spapr->mc_status =3D -1;
>      qemu_cond_signal(&spapr->mc_delivery_cond);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> =20
>  static struct rtas_call {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f6f82d88aa..a1fba95c82 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -218,6 +218,8 @@ struct SpaprMachineState {
> =20
>      unsigned gpu_numa_id;
>      SpaprTpmProxy *tpm_proxy;
> +
> +    Error *fwnmi_migration_blocker;
>  };
> =20
>  #define H_SUCCESS         0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7UxcOAJ07vnNm5/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4k+OoACgkQbDjKyiDZ
s5LwzQ//VPS3DM60AsTuNCqFsVmNJ8FaMWHU0pgH2672kG2CUMGEowGyE5eQnzx4
yrvzurl17GHMSVJgtGyOw2hHrAnki4FvfBI1BBhAPpcf3SH5WuuscKiLFCKrUcjA
0TeP1h1JGyqneoHxGKvtcvFQeCQzBWqizVCj0ZTwlxC/IvKc4Q3Bj6BT6C2k+tXr
lD/FWtDtuksAtgRLjgXEM1qe1d/q3zh0Ak8cHeLTueSsbUinIe5vVuz8Waim/YPN
9ZL1/UtEjOj9kDoj7rAj+jhmA1SDKUOP+LJWiAlFbhst+ZofB8WL1TPJ2cRzdTf/
ACWCEPC1+kbYFzJkV3MsNEUtYr7yRYltpAi8FAfp8CwwApQGdMMe9bxvkoaffa3E
hDmI+pOipjFyM2Pby+YoeEg5M7K56ovfHV/uVU9+0oM/jGC8l0u2mCCO1dpWTsYv
ib6da2cpshim2hrwvJvzpkesqDZzdzWlcgtezsRmL005Y7jhDhZx341Nx65YMOmx
1aAHIfzx+HifeXBfzAca7Z4561bYC25/qER1z0ICrUtt+XpbBF27Xca72ZAYgcMC
6nMbtEmoQ+0Ak3IeOQQ+uBaRaStGb0jBT4FO22byB/1Qzzb8Hc6GsGcvp6xWPMP4
OZ7waW3E5aDYYQWnzbuMDZIwSt0dPwrXS2n6mcQ+f4itGtOL+jg=
=pryl
-----END PGP SIGNATURE-----

--7UxcOAJ07vnNm5/N--

