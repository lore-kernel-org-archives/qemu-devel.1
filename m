Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3739C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6B2215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aDo7qxRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6B2215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5nL-0003JS-1J
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iT5lO-0002Ga-D7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iT5lM-00030t-Ki
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:01:25 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46905 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iT5lK-0002wB-KS; Fri, 08 Nov 2019 10:01:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 478k452K5yz9sP3; Sat,  9 Nov 2019 02:01:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573225269;
 bh=L8m+l5KOyEEAqLTzbmGNsdw8kzr53pZ8Ue9gy7VS200=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aDo7qxRUjtKN9NMRjVU4w6g2mIiXxM11urZXQRDzWwj7OgzybU7sIVNZ1PT5muoMI
 /ohc5hfExfOuHLgd3ZTqaesZmvKVfL5DPGHHiqt8AniOPYD04vLbpbwtgKMImTSoyk
 3wJtFMVtt9zc2F3dGbZcju94R6fn2Y5k6OQO02RQ=
Date: Fri, 8 Nov 2019 14:26:10 +0000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 06/28] spapr: Set VSMT to smp_threads by default
Message-ID: <20191108142610.GM2461@umbus.Home>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
 <20191024081813.2115-7-david@gibson.dropbear.id.au>
 <9aebac7e-8ea3-0c16-30ca-251bcddd7699@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline
In-Reply-To: <9aebac7e-8ea3-0c16-30ca-251bcddd7699@redhat.com>
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
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 02:11:03PM +0100, Laurent Vivier wrote:
> On 24/10/2019 10:17, David Gibson wrote:
> > From: Greg Kurz <groug@kaod.org>
> >=20
> > Support for setting VSMT is available in KVM since linux-4.13. Most dis=
tros
> > that support KVM on POWER already have it. It thus seem reasonable enou=
gh
> > to have the default machine to set VSMT to smp_threads.
> >=20
> > This brings contiguous VCPU ids and thus brings their upper bound down =
to
> > the machine's max_cpus. This is especially useful for XIVE KVM devices,
> > which may thus allocate only one VP descriptor per VCPU.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Message-Id: <157010411885.246126.12610015369068227139.stgit@bahia.lan>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c         | 7 ++++++-
> >  include/hw/ppc/spapr.h | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 4eb97d3a9b..428b834f30 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2496,6 +2496,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineStat=
e *ms, uint32_t id, int *idx)
> >  static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *ms =3D MACHINE(spapr);
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      Error *local_err =3D NULL;
> >      bool vsmt_user =3D !!spapr->vsmt;
> >      int kvm_smt =3D kvmppc_smt_threads();
> > @@ -2522,7 +2523,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
 *spapr, Error **errp)
> >              goto out;
> >          }
> >          /* In this case, spapr->vsmt has been set by the command line =
*/
> > -    } else {
> > +    } else if (!smc->smp_threads_vsmt) {
> >          /*
> >           * Default VSMT value is tricky, because we need it to be as
> >           * consistent as possible (for migration), but this requires
> > @@ -2531,6 +2532,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
 *spapr, Error **errp)
> >           * overwhelmingly common case in production systems.
> >           */
> >          spapr->vsmt =3D MAX(8, smp_threads);
> > +    } else {
> > +        spapr->vsmt =3D smp_threads;
> >      }
> > =20
> >      /* KVM: If necessary, set the SMT mode: */
> > @@ -4438,6 +4441,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->irq =3D &spapr_irq_dual;
> >      smc->dr_phb_enabled =3D true;
> >      smc->linux_pci_probe =3D true;
> > +    smc->smp_threads_vsmt =3D true;
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -4505,6 +4509,7 @@ static void spapr_machine_4_1_class_options(Machi=
neClass *mc)
> > =20
> >      spapr_machine_4_2_class_options(mc);
> >      smc->linux_pci_probe =3D false;
> > +    smc->smp_threads_vsmt =3D false;
> >      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_le=
n);
> >      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index cbd1a4c9f3..2009eb64f9 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -122,6 +122,7 @@ struct SpaprMachineClass {
> >      bool broken_host_serial_model; /* present real host info to the gu=
est */
> >      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> >      bool linux_pci_probe;
> > +    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
> > =20
> >      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
> >                            uint64_t *buid, hwaddr *pio,=20
> >=20
>=20
> This patch breaks tests/migration-test on P8 host with kernel older than
> 4.3 because it tries by default to set the VSMT to 1.
>=20
> qemu-system-ppc64: Failed to set KVM's VSMT mode to 1 (errno -22)
> On PPC, a VM with 1 threads/core on a host with 8 threads/core requires
> the use of VSMT mode 1.
> This KVM seems to be too old to support VSMT.
>=20
> As this is clearly intentional, is there a way to fix migration-test?

Hrm.  I believe the argument for this was that the broken kernels were
old enough we didn't care.  What platform are you testing on where
you're hitting this?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3FewIACgkQbDjKyiDZ
s5LckRAAgP49qITSZ0dF4utjDRiDRv9dydTSVAl2g4x58tyGCfe38MqnBR0BSqhE
V+s8s5WwV6fd5dnbcDOi/eURoZuND/wzQFnf5rjlaer/XdRTAw7vscPxikatI8uY
801NzTBEBU4RXKeQl+gfFm4CQuTxtSMoaTKRMBgRGjJDxyTfjt9a5HoVOb3vklFx
VF3+GbGXpKmPSL8YdWmW/nl6JssPE9Srj79ReRR4x/iXo6Q5bNgU8wAy4sOEPiUb
wWUkJmY2jHuvxA4Em1Gi57NbEtxj8mp7LaetZEiAjGfCmdW+j5H70PS0BLFf4UOW
73BoY28mkXtNVspQeWNRePPiPhc0XpCscDXS7sdsqKjrAKDYT1skjOPu4fiEvVK0
tcNF02xqutBb8S0oLEJYBx/BscEs+dXmMWH+1IApYlLsSAkduEU0Q3jY6Ul+vnFF
bK4d+P8LabB20QsGEBDmQ7295vkKQV7qTAmNVLpVgKpillnhztWi9di5oj5SCG6o
xuew96EfMxUJNgQRqmCojpkoRb58hBCHmafVdjyS/0Wi2RyQ3qTJBJzt62koqcrl
eoYgDHtSvy1ptdH6IhL/vsHDS7hMm9CSoKxos631dR+ujj0BoHE71IZo06Qble9h
4KXq2AWifj1Mk3oho89vHAmav4zmTpIKiEydZ3PKDw8sMK7KG8g=
=nVqk
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--

