Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03232074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XCG37Mwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03232074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiszF-0003cd-U5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjP-0002mV-5H; Wed, 10 Jun 2020 00:52:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50683 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjN-0004eX-Uw; Wed, 10 Jun 2020 00:52:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC5NHsz9sSg; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=/5pSOXrvZ6i5E74Zn/tFWRea/OFiqAbiiHNszmV9Rds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XCG37Mwk9GwPIXcdThk9hiA/ZXT/0Rtqf2MeWRK7cE56hrnaXwdy5WyPOdTcSSfTg
 h3ELhTWOQHBn4FDaaf3+VDdlMRbHApvoJxWWbuY8Lplf9tsfnpnfyYM8bH0WYFG/vr
 WRzwluuEAbCaouIndoYaRuEnQwBcRFscpounBIeI=
Date: Wed, 10 Jun 2020 14:45:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200610044510.GJ494336@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
 <20200609121641.5b3ffa48.cohuck@redhat.com>
 <20200609174046.0a0d83b9.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <20200609174046.0a0d83b9.pasic@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 05:40:46PM +0200, Halil Pasic wrote:
> On Tue, 9 Jun 2020 12:16:41 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Sun, 7 Jun 2020 13:07:35 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote: =20
> > > > > The default behaviour for virtio devices is not to use the platfo=
rms normal
> > > > > DMA paths, but instead to use the fact that it's running in a hyp=
ervisor
> > > > > to directly access guest memory.  That doesn't work if the guest'=
s memory
> > > > > is protected from hypervisor access, such as with AMD's SEV or PO=
WER's PEF.
> > > > >=20
> > > > > So, if a guest memory protection mechanism is enabled, then apply=
 the
> > > > > iommu_platform=3Don option so it will go through normal DMA mecha=
nisms.
> > > > > Those will presumably have some way of marking memory as shared w=
ith the
> > > > > hypervisor or hardware so that DMA will work.
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---
> > > > >  hw/core/machine.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 88d699bceb..cb6580954e 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,8 @@
> > > > >  #include "hw/mem/nvdimm.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "exec/guest-memory-protection.h"
> > > > > +#include "hw/virtio/virtio.h"
> > > > > +#include "hw/virtio/virtio-pci.h"
> > > > > =20
> > > > >  GlobalProperty hw_compat_5_0[] =3D {};
> > > > >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > > > > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *=
machine)
> > > > >           * areas.
> > > > >           */
> > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abo=
rt);
> > > > > +
> > > > > +        /*
> > > > > +         * Virtio devices can't count on directly accessing guest
> > > > > +         * memory, so they need iommu_platform=3Don to use norma=
l DMA
> > > > > +         * mechanisms.  That requires disabling legacy virtio su=
pport
> > > > > +         * for virtio pci devices
> > > > > +         */
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-leg=
acy", "on");
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_pl=
atform", "on");
> > > > >      }
> > > > >   =20
> > > >=20
> > > > I think it's a reasonable way to address this overall.
> > > > As Cornelia has commented, addressing ccw as well =20
> > >=20
> > > Sure.  I was assuming somebody who actually knows ccw could do that as
> > > a follow up.
> >=20
> > FWIW, I think we could simply enable iommu_platform for protected
> > guests for ccw; no prereqs like pci's disable-legacy.
>=20
> For s390x having a memory-encryption object is not prereq for doing
> protected virtualization, so the scheme does not work for us right now.

That's basically true for POWER as well - in our case the "memory
encrypt" object (called "host trust limitation" (HTL) object in the
latest version) is basically just a dummy with no parameters.  The
same should work for s390x.

I am considering having the machine always create the HTL object with
a well-known name (e.g. "pef0"), so you can just set the machine
property to it to enable PEF.  Again, that could also be done on
s390x.

Note also that anything could in principle implement the HTL
interface.  So you could have the machine object itelf, or the cpu
implement the interface to avoid creating a dummy object, though that
might get messier that just having a dummy in the long run.

> I hope Jansoch will chime in after he is back from his vacation. IMHO
> having a memory-protection object will come in handy for migration,
> but the presence or absence of this object should be largely transparent
> to the user (and not something that needs to be explicitly managed via
> command line). AFAIU this object is in the end it is just QEMU plumbing.

Yes.  However, if either POWER or z ever gets any configurable knobs
for their protection systems, it does provide an obvious place that we
can do that configuration.

> > > > as cases where user has
> > > > specified the property manually could be worth-while. =20
> > >=20
> > > I don't really see what's to be done there.  I'm assuming that if the
> > > user specifies it, they know what they're doing - particularly with
> > > nonstandard guests there are some odd edge cases where those
> > > combinations might work, they're just not very likely.
> >=20
> > If I understood Halil correctly, devices without iommu_platform
> > apparently can crash protected guests on s390. Is that supposed to be a
> > "if it breaks, you get to keep the pieces" situation, or do we really
> > want to enforce iommu_platform?
>=20
> I strongly oppose to adopting the "if it breaks, you get to keep the
> pieces" strategy here. It is borderline acceptable on startup, although
> IMHO not preferable, but a device hotplug bringing down a guest that is
> already running userspace is not acceptable at all.
>=20
> Regards,
> Halil



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gZVYACgkQbDjKyiDZ
s5Ij7w//cdBg7Etb+XfkNEsZYjarhQpaYRLvcNsgzNwDKU4fOV4h1LFuwW7Tkikc
Nu6Z7pJbDGZdVL1tG8IMbO31gQ1CzG+xxFam8onKohU6YwjeKvtlndlgK1Mpk3Zz
9vg71viUt5HknR4LK27AVbOoUh0g7QQrCOMKSwtKHmiRpSk9wP4dhTXLYUxjNXka
tcVlYyL1NFpXvU9xCr+1FZ96DliiuthzCt9xPFaTZbvA+/IN21Yjhsex7my8Khm8
yFkzjAVs57hkxgn9hddrYEYNvRR4x2DeOQDnVO17oeHF5T+noUCFMTQIq2wANrde
gRZDCW1gRWU4M91s8FAzcs9Kz3wSOpuBjVsBGRqCK3GHcl2J6+FVJA0vr3OJGcwg
xqIgZGBDDpfaVaDgSOPRZlt6aLDVXzrmxw24J31FKO8M3gwut8UvnR8xPAjFroJP
0TpUgVRQRhsHA5NvFcdegP0eWxWoZFwNyVcaigFOPbU7lxIWNpIVa/tg2yKRTizE
sMOw9ez7MecwoHs4QeQcc1WgMNoPyCrTnV8rbWrJl1c2dZphKUl4EyN+Slf0wd8m
yd/x7oaAypSGoPg/YJVsWmBNn352M7tumBjZCnNBv6cYk7nGSctw7nfQsQcVXhCm
PmhhJdO43ntOxyUEqR5R2qjrv3LBjdPa/XUk0IyXxmOm13RHCzA=
=sFmA
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--

