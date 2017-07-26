Received: from eggs.gnu.org ([2001:4830:134:3::10]:43638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKZ7-0000oS-Hx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKZ5-0007TP-U8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:33:21 -0400
Date: Wed, 26 Jul 2017 12:33:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726113308.GG18489@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
	<20170725152052.GP23343@stefanha-x1.localdomain>
	<CAFEAcA9J=m+aVWH1piHA=dzXU_ND9O1=whkpis9mb=WM8m_40g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9J=m+aVWH1piHA=dzXU_ND9O1=whkpis9mb=WM8m_40g@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 04:34:19PM +0100, Peter Maydell wrote:
> On 25 July 2017 at 16:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Mon, Jul 24, 2017 at 11:20:44AM +0100, Peter Maydell wrote:
> >> Should ./check be run from the source tree, or the build tree? The
> >> existing README text doesn't say and I don't think your additions
> >> do either.
> >
> > It doesn't matter, both should work.  The script detects both
> > possibilities and rejigs itself to compensate.
>=20
> Does that mean
>  if you run it from the source tree in a tree configured
>  for out of tree build it will:
>  (a) pollute your source tree with test output and binaries
>  (b) give you a helpful message about what to do
>  (c) magically find the build tree somehow
>  (d) not need to write any binaries/test output/temp files at all
>=20
> ?

I think it would fail since the binaries would be missing in the source
tree.

=2E/check handles either source or out-of-tree mode:

if [ -L "$0" ]
then
    # called from the build tree
    source_iotests=3D$(dirname "$(readlink "$0")")
    if [ -z "$source_iotests" ]
    then
        _init_error "failed to obtain source tree name from check symlink"
    fi
    source_iotests=3D$(cd "$source_iotests"; pwd) || _init_error "failed to=
 enter source tree"
    build_iotests=3D$PWD
else
    # called from the source tree
    source_iotests=3D$PWD
    # this may be an in-tree build (note that in the following code we may =
not
    # assume that it truly is and have to test whether the build results
    # actually exist)
    build_iotests=3D$PWD
fi

build_root=3D"$build_iotests/../.."

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeH30AAoJEJykq7OBq3PIvaIIALnpA+iDtB1F9vxHRvL8g92y
mThFR92GttA1vObU6xUXtdqN9um01IO+HT2tsmKkczYmyLsgAxbpLSflMDTOC0EQ
NE71LFm8qOhTl6T+PP91Kcmvy69B3ZVXKcbQSy3E6T+w7kCES7MqNmVMKAdON2hL
ctUmF8qi4dKyW4vdNLwVidnK2KJMcAgw3skVwuIK37EkPLLHopokqo7qLPpH/I+d
X4nmwn8z2nzmdxoZQux1FIv0yqt8CDSU40kzGra6HEyM8MvuIMQneipIincqDGhR
m23W7rssU/E/PIm4m53RhTSLP+vzHxTkWWopBCZkmhdbHTjc2GFjn/0aHBk1Io4=
=qrVD
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
