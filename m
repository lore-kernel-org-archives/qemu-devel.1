Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBr6-0005YF-88
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBr1-0006vH-4w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQBr0-0006us-Um
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:13:55 -0400
Date: Wed, 28 Jun 2017 13:13:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170628121352.GC7538@stefanha-x1.localdomain>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 06:40:04AM -0500, Eric Blake wrote:
> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
> > Avoid duplicating the QEMU command-line.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/068 | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
>=20
> > +# Give qemu some time to boot before saving the VM state
> > +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
>=20
> Are we sure that 'bash' on PATH is the same as the /bin/bash running the
> script?
>=20
> Also, while bash has more deterministic behavior for 'echo -e' (it is
> non-portable if you are porting a script to other shells), it is still
> possible to set bash to a mode where it does not work (see xhopt
> xpg_echo).  I'd much prefer you use 'printf' instead of 'set -e'.

Do you want to send a separate patch?

The purpose of this patch was just to move this code.

Stefan

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU52AAAoJEJykq7OBq3PIQSMH/1+MUhOphgKNCSEqqCr8Y83O
Q59YaPSbtXbG7oPr5i+JaZPEXU2l9UQp4cKxc1vc7K8yDa93uri2fzdxukBgY/aG
saJilCK4SmeIZcL01wl4AAY1MLuD3IhUST8wXkckvg9+dtuTv7CVrhSeSE6X80hH
iaIoLhC4zMUOeIi/2zwvT+UCrCpJx1o0+qOdPtCYsZ0ni6mX77EUFWW0vBRT9BEG
3M24cxKY9Fh5par+D/kqEhV017lmf3IzmHvyrW2KliPXjvGAk2RFqIK1rQpw5neK
ouXxM/l0kQ9hY/lPTbLIFP2N4+SNDIb6a0+MUPmcFQJpUUj/e/YxEvW3lGmaCFI=
=6bpZ
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
