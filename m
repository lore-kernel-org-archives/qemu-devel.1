Received: from eggs.gnu.org ([2001:4830:134:3::10]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaDJ-0004Zv-4K
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaDI-0002ua-17
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYaDH-0002uM-Qc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:23:51 -0500
Date: Mon, 8 Jan 2018 16:23:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108162338.GE11758@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-13-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 12/27] qmp: negotiate QMP capabilities
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


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:42PM +0800, Peter Xu wrote:
> After this patch, we will allow QMP clients to enable QMP capabilities
> when sending the first "qmp_capabilities" command.  Originally we are
> starting QMP session with no arguments like:
>=20
>   { "execute": "qmp_capabilities" }
>=20
> Now we can enable some QMP capabilities using (take OOB as example,
> which is the only one capability that we support):
>=20
>   { "execute": "qmp_capabilities",
>     "argument": { "enable": [ "oob" ] } }
>=20
> When the "argument" key is not provided, no capability is enabled.
>=20
> For capability "oob", the monitor needs to be run on dedicated IO
> thread, otherwise the command will fail.  For example, trying to enable
> OOB on a MUXed typed QMP monitor will fail.
>=20
> One thing to mention is that, QMP capabilities are per-monitor, and also
> when the connection is closed due to some reason, the capabilities will
> be reset.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  qapi-schema.json | 15 ++++++++++---
>  2 files changed, 74 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU5sKAAoJEJykq7OBq3PIVLoH/3zpTwkq8pOjSKb452eK6X1w
v7oHhIUfbrx69aqvFzpN1BqcV1FItYod/gurWca/L2lfS7x1dca8eGPP921eYxGt
cg5RoOG1TDWMX40fgSb6b8IWgcJGjP374mDzidAv+MVtBBeNS9FjCDPWLomdNFGM
cJDTiDnYmONteitNKc7xmUQTetRh6KCkwSyJ3SSvVpbOsQl/YPzAgOmryYbSmCTG
2Kq3zvGBMXByG1x3Tu4CymAdjWlK44UjaN6SiqsmC4Iu72AJ/m3KxL+7hq9vOCuB
ijmP3rJTzY+6XhhgcQNGS+wz63I3yRfGKHCz9vt/U++aGemHS+CrgSsuKKGIH/g=
=7KGE
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
