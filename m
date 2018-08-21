Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fs5Xj-0007Aq-Dv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fs5Qj-0000nn-6o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:06:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fs5Qj-0000lc-0D
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:06:37 -0400
Date: Tue, 21 Aug 2018 14:06:34 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180821120634.GC3923@vader>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
	<20180810171102.16451-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20180810171102.16451-3-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] qemu-seccomp: manually expand
 SCMP_A1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10/08/2018 - 18:11:00, Alex Benn=C3=A9e wrote:
> The expansion of ((struct scmp_arg_cmp){1, SCMP_CMP_NE, 5}) doesn't
> work with -std=3Dgnu99.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  qemu-seccomp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 9cd8eb9499..4dc1c22924 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -39,7 +39,7 @@ struct QemuSeccompSyscall {
>  };
> =20
>  const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> -    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> +    {1, SCMP_CMP_NE, SCHED_IDLE}
>  };
> =20
>  static const struct QemuSeccompSyscall blacklist[] =3D {
> --=20
> 2.17.1
>=20
Acked-by: Eduardo Otubo <otubo@redhat.com>

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbfABKAAoJEN8y58Dw//miAk0H/3i4DBGW6I6UBB4losLtGdsL
6ImG0bK+cYyuZweqm+w3bQoqwiymCIWhsauASPZmDsUf8R8ukBVfbiBq22nY7h1H
7oWLCjmTk+atN/zeqfRNUn5kns23QU2aIaof1CYjwU6ASLH8Pjm9j8xht1NOA0rW
jV2Nl4WcPjH4N7x0kA44FcxUxeCu+hWwRFHJkwlVlp+/3xxGsOhTUH0peMI65hS7
3wancwArPBX50uO/1QtadOgsbRNTad18cgXMoD5eg6UfOGmHcFpUrKzDqnbghxIE
p7DAkKoKfncBthNj78NI0JJpILmqRI7qt/b6uURZ36UYVI4EWi8iFDDGuDWe+rY=
=OVcS
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
