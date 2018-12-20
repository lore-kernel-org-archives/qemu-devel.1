Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ga1KX-0003eM-Qi
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ga1KU-00060J-L7
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:37:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ga1KU-0005zO-EX
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:37:46 -0500
Date: Thu, 20 Dec 2018 16:37:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181220163738.GA5662@stefanha-x1.localdomain>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20181220152030.28035-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2018 at 04:20:28PM +0100, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
>=20
> It is possible for an io_poll/read/write callback to be concurrently exec=
uted along
> with an aio_set_fd_handlers. This can cause all sorts of problems, like
> a NULL callback or a bad opaque pointer.
>=20
> V2:
>     * Do not use RCU anymore as it inccurs a performance loss
> V3:
>     * Don't drop revents when a handler is modified [Stefan]
> V4:
>     * Unregister fd from ctx epoll when removing fd_handler [Paolo]
>=20
> Remy Noel (2):
>   aio-posix: Unregister fd from ctx epoll when removing fd_handler.
>   aio-posix: Fix concurrent aio_poll/set_fd_handler.
>=20
>  util/aio-posix.c | 90 +++++++++++++++++++++++++++++-------------------
>  util/aio-win32.c | 67 ++++++++++++++++-------------------
>  2 files changed, 84 insertions(+), 73 deletions(-)
>=20
> --=20
> 2.19.2
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcG8VSAAoJEJykq7OBq3PI4u0H/RL5BCS1wt3ZKf8ckP9yA1Ff
wh26M5CDjOVcdJ0SDL5LtG+mqQAuajwBhCv8PHkjIErZ7myflKf1+xArFUVExAOT
eDk7Wf+JRmqFSx052XBMsDN+LEJplTQtCcl4BMTHXuSJHzY2jnyeDwRO7KSISsJY
FPl+2/HlHY5Jf45SmnE5jmqVX1r4c1yqpydysWSzFZcdDowTM7+iP4khiyxFCnMZ
kHtFiwT72pRslUCcbNB7cy1j24qHRdBrlrX9RT105+AcuEIpDY819c1s898syOXx
lmPMztfCGQVrVpKYH+3bEG3WdPWlg/7seCcBWYJ3hE/+JgoGkI407ctsTg1HVdQ=
=/W/D
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
