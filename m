Received: from eggs.gnu.org ([2001:4830:134:3::10]:60303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d874G-0000mB-MJ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d874B-0000Qu-Qb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d874B-0000PV-Jr
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:28:47 -0400
Date: Tue, 9 May 2017 11:28:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170509152843.GI16825@stefanha-x1.localdomain>
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-2-stefanha@redhat.com>
	<af6f4140-e264-dc45-8b0c-36b5d520ce28@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <af6f4140-e264-dc45-8b0c-36b5d520ce28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 09:50:06AM -0500, Eric Blake wrote:
> On 05/08/2017 09:15 AM, Stefan Hajnoczi wrote:
> > bdrv_measure() provides a conservative maximum for the size of a new
> > image.  This information is handy if storage needs to be allocated (e.g.
> > a SAN or an LVM volume) ahead of time.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> It looks like non-trivial changes since v5, are you sure this R-b is
> still appropriate?

I guess you are right, a lot of lines have changed, but the change turns
the BdrvMeasureInfo parameter into the return type.  It's just
mechanical stuff.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEeArAAoJEJykq7OBq3PIntIIAJkOu/orNfSlYFxZPl326uCl
D9YwX1OvMbDO7E/0CiOZqrPfWeAAu5RYHl5hldyqa5FH7qWfqHFBe9ZaS6sJXPB7
3q9YTYqf94Lz5/rgqGPKUsA39I9EA8mnSX2N2QkaxWRCkIF97GJzIayqlkhPLLdH
uywsbAPevfGaTbUieT2IQbyy8t6lkKTe8tMXFv48Mt/t45GtIclbjPFIVy0dNdTS
F1qrvazEk9zW+RZZ/MS34AZ8SInHMIUgrKEmoCYNkKw2XLf68XhjmKKUw9R21EJu
Bw61jw9QqnHHpz+N9t7KtmJxw2JMQ3XYhXw7kIwhNc6sCnAnRfQSxCEOF2bwScE=
=l+k1
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
