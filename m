Received: from eggs.gnu.org ([2001:4830:134:3::10]:60809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaEw-00066v-Hr
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYaEs-0003oO-HF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:25:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYaEs-0003nt-A4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:25:30 -0500
Date: Mon, 8 Jan 2018 16:25:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108162515.GF11758@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-14-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 13/27] monitor: introduce
 monitor_qmp_respond()
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


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:43PM +0800, Peter Xu wrote:
> A tiny refactoring, preparing to split the QMP dispatcher away.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 50 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU5trAAoJEJykq7OBq3PI+PsH+gLjFIWlOcRjI8jkJXQbzwxO
BVrJE/Oldgt/PZXIwI8Ci1CkTZaZvmC9mnwFJ4dVj/PixVFrEkSX7spfWvV2vY+e
73JO/LokXJ7QO69D+MQrYAJNZT+/3yaL7yK2hR5m3vkTv0O8h7+7Ni5/jGx+p6Fs
VDrgtXu/HG+mk5/mprTwM0aLaL5gZ/qP6tC5MzrKy5XbnR5JKfeAFSW+1SjVkua+
EGMqOnUz+binZPPEprmTDXRMdbOS5wmLXXMgU2NQuiXUAw3Jyih8XI2XIKWBybAW
Kt0KLkst3swnTBpRRgmEpGlou1rmsOI8UfAxMUIvP+JGtQq3cRiUgjQljz40RAc=
=kBNK
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
