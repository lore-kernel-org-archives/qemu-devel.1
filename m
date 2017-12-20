Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhRv-0004Sw-S1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhRt-0005PJ-0a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:42:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRhRs-0005O7-Qr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:42:28 -0500
Date: Wed, 20 Dec 2017 16:42:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220164221.GJ12566@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KZLWU/9q3evlN4nQ"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-7-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 06/27] monitor: move the cur_mon hack
 deeper for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--KZLWU/9q3evlN4nQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:36PM +0800, Peter Xu wrote:
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> routine since the Monitor pointer can be actually obtained using
> container_of() upon the parser object, just like most of the other JSON
> parser users do.
>=20
> This does not make much sense as a single patch.  However, this will be
> a big step for the next patch, when the QMP dispatcher routine will be
> split from the QMP parser.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KZLWU/9q3evlN4nQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOpLtAAoJEJykq7OBq3PIo4wIAL+mQGNWhiJm9S3yVTsOtDum
9atRukL2FiWFSgt1TiAPdxmPXanx46GMr3dEi6FYyCnMkPC452Si4k3iobHOEV8j
PPZAb8cuwkSmLFqpkW/0SOncOAkgHIy7eouuhrzz/qhqrRHzUMRF9U6N2PNZfcTt
wWE2QQIn+nMmptwdmn0VvmHYpB5GcSXWxj2ETV7v6mOSGEkmrg+ng5lAS4CiPaO7
RtEvhyKmhkvzRix2fUA0oGnWgBFIUR9v3OqNvgj7EUcW35yv/xzAoPzE6VRLOph/
xZEiHDdRMvZ5Z2PKKTjZJvaSxCJN4Y6MeK69ta6xV6GD0928NvmeRtm7Rtw6h58=
=qaYM
-----END PGP SIGNATURE-----

--KZLWU/9q3evlN4nQ--
