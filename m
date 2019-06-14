Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2544EC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBE22133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBE22133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbevu-0004zJ-Ar
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 01:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbeuT-0004Rx-My
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbeuS-00011v-Fq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:37:57 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:42692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbeuS-0000xl-AP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:37:56 -0400
Received: from player158.ha.ovh.net (unknown [10.108.54.156])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6E855FB385
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:37:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 8276E6B876CE;
 Fri, 14 Jun 2019 05:37:47 +0000 (UTC)
Date: Fri, 14 Jun 2019 07:37:46 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190614073746.1095f3c5@bahia.lan>
In-Reply-To: <20190614013459.GA11158@umbus.fritz.box>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <156044429419.125694.507569071972451514.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20190614013459.GA11158@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3eRzva3RJy.X0Xzu=8Vm6rx"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3652137826926959078
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeitddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.154
Subject: Re: [Qemu-devel] [PATCH 1/3] xics/spapr: Prevent RTAS/hypercalls
 emulation to be used by in-kernel XICS
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

--Sig_/3eRzva3RJy.X0Xzu=8Vm6rx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2019 11:34:59 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 13, 2019 at 06:44:54PM +0200, Greg Kurz wrote:
> > The XICS-related RTAS calls and hypercalls in QEMU are supposed to be
> > called only when the KVM in-kernel XICS is in use. =20
>=20
> I've applied this, but reversed the sense of the sentence above, which
> appears to be the intent.
>=20

Oops indeed... Thanks !

> >=20
> > Add some explicit checks to detect that, print an error message and rep=
ort
> > an hardware error to the guest.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics_spapr.c |   46 ++++++++++++++++++++++++++++++++++++++++++=
++++
> >  1 file changed, 46 insertions(+)
> >=20
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 5a1835e8b1ed..d470ab5f7a2a 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -41,11 +41,31 @@
> >   * Guest interfaces
> >   */
> > =20
> > +static bool check_in_kernel_xics(const char *func)
> > +{
> > +    if (kvm_irqchip_in_kernel()) {
> > +        error_report("pseries: %s must never be called for in-kernel X=
ICS",
> > +                     func);
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +#define CHECK_IN_KERNEL_XICS_HCALL              \
> > +    do {                                        \
> > +        if (check_in_kernel_xics(__func__)) {   \
> > +            return H_HARDWARE;                  \
> > +        }                                       \
> > +    } while (0)
> > +
> >  static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >                             target_ulong opcode, target_ulong *args)
> >  {
> >      target_ulong cppr =3D args[0];
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
> >      return H_SUCCESS;
> >  }
> > @@ -56,6 +76,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
> >      target_ulong mfrr =3D args[1];
> >      ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      if (!icp) {
> >          return H_PARAMETER;
> >      }
> > @@ -69,6 +91,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
> >  {
> >      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      args[0] =3D xirr;
> >      return H_SUCCESS;
> >  }
> > @@ -78,6 +102,8 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
> >  {
> >      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      args[0] =3D xirr;
> >      args[1] =3D cpu_get_host_ticks();
> >      return H_SUCCESS;
> > @@ -88,6 +114,8 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
> >  {
> >      target_ulong xirr =3D args[0];
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
> >      return H_SUCCESS;
> >  }
> > @@ -99,6 +127,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
> >      uint32_t mfrr;
> >      uint32_t xirr;
> > =20
> > +    CHECK_IN_KERNEL_XICS_HCALL;
> > +
> >      if (!icp) {
> >          return H_PARAMETER;
> >      }
> > @@ -111,6 +141,14 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
> >      return H_SUCCESS;
> >  }
> > =20
> > +#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
> > +    do {                                                \
> > +        if (check_in_kernel_xics(__func__)) {           \
> > +            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
> > +            return;                                     \
> > +        }                                               \
> > +    } while (0)
> > +
> >  static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >                            uint32_t token,
> >                            uint32_t nargs, target_ulong args,
> > @@ -119,6 +157,8 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t nr, srcno, server, priority;
> > =20
> > +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> > +
> >      if ((nargs !=3D 3) || (nret !=3D 1)) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >          return;
> > @@ -152,6 +192,8 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t nr, srcno;
> > =20
> > +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> > +
> >      if ((nargs !=3D 1) || (nret !=3D 3)) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >          return;
> > @@ -182,6 +224,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t nr, srcno;
> > =20
> > +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> > +
> >      if ((nargs !=3D 1) || (nret !=3D 1)) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >          return;
> > @@ -213,6 +257,8 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t nr, srcno;
> > =20
> > +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> > +
> >      if ((nargs !=3D 1) || (nret !=3D 1)) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >          return;
> >  =20
>=20


--Sig_/3eRzva3RJy.X0Xzu=8Vm6rx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl0DMqoACgkQcdTV5YIv
c9ZTXQ//Td96jsU9Nl0o0pDNIGblPgv9wkhj8cIR9WMXZjvQMoPq4XO0Wl/9A4CR
Ka8CcrEgSlp40y7qFrPsyBrCgMJI8wVPhahaUlZ99vt2/NR34LAcu3Z19alrewIM
8UB2DqIdxozp/rbzlUPRM+wz0NrET2GDgs+fM0Z0/sfvmtl08PTOg9HGRRS9wu6L
QiCQGPmJOZme/b/xf4ueemNQMOKq8XUeIVPnPrqyFTukZCxi7Y4kCxWLXs3KxeGi
2PY5VfCQsV7KiWxmzufS2/TrDNm13kXVNzPuEKRTzv4xyTzut0mG4tYVfOj518vA
YNZDZDv7RsXNz/M3/Kziom1+fAhMelOONyH/6Tda5Tgo8hQzKYXNqodw66Wxle2X
u0KdtR9L3W04Cxh7Cet5WR+prb5fXzl1M1oWewaYEAxi9pv+N2Uo7OoitIFFqMyv
m9yGe4jyj/Bqv/CDT2eX7wvZRoTtuUFSilEiymRu7+OyPiVjOsKlY4PlpdAOwZlh
WAEr/n5QYCsiNCgNruhawjJyZrYuYIC/yNZxROWVfNLigh/cC641jRdr3mDW+7WN
GcCKlbJpzrkR1Xvizry+vtqR1ma9MG7lYA70XwyDfMV32XkMLCdp1Ztjsor2HHdY
7L2DulIPD0wle3bsrZFqZNEt5vNozITTszq2phDaf9FcfuCfmKk=
=THgF
-----END PGP SIGNATURE-----

--Sig_/3eRzva3RJy.X0Xzu=8Vm6rx--

