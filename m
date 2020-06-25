Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5225C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A47520709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CN+c/bIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A47520709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKnG-0006S3-LY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjc-0000cP-3j; Thu, 25 Jun 2020 01:47:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37111 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjX-0004Qd-FJ; Thu, 25 Jun 2020 01:47:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spv45Mw1z9sSt; Thu, 25 Jun 2020 15:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064048;
 bh=l9AL0ieEC3RcSjWyXheDAYT81J7kRiLAV823iK7iJVc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CN+c/bIaCTTrJ15e4Ix3jqW1dQDjBgGOryZoGXZRKOKV4UOPqoSDwgwPHxhug+UBb
 UxR80oge1/qYrwO40hbGmCCVfHh3yr3eOTCvkux3+vHU4qK1xXIxkQ9aEc36bVnY5P
 +Ts40c6I54sKjDaKf5PPdMOglrUhaRHZfxMI9dCY=
Date: Thu, 25 Jun 2020 15:06:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200625050600.GC172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
 <20200619144541.GM17085@umbus.fritz.box>
 <20200619150556.GW700896@redhat.com>
 <20200620082427.GP17085@umbus.fritz.box>
 <20200622090930.GB736373@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <20200622090930.GB736373@redhat.com>
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
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:09:30AM +0100, Daniel P. Berrang=E9 wrote:
> On Sat, Jun 20, 2020 at 06:24:27PM +1000, David Gibson wrote:
> > On Fri, Jun 19, 2020 at 04:05:56PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Sat, Jun 20, 2020 at 12:45:41AM +1000, David Gibson wrote:
> > > > On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrang=E9 wrot=
e:
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
> > > > > Silently changing the user's request configuration like this
> > > >=20
> > > > It doesn't, though.  register_sugar_prop() effectively registers a
> > > > default, so if the user has explicitly specified something, that wi=
ll
> > > > take precedence.
> > >=20
> > > Don't assume that the user has set "disable-legacy=3Doff". People who=
 want to
> > > have a transtional device are almost certainly pasing "-device virtio=
-blk-pci",
> > > because historical behaviour is that this is sufficient to give you a
> > > transitional device. Changing the default of disable-legacy=3Don has =
not
> > > honoured the users' requested config.
> >=20
> > Umm.. by this argument we can never change any default, ever.  But we
> > do that routinely with new machine versions.  How is changing based on
> > a machine option different from that?
>=20
> It isn't really different. Most of the time we get away with it and no one
> sees a problem. Some of the changes made though, do indeed break things,
> and libvirt tries to override QEMU's changes in defaults where they are
> especially at risk of causing breakage. The virtio device model is one su=
ch
> change I'd consider especially risky as there are clear guest OS driver
> support compatibility issues there, with it being a completely different
> PCI device ID & impl.

If it were possible to drop an existing supported guest into secure VM
mode, that would make sense.  But AFAICT, a guest always need to be
aware of the secure mode - it certainly does on POWER.  Plus, support
for secure guest mode is way newer than support for modern virtio
devices.

Even then, I don't see that this is really anything new.  Updating
machine type version can absolutely change system devices in a way
which could break guests (though it mostly won't).  If you really want
stable support for a given guest, use a versioned machine type.  Doing
that will work just as well for the secure VM stuff as for anything
else.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70MLgACgkQbDjKyiDZ
s5Iw2RAAzFgLklXkpGJ4bIgfOhUu7p7MmaRh+W7RcBuUkjtLstIv+7Vjxc+IUcBt
IrOZsvXF/fniaLCPIu2Pa9bPbVae3hZqaQqv2N4tBnFUJb/5DbADwQ0Geb91I6AS
otRcAksdD7zqbXItgaMErgdWzIDM4tHJgPClDMSUYCrnHWPa0MzP66AdVf6HGcNA
FX0kHW3G5CQ/hIDqGrKEXU2912KeDI1zVak6n0Gyuuzdjtrn4uVrLLVx1a5vV89+
nE+qmtsuT+iWVJqAq80LnsrJISUcCq6zrTzr0klq6Y7HhNxYbIT23C/RboYFtXjn
UzrIEL4SVOntcxP6kuHMl5DpFsvOWK/18mvWu7+i+pYvfh8awKuIyGz+3jtywRl0
0uT9sIDVBLYz1zHfrI9JLsrSiHy5aptc8d9zCTw+UALc6g8QDYp+OHjxZcMOEwRB
ohf4TIY0srbUx+FR7TzG+tx5tHudHvSivO1AF0oGS9WPoueoW3af4/tfCLmwc6jo
Q2rM5sVTcPMaCFh+BG5842Y+h8gzLxBSyVArMc3sW6c/QaIJu+wNrSzUWBh4FtpC
rBHw9R6d8KP78kX343duXPy4MOrMFU6OiybaSkE2Lsp0CL6zwYBREDGypKm+n+eE
q56ClWBJhhG77uGGav0T+GavIzXkWwWraS3y2v76Na1NNeHrLss=
=hMmK
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

