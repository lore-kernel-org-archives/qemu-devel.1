Received: from eggs.gnu.org ([2001:4830:134:3::10]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d42ME-00017Y-ND
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d42MD-00052G-TM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:38:34 -0400
Date: Fri, 28 Apr 2017 11:38:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170428093825.GB4714@noname.redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-4-mreitz@redhat.com>
	<a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.04.2017 um 17:36 hat Eric Blake geschrieben:
> On 04/26/2017 08:46 AM, Max Reitz wrote:
> > I think originally the idea was to remove the individual special case
> > options in the long term in favour of the uniform -o. But I don't think
> > the short options have fallen out of use, so we can as well document
> > them again...
> >
> > Maybe we could change the implementation, however, so that the old
> > options are really just aliases for the respective -o version.
>=20
> As in, a followup patch that adds a paragraph or two to the .texi file
> stating that '-B @var{backing_file}' is shorthand for '-o
> backing_file=3D@var{backing_file}'?

First and foremost, I meant in the C code where we have separate
variables for all the shorthand options and then need to handle both
ways explicitly in the code further down. Instead, -B could just
directly add a 'backing_file' key to a QemuOpts (and -o would do the
same instead of building a string that is parsed only later).

But the documentation change that you're suggesting is probably a good
idea as well.

Kevin

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZAw2RAAoJEH8JsnLIjy/WO9oP/izVmRwjg9j7LUfqM00bTVoc
UGE2ZCeDxrzR3PbVTCD538HawgrCvLVtpzGSS9QQ2rcAFzAERFGEqrRrKmxI45U/
nZ4448P/p1GPz9EzLEg1xAKMGzuB4D4CYajVxnnmbqcLIf9CZoLoO3OwE2ab1aYR
6LOyvke1l/Orl3Q4hCGyfh/Yz7rd3fJxeJZ7a/76PZhwcG0Wh/tl7KqHl7MpHcGs
/n+xgaKvKxUEdykKfCGooQEMrcg+SDn8lFxPu5/qhigLIm6xc0NN+l+eUzNSE7Xd
UbrIKe5g2h8XLqs9Wg6U6IE4XP7YSZ386MuDSAd9EjFd/LIjxs9fAIl83v9qpKep
OKoa4g3dpSEnnaxKzxyz0r4bnGXZe7TDS83zVO42413Bnnog62NHiLGRyrBYgx89
tATxiazUnrykKeYKHrQWHhnShSg5wKBLP1FVYKqP+slMake8KfRJ27QDlZmvgA+n
qSwRzCPv/ahyr0OX8uQpaBwQqQtGDiOBjX1F6rhRxhRw0z2UFxd6lWZpjMUb6ya3
tFhXpQ/uu4eoFhI5fNU+qoWqQYre13yfRq8AQa3tLYVpa4LBW0b5c9wkB2q3oW7F
7rAeEJB2mdQVdMPxLdaZXC/9uVN1yvfBagVL8n0F9ESJYcUW1CRdY6wlnSy7Zo7H
0EahcWYMHKDkQxQGKBbH
=87r2
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
