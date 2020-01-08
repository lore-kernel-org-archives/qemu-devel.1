Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F20C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716D3206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j3nJRdSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716D3206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip4CH-0002wE-E7
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip4B8-0001tu-Ag
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip4B6-0001Z9-IH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:46:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41671 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip4B6-0001VC-5V; Wed, 08 Jan 2020 00:46:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sytD23Vpz9sPn; Wed,  8 Jan 2020 16:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578462404;
 bh=O14BKnd8gMQgfY2vWM6ko1K8ja1wBVse8/gGCZbr888=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j3nJRdSjJeeBVNHQ1rdqvGuBR/kXZT+SnTRVSiZ+tqGKunjt5UsosMdE4TSdh6/5G
 akyZZPf/ZmGCcR25nMk4sxhe7990ixMpjPKLFjhuEKplfxNd02/ziVS5Lx4AzL2eoj
 VsRnfXpGrc4hatGQVlqmgDbS/kI3bNtn2dEW7tKs=
Date: Wed, 8 Jan 2020 16:45:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 6/7] migration: Include migration support for machine
 check handling
Message-ID: <20200108054543.GA8586@umbus.fritz.box>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-7-ganeshgr@linux.ibm.com>
 <20200103022540.GS2098@umbus>
 <066a1db3-254a-5607-915e-0392fefd72e6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <066a1db3-254a-5607-915e-0392fefd72e6@linux.ibm.com>
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 04:58:14PM +0530, Ganesh wrote:
>=20
> On 1/3/20 7:55 AM, David Gibson wrote:
> > On Thu, Jan 02, 2020 at 01:21:10PM +0530, Ganesh Goudar wrote:
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
> > >   hw/ppc/spapr_events.c  | 20 +++++++++++++++++++-
> > >   hw/ppc/spapr_rtas.c    |  4 ++++
> > >   include/hw/ppc/spapr.h |  1 +
> > >   4 files changed, 65 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 975d7da734..4acdc30100 100644
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
> > > @@ -1685,6 +1686,8 @@ static void spapr_machine_reset(MachineState *m=
achine)
> > >       /* Signal all vCPUs waiting on this condition */
> > >       qemu_cond_broadcast(&spapr->mc_delivery_cond);
> > > +
> > > +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> > >   }
> > >   static void spapr_create_nvram(SpaprMachineState *spapr)
> > > @@ -1967,6 +1970,43 @@ static const VMStateDescription vmstate_spapr_=
dtb =3D {
> > >       },
> > >   };
> > > +static bool spapr_fwnmi_needed(void *opaque)
> > > +{
> > > +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > > +
> > > +    return spapr->fwnmi_calls_registered;
> > I think it would be better to base this directly on the cap, rather
> > than a variable set later.
> Ok, ill revert to older way
> >=20
> > > +}
> > > +
> > > +static int spapr_fwnmi_pre_save(void *opaque)
> > > +{
> > > +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > > +
> > > +    /*
> > > +     * Check if machine check handling is in progress and print a
> > > +     * warning message.
> > > +     */
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
> > > +        VMSTATE_BOOL(fwnmi_calls_registered, SpaprMachineState),
> > This doesn't make sense to migrate - it will always have its final
> > value by the time the guest is running in a migratable state.
> Ok, ill remove it.
> >=20
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > >   static const VMStateDescription vmstate_spapr =3D {
> > >       .name =3D "spapr",
> > >       .version_id =3D 3,
> > > @@ -2001,6 +2041,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >           &vmstate_spapr_cap_large_decr,
> > >           &vmstate_spapr_cap_ccf_assist,
> > >           &vmstate_spapr_cap_fwnmi,
> > > +        &vmstate_spapr_machine_check,
> > >           NULL
> > >       }
> > >   };
> > > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > > index 54eaf28a9e..7092687fa0 100644
> > > --- a/hw/ppc/spapr_events.c
> > > +++ b/hw/ppc/spapr_events.c
> > > @@ -43,6 +43,7 @@
> > >   #include "qemu/main-loop.h"
> > >   #include "hw/ppc/spapr_ovec.h"
> > >   #include <libfdt.h>
> > > +#include "migration/blocker.h"
> > >   #define RTAS_LOG_VERSION_MASK                   0xff000000
> > >   #define   RTAS_LOG_VERSION_6                    0x06000000
> > > @@ -843,6 +844,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool re=
covered)
> > >   {
> > >       SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >       CPUState *cs =3D CPU(cpu);
> > > +    int ret;
> > > +    Error *local_err =3D NULL;
> > >       if (spapr->guest_machine_check_addr =3D=3D -1) {
> > >           /*
> > > @@ -872,8 +875,23 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool r=
ecovered)
> > >               return;
> > >           }
> > >       }
> > > -    spapr->mc_status =3D cpu->vcpu_id;
> > > +    error_setg(&spapr->fwnmi_migration_blocker,
> > > +               "Live migration not supported during machine check ha=
ndling");
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
> > > +        error_free(spapr->fwnmi_migration_blocker);
> > > +        spapr->fwnmi_migration_blocker =3D NULL;
> > > +        warn_report("Received a fwnmi while migration was in progres=
s");
> > Didn't we change from initializing the blocker Error at init time
> > because there was a case where we could have two migration blockers
> > registered at once?  If that's so then we need entirely different
> > instances of the blocker Error.  Just dynamiically allocating them
> > doesn't help us if there can still only be one at a time.
>=20
> I agree, but this how we were doing it before.
>=20
> Are you suggesting to have per cpu blocker Error instance ?

I was, but..

> I think initializing the blocker Error at init time and not freeing it, is
> much simpler
>=20
> and cleaner. And if we receive multiple fwnmi events on different cpus
> almost
>=20
> at the same time, Though we will be prepending same migration blocker
> instance
>=20
> multiple times to the migration_blockers list, IIUC we will not be
> unblocking migration
>=20
> till the migration_blockers list is empty. Please let me know if you are =
ok
> with initializing
>=20
> blocker error at init time.

=2E. I realized I was mistaken.  It wasn't premature unblocking I was
concerned about, but corrupting the actual list structure.  I thought
we were using an intrusive linked list like the QLIST_*() stuff for
this, which can't tolerate double adding an element.  In fact we're
using g_slist_*() which has it's own wrapper nodes around the pointers
given here, so we're ok after all.

So creating the blocker error at init time is the way to go after all.

> > > +    }
> > > +
> > > +    spapr->mc_status =3D cpu->vcpu_id;
> > >       spapr_mce_dispatch_elog(cpu, recovered);
> > >   }
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 54b142f35b..3409f6b896 100644
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
> > > @@ -448,6 +449,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cp=
u,
> > >       spapr->mc_status =3D -1;
> > >       qemu_cond_signal(&spapr->mc_delivery_cond);
> > >       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > > +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> > > +    error_free(spapr->fwnmi_migration_blocker);
> > > +    spapr->fwnmi_migration_blocker =3D NULL;
> > >   }
> > >   static struct rtas_call {
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index a90e677cc3..ac246c8be3 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -220,6 +220,7 @@ struct SpaprMachineState {
> > >       SpaprTpmProxy *tpm_proxy;
> > >       bool fwnmi_calls_registered;
> > > +    Error *fwnmi_migration_blocker;
> > >   };
> > >   #define H_SUCCESS         0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VbIQACgkQbDjKyiDZ
s5JBKQ/+L6tFhVDIIicBN5kPzxRh2jeC+QXgZ1biIC6/to3tE4RXiMoI5NyHOPN4
XeUsFn+MTzYJVb8VBYqYrLt59kdnvKncnYLnncm4RIYsBObJnRIBko4vqxdu03mr
4DlblrP2sOHSgQX5xEb6KNrM80TkXN+h6WWeukEhj/Jt9B91lEYLBvaPlmSdbRDh
LXmx5ep0ADWSPm2ny3J+uwWqr+H75ZveVFGN0IXCjieaURv+SnMVk1elW+9xaVQC
2lfLHbDZJWhCHYDuheKp7xmzrws7tr3JZ/UbdXNyVQhDYQU3pfz/2VhLqmAMwNCI
djPe8nTtCbetyaH55agBxTdpUUN8fLG1b6zsSjQBiNsovPoojMgoAd38uGSEx7tx
AFwPIo6yMo/MMtMxyGz+KtYvdGVVUFwf+fpEXYKx/7SKJIBO8fKDlVJny0NYued0
S0RvRfv1iRZoyi4TlZzeDPj+QSTcGto/VlV+iDoZKchi+ZZxSXLBUsZUg7PGUXRG
qWA+yYYFKDzrf/1cGb36EI0K1rBQSCwzKRkPDFzLiF2RW/U/4d6KyvPsOArTAYtO
xRgyzAKz6c//DU9gkZeU5X1e3iPg5nr7tCYyecTLTGc+/FsrHKb7nXWTOGLm0vsP
ygqwevPV9hX08236K3zID/ZR0gZuzxZzL34F3LCUaqUvGYzH7cU=
=zO2m
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

