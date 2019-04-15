Received: from eggs.gnu.org ([209.51.188.92]:54170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4FL-0002Uk-HU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4FK-0008Ss-Ii
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:14:15 -0400
References: <20190415155452.5115-1-kwolf@redhat.com>
	<20190415155452.5115-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8cbce5a-6407-ed72-5344-230733caf7e8@redhat.com>
Date: Mon, 15 Apr 2019 11:14:08 -0500
MIME-Version: 1.0
In-Reply-To: <20190415155452.5115-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ"
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Avoid COW during metadata
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <e8cbce5a-6407-ed72-5344-230733caf7e8@redhat.com>
Subject: Re: [PATCH 1/4] qcow2: Avoid COW during metadata preallocation
References: <20190415155452.5115-1-kwolf@redhat.com>
 <20190415155452.5115-2-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:54 AM, Kevin Wolf wrote:
> Limiting the allocation to INT_MAX bytes isn't particularly clever
> because it means that the final cluster will be a partial cluster which=

> will be completed through a COW operation. This results in unnecessary
> data read and write requests which lead to an unwanted non-sparse
> filesystem block for metadata preallocation.
>=20
> Align the maximum allocation size down to the cluster size to avoid thi=
s
> situation.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0rdAACgkQp6FrSiUn
Q2oMvgf/fwGvs9cOvxAO/oUkGphldiegQoBeVyAxuU6TjcbH4IcOzGo5B85PWCsj
APZRpu1lIoxzWpF75LyIiXlCEbPr0mm+fvxmzqSTv3T6AUoEbZFbaD524r2Kaf6T
bIkWk86xHMQTlUOXNBp2hP5e4KvVCk98mxfJaSic+KfAALoIZzWWEFlydWh4Olnr
Ym2D1DnXtuX6oyFwo19eYyw8mUjiHx/3AGwTaD/mxCi/Is061+PKCMDV8zM9n4pr
CzACPDT1sLK9U+itaraNS6I6dTcSHfDb9EFZ8fOG48bMZ/dSKXI4ZBxhh49B9eLg
JFCugBSM0tehkZZYiU74rwyiVtE9og==
=3son
-----END PGP SIGNATURE-----

--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ--
