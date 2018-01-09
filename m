Received: from eggs.gnu.org ([2001:4830:134:3::10]:42564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYups-0002Jw-Ja
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYupn-0000Am-IU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYupn-0000AW-CP
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:59 -0500
Date: Tue, 9 Jan 2018 14:24:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109142452.GH31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-24-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-24-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 23/27] monitor: enable IO thread for (qmp
 & !mux) typed
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


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:53PM +0800, Peter Xu wrote:
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNC0AAoJEJykq7OBq3PIVesH/3/eLqjfclts5iBZegnWpBLX
zHo8cAdy+K31ud25r5iOYggk+aiANrKc5tHNMk2RIPsBwVOP2HuLT1WRtM51o52e
WCywiWj93uOS1r+XnWYijal/16dSFoMIRZ6E8v8SBMNSK2hdY3GW0mtPYHzqnkm1
ToLyWRZhcb5v3sjRSTrboYEgP4nIvVu2EdQL4DrReHSTgDiu+0B1rPgyVwSs03nz
l+hY6sNZDLJkLzRVnhNtSQTe6VaSGKtd1yCxT/ZZ331lMGWojSr04taBaFvZXg5f
0S92vQ9deHRstHa8AGq/0xM2KjauTYD1inFxfHVvcQlz3o9DeU5t/bQpVVR2MJ0=
=Awui
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
