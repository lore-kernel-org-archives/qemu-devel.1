Received: from eggs.gnu.org ([209.51.188.92]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMZG-00072p-HJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMZF-0006nI-Je
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:30 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::12]:10938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMZE-0006jA-Ap
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:29 -0400
Date: Fri, 5 Apr 2019 12:59:18 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405125918.462c6ae4.olaf@aepfle.de>
In-Reply-To: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qxyv.yX5szkNIorp2b5/mpZ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

--Sig_/qxyv.yX5szkNIorp2b5/mpZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 12:49:15 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> The EDK2 submodule was added for UEFI testing, you don't need to compile
> it to build/use QEMU.
>=20
> How did you end up compiling it?

The qemu.spec file has this since a very long time:
make -C roms efirom ${unrelated_settings}

This used to work still in January with c9d18c1c150c84e7a976df989ad04ddf010=
83f46.

Olaf

--Sig_/qxyv.yX5szkNIorp2b5/mpZ
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc1BwAKCRBdQqD6ppg2
fh9/AKCQYcL7VuEatSXVQcwVI1TsBd2BfwCfdsKy0MYdn/CCqZD6biEzttKfq5o=
=yysl
-----END PGP SIGNATURE-----

--Sig_/qxyv.yX5szkNIorp2b5/mpZ--
