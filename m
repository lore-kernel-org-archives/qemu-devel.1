Received: from eggs.gnu.org ([2001:4830:134:3::10]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvrt-00066p-Gv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvrs-0005aL-Jh
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:01:37 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9211ef34-f8ef-5174-661c-478ad533bfe2@redhat.com>
Date: Fri, 15 Sep 2017 14:01:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bDeicsrLKiL6oE1c5h6xDhpX1uns9A4cr"
Subject: Re: [Qemu-devel] [PATCH 5/6] block: reopen: Queue children after
 their parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bDeicsrLKiL6oE1c5h6xDhpX1uns9A4cr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <9211ef34-f8ef-5174-661c-478ad533bfe2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] block: reopen: Queue children after
 their parents
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-6-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> We will calculate the required new permissions in the prepare stage of =
a
> reopen. Required permissions of children can be influenced by the
> changes made to their parents, but parents are independent from their
> children. This means that permissions need to be calculated top-down. I=
n
> order to achieve this, queue parents before their children rather than
> queuing the children first.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bDeicsrLKiL6oE1c5h6xDhpX1uns9A4cr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8I4YACgkQp6FrSiUn
Q2r9kQf/eVPK70H5+iNXBX0e7dbsl79Mf1iYF/S3yeaP8oBommJxoy9LksmLOIdx
vb+o7zn0aSqoibDiwQ8FxKx/6gObGj/Vr/7vxvJMtvMg+M0PzZ6QCxc85DaGa3vW
+CUjmucJCTDBqVue7yzHpM/wmFP14vGXChObjQzcVtNGPjmKVAkhW105WKcOzqW0
9uOnGGcfWKurwV/5ygvUm49GRmqNiY8W4mFX7UVuMh1dGOhF1GDz6F2OqDdr3YCp
9zq/aCNWgrA5pIasa3btpGFvpWgVYMjrr1ld6REDagFZAigj/QFzKrrVHFHGk6S4
Ab+09xY+ILpN0DIWn9yztrXJoXfA1w==
=00N9
-----END PGP SIGNATURE-----

--bDeicsrLKiL6oE1c5h6xDhpX1uns9A4cr--
