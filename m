Received: from eggs.gnu.org ([2001:4830:134:3::10]:51992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKBs-0005mt-Hz
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKBr-0006oV-Mc
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:53:52 -0400
References: <20170515141014.25793-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <40e4eb3f-1900-1c5d-e189-58b569ffd35d@redhat.com>
Date: Mon, 15 May 2017 19:53:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170515141014.25793-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AxwFPAws3ieoOxNWAHbxg1DvBxr4xvRHi"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix leakage of options on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxwFPAws3ieoOxNWAHbxg1DvBxr4xvRHi
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <40e4eb3f-1900-1c5d-e189-58b569ffd35d@redhat.com>
Subject: Re: [PATCH] qemu-img: Fix leakage of options on error
References: <20170515141014.25793-1-famz@redhat.com>
In-Reply-To: <20170515141014.25793-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 16:10, Fam Zheng wrote:
> Reported by Coverity.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--AxwFPAws3ieoOxNWAHbxg1DvBxr4xvRHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGesZEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAYZ
B/97ht1aYt5EdqH49xzolp1nbhQXD3BTWYyjL6JRSLlVpAoaR7f0OY+iQEXP3jHa
OMpTarXSh9S9q10Pd+HYi/Y7+Mdh40P7zz4P/yRT+D6ycE+TyDIROZqqmviBwwsp
CE8cQp2jtSqnC+/Evfes/CWeSl7qkby4QnISkBbJugE28gfdanl/No/lWEmUNGJL
t3ibBSImE/PbeF0g9VUSm9IM6x/UUh9Ie4unnHtoRYJPRtCH9Am5fFEDBbxgcZLZ
wgYI1l6ByI/7ePivyas/JLPueJ4J+MXQTkilLMGH05H8lRYERnZ1n3geBwyhaPtS
C28odv9b8jmwqCLPXfrJSzP2
=txn/
-----END PGP SIGNATURE-----

--AxwFPAws3ieoOxNWAHbxg1DvBxr4xvRHi--
