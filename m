Received: from eggs.gnu.org ([209.51.188.92]:56680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNCq-00013v-3c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMxw-0007Va-J3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:25:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCMxv-0007R3-JG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:25:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so7561522wrp.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:24:58 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Message-ID: <aba99e13-f034-3946-3da2-9cecd615cde6@redhat.com>
Date: Fri, 5 Apr 2019 13:24:55 +0200
MIME-Version: 1.0
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <aba99e13-f034-3946-3da2-9cecd615cde6@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
 <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
 <20190405125918.462c6ae4.olaf@aepfle.de>
 <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/5/19 12:59 PM, Olaf Hering wrote:
>> Am Fri, 5 Apr 2019 12:49:15 +0200
>> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>>
>>> The EDK2 submodule was added for UEFI testing, you don't need to comp=
ile
>>> it to build/use QEMU.
>>>
>>> How did you end up compiling it?
>>
>> The qemu.spec file has this since a very long time:
>> make -C roms efirom ${unrelated_settings}
>=20
> I don't have any qemu.spec, is it a SUSE file?

I checked and apparently.

>>
>> This used to work still in January with c9d18c1c150c84e7a976df989ad04d=
df01083f46.
>=20
> Before f590a812c210 the EfiRom tool was not available, now we compile i=
t
> inconditionally.
>=20
> So I assume your distribution already provides the EfiRom tool. Can you=

> point me at the package which provides it? I wonder if your distributio=
n
> use a non-upstreamed patch that change the EDK2 BaseTools PIE/PIC flags=
=2E

I see EfiRom was previously provided by ovmf-tools-2017.src.rpm, and the
latest ovmf-2019.src.rpm has this file:

$ cat ovmf-pie.patch
Index:
ovmf-2018+git1534736099.43fe4c405292/BaseTools/Source/C/Makefiles/header.=
makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---
ovmf-2018+git1534736099.43fe4c405292.orig/BaseTools/Source/C/Makefiles/he=
ader.makefile
+++
ovmf-2018+git1534736099.43fe4c405292/BaseTools/Source/C/Makefiles/header.=
makefile
@@ -77,7 +77,7 @@ ifeq ($(DARWIN),Darwin)
 # assume clang or clang compatible flags on OS X
 BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-self-assign -Wno-unused-result
-nostdlib -g
 else
-BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-stringop-truncation -Wno-restrict
-Wno-unused-result -nostdlib -g
+BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-stringop-truncation -Wno-restrict
-Wno-unused-result -nostdlib -g -fPIE
 endif
 BUILD_LFLAGS =3D
 BUILD_CXXFLAGS =3D -Wno-unused-result




--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynOwcACgkQoqP9bt6t
wN4kSQ/9EhLOD/85yxc8bLIoxsKOb1uNa3J9tyiM02WiesVt8u4H13MkVNH5bw5c
LqAab0+kFifkWqYqhgsVPfwB1yxPPCZu1KaUdMEwwu+GECaTOPjDcfkzVtgIrxSr
zL/AXwMyWA0SNaVhqzEQtECZ+/hNjwZvCIcWeAq2MykFiEWqhgd8UqBtRnyRAMUj
lMgtNYP4A6loxlE6zyVW+AuQySiCij8U98DXOQhZrLwQadj2SvGsDEyVxm1SiIvN
cg3u6qcIRDvteSMRPpzjPOnzZRIMe++tv3FwJZpFp0cUojt0MrBmrRKZDBt4gYxP
wdsVNrOZsIrpaxMS0cqyefaIT/p7xTI1PqHF2Gm2c4/PQdy/rgQ6Zpo2nbrTUPbi
7p8lNBgoF31u4wNp8hn/sBvb+z5TljTY6OBjRjLl5LaXV2wLHwh/8UCD+yL6sC6Y
/veYqZg2Mymv7w6G0ZX/q7PwlVx+E5cYdW91BHeWFYMy5q98rnByZw/SVCNxi2cp
30lpAbiZWcmvsHuNFSXaozveHiDDMP2SdLJQ9tBrWlrB6WfOXZQQId+CaN+DWGM4
8gM95PFaDXUwhWDKviNNF+tbZEcG3fi2Eo+/B3EXzdkRONNGYbNbEVIAHHk2SsFr
H/QCOJWDPa8K6syf6sMrBohG86an8QWFv4OhqdPS5/ll8oG617Q=
=OrYD
-----END PGP SIGNATURE-----

--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo--
