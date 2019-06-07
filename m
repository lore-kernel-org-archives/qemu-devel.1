Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289DEC04AB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E590220840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N7bl2AGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E590220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2wU-0002pr-8K
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2uu-0001zF-9T
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2us-0003ld-Se
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:39:36 -0400
Received: from ozlabs.org ([203.11.71.1]:58205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hZ2ur-0003dK-Ko; Thu, 06 Jun 2019 20:39:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45KkDt2DLYz9s00; Fri,  7 Jun 2019 10:39:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1559867966;
 bh=3t8aZ0tF3nQdKiXc73mPtT+S+hlrvFv0nR43gZbu2YQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N7bl2AGChOr1b3cC0JH3roToMBAwL2GPUx94+GhmwTnH7M/x7a011hrgyEp9VrzJL
 gGYCzgsnR0MmQw7L0JV9Jrw9OxyLh/HAejueytntiNL9ZmZ+1gl0Ew4J6kUuHJa7Xd
 d16/LofwgIj1PdLK9RXL6CRdXWR2XZ9rZxwkYSrA=
Date: Fri, 7 Jun 2019 10:23:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190607002332.GE3760@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
 <155910845769.13149.8097972239187020170.stgit@aravinda>
 <20190606030614.GK10319@umbus.fritz.box>
 <08b42ce8-2413-ce8f-980a-419146423be7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <08b42ce8-2413-ce8f-980a-419146423be7@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v9 6/6] migration: Include migration
 support for machine check handling
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


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 04:55:18PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 06 June 2019 08:36 AM, David Gibson wrote:
> > On Wed, May 29, 2019 at 11:10:57AM +0530, Aravinda Prasad wrote:
> >> This patch includes migration support for machine check
> >> handling. Especially this patch blocks VM migration
> >> requests until the machine check error handling is
> >> complete as (i) these errors are specific to the source
> >> hardware and is irrelevant on the target hardware,
> >> (ii) these errors cause data corruption and should
> >> be handled before migration.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |   20 ++++++++++++++++++++
> >>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
> >>  hw/ppc/spapr_rtas.c    |    4 ++++
> >>  include/hw/ppc/spapr.h |    2 ++
> >>  4 files changed, 43 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index e8a77636..31c4850 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2104,6 +2104,25 @@ static const VMStateDescription vmstate_spapr_d=
tb =3D {
> >>      },
> >>  };
> >> =20
> >> +static bool spapr_fwnmi_needed(void *opaque)
> >> +{
> >> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> >> +
> >> +    return (spapr->guest_machine_check_addr =3D=3D -1) ? 0 : 1;
> >=20
> > Since we're introducing a PAPR capability to enable this, it would
> > actually be better to check that here, rather than the runtime state.
> > That leads to less cases and easier to understand semantics for the
> > migration stream.
>=20
> I am fine with this approach as well.
>=20
> >=20
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_spapr_machine_check =3D {
> >> +    .name =3D "spapr_machine_check",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D spapr_fwnmi_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> >> +        VMSTATE_INT32(mc_status, SpaprMachineState),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >>  static const VMStateDescription vmstate_spapr =3D {
> >>      .name =3D "spapr",
> >>      .version_id =3D 3,
> >> @@ -2137,6 +2156,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> >>          &vmstate_spapr_dtb,
> >>          &vmstate_spapr_cap_large_decr,
> >>          &vmstate_spapr_cap_ccf_assist,
> >> +        &vmstate_spapr_machine_check,
> >>          NULL
> >>      }
> >>  };
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index 573c0b7..35e21e4 100644
> >> --- a/hw/ppc/spapr_events.c
> >> +++ b/hw/ppc/spapr_events.c
> >> @@ -41,6 +41,7 @@
> >>  #include "qemu/bcd.h"
> >>  #include "hw/ppc/spapr_ovec.h"
> >>  #include <libfdt.h>
> >> +#include "migration/blocker.h"
> >> =20
> >>  #define RTAS_LOG_VERSION_MASK                   0xff000000
> >>  #define   RTAS_LOG_VERSION_6                    0x06000000
> >> @@ -855,6 +856,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *c=
pu, bool recovered)
> >>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> >>  {
> >>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> +    int ret;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    error_setg(&spapr->fwnmi_migration_blocker,
> >> +            "Live migration not supported during machine check handli=
ng");
> >> +    ret =3D migrate_add_blocker(spapr->fwnmi_migration_blocker, &loca=
l_err);
> >> +    if (ret < 0) {
> >> +        /*
> >> +         * We don't want to abort and let the migration to continue. =
In a
> >> +         * rare case, the machine check handler will run on the target
> >> +         * hardware. Though this is not preferable, it is better than=
 aborting
> >> +         * the migration or killing the VM.
> >> +         */
> >> +        error_free(spapr->fwnmi_migration_blocker);
> >=20
> > You should set fwnmi_migration_blocker to NULL here as well.
>=20
> ok.
>=20
> >=20
> > As mentioned on an earlier iteration, the migration blocker is the
> > same every time.  Couldn't you just create it once and free at final
> > teardown, rather than recreating it for every NMI?
>=20
> That means, we create the error string at the time when ibm,nmi-register
> is invoked and tear it down during machine reset?

Or you could even just create it at machine_init time, and tear it
down never, just add/remove it from the blocker slot.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz5roQACgkQbDjKyiDZ
s5JEDBAAiuRlJSBz5iBYmrit3ux80qNxeaMmng83LmlwtY4lFeMF8X6Aa6uzlKmd
v4/TzmlycWxDrYmwsCPau0cfirVIqS7ycRHbAqHtuYMt3wuU3utxtnXjEa0i4bx4
G3gluL1sRJnds8sC6Sgar22sSAF9K81km92m3r68ZLakJLkgreJQTQfJrCAsXAES
QF5UvbmEcSTNGIrThZZfPtNRW17e5AMNe9131QOOkR5MtUk15K08TALKXMvH3yuB
NO8N6c/bzQrOruWrpuvp3CRmArVU79ly3/B2gJ4nOayOISUpc83XN4kq6Qk+1H+A
yJY4jOQeJXsfz7sz12QSQwLnSZvBsWshJPtbehg6kPWObi9BlxdWxJqGUEF3dGk7
6NjEEyiRmAjM1wv6F0g7V+AhFb56YCKoNPAvxB4SgP9eCrav1XhtoDwt8jNVzRjB
yQaWpeOBGgl9PlabfPFKR2MBLk5gbj/sMTOjGtyMAsdPUFTOiBb2eyelC2xC6V8p
WARToKiigVAlGi5AKUs5Ry3a6fyy7LHZYJNWD0bDKKqECRFBjrj0C56wQ4kuO4Nx
mBzty3Leuz4aDy7ieFycDp4gVm41OJTQFAORD+SfwpDDbV9ES8C5JMfwnNvongS/
Kcp3Q/pC1G9mLgCs90MZT45ijSpwEIkzRIxf1e2d72K5OW5CjcY=
=6ZbO
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--

