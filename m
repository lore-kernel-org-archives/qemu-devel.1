Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED57C3276E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E36521D56
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pg3kALMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E36521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inChY-0005ru-ND
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 21:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf3-0002AZ-2o
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf1-000603-BI
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42709 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inCf0-0005ju-8M; Thu, 02 Jan 2020 21:25:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ppfk57Klz9sRQ; Fri,  3 Jan 2020 13:25:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578018350;
 bh=wWNixyTRO1De7wtkQg/zNIz8tYoHgMtPSEMcaUNk5eE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pg3kALMdeqWtWz+xfEJ4Mg5Yh5WW3eIg/DPiygp5+P0gR+DbO8RC4aNxvhTDdr/R7
 oKqKoO4kZC66u38anQtRSIEJnsXu2bAB1AJEgvJYp//otSqtgW0Q40Dwe9bm5zpEG+
 dAa64g9OBiCnKTW+B5mTYYiuYC6lsO31TOiGJUSE=
Date: Fri, 3 Jan 2020 13:25:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20200103022540.GS2098@umbus>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-7-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPT5DIEyVHz5yXBV"
Content-Disposition: inline
In-Reply-To: <20200102075111.25308-7-ganeshgr@linux.ibm.com>
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


--GPT5DIEyVHz5yXBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 01:21:10PM +0530, Ganesh Goudar wrote:
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
>  hw/ppc/spapr_events.c  | 20 +++++++++++++++++++-
>  hw/ppc/spapr_rtas.c    |  4 ++++
>  include/hw/ppc/spapr.h |  1 +
>  4 files changed, 65 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 975d7da734..4acdc30100 100644
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
> @@ -1685,6 +1686,8 @@ static void spapr_machine_reset(MachineState *machi=
ne)
> =20
>      /* Signal all vCPUs waiting on this condition */
>      qemu_cond_broadcast(&spapr->mc_delivery_cond);
> +
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -1967,6 +1970,43 @@ static const VMStateDescription vmstate_spapr_dtb =
=3D {
>      },
>  };
> =20
> +static bool spapr_fwnmi_needed(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> +
> +    return spapr->fwnmi_calls_registered;

I think it would be better to base this directly on the cap, rather
than a variable set later.

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
> +        VMSTATE_BOOL(fwnmi_calls_registered, SpaprMachineState),

This doesn't make sense to migrate - it will always have its final
value by the time the guest is running in a migratable state.

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -2001,6 +2041,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
>          &vmstate_spapr_cap_fwnmi,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 54eaf28a9e..7092687fa0 100644
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
> @@ -872,8 +875,23 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
>              return;
>          }
>      }
> -    spapr->mc_status =3D cpu->vcpu_id;
> =20
> +    error_setg(&spapr->fwnmi_migration_blocker,
> +               "Live migration not supported during machine check handli=
ng");
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
> +        error_free(spapr->fwnmi_migration_blocker);
> +        spapr->fwnmi_migration_blocker =3D NULL;
> +        warn_report("Received a fwnmi while migration was in progress");

Didn't we change from initializing the blocker Error at init time
because there was a case where we could have two migration blockers
registered at once?  If that's so then we need entirely different
instances of the blocker Error.  Just dynamiically allocating them
doesn't help us if there can still only be one at a time.

> +    }
> +
> +    spapr->mc_status =3D cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 54b142f35b..3409f6b896 100644
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
> @@ -448,6 +449,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      spapr->mc_status =3D -1;
>      qemu_cond_signal(&spapr->mc_delivery_cond);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +    error_free(spapr->fwnmi_migration_blocker);
> +    spapr->fwnmi_migration_blocker =3D NULL;
>  }
> =20
>  static struct rtas_call {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a90e677cc3..ac246c8be3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -220,6 +220,7 @@ struct SpaprMachineState {
>      SpaprTpmProxy *tpm_proxy;
> =20
>      bool fwnmi_calls_registered;
> +    Error *fwnmi_migration_blocker;
>  };
> =20
>  #define H_SUCCESS         0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GPT5DIEyVHz5yXBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4OpiQACgkQbDjKyiDZ
s5II2BAAqc6+mehb/98sbiO+iKgcsAnGDrX0pdPm0HRHiH759kYWw7SH6Grr15zw
pIDRXpmwrT8mlyvrk0ZGANdmERcrXOCfG1tDWv2bYlc0lSMv0vkm+JrIAJNdmkbG
SWQ/CGXBn+rKgWh4+32biXgkfDOstPqpFJurHGRNhHgjRO0aIr57frsGe9X3U0PW
uPCTFQq7Q5AcfFgRH0BsvafcrJvhPgO7ha9nWTMrBfZJrgyVMBRzu67DU/ckd8hR
R7lOu+/udCgQaDGL3/Lf52404xrniJJZTzD7rbWlhqJQD6FWoJ1VLHqJHEKoxIfB
z9LF4Ttr3DPro3glkQ+BoQMhsOISxnEcskUj1jHzd0ezpCXZgTj3uYiu8kRl1ZsT
2PgQvSKHz3b+ASNDN2xyKSvrkDheIeBiauq3b+BpDH00A1NeTuuw8Nd5iMMv7kIm
monzcYrbolMLR+no80wi/A387BzflEAATlpWMSMmyxEiiBmn5be3kk6uKVKx0QAY
zizcHski60EXblVGjnYY9xXrfZhQX7ZS0Gx4mf6FtHEmbF0uw5hMQHRSaW+LxMZw
lQf16vku1ZSB1tHTZ9LQPM5wJVHO+51aPDmnafkAGejSLzg8IsguduEgXdPxNpLv
B0YqVNzic7pEUuFndT+yf6NV0P4un3vc7el+LSA9LLMj8gucW00=
=yKjr
-----END PGP SIGNATURE-----

--GPT5DIEyVHz5yXBV--

