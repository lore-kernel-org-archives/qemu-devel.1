Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C070ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A45207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A45207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJylW-0000iN-EI
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iJyaD-0003Wh-Tl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iJya8-0002gZ-Cr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:32:10 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:49410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iJya4-0002WY-DL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:32:05 -0400
Received: from player793.ha.ovh.net (unknown [10.108.35.124])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 09DE01454B4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 13:31:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id DCCD5AEA73CF;
 Mon, 14 Oct 2019 11:31:51 +0000 (UTC)
Date: Mon, 14 Oct 2019 13:31:49 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 7/7] spapr: Set VSMT to smp_threads by default
Message-ID: <20191014133149.686b681e@bahia.lan>
In-Reply-To: <20191014061247.GZ4080@umbus.fritz.box>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010411885.246126.12610015369068227139.stgit@bahia.lan>
 <20191014061247.GZ4080@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I47mP63z5TeIBN61Vqkk7q3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 6677712348298713574
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjedugdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.175
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/I47mP63z5TeIBN61Vqkk7q3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2019 17:12:47 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 03, 2019 at 02:02:00PM +0200, Greg Kurz wrote:
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

Just to clarify that without the other patches in this series, XIVE
KVM devices still allocate a fixed block of 2048 VPs, no matter what.
ie, the last sentence in the changelog may be slightly misleading.

> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Applied to ppc-for-4.2, thanks.
>=20
> > ---
> >  hw/ppc/spapr.c         |    7 ++++++-
> >  include/hw/ppc/spapr.h |    1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8f59f08c102e..473ce1d04775 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2503,6 +2503,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineStat=
e *ms, uint32_t id, int *idx)
> >  static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *ms =3D MACHINE(spapr);
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      Error *local_err =3D NULL;
> >      bool vsmt_user =3D !!spapr->vsmt;
> >      int kvm_smt =3D kvmppc_smt_threads();
> > @@ -2529,7 +2530,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
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
> > @@ -2538,6 +2539,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
 *spapr, Error **errp)
> >           * overwhelmingly common case in production systems.
> >           */
> >          spapr->vsmt =3D MAX(8, smp_threads);
> > +    } else {
> > +        spapr->vsmt =3D smp_threads;
> >      }
> > =20
> >      /* KVM: If necessary, set the SMT mode: */
> > @@ -4452,6 +4455,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->irq =3D &spapr_irq_dual;
> >      smc->dr_phb_enabled =3D true;
> >      smc->linux_pci_probe =3D true;
> > +    smc->smp_threads_vsmt =3D true;
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -4519,6 +4523,7 @@ static void spapr_machine_4_1_class_options(Machi=
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
> > index cbd1a4c9f390..2009eb64f9cb 100644
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


--Sig_/I47mP63z5TeIBN61Vqkk7q3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2kXKUACgkQcdTV5YIv
c9Z0gxAAyO+CLPJjJZomJKzLD8W9rnh4j9DkSJuvmjK7nEmMayiUwEE+3F+Le4tQ
9sMB3H1nk8TJKrG0A3WZhlLKdxW6cUnrj8hGiwteI5I0DsJn/A/34v+28FGLBoRo
tzG7FaPc+c3cwzgphIOFunB5XcRwdF+pTJ8Aao5iJUqOrOHmkBlGhLkc7KhyKUCN
YeR6SzW26ABXWqBwhXGRP93Q5dtavAOp6LW1ZabTaru+x15i39E/RS7nJRuKdtjX
cRayqwrQ5u34u5GpF/jYRwXDGVIijhzIL3ZLJHM5Lv6VDPXPcs9ZsYqYRi6U3Nt4
d22RQndB2DHEkm/ej6UULvUyzq6M9N9CUf2iulxBswcw1x7uUxdvXjDEksgCnMVn
V2VDN2NNTD+iz2hXt+3v9SMlU/Or/IxMDVfjdCia4Fi51TjCCltmXSchxkRITGeB
jlbT84EKTLCL/Fo+rn6raVDA0jDeRNXO1JZPSxmSTGWJ+uAK/J/BVzesjn2VJIz3
DBSERZSmB9QwytibRLwjo4WsTUhlBagJqeVMNtAV7CAaZDGS1K96SqXgQlar69sY
pb/en8DIeA3ytAuUUmaJWPSajFHwpuOy+w847QIFRr+OMTvBm09OU1vpvP4oCMUD
n/FovFTSIXIBg6HaKYM5zVhg5yCGZJ75sVq20t8zaVsgIoC6X1k=
=DFqS
-----END PGP SIGNATURE-----

--Sig_/I47mP63z5TeIBN61Vqkk7q3--

