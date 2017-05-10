Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8TW1-0007Ft-ER
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8TVy-0002pf-6l
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:27:01 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d8TVy-0002pY-29
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:26:58 -0400
Received: by mail-qk0-x22d.google.com with SMTP id y201so33584596qka.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 08:26:57 -0700 (PDT)
Date: Wed, 10 May 2017 11:26:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170510152655.GD19962@stefanha-x1.localdomain>
References: <20170509134623.13120-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20170509134623.13120-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge qcrypto 2017/05/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 02:46:19PM +0100, Daniel P. Berrange wrote:
> The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:
>=20
>   Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/berrange/qemu tags/pull-qcrypto-2017-05-09-1
>=20
> for you to fetch changes up to a37278169d0d7d33270c6817f4a2e4f7345e1098:
>=20
>   crypto: qcrypto_random_bytes() now works on windows w/o any other crypt=
o libs (2017-05-09 14:41:47 +0100)
>=20
> ----------------------------------------------------------------
> Merge qcrypto 2017/05/09 v1
>=20
> ----------------------------------------------------------------
>=20
> Daniel P. Berrange (3):
>   Default to GSSAPI (Kerberos) instead of DIGEST-MD5 for SASL
>   List SASL config file under the cryptography maintainer's realm
>   crypto: move 'opaque' parameter to (nearly) the end of parameter list
>=20
> Geert Martin Ijewski (1):
>   crypto: qcrypto_random_bytes() now works on windows w/o any other
>     crypto libs
>=20
>  MAINTAINERS               |  1 +
>  block/crypto.c            |  6 +++---
>  crypto/block-luks.c       | 13 +++++++-----
>  crypto/init.c             |  6 ++++++
>  crypto/random-gcrypt.c    |  2 ++
>  crypto/random-gnutls.c    |  3 +++
>  crypto/random-platform.c  | 45 ++++++++++++++++++++++++++++++++-------
>  include/crypto/block.h    |  6 +++---
>  include/crypto/random.h   |  9 ++++++++
>  qemu-doc.texi             | 50 +++++++++++++++++++++++++----------------=
--
>  qemu.sasl                 | 54 +++++++++++++++++++++++++++--------------=
------
>  tests/test-crypto-block.c |  6 +++---
>  12 files changed, 135 insertions(+), 66 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEzE/AAoJEJykq7OBq3PIO0sH/1qDs1KAh5lLG9BetimsOoDu
/DKxVykczIYAiZMax76Z4g6jkY8rSzRVIpjrP6G22PA1H8VKoo4fxd3TcMdBIaaj
jKunt0SpV7Ny3leQ9HrCas6NVjSzh+ZfKp9v7pMM02yE0EGBmZ0YPlz8gcWe/QVF
x6zdWaesqVKzIdtjpn/0WKGvF1gw41KqDQNuSCyfYG1/CjGOmNYt/8i6prpsz7mJ
3X1GxBwP+TEMHAR+WYy77zw1asczxhHd6/3S1X/tIGE8FiIU2f6APdC+56wUH0j7
zLkZBosY/2LG1+2lEPWesFPUNyFfYCsdccsdPkpSYvCqsyCNrTtdjXE6v48FVSQ=
=4ZGA
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
