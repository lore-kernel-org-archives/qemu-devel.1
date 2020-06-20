Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15871C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 08:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D641F22202
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 08:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gOKShuaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D641F22202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmYod-0005gZ-4L
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 04:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmYnz-0004wQ-EU; Sat, 20 Jun 2020 04:24:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42965 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmYnu-0007Jo-Ka; Sat, 20 Jun 2020 04:24:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49ppcj0CfPz9sRh; Sat, 20 Jun 2020 18:24:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592641477;
 bh=W38gQ8kAX055GFm1vlm4XFMgXT6TAso2CKHgAagLEDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gOKShuaDtZTlQUv5OT6rfvdnBWF/EcOzPzNOVllcLC3My5sM3/tLrGX1WsFdSUblR
 LmQ2ZJtF27ciH3tx3oKHEPpx3m9GaG9lgXD9i+0Ddcaf9Pg2mHWnbpc5M8e/2DVzh7
 wAGixsJmMv3w67MtBbz43+mwFBjYpX3J+VOx/QOc=
Date: Sat, 20 Jun 2020 18:24:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200620082427.GP17085@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
 <20200619144541.GM17085@umbus.fritz.box>
 <20200619150556.GW700896@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ftQmbtOmUf2cr8rB"
Content-Disposition: inline
In-Reply-To: <20200619150556.GW700896@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 04:24:37
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


--ftQmbtOmUf2cr8rB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 04:05:56PM +0100, Daniel P. Berrang=E9 wrote:
> On Sat, Jun 20, 2020 at 12:45:41AM +1000, David Gibson wrote:
> > On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > > > The default behaviour for virtio devices is not to use the platform=
s normal
> > > > DMA paths, but instead to use the fact that it's running in a hyper=
visor
> > > > to directly access guest memory.  That doesn't work if the guest's =
memory
> > > > is protected from hypervisor access, such as with AMD's SEV or POWE=
R's PEF.
> > > >=20
> > > > So, if a host trust limitation mechanism is enabled, then apply the
> > > > iommu_platform=3Don option so it will go through normal DMA mechani=
sms.
> > > > Those will presumably have some way of marking memory as shared wit=
h the
> > > > hypervisor or hardware so that DMA will work.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > > >  hw/core/machine.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >=20
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index a71792bc16..8dfc1bb3f8 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -28,6 +28,8 @@
> > > >  #include "hw/mem/nvdimm.h"
> > > >  #include "migration/vmstate.h"
> > > >  #include "exec/host-trust-limitation.h"
> > > > +#include "hw/virtio/virtio.h"
> > > > +#include "hw/virtio/virtio-pci.h"
> > > > =20
> > > >  GlobalProperty hw_compat_5_0[] =3D {
> > > >      { "virtio-balloon-device", "page-poison", "false" },
> > > > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *ma=
chine)
> > > >           * areas.
> > > >           */
> > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abort=
);
> > > > +
> > > > +        /*
> > > > +         * Virtio devices can't count on directly accessing guest
> > > > +         * memory, so they need iommu_platform=3Don to use normal =
DMA
> > > > +         * mechanisms.  That requires disabling legacy virtio supp=
ort
> > > > +         * for virtio pci devices
> > > > +         */
> > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legac=
y", "on");
> > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_plat=
form", "on");
> > > >      }
> > >=20
> > > Silently changing the user's request configuration like this
> >=20
> > It doesn't, though.  register_sugar_prop() effectively registers a
> > default, so if the user has explicitly specified something, that will
> > take precedence.
>=20
> Don't assume that the user has set "disable-legacy=3Doff". People who wan=
t to
> have a transtional device are almost certainly pasing "-device virtio-blk=
-pci",
> because historical behaviour is that this is sufficient to give you a
> transitional device. Changing the default of disable-legacy=3Don has not
> honoured the users' requested config.

Umm.. by this argument we can never change any default, ever.  But we
do that routinely with new machine versions.  How is changing based on
a machine option different from that?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ftQmbtOmUf2cr8rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7tx7sACgkQbDjKyiDZ
s5Lk1Q/9EyZXMK2UB/lzd6fAojOLADfFhZxOt+1U1YObtM8o8pRBIcXCzGtvzgHU
533geSroEFIm+4Y8Mq41KigHqV95a5roJE+UpfZ/AJkB/VZyOiEtr4oFubj+a3OW
zTk4pwCfEq7dtrK/UVJbBeebDuKioGX5mhMXBbbsHPDUITNDb++FjT2dMLG2aiOF
HOtzzc1lFkZnEAnUf8rHcsulFeihNG50qARa5BxPlcRFvuOWFperm8SGCxYbHuRv
cjHOQCRBw4HTSO3kz8TKo6uK1OB3jw9XuSRsmmczPDiwJvpFrJ9BHF4e45e+9xjy
A19ESEqV0fTfr67YxTinyLeiXHxvJXPPr1ASV0lTif0rpVqbfshf7jW66LqHo0Ss
cCxXOkgiyQEwGEhmcUzoQ/nGonhvz/i1zKR1xoApjK6DfbuW102ojdxesxMNyEM1
Rp2xy2b2Et0cuiIFVOZwG+5KkeQ9VHIgnlrYPA2hQNoas3hSzYa+8V7cqo/ELd+3
eccQaHAR0nNEsV/Fk5ppJ+VSPmjLVvB4rff0xv/m9e+z2GFJdFfV58vNTV/d5l4P
t3Mdm0gCP27shb7jZm3eQHzQLcqUGoUOUppTALP1E4lQSlCF/cKigUjmyvzOMmc8
ZIfbz0dxlSqQIhiJF/SPCic83D6Hg9ucyoEPmuRUkHpLIfMEvCM=
=GaO6
-----END PGP SIGNATURE-----

--ftQmbtOmUf2cr8rB--

