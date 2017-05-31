Received: from eggs.gnu.org ([2001:4830:134:3::10]:54482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0zd-0005ZE-UA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0zd-0002NV-4u
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:36:45 -0400
Date: Wed, 31 May 2017 11:36:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531103635.GI15666@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-14-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-14-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 13/16] block/qcow2: Rename
 "fail_block" to just "fail"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:15PM +0200, Max Reitz wrote:
> Now alloc_refcount_block() only contains a single fail label, so it
> makes more sense to just name it "fail" instead of "fail_block".
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-refcount.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpyzAAoJEJykq7OBq3PIBEEH/RgDHWB6laTZFiVOdKUFfXoA
KNrVqHhITZ8KQrJIZMpmZE4wYPYks0tnOeFewzsXpEzcLCV0iVdFAaGqgbgWQw2a
4qwJ9iMIlDzGT6lYJnHhfQAwG3f3Get5r2hkwlts/XobXCWEhfelq2WQ4SlzmLv3
1IIzwPeC5Aacmb8RS9D59xJhaVY/8tcVqhWMP/2f6XII3pkRqTb7/XJ4HPsSUpzP
97RlffRKw9SpPDLXS02fZD+BgHtkR/YMjHnwnhZqYDAme/dxntd8HOJxkRia5bry
sbp6ypV2lsy9aR37/OIBOTO3WXOdJVHA3urAEqLB9IrIoYePG9I2Awcoz7L7/aM=
=mgJ0
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
