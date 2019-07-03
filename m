Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF48C4646D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E45A21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="buL7j7yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E45A21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYXY-0005IB-UV
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYW0-0003YN-Cx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVy-0006Av-IU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:12 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42633 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiYVu-0005vP-MY; Wed, 03 Jul 2019 02:13:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45drPb1dKkz9sN4; Wed,  3 Jul 2019 16:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562134371;
 bh=uM0DRimyDGFngezj59wSIpxrUgLhB08wq3tuTcWpwak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=buL7j7yK9VG9+yf3pdhLJczk8N2XvbZr+TsrfQa3ECTCC7fxuKMKvpCJO5YTubM2B
 hoTwrN2GMbdI5kidR55pkz/Ms12Ly8xB2Q8EC1N0HJEw3cLtTmX0N1szjWMVuY4dae
 SM7wBrHHgxembuEcyaWOzKefgbfZrmmQ2LGSYV5w=
Date: Wed, 3 Jul 2019 13:20:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190703032027.GI9442@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
 <20190702041129.GJ6779@umbus.fritz.box>
 <89a68bbd-801e-876c-3105-877790a3189b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <89a68bbd-801e-876c-3105-877790a3189b@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2019 at 04:10:08PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 02 July 2019 09:41 AM, David Gibson wrote:
> > On Wed, Jun 12, 2019 at 02:51:38PM +0530, Aravinda Prasad wrote:
> >> This patch adds support in QEMU to handle "ibm,nmi-register"
> >> and "ibm,nmi-interlock" RTAS calls and sets the default
> >> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> >> type 4.0.
> >>
> >> The machine check notification address is saved when the
> >> OS issues "ibm,nmi-register" RTAS call.
> >>
> >> This patch also handles the case when multiple processors
> >> experience machine check at or about the same time by
> >> handling "ibm,nmi-interlock" call. In such cases, as per
> >> PAPR, subsequent processors serialize waiting for the first
> >> processor to issue the "ibm,nmi-interlock" call. The second
> >> processor that also received a machine check error waits
> >> till the first processor is done reading the error log.
> >> The first processor issues "ibm,nmi-interlock" call
> >> when the error log is consumed.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |    6 ++++-
> >>  hw/ppc/spapr_rtas.c    |   63 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/spapr.h |    5 +++-
> >>  3 files changed, 72 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 3d6d139..213d493 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >>          /* Create the error string for live migration blocker */
> >>          error_setg(&spapr->fwnmi_migration_blocker,
> >>                  "Live migration not supported during machine check ha=
ndling");
> >> +
> >> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls=
 */
> >> +        spapr_fwnmi_register();
> >>      }
> >> =20
> >>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
> >=20
> > Turning this on by default really isn't ok if it stops you running TCG
> > guests at all.
>=20
> If so this can be "off" by default until TCG is supported.
>=20
> >=20
> >>      spapr_caps_add_properties(smc, &error_abort);
> >>      smc->irq =3D &spapr_irq_dual;
> >>      smc->dr_phb_enabled =3D true;
> >> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(Mach=
ineClass *mc)
> >>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_OFF;
> >> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >=20
> > We're now well past 4.0, and in fact we're about to go into soft
> > freeze for 4.1, so we're going to miss that too.  So 4.1 and earlier
> > will need to retain the old default.
>=20
> ok.
>=20
> >=20
> >>  }
> >> =20
> >>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index a015a80..e010cb2 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -49,6 +49,7 @@
> >>  #include "hw/ppc/fdt.h"
> >>  #include "target/ppc/mmu-hash64.h"
> >>  #include "target/ppc/mmu-book3s-v3.h"
> >> +#include "migration/blocker.h"
> >> =20
> >>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState=
 *spapr,
> >>                                     uint32_t token, uint32_t nargs,
> >> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu,=
 SpaprMachineState *spapr,
