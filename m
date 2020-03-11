Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312DC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D02920727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g0PXSiOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D02920727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBpwV-0001Nv-7R
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBpvj-0000Bv-5B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBpvh-0006Mf-7k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:13:02 -0400
Received: from ozlabs.org ([203.11.71.1]:36395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBpvg-0006Ed-Ro; Tue, 10 Mar 2020 21:13:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cYq85y7Qz9sPJ; Wed, 11 Mar 2020 12:12:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583889172;
 bh=ZZuFWOIKD8F6iCcQPGMLx8U2dzIb2s9fyLu6ujWFcd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g0PXSiOmHZBYdFAmnmR4OJaXLQt7EIBYiOgxx+Vuy2EY77KKje/Nh2MsvwrjvDwPV
 BO86Lzd+YSjIIn/0QX8TbioD4GnrSzGimujFChjI8MxZ2katUh+sjHoCEHK8YGZlnc
 eb0orQVffW1ErF3Yr1ntM23MkJNHyfZ4+qwirHbQ=
Date: Wed, 11 Mar 2020 11:58:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200311005857.GS660117@umbus.fritz.box>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
 <20200310115611.GE3234052@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mln0rGgUGuXEqmuI"
Content-Disposition: inline
In-Reply-To: <20200310115611.GE3234052@redhat.com>
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, groug@kaod.org,
 qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mln0rGgUGuXEqmuI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 11:56:11AM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Mar 05, 2020 at 03:30:08PM +1100, David Gibson wrote:
> > PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> > the guess mostly like classic PCI, even if some of the individual
> > devices on the bus are PCI Express.  One consequence of that is that
> > virtio-pci devices still default to being in transitional mode, though
> > legacy mode is now disabled by default on current q35 x86 machine
> > types.
>=20
> Two things to note here
>=20
> x86 defaults to the i440fx  machine type, and so defaults
> to transitional mode. AFAIK, only RHEL-8 downstream changed
> x86 to defualt to q35
>=20
> With q35 whether you get transitional mode or not is actually
> dependent on where you place the device. If it is placed into
> a PCIe root port, then it is modern-only. If it is placed into
> a PCI bridge, then it is transitional still.

Yes, I'm aware.

> > Legacy mode virtio devices aren't really necessary any more, and are
>=20
> Legacy mode is required for RHEL-6 which has not reached EOL yet.

Yeah.. I'm concerned about this, but I'm not sure what to do about it.

> > causing some problems for future changes.  Therefore, for the
> > pseries-5.0 machine type (and onwards), switch to modern-only
> > virtio-pci devices by default.
>=20
> The challenge I see with pseries, as compared to x86 is around
> how apps deal with mgmt / guest setup.  With x86 there are
> distinct machine types i440fx / q35, so mgmt apps could decide
> what todo based on the chipset & device support. eg they can
> determine whether the guest supports PCIe at all, and they
> can determine whether the guest supports virtio-1.0. Thus
> they can decide between three options
>=20
>  - Use i440fx
>  - Use q35 with placement in PCI bridge
>  - Use q35 with placement in PCIe root port
>=20
> These rules applies no matter what version of q35/i440fx
> is in use.

Yeah.. x86 also has the advantage of enough visibility that it can
reasonbly easily get mgmt layers to do stuff about it.  This is much
harder for POWER :/.

> With PPC, we're changing behaviour of the existing pseries
> machine type in a minor version. Management apps need to
> avoid creating logic that depends on a specific minor version
> because these version numbers are all changed by downstream
> distro vendors. IOW, as a comparison to x86, this change is
> akin to altering behaviour of the i440fx machine type so
> that it disables legacy mode despite still being PCI, and
> not PCIe.
>=20
> Is there any liklihood we'll ever introduce a true PCIe
> based machine type for PPC, so we get something much
> closer to x86/aarch64 machine types in terms of PCIe
> architecture ?

It doesn't really make sense to do so.  For x86 - or more strictly for
pc - the change from PCI to PCIe is a pretty fundamental system change
with affects in lots of places, which makes a whole new versioned
series of machine types a reasonable option.

For pseries - that's not really the case.  PCI under PAPR is
paravirtualized, and it always has been.  The interface we're matching
is not real hardware, but the PAPR spec and to a lesser extent the
existing PowerVM implementation of it.

[Aside: you've made a subtle but common x86-centric assumption above
 that there's only one important platform design per ISA.  There
 is a real PCIe based PPC  machine type in "pnv" (and maybe some of
 the embedded ones as well), but that's not the environment we care
 about for guests in production, since we can't use KVM with it]

What PAPR has is an odd hybrid - individual devices can be PCIe (we
have calls to access extended config space) - but the overall bus
structure is more-or-less like vanilla PCI.

I think it would be possible to kind of expose a more PCIe like
structure, but a) it would be weirdly artificial, b) it doesn't match
the PAPR interfaces very well, c) it would make our behaviour
different from PowerVM.

