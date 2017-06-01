Received: from eggs.gnu.org ([2001:4830:134:3::10]:53083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGKXz-0001V6-PN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGKXw-0004XV-GY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:29:31 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:60565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGKXw-0004Wo-3P
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:29:28 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 95DE910043B
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 09:29:26 +0200 (CEST)
Date: Thu, 1 Jun 2017 09:29:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601092908.5a17eeec@bahia.lan>
In-Reply-To: <1496295880.4414.1.camel@gmail.com>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-4-david@gibson.dropbear.id.au>
	<1496295880.4414.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/UCTye6gcgE28J5+9JRbfiE0";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv4 3/5] pseries: Move CPU
 compatibility property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, quintela@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-ppc@nongnu.org, abologna@redhat.com, sbobroff@redhat.com, dgilbert@redhat.com

--Sig_/UCTye6gcgE28J5+9JRbfiE0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Jun 2017 15:44:40 +1000
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> On Fri, 2017-05-26 at 15:23 +1000, David Gibson wrote:
> > Server class POWER CPUs have a "compat" property, which is used to
> > set the
> > backwards compatibility mode for the processor.=C2=A0=C2=A0However, thi=
s only
> > makes
> > sense for machine types which don't give the guest access to
> > hypervisor
> > privilege - otherwise the compatibility level is under the guest's
> > control.
> >=20
> > To reflect this, this removes the CPU 'compat' property and instead
> > creates a 'max-cpu-compat' property on the pseries machine.=C2=A0=C2=A0=
Strictly
> > speaking this breaks compatibility, but AFAIK the 'compat' option was
> > never (directly) used with -device or device_add.
> >=20
> > The option was used with -cpu.=C2=A0=C2=A0So, to maintain compatibility=
, this
> > patch adds a hack to the cpu option parsing to strip out any compat
> > options supplied with -cpu and set them on the machine property
> > instead of the now deprecated cpu property. =20
>=20
> Generally looks good, a couple of comments below.
>=20
> Suraj
>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > =C2=A0hw/ppc/spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A06 ++-
> > =C2=A0hw/ppc/spapr_cpu_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A056 +++++++++++++++++++++++-
> > =C2=A0hw/ppc/spapr_hcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A0=C2=A08 ++--
> > =C2=A0include/hw/ppc/spapr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A012 ++++--
> > =C2=A0target/ppc/compat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 102
> > ++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0target/ppc/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A05 ++-
> > =C2=A0target/ppc/translate_init.c |=C2=A0=C2=A086 +++++++++++----------=
-------------
> > ---
> > =C2=A07 files changed, 202 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ab3aab1..3c4e88f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2134,7 +2134,7 @@ static void ppc_spapr_init(MachineState
> > *machine)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0machine->cpu_mode=
l =3D kvm_enabled() ? "host" : smc- =20
> > >tcg_default_cpu; =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0ppc_cpu_parse_features(machine->cpu_model);
> > +=C2=A0=C2=A0=C2=A0=C2=A0spapr_cpu_parse_features(spapr);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spapr_init_cpus(spapr);
> > =C2=A0
> > @@ -2497,6 +2497,10 @@ static void spapr_machine_initfn(Object *obj)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0" place of standard EPOW events
> > when possible"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0" (required for memory hot-
> > unplug support)",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0ppc_compat_add_property(obj, "max-cpu-compat",=
 &spapr- =20
> > >max_compat_pvr, =20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"Maximum permitted CPU compatibility
> > mode",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0&error_fatal);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void spapr_machine_finalizefn(Object *obj)
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index ff7058e..ab4102b 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -20,6 +20,58 @@
> > =C2=A0#include "sysemu/numa.h"
> > =C2=A0#include "qemu/error-report.h"
> > =C2=A0
> > +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Backwards compatibility hack:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0CPUs had a "compat=3D=
" property which didn't make sense for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0anything except pseri=
es.=C2=A0=C2=A0It was replaced by "max-cpu-
> > compat"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0machine option.=C2=A0=
=C2=A0This supports old command lines like
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0-cpu POWER8,compat=3Dpower7
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0By stripping the comp=
at option and applying it to the
> > machine
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=C2=A0=C2=A0before passing it on =
to the cpu level parser.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0gchar **inpieces;
> > +=C2=A0=C2=A0=C2=A0=C2=A0int i, j;
> > +=C2=A0=C2=A0=C2=A0=C2=A0gchar *compat_str =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0inpieces =3D g_strsplit(MACHINE(spapr)->cpu_mo=
del, ",", 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* inpieces[0] is the actual model string */
> > +=C2=A0=C2=A0=C2=A0=C2=A0i =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0j =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0while (inpieces[i]) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (g_str_has_prefix(i=
npieces[i], "compat=3D")) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* in case of multiple compat=3D optipons */ =20
>=20
> s/optipons/options?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0g_free(compat_str);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0compat_str =3D inpieces[i];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0j++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Excise compat optio=
ns from list */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inpieces[j] =3D inpiec=
es[i]; =20
>=20
> it's worth noting that where previously when specifying an invalid
> option you got:
>=20
> qemu-system-ppc64: Expected key=3Dvalue format, found=C2=A0*blah*
>=20
> You now get a segfault here.
>=20

Yeah. This basically does:

    inpieces[i + 1] =3D inpieces[i];

and we end up overwriting the terminal NULL pointer with a non-NULL
pointer.

What about simplifying the loop to:

    /* inpieces[0] is the actual model string */
    i =3D 1;
    while (inpieces[i]) {
        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
            /* in case of multiple compat=3D optipons */
            g_free(compat_str);
            compat_str =3D inpieces[i];
            /* Excise compat options from list */
            inpieces[i] =3D inpieces[i + 1];
        }
        i++;
    }

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0inpieces[j] =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (compat_str) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *val =3D compat_s=
tr + strlen("compat=3D");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gchar *newprops =3D g_=
strjoinv(",", inpieces);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_property_set_st=
r(OBJECT(spapr), val, "max-cpu-
> > compat",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&error_fatal);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ppc_cpu_parse_features=
(newprops);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(newprops);
> > +=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ppc_cpu_parse_features=
(MACHINE(spapr)->cpu_model);
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_strfreev(inpieces);
> > +}
> > +
> > =C2=A0static void spapr_cpu_reset(void *opaque)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sPAPRMachineState *spapr =3D SPAPR_MACHIN=
E(qdev_get_machine());
> > @@ -70,10 +122,10 @@ static void spapr_cpu_init(sPAPRMachineState
> > *spapr, PowerPCCPU *cpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Enable PAPR mode in TCG or KVM */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVI=
SOR(spapr));
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0if (cpu->max_compat) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (spapr->max_compat_pvr) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error *local_err =
=3D NULL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ppc_set_compat(cpu, cp=
u->max_compat, &local_err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ppc_set_compat(cpu, sp=
apr->max_compat_pvr, &local_err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (local_err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0error_propagate(errp, local_err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0return;
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 77d2d66..8129959 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1044,11 +1044,11 @@ static target_ulong
> > h_signal_sys_reset(PowerPCCPU *cpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0}
> > =C2=A0
> > -static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp)
> > +static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU
> > *cpu,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target_ulong *addr, Error **errp)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool explicit_match =3D false; /* Matched=
 the CPU's real PVR */
> > -=C2=A0=C2=A0=C2=A0=C2=A0uint32_t max_compat =3D cpu->max_compat;
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t max_compat =3D spapr->max_compat_pvr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t best_compat =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > =C2=A0
> > @@ -1104,7 +1104,7 @@ static target_ulong
> > h_client_architecture_support(PowerPCCPU *cpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool guest_radix;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error *local_err =3D NULL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0cas_pvr =3D cas_check_pvr(cpu, &addr, &local_e=
rr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &=
local_err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (local_err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report_err(=
local_err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return H_HARDWARE;
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 98fb78b..4da92e2 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -87,16 +87,19 @@ struct sPAPRMachineState {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t rtc_offset; /* Now used only dur=
ing incoming migration
> > */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct PPCTimebase tb;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_graphics;
> > -=C2=A0=C2=A0=C2=A0=C2=A0sPAPROptionVector *ov5;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* QEMU-supported option vectors
> > */
> > -=C2=A0=C2=A0=C2=A0=C2=A0sPAPROptionVector *ov5_cas;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0/* negotiated (via CAS) option
> > vectors */
> > -=C2=A0=C2=A0=C2=A0=C2=A0bool cas_reboot;
> > -=C2=A0=C2=A0=C2=A0=C2=A0bool cas_legacy_guest_workaround;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Notifier epow_notifier;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QTAILQ_HEAD(, sPAPREventLogEntry) pending=
_events;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool use_hotplug_event_source;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sPAPREventSource *event_sources;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* ibm,client-architecture-support option nego=
tiation */
> > +=C2=A0=C2=A0=C2=A0=C2=A0bool cas_reboot;
> > +=C2=A0=C2=A0=C2=A0=C2=A0bool cas_legacy_guest_workaround;
> > +=C2=A0=C2=A0=C2=A0=C2=A0sPAPROptionVector *ov5;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* QEMU-supported option vectors
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0sPAPROptionVector *ov5_cas;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0/* negotiated (via CAS) option
> > vectors */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t max_compat_pvr;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Migration state */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int htab_save_index;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool htab_first_pass;
> > @@ -639,6 +642,7 @@ void
> > spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t count, uint32_t
> > index);
> > =C2=A0void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorTy=
pe
> > drc_type,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32=
_t count,
> > uint32_t index);
> > +void spapr_cpu_parse_features(sPAPRMachineState *spapr);
> > =C2=A0void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0sPAPRMachineState *spapr);
> > =C2=A0
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index e8ec1e1..e72839f 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -24,9 +24,11 @@
> > =C2=A0#include "sysemu/cpus.h"
> > =C2=A0#include "qemu/error-report.h"
> > =C2=A0#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > =C2=A0#include "cpu-models.h"
> > =C2=A0
> > =C2=A0typedef struct {
> > +=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t pvr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t pcr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t pcr_level;
> > @@ -38,6 +40,7 @@ static const CompatInfo compat_table[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Ordered from oldest to newest - t=
he code relies on this
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* POWER6, ISA2.05 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "power6",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pvr =3D CPU_POWE=
RPC_LOGICAL_2_05,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr =3D PCR_COMP=
AT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
> > @@ -45,24 +48,28 @@ static const CompatInfo compat_table[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_threads =3D =
2,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* POWER7, ISA2.06 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "power7",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pvr =3D CPU_POWE=
RPC_LOGICAL_2_06,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr =3D PCR_COMP=
AT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
> > PCR_TM_DIS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr_level =3D PC=
R_COMPAT_2_06,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_threads =3D =
4,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "power7+",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pvr =3D CPU_POWE=
RPC_LOGICAL_2_06_PLUS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr =3D PCR_COMP=
AT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
> > PCR_TM_DIS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr_level =3D PC=
R_COMPAT_2_06,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_threads =3D =
4,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* POWER8, ISA2.07 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "power8",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pvr =3D CPU_POWE=
RPC_LOGICAL_2_07,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr =3D PCR_COMP=
AT_3_00 | PCR_COMPAT_2_07,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr_level =3D PC=
R_COMPAT_2_07,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_threads =3D =
8,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* POWER9, ISA3.00 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "power9",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pvr =3D CPU_POWE=
RPC_LOGICAL_3_00,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr =3D PCR_COMP=
AT_3_00,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pcr_level =3D PC=
R_COMPAT_3_00,
> > @@ -189,3 +196,98 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return n_threads;
> > =C2=A0}
> > +
> > +static void ppc_compat_prop_get(Object *obj, Visitor *v, const char
> > *name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *opaque, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t compat_pvr =3D *((uint32_t *)opaque);
> > +=C2=A0=C2=A0=C2=A0=C2=A0const char *value;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (!compat_pvr) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D "";
> > +=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const CompatInfo *comp=
at =3D compat_by_pvr(compat_pvr);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_assert(compat);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D compat->name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0visit_type_str(v, name, (char **)&value, errp);
> > +}
> > +
> > +static void ppc_compat_prop_set(Object *obj, Visitor *v, const char
> > *name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *opaque, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0Error *error =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0char *value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint32_t compat_pvr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0visit_type_str(v, name, &value, &error);
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (error) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_propagate(errp, =
error);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (strcmp(value, "") =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compat_pvr =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const CompatInfo *comp=
at =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < ARRA=
Y_SIZE(compat_table); i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (strcmp(value, compat_table[i].name) =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0compat =3D &compat_table[i];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!compat) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0error_setg(errp, "Invalid compatibility mode \"%s\"",
> > value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compat_pvr =3D compat-=
>pvr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0*((uint32_t *)opaque) =3D compat_pvr;
> > +
> > +out:
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_free(value);
> > +}
> > +
> > +void ppc_compat_add_property(Object *obj, const char *name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t *compat_pvr, const char
> > *basedesc,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0Error *local_err =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0gchar *namesv[ARRAY_SIZE(compat_table) + 1];
> > +=C2=A0=C2=A0=C2=A0=C2=A0gchar *names, *desc;
> > +=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0object_property_add(obj, name, "string",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ppc_compat_prop_get, ppc_compat_prop_set,
> > NULL,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
compat_pvr, &local_err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (local_err) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < ARRAY_SIZE(compat_table); i+=
+) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Have to discar=
d const here, because g_strjoinv() takes
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* (gchar **), no=
t (const gchar **) :(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0namesv[i] =3D (gchar *=
)compat_table[i].name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0namesv[ARRAY_SIZE(compat_table)] =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0names =3D g_strjoinv(", ", namesv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0desc =3D g_strdup_printf("%s. Valid values are=
 %s.", basedesc,
> > names);
> > +=C2=A0=C2=A0=C2=A0=C2=A0object_property_set_description(obj, name, des=
c, &local_err);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_free(names);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_free(desc);
> > +
> > +out:
> > +=C2=A0=C2=A0=C2=A0=C2=A0error_propagate(errp, local_err);
> > +}
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 401e10e..4517b4b 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1189,7 +1189,6 @@ typedef struct PPCVirtualHypervisorClass
> > PPCVirtualHypervisorClass;
> > =C2=A0 * PowerPCCPU:
> > =C2=A0 * @env: #CPUPPCState
> > =C2=A0 * @cpu_dt_id: CPU index used in the device tree. KVM uses this
> > index too
> > - * @max_compat: Maximal supported logical PVR from the command line
> > =C2=A0 * @compat_pvr: Current logical PVR, zero if in "raw" mode
> > =C2=A0 *
> > =C2=A0 * A PowerPC CPU.
> > @@ -1201,7 +1200,6 @@ struct PowerPCCPU {
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPUPPCState env;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cpu_dt_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0uint32_t max_compat;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t compat_pvr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PPCVirtualHypervisor *vhyp;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Object *intc;
> > @@ -1374,6 +1372,9 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t
> > compat_pvr, Error **errp);
> > =C2=A0void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
> > =C2=A0#endif
> > =C2=A0int ppc_compat_max_threads(PowerPCCPU *cpu);
> > +void ppc_compat_add_property(Object *obj, const char *name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t *compat_pvr, const char
> > *basedesc,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp);
> > =C2=A0#endif /* defined(TARGET_PPC64) */
> > =C2=A0
> > =C2=A0#include "exec/cpu-all.h"
> > diff --git a/target/ppc/translate_init.c
> > b/target/ppc/translate_init.c
> > index 56a0ab2..e837cd2 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -33,6 +33,7 @@
> > =C2=A0#include "hw/qdev-properties.h"
> > =C2=A0#include "hw/ppc/ppc.h"
> > =C2=A0#include "mmu-book3s-v3.h"
> > +#include "sysemu/qtest.h"
> > =C2=A0
> > =C2=A0//#define PPC_DUMP_CPU
> > =C2=A0//#define PPC_DEBUG_SPR
> > @@ -8413,73 +8414,38 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void
> > *data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->l1_icache_size =3D 0x10000;
> > =C2=A0}
> > =C2=A0
> > -static void powerpc_get_compat(Object *obj, Visitor *v, const char
> > *name,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *opaque, Error **errp)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0char *value =3D (char *)"";
> > -=C2=A0=C2=A0=C2=A0=C2=A0Property *prop =3D opaque;
> > -=C2=A0=C2=A0=C2=A0=C2=A0uint32_t *max_compat =3D qdev_get_prop_ptr(DEV=
ICE(obj), prop);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0switch (*max_compat) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0case CPU_POWERPC_LOGICAL_2_05:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D (char *)"pow=
er6";
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0case CPU_POWERPC_LOGICAL_2_06:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D (char *)"pow=
er7";
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0case CPU_POWERPC_LOGICAL_2_07:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D (char *)"pow=
er8";
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0case 0:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0default:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("Internal=
 error: compat is set to %x",
> > *max_compat);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0abort();
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0}
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0visit_type_str(v, name, &value, errp);
> > -}
> > -
> > -static void powerpc_set_compat(Object *obj, Visitor *v, const char
> > *name,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *opaque, Error **errp)
> > +/*
> > + * The CPU used to have a "compat" property which set the
> > + * compatibility mode PVR.=C2=A0=C2=A0However, this was conceptually b=
roken -
> > it
> > + * only makes sense on the pseries machine type (otherwise the guest
> > + * owns the PCR and can control the compatibility mode
> > itself).=C2=A0=C2=A0It's
> > + * been replaced with the 'max-cpu-compat' property on the pseries
> > + * machine type.=C2=A0=C2=A0For backwards compatibility, pseries speci=
ally
> > + * parses the -cpu parameter and converts old compat=3D parameters
> > into
> > + * the appropriate machine parameters.=C2=A0=C2=A0This stub implementa=
tion of
> > + * the parameter catches any uses on explicitly created CPUs.
> > + */
> > +static void getset_compat_deprecated(Object *obj, Visitor *v, const
> > char *name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0void *opaque, Error **errp)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0Error *error =3D NULL;
> > -=C2=A0=C2=A0=C2=A0=C2=A0char *value =3D NULL;
> > -=C2=A0=C2=A0=C2=A0=C2=A0Property *prop =3D opaque;
> > -=C2=A0=C2=A0=C2=A0=C2=A0uint32_t *max_compat =3D qdev_get_prop_ptr(DEV=
ICE(obj), prop);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0visit_type_str(v, name, &value, &error);
> > -=C2=A0=C2=A0=C2=A0=C2=A0if (error) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_propagate(errp, =
error);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > -=C2=A0=C2=A0=C2=A0=C2=A0}
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0if (strcmp(value, "power6") =3D=3D 0) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*max_compat =3D CPU_PO=
WERPC_LOGICAL_2_05;
> > -=C2=A0=C2=A0=C2=A0=C2=A0} else if (strcmp(value, "power7") =3D=3D 0) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*max_compat =3D CPU_PO=
WERPC_LOGICAL_2_06;
> > -=C2=A0=C2=A0=C2=A0=C2=A0} else if (strcmp(value, "power8") =3D=3D 0) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*max_compat =3D CPU_PO=
WERPC_LOGICAL_2_07;
> > -=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Inva=
lid compatibility mode \"%s\"",
> > value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (!qtest_enabled()) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("CPU 'com=
pat' property is deprecated and has no
> > effect; "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"use max-cpu-compa=
t machine property instead");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0g_free(value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0visit_type_null(v, name, NULL);
> > =C2=A0}
> > =C2=A0
> > -static PropertyInfo powerpc_compat_propinfo =3D {
> > +static PropertyInfo ppc_compat_deprecated_propinfo =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "str",
> > -=C2=A0=C2=A0=C2=A0=C2=A0.description =3D "compatibility mode, power6/p=
ower7/power8",
> > -=C2=A0=C2=A0=C2=A0=C2=A0.get =3D powerpc_get_compat,
> > -=C2=A0=C2=A0=C2=A0=C2=A0.set =3D powerpc_set_compat,
> > +=C2=A0=C2=A0=C2=A0=C2=A0.description =3D "compatibility mode (deprecat=
ed)",
> > +=C2=A0=C2=A0=C2=A0=C2=A0.get =3D getset_compat_deprecated,
> > +=C2=A0=C2=A0=C2=A0=C2=A0.set =3D getset_compat_deprecated,
> > =C2=A0};
> > -
> > -#define DEFINE_PROP_POWERPC_COMPAT(_n, _s, _f) \
> > -=C2=A0=C2=A0=C2=A0=C2=A0DEFINE_PROP(_n, _s, _f, powerpc_compat_propinf=
o, uint32_t)
> > -
> > =C2=A0static Property powerpc_servercpu_properties[] =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0DEFINE_PROP_POWERPC_COMPAT("compat", PowerPCCP=
U, max_compat),
> > +=C2=A0=C2=A0=C2=A0=C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "compat",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.info =3D &ppc_compat_=
deprecated_propinfo,
> > +=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEFINE_PROP_END_OF_LIST(),
> > =C2=A0};
> > =C2=A0 =20


--Sig_/UCTye6gcgE28J5+9JRbfiE0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkvwkQACgkQAvw66wEB28LpEACeIL5oZW3K0J/tYrxcUHjKBdA4
FzoAmgIE65LXQfZHqs6O5pmpE2mc0KFA
=fm5o
-----END PGP SIGNATURE-----

--Sig_/UCTye6gcgE28J5+9JRbfiE0--
