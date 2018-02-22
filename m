Received: from eggs.gnu.org ([2001:4830:134:3::10]:43572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0Z3-0000XA-Jh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0YK-0000rc-HQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:46:13 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-28-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <064d5ba2-17b8-f834-fe00-46d5469bf0d7@redhat.com>
Date: Fri, 23 Feb 2018 00:43:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-28-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6YEFEb9MfUZTlhPtKqVIdKqB3oO1ceNRW"
Subject: Re: [Qemu-devel] [PATCH v2 27/36] sheepdog: QAPIfy "redundacy"
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6YEFEb9MfUZTlhPtKqVIdKqB3oO1ceNRW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <064d5ba2-17b8-f834-fe00-46d5469bf0d7@redhat.com>
Subject: Re: [PATCH v2 27/36] sheepdog: QAPIfy "redundacy" create option
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-28-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-28-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> The "redundacy" option for Sheepdog image creation is currently a strin=
g
> that can encode one or two integers depending on its format, which at
> the same time implicitly selects a mode.
>=20
> This patch turns it into a QAPI union and converts the string into such=

> a QAPI object before interpreting the values.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 45 +++++++++++++++++++++++++
>  block/sheepdog.c     | 94 +++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 112 insertions(+), 27 deletions(-)

Ooooh, thanks!

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6YEFEb9MfUZTlhPtKqVIdKqB3oO1ceNRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPVZoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Atk8H+QH8hbTaYVivASlMHlE61vOLAYM13VV4
ZowO/3GGTbwsSNGAx9uAVqVvpQ4jA7b58Q8NURxqqJotE4pbJut7lK6m/4sBa3FX
uN/nsKWP+HQDnEApFmi6RKNADCGU99Tm+zqFKG44EsEKBVHvPJLI3eWj4aIDKNTX
K4JsRm5cyKXNmuHu4dycVTuST99jjXaqWnbGtpRaeCR+bQyy1sur0ckgHWwtJbdT
CBjcKeKGwpQFArIQk2wOqm2LzHp9mTbYyueH1wSgUKSKdcEQlvimHT3eHE+uXUed
qXhkA0F/c+r9praUkGNr0IxSsFH2wfTg1TfOvti8jVbw7lmC+N9cvv4=
=pgu9
-----END PGP SIGNATURE-----

--6YEFEb9MfUZTlhPtKqVIdKqB3oO1ceNRW--
