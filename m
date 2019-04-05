Received: from eggs.gnu.org ([209.51.188.92]:45754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCOWg-0007UJ-6Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCOWe-0001Bh-0Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:57 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::12]:29689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCOWc-00010V-Ae
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:55 -0400
Date: Fri, 5 Apr 2019 15:04:38 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405150438.48c1cc84.olaf@aepfle.de>
In-Reply-To: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/IkYw9CvzDzhQ5joI35eOSp8";
	protocol="application/pgp-signature"
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>

--Sig_/IkYw9CvzDzhQ5joI35eOSp8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 14:59:16 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> On 4/5/19 2:09 PM, Olaf Hering wrote:
> > Am Fri,  5 Apr 2019 13:55:29 +0200
> > schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
> >  =20
> >> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom =20
> >=20
> > This name is too generic and will conflict with ipxe.git if any of "bio=
s seavgabios pxerom" is used for 'make -C roms'. =20
>=20
> This is similar to commit c9d18c1c150c84e where you said "it used to
> work", what is the difference?

Before there was no need to pass EFIROM=3D to make, so ipxe.git was happy.
Now it is required, and ipxe.git gets an unexpected value.

> IPXE override the EFIROM variable, so there is no change there.

For me ipxe tries to rm $(type -P EfiRom). Let me double check.

> How can I trigger a SUSE package build with this patch?

Not so easy without a VM.

Olaf

--Sig_/IkYw9CvzDzhQ5joI35eOSp8
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKdSZgAKCRBdQqD6ppg2
fmiNAKC4rVOVneYgarSZoWrosXTXEB7NggCeLLgbNwX2QuIFLYYvukYq/rzB1uc=
=yDkZ
-----END PGP SIGNATURE-----

--Sig_/IkYw9CvzDzhQ5joI35eOSp8--
