Received: from eggs.gnu.org ([2001:4830:134:3::10]:56779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL3hr-0004tC-Tz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL3ho-0004NK-Bl
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:31:15 -0400
Date: Wed, 14 Jun 2017 16:27:31 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614082731.GI13420@umbus>
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<149742316109.876.1308050750965482811@4a9a010726c0>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <149742316109.876.1308050750965482811@4a9a010726c0>
Subject: Re: [Qemu-devel] [PATCH qemu v8 0/2] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, famz@redhat.com, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 11:52:41PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH qemu v8 0/2] memory/iommu: QOM'fy IOMMU Memo=
ryRegion
> Message-id: 20170614063607.47863-1-aik@ozlabs.ru
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/20170613140358.81651-1-vsementsov@virtuozzo.=
com -> patchew/20170613140358.81651-1-vsementsov@virtuozzo.com
>  * [new tag]         patchew/20170614064452.23167-1-sjitindarsingh@gmail.=
com -> patchew/20170614064452.23167-1-sjitindarsingh@gmail.com
> Switched to a new branch 'test'
> 3d08aca memory/iommu: introduce IOMMUMemoryRegionClass
> d1443b0 memory/iommu: QOM'fy IOMMU MemoryRegion
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/2: memory/iommu: QOM'fy IOMMU MemoryRegion...
> ERROR: spaces required around that '*' (ctx:WxO)
> #129: FILE: hw/dma/rc4030.c:720:
> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
>                                      ^

False positive.  checkpatch thinks this is a multiplicatin rather
thana pointer designation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQPNwAAoJEGw4ysog2bOSqRMP/0iXJ1kswO1bIX6jwnGuLFjo
wvkMJE8bwqCP1ABoZWEoTSRjljvTrdXXRO7wW8wZtAefm9WmiG7IPBDHLZj1Nxug
oKMYOz2FYGIZEwuxBYbV/RVBxSuAHy95GOVpuqTAyo7VmcyX3nuw4T5xFREw0ayB
GC5Zq2/yBQk37xyYwlpI7Dlq5QRLIUnQWuqo6veLyRsf3fU3FqoblVJl5b4gEJhO
qkMOsLGejCKFuAEERGOErlvSHAopWe9A8JTse7IVdwBBZdCECyj/Nsud0DV3U0rM
JTBL6onAGFypoFXmNdUSvE3HcAmsIVdRbkpC+HBDzKLQwv5z8IqaM5YSIsw2lNtr
wGZjigaNv3vmdiD/Pe+0O2YjPk/etsYZTNLNGbyQzkTr/Htw2rnFZpKVLZZk4RnM
965SAScTvAgcrnBqUCkc0/RS758O+S7pOTan0RzVCoAfEYE9arjADsoyhljYLhuO
ZX+V3LrBgoDqHLMwIfesyaa+kyp4v4EQjak51ylU0bw++nAbLUwmjBV6yrUlBvA9
kzVup44do0Parjgy8MthlSOCscjooLde1+agnYL4JT0tknwEevaeIv2Y9CTo/glP
55GfSKaL+NEKkDZzM/LkFpDqv423X6VtrHON1dm35y/lXigd/tdWYPGmtoMFA/fR
bSLsmnKt8f9ortItiVN6
=Bx5Z
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
