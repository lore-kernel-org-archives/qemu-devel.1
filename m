Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB469C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2FE223AC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UHBVCqFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2FE223AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtYq-0004PM-4s
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 21:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtWm-0002y4-1B
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtWj-0004E6-G9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:46:03 -0500
Received: from ozlabs.org ([203.11.71.1]:36945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWtWi-0004D5-LZ; Mon, 18 Nov 2019 21:46:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H9Dg53RZz9sPc; Tue, 19 Nov 2019 13:45:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574131555;
 bh=R7oyII1nFWsjg/K5ZAOmiC29M4tDYE28eE2xnFjv2UE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHBVCqFw0A4ShhjvyZqHbMLztAmOnmVKYCTuuQlePRXWyWKidwGi1tOgaqNLxrmsN
 dm+jUcjedXjb+2OBgnmp2KVS6/C2ir33qCeGjtGeT8dTPwyXrdQ60VtTMk7V2PxtZ3
 hIdIvkPFYNUpgi22vPx3XoipMc0C6XsRoPcIFLVk=
Date: Tue, 19 Nov 2019 13:45:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v17 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20191119024514.GM5582@umbus.fritz.box>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-7-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WkHPBKJ2pKcVUM5H"
Content-Disposition: inline
In-Reply-To: <20191024074307.22821-7-ganeshgr@linux.ibm.com>
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WkHPBKJ2pKcVUM5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:13:06PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
> This patch includes migration support for machine check
> handling. Especially this patch blocks VM migration
> requests until the machine check error handling is
> complete as these errors are specific to the source
> hardware and is irrelevant on the target hardware.
>=20
> [Do not set FWNMI cap in post_load, now its done in .apply hook]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> ---
>  hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  | 16 +++++++++++++++-
>  hw/ppc/spapr_rtas.c    |  2 ++
>  include/hw/ppc/spapr.h |  2 ++
>  4 files changed, 60 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 346ec5ba6c..e0d0f95ec0 100644
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
> @@ -1751,6 +1752,8 @@ static void spapr_machine_reset(MachineState *machi=
ne)
> =20
>      /* Signal all vCPUs waiting on this condition */
>      qemu_cond_broadcast(&spapr->mc_delivery_cond);
> +
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -2041,6 +2044,43 @@ static const VMStateDescription vmstate_spapr_dtb =
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
> +     * With -only-migratable QEMU option, we cannot block migration.
> +     * Hence check if machine check handling is in progress and print
> +     * a warning message.
> +     */

IIUC the logic below this could also occur in the case where the fwnmi
event occurs after a migration has started, but before it completes,
not just with -only-migratable.  Is that correct?

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
> @@ -2075,6 +2115,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
>          &vmstate_spapr_cap_fwnmi,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index db44e09154..30d9371c88 100644
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
> @@ -842,6 +843,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(cpu);
> +    int ret;
> +    Error *local_err =3D NULL;
> =20
>      if (spapr->guest_machine_check_addr =3D=3D -1) {
>          /*
> @@ -871,8 +874,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
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

I suspect the error message in local_err won't be particularly
meaningful on its own.  Perhaps you need to add a prefix to clarify
that the problem is you've received a fwnmi after migration has
commenced?

> +    }
> +
> +    spapr->mc_status =3D cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0328b1f341..c78d96ee7e 100644
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

Oh... damn.  I suggested using a static fwnmi_migration_blocker
instance, but I just realized there's a problem with it.

If we do receive multiple fwnmi events on different cpus at roughly
the same time, this will break: I think we'll try to add the same
migration blocker instance multiple times, which won't be good.  Even
if that doesn't do anything *too* bad, then we'll unblock the
migration on the first interlock, rather than waiting for all pending
fwnmi events to complete.

>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 86f0fc8fdd..290abd6328 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -215,6 +215,8 @@ struct SpaprMachineState {
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

--WkHPBKJ2pKcVUM5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TVzkACgkQbDjKyiDZ
s5IQ8xAA0lzUL9uYqr7bv0A8CXGe1R3yXglG6X8zrYsl4vlnlFmyss+Mcfn/2W5x
JOO8jq9ZVU3TdFmninOfzn/5bCkvfet4ituCIYXqGG7tNvpTyseWV+UmRJsHGNOk
PzZ3AkmH22rV/r30Gl/T/BsYytJAx9ty3TaeprneT4fqTy/CEo8FeG6ieHOVifQa
ZvlIgjiHBILyXLjm/3kQrB+4HAJFmfDyf40NoIF4GZj6++k3RigHXLP6bNYdU3Tu
n7mCmMlSUwKU6v0vj74S4hrC3hsWPl9eDkJrMbxG3uHmjiI+VEljakYOneowPdXv
LcLWiUgpezZKoZr1qE3feSuhtlZhVFU0vhXx08mJe9G7XQkuWZqabB7BYH52Z20y
ou++eIxkMM/zmM+dFxugSvf7aYGliIE+acovmMYagkxlKFXsXl1yPOKQnUWIPV7W
YuOzlvnA25ck4B3H7sIObg8ygoKmh/0c+Gt7VtfTr/uXSU5GsdmVtDLbTFLrKL3Q
MCd7Vfg29L/wQyLlQE+C1pmc5m3B1ig1oqIxlRwZWYCMQ6yCBmsIHaQH9MAG6Q9c
ivO72YC7UXkV4HmMK+BO0Tp7Rk2j8hOkiX4GwnZZJuiRNIr52HnoZ8XmAFtSI68I
8wIyhf/cgIIN28Zag63l4Hx6F5Jki5eDTbZBVQN7jHuYjBmV1x8=
=61sK
-----END PGP SIGNATURE-----

--WkHPBKJ2pKcVUM5H--

