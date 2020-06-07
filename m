Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE6C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 03:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CDA2076D
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 03:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d4OhZP2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CDA2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhlsr-0004R0-GA
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 23:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhlsG-0003tm-18; Sat, 06 Jun 2020 23:21:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54873 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhlsD-0004De-8R; Sat, 06 Jun 2020 23:21:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49fhVl42Z1z9sSf; Sun,  7 Jun 2020 13:21:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591500079;
 bh=sjxcB2ZCXQs3QAHxQ+jllLLgJ3Mg6gEnyr8XxHJVoes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d4OhZP2gompTbni7TJSU3GiP+7lrPUYcdefp9fn4Et0l/jj1HhNx9vOSU7wCR1QCQ
 aDwnLMbB0d6RWdcoijAIMSqv/aNGeR+pBY9eFBfYRdPsixtF/OgF056S7AYyS8jNLA
 B83auEeeC1HOkUUuCLT7w2XjNHjqGBlTaK40BNik=
Date: Sun, 7 Jun 2020 13:07:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200607030735.GN228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Content-Disposition: inline
In-Reply-To: <20200606162014-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 23:21:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 kvm@vger.kernel.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote:
> > The default behaviour for virtio devices is not to use the platforms no=
rmal
> > DMA paths, but instead to use the fact that it's running in a hypervisor
> > to directly access guest memory.  That doesn't work if the guest's memo=
ry
> > is protected from hypervisor access, such as with AMD's SEV or POWER's =
PEF.
> >=20
> > So, if a guest memory protection mechanism is enabled, then apply the
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
> > index 88d699bceb..cb6580954e 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -28,6 +28,8 @@
> >  #include "hw/mem/nvdimm.h"
> >  #include "migration/vmstate.h"
> >  #include "exec/guest-memory-protection.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-pci.h"
> > =20
> >  GlobalProperty hw_compat_5_0[] =3D {};
> >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *machin=
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
>=20
> I think it's a reasonable way to address this overall.
> As Cornelia has commented, addressing ccw as well

Sure.  I was assuming somebody who actually knows ccw could do that as
a follow up.

> as cases where user has
> specified the property manually could be worth-while.

I don't really see what's to be done there.  I'm assuming that if the
user specifies it, they know what they're doing - particularly with
nonstandard guests there are some odd edge cases where those
combinations might work, they're just not very likely.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7cWeoACgkQbDjKyiDZ
s5KsURAAhiR6V12OFx0b5uCHQEi27xZICTkD74JVTRf00hH+bj7Lt2QZP4u1E/LX
Bdrz2en9NcEm0c58y/ksosrzrq1stDpcepqJT27EES8GfNJ+O0b/4OA4w3EglxC4
xrs6P7zlihJBf7X5jTRRbdwz7pmvismuPewerVGfcBBtQYWNnKko/6DHMYVi4Zqg
W4YdWv0uhEUGI2uxQvU5II6Bo5sUiQlr6AyecP6i+uG0+0zMfjMDnz8WL+IlaOfJ
+4KW1qqa2tTRUfz0XpXZNETTyjQJT2wuUFcc7n7bTQGHvtFrRu4snDzHX63fSlpP
F//JMD6X0rtMXsGCD0wRHZoljBOUXCF17+hF4w3+aQXdw4g+H93RYZlslV2L9IQE
TS35iCtGka8cRUPHxPhMT1hnQUInHTqFEW+bUqonhZZpx8iiZosoLeryrvKVEaUn
AQY6UJty6NN+vaGbBDAQK5mnO1eFuiyB7SItwTguH0yqy4J1hsxo1/XNUPLpk1i5
T7PgRcRGpA3hQefM8yhPlKTtRVoX+fpzeN9MOqE9a4PSaGN8OAKoX1ylvdTEv7IK
IEd/I54C0BrwFoQxnQJ8ciEsuZAC0j8IqYoEwvb3FXh59OvWwO06+QFJaJXwuQ1c
l30E6wGpXz0boBr+cIFc/8QFQjKS1paMBBbI52dmvaUlBppRG8k=
=XDyW
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--

