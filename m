Received: from eggs.gnu.org ([2001:4830:134:3::10]:59930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaDD-0004VN-TS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaD9-0002qg-S7
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYaD9-0002pE-MD
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:43 -0500
Date: Mon, 8 Jan 2018 16:23:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108162332.GD11758@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-12-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 11/27] qmp: introduce QMPCapability
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


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:41PM +0800, Peter Xu wrote:
> There was no QMP capabilities defined.  Define the first "oob" as
> capability to allow out-of-band messages.
>=20
> Also, touch up qmp-test.c to test the new bits.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 10 ++++++++--
>  qapi-schema.json | 13 +++++++++++++
>  tests/qmp-test.c | 10 +++++++++-
>  3 files changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU5sEAAoJEJykq7OBq3PIzasH/jAaicARDUmwo0E99lY+UAr9
oEwz7fj/99BqPCDcoc6ttFqTxXOB+WGXscN4P29UPMHxrqM2q5D8fa5ogflhTyAp
xoo3u0uFDNkd9EdrlJpXbF7L/xXTMYSSOmmOpAPQAWUVqKUUXKXnwx17li91OPKo
3U3fVqr/naeo5iy7fgxZqRlxRz8xvm77Dq3iMaHAjN+wMY9n+U4HTJnuxBLCq0/r
t197A3kwNT3v7gIZ3bqkVbQp5h6L+5PFuyrmWNcv/e5bBpMLqECwS7Shv+/HkIue
aIOMBmH9nfbCDTSdy+plYaPMyoTCLtZTTT2Vh/t9oy/WcVEvpnPmmWl3n2OZh+U=
=pBOz
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
