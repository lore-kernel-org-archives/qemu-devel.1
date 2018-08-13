Received: from eggs.gnu.org ([2001:4830:134:3::10]:48574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpG99-0007ce-L0
	for Qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpG95-0007JW-Lx
	for Qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:56:47 -0400
References: <20180730212249.16418-1-programmingkidx@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
Date: Mon, 13 Aug 2018 18:56:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180730212249.16418-1-programmingkidx@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m4PpEUvcynqhwTXeieQoCIB3SmppbYjoU"
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, eblake@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m4PpEUvcynqhwTXeieQoCIB3SmppbYjoU
From: Max Reitz <mreitz@redhat.com>
To: John Arbuckle <programmingkidx@gmail.com>, eblake@redhat.com,
 kwolf@redhat.com, qemu-block@nongnu.org, Qemu-devel@nongnu.org
Message-ID: <5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
Subject: Re: [PATCH] qemu-img.c: increase spacing between commands in
 documentation
References: <20180730212249.16418-1-programmingkidx@gmail.com>
In-Reply-To: <20180730212249.16418-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-30 23:22, John Arbuckle wrote:
> When the user uses the --help option in qemu-img, the output for the co=
mmands is very hard to read due to being so close to each other. With thi=
s patch the help for the commands is double spaced making things easier t=
o read.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 9b7506b8ae..6a7e63435e 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -120,7 +120,7 @@ static void QEMU_NORETURN help(void)
>             "\n"
>             "Command syntax:\n"
>  #define DEF(option, callback, arg_string)        \
> -           "  " arg_string "\n"
> +           "  " arg_string "\n\n"
>  #include "qemu-img-cmds.h"
>  #undef DEF
>             "\n"

Ah, hm, so much for that.  Hm...  I don't quite know what to think of
this.  It does indeed improve legibility.  But the question is whether
--help should be as condensed as possible, and if the user finds it hard
to read, whether they should not just open the man page...

Then again, our --help text already has 102 lines.

Let me just think about it for a bit longer. :-)
(And see whether others have opinions.)

Max


--m4PpEUvcynqhwTXeieQoCIB3SmppbYjoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxuEgACgkQ9AfbAGHV
z0CZQQf8C2POgk+9cnHuJIe/clGb2tNTyvkzFNqbYR0EkQ2yVQj18Ld2cJD8eQDE
DsqMgAdt4U3/MCRdEH9tkklaC6xeHaFAu4/4wRFl5E4IdNmA5nSvCfT2ff+3OwyH
K5fMGio/OliddOkU0YmUacZCmB7MucPUW6iF2j5bqVKfreohe+c+WIM7I5624w5V
id9Y2GrWviKHAwD7AQjaA8Dd9SUZXeGwu+J9YZjCxBREIuAE4EBKWsF8m9kUtlkn
eYpe069KNWRgFKsU4hfY8jE6m50VLNWRTlxlTRCVyzr1yofO1vHRQ6hOWGwTTJ0p
VxkQYhCy+r5yhWb1zGb42SptjBDPsw==
=OPYL
-----END PGP SIGNATURE-----

--m4PpEUvcynqhwTXeieQoCIB3SmppbYjoU--
