Received: from eggs.gnu.org ([2001:4830:134:3::10]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekD2n-0008Gm-RF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekD2n-0007mE-1r
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:05:05 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68a84e1e-dee6-8e8a-2b0e-bd5e7756c337@redhat.com>
Date: Fri, 9 Feb 2018 19:04:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Esseu1T7EQ9b0XJVp0mXw3RBi4JFcmrFq"
Subject: Re: [Qemu-devel] [PATCH 07/27] qcow2: Handle full/falloc
 preallocation in qcow2_create2()
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
--Esseu1T7EQ9b0XJVp0mXw3RBi4JFcmrFq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <68a84e1e-dee6-8e8a-2b0e-bd5e7756c337@redhat.com>
Subject: Re: [PATCH 07/27] qcow2: Handle full/falloc preallocation in
 qcow2_create2()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-8-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Once qcow2_create2() can be called directly on an already existing node=
,
> we must provide the 'full' and 'falloc' preallocation modes outside of
> creating the image on the protocol layer. Fortunately, we have
> preallocated truncate now which can provide this functionality.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Esseu1T7EQ9b0XJVp0mXw3RBi4JFcmrFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp94scSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqwMH/0LLirIGKiR9+wh9SN3Wj01EUTtEPE7r
JRtIed1cgC/77liikSSSHGUId2OS6zZOlGP2HHTFVRiPWK0JkoUXG6n3uxtv3aVc
LwqzwYbCKt/f9uNXhIFkymtwOfT0GZdVQ4p1C+K8tIqRue1svNB9kME6696LM3tZ
LomcTni2gsOf9lulWbyVKtmzTYeyU0N8ydt5pLndn5WmpjoJnKGZHjM6g3bde9c4
tq/86I6FIAewJ9Ai2PMufWs4q1UuSp3qNxN2/kVCXbGyzOGubYg8NJPtw8Gng62y
BvJGuIl3jpN/3QwlP71qjiYhFKxbbM+jkfWf/NFoXua7nDwAShXp66Y=
=OVzq
-----END PGP SIGNATURE-----

--Esseu1T7EQ9b0XJVp0mXw3RBi4JFcmrFq--
