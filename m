Received: from eggs.gnu.org ([209.51.188.92]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMPR-0002wa-FX
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMPQ-0006mh-7b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCMPP-0006iX-6c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so7446327wrq.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:49:18 -0700 (PDT)
References: <20190405123928.70da87e2.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
Date: Fri, 5 Apr 2019 12:49:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190405123928.70da87e2.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
In-Reply-To: <20190405123928.70da87e2.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

On 4/5/19 12:39 PM, Olaf Hering wrote:
> It seems in qemu.git#master the edk2.git submodule is now mandatory.

The EDK2 submodule was added for UEFI testing, you don't need to compile
it to build/use QEMU.

How did you end up compiling it?

> For me it fails to compile. This is not a new error. It needs to be com=
piled with -fPIC since essentially forever.
>=20
> But I wonder, why does it fail to compile only for me?!
> Example of failure:
>=20
>  $ grep -h CommonLib.o /dev/shm/*/.build.log=20
> [   85s] gcc  -c  -I .. -I ../Include/Common -I ../Include/ -I ../Inclu=
de/IndustryStandard -I ../Common/ -I .. -I . -I ../Include/X64/  -MD -fsh=
ort-wchar -fno-strict-aliasing -Wall -Werror -Wno-deprecated-declarations=
 -Wno-stringop-truncation -Wno-restrict -Wno-unused-result -nostdlib -g -=
O2  CommonLib.c -o CommonLib.o
> [   89s] ar crs ../libs/libCommon.a BasePeCoff.o BinderFuncs.o CommonLi=
b.o Crc32.o Decompress.o EfiCompress.o EfiUtilityMsgs.o FirmwareVolumeBuf=
fer.o FvLib.o MemoryFile.o MyAlloc.o OsPath.o ParseGuidedSectionTools.o P=
arseInf.o PeCoffLoaderEx.o SimpleFileParsing.o StringFuncs.o TianoCompres=
s.o PcdValueCommon.o
> [  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
> [  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
> [  120s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
>=20
> What do I need to change in my setup so that -fPIC is not required?

Apparently your Linux distribution has transitioned to enabling PIE by
default in GCC 7, see:
https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

"This is achieved by a gcc defaults override in the "gcc-PIE" package."

Regards,

Phil.


--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynMqsACgkQoqP9bt6t
wN6rPBAAm4MM5iUy8Koceu92ju9lKju1alwJvGelswGjpYJmVofGROSSvqCCVn8L
JNSjM7JfWpfroJ2jL+RZutkbL10mBTOhh3nUU3WaSZJGsBOHyPneygrtIoTWI4nE
uEtUEKngmxPS78luW2XZfcKTVqccSrs05LehYg2b7o3eOVjcYHviz6bNSgnr4lcH
kvsFCj/YKP9Uqmo8o4yS10vcWkL4QYrjNqnQS+FbMf9QNhdKc72mg/i2BVpeGggi
VoZv5LWBd4Sic7Ga0icHSlIC9btyXofoDfp5li/sFSDiwAfrax78+E5fN/mN7yJi
qyoHFGgOsdM3vCIZL2xC9S1ZejV7BTxz0aEkOoejLYZlKAWmPm/iCNhSwoJLouSG
NNBEJ6TGaX1jn19iHhPetdw5S2hZ2nrtrbUd4yXbuPJBhhHH0pqWD5PG3A69TQE8
CpICc9+EKO2MY9JpQhWLT98ixbrtXQbKlS6jB2ckpTLTAOIgrgZ3dWJqZ73buyI+
GfhvRbLxd/JPWRFfsuk8io8wZQuPX8bdsQMH93j6M5oeoCLQV9qlAVZeYoMFV3no
XbRHXDxn1+hjVjUWGYuaqxsGg4qj+g6qjEdxounDg4w48XAfjvsqNn8hKxJ0A6C8
TTXb688+DQqGATMVCXbx8qSCyiCo80dzFrXAc4zdr55xxtIM/XQ=
=qgic
-----END PGP SIGNATURE-----

--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq--
