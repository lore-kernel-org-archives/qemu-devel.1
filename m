Received: from eggs.gnu.org ([2001:4830:134:3::10]:54174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYX7d-0003IY-Bq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYX7Z-00056R-E9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:33:33 -0400
Date: Fri, 21 Jul 2017 13:33:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721123325.GC18014@stefanha-x1.localdomain>
References: <20170721034730.25612-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20170721034730.25612-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> This is a follow up to a previous discussion about reported failures when
> running some qemu-iotests.  Turns out the failures were due to missing
> libraries, which in turn, reflected on the host build configuration.
>=20
> This series introduces a tool that can check both host and target level
> build configurations.  On top of that, it adds a function to to be used
> on qemu-iotests.  Finally, as an example, it sets a test to be skipped
> if the required feature is not enable on the host build configuration.
>=20
> Cleber Rosa (3):
>   scripts: introduce buildconf.py
>   qemu-iotests: add _require_feature() function
>   qemu-iotests: require CONFIG_LINUX_AIO for test 087
>=20
>  scripts/buildconf.py         | 278 +++++++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/087       |   1 +
>  tests/qemu-iotests/check     |   2 +
>  tests/qemu-iotests/common.rc |   7 ++
>  4 files changed, 288 insertions(+)
>=20

It should be possible to run iotests against any
qemu/qemu-img/qemu-io/qemu-nbd binaries - even if no build root is
available.

How about invoking qemu-img and tools to determine their capabilities?

At the beginning of ./check, query the qemu/qemu-img/qemu-io/qemu-nbd
binaries for specific features.  This produces a set of available
features and tests can say:

  _supported_feature aio_native

This feature can be checked by opening an image file:

  qemu-io --format raw --nocache --native-aio --cmd quit test.img

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcfSVAAoJEJykq7OBq3PIYNIIALFqx8PI2I6CZU09gQaW+FfB
6mlK4l2jE21+43gwu4/Wn9DeSU28xOBvthwhdnhSdXWxpT0mPRs94X+9E1AHy9RQ
iz/qNpXvC0OPbTfYcd8dJ2mddn/G30B9Mt6c/Wiklau/Udj6WSZL9nSscqeEfZMR
p3z9c19LNwGZtxJlCNHnyYA4YRDxxPkzitu5+/uhZYSo2ChLsyTGoW2VP2ge7aNE
GKNIfdD4muJQ+Z1uVPEcw576zV7Ae2z5J3M/URR8cu0wpP37IM736ZFlmaBxPdVY
Vb3qn9x07KLygY16U29ZArNoa3x6qbpaX0BmTkEVnPRegNzMVO3FOMvOvdVPmPU=
=uk2v
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
