Received: from eggs.gnu.org ([209.51.188.92]:58979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hE6gg-0000Cc-8z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hE6gf-0003PI-BC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:22 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:26583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hE6ge-0003La-Jm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:21 -0400
Date: Wed, 10 Apr 2019 08:25:54 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190410082554.6c595b3f.olaf@aepfle.de>
In-Reply-To: <fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
	<20190405153314.2068-3-philmd@redhat.com>
	<fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qpQU+wBOGMTWT_9aY1lUNlz";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 8 Apr 2019 13:05:07 +0200
schrieb Laszlo Ersek <lersek@redhat.com>:

> Then build scripts could be updated to invoke:
>=20
>   make -C roms \
>     EDK2_BASETOOLS_OPTFLAGS=3D'...' \
>     EDK2_BASETOOLS_LDFLAGS=3D'...' \
>     efirom

The question remains: 'But why?'.
Why can edk2 not be built with '-fno-pie' right away?
Did noone approach the edk2 developers yet that their buildsystem is broken=
 in that regard?

Olaf

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXK2McgAKCRBdQqD6ppg2
fmXLAJ9CZLvvfEoP6rZsnG8NA75pbyL4KgCdHDh8gIwoZ5ox7oeOoLCUrzfRygc=
=m8/g
-----END PGP SIGNATURE-----

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz--
