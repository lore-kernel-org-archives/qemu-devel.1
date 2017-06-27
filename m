Received: from eggs.gnu.org ([2001:4830:134:3::10]:52789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwgP-0003zt-Vu
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwgL-0004Ke-EO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPwgL-0004KB-64
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:01:53 -0400
References: <20170618082813.8091-1-tobleminer@gmail.com>
	<20170618082813.8091-2-tobleminer@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5601e86-7601-b79a-f1eb-9b2a623081c4@redhat.com>
Date: Tue, 27 Jun 2017 15:01:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170618082813.8091-2-tobleminer@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T4WtIG1e4Gu1kdiqvp4nUtIcEXWeI4bFe"
Subject: Re: [Qemu-devel] [PATCH 1/1] Add support for custom fmasks/dmasks
 in 9ps mapped mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Schramm <tobleminer@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T4WtIG1e4Gu1kdiqvp4nUtIcEXWeI4bFe
From: Eric Blake <eblake@redhat.com>
To: Tobias Schramm <tobleminer@gmail.com>, qemu-devel@nongnu.org
Message-ID: <e5601e86-7601-b79a-f1eb-9b2a623081c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Add support for custom fmasks/dmasks in
 9ps mapped mode
References: <20170618082813.8091-1-tobleminer@gmail.com>
 <20170618082813.8091-2-tobleminer@gmail.com>
In-Reply-To: <20170618082813.8091-2-tobleminer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/18/2017 03:28 AM, Tobias Schramm wrote:
> Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
> ---
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  hw/9pfs/9p-local.c      | 33 +++++++++++++++++++++++++++++----
>  hw/9pfs/9p.c            |  3 +++
>  4 files changed, 48 insertions(+), 4 deletions(-)
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 0844a403dc..0ecb1d392b 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -76,6 +76,8 @@ typedef struct FsDriverEntry {
>      int export_flags;
>      FileOperations *ops;
>      FsThrottle fst;
> +    mode_t fmask;
> +    mode_t dmask;
>  } FsDriverEntry;
> =20

> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -38,6 +38,12 @@ static QemuOptsList qemu_fsdev_opts =3D {
>          }, {
>              .name =3D "sock_fd",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "fmask",
> +            .type =3D QEMU_OPT_STRING,
> +        }, {
> +            .name =3D "dmask",
> +            .type =3D QEMU_OPT_STRING,

No documentation of what these represent (other than the cover letter).
I'd at least expect a comment of 'default creation mask for files' and
'default creation mask for directories'; it would also be nice to state
if the mask is positive or negative logic (compare the third argument
passed to open() which specifies bits to set, vs. the argument to umask
which specifies bits to keep clear).

Also, does this need a QAPI counterpart (or can you even create a 9pfs
device through QMP)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--T4WtIG1e4Gu1kdiqvp4nUtIcEXWeI4bFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUrmoAAoJEKeha0olJ0NqB64H/AjFOxxhbN5aq1wIBsL2kZZz
N8kvhmGaHAWUQQPhNfW7Ex+dXFXxa6gyhLn25NfWVW1qb27vjoTA/hzgmvXyyhp4
ZQm64LlMXT0vELsF000H3+Z1PU3oTHSkeTpIgBR/lfSv9E0nJMYNg76kxt8glDw8
r0KlyPm6SYjXl7QsV4f6PR3vulNyOhbuv5YIJkD+szVbSYQa00WOaS3dn/7qPje8
N0unXM1Ewjg5/6bGqz9h3onnZ2qPW8NRX7odxuBqbZg6srHxHmmLsGetNZnDJoDi
n+E62QCLsVt+jyFA4LchfruVkksRgKCrguYHWyrilgSK0B7RTfv9CHPrFjmYeQ4=
=Ml2J
-----END PGP SIGNATURE-----

--T4WtIG1e4Gu1kdiqvp4nUtIcEXWeI4bFe--
