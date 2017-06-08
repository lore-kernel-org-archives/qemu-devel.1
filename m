Received: from eggs.gnu.org ([2001:4830:134:3::10]:53627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIzP6-0007ao-7y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIzOw-00028g-HT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:31:14 -0400
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
	<d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
	<20170608145803.GI25805@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d33a605-3e14-249c-b632-3d90f4e0bb50@redhat.com>
Date: Thu, 8 Jun 2017 17:30:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170608145803.GI25805@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bONwKx6BAUjLIASXPuLOd8rXbGJl1rgNe"
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
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bONwKx6BAUjLIASXPuLOd8rXbGJl1rgNe
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d33a605-3e14-249c-b632-3d90f4e0bb50@redhat.com>
Subject: Re: [PATCH qemu v7] memory/iommu: QOM'fy IOMMU MemoryRegion
References: <20170607083243.8983-1-aik@ozlabs.ru>
 <20170608074250.GE25805@umbus.fritz.box>
 <d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
 <20170608145803.GI25805@umbus.fritz.box>
In-Reply-To: <20170608145803.GI25805@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/06/2017 16:58, David Gibson wrote:
> So, doing that via the standard macro wrappers would be slow, because
> it does type verification.  However, looking up the class function is
> fundamentally:
>=20
> 	((IOMMUMemoryRegionClass *)(((Object *)mr)->class))->translate
>=20
> i.e. two pointers followed, which is just the same as
> 	mr->ops->translate

Fair enough.  On the other hand it's a bigger change so I think it's
better to keep it separate.

Paolo


--bONwKx6BAUjLIASXPuLOd8rXbGJl1rgNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlk5bbIACgkQv/vSX3jH
roNggAgAiuGB3IDTIF0X1sy2IoRyOnbIcVdc5w41MnyCQhu7Ov7Et08xe5aE4ztS
BL7eeUx8e1PjN942+1cLM4uSJ2WFmQa7uPbrq++wdYRr3J1+jvd3Q+034a43E+C/
pGoBdeFksN3XeixMBabTXk8sqggIzQRm+UiVu0cu7ldJmBScFtIjN+sZBeuYSLou
ruiEiU0nIdMnOeyfpXmbeMY2Q96vegizVFZhpvetM7tBWLO5J6IcHIzt0o/lqyhG
5vBZdQ6PtSY4xl49luzQcGieghQ6RWGsdZk8SxEuvzWyxky2brNgvoLiS5s632wQ
Y3jIxDDS7enqBxmfe/sETy1qA6/8UA==
=wj82
-----END PGP SIGNATURE-----

--bONwKx6BAUjLIASXPuLOd8rXbGJl1rgNe--
