Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A330620709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DnvTWNzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A330620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKoP-00007j-U4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjb-0000cM-Ug; Thu, 25 Jun 2020 01:47:39 -0400
Received: from ozlabs.org ([203.11.71.1]:46425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjX-0004QS-FL; Thu, 25 Jun 2020 01:47:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spv43hF1z9sSJ; Thu, 25 Jun 2020 15:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064048;
 bh=zgpo/Uarv4ptzF6ccXY6E68/qcnS5o3Z06+YqXK19gg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DnvTWNzLu7P4Mwg5ZZEy70Pu4p3n+Q4kiHzoOuzuQwysrt2NCPy6VpMqjr30wsj1w
 xUiWled4956Y10mafjuM/Vt0iTuKi8a/Yx94z99ZBKrkrWfFRk2yPEfovUo+/U/KyB
 NhXg5BxPZAATvcMNftE5Qin/x9YcymQmqiWaWSnI=
Date: Thu, 25 Jun 2020 14:57:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200625045738.GA172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
 <20200619074432-mutt-send-email-mst@kernel.org>
 <20200619074630-mutt-send-email-mst@kernel.org>
 <20200619121638.GK700896@redhat.com>
 <20200624034932-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200624034932-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:09:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 03:55:59AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jun 19, 2020 at 01:16:38PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jun 19, 2020 at 07:47:20AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jun 19, 2020 at 07:46:14AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrang=C3=83=
=C6=92=C3=82=C2=A9 wrote:
> > > > > On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > > > > > The default behaviour for virtio devices is not to use the plat=
forms normal
> > > > > > DMA paths, but instead to use the fact that it's running in a h=
ypervisor
> > > > > > to directly access guest memory.  That doesn't work if the gues=
t's memory
> > > > > > is protected from hypervisor access, such as with AMD's SEV or =
POWER's PEF.
> > > > > >=20
> > > > > > So, if a host trust limitation mechanism is enabled, then apply=
 the
> > > > > > iommu_platform=3Don option so it will go through normal DMA mec=
hanisms.
> > > > > > Those will presumably have some way of marking memory as shared=
 with the
> > > > > > hypervisor or hardware so that DMA will work.
> > > > > >=20
> > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > ---
> > > > > >  hw/core/machine.c | 11 +++++++++++
> > > > > >  1 file changed, 11 insertions(+)
> > > > > >=20
> > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > index a71792bc16..8dfc1bb3f8 100644
> > > > > > --- a/hw/core/machine.c
> > > > > > +++ b/hw/core/machine.c
> > > > > > @@ -28,6 +28,8 @@
> > > > > >  #include "hw/mem/nvdimm.h"
> > > > > >  #include "migration/vmstate.h"
> > > > > >  #include "exec/host-trust-limitation.h"
> > > > > > +#include "hw/virtio/virtio.h"
> > > > > > +#include "hw/virtio/virtio-pci.h"
> > > > > > =20
> > > > > >  GlobalProperty hw_compat_5_0[] =3D {
> > > > > >      { "virtio-balloon-device", "page-poison", "false" },
> > > > > > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState=
 *machine)
> > > > > >           * areas.
> > > > > >           */
> > > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_a=
bort);
> > > > > > +
> > > > > > +        /*
> > > > > > +         * Virtio devices can't count on directly accessing gu=
est
> > > > > > +         * memory, so they need iommu_platform=3Don to use nor=
mal DMA
> > > > > > +         * mechanisms.  That requires disabling legacy virtio =
support
> > > > > > +         * for virtio pci devices
> > > > > > +         */
> > > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-l=
egacy", "on");
> > > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_=
platform", "on");
> > > > > >      }
> > > > >=20
> > > > > Silently changing the user's request configuration like this is a=
 bad idea.
> > > > > The "disable-legacy" option in particular is undesirable as that =
switches
> > > > > the device to virtio-1.0 only mode, which exposes a different PCI=
 ID to
> > > > > the guest.
> > > > >=20
> > > > > If some options are incompatible with encryption, then we should =
raise a
> > > > > fatal error at startup, so applications/admins are aware that the=
ir requested
> > > > > config is broken.
> > > >
> > > > Agreed - my suggestion is an on/off/auto property, auto value
> > > > changes automatically, on/off is validated.
> > >=20
> > > In fact should we extend all bit properties to allow an auto value?
> >=20
> > If "auto" was made the default that creates a similar headache, as to
> > preserve existing configuration semantics we expose to apps, libvirt
> > would need to find all the properties changed to use "auto" and manually
> > set them back to on/off explicitly.
> >=20
> > Regards,
> > Daniel
>=20
> It's QEMU's job to try and have more or less consistent semantics across
> versions. QEMU does not guarantee not to change any option defaults
> though.
>=20
> My point is to add ability to differentiate between property values
> set by user and ones set by machine type for compatibility.

At which point are you looking to differentiate these?  The use of
sugar_prop() in my draft code accomplishes this already for the
purposes of resolving a final property value within qemu (an explicit
user set one takes precedence).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70LsAACgkQbDjKyiDZ
s5L3ExAAxnFj1Oy2Vrk0tvlc4e5RkcOJmfFGJx7VpnNMS45oSrpNromPMAvVS86m
lQKtHv7x8qYxsusrq5IRCnaGdjC5QqPOP6AeQ2GqF+rh81ZZA+FAht92vIw+iDDT
OsHgjvEEAeauu4VOymzjycOslQyFy6rLHvMcDTp2ladqF9yopsxKfAbT3X2o53tV
bgKydBr9UyiKJKz/PkQV6rklhg5+ModFjSQnbVZxvN4rZsn8mA+LtybBTM0PuWdQ
acx4xCknEb01bseb5l+k4pNFptngykUFj6j0VYHHTZlDcI07X/4W4NMRGLanFW/1
tNp9HCkcFRA9FLAd0+qgBB0rO2bInu7tMqs2Dk244hcFbb0YqbkzO4BjhkSIoYvq
JrJZKEecQ80NQO+kYxc7XqP/WQy68MVRzL0NazeNBNc2+UUHOH2+6Dzp5ytQowj7
oqAml1I/4wXe/rXe8ODAUjNufJZhKCpkc9mg3h4KYLXP+inbPeRP9vvJ9k6///SZ
nfg9VzvvjYaQxjMRR74wHyft82oOL/KKjLsgm9hib+gccbjn5tNhPDhYc5j+Xmwg
95lywChej9zAbU48cIO9j7OY1feijnwzGf1HyNWI/0QrBZREPv+tQFJx2JJpt7Gy
xX9Xe+uMsqcXkyI32bDJQfqO6x5pO+JIT03vqyMseg9ZvhNi4lc=
=f4oi
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

