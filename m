Received: from eggs.gnu.org ([2001:4830:134:3::10]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d83QZ-0006E4-5w
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d83QV-0003Cp-Cs
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:39 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d83QV-0003CT-6O
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:35 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so12906263wrc.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 04:35:35 -0700 (PDT)
References: <20170505101930.45837-1-aik@ozlabs.ru>
	<20170508055324.GF25748@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4997c37b-c0d4-e4f4-2b05-353f8223b0dc@ozlabs.ru>
Date: Tue, 9 May 2017 21:35:23 +1000
MIME-Version: 1.0
In-Reply-To: <20170508055324.GF25748@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ism9AtS0a94vFAKh7FtDwwqRu9iJ3N7D"
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ism9AtS0a94vFAKh7FtDwwqRu9iJ3N7D
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4997c37b-c0d4-e4f4-2b05-353f8223b0dc@ozlabs.ru>
Subject: Re: [PATCH qemu v6] memory/iommu: QOM'fy IOMMU MemoryRegion
References: <20170505101930.45837-1-aik@ozlabs.ru>
 <20170508055324.GF25748@umbus.fritz.box>
In-Reply-To: <20170508055324.GF25748@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 08/05/17 15:53, David Gibson wrote:
> On Fri, May 05, 2017 at 08:19:30PM +1000, Alexey Kardashevskiy wrote:
>> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
>> as a parent.
>>
>> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
>> dymanic QOM casting in fast path (address_space_translate, etc),
>> this adds an @is_iommu boolean flag to MR and provides new helper to
>> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
>> is set in the instance init callback. This defines
>> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
>>
>> This switches MemoryRegion to IOMMUMemoryRegion in most places except
>> the ones where MemoryRegion may be an alias.
>>
>> This defines memory_region_init_iommu_type() to allow creating
>> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
>> this splits memory_region_init() to object_initialize() +
>> memory_region_do_init.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> With the caveat that this will conflict with Peter Xu's outstanding
> patches which adjust the semantics of the IOMMU translate function.

Sigh... So I'll wait till that reaches upstream and repost.


--=20
Alexey


--7ism9AtS0a94vFAKh7FtDwwqRu9iJ3N7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZEal7DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5mBsQAIF8
wkdw32BhvnomNZ4YYO8rIkog8rzTBoP/ckZJpA0xPzSPMjSeNZf7h0wP8hb4CXaw
8cF/pnvk9tvl1p8PxtiAlWPbuyOoHam2lHvJD1Zsd8DXYj30vV0QUOynDQQTGjt8
NBUrWiMpu4MUwOTi3K7sJmwW3NML5XtShBFiNlk69E0BFcUD+CZZXFyopujEjzrC
IuQcmp/cnQha2Lb/4D0sXfPAatjPUg7Qlv4z+HvXgq8z0CUXE9X3oQGjgPOOkHpH
UOYXQurortuhWwxpNRTGCXmizYqqILz/WqqJB/YPLeChOIASO1ELwkOdCh8YUUN/
71ZCkNeWbqroAdcOJ+30e5dN9wzXpA58Yy00/PxKosaUNZiDmLzjFSIZubZOKtYa
8WstKxCw0iI59DOGcYUOqxxJzv8A1dgVOsHHaDRjlJDTSJhpUDt8TlDV3aGlicNb
gBLjTjqrhW1s3Eaj5A27gXNd+I7oB9qilVTahePk7X5Ex+yvjR99e0Gz6vKHAkGP
qd/ZYsHQtYhZl2tm4cfrLgHxYjGGqza2+/zkQzUasaVORbspBs6lDIXOl2CffSMQ
CFSbSG7Dt1yek5iJTVwLsmlAKfAmHP4yA0wyoLLWTnbP/A4kC8PqwtFAejiHh/gM
cHxgpAkHnCMOiIRRK0+9iGttLUZu5ZpwD7mRxc2U
=KAV9
-----END PGP SIGNATURE-----

--7ism9AtS0a94vFAKh7FtDwwqRu9iJ3N7D--
