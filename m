Received: from eggs.gnu.org ([209.51.188.92]:53252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Qh-0003k0-Rc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Qh-0007Mf-5I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:11:15 -0500
Date: Wed, 13 Feb 2019 16:19:51 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190213081951.GA13081@stefanha-x1.localdomain>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 01:24:28PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is a new simple helper for a very often patter
> around qemu_iovec_init_external, when we need simple qiov with only
> one iov, initialized from external buffer.
>=20
> v3:

Hi Vladimir,
"make check" is failing:

  TEST    check-qtest-x86_64: tests/ide-test
qemu-system-x86_64: /home/stefanha/qemu/include/qemu/iov.h:195: qemu_iovec_=
get_buf: Assertion `qiov->niov =3D=3D -1 && qiov->iov =3D=3D &qiov->local_i=
ov' failed.

Please take a look and send v4.

Stefan

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY9MnAAoJEJykq7OBq3PI6rwIAMFCmVZ66MkLcz4sQOgvKSw7
Qsr5eSF/++J7u0msSQK9ZC4VrrkMiwCjuZxHZCf2mZokLqvxwnK5JcbisUFwAOPZ
ss/JgoyTGh6xhM62icYcJ4XHQQd72+oJO7Iih/4kTZfgsgC8bSrzx+QxacNCBOlW
dHFnY0Vl7PcodGPNkC6QRnFiim74fWhUE7K/jDEC8rETPqVrtTv+mzzgn/GCsgAW
80Mu0oRLCmk722MEeo7QT6mIx2P+9uGnvtkd3ByYttrlLq4EBoS/lt+fbz94tPhf
HGtcQ5SyuQqfHN5tQk3RXf4JtxSttBIKcOvPPuNPrQ+netscTh3UMmLnxw8+pvQ=
=qTd0
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
