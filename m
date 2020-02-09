Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF8C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 12:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16415207FF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 12:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NGNbP6Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16415207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0lb7-0004vy-7f
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 07:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j0la8-0003uf-NJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 07:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j0la7-00024a-7Y
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 07:21:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44311 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j0la6-0001tJ-2v; Sun, 09 Feb 2020 07:20:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Fp652Ynbz9sPK; Sun,  9 Feb 2020 23:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581250845;
 bh=gdWbNbJOWZSM4q+Qt/2gRLQwjuI/l7bmTTxRYP6IF9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NGNbP6Vz0gCwLOArrawJkiVikq3tYulWElx4gWvW89aNIQ2ZFtvj7lGGG2itxTbxs
 LH9xim4t+SbbfyfzjQp93GxmO7d5CMRApDdIgE8J9skU5U2XHHxnKQMGpqnHOp+Z37
 LmPo0FYuS9foQe6+7nzbSfEG3cfV4qeZ4p1EDYAU=
Date: Sun, 9 Feb 2020 16:27:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0
 and later
Message-ID: <20200209052744.GA1704@umbus.fritz.box>
References: <20200207043055.218856-1-david@gibson.dropbear.id.au>
 <20200207043055.218856-2-david@gibson.dropbear.id.au>
 <20200207013757-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200207013757-mutt-send-email-mst@kernel.org>
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
Cc: pair@us.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 01:54:26AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 03:30:54PM +1100, David Gibson wrote:
> > PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> > the guess mostly like classic PCI, even if some of the individual
> > devices on the bus are PCI Express.  One consequence of that is that
> > virtio-pci devices still default to being in transitional mode, though
> > legacy mode is now disabled by default on current q35 x86 machine
> > types.
> >=20
> > Legacy mode virtio devices aren't really necessary any more, and are
> > causing some problems for future changes.  Therefore, for the
> > pseries-5.0 machine type (and onwards), switch to modern-only
> > virtio-pci devices by default.
>=20
> It's worth noting in the commit log that this disables support
> for guests older than Linux 4.0.

Oof.  That's more recent than I'd guessed.  I'll have to do some
checking to see if that's reasonable.

>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c9b2e0a5e0..216d3b34dc 100644
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
> > @@ -4512,7 +4513,14 @@ static const TypeInfo spapr_machine_info =3D {
> >   */
> >  static void spapr_machine_5_0_class_options(MachineClass *mc)
> >  {
> > -    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +    /* Most defaults for the latest behaviour are inherited from the
> > +     * base class, but we need to override the (non ppc specific)
> > +     * default behaviour for virtio */
> > +    static GlobalProperty compat[] =3D {
> > +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> > +    };
> > +
> > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>=20
> So this sets the defaults, right?
>=20
> Problem is we'll then need to remember to carry this in the latest
> call. If we forget we get a mess.
>=20
> How about adding a call to e.g. spapr_machine_latest_class_options
> in DEFINE_SPAPR_MACHINE?
> Then spapr_machine_latest_class_options can set the per-machine
> defaults.
>=20
> I send a patch for this:
> 	[PATCH] ppc: function to setup latest class options
> feel free to reuse.

Good idea, thanks.  I've merged that and will rebase these changes on it.
>=20
>=20
> > @@ -4523,11 +4531,15 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
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
> >      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4/mE0ACgkQbDjKyiDZ
s5LKUA//Yw/aeByKtNdRNgFl/oQL1hK7LQPYvKyLwCDsMeXwhUroWcizqnmR9jPM
m/4lpvcnCGT/oFgU1ZkLu8orJM6Fse+XISD/tyuDqdmeHOkjqGEEmSNtHCC91HFf
mquNblE9pLwQ6ynW40GJ9URaIJ+BqudMa8FvpOvCdGyXE5mJn/OBdcd+z0UE67O3
Ppdq+mhNu7XryIToZgk+Xu7zxKBkx8jugs/4Xia3GsOGJGYldF6g4AesHX6SMZnx
KECuCKHNiEjOZfkvD2qbRZN4BBd+dnq0PEX5ZVOt2GzREIiVm+jNLvForM3lYAIj
wjKQrF+fe+CcvB30kMqOrAwmLJw6JPfoJGMTb8BpjLibnmX0kJRV4coVSi1RbfcR
I34mr7iVyhd0N2DZSO/xq/rnrDxuCmzzeFaV8rJyODDB8/xYhmrvCnH1KO8LHIlX
bAyNn/lIxcHfFUnPnStu8pNxKrBIpyVrIdhFzWUhLMamzm1b7ZdXXUqXMCWbd7aG
Y0b3wWr6Eet2/n+UIkVeO0ob9rbS4NdpvFIY/C7Ur4/AlzmFkcFVkct+SJ6S2/yc
WfwyBZtC1BZBrkoV58yMUJ5d1t9npSsF9k7qHvzq0FisSm48zQH8GSxzEwTewA/A
aK3L6rl9c2l1qULAI4mple4X8Ufa4h6WTnj6jingICECgldh//0=
=S6De
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

