Received: from eggs.gnu.org ([2001:4830:134:3::10]:49720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI50-0006Mf-5l
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI4z-0004zG-HZ
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:40:30 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-33-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
Date: Mon, 26 Feb 2018 13:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-33-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nV41ZPowEkGNooAXRV1xZLIBtrvddQLk"
Subject: Re: [Qemu-devel] [PATCH v2 32/36] ssh: Support .bdrv_co_create
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
--2nV41ZPowEkGNooAXRV1xZLIBtrvddQLk
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
Subject: Re: [PATCH v2 32/36] ssh: Support .bdrv_co_create
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-33-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-33-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:54, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to ssh, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 16 ++++++++-
>  block/ssh.c          | 92 +++++++++++++++++++++++++++++---------------=
--------
>  2 files changed, 67 insertions(+), 41 deletions(-)

This needs a rebase on my ssh truncation patches (notably "block/ssh:
Pull ssh_grow_file() from ssh_create()") -- good thing for me you need
to rebase, because without those patches you cannot create qcow2 files
over ssh. O:-)

Max


--2nV41ZPowEkGNooAXRV1xZLIBtrvddQLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUAC0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Az/QIAJqu4eDqUkuc90cJKuawfJsrbGGGwV5y
dDYIcurewKkbuCLQ6ZGwZ8+eD9ZyE3HOjhwug8XBpbLxYQ5T+yLvt1nBup68exw9
y2TJkh6n85mqF9LRsoZ8vCzQGKqIojWIr16g/43QtxABfY1VMb0hZ3XDwKE0QUym
909+rpdN0dH13fwgtFhKmX+UmiCyrHw9lgq2clpxFP6IAZT2YirxoAeqUINUNfnB
4MiPO52zIk4A/YaWFan0s8SUr0PqgiVK7FPt2HLIcxTwBtoY1ob+c6S5lV+wqnjI
+xq9w8T413RqCfBUE6Ee7Mi3aJZEsM89Y34eE9RoHX5/qZe79IqkbS8=
=hUQr
-----END PGP SIGNATURE-----

--2nV41ZPowEkGNooAXRV1xZLIBtrvddQLk--
