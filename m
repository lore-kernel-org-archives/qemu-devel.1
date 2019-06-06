Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C86C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306342070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YMfOIFcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306342070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYinJ-0004Hj-F0
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:10:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijz-0002Ch-OY
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijm-0006Vo-Lo
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:06:51 -0400
Received: from ozlabs.org ([203.11.71.1]:57259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYijd-0006FO-Bl; Wed, 05 Jun 2019 23:06:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K9Xs3LWbz9sNf; Thu,  6 Jun 2019 13:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559790381;
	bh=aYL8cwlPtguN31mOiGvSQMgBZrb+ZZ9x7aLdUUfko5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMfOIFcXOLrdBuK9iT2BjOibZ158IXfpvM6XvXlNkxV73POv8PdtnzlB24GQgiTHn
	F1YK+1IFlbaKP7lLCi4/sfXmKIRF/welaXyM2pxeCOJRF3JPAHIDIYiJjmhSgUISZ1
	w/ucHYtJH4MWpsiIdEk2lHU0UjvQtoqUPSr3whBU=
Date: Thu, 6 Jun 2019 13:06:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190606030614.GK10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910845769.13149.8097972239187020170.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <155910845769.13149.8097972239187020170.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v9 6/6] migration: Include migration
 support for machine check handling
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 11:10:57AM +0530, Aravinda Prasad wrote:
> This patch includes migration support for machine check
> handling. Especially this patch blocks VM migration
> requests until the machine check error handling is
> complete as (i) these errors are specific to the source
> hardware and is irrelevant on the target hardware,
> (ii) these errors cause data corruption and should
> be handled before migration.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |   20 ++++++++++++++++++++
>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
>  hw/ppc/spapr_rtas.c    |    4 ++++
>  include/hw/ppc/spapr.h |    2 ++
>  4 files changed, 43 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e8a77636..31c4850 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2104,6 +2104,25 @@ static const VMStateDescription vmstate_spapr_dtb =
=3D {
>      },
>  };
> =20
> +static bool spapr_fwnmi_needed(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    return (spapr->guest_machine_check_addr =3D=3D -1) ? 0 : 1;

Since we're introducing a PAPR capability to enable this, it would
actually be better to check that here, rather than the runtime state.
That leads to less cases and easier to understand semantics for the
migration stream.

> +}
> +
> +static const VMStateDescription vmstate_spapr_machine_check =3D {
> +    .name =3D "spapr_machine_check",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_fwnmi_needed,
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
> @@ -2137,6 +2156,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 573c0b7..35e21e4 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -41,6 +41,7 @@
>  #include "qemu/bcd.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
> +#include "migration/blocker.h"
> =20
>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>  #define   RTAS_LOG_VERSION_6                    0x06000000
> @@ -855,6 +856,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu,=
 bool recovered)
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    int ret;
> +    Error *local_err =3D NULL;
> +
> +    error_setg(&spapr->fwnmi_migration_blocker,
> +            "Live migration not supported during machine check handling"=
);
> +    ret =3D migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_e=
rr);
> +    if (ret < 0) {
> +        /*
> +         * We don't want to abort and let the migration to continue. In a
> +         * rare case, the machine check handler will run on the target
> +         * hardware. Though this is not preferable, it is better than ab=
orting
> +         * the migration or killing the VM.
> +         */
> +        error_free(spapr->fwnmi_migration_blocker);

You should set fwnmi_migration_blocker to NULL here as well.

As mentioned on an earlier iteration, the migration blocker is the
same every time.  Couldn't you just create it once and free at final
teardown, rather than recreating it for every NMI?

> +        warn_report_err(local_err);
> +    }
> =20
>      while (spapr->mc_status !=3D -1) {
>          /*
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 91a7ab9..c849223 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -50,6 +50,7 @@
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
>  #include "kvm_ppc.h"
> +#include "migration/blocker.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -404,6 +405,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          spapr->mc_status =3D -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +        error_free(spapr->fwnmi_migration_blocker);
> +        spapr->fwnmi_migration_blocker =3D NULL;
>      }
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bd75d4b..6c0cfd8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -214,6 +214,8 @@ struct SpaprMachineState {
>      SpaprCapabilities def, eff, mig;
> =20
>      unsigned gpu_numa_id;
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

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4gyYACgkQbDjKyiDZ
s5I0Mw//Wqd18dXjkYea0FsNpE3rBEEMkaGMrWhmj1YVc3sFfxIjT6J1RdE48aI6
x1Q9rEkdMWbi5kjDwuqvv+/wgmsP92gCzpimcV+ZFEU4TdFeWdMOTNMnYQ2khPHc
DH2dPh8p6dTjO0hUN3v27cxSR9IsuAkHZN+n+nARx9Fu7mW3lzgsCGGo5F3mOYex
kcvcH2bHzs+mRWDrDNVjkYBgcrB5Hf94ZkgJDeBr3ukud6tivdMxFPf92UV7mWWj
hNox8nP5287ju6MPGTCVdYPANENWdGHTuJQFt/u7H70NnyQmow4v+8u1R5g+hBQk
BiyZcNJmpIFelrF7wSu6cy7YZ0Y3tu+t4eLgBLz+omjlecmYkUFhSBhgoPKyVfPD
WSzkFz0yunGotqfzFaMY+i92Qa/aAWVA1ukmvgJEdcj0FR9NKJM/xUHrLQkevkzE
A5bErXE2uAoWbByPnD9inoCIZ9cJ9zJ96gpuGYYI03cADJpae/OPl3j7GMD0TziT
0JL+FLcBxa0SmaXjUbZve3VElSBgASR2e7wiO7oZFLpKIMKKjicrMBqfF61WdptN
u18kEgkchFBxnWQuhhxg1v4jENuBAsrO/MjQF8eCg6ws08bT6F4nt2YLxwJyYP0K
h9DbGCBKp0kbE/t8NZ7QOEQuNruJjuw68Ht5b6Pp2LLI5ykRSzs=
=MGr/
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--

