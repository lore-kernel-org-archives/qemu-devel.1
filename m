Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9938C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 01:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C062245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 01:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CdEuGNc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C062245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id2XA-0002ZI-Rv
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 20:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1id2Ot-0001af-Vb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 20:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1id2Or-0005XN-V4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 20:27:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45987 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1id2Op-0005Ho-Mz; Thu, 05 Dec 2019 20:27:16 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47TZgt3gqLz9sPV; Fri,  6 Dec 2019 12:27:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575595626;
 bh=YGxXbW4EIkdd5SuGsp29tnaxW0BF2xNBQMWlN4os/DE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CdEuGNc/s0eHtCnmsOzoOpFEogZhOLlZDl7/GfalL+EuJXqcLPQpFbobjy/b1hNko
 O9J5+idWvYBTe1Y7XjDMQ7VRvfKj4yhxWDXYp3JPbzTXHD8RAVg3IFnB1B2r/y2+di
 n67YJo2vy+sVjWJ8gd/x3iQUIoxf3bjQSntF9gaA=
Date: Fri, 6 Dec 2019 12:22:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v17 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20191206012217.GJ5031@umbus.fritz.box>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-7-ganeshgr@linux.ibm.com>
 <20191119024514.GM5582@umbus.fritz.box>
 <5348d151-bc01-b704-7587-77e7856f90e5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Content-Disposition: inline
