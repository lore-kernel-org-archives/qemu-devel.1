Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyKb-00028s-RI
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyKa-00050p-Ug
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:21:57 -0400
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25e6f0b7-4981-a07c-c841-5b63a5a86ac0@redhat.com>
Date: Thu, 25 May 2017 14:21:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170525163851.8047-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ddleTqc6JmU3NW6Q7rn1GOENEa7AtQJ7q"
Subject: Re: [Qemu-devel] [PATCH v7 02/20] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ddleTqc6JmU3NW6Q7rn1GOENEa7AtQJ7q
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <25e6f0b7-4981-a07c-c841-5b63a5a86ac0@redhat.com>
Subject: Re: [PATCH v7 02/20] block: add ability to set a prefix for opt names
References: <20170525163851.8047-1-berrange@redhat.com>
 <20170525163851.8047-3-berrange@redhat.com>
In-Reply-To: <20170525163851.8047-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> When integrating the crypto support with qcow/qcow2, we don't
> want to use the bare LUKS option names "hash-alg", "key-secret",
> etc. We need to namespace them to match the nested QAPI schema.
>=20
> e.g. "encrypt.hash-alg", "encrypt.key-secret"
>=20
> so that they don't clash with any general qcow options at a later
> date.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 16 ++++++++--------
>  block/crypto.h | 40 ++++++++++++++++++++--------------------
>  2 files changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ddleTqc6JmU3NW6Q7rn1GOENEa7AtQJ7q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJy7LAAoJEKeha0olJ0NqGIYH/3EfbYuH7ubt8mnYpd/Qdmcq
JCu8/q8gcP0xbQvLsBx/Vw7kyLjJ0hnalW+KR7/MtSo4Dd9YzLaggT/qsxT9jpm+
nt/LAcTauhessknqvbvPvJuv/D2WahU7HDDuS1b/utmJwo8NRz2uBI2xFO/z8ylV
ZYH8xwA+dT5KAFK9egL4yezpGT0bK56O1dXWvlQX5E0EyddjiR25TnNQxRfvD79E
Z6SOYhTzUsv78tgMIShTjP8Qrq0hqMcNqtGL3htw3n/Y6OobFw0giZVEI8IpWavh
VgU7MdPqLoM1Tw97IJoez5DQa/Agcu1KwTQaaxHXwPAPYPGIxnsk51PWR2JtTts=
=ZIQt
-----END PGP SIGNATURE-----

--ddleTqc6JmU3NW6Q7rn1GOENEa7AtQJ7q--
