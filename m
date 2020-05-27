Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F2CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 03:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731692073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 03:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="chNlic/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731692073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdmZi-0003wT-H1
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 23:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdmYY-00029T-AO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 23:16:38 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35057 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdmYR-00009q-BT
 for qemu-devel@nongnu.org; Tue, 26 May 2020 23:16:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49Www43K9dz9sSW; Wed, 27 May 2020 13:16:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590549380;
 bh=D1n5U/uC5esw8SdPJg7fZimoG4KzZoxD/ZWxwU6H7+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=chNlic/bscqzy5azmhkZYeis0Lq7m339Agw5NhXKVitW+cAn+V262G/Ipn0fu1ezv
 AgiMpqyuY7ICo6i7QEABTvPCV5UhAGe7qU2FN2mrO7Uvs+79Z9KzJyQqEXxjgpWg66
 WrROP7chT3DuAGOY7wUp2ZQlOYqFAnmssoScKfAU=
Date: Wed, 27 May 2020 10:42:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RESEND PATCH 1/1] vfio/nvlink: Remove exec permission to avoid
 SELinux AVCs
Message-ID: <20200527004245.GH23110@umbus.fritz.box>
References: <8f5ae1658103b71b09555d3ab499edaf3f36a15d.camel@gmail.com>
 <20200526144343.7c6c6def@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <20200526144343.7c6c6def@x1.home>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Leonardo Bras <leobras.c@gmail.com>,
 qemu-devel@nongnu.org, dgibson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2020 at 02:43:43PM -0600, Alex Williamson wrote:
> On Mon, 18 May 2020 12:05:24 -0300
> Leonardo Bras <leobras.c@gmail.com> wrote:
>=20
> > If SELinux is setup without 'execmem' permission for qemu, all mmap
> > with (PROT_WRITE | PROT_EXEC) will fail and print a warning in
> > SELinux log.
> >=20
> > If "nvlink2-mr" memory allocation fails (fist diff), it will cause
> > guest NUMA nodes to not be correctly configured (V100 memory will
> > not be visible for guest, nor its NUMA nodes).
> >=20
> > Not having 'execmem' permission is intesting for virtual machines to
> > avoid buffer-overflow based attacks, and it's adopted in distros
> > like RHEL.
> >=20
> > So, removing the PROT_EXEC flag seems the right thing to do.
> >=20
> > Browsing some other code that mmaps memory for usage with
> > memory_region_init_ram_device_ptr, I could notice it's usual to
> > not have PROT_EXEC (only PROT_READ | PROT_WRITE), so it should be
> > no problem around this.
> >=20
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > ---
>=20
> Seems David Gibson might be in a position to send a pull request
> including this before I can, so:

Merged to ppc-for-5.1, thanks.

>=20
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>=20
>=20
> > - Alexey's review is here: https://lists.nongnu.org/archive/html/qemu-d=
evel/2020-05/msg00006.html
> >=20
> >  hw/vfio/pci-quirks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 2d348f8237..124d4f57e1 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -1620,7 +1620,7 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *=
vdev, Error **errp)
> >      }
> >      cap =3D (void *) hdr;
> > =20
> > -    p =3D mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> > +    p =3D mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE,
> >               MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
> >      if (p =3D=3D MAP_FAILED) {
> >          ret =3D -errno;
> > @@ -1680,7 +1680,7 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Er=
ror **errp)
> > =20
> >      /* Some NVLink bridges may not have assigned ATSD */
> >      if (atsdreg->size) {
> > -        p =3D mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_=
EXEC,
> > +        p =3D mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE,
> >                   MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
> >          if (p =3D=3D MAP_FAILED) {
> >              ret =3D -errno;
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7Nt4UACgkQbDjKyiDZ
s5K5FQ/+PEPCEEluXbvtnu9yaA6bQ43d1BXg9LekD4WBlgMQgdaj4DAT6MWhUKcA
8085DI46QLEc2qeW+DjVkS7N2Sf+x4PcvikjXvmaT6nnL1WVGDeiQvXJZPnqAfIX
EWlrY6NtBYGUtnthOHgtIbpethzXf3FN/79AnQ+RbPDMiWTgkl0uLLlKGyHmjcZU
osyDyHGMUFYRYurOHKYc6gyT+QGWmRmQab4sq3uXUClslHoOLj7WPRlUZZTWlDrc
tEMLGc/AsI88aWSY8EqZuI3GTwdF40X+0ueCWk534v6Y9nwFivoC9OJZT7+UcO4j
+piOU/ZWciPEYbl56PSa0UugnY5dJtVD/Q+3lYKlY6vj9bz1ipY92lnpeFP8INdE
JP6FPizsfRSsGixI+VS+3o3Z0wkzPE6spBv28xuYuJQny2CjpjTKOFdJg74jQXWm
wfVB/m3uW3SzFWDjKCynx631jFrQWmK+3vPneuumvtEa4MIZtMacImVgrV5zmtjK
JJm3E/Wn43fgH7Kjz8Sd4jHNHB2D3d26vEe9GDrHm3rSy8IoijrWcDWDi3HQR+DF
3IfWs/6z2AdSX6swnx/GfjBXpGL7s/u4z2Wr9cguNsbK+HEquEZGD/Fxwxp1JpV9
ygmXCYxdG92TQJn4ELoDh9zsQqgedERYzByEbYt1DABnrIzWjyo=
=f9KY
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--

