Received: from eggs.gnu.org ([209.51.188.92]:51872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMnz-0002He-Tv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMnx-0003Eh-UX
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:14:43 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCMnv-00035E-Vb
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:14:40 -0400
Received: by mail-wr1-f48.google.com with SMTP id y7so7458922wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:14:39 -0700 (PDT)
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Date: Fri, 5 Apr 2019 13:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iwBXYSSKQw6emSL0d4WjQ4r3pfDmMQxzP"
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
--iwBXYSSKQw6emSL0d4WjQ4r3pfDmMQxzP
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
 <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
 <20190405125918.462c6ae4.olaf@aepfle.de>
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 12:59 PM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 12:49:15 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>=20
>> The EDK2 submodule was added for UEFI testing, you don't need to compi=
le
>> it to build/use QEMU.
>>
>> How did you end up compiling it?
>=20
> The qemu.spec file has this since a very long time:
> make -C roms efirom ${unrelated_settings}

I don't have any qemu.spec, is it a SUSE file?

>=20
> This used to work still in January with c9d18c1c150c84e7a976df989ad04dd=
f01083f46.

Before f590a812c210 the EfiRom tool was not available, now we compile it
inconditionally.

So I assume your distribution already provides the EfiRom tool. Can you
point me at the package which provides it? I wonder if your distribution
use a non-upstreamed patch that change the EDK2 BaseTools PIE/PIC flags.

Thanks,

Phil.


--iwBXYSSKQw6emSL0d4WjQ4r3pfDmMQxzP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynOJsACgkQoqP9bt6t
wN429Q//Q2XrblwuyAfMK5dEBcmW+FNJEvxu82nwKxgZIbtLOymk7+NcLXa7FGtO
wt13en6vDZiwHoN4iWvE71vfjNSgwW0QROEipZACzxZC8rZZDitJetXKbpf0CZRt
fnWG+QKUGFUU/zznoE34zg5QETKv3h0KzrRaA0l78mJqFke+J3va5Dch62TFfwxh
VImuWFZk0RqmfXB9YwOKettPfHPJ9H75vmurjnWyRjMwiEBW19CLAd8cNjda8mEA
84VFHg44ycxvxhQlOM2/aa/0BkMeY0hTe6vGMa8WczcXWS8xX0tin58o/5pupNyj
pVACMZqHdXSVk9pbkX4FPsreFOZp7ICSr4LAghMdnh++GYM8BtLD/n3E5uRyf+pr
yAsswhURj+1VIoS2T5GYD/CSkSMyfOH3IzW6PIAdYXA7TnRNMYkI7Cj+RR/HHUQh
bnCKZxA0ppfH3GD2SxypATIY27frLgOUKQ4Iyo7en2bMZccobCQcp0hA8OWy2yB7
JHUisZcfyi+3XoLflLT9VQsoUALaCQYIgOIvGblFBrHOvkLiDxfDOGKNsdamxizn
m7DTchWi/SJEVws5di/KQzMf6RYhVqirAtNRdgYMZ2GDkowHxpDbWTCqgYU0cjn+
lzYKrn9Fp5x+2W9m3UyuEnqP0nLSZ+qsfkB/aAXwkToWfE2aOgk=
=ZgJ5
-----END PGP SIGNATURE-----

--iwBXYSSKQw6emSL0d4WjQ4r3pfDmMQxzP--
