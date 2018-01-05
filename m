Received: from eggs.gnu.org ([2001:4830:134:3::10]:42279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUmY-0004fe-21
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUmU-0002Ve-Qk
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:23:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXUmU-0002Ti-Hu
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:23:42 -0500
Date: Fri, 5 Jan 2018 16:23:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105162331.GK28322@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 09/27] monitor: create monitor dedicate
 iothread
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


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:39PM +0800, Peter Xu wrote:
> Create one IOThread for the monitors, prepared to handle all the
> input/output IOs using existing iothread framework.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT6aDAAoJEJykq7OBq3PI0WsIALjHxAURaVSPIwGjl/5HISjd
G7g1Kt2pkNU2Mc7fd2ch4pf5dvD5RVYfHhn5d3p3jI+hmPwS3Whf2vab/d25zAiE
VnfA0Jj6/H6vKq0cyUt94iykEh/CmnhGAuBx96+6ZfJZH3gQMyi3QGSMEQbUfOj9
XuCSktVOSmPJuYjThiMCFH90gaOKVPfS+66RIFbXyfr0ElTqneTFDDWiI6RAMfpb
lqy44SJUOaDty6CjpnKqYZHMuSBsK/nf/nAc+r90sgs4HwnNLr1vV1c6QEj/yINQ
pTsM3pPU70UUpbQjheWV0A6AIHTVR27NhkpYRa3anYaM2r3849z0dV55meTPT64=
=UBfE
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
