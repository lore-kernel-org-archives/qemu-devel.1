Received: from eggs.gnu.org ([2001:4830:134:3::10]:38125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozci-0007WD-7J
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozch-0008BN-JM
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:45:56 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6f60ef9f-8ef2-33ad-6c3f-fb1ca3130c2b@redhat.com>
Date: Thu, 22 Feb 2018 23:45:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W3IDj2RJNlQfFopxcA8dXExg7HeGVzf40"
Subject: Re: [Qemu-devel] [PATCH v2 13/36] block: Make bdrv_is_whitelisted()
 public
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
--W3IDj2RJNlQfFopxcA8dXExg7HeGVzf40
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <6f60ef9f-8ef2-33ad-6c3f-fb1ca3130c2b@redhat.com>
Subject: Re: [PATCH v2 13/36] block: Make bdrv_is_whitelisted() public
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-14-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> We'll use a separate source file for image creation, and we need to
> check there whether the requested driver is whitelisted.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h | 1 +
>  block.c               | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--W3IDj2RJNlQfFopxcA8dXExg7HeGVzf40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPSAwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMBcIAJzYq53QGElrISkLg4xqYyvXtb1GhCxH
+Ofj5UjsWTQLRCeCHju0bUfQYVIvcLgIIL92r95RCfOctUfPrYktVHV5799+v0Uq
lPF5chkreA7QoV+GzZ93246PEEYbtYzN6viN5jkMdTvlPQzyhVYfHYezF0pyLwmr
Eyn4pX4SGvHtKG0sq/XeZJoS+ARWq2QF+9id/QzP7qTFXwaQvpTRJyrEN1tzR3Q4
MUih8nxrWmsREA79JAll/YmFiWLbxsFPYInHxEWFHOYuxzzqB9j334U9MkWZiJff
AdaG/uqEpirmwT4WcrT9IR0lAgegX/T/bHmDYM2yQIe951Bn3aq+RXg=
=pDpg
-----END PGP SIGNATURE-----

--W3IDj2RJNlQfFopxcA8dXExg7HeGVzf40--
