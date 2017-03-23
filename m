Received: from eggs.gnu.org ([2001:4830:134:3::10]:59789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqqNC-0001Mk-SM
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 20:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqqNB-0001Ro-S4
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 20:13:02 -0400
References: <20170322210005.16533-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f187f50-20b5-eed5-7c11-3259f163291a@redhat.com>
Date: Wed, 22 Mar 2017 19:12:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f5qmRSMd8oM2noKaHUgLSOhBFfVFLuRhc"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] file-posix: Make bdrv_flush()
 failure permanent without O_DIRECT
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
--f5qmRSMd8oM2noKaHUgLSOhBFfVFLuRhc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <2f187f50-20b5-eed5-7c11-3259f163291a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] file-posix: Make bdrv_flush()
 failure permanent without O_DIRECT
References: <20170322210005.16533-1-kwolf@redhat.com>
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 04:00 PM, Kevin Wolf wrote:
> Success for bdrv_flush() means that all previously written data is safe=

> on disk. For fdatasync(), the best semantics we can hope for on Linux
> (without O_DIRECT) is that all data that was written since the last cal=
l
> was successfully written back. Therefore, and because we can't redo all=

> writes after a flush failure, we have to give up after a single
> fdatasync() failure. After this failure, we would never be able to make=

> the promise that a successful bdrv_flush() makes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Makes sense for 2.9 (it doesn't change the data loss, but alerts to the
user to the knowledge of data loss a lot sooner, perhaps before things
get even worse).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--f5qmRSMd8oM2noKaHUgLSOhBFfVFLuRhc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0xMGAAoJEKeha0olJ0Nq9ZwIAKJ1Euk2B6eiwo5j00Fwqa2B
GQnf0+M67yNkb6vUbxQzV48qwARZ2ysaFaTYXOWqKFii023lT1GAPybqWvQfxBC6
Suic5ia/6gTqsb7wCvrLdorylDp2NYrlIGkh6/XnRvxKow6mhDdL/bjlVEQwGyVY
i3lzjEkbs5fmPcho5zKqoIEGbqreaRqFhQG8QG+U09Nez/dJ3wmVusWEKNpNnOgK
3L0gwtsFqIi5fK2Jhp+sMPczTus1RsRVMnw2Ij6MLJiCRiNVNjGlclpD42y6H2oh
RqhvPWbaRVPPrYzGnO6nfGua5FaIm6dmwBqrYfte3/RHR075H/5OY2kfUk1wqks=
=xefa
-----END PGP SIGNATURE-----

--f5qmRSMd8oM2noKaHUgLSOhBFfVFLuRhc--
