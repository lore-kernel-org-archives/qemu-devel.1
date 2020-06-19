Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F86FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503BB2193E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C6DS+ar7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503BB2193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIWs-0002cA-H6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmIVL-0001F2-12; Fri, 19 Jun 2020 11:00:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmIVF-00058t-7P; Fri, 19 Jun 2020 11:00:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49pMRh15XWz9sjF; Sat, 20 Jun 2020 01:00:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592578816;
 bh=i09Pzm3J+sHg0qnWmU6RuDXb6mWa9G7DYcrmVm6UoBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C6DS+ar7jPslhN9O0WwbEn1ayt+r6wlNcnguyJVycjvA5RqxBcPyHXrPAmuv283x2
 HMcCuAogsKUMm1OQef7TBRlAzqp1jMAX1H0enKcgbCEt9Nnq3gvhza6kiuJxSYeEV7
 8tRtC/a22PQL23JdgPLKG8qPZoppbekkiRRRz1vg=
Date: Sat, 20 Jun 2020 00:45:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200619144541.GM17085@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline
In-Reply-To: <20200619101245.GC700896@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > The default behaviour for virtio devices is not to use the platforms no=
rmal
> > DMA paths, but instead to use the fact that it's running in a hypervisor
> > to directly access guest memory.  That doesn't work if the guest's memo=
ry
> > is protected from hypervisor access, such as with AMD's SEV or POWER's =
PEF.
> >=20
> > So, if a host trust limitation mechanism is enabled, then apply the
> > iommu_platform=3Don option so it will go through normal DMA mechanisms.
> > Those will presumably have some way of marking memory as shared with the
> > hypervisor or hardware so that DMA will work.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/core/machine.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index a71792bc16..8dfc1bb3f8 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -28,6 +28,8 @@
> >  #include "hw/mem/nvdimm.h"
> >  #include "migration/vmstate.h"
> >  #include "exec/host-trust-limitation.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-pci.h"
> > =20
> >  GlobalProperty hw_compat_5_0[] =3D {
> >      { "virtio-balloon-device", "page-poison", "false" },
> > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *machin=
e)
> >           * areas.
> >           */
> >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > +
> > +        /*
> > +         * Virtio devices can't count on directly accessing guest
> > +         * memory, so they need iommu_platform=3Don to use normal DMA
> > +         * mechanisms.  That requires disabling legacy virtio support
> > +         * for virtio pci devices
> > +         */
> > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", =
"on");
> > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform=
", "on");
> >      }
>=20
> Silently changing the user's request configuration like this

It doesn't, though.  register_sugar_prop() effectively registers a
default, so if the user has explicitly specified something, that will
take precedence.

> is a bad idea.
> The "disable-legacy" option in particular is undesirable as that switches
> the device to virtio-1.0 only mode, which exposes a different PCI ID to
> the guest.
>=20
> If some options are incompatible with encryption, then we should raise a
> fatal error at startup, so applications/admins are aware that their reque=
sted
> config is broken.
>=20
> Regards,
> Daniel

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sz5IACgkQbDjKyiDZ
s5J+8w/+JJK7plk6WUNFDCN0inRibIaHRp7R6OpBirGdfBHRI1bEAYrmm7cOnjhR
LQ67An6wmLV4QB7P+Kt7Ud1ppfskhG5Uz9xEmuFGS/fNycr3KXZ4q4OddDW7mI2/
PADqa5j+AaqWFh+hnw/Zux6jYUGi52aqFJfh6iluGZ2Be3sD17YFKpA/yytBecWH
dU8rFFovc4YOSHyjJEsMENtQ80qKTTObootZeTRqKQavrBQnfQ8W7GejOanVI5k9
xez40IKMLN1FNzKt0HwBIJVClQrOYXDhoY1ia3gATv1GJ/IT+3ARH3I+qfp9rPLm
8JyPaBgMzVv2sbRguF7nGblW58pnv4RqK9XuSpWMKfmIMtV0fm1B4R1cTwcDeaDW
R9aGfdUIolZKUIRwlbkPhjialYbOBgJ13BgIZrlvHl4PGR6ZSvoHHyjdrtfk2aYD
Uz/sq915JnDTHt2T1Y/I9I38Xu7HR7RAGUhSyG08kihRxBBVYqoeUldHmoOnyt3S
br6yo5JX9LjceRJR2VaGnY8yuKXMyXNEKLLQJF1qBqzzJfrpNH4UkzDFlaj8X9IA
/VCoiB2npTzwRCgTqNgxnCl//60s7oLx/KaEHvuB6iE4b9IZKrvWUcZADxXctxMn
lWwvRa5r5rMiB1sx0cBJS/MeqhDlB0BX4EXlEerznh86A3KMQrg=
=LRIe
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--

