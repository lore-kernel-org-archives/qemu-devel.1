Received: from eggs.gnu.org ([2001:4830:134:3::10]:58302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNbeI-0000XZ-Rk
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNbeH-0004HV-S6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:38 -0400
Date: Tue, 29 May 2018 12:14:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529101428.GB4756@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
	<20180528190915.GK4580@localhost.localdomain>
	<233d8d33-1865-9100-aa1e-07979473f495@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <233d8d33-1865-9100-aa1e-07979473f495@redhat.com>
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.05.2018 um 11:23 hat Max Reitz geschrieben:
> On 2018-05-28 21:09, Kevin Wolf wrote:
> > Am 28.05.2018 um 20:44 hat Max Reitz geschrieben:
> >> On 2018-05-28 20:38, Kevin Wolf wrote:
> >>> Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
> >>>> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
> >>>>> As someone who is just naive and doesn't see the big picture, I don=
't
> >>>>> see what's wrong with using a tar file that contains the image and
> >>>>> additional data.
> >>>>
> >>>> FWIW an OVA file is exactly this: an uncompressed tar file containing
> >>>> disk image(s) and metadata.
> >>>
> >>> If we combine VM configuration and the disk image this way, I would
> >>> still want to directly use that combined thing without having to extr=
act
> >>> its components first.
> >>>
> >>> Just accessing the image file within a tar archive is possible and we
> >>> could write a block driver for that (I actually think we should do
> >>> this), but it restricts you because certain operations like resizing
> >>> aren't really possible in tar. Unfortunately, resizing is a really
> >>> common operation for non-raw image formats.
> >>>
> >>> And if I think of a file format that can contain several different
> >>> things that can be individually resized etc., I end up with qcow2 in =
the
> >>> simple case or a full file system in the more complex case.
> >>
> >> Well, you end up with VMDK.
> >=20
> > I don't think VMDK can save several different objects? It can have some
> > metadata in the descriptor, and it can spread the contents of a single
> > object across multiple files (with extents), but I don't think it has
> > something comparable to e.g. qcow2 snapshots, which are separate objects
> > with an individual size that can dynamically change.
>=20
> Right, I tried to be funny and was over-simplifying in the process.
>=20
> What I meant is: You end up with an image format that is spread on a
> filesystem, like VMDK is (usually).  Then you have some metadata
> descriptor file that describes the rest and multiple data object files.
>=20
> (For completeness's sake: And you can use an external or an internal
> filesystem, that is, use multiple files (like VMDK) or have an internal
> filesystem (like tar, except tar doesn't allow fragmentation).)

Let's call the libvirt XML the image file and the qcow2 files its
data object files and we're done?

I'm afraid spreading things across multiple files doesn't meet the
requirements for the problem at hand, though...

Kevin

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDSgDAAoJEH8JsnLIjy/WeCcP/RJx9eqRpHvI7zo5ch0rPIFe
3RQezys4c2fSIHL5MsVtJs4H2vbiZywl+W3q8G+wbPn/Mc/IJcPRu0lwj8Uv5D+D
uJIDbbMbu1bNgpQhTuSLsEYKMUvrDjA+ZUHmNGDFjxNEB+EacUWrrrIUXZTj+mNY
Pw3b6MWmlh0rjOOYmp6TigHz/PKRLw5ruyXKeZ0hwLVLKjI9mGm+19A6CeBC0quV
OF+wmps8RGZA3O8kWLQGn7jcaIpw7aB8bMZqORnoVgVr0mfgvMzM/GEbNGDeWgVC
XPhaTOf4HtQt22n4gfDzFBdKM1GvTcx8RLmpOJzmgQ6l+5oq9rlUEEze31yMKlGI
SPZpIevi327182SV/dXmnsu1Us23+wZyquPX7CL1PQbqV5/k3ohuLm7Bibg9syer
FvYDlW4UVBU10cfIaDRi9k4g/8hNh2YdjPaYP+5HeN0w7NPcOcPr+Gwut3X/aC3+
MHIGpvP2kFXJWNTvBwz0h98jUBh6JDfEyADUQyA5R+13aYoFyq+1i1q/m7C3gS3v
oxe5iRiRnXey2Sm9BOPbTFM4qCCIE0fLjNb4ddY2gYFDkJQP1W5zl8p2jCjLPFQQ
FKckrHbXw4aFPwUFy7I7kwFACoAOu7SeubF7C5b5qqS24CmKvE31LhWOu5P9KMf1
CYnVkR9EP3/jUI/4q8U7
=4nuo
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
