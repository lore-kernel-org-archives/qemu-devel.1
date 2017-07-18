Received: from eggs.gnu.org ([2001:4830:134:3::10]:53992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUO0-0000Pz-3I
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUNz-0003CG-0W
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:26:08 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-6-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0274cb0-072d-534a-607a-924ecda631f5@redhat.com>
Date: Tue, 18 Jul 2017 10:25:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-6-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AQwUI17HplluBpDIm7D6cB8qlphsK8guu"
Subject: Re: [Qemu-devel] [PATCH 05/29] block: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQwUI17HplluBpDIm7D6cB8qlphsK8guu
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <a0274cb0-072d-534a-607a-924ecda631f5@redhat.com>
Subject: Re: [PATCH 05/29] block: use QEMU_IS_ALIGNED macro
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-6-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/io.c          | 4 ++--
>  block/qcow2-cache.c | 2 +-
>  block/vhdx-log.c    | 2 +-
>  block/vvfat.c       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

The first three look okay,

> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -454,7 +454,7 @@ static direntry_t *create_long_filename(BDRVVVFATSt=
ate *s, const char *filename)
>          entry=3Darray_get(&(s->directory),s->directory.next-1-(i/26));=

>          if (i >=3D 2 * length + 2) {
>              entry->name[offset] =3D 0xff;
> -        } else if (i % 2 =3D=3D 0) {
> +        } else if (QEMU_IS_ALIGNED(i, 2)) {
>              entry->name[offset] =3D longname[i / 2] & 0xff;
>          } else {
>              entry->name[offset] =3D longname[i / 2] >> 8;

but this one looks a bit odd.  Code-wise, it's identical, but
semantically, this doesn't feel like an alignment check, so much as an
even-or-odd check.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AQwUI17HplluBpDIm7D6cB8qlphsK8guu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluKH8ACgkQp6FrSiUn
Q2p1gggAsGdkoMZMENu35D8Gap/CfqSTH4DKstyfRDuYxvl69sxI4sMkkd/VljKe
2SGizJTyNlPo9KMzwsAjDtoUiQp+z3gyjtlR5HQVAUjRr8NhRkZGAQ06r7I8uP08
WcoPZSAfTh2oz0Q7SFgUwwM76bR56U6Va43xGW2AG6hSgYl35KQZgiX8B4Z4Bo66
EmmuKS6FigkpoyV924k5DSZnoNhrIJEit/w4xLhj6oqx5WUWLE8ibZEGORrh8cnY
Nyq4Vju8dQ0HR520eJLbgR42CUdoMdmRTf1rwfPcv6c0X5xTSYv9IxFMyhd0vtWO
xd+TPZwGZpDTcWxTiTi3DRUjb5YD1Q==
=ulSt
-----END PGP SIGNATURE-----

--AQwUI17HplluBpDIm7D6cB8qlphsK8guu--
