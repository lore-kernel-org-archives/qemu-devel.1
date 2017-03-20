Received: from eggs.gnu.org ([2001:4830:134:3::10]:40358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv4g-0007KB-N4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv4f-0006c8-UP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:02:06 -0400
Date: Mon, 20 Mar 2017 11:01:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320110156.GI17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 08/16] block/file-posix:
 Preallocation for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:37PM +0100, Max Reitz wrote:
> By using raw_regular_truncate() in raw_truncate(), we can now easily
> support preallocation.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7akAAoJEJykq7OBq3PIF7sH/j0tPg7phldSzOa7qNh2Qbl1
hRMkFpoYsijbz9bvV/PFx1LLQmLntw5/LU5Kuv5iL81GSQiQ5GWVL1+X+OkEbQJP
Wmf4Rlkd9TpSbRssh1h5PIa7grWjDvHekOgnZnU3P09ks6zlIQt6DdHTskVP8/FO
oMEcNNYm39PHQm9hLPdAupAAvFqeN/aZJW6RPsGXBr7qmx5rw8yGKZsErIQarJU8
XXgGrfakcAwNGNdhiGek51niOsEOQc56y/J57tHtz7SETjIgi5vfKuYBCmGOzQJc
viHJZzw5/Hlv46OYo4PkAIXPXF+BhFLmYVJIFkcRr2O0kiVkeNO67G7miabk8Oc=
=u+UG
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
