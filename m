Received: from eggs.gnu.org ([2001:4830:134:3::10]:32936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNH8L-00026B-IW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNH8K-0004Ud-RW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:48:01 -0500
Date: Fri, 8 Dec 2017 12:47:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171208114748.GA4217@localhost.localdomain>
References: <20171208014456.16635-1-famz@redhat.com>
	<20171208095412.GC23880@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20171208095412.GC23880@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, kchamart@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.12.2017 um 10:54 hat Stefan Hajnoczi geschrieben:
> On Fri, Dec 08, 2017 at 09:44:56AM +0800, Fam Zheng wrote:
> > +@item --force-share (-U)
> > +
> > +If specified, @code{qemu-img} will open the image with shared permissi=
ons,
> > +which makes it less likely to conflict with a running guest's permissi=
ons due
> > +to image locking. For example, this can be used to get the image infor=
mation
> > +(with 'info' subcommand) when the image is used by a running guest. No=
te that
> > +this could produce inconsistent result because of concurrent metadata =
changes,
> > +etc.
>=20
> The documentation isn't clear on whether read-write is supported or just
> read-only.
>=20
> Also, should it be declared a legacy option right away to discourage
> use in new software?

I don't think this is a legacy option. As long you know what you're
doing, using it is fine.

Kevin

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaKnvkAAoJEH8JsnLIjy/WIwIQALYKNWbThfOseVUHZvhkB6qU
2RhxMPIHCH2sM4pdVV7Ee/lJyaeYnxD0Gw+9EeZYinRpN9lfrPznB6P0dwP7LJcU
2XxrQPc6BMuy4fGXxXnxLSgW9sk8edg9wrMgQkzR6zglw8j2d1/l4j1u7hBbTU7y
JvL0kNBvH0aFyl3T+CAh+TKzIAM4WrcInYsNYSv3JuFMAVQkZfvWKNy35ibuBQaW
LFXaaaLWcvQAw8TtgUVt4Z8cC3SqmlkqBbJuZAlPT4FqbbZDlU2DqSRLnXP0MvI6
8kuqkMXKe4HltBEgo91UOcG4Uu45MawCtGnC0YdZQM/W9o7vjviz+9xcz2w26zRs
N8+EpuU6SlhaAbvDawDeTy5R5llu5I+b3ol3bvshXqYZ5PYSp5cZ2wdatQ7Rk0Qx
Fr1Pd8kaEeXGs1E1mllA/Az5VbKc2jwzpedQchZDpKud7AtEMmO7vgF/xYOIUQ3f
OTX36l4eSV0Z6WMH/HY5ZfMx02bzUd/7r7YmJ6gc4b1pym7WBjeN555QnqwPip66
O1/Cmw2+clxkcne4dE6bhRk6dCVrg+SmnQfsw5Sj0CeucxoWSblXL+l8B0DqiRNu
5kM4Qr+6UiCIZlQGxsvlHlKdKoZ1GBsFtKDveGk99gnjMoEbBOEwwH9dqZgu7XmD
XUlYUEfJ/UcFsIODNrPP
=3QHL
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
