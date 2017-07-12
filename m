Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJrl-0001tG-5D
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJrk-00063v-3k
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:47:53 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-6-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <266aa00c-27cd-2f18-f756-844a9a321de7@redhat.com>
Date: Wed, 12 Jul 2017 10:47:40 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SW08ENF0hA3s8p3i6K1uBDVxsHAM19pbd"
Subject: Re: [Qemu-devel] [PATCH 5/9] block: List anonymous device BBs in
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SW08ENF0hA3s8p3i6K1uBDVxsHAM19pbd
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <266aa00c-27cd-2f18-f756-844a9a321de7@redhat.com>
Subject: Re: [PATCH 5/9] block: List anonymous device BBs in query-block
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> Instead of listing only monitor-owned BlockBackends in query-block, als=
o
> add those anonymous BlockBackends that are owned by a qdev device and a=
s
> such under the control of the user.
>=20
> This allows to use query-block to inspect BlockBackends for the modern

"allows to VERB" is not idiomatic; better is "allows VERBing" (as in
"allows using query-block"); or "allows SUBJECT to VERB" (as in the
verbose "allows the client to use query-block").  For your particular
wording choice, it is also possible to do "allows the use of
query-block", although that rewrite is not possible for all VERB.

> configuration syntax with -blockdev and -device.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qapi.c | 2 +-
>  hmp.c        | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SW08ENF0hA3s8p3i6K1uBDVxsHAM19pbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZkScAAoJEKeha0olJ0Nqo9YH/RfcztPGxk3O3+cuJ3gWQf73
Am3aoBzE1Hpqb6YC1Gujn3CHFYORrh5lPgS4UHfr+QV2saSa+c9sekDxFhGyTlJm
UTJw2IoSTsdNMil5P5hcHGCnuFMNp/UsPzJ81KljhHjcJ20Jl1aIH7ZnnJ6JwGfG
wjG2nGayNksf+8nWyHj4Yzdg+EU6E1eqE1RzgC/vrysUMjkVsyYtaSduZ9mwnlKp
1VokfVvppFc1A5Bc1MMTZhSBilTiUrafIj1LpEN6hx+wGA/x4R5MZnJD+3RSvCLh
/nfMN/uf/iD/q0hbaHvgWjvCN8Vq48WA8xnmEz6p8bg7fv0TP/jdppn9Ybf6tys=
=z6R4
-----END PGP SIGNATURE-----

--SW08ENF0hA3s8p3i6K1uBDVxsHAM19pbd--
