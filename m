Received: from eggs.gnu.org ([2001:4830:134:3::10]:37002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkvJU-0000Ho-PT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkvJQ-0004gp-LP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkvJQ-0004fz-Bk
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:48:56 -0400
References: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <104369c1-ccfd-bfda-5d1e-97e8e874f45d@redhat.com>
Date: Thu, 24 Aug 2017 11:48:53 -0500
MIME-Version: 1.0
In-Reply-To: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5vTwFINBbP8M4soUtvRwQCvrxON4v3FIq"
Subject: Re: [Qemu-devel] [Bug 1712818] [NEW] live migration with storage
 encounter assert(!(bs->open_flags & BDRV_O_INACTIVE)) crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1712818 <1712818@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5vTwFINBbP8M4soUtvRwQCvrxON4v3FIq
From: Eric Blake <eblake@redhat.com>
To: Bug 1712818 <1712818@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <104369c1-ccfd-bfda-5d1e-97e8e874f45d@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1712818] [NEW] live migration with storage
 encounter assert(!(bs->open_flags & BDRV_O_INACTIVE)) crashes
References: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
In-Reply-To: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 07:59 AM, meeho yuen wrote:
> Public bug reported:
>=20
> The vm guest runs a iotest program, and i migrate it with virsh --copy-=

> storage-all,then the qemu process on the source host happens to crash
> with the following message:
>=20
> kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x=
0800)' failed.
> 2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed

>   here is the release:
>   qemu 2.7 & 2.10.rc3 were tested.

The just-tagged 2.10-rc4 includes a fix that should be addressing that
issue during live migration; can you please re-test with that?  (see
also https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04513.html)=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5vTwFINBbP8M4soUtvRwQCvrxON4v3FIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfA3UACgkQp6FrSiUn
Q2q73wf/fcc15FmdqSSjmoz5QkcK4ZZtxGxXZqYEQojwQ9LZiJYYozyXUaaiZ0U1
d7gCz3eSob8NC021OtOCa9CddLqiyd7qGM+00Fcd9frlQloW9JHFrDbLUClkC4mu
x3jArDU7+lXnTa1XQ83K8hTTJC7BKFxgMiVUT1ZcO26YpJz3l4/rzjWOgxhLRPd+
YJ6etK2upJ/cen4jTF+ArRj+Vr3O3o2mGGfHX2kWKWwXxD+hT+ZY+K0DO0vxIQKm
LO30kCbwdpuEKKY98idVpLpiWQwUDPDpu44s/1bPagXLK4c8VZxhpAEWLgepldca
2ll3M17Qtg55PpnV9MFMqSRMsGepUA==
=ryCW
-----END PGP SIGNATURE-----

--5vTwFINBbP8M4soUtvRwQCvrxON4v3FIq--
