Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1epGIL-00046d-Ot
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1epGII-0003o3-Hg
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:34:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1epGII-0003mf-DA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:33:58 -0500
Date: Fri, 23 Feb 2018 16:33:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180223163354.GC7151@stefanha-x1.localdomain>
References: <20180213140029.8308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20180213140029.8308-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 02:00:29PM +0000, Peter Maydell wrote:
> A persistent build problem we see is where a source file
> accidentally omits the #include of log.h. This slips through
> local developer testing because if you configure with the
> default (log) trace backend trace.h will pull in log.h for you.
> Compilation fails only if some other backend is selected.
>=20
> To make this error cause a compile failure regardless of
> the configured trace backend, split out the parts of log.h
> that trace.h requires into a new log-for-trace.h header.
> Since almost all manual uses of the log.h functions will
> use constants or functions which aren't in log-for-trace.h,
> this will let us catch missing #include "qemu/log.h" more
> consistently.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++++++++++
>  include/qemu/log.h               | 18 ++++--------------
>  scripts/tracetool/backend/log.py | 13 ++++++-------
>  3 files changed, 45 insertions(+), 21 deletions(-)
>  create mode 100644 include/qemu/log-for-trace.h

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJakEJxAAoJEJykq7OBq3PIxhoH/RHj+ik2h+Ytp/I2iMtKuLkc
nDQWxdyO1U/nKUSZ8tb9y66XGicI9+FUAitJnyolfW7VMP3/4QOTCHYQ5q0z+2xQ
x2JNjLn1BBoODWN6kT/29QhSvM+QfO6y/E/8SVedlGPlgNoydLg5h9dA/oUvxAdO
iWxD596fAZ6zsHdHYnSQHlHjBFrfzJg+Xs0w4NJu/NtP+skqA9HmYlK+nFXH95rc
kAS3UTCRt+d8eYVbkmwONjPDFZdPjwF9t6QT2eyHqkftup8mGMg/R9sUb7W5FsuY
qf3Q+GbzDHOpyXRzc5uLe6qlXPCOIeviPS83r/rFFya9RNg4TQAZ0Znv7W+havM=
=l7d9
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
