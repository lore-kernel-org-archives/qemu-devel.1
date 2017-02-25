Received: from eggs.gnu.org ([2001:4830:134:3::10]:52436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chazb-0001P2-7e
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chaza-0007U8-AY
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:58:27 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-38-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3a1ce7c-d4c5-1d17-6304-bbc709f99c7b@redhat.com>
Date: Sat, 25 Feb 2017 12:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-38-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ESWLxCsj3VWC6GxBrPXtBklas2tMfrd5E"
Subject: Re: [Qemu-devel] [PATCH 37/54] commit: Use real permissions for HMP
 'commit'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESWLxCsj3VWC6GxBrPXtBklas2tMfrd5E
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <d3a1ce7c-d4c5-1d17-6304-bbc709f99c7b@redhat.com>
Subject: Re: [PATCH 37/54] commit: Use real permissions for HMP 'commit'
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-38-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-38-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This is a little simpler than the commit block job because it's
> synchronous and only commits into the immediate backing file, but
> otherwise doing more or less the same.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ESWLxCsj3VWC6GxBrPXtBklas2tMfrd5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixcVcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AI5MH/2nNaz+b38Re1WbmxYb6X4oaxEodhZx/
FvHUjeKDrA0S3nIv3xJgr2kE3vwTgklPlFjiWeMBNB6z3ku7BfRXQOUD0jS5v9ps
rSyfo97QoNINjhZ/jnew851JwJt9qtJOfmRYfM3DuK28huLl9EhoYemfBGN1MSjk
XKl0T2fbHLC552lkWtZh5rJkuo/J+DMEFj507M41s7Gwhcl9AviqTXcFvG0IPrQP
rxOJ9oNMqpn4tMg1TcRQtKDEJ791AP++2gy8Pw+nmgAGHT7ieU1FybIObljCbuQy
nXzzKMn1qM+nLMETpHMsKZZjk2jnKg4iqKekTnaLB8n7N+MwOWLJrNA=
=/4GK
-----END PGP SIGNATURE-----

--ESWLxCsj3VWC6GxBrPXtBklas2tMfrd5E--
