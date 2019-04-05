Received: from eggs.gnu.org ([209.51.188.92]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNex-0007bZ-UD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNex-0007Ma-1Q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:27 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:19593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCNev-0007JZ-Qe
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:26 -0400
Date: Fri, 5 Apr 2019 14:09:17 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405140917.3af9b91d.olaf@aepfle.de>
In-Reply-To: <20190405115529.11590-1-philmd@redhat.com>
References: <20190405115529.11590-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf";
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

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri,  5 Apr 2019 13:55:29 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom

This name is too generic and will conflict with ipxe.git if any of "bios se=
avgabios pxerom" is used for 'make -C roms'.

Olaf

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKdFbQAKCRBdQqD6ppg2
fkRNAJ99Ry8ACOCI8Oi3lFj0I4/1FKU9YACgxmjYmn095wUNKBxXZ1EiStfU5Dg=
=tORK
-----END PGP SIGNATURE-----

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf--
