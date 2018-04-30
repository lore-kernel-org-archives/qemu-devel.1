Received: from eggs.gnu.org ([2001:4830:134:3::10]:53807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8I1-0000B9-It
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8I0-0003jM-JO
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:52:21 -0400
Date: Mon, 30 Apr 2018 13:52:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180430125210.GA10576@stefanha-x1.localdomain>
References: <20180421163957.29872-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180421163957.29872-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: Check
 post-truncation size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 21, 2018 at 06:39:57PM +0200, Max Reitz wrote:
> Some block drivers (iscsi and file-posix when dealing with device files)
> do not actually support truncation, even though they provide a
> .bdrv_truncate() method and will happily return success when providing a
> new size that does not exceed the current size.  This is because these
> drivers expect the user to resize the image outside of qemu and then
> provide qemu with that information through the block_resize command
> (compare cb1b83e740384b4e0d950f3d7c81c02b8ce86c2e).
>=20
> Of course, anyone using qemu-img resize will find that behavior useless.
> So we should check the actual size of the image after the supposedly
> successful truncation took place, emit an error if nothing changed and
> emit a warning if the target size was not met.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1523065
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Drop dots in {error,warn}_report() messages [Eric]
>=20
> v1: http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00441.html
> ---
>  qemu-img.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5xF6AAoJEJykq7OBq3PIQh8IAK9x7vf1WNvcmkt/XbVn6au5
I2g/EyCcsID4DBlEvRpwRFUCvxdkTmjiFIILym4sNvDDX/kJbd1Yuy0rgxSecRDr
IMcjr4KXZU99oiWOZ/4RHeiXuABu4aht/NKNgZTPdUTf/EpCC4kgYLc3BbgQxibu
d8aSHzHJt80gvaxXOA6rZs0yeL1c4wn6cCP8ekIg5lDfnaTj9pLvls/Jt7rpsgKg
XbqzBcPe17Z1EKaHM69Qs6P0PicstIfFL5aPifYu1gT3Xhm/r/Bpr8wLmdFE4JEB
wsbQ1vfUW8HvvBnI1czugwXjo3aMzYSznBnK+38NvFd7rM/Zvzn5EzdOz39qyCc=
=S7+7
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
