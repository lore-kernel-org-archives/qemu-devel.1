Received: from eggs.gnu.org ([2001:4830:134:3::10]:39104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKH6-0001WU-9O
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKH5-00049h-GC
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:48:28 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-21-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df5eb89d-d226-2835-7802-faa4e9c13849@redhat.com>
Date: Fri, 9 Jun 2017 15:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-21-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6fPhTNHUeBdtgnXbXP1svwCN7jrowQfWx"
Subject: Re: [Qemu-devel] [PATCH v20 20/30] qcow2: store bitmaps on
 reopening image as read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6fPhTNHUeBdtgnXbXP1svwCN7jrowQfWx
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <df5eb89d-d226-2835-7802-faa4e9c13849@redhat.com>
Subject: Re: [PATCH v20 20/30] qcow2: store bitmaps on reopening image as
 read-only
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-21-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-21-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
> Store bitmaps and mark them read-only on reopening image as read-only.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 22 ++++++++++++++++++++++
>  block/qcow2.c        |  5 +++++
>  block/qcow2.h        |  1 +
>  3 files changed, 28 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6fPhTNHUeBdtgnXbXP1svwCN7jrowQfWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOqcbEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJC4
B/9KGldvc2BF3tKWF/Hzoy5qF4Vwb+tT7iPRgat/ARJXLgsL6Qd4R5VWUkfD9YL9
auBPQMGz2oJzsCH8J0V1shMTC/8u3Ceq6fyrtt3utIZ0fzdQd6+dCfkwLHRLVcYT
VxI3wVW+ZN1BeDtOHciAvtD4IXKBF510jSn1BEgpB+TSxUmmMHAxapfZVpKvnoYX
XdiOeX35E+695w8V4Q9p7Rd84r6jSyuH7BkksXyOAlNa41k7O2rNzxGIXWsWk2q3
+WQKwe/VsuCFnifB0fqOrfwwn4IQa3hNeqyA/b+uExjKzujZ42K1WpGxzIHkC/0L
xpLEuJDF6VlqO1EJpn2G2E4R
=dGPL
-----END PGP SIGNATURE-----

--6fPhTNHUeBdtgnXbXP1svwCN7jrowQfWx--
