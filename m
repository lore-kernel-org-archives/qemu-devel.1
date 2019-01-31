Received: from eggs.gnu.org ([209.51.188.92]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpEzg-0001Vk-JQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpEzf-0005wL-Mc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:15:12 -0500
Received: from greensocs.com ([193.104.36.180]:49017)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpEzf-0005rH-4p
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:15:11 -0500
References: <20190130192403.13754-1-jcmvbkbc@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ff956174-0839-0034-b659-a1e6e5096493@greensocs.com>
Date: Thu, 31 Jan 2019 17:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190130192403.13754-1-jcmvbkbc@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wh9AAC8EZHxXjBVqs4sbUlnEwDcpjG3XY"
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wh9AAC8EZHxXjBVqs4sbUlnEwDcpjG3XY
From: Luc Michel <luc.michel@greensocs.com>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ff956174-0839-0034-b659-a1e6e5096493@greensocs.com>
Subject: Re: [PATCH v2] gdbstub: allow killing QEMU via vKill command
References: <20190130192403.13754-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190130192403.13754-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 8:24 PM, Max Filippov wrote:
> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
> presence of single process.
>=20
> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
> (f|s)ThreadInfo and ThreadExtraInfo")
>=20
> Cc: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
> Changes v1->v2:
> - terminate QEMU in the vKill packet handler regardless of whatever the=

>   PID is or how many processes are attached [Luc Michel]
>=20
>  gdbstub.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb50968..96ffcd9d9d1d 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1383,6 +1383,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
> =20
>              put_packet(s, buf);
>              break;
> +        } else if (strncmp(p, "Kill;", 5) =3D=3D 0) {
> +            /* Kill the target */
> +            error_report("QEMU: Terminated via GDBstub");
> +            exit(0);
>          } else {
>              goto unknown_command;
>          }
>=20


--wh9AAC8EZHxXjBVqs4sbUlnEwDcpjG3XY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxTHwoACgkQd8knW3Qn
Tr5Evw//dFuyrnneRkz5D8FGLKW8W2medqlK/bhh3x8OvheOw4jzhbnzDvLo8hSe
XhpdRzvJJCe0t6Ap68wFHcaY7cbLvfbBkUEteNeOGIwWNXfW49DE4TiCOA3DEEN/
sSHCHnvWsZnLtx5NGjY4hifmgNyFKTXh1uAM7nb3kOO68m4KL26XiVCJat5AaT3d
Y48DG0c6wi6ikFYMyZp2d9Du03C4rr4jNJ5HQgCzYeLQDyatmWfwf8QXscEol0cm
QrZyqah9Os7/BHtMgdFeux7fNsGO1vI4y2aUyHXF4DSvf6lufm+FvnLrqEd7pMS/
TjFN1GGjJ69DyiXSs1C5riUG/vsARFag2OtgXIyxUOK8abC9c4yVNB23ULFLmPGL
X2IUYoNJwLOyXDY8q798Vp90Q8Fs/CmnBa4YuWsIhwy1TXFZSA48ilB5ADKmvx2X
M6e++kwnO6o7FLyRA+1eBcsUu+IN/yn/ZsRFc0wsErqsrVn7qFYYIjeolr6eIRay
1Wql9I1cj0tFmsR9xuQCDsEEzrBPyn7gQErBfsmfgNoAaEpYY+Lgy/nBhL+RaHwD
Yu7VwxPfs72hSoJ+ZOyM6Hy2uMAHPFEJtHm/Cyq+DbzgcO4ynT8yQDfzgpCn5oO2
4E1uZgKpMAU2i4ERD1MsF/2/iYpKiyLYsZLRyh1IfaWFGFuHm+Y=
=XYMj
-----END PGP SIGNATURE-----

--wh9AAC8EZHxXjBVqs4sbUlnEwDcpjG3XY--
