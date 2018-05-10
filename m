Received: from eggs.gnu.org ([2001:4830:134:3::10]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGi5n-0002WZ-9G
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGi5j-0004ao-DO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:31 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fGi5j-0004aV-6l
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id g21-v6so1323541wrb.8
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:42:26 -0700 (PDT)
Date: Thu, 10 May 2018 10:42:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180510094224.GA4148@stefanha-x1.localdomain>
References: <20180430124651.10340-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20180430124651.10340-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes
 and MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 01:46:46PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Resolve missing CHK() [Thomas]
>  * Drop first argument to WARN() to match QEMU function arguments
>=20
> This series cherry picks checkpatch UTF-8 fixes and the MAINTAINERS file =
check
> from Linux.  Thomas Huth original did the backport in January 2017 but the
> series was forgotten (<1485436265-12573-1-git-send-email-thuth@redhat.com=
>).  I
> did the cherry pick again from scratch.
>=20
> The MAINTAINERS file check prints a warning when new files are added with=
out a
> modification to ./MAINTAINERS.  It is easy to forget to update ./MAINTAIN=
ERS
> and this check should help us stay on top of new source files.
>=20
> Joe Perches (4):
>   checkpatch: add a --strict check for utf-8 in commit logs
>   checkpatch: ignore email headers better
>   checkpatch: emit a warning on file add/move/delete
>   checkpatch: reduce MAINTAINERS update message frequency
>=20
> Pasi Savanainen (1):
>   checkpatch: check utf-8 content from a commit log when it's missing
>     from charset
>=20
>  scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.14.3
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BQAAAoJEJykq7OBq3PItHEH/3CmAwkdh3mfE59xkQqp5oJf
ipqHoZbqtZWDoPbT5beTQb0u5DETqc3On5QSNcR5rNVfm3nG4Koxht/SuW2BgiE4
m5/WP3ucKFYJQrijVgEmMVBWwtGIJUsID4rFvwIO2CJHaZDslUngZWmwRz/btUeu
dA5qMOahNlZ7ddMjeal11brCSBnDxWiZQdtyW/A9r+9GmnRcCk88IKp2EFweD6Bf
FOq02ITC4u43rPon2PuIMkL4mE4V8cvEcUsaI7psuIvxCABsheB/QlTJYxzQpFFz
noH19GK3wYP8YCSoxTp1EGEvQy/fxCqHzakPotoMTCY0T0YFR9AOZhyK5Odjuwo=
=K4Uz
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
