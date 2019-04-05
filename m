Received: from eggs.gnu.org ([209.51.188.92]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMGB-0000Eb-Gj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMG9-0005xL-Ij
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:47 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::2]:35365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMG5-0005rT-KI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:44 -0400
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35AdZpHN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate) for <qemu-devel@nongnu.org>;
	Fri, 5 Apr 2019 12:39:35 +0200 (CEST)
Date: Fri, 5 Apr 2019 12:39:28 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405123928.70da87e2.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/AYpR9aZwhs_17BsV=fNIudv";
	protocol="application/pgp-signature"
Subject: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--Sig_/AYpR9aZwhs_17BsV=fNIudv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

It seems in qemu.git#master the edk2.git submodule is now mandatory.
For me it fails to compile. This is not a new error. It needs to be compile=
d with -fPIC since essentially forever.

But I wonder, why does it fail to compile only for me?!
Example of failure:

 $ grep -h CommonLib.o /dev/shm/*/.build.log=20
[   85s] gcc  -c  -I .. -I ../Include/Common -I ../Include/ -I ../Include/I=
ndustryStandard -I ../Common/ -I .. -I . -I ../Include/X64/  -MD -fshort-wc=
har -fno-strict-aliasing -Wall -Werror -Wno-deprecated-declarations -Wno-st=
ringop-truncation -Wno-restrict -Wno-unused-result -nostdlib -g -O2  Common=
Lib.c -o CommonLib.o
[   89s] ar crs ../libs/libCommon.a BasePeCoff.o BinderFuncs.o CommonLib.o =
Crc32.o Decompress.o EfiCompress.o EfiUtilityMsgs.o FirmwareVolumeBuffer.o =
FvLib.o MemoryFile.o MyAlloc.o OsPath.o ParseGuidedSectionTools.o ParseInf.=
o PeCoffLoaderEx.o SimpleFileParsing.o StringFuncs.o TianoCompress.o PcdVal=
ueCommon.o
[  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC
[  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC
[  120s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC

What do I need to change in my setup so that -fPIC is not required?

Olaf

--Sig_/AYpR9aZwhs_17BsV=fNIudv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKcwYAAKCRBdQqD6ppg2
fur5AJ9MGZtoafXZUTXbNLVTny3ukV+yJgCglJTI8TeRtBuWk5Cv59y64iXjZpY=
=++Fo
-----END PGP SIGNATURE-----

--Sig_/AYpR9aZwhs_17BsV=fNIudv--
