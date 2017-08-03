Received: from eggs.gnu.org ([2001:4830:134:3::10]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddHnQ-0001tm-L5
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddHnP-0001Ys-Lp
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:12:20 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7faae088-d3f8-e3a9-b252-6b8a7c3e132a@redhat.com>
Date: Thu, 3 Aug 2017 10:12:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CMDJflS6JUMbT8DQDGkGHspBgEBoW3ex8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/5] block: Fix order in
 bdrv_replace_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMDJflS6JUMbT8DQDGkGHspBgEBoW3ex8
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <7faae088-d3f8-e3a9-b252-6b8a7c3e132a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/5] block: Fix order in
 bdrv_replace_child()
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-2-kwolf@redhat.com>
In-Reply-To: <20170803150301.10177-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:02 AM, Kevin Wolf wrote:
> Commit 8ee03995 refactored the code incorrectly and broke the release o=
f
> permissions on the old BDS. Instead of changing the permissions to the
> new required values after removing the old BDS from the list of
> children, it only re-obtains the permissions it already had.
>=20
> Change the order of operations so that the old BDS is removed again
> before calculating the new required permissions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CMDJflS6JUMbT8DQDGkGHspBgEBoW3ex8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDPUwACgkQp6FrSiUn
Q2r32QgAqPESLoBEUim/SKzA+gThUnDgNehzTyzoE8/KSwBQaDmZr9hpVV/AhDVB
mM7jppVLoTcP/ItGe8LadD+toAinrXAfjIDHrhE5ITu7FODRpvT4adS88p/5Q2+Y
6xNk9jAC0RbkqCKjfM9Ese3Xkej3HOPml4w/NF0cBd4QWOZtYQ1p7pt7HjMUgzVI
YNM3AlvbpwhX6Eug2KQSP0BZ22WPO1ZG99Vwp2t1S2/G7+nrPMA/nanLExP5CiFG
8Gnp2K8AtOb8XJpodJEyeszKUuMIJx+U5JCVNZ/lcwV04nF1t27VyQAPju9Oz97B
AZOiS+5/Eg5zTxOTZvfJgfeiOwt1BA==
=zbU+
-----END PGP SIGNATURE-----

--CMDJflS6JUMbT8DQDGkGHspBgEBoW3ex8--
