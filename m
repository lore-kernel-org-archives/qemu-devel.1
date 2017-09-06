Received: from eggs.gnu.org ([2001:4830:134:3::10]:50409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpavp-00066J-3J
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpavo-0001Lx-8l
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpavo-0001LP-0K
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 069FD7E428
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 14:03:51 +0000 (UTC)
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-9-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f46e8437-a739-08cf-75c4-cbb5309b5c23@redhat.com>
Date: Wed, 6 Sep 2017 09:03:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170906115143.27451-9-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tTJtjQPB0ljHd9CsgsMSVfW5cN24uhO9s"
Subject: Re: [Qemu-devel] [PATCH v7 08/22] qio: Create new
 qio_channel_{readv, writev}_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tTJtjQPB0ljHd9CsgsMSVfW5cN24uhO9s
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <f46e8437-a739-08cf-75c4-cbb5309b5c23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 08/22] qio: Create new qio_channel_{readv,
 writev}_all
References: <20170906115143.27451-1-quintela@redhat.com>
 <20170906115143.27451-9-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-9-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:51 AM, Juan Quintela wrote:
> The functions waits until it is able to write the full iov.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Add tests.
>=20
> fix reader to check for len =3D=3D 0.
>=20
> make reader wait on G_IO_IN (dave)
> change tests to make sure that all combinations of call work with all b=
ackends

Since Dan's patch to add qio_channel_readv_all has already landed,
shouldn't this patch just be rebased to add the tests? Or is it also
fixing some bugs?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tTJtjQPB0ljHd9CsgsMSVfW5cN24uhO9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwADwACgkQp6FrSiUn
Q2ozHggAsBC0Z6RoZ/TsjHn08FTb0xIylXw3RPyFFENNBfHGcMImRBYGMRBJnF2T
dTVMOoAhMxjHHVoeu45ueRgXi04BWAc+iVTygr3diNkA72mk71Q5NYDLsGzxPL64
jWpH0dHtkoE2Sfk7ROBZK+n7ASjQqwpA5NdVsCWnPsVkTC7luzQsuooRMNOxcg3j
gBSsxaynSQqCBsJRXFCLI8XwLCzm6WneHt+ukrK69cW9xEUBLxsl2p8z1GncgxYD
o1GXWd1yjd5j1tTTxko2xwn9n2dKjALoF4ORFZypogmNDNcg1guv2fnNSP4t6vrY
PhSgDclNtS8y5GAft4MLmby7Z5Wqlg==
=ma8q
-----END PGP SIGNATURE-----

--tTJtjQPB0ljHd9CsgsMSVfW5cN24uhO9s--
