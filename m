Received: from eggs.gnu.org ([209.51.188.92]:32860)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gn6fu-0000Zh-Gi
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gn6ft-0007ER-F6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:57:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:45617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gn6fr-0007C1-H0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:57:55 -0500
References: <20190115200252.25911-1-mst@redhat.com>
	<20190115200252.25911-8-mst@redhat.com>
	<690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <ff7fd6be-9746-872b-0fec-02993ef69fc9@gmx.com>
Date: Fri, 25 Jan 2019 19:58:32 +0100
MIME-Version: 1.0
In-Reply-To: <690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3wnKPDtpul9aKuYdhMeAAFKy9awNBFaJz"
Subject: Re: [Qemu-devel] [PULL v2 07/49] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3wnKPDtpul9aKuYdhMeAAFKy9awNBFaJz
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff7fd6be-9746-872b-0fec-02993ef69fc9@gmx.com>
Subject: Re: [Qemu-devel] [PULL v2 07/49] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
References: <20190115200252.25911-1-mst@redhat.com>
 <20190115200252.25911-8-mst@redhat.com>
 <690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
In-Reply-To: <690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.01.2019 19:53, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> On 1/15/19 9:04 PM, Michael S. Tsirkin wrote:
>> From: Li Qiang <liq3ea@163.com>
>>
>> Assert that the return value is not an error. This is like commit
>> 7e6478e7d4f for qemu_set_cloexec.
>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  util/oslib-posix.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index c1bee2a581..4ce1ba9ca4 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
>>  {
>>      int f;
>>      f =3D fcntl(fd, F_GETFL);
>> -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
>> +    assert(f !=3D -1);
>> +    f =3D fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
>> +    assert(f !=3D -1);
>>  }
>> =20
>>  void qemu_set_nonblock(int fd)
>>  {
>>      int f;
>>      f =3D fcntl(fd, F_GETFL);
>> -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
>> +    assert(f !=3D -1);
>> +    f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
>> +    assert(f !=3D -1);
>=20
> This commit breaks OpenBSD, when trying to start QEMU I get:
> assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247,
> function "qemu_set_nonblock"
>=20
> Having a quick look at gdb, the last device opened is /dev/null, and
> when fcntl() fails we have errno =3D ENODEV.
>=20
>     19 ENODEV Operation not supported by device.
>     An attempt was made to apply an inappropriate function to a device,=

>     for example, trying to read a write-only device such as a printer.
>=20
> Digging further I found a recent commit which could fix this problem:
> https://github.com/openbsd/src/commit/c2a35b387f9d3c
> "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
> the memory devices (/dev/null, /dev/zero, etc) need to permit them."
>=20
> Brad: Do you think this might be the fix? If so, any idea what is the
> first release to contain this fix? I don't know OpenBSD and can't figur=
e
> this out... Also, what would be the cleaner QEMU fix?
>=20
> Thanks,
>=20

I cannot speak for OpenBSD (never installed it myself), but if there is
a critical patch to test on NetBSD - please let me know.

> Phil.
>=20
>>  }
>> =20
>>  int socket_set_fast_reuse(int fd)
>>
>=20



--3wnKPDtpul9aKuYdhMeAAFKy9awNBFaJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxLXFgMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsqcoP/jitxGNQKLTEPBPB0JD0RY0eGZ8XUEkX5QSpo8Qx
GHxFKRssYly4vwibo0xGHQA2MwwanKscEAShTi1y24ytnI5E376ZZd5Jd5k59eI5
7qN0imPuj4wE9Ej8K/36KlyMA4qRGsnsw79pCheN8h6Wn0DIEPQWFbMLA9k3Bx/P
nApCdg0eT8OD1eiNr47NCDSq2sad23WIg1Qw4PwIpDLLYHNhpJ4nFTN4hK36oUuc
pelNkqcGakxX946DS25+xCC58d7UhRzSMVqoQLN01m+xJjGiNp16CEPNZbuTac7A
liHDhfbd5nNspt6ApG3qqbnUF0qn3+7ZnTtkAufxg1ZlFTGe7Hd0RXPBKWFfVgTh
RQZ6MYD3csZQLUIYjTXwUCxwpBMnKs0pcYRjK/0sL79kVkgVCVpajYN8IQqEB+PM
leZ+xGezi5tRV5hJi360hBrMGmcqVBQkCemVJqfZUzMDpLSQtS4Itz3j36HyC69S
jxmGjW7UZoYbkM6iEb+aes11D2+4JuVObmM6OgYcNIbVxk3GD5e8/OYCeKNOPxsq
z/TVwUBnIcnOwBUBU2XMN07yzWQHqtwanMJ1pymxWOIrJ7yV/shNIfC3J3mRDm9Q
BSp6DbQkf/BFGv90O+dVId06ihgWS4Pn7m3OBXPEMUitEloG9dVVAy+3NW09XOZM
NiUV
=iaa1
-----END PGP SIGNATURE-----

--3wnKPDtpul9aKuYdhMeAAFKy9awNBFaJz--
