Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzQ5-0007dk-Ea
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzQ2-0000P1-Kv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:40:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cpzQ2-0000OT-Ed
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:40:26 -0400
Date: Mon, 20 Mar 2017 15:40:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170320154015.GC7320@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-5-stefanha@redhat.com>
	<CAMRbyytgis39Ayj2Hd3_sqa2EBOov9oo0Ne0d+=CdehfgEynog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <CAMRbyytgis39Ayj2Hd3_sqa2EBOov9oo0Ne0d+=CdehfgEynog@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 4/8] qcow2: extract image creation option
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 08:14:45PM +0000, Nir Soffer wrote:
> > @@ -2235,7 +2284,7 @@ static int qcow2_create2(const char *filename,
> > int64_t total_size,
> >      *header =3D (QCowHeader) {
> >          .magic                      =3D cpu_to_be32(QCOW_MAGIC),
> >          .version                    =3D cpu_to_be32(version),
> > -        .cluster_bits               =3D cpu_to_be32(cluster_bits),
> > +        .cluster_bits               =3D cpu_to_be32(ctz32(cluster_size=
)),
> >
>=20
> Is this related?

Yes, the main cluster_bits code was extracted into
qcow2_opt_get_cluster_size_del() above.

This is now the only place in qcow2_create2() the needs this value so I
inlined the expression and dropped the variable.

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz/ffAAoJEJykq7OBq3PId4AH/jgGhHA38w6wVPLvXCI7EcKJ
89a1o9CAlSOXyBb3195xc7IgVv2Q388x6EJdbn6dsxeC21UTAFpC0pMGp+JTbZco
jlWeDT7kKRC97J4Xpz8fHBL3uZFA+VSWHVxfdWLMDxO+ldyUBw6u/0E/7C0JYNSr
N/SqM1o9Ix91WzzN73Lm6evEhBT050ST6UQXuhT5sc4W5ysdA1Guxh3bhATXXrnw
QLb92Bmh4sHe9ADpsGn267TJp0HbbFBkQlAeuQR489Y7Abh8EadEFVjcgu8Gmyjr
ljHg3uj1vlB7YxUXfJn5idk1Ep+3K2ayBu1w0GnsK99FA3oyryGdGI6MdJXSbiw=
=F3wX
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
