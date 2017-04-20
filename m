Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d19eB-0008AM-DS
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d19e8-0004xE-8U
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d19e8-0004wf-2U
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:49:08 -0400
Date: Thu, 20 Apr 2017 11:49:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170420104902.GD28129@stefanha-x1.localdomain>
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-2-stefanha@redhat.com>
	<09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
	<20170419132737.GF3343@stefanha-x1.localdomain>
	<8c7093c1-8c10-c36c-3628-421664ca02be@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <8c7093c1-8c10-c36c-3628-421664ca02be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 08:32:06AM -0500, Eric Blake wrote:
> On 04/19/2017 08:27 AM, Stefan Hajnoczi wrote:
>=20
> >>
> >> I know we haven't done a good job in the past, but should we start
> >> trying to do better at documenting callback constraints of new things
> >> added in this header?
> >=20
> > .bdrv_measure() is a 1:1 pass-through of the public bdrv_measure()
> > function.  All the public function does is to dereference
> > drv->bdrv_measure.
> >=20
> > I think that's why many of the other callbacks also have no
> > documentation - they inherit semantics from the public function.  We
> > don't need to duplicate the doc comments.
>=20
> Sometimes, though, there are slightly different semantics (for example,
> we guarantee that the parameters to the driver code have already been
> validated against image size, properly sliced-and-diced to match block
> limits, and so on), so that the drivers don't have to do as much work.
> Documenting these contract guarantees would be useful.

Fair enough.

> But as I said, it's not something we have to solve in this series.

Okay.

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY+JIeAAoJEJykq7OBq3PIWnUH/0Q5umZj60j2ojmVKiscroTJ
wLlJJGpum9SIph+X8QnHvpE6L6jS1Gjmg0Zbilocb4/47U72/xiecJxC5MTOGBnn
qroey9huN0vB8X+yVxYBdgmOymgxNT/r4eBOADzoDwnfqoIejV3yOk7gOb+9IVwp
RQxg+MW1o85Qf5JTCMgVqkJciRjZ9ZjEzvZm5aszgYu3PBN78H68BcS9tjaJGipf
AVNhUFbzUZCuVuJdUbN76qI318tiVHoLRUIQGHEb239vLJ8cWnWO1Z3VCPOer7ST
hBUdaDGRKuZ7a52cPqh1SPkcysKuFnOYCvPyduPBOe+u7uQeJYe+ibW3ok5g4vk=
=1MeM
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
