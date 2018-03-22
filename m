Received: from eggs.gnu.org ([2001:4830:134:3::10]:45618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez7dy-0008EG-Ib
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez7dv-0005Ky-10
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:21:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ez7du-0005Ko-RM
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:21:02 -0400
Date: Thu, 22 Mar 2018 21:20:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180322212035.GA16426@stefanha-x1.localdomain>
References: <1521645545-247351-1-git-send-email-mst@redhat.com>
	<1521645545-247351-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1521645545-247351-2-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] make: switch from -I to
 -iquote
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:22:07PM +0200, Michael S. Tsirkin wrote:
> Our rule right now is to use <> for external headers,
> "" for internal ones. The idea was to avoid conflicts
> between e.g. a system file named <trace.h> and an
> internal one by the same name.
>=20
> Unfortunately we use -I compiler flag so it does not
> help: a system file doing #include <trace.h> will
> still pick up ours first.
>=20
> To fix, switch to -iquote which is supported by both
> gcc and clang and only affects #include "" directives.
>=20
> As a side effect, this catches any future uses of
>  #include <> for internal headers.
>=20
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> I still think we want to switch to a more formal rule such as qemu/
> prefix for all includes down the road, but this will at least catch any
> scheme violations from creeping in meanwhile.
>=20
>=20
>  configure       | 16 ++++++++--------
>  rules.mak       |  2 +-
>  Makefile.target |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJatB4jAAoJEJykq7OBq3PI1sAH/2GDdYJmvQeJG8lkgTzpRKlX
REr6mAOFUim8Rxp7uXaJsRhQjq+gAbQsDWmqBjM2Tss+/lWwZRYonINC9XjUxWtF
+NIq2FJKDrESvWSqlboZhkwYhnb86Plw3onUwrsqdzV1bKA1oYniOmEewveBriWL
P/dpzjSHkG4gSOmrX2ozVpeXU3ypAX5fR20iznV8VYVuPLjzj+v3Gza48dclBhJY
CFtwIlTymje/PBaq6i9juU3ZZ6h+0BJNOeH0rtt/fqh+K8jgvZhoarAt1ThQ3EOi
N1dstfgHzFTjyoGgpxkVJ7vyuDcxPUqJglMCHjumhF734XSV+1BP6nfzOh2GjVE=
=yC5Q
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
