Received: from eggs.gnu.org ([2001:4830:134:3::10]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlq2-0001BJ-9l
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlq1-0007hf-9p
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:39:18 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <40aae25f-2a7e-8c5a-affa-73a9da67a1e1@redhat.com>
Date: Fri, 30 Jun 2017 04:38:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Om9oxPpU1tD56MQCNIAPumhUtx1FdlqEd"
Subject: Re: [Qemu-devel] [PATCH v22 00/30] qcow2: persistent dirty bitmaps
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
--Om9oxPpU1tD56MQCNIAPumhUtx1FdlqEd
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <40aae25f-2a7e-8c5a-affa-73a9da67a1e1@redhat.com>
Subject: Re: [PATCH v22 00/30] qcow2: persistent dirty bitmaps
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-28 14:05, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> There is a new update of qcow2-bitmap series - v22.

Thank you for all the work.

After resolving some conflicts with the qcow2 LUKS series (and after
bisecting some unrelated iotest 055 breakage), I've applied this series
to my block branch:

https://github.com/XanClic/qemu/commits/block

(I've also fixed the indentation issue Eric has found in patch 17.)

Max


--Om9oxPpU1tD56MQCNIAPumhUtx1FdlqEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVbnDEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGR7
B/0VcUTfeq0MO1svzlrwCu/xUvnFSdOER7X4NZ8QEresVWteQum3wg0tzXsbYwxT
jzw6BhGJtf+BIWKAh3YQBqU+3N8gDCgCCffgkgQr33aVIQGwUAwTUMnQS9feLvmE
6RA81o9HrRxL1ow43b1SLm9a9gJw1ELhV1Nv2M3pJW6sbeUwEf4hkP5vEg2swQvO
2nnlqVpU+KIEo1ZzyXxvlpPQHRWxISuaDHU2tO3Z6or/VNg4Na1LXfacRvYCXlzc
kXAVT94qxcmvKi9JaYF07wOdlKG1cG1uYWLsH6CjFUdINmb6XKITrnwr69mw/SGF
zgaZSYce8/dC5VectZj8NMbe
=1RrY
-----END PGP SIGNATURE-----

--Om9oxPpU1tD56MQCNIAPumhUtx1FdlqEd--
