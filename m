Received: from eggs.gnu.org ([2001:4830:134:3::10]:47810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNNWF-0008U8-B1
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNNWE-0005qV-I4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:09:23 -0400
Date: Mon, 28 May 2018 21:09:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528190915.GK4580@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.05.2018 um 20:44 hat Max Reitz geschrieben:
> On 2018-05-28 20:38, Kevin Wolf wrote:
> > Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
> >> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
> >>> As someone who is just naive and doesn't see the big picture, I don't
> >>> see what's wrong with using a tar file that contains the image and
> >>> additional data.
> >>
> >> FWIW an OVA file is exactly this: an uncompressed tar file containing
> >> disk image(s) and metadata.
> >=20
> > If we combine VM configuration and the disk image this way, I would
> > still want to directly use that combined thing without having to extract
> > its components first.
> >=20
> > Just accessing the image file within a tar archive is possible and we
> > could write a block driver for that (I actually think we should do
> > this), but it restricts you because certain operations like resizing
> > aren't really possible in tar. Unfortunately, resizing is a really
> > common operation for non-raw image formats.
> >=20
> > And if I think of a file format that can contain several different
> > things that can be individually resized etc., I end up with qcow2 in the
> > simple case or a full file system in the more complex case.
>=20
> Well, you end up with VMDK.

I don't think VMDK can save several different objects? It can have some
metadata in the descriptor, and it can spread the contents of a single
object across multiple files (with extents), but I don't think it has
something comparable to e.g. qcow2 snapshots, which are separate objects
with an individual size that can dynamically change.

Kevin

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDFPaAAoJEH8JsnLIjy/WulMQAIFRsmTIJEk6VthNabdjRWHM
8XIHz4cfMByrA06yrTDf0yHlK5xkk/zfvOvFi36SCWYHPf0nk4F4yZiQdWU+DGwu
9Smqqxby0KgexDEkjWalkzaDzPAtVDMmPse52MiCTW0+bMrorOAmEV2N86wR1OTl
x9AFNywnu7Dhq8qV4OX5eJijynH7RwoRIyF3elNiPKUR+E4pwzIHrNOQm4UWseT1
lYWL5tJYNwfIx32w8qfb4BzwHybV6d9bjP1VHilZY/glR9qXENTIRDo3hHwDSNSF
I3FieLHAu+qsos0r8YaFORegPg/9tcKzjaCJnX06gCqgk0/ntkCZtgycYarHlelt
/95VJ4bY6SS8EPxWwcx19OkYf+REWocIIFW4OuJy43hXNIJse7bfyLZOEXAgzSof
6aZhayFrWv0uVadxpO1XgoycL2WGQ+XolTx8Q2KW8ISasrlNcVkEntVsRJv56Rv5
Lp6tRmvT/2NPAh4cxS7tWtMFmNO2kQRaIKqqYA5BmVY1yjqfOzJRGwn94WfBYrXL
zxWwmL5T6bElmydgAHR7jg4NRKD9/5fE3P/GMiM9uGljEJWgmblbRnJLm+GidGmV
uxkb7v+1xcQWs9pu3GM1QOi8SwYcrHlb8X2JYzWM6y6wk5HD3RbgpjMF+a8O36tt
7i7E4PNXAyT70jPbmZoj
=8iDF
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
