Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTXH-0001rh-4X
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTXD-0007wS-E2
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:10:51 -0500
Date: Tue, 17 Jan 2017 13:10:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170117131039.GH4265@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-4-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <1480926904-17596-4-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/6] replication: Split out
 backup_do_checkpoint() from secondary_do_checkpoint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:35:01PM +0800, zhanghailiang wrote:
> The helper backup_do_checkpoint() will be used for primary related
> codes. Here we split it out from secondary_do_checkpoint().
>=20
> Besides, it is unnecessary to call backup_do_checkpoint() in
> replication starting and normally stop replication path.
> We only need call it while do real checkpointing.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  block/replication.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfhfPAAoJEJykq7OBq3PI51cH/2pvIFmamelZt2wsA1eAKl0Y
F6J9LH2TPUablXyN8rcqB1jeuNIsnlGjZ1kmhiEI1Z374Mh2HJy2I9Y1iKQPQjey
51x5CMhlb3tL1wYkqvuRIey4nyyxoQJv+y9+mog332g7dzrQyqvX+4Gh2HSRcSfM
ajGTTFWcH0FMOao4B+rAPCe7lPld7SKPZw2bayqPG9cDZtVpY38qIlzkL+E8nC7Q
mzCQtX+d/EkPdQvmahBo4u4sgx1AS5Xz78bx0T/CHLBO48Dy08fYjMVNclgGFZhS
TSqRdhMPxOXpu088hmd9Tz4y4bmqNAWUfQu80TINzq67kK1RF9v86dhSkR0dn+M=
=mGKg
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
