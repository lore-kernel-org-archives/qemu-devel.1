Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaNU-0006lH-It
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaNQ-0005Wp-8v
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:51:20 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhaNQ-0005UC-1N
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:51:16 -0400
Received: by mail-wm0-x235.google.com with SMTP id i66so8014503wmg.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 04:51:15 -0700 (PDT)
Date: Tue, 15 Aug 2017 12:51:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815115112.GA22606@stefanha-x1.localdomain>
References: <20170815084430.7128-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20170815084430.7128-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 09:44:28AM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Don't emit event ID mapping records in simpletrace.stp [Daniel Berrang=
e]
>=20
> The SystemTap flight recorder mode no longer works with simpletrace.stp b=
ecause
> the event ID mapping records are emitted the first time an event fires.
> Chances are, the event ID mapping record will not be in ring buffer when =
the
> users wants to print the trace.
>=20
> This series solves the issue by using the trace-events-all global event
> ordering for event IDs for simpletrace.stp.
>=20
> Stefan Hajnoczi (2):
>   trace: use static event ID mapping in simpletrace.stp
>   simpletrace: fix flight recorder --no-header option
>=20
>  scripts/simpletrace.py                       | 24 +++++++++++++++------
>  scripts/tracetool/format/simpletrace_stap.py | 31 ++--------------------=
------
>  2 files changed, 20 insertions(+), 35 deletions(-)
>=20
> --=20
> 2.13.4
>=20
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkuAwAAoJEJykq7OBq3PIKVgIAIyJ5MPjBSR0ftdxxSQKcKKF
/ZxW+upOVkhUGlQrW0wJ4JNV2oHsdMCGq5WjFxkJH7wD7M3+o/a+HGoc1Tmhtnqk
kkvj+iA6TjsCssRXLV5y7djWTds9tgy6mxrPKXByOjVqT6TCeSkvGEZtj2ZEuntA
L6a1i55CGUu4tNGcVM+eiuTFMLjJme+wkF1tHWD/o6Uo8FQQw7LTX8LNjoJIBF7Z
S+jxyP8C1v3Ghqv80hJPAxTSFfWhkO/8O5Gj5ahnVJa6jtmFuO5kRIlTHXzmkx4v
knRQ8nh/TK2PVMizTnxka75QZ8jaVH5wRXWDmx6jF2s7YDiZWuo2U6DRbxLoAHE=
=qe3j
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
