Received: from eggs.gnu.org ([2001:4830:134:3::10]:39327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMGs-0006QB-P5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMGo-0002TP-T4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coMGo-0002T2-Nh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:40:10 -0400
Date: Thu, 16 Mar 2017 11:40:03 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316034003.GJ11074@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-4-stefanha@redhat.com>
	<a04f6be2-710a-4f12-b2da-1c631670a236@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <a04f6be2-710a-4f12-b2da-1c631670a236@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/8] qcow2: extract preallocation
 calculation function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 02:18:36AM +0100, Max Reitz wrote:
> On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> > Calculating the preallocated image size will be needed to implement
> > .bdrv_measure().  Extract the code out into a separate function.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/qcow2.c | 134 +++++++++++++++++++++++++++++++++-----------------=
--------
> >  1 file changed, 76 insertions(+), 58 deletions(-)
>=20
> So let's see whether it will be this or
> http://lists.nongnu.org/archive/html/qemu-block/2017-03/msg00342.html
> that lands first! ;-)

Ha, thanks for pointing that out :).

Stefan

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYygkTAAoJEJykq7OBq3PIPzMH/0IHHZdLgdFzZ937C1hv29JG
1ZruzwR5IbEVR9DEps0vVwidP0cXtnnjSXuXJN/0MR5JwwXhoO23zn8VU7/ysjY+
3J6Qar4j2W8lwCcGOWt3qYU3/wx06xXfDnuDCIu0ZqyYv9r/rcLgwIy5RYTPqSQz
TTJTLlKMMKc6X0KQ3QvgOsgCKvQSHuZdAYjFlp8zjDQDqgNGElJSOl/j123JqtFv
PBvtaxUzvEL/QvzGb/lhQsLzhPctrq7vjodACHYo6bovY9KRs0/rlZplvA3IRQjM
wRLIuWpWjV4HLTkVsATiP+cGnYfP7Sk5I8Fjqmu0g88uVfA/1IKaBAacbgXieg8=
=n3OS
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
