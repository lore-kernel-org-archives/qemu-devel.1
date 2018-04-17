Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xgr-000360-Oo
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xgn-0001uz-MC
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8Xgn-0001po-E9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:58:57 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<cd6e61655ae9dd818bb49845f7f76d78f6931507.1523537181.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72ec4e1-6af1-05d4-d7b0-d3312fbe7b96@redhat.com>
Date: Tue, 17 Apr 2018 15:58:55 -0500
MIME-Version: 1.0
In-Reply-To: <cd6e61655ae9dd818bb49845f7f76d78f6931507.1523537181.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yTXnwmkaNuPeJcYTl0YRPtczeZ1QuIiQl"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] cpus: use size_t in
 qmp_memsave/qmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yTXnwmkaNuPeJcYTl0YRPtczeZ1QuIiQl
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <f72ec4e1-6af1-05d4-d7b0-d3312fbe7b96@redhat.com>
Subject: Re: [PATCH v2 3/5] cpus: use size_t in qmp_memsave/qmp_pmemsave
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
 <cd6e61655ae9dd818bb49845f7f76d78f6931507.1523537181.git.simon@ruderich.org>
In-Reply-To: <cd6e61655ae9dd818bb49845f7f76d78f6931507.1523537181.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 07:50 AM, Simon Ruderich wrote:
> It's the natural type for object sizes and matches the return value of
> sizeof(buf).
>=20
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  cpus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yTXnwmkaNuPeJcYTl0YRPtczeZ1QuIiQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWYBAACgkQp6FrSiUn
Q2qpygf+MkG4T/w7xge2jeWhHs+GrXopVj417j5yQUwxTTJFaf4joB3rMW/prNJG
giiSJ1yYs6B4EznFe7LdknDXXrI7cJEJiIN8Xgr+h7G9+w06ySOAwXOqEwVoo6/W
2Ct51Rpn98Tu+l3gKyAHncyRUOMbrFreoUVbUiHLbqv/EWTDjAcvzokq7jL+olbc
srm8zzJq0rG6c/vx0xRs6BtZcW/8vxG0hPSeMyDM/OBERxmRUThoHeSHVDabgl/Z
oi/gJMxHBjfpI5lgf0LnDK2zOe5Xl7+cXnkxjnHJO7P2nzJbuG7+5jLFKIIDgjEK
2/XJ0WXzhpOdsNQg4BF9Zif+YFpN+Q==
=uYfm
-----END PGP SIGNATURE-----

--yTXnwmkaNuPeJcYTl0YRPtczeZ1QuIiQl--
