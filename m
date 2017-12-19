Received: from eggs.gnu.org ([2001:4830:134:3::10]:39043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRE0C-0000T4-65
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRE0A-0000Pn-39
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:15:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRE09-0000On-Rf
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:15:54 -0500
Date: Tue, 19 Dec 2017 09:15:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171219091551.GA9977@stefanha-x1.localdomain>
References: <20171218143530.12082-1-stefanha@redhat.com>
	<CAFEAcA8fBMYV_uvphxadgXbfzAb+BoOhWVdvX5q4=fXsGBoj3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8fBMYV_uvphxadgXbfzAb+BoOhWVdvX5q4=fXsGBoj3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/23] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 12:15:18AM +0000, Peter Maydell wrote:
> On 18 December 2017 at 14:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfab=
e259:
> >
> >   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017=
-12-15-1' into staging (2017-12-17 15:27:41 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to 585426c518958aa768564596091474be786aae51:
> >
> >   qemu-iotests: add 203 savevm with IOThreads test (2017-12-18 13:12:53=
 +0000)
> >
> > ----------------------------------------------------------------
> >
>=20
> This failed 'make check' on all hosts:
>=20
> TEST: tests/virtio-blk-test... (pid=3D49005)
>   /arm/virtio/blk/mmio/basic:                                          **
> ERROR:/home/pm215/qemu/tests/libqos/virtio.c:94:qvirtio_wait_queue_isr:
> assertion failed: (g_get_monotonic_time() - start_time <=3D timeout_us)
> FAIL
> GTester: last random seed: R02S8877aa3278e71261919aae7707897a80
> (pid=3D49024)
> FAIL: tests/virtio-blk-test

Thanks, didn't notice it because x86 passes and Travis was looking
flakey.  Will send a v2.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaONjHAAoJEJykq7OBq3PIURsIAKdyC/GKslvAUgZUxx3nKrtI
C1oYCoA7ryrl+mvw9ehDLGvO84zd9GY/9CgC7BoPxpStXImLDZCM8bYbpy1ttvfo
Tti4/3QgDTBeSCMcta2L7WKUHQOhFeqKuivltjLcqI3ZEYk7YeCdNLhNH7XzurRD
6V9WK/RGeVi8ZsX5wAm6VKIWyvg09LSqZBLEYxfKhnJohcPce6hKT41LONe6Dz3Y
0TpyniAHhVEdm8aGkUVFpzPqn+mEFURQlrca2PX3FrCf749vy34W/P8e+q+mLTK9
42FlwHCLfv72EfCLYKQPrtiiPJjmTL0ojpUZZgG78oW5/L2EhGzL0tRk9lEdTyA=
=nEhJ
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
