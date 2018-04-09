Received: from eggs.gnu.org ([2001:4830:134:3::10]:50255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5THP-0004lp-VN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5THM-0002dT-Ql
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:40:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5THM-0002d3-KR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:40:00 -0400
References: <20180408145933.1149-1-f4bug@amsat.org>
	<20180409055825.GB4848@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdc75c37-85ab-3218-423d-4f50f895b4fc@redhat.com>
Date: Mon, 9 Apr 2018 11:39:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180409055825.GB4848@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ajI2psex5bT2GNV2Z78Dxzztts4KwqYCL"
Subject: Re: [Qemu-devel] [PATCH for-2.12] gdbstub: fix off-by-one in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ajI2psex5bT2GNV2Z78Dxzztts4KwqYCL
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <cdc75c37-85ab-3218-423d-4f50f895b4fc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] gdbstub: fix off-by-one in
 gdb_handle_packet()
References: <20180408145933.1149-1-f4bug@amsat.org>
 <20180409055825.GB4848@stefanha-x1.localdomain>
In-Reply-To: <20180409055825.GB4848@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/04/2018 07:58, Stefan Hajnoczi wrote:
> On Sun, Apr 08, 2018 at 11:59:33AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> memtohex() adds an extra trailing NUL character.
>>
>> Reported-by: AddressSanitizer
>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>> ---
>> (gdb) dump binary memory /tmp/dram.bin 0x94000000 0x94100000
>> Remote connection closed
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D22732=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on add=
ress 0x7ffe43018340 at pc 0x55f2655fde81 bp 0x7ffe43017210 sp 0x7ffe43017=
208
>> WRITE of size 1 at 0x7ffe43018340 thread T0
>>
>> ---
>>  gdbstub.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Peter, can you apply this directly to master?

Thanks,

Paolo


--ajI2psex5bT2GNV2Z78Dxzztts4KwqYCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrLNOAACgkQv/vSX3jH
roNgxgf+KVAI1/H2O3JhfUmUWEFfp657fKuEc9ru/BazpyDp5YwHaSTg9INah2Gk
7yp5Do0puF/ZlybKmBPK+f408XN+Ttzw9TFj0DzsRowj/zm/dcmFPyGJ1fvvqhlf
sb0wa6fRRE2/2C7AXo5WhHBUNTgEikW5WUULC0w2Xu+O5Q17/3ESuX0/IFQ46h7m
1BKQCHdOmBZqYd3nH8VbN5RCZrEPKhSuo2dRkWIxt+39mmIpjA4xePcqg8Q4gx1Y
zKnDHPPf9Fx+FT7wOqonzbO82QKCVQLEiNV+Mgr4BEhtcwvWABwps5+CornQs9dy
rmhT3X4UeyKNY2haEzIcnESZZII2zQ==
=0Gq1
-----END PGP SIGNATURE-----

--ajI2psex5bT2GNV2Z78Dxzztts4KwqYCL--
