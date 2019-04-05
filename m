Received: from eggs.gnu.org ([209.51.188.92]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCORG-0005u8-T1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCORF-0001ya-NH
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCORE-0001wl-OA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so7930043wrp.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 05:59:20 -0700 (PDT)
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
Date: Fri, 5 Apr 2019 14:59:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190405140917.3af9b91d.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv"
Subject: Re: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to
 be overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
Subject: Re: [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden
References: <20190405115529.11590-1-philmd@redhat.com>
 <20190405140917.3af9b91d.olaf@aepfle.de>
In-Reply-To: <20190405140917.3af9b91d.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 2:09 PM, Olaf Hering wrote:
> Am Fri,  5 Apr 2019 13:55:29 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>=20
>> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
>=20
> This name is too generic and will conflict with ipxe.git if any of "bio=
s seavgabios pxerom" is used for 'make -C roms'.

This is similar to commit c9d18c1c150c84e where you said "it used to
work", what is the difference?

IPXE override the EFIROM variable, so there is no change there.

How can I trigger a SUSE package build with this patch?

Thanks,

Phil.


--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynUSQACgkQoqP9bt6t
wN7ATg//cXb2NbsUw7JvaJq9RxdQxTXw4dX+WWjO55UFv9GwQWF6jCvjYWBWvz39
ipIkq4dBHAQYodi+TUfO906b+F7gi2CZ0X3vqY7tyZQRAzjG1eD/pTCSqNBPuD0s
pfiphXSagFMR62GYFO4fI0ApoD7H6RtImWt/9Fj1xFFgQXlqY+lNpK9a/oLX1/pu
G+1+ynSxgDknD+MRDkH8iM6mkDKitdXq1akfAjaPvPsY76jPEzv0u6kc/8p3jmqH
amE0mXWjMhrswTE5eEOPl1on8AiaT6r2qk8d3TwTRqHdzBYG1qM8TM48zt3fyUeN
/vV6Y8yLxiuOzK9iAFmpKSViotrIjJ9oUAjJJNulC737XaARr+jkVpeMgxsdGsl0
7flCRZwg9hx06nae4zSVIAH22iULg6FV2/lnEcr0e2Pi5fxyx9HpV0tPeTpETyMM
DI5SNwl/TBEsnCY0BM1OzJa4jtsXKLimMYSwI7AjZyBdsjbK/7LVt3NCGJ9EkfIM
8+M0pAzrrN7UsZ59sD376Q43ll1zYDkybrAaac47julU4hu3BLHoNi1VatG0Jphi
8u2EEUgEPCVYyzR2w6pRvT2MHWlXHU+IExo/X5//CLOjcVOPn8pi2OoV/dbmQFqU
lQdQo2VwSR2tRo4OQATlbeC0fmRN6HCG7/McwOPWtUkSAnDYCj0=
=P5vv
-----END PGP SIGNATURE-----

--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv--
