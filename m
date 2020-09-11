Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E37C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 02:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335E7206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 02:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cVpjOr9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335E7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGYRk-0005Fs-VO
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 22:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGYQt-0004h3-Dw; Thu, 10 Sep 2020 22:04:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGYQp-0004qk-Qk; Thu, 10 Sep 2020 22:04:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BnfG760H0z9sVD; Fri, 11 Sep 2020 12:04:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599789887;
 bh=UEYW9bd4ufUoKe/6L46GU0olcLvQXPJyyqz3qnQQFNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cVpjOr9dW+lEJbnJyXROtSVk6K90ja5dYhsNlxXkr25fkWIBhb3eK+cyM0bvViP7x
 RjDeXE76qlwn1hy5O8l4Pr/oHOuPQh00ARQKCsuH05baiiNKNlwHAFsw5nzHx85sp4
 DsGQAfm3QlzcBGtVtp8mioEtWi7TVseOeRDsiOuU=
Date: Fri, 11 Sep 2020 12:04:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [for-5.2 v4 09/10] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200911020442.GH66834@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-10-david@gibson.dropbear.id.au>
 <20200907171046.18211111.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <20200907171046.18211111.pasic@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: pair@us.ibm.com, Cornelia Huck <cohuck@redhat.com>, brijesh.singh@amd.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Bjoern Walk <bwalk@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2020 at 05:10:46PM +0200, Halil Pasic wrote:
> On Fri, 24 Jul 2020 12:57:43 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
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
>=20
> Sorry for being this late. I had to do some high priority debugging,
> which made me drop everything else, and after that I had some vacation.
>=20
> I have some questions about the bigger picture. The promised benefit of
> this patch for users that invoke QEMU manually is relatively clear: it
> alters the default value of some virtio properties, so that using the
> defaults does not result in a bugous configuration.

Right.

> This comes at a price. I used to think of device property default values
> like this. If I don't specify it and I use the default machine, I will
> effectively get the the default value of of the property (as reported by
> qemu -device dev-name,?). If I use a compat machine, then I will get the
> compatibility default value: i.e. the what is reported as the default
> value, if I invoke the binary whose default machine is my compat machine.

Hm, ok.  My mental model has always been that defaults were
essentially per-machine-type.  Which, I grant you isn't really
consistent with the existence of the -device dev,? probing.  On the
other hand, it's possible for a machine/platforms to impose
restrictions on almost any property of almost any device, and it would
suck for the user to have to know all of them just in order to start
things up with default options.

Given that model, extending that to per-machine-variant, including
machine options like htl seemed natural.

> With this patch, that reasoning is not valid any more. Did we do
> something like this before, or is this the first time we introduce this
> complication?

I don't know off hand if we have per-machine differences for certain
options in practice, or only in theory.

> In any case, I suppose, this change needs a documentation update, which I
> could not find in the series.

Uh.. fair enough.. I just need to figure out where.

> How are things supposed to pan out when QEMU is used with management
> software?
>=20
> I was told that libvirt's policy is to be explicit and not let QEMU use
> defaults. But this policy does not seem to apply to iommu_platform -- at
> least not on s390x. Why is this? Is this likely to change in the future?

Ugh.. so.  That policy of libvirt's is very double edged.  It's there
because it allows libvirt to create consistent machines that can be
migrated properly and so forth.  However, it basically locks libvirt
into having to know about every option of qemu, ever.  Unsurprisingly
there are some gaps, hence things like this.

Unfortunately that can't be fixed without substantially redesigning
libvirt in a way that can't maintain compatibility.

> Furthermore, the libvirt documentation is IMHO not that great when it
> comes to iommu_platform. All I've found is=20
>=20
> """
> Virtio-related options
>=20
>=20
> QEMU's virtio devices have some attributes related to the virtio transpor=
t under the driver element: The iommu attribute enables the use of emulated=
 IOMMU by the device.=20
> """
>=20
> which:
> * Is not explicit about the default, but suggests that default is off
>   (because it needs to be enabled), which would reflect the current state
>   of affairs (without this patch).
> * Makes me wonder, to what extent does the libvirt concept correspond
>   to the virtio semantics of _F_ACCESS_PLATFORM. I.e. we don't really
>   do any IOMMU emulation with virtio-ccw.
>=20
> I guess host trust limitation is something that is to be expressed in
> libvirt, or? Do we have a design for that?

Yeah, I guess we'd need to.  See "having to know about every option"
above :/.  No, I haven't thought about a design for that.

> I was also reflecting on how does this patch compare to on/off/auto, but
> this email is already too long, so decided keep my thoughts for myself
> -- for now.

on/off/auto works for your case on s390, but I don't think it works
for POWER, though I forget the details, so maybe I'm wrong about that.


>=20
> Regards,
> Halil
>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/core/machine.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index b599b0ba65..2a723bf07b 100644
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
> > @@ -1161,6 +1163,15 @@ void machine_run_board_init(MachineState *machin=
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
> > =20
> >      machine_class->init(machine);
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9a2zgACgkQbDjKyiDZ
s5LUWQ/+JAEQF1QbBjie/H5DePAHcxyz0RicZ/ylbFd9VrPJxg4Xtmjb5SEZZNLu
HelpPexAlX58cpxwyCdRYcBEKlaxowOXsxcPoQ33wwXaksLNuneyi+fB3QuE6y51
VMm3xwieIun9oBWsNZZ4Bfl0uvsZlxAozqFAekcqpJKWwo4egSTAfkIfXWyC2ayd
XRBTPucT60ZrJ34eMKD2r9eSTjjHo/hL1/pTheRnBVaJuz6HxiCV+qkGueqhWkTQ
SfYD6iTcezjZ9Rk46KBSjv1dgQgWSIfv9sXuobuumvmDTJkGucOkQOJu3tOXn1ib
bOpSsjdY+p4X18QynQcJV51VbltL2Oi3dzo0X2JbdrB1QBdldZXlEl7PeRzTDXzD
cB07l0EYKHX7ylAj902/5w+H0D+vgWDzaygxA0GqdeRS678HW7NyW+oRJ+TaS/os
Q/VWrEyeczGqMFT3O9nLosBTTIzc7Pv8yo25QJOSAwNYgJZUSdeGfjszg4w7PTgQ
Kbn6iN6NSYwTFumlmr5ncE9RK6QmqIgIkF34Of9zkvNmsDgxAGPPuRao94oQSzQO
fOhXuZzNMWYu/3BkyIUv3YrmeFABpvQDD9naN4sRWRfbgyuujdAljudRn8mkEY1s
KTI7N3VfJ0kQ5p79OD5wY/GCC7jhShEXq9K69ANiDW6Z5DaabNU=
=rqX/
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

