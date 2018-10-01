Received: from eggs.gnu.org ([2001:4830:134:3::10]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70p3-0007qX-IF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70oz-0002w2-Uc
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:13:23 -0400
References: <20181001151053.7046-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fc3f0985-53e2-875f-269b-96b959945bd0@redhat.com>
Date: Mon, 1 Oct 2018 18:13:10 +0200
MIME-Version: 1.0
In-Reply-To: <20181001151053.7046-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="woLHXicrjAFwhXOolDjrpAlkbzzyKREsO"
Subject: Re: [Qemu-devel] [PATCH] tests/test-bdrv-drain: Fix too late
 qemu_event_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--woLHXicrjAFwhXOolDjrpAlkbzzyKREsO
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <fc3f0985-53e2-875f-269b-96b959945bd0@redhat.com>
Subject: Re: [PATCH] tests/test-bdrv-drain: Fix too late qemu_event_reset()
References: <20181001151053.7046-1-kwolf@redhat.com>
In-Reply-To: <20181001151053.7046-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.18 17:10, Kevin Wolf wrote:
> qemu_event_reset() must be called before the AIO request in a different=

> iothread is submitted. Otherwise the request could be completed before
> we do the qemu_event_reset() and the test would hang in
> qemu_event_wait().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>
Tested-by: Max Reitz <mreitz@redhat.com>

(I still got the same hang as the one you just reported, though -- but
it happens just very rarely, so it's definitely better.)


--woLHXicrjAFwhXOolDjrpAlkbzzyKREsO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyR5YACgkQ9AfbAGHV
z0BztAgAvIPgSGQvNlEm7czcXSJsfWQ3qbUNITgPCHy183PIaDRwdXzGdu4Ck68L
/BdGFT2WaffS185575mJiEPoMnRu2HfCIccsGfGG+/Ip/BZoArduBbxMm6Ra8sG0
/rj52tkDcOlrdDVY8q2XtRgwQEC8z7Pod2tji6Kh8LQLnxAHbKfuULd9s1R/oh1h
1YwxgomlMOTKRhcKvx5xYBCTqi3gjyMO/XMZFjOktbwypV8x/os+Q6YAXyqVsLdI
iLe0Lfb9Mr4OxMJe/ZTa71rLP8lBgl+GFy5KXpDCEvecNX++6p7k2cE0AF3AgcmL
En9uaL14SnJvhT31L/iBLBVqQ5td6Q==
=2phf
-----END PGP SIGNATURE-----

--woLHXicrjAFwhXOolDjrpAlkbzzyKREsO--
