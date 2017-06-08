Received: from eggs.gnu.org ([2001:4830:134:3::10]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ7Ba-00030A-4I
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 19:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ7BW-00017A-0E
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 19:49:54 -0400
Date: Fri, 9 Jun 2017 09:49:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608234916.GA12240@umbus.fritz.box>
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
	<d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
	<20170608145803.GI25805@umbus.fritz.box>
	<9d33a605-3e14-249c-b632-3d90f4e0bb50@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <9d33a605-3e14-249c-b632-3d90f4e0bb50@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 05:30:57PM +0200, Paolo Bonzini wrote:
1;4602;0c>=20
>=20
> On 08/06/2017 16:58, David Gibson wrote:
> > So, doing that via the standard macro wrappers would be slow, because
> > it does type verification.  However, looking up the class function is
> > fundamentally:
> >=20
> > 	((IOMMUMemoryRegionClass *)(((Object *)mr)->class))->translate
> >=20
> > i.e. two pointers followed, which is just the same as
> > 	mr->ops->translate
>=20
> Fair enough.  On the other hand it's a bigger change so I think it's
> better to keep it separate.

Ok, project for another day.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOeJ5AAoJEGw4ysog2bOSanYP/AtJIdhiuPlSX3sKSAi/I0RN
0jVtH/yaUoJUEKmUXXQ8SNtaq1FDk8YQfSB5ixEH2qlh8pUseMdXwDADQbqiJilv
BhOKxquEkho9f2IW+gApDCNp4kchah2vxxKssK3YB/FZ4Tyl0VYHKHODH8BTSfG6
OQEqRtcn+js0Q0BgK5owvef18g76y3eTqKkzOwjY1OKFJenYcaPIjjZqQGphdDCQ
O/CF6XMiE10oNj4Eb1F4MxOpJmjiZdtaT5VuPfxHW2n4BH713brR6o+mx3r2LXZJ
0EMLBz1Ot+ZldDw8ftcpIACF9UOW/8Jt8/9bgtPeAXeJeSluRcc8Kv3NGmpsOq2O
DUB0G6p5N8meEm5YM/3pEftKDoR0v2CnGcvGJY/oQueQ92uuLdNNljgYzHzFRWSI
QdUiMgqfuA1UWqWW9yqFJHYzSSoPg01WvjOYhTZwI6poLiGO3TowuNQYuEpSA7Qo
azAIGw2ZTh1yOS8R7KBmxX31ZKC8o1I8rZ9P5OalmAVwF7VbldyJMc01kws983df
Th6WzFMb8TIvMWs4DubITOflOCtU9LwahJJxGqi3oSjHPD1JM7U2cKChb1Sb5JGt
2FhdA9prMTPTZra5jtWnf9ffWpvkAO61cGEsTGUVypgqrMQ85Bnwi6gznLTCn1OQ
mpxkWUEXgBvf7r5xdV+M
=z2cM
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