In-Reply-To: <5348d151-bc01-b704-7587-77e7856f90e5@linux.ibm.com>
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


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 10:39:29AM +0530, Ganesh wrote:
>=20
> On 11/19/19 8:15 AM, David Gibson wrote:
> > On Thu, Oct 24, 2019 at 01:13:06PM +0530, Ganesh Goudar wrote:
> > > From: Aravinda Prasad <arawinda.p@gmail.com>
> > >=20
> > > This patch includes migration support for machine check
> > > handling. Especially this patch blocks VM migration
> > > requests until the machine check error handling is
> > > complete as these errors are specific to the source
> > > hardware and is irrelevant on the target hardware.
> > >=20
> > > [Do not set FWNMI cap in post_load, now its done in .apply hook]
> > > Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> > > Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> > > ---
> > >   hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++=
++
> > >   hw/ppc/spapr_events.c  | 16 +++++++++++++++-
> > >   hw/ppc/spapr_rtas.c    |  2 ++
> > >   include/hw/ppc/spapr.h |  2 ++
> > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 346ec5ba6c..e0d0f95ec0 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -46,6 +46,7 @@
> > >   #include "migration/qemu-file-types.h"
> > >   #include "migration/global_state.h"
> > >   #include "migration/register.h"
> > > +#include "migration/blocker.h"
> > >   #include "mmu-hash64.h"
> > >   #include "mmu-book3s-v3.h"
> > >   #include "cpu-models.h"
> > > @@ -1751,6 +1752,8 @@ static void spapr_machine_reset(MachineState *m=
achine)
> > >       /* Signal all vCPUs waiting on this condition */
> > >       qemu_cond_broadcast(&spapr->mc_delivery_cond);
> > > +
> > > +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> > >   }
> > >   static void spapr_create_nvram(SpaprMachineState *spapr)
> > > @@ -2041,6 +2044,43 @@ static const VMStateDescription vmstate_spapr_=
dtb =3D {
> > >       },
> > >   };
> > > +static bool spapr_fwnmi_needed(void *opaque)
> > > +{
> > > +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > > +
> > > +    return spapr->guest_machine_check_addr !=3D -1;
> > > +}
> > > +
> > > +static int spapr_fwnmi_pre_save(void *opaque)
> > > +{
> > > +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > > +
> > > +    /*
> > > +     * With -only-migratable QEMU option, we cannot block migration.
> > > +     * Hence check if machine check handling is in progress and print
> > > +     * a warning message.
> > > +     */
> > IIUC the logic below this could also occur in the case where the fwnmi
> > event occurs after a migration has started, but before it completes,
> > not just with -only-migratable.  Is that correct?
> Yes

Ok, please update the comment accordingly.

> >=20
> > > +    if (spapr->mc_status !=3D -1) {
> > > +        warn_report("A machine check is being handled during migrati=
on. The"
> > > +                "handler may run and log hardware error on the desti=
nation");
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_spapr_machine_check =3D {
> > > +    .name =3D "spapr_machine_check",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .needed =3D spapr_fwnmi_needed,
> > > +    .pre_save =3D spapr_fwnmi_pre_save,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> > > +        VMSTATE_INT32(mc_status, SpaprMachineState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > >   static const VMStateDescription vmstate_spapr =3D {
> > >       .name =3D "spapr",
> > >       .version_id =3D 3,
> > > @@ -2075,6 +2115,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >           &vmstate_spapr_cap_large_decr,
> > >           &vmstate_spapr_cap_ccf_assist,
> > >           &vmstate_spapr_cap_fwnmi,
> > > +        &vmstate_spapr_machine_check,
> > >           NULL
> > >       }
> > >   };
> > > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > > index db44e09154..30d9371c88 100644
> > > --- a/hw/ppc/spapr_events.c
> > > +++ b/hw/ppc/spapr_events.c
> > > @@ -43,6 +43,7 @@
> > >   #include "qemu/main-loop.h"
> > >   #include "hw/ppc/spapr_ovec.h"
> > >   #include <libfdt.h>
> > > +#include "migration/blocker.h"
> > >   #define RTAS_LOG_VERSION_MASK                   0xff000000
> > >   #define   RTAS_LOG_VERSION_6                    0x06000000
> > > @@ -842,6 +843,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool re=
covered)
> > >   {
> > >       SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >       CPUState *cs =3D CPU(cpu);
> > > +    int ret;
> > > +    Error *local_err =3D NULL;
> > >       if (spapr->guest_machine_check_addr =3D=3D -1) {
> > >           /*
> > > @@ -871,8 +874,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool r=
ecovered)
> > >               return;
> > >           }
> > >       }
> > > -    spapr->mc_status =3D cpu->vcpu_id;
> > > +    ret =3D migrate_add_blocker(spapr->fwnmi_migration_blocker, &loc=
al_err);
> > > +    if (ret =3D=3D -EBUSY) {
> > > +        /*
> > > +         * We don't want to abort so we let the migration to continu=
e.
> > > +         * In a rare case, the machine check handler will run on the=
 target.
> > > +         * Though this is not preferable, it is better than aborting
> > > +         * the migration or killing the VM.
> > > +         */
> > > +        warn_report_err(local_err);
> > I suspect the error message in local_err won't be particularly
> > meaningful on its own.  Perhaps you need to add a prefix to clarify
> > that the problem is you've received a fwnmi after migration has
> > commenced?
> ok
> >=20
> > > +    }
> > > +
> > > +    spapr->mc_status =3D cpu->vcpu_id;
> > >       spapr_mce_dispatch_elog(cpu, recovered);
> > >   }
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 0328b1f341..c78d96ee7e 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -50,6 +50,7 @@
> > >   #include "hw/ppc/fdt.h"
> > >   #include "target/ppc/mmu-hash64.h"
> > >   #include "target/ppc/mmu-book3s-v3.h"
> > > +#include "migration/blocker.h"
> > >   static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineSta=
te *spapr,
> > >                                      uint32_t token, uint32_t nargs,
> > > @@ -446,6 +447,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cp=
u,
> > >        */
> > >       spapr->mc_status =3D -1;
> > >       qemu_cond_signal(&spapr->mc_delivery_cond);
> > > +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> > Oh... damn.  I suggested using a static fwnmi_migration_blocker
> > instance, but I just realized there's a problem with it.
> >=20
> > If we do receive multiple fwnmi events on different cpus at roughly
> > the same time, this will break: I think we'll try to add the same
> > migration blocker instance multiple times, which won't be good.  Even
> > if that doesn't do anything *too* bad, then we'll unblock the
> > migration on the first interlock, rather than waiting for all pending
> > fwnmi events to complete.
> Ok, not sure how to handle this, ill look into it.

Well, you can do it by reverting to the old approach of dynamically
creating the Error object before adding it as blocker (and freeing it
when the blocker is removed).  It's a bit ugly, but it will suffice.

> >=20
> > >       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > >   }
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 86f0fc8fdd..290abd6328 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -215,6 +215,8 @@ struct SpaprMachineState {
> > >       unsigned gpu_numa_id;
> > >       SpaprTpmProxy *tpm_proxy;
> > > +
> > > +    Error *fwnmi_migration_blocker;
> > >   };
> > >   #define H_SUCCESS         0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3prUYACgkQbDjKyiDZ
s5JN/A//QQIhh+pBhkDX792lQP5+/0T+fFecHJGQ8y7sdvFjMBT5hf+OoKel79Iu
1JtjTGBrMVpspjNpO6nJSNHM1QwZw/igdRuTLQOvRZtwVWdX1I5Q9OJ9JH91UPSh
bKyLxH2dhNgR4CJE6xCKp/qzHvCXgGOAPqgVN1ZRvNCwpVv4KVeHPfNA9a1D9nth
KvlVvmnRTzU6qOGy7SW7UjaG0aId6AH8aTRhzXL3WowsdoN8WValqfOAwv76mHqh
Jr6u5Vq8Ux5To3bO05MZpOUMNYGD7fkefVfJIGFckgzFNytZ/F+bMjuXyKce0oa8
2ubaNDAz7gm6PvRztYRDLmMfDf8tM9NN8/GxjJIKbsHDlJxv37onruSrrr9Vc8nF
ERXTAQsJhKadH6qQl8OCkUAaMbmXiToM5eJj1yZyora05uqehsuo0p3yvgX/bvvz
xcvSZYbrWMaphbH23wvRXPELeNQp1X9Q5hXxGamKsACk1FMfoh8nh3nuek+IgGVG
cHjlgFZ1wZ3Jg45tc1dUPnmqXC9Ne1eP0g+JQhF80fhaVcHzrxn9W1eIAEbbGRso
hoJhD3uI3wF+J1dIEWo/8vhLGdRtJqmlYzoCixObO+oBDEYi1+KxgvDFtn124RoY
gMTOCQagmNGwFqhFUAFjyBz90Vgorgf1tEpxUorSnesSXl0CVNI=
=XbX7
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--

