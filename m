Received: from eggs.gnu.org ([2001:4830:134:3::10]:37976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2Kn-0000gJ-MO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2Ki-0000YN-QJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:40:25 -0400
Date: Thu, 6 Jul 2017 09:40:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706084015.GB30447@stefanha-x1.localdomain>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-2-el13635@mail.ntua.gr>
	<8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
	<1b82e5ed-73b1-34d6-9958-dfc45bebedfc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <1b82e5ed-73b1-34d6-9958-dfc45bebedfc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/3] block: pass bdrv_*
 methods to bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 01:40:57PM -0500, Eric Blake wrote:
> On 07/03/2017 10:56 AM, Eric Blake wrote:
> > On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
> >> The following functions fail if bs->drv does not implement them:
>=20
> One other suggestion: most patches in the tree use 'topic: Capital',
> while yours used 'topic: lowercase'.  It's probably worth posting a v3
> that addresses all of the nits I've pointed out, including tweaking the
> commit messages.

Plenty of regular contributors use "topic: lowercase" including Michael
Tsirkin, Mark Cave-Ayland, Peter Xu, and myself (just from looking at
the first page of git log --oneline on qemu.git/master).

If we want to enforce a consistent style in the future then it should be
discussed separately.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXfdvAAoJEJykq7OBq3PIlxwH+gJTTfptgBoZiAaCc3fG9v/i
nhrAT0QFuPAMWVlAr/iEEKw0/aHN3W7WFU3TSkB1VKh2CMRwyOh9l5OCDw/J/5gh
CDm6vd7vnxtcnU2Y+QXfDpGjTMFWCizXffM+Py3BSvEFPyOLQj3wBW0agOWN6AMK
etMOFTzHYQtEDSIUBMwEQJe6/pZvqZ4RxVmCFrFTD3k5O+ZlpmFFeLcBSUEofZU+
qw1TuPlh3CH9yQXuBeqkJUGf+Zhp4U4kfLO+oXkWpAEKdSasrlh6i9FjoJ2VqWjb
HdaLV1wknOrrP50cexji1Jl2iHe5n+mHdbrM1Q41JrLyNpdioA7BMQLPj1MRjng=
=7io6
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