> >>      rtas_st(rets, 1, 100);
> >>  }
> >> =20
> >> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >> +                                  SpaprMachineState *spapr,
> >> +                                  uint32_t token, uint32_t nargs,
> >> +                                  target_ulong args,
> >> +                                  uint32_t nret, target_ulong rets)
> >> +{
> >> +    int ret;
> >> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> >> +
> >> +    if (!rtas_addr) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >> +        return;
> >> +    }
> >> +
> >> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OF=
F) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >> +        return;
> >> +    }
> >> +
> >> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >> +    if (ret =3D=3D 1) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >=20
> > I don't understand this case separate from the others.  We've already
> > set the cap, so fwnmi support should be checked and available.
>=20
> But we have not enabled fwnmi in KVM. kvmppc_fwnmi_enable() returns 1 if
> cap_ppc_fwnmi is not available in KVM.

But you've checked for the presence of the extension, yes?  So a
failure to enable the cap would be unexpected.  In which case how does
this case differ from..=20

>=20
> >=20
> >> +        return;
> >> +    } else if (ret < 0) {
> >> +        error_report("Couldn't enable KVM FWNMI capability");
> >> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> >> +        return;

=2E.this case.

> >> +    }
> >> +
> >> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> >> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >> +}
> >> +
> >> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> >> +                                   SpaprMachineState *spapr,
> >> +                                   uint32_t token, uint32_t nargs,
> >> +                                   target_ulong args,
> >> +                                   uint32_t nret, target_ulong rets)
> >> +{
> >> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> >> +        /* NMI register not called */
> >> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >> +    } else {
> >> +        /*
> >> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> >> +         * hence unset mc_status.
> >> +         */
> >> +        spapr->mc_status =3D -1;
> >> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> >> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
> >=20
> > Hrm.  We add the blocker at the mce request point.  First, that's in
> > another patch, which isn't great.  Second, does that mean we could add
> > multiple times if we get an MCE on multiple CPUs?  Will that work and
> > correctly match adds and removes properly?
>=20
> If it is fine to move the migration patch as the last patch in the
> sequence, then we will have add and del blocker in the same patch.
>=20
> And yes we could add multiple times if we get MCE on multiple CPUs and
> as all those cpus call interlock there should be matching number of
> delete blockers.

Ok, and I think adding the same pointer to the list multiple times
will work ok.

Btw, add_blocker() can fail - have you handled failure conditions?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cHvkACgkQbDjKyiDZ
s5KuJhAA1wV0Nii9ysFP+PTBGqsq0Xxd/EdD61LLScYNT5JnMaSFheyyHY3/VdJn
/NLB1Oy20etSagtT7XERkbhlCtNFQG63trDD/6D7wPPKGTQpF1Z7Y9EUO7THP1JE
YzyKTGTmZ/B9+SVxmW6Pw20ziiBPE1prEBUc91Kn4jI37yynJH7mJDK2SrNMjRGm
X3cLKDc1h2NM3uIf7wTK9nsFal1mOFJhUtSTmuQZ3Ehn6fLViXfHVfpL8dRrSXPY
p0a1oeyU2Y+WU+3Q5c/4/zw9+bWjCQ4KFegfxgp3fbKKvEIvySyvVLw6ltGwTgBJ
ReoVMO+5HIC7ePm4B6GoaCHKYdGbjJ8mjmFhmar4P64cW77J89WtXJaRVpFWELlk
7GU6NmVfGCNbUFUgtoNwTllNtcO+CBLsI0spKSFuTllt5MaqUqLcwcf7RhE8QpTR
XF9SofkMkqngU4OUSVAHZQNf0TX1cO/ZTpIPsRMAh7O9kajzyEEbCT4fQkI8vID2
RwHU8CM9P/ugkGolF9R/7OEW8zJ7Dd8aaSnpl2LWauA9yJ1pYOx8eh8DN6CPa69P
nWiQzFGeAthJUy3VkD5n9kTQD4GN7d470aU/MrYTiNZptAkyHUxO9l4dWVrIMr2o
Mgl4kzMX4vNM+8ZKIk6Io1BJjE18KU0XN7Arhaz+C6KjZp7OcKw=
=jojk
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--

