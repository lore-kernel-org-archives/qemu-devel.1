Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfltG-00038t-Lf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfltD-00038A-Fv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:12:22 -0500
Date: Mon, 20 Feb 2017 11:12:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170220111214.GF21255@stefanha-x1.localdomain>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<20170215152013.GH24672@redhat.com>
	<CAMRbyyv4gGDG1f5tbb8NTtWPdWC+23OT2GKcrLLOuo4N2Prrkg@mail.gmail.com>
	<20170215160743.GJ24672@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20170215160743.GJ24672@redhat.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-discuss@nongnu.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 04:07:43PM +0000, Daniel P. Berrange wrote:
> On Wed, Feb 15, 2017 at 05:57:12PM +0200, Nir Soffer wrote:
> > On Wed, Feb 15, 2017 at 5:20 PM, Daniel P. Berrange <berrange@redhat.co=
m> wrote:
> > > On Wed, Feb 15, 2017 at 03:14:19PM +0000, Stefan Hajnoczi wrote:
> > >> On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
> > >> > I was wondering if that is possible to provide a new API that
> > >> > estimates the size of
> > >> > qcow2 image converted from a raw image. We could use this new API =
to
> > >> > allocate the
> > >> > size more precisely before the convert operation.
> > >> >
> > >> [...]
> > >> > We think that the best way to solve this issue is to return this i=
nfo
> > >> > from qemu-img, maybe as a flag to qemu-img convert that will
> > >> > calculate the size of the converted image without doing any writes.
> > >>
> > >> Sounds reasonable.  qcow2 actually already does some of this calcula=
tion
> > >> internally for image preallocation in qcow2_create2().
> > >>
> > >> Let's try this syntax:
> > >>
> > >>   $ qemu-img query-max-size -f raw -O qcow2 input.raw
> > >>   1234678000
> > >>
> > >> As John explained, it is only an estimate.  But it will be a
> > >> conservative maximum.
> > >
> > > This forces you to have an input file. It would be nice to be able to
> > > get the same information by merely giving the desired capacity e.g
> > >
> > >   $ qemu-img query-max-size -O qcow2 20G
> >=20
> > Without a file, this will have to assume that all clusters will be allo=
cated.
> >=20
> > Do you have a use case for not using existing file?
>=20
> If you want to format a new qcow2 file in a pre-created block device you
> want to know how big the block device should be. Or you want to validate
> that the filesystem you're about to created it in will not become
> overrcomitted wrt pre-existing guests. So you need to consider the FS
> free space, vs query-max-size for all existing guest, combined with
> query-max-size for the new disk you wan tto create

QEMU can certainly provide a --size 20G mode which returns data size
(20G) + metadata size.  Of course, an empty qcow2 file will start off
much smaller since no data clusters are in use yet.

It's worth remembering that operations like savem and internal snapshots
can increase image size beyond the conservative max estimate.  So this
estimate isn't an upper bound for the future, just an upper bound for
qemu-img convert.

Stefan

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqs8OAAoJEJykq7OBq3PIMcIH/08XD2olIRdtVIn2xr9Jy/tc
nhedrqCFRntOvN1SaDWxC8Fzy8qxHXHcwUY7gdImdAT1cd6b5qHMdSgDMpV7AAjq
40thMOLgLz8WW6gMzXkvx6eXZ6myvt86npysVNQX9XzL0RFaqWmqEDLgudhpN/r+
pMbhK0r9aLD4/PoqFKLwa/VLgrQCQUPdSUSfma1LYfZWuFVtjOwfHb3jI6VyZYwY
Ai9bmazmfenFlARwTWPoeiS7e3P58NQfSqG7zFRBp1O1U7UANdXHjue8NaIPPrVw
q4Yvg+XJDNfPpic6nCnHP9gfiPk7L/sKjC5l/jX20tcWOHLRf1LqRuKHoVPG0pk=
=J7LS
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