It would certainly be possible to better handle PCIe devices on a root
bus.  That's been on my todo someday list for ages, but I've kept
putting it off because the tangible benefits are pretty minimal.

Note that several things that I believe are now in the PCIe spec, but
really derive more from PC legacy considerations, don't apply at all
for PAPR.  e.g. there's no meaningful distinction between integrated
and slotted devices, multiple independent host bridges is routine and
doesn't require any (virtual) hardware visible domain numbers.

> > This does mean we no longer support guest kernels prior to 4.0, unless
> > they have modern virtio support backported (which some distro kernels
> > like that in RHEL7 do).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2eb0d8f70d..3cfc98ac61 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -65,6 +65,7 @@
> > =20
> >  #include "hw/pci/pci.h"
> >  #include "hw/scsi/scsi.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  #include "hw/virtio/virtio-scsi.h"
> >  #include "hw/virtio/vhost-scsi-common.h"
> > =20
> > @@ -4566,8 +4567,20 @@ static const TypeInfo spapr_machine_info =3D {
> > =20
> >  static void spapr_machine_latest_class_options(MachineClass *mc)
> >  {
> > +    /*
> > +     * Most defaults for the latest behaviour are inherited from the
> > +     * base class, but we need to override the (non ppc specific)
> > +     * default behaviour for virtio.  We can't do that from the base
> > +     * class since it doesn't have a compat_props.
> > +     */
> > +    static GlobalProperty compat[] =3D {
> > +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> > +    };
> > +
> >      mc->alias =3D "pseries";
> >      mc->is_default =3D true;
> > +
> > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> >  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
> > @@ -4607,6 +4620,9 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> >  static void spapr_machine_4_2_class_options(MachineClass *mc)
> >  {
> >      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +    static GlobalProperty compat[] =3D {
> > +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> > +    };
> > =20
> >      spapr_machine_5_0_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_le=
n);
> > @@ -4614,6 +4630,7 @@ static void spapr_machine_4_2_class_options(Machi=
neClass *mc)
> >      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >      smc->rma_limit =3D 16 * GiB;
> >      mc->nvdimm_supported =3D false;
> > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
>=20
> Regards,
> Daniel

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mln0rGgUGuXEqmuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5oN84ACgkQbDjKyiDZ
s5LVVw//cowKHuGYKDS2fglF4EGiB1MoDnD4UFd9eKnbjO2UJq+6gZlgqCgGJ1TG
uEphi+Tak5LxH4ytJumcCpqT0pDdNrbrR4XkMAVFbB1IAmMMgMrnNX0Ns+J8xXGV
+voYsgg6RfEG2DhaTBJ5qgTjLHc5bfeaayqsnJ3sZnOQ2eJLcEV06ku5EzZ4vXUi
q26iCpcxD7vJ7wS1SzhvczQDLsTfZjHA/K/fpTkfCuQXV4UUqd6aG2f8+4jfSQdx
M44DmtNajvkO1OwkDR0Xa+V+IaDU6G5ATFOssbL0F6nxlQAp+lQL277SwQIAjVIZ
SisiNyF0vdBoUIWZrt2BKAhKnFzzm0pkqHFg8NfJu1zAwezi1OZvH6TP8THtbeUY
zriRGQ4q9md4lkD+7BkD+JfjFbCrX/zFxCgVzmf5XDJ1ohnshT5cdqwZLN7dDhFf
Qe9b01cKe/AcqjcNQStuMLHKpPd/+fjqJqvy7Ouz2Z3VZR4l4+UntDbhiVzQ2t2S
KwhfoOO37yqkv/5YvLv6QRxnzXgO849OQd/SNMHycBJJRODdLeNsnJsrkwFmEQ/q
ecyGHC0dro9NgfzQfB3CcT9jyC7E5J3vAXPwqsG5/xcJDtvU+l6VfcQuHJdbjPL7
j8DCFuApZYEkY7/eRxgPIhHHY1oruYRSm+PkIHoGWMB6J7opErM=
=9T2B
-----END PGP SIGNATURE-----

--mln0rGgUGuXEqmuI--

