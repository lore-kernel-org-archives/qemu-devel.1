Received: from eggs.gnu.org ([2001:4830:134:3::10]:42118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0T4B-0007E9-67
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0T47-0000cq-U2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:21:11 -0400
References: <20170314023933.12118-1-famz@redhat.com>
	<20170314023933.12118-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f1ecad6-9e85-39a2-6d52-5481f7e309cb@redhat.com>
Date: Tue, 18 Apr 2017 08:20:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170314023933.12118-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mC9FjOeGN5VdHSjK2Na47Q30e2EeeeBjQ"
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] qemu-img: Add --unsafe-read option
 to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mC9FjOeGN5VdHSjK2Na47Q30e2EeeeBjQ
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <0f1ecad6-9e85-39a2-6d52-5481f7e309cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] qemu-img: Add --unsafe-read option
 to subcommands
References: <20170314023933.12118-1-famz@redhat.com>
 <20170314023933.12118-3-famz@redhat.com>
In-Reply-To: <20170314023933.12118-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 09:39 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++------=
--------
>  1 file changed, 114 insertions(+), 34 deletions(-)
>=20

> @@ -2711,9 +2751,10 @@ static int img_map(int argc, char **argv)
>              {"output", required_argument, 0, OPTION_OUTPUT},
>              {"object", required_argument, 0, OPTION_OBJECT},
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"unsafe-read", no_argument, 0, 'U'},
>              {0, 0, 0, 0}
>          };
> -        c =3D getopt_long(argc, argv, "f:h",
> +        c =3D getopt_long(argc, argv, "f:hU",

Yay for 'U' being an unambiguous mnemonic that we could use on all the
commands.  You got lucky (it gets ever harder to add new options, as our
letters get thinner ;)

> @@ -2970,6 +3020,7 @@ static int img_rebase(int argc, char **argv)
>      int c, flags, src_flags, ret;
>      bool writethrough, src_writethrough;
>      int unsafe =3D 0;
> +    int unsafe_read =3D 0;

bool, please.  (Just because existing code is lousy with using an int
for a bool doesn't mean we should perpetuate it)


> @@ -3033,6 +3085,9 @@ static int img_rebase(int argc, char **argv)
>          case OPTION_IMAGE_OPTS:
>              image_opts =3D true;
>              break;
> +        case 'U':
> +            unsafe_read =3D 1;

s/1/true/

Good patch, but missing documentation updates to --help/man page.  So,
as encouragement to add that when you drop the RFC, I'll withhold my R-b
until then. ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mC9FjOeGN5VdHSjK2Na47Q30e2EeeeBjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9hKtAAoJEKeha0olJ0NqSVYIAJOZ/0js164vupcyO/yCO/mA
jAoM3tdQGyQLEf1ybAui9QAM48atrOJhTlOILZi7V9jawBQSE7kZZbQWbMJ26kUZ
LYLV+v+w1BksOyjE/4tRRWdb9e52rlZXQNF6HyqVEjmuPz6KvSTJmuaQvJh2Wuhy
1YOf2tmWrg4RiSQYAA2L46L01GdWzQNrVLpfMWQl2g9gcEz11cfwGbOanDEuP3lv
+yNlckN0iLpdBWSJhb5r9zcjMef4lc5qDjaK6XQCee1i7Kdrf6EK/6zVWBk3GWpX
A8fKV4O64Bo6EDwyQlt4BIU9pEvOK1ma7E3k3ZCuWp7BD7DTXIHd9BRc8RMYrK4=
=Ihuy
-----END PGP SIGNATURE-----

--mC9FjOeGN5VdHSjK2Na47Q30e2EeeeBjQ--
