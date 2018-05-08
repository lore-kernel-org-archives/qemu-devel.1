Received: from eggs.gnu.org ([2001:4830:134:3::10]:45103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG1vj-00041A-Ik
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG1vd-0000Sb-Vm
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:41:19 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG1vd-0000Rg-Pq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:41:13 -0400
Received: by mail-qk0-x233.google.com with SMTP id g4so6771604qki.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:41:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
Date: Tue, 8 May 2018 09:41:05 -0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="h3qNqyDfruqFGQPuKHOADNQnMmF6kbClR"
Subject: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3qNqyDfruqFGQPuKHOADNQnMmF6kbClR
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
Subject: tpm_emu_test_wait_cond: code should not be reached
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Travis CI hit this error testing commit 853f8ca13cd6d256:

$ clang --version
Apple LLVM version 8.1.0 (clang-802.0.42)
Target: x86_64-apple-darwin16.7.0

$ ./configure
C compiler        clang
host CPU          x86_64
=2E..
TPM support       yes
libssh2 support   no
TPM passthrough   no
TPM emulator      yes

  GTESTER check-qtest-i386
Unexpected error in qio_channel_socket_readv() at io/channel-socket.c:494=
:
**
ERROR:tests/tpm-emu.c:27:tpm_emu_test_wait_cond: code should not be reach=
ed
make: *** [check-qtest-i386] Error 1
make: *** Waiting for unfinished jobs....

see https://travis-ci.org/qemu/qemu/jobs/376289241

Regards,

Phil.


--h3qNqyDfruqFGQPuKHOADNQnMmF6kbClR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrxmuEACgkQ4+MsLN6t
wN4p9RAAx8QflLIF0Z9I2DeTsVB2BDq2cD6cpC8fTvkx3dA3ivceRnw3UL8eMVf5
j5JH7cp8s9qJjZgOK6D+mDy2cOIWoKy2WE7MrIGkpennBzQu6fBZjtUEKaTR5t17
QyQXTb9JhkteFMKZ+kCdOSjU2v3O2rYdONPVG74KzcP3aXM4NfEdpRn67QkkaglF
2jt5lE5vU28Wjedzr4mjNuJHSlEGd0e8HQ3CFp9VddyOYoDhFBLXWctNAC9vk4Xs
dNheN8T3eKW7ZTfwyh8YIKuV5JWIFqdUUi8cQ2rCh1JuMdOLWK9utVK+VLTRLoUC
ZWwkkx9cQ/QvJ9gWjRsnU/UTQx4z5rpIp/mbF6iBhROkOsqpEko11KjhJidhczAp
vjBjB3NRDjkIBkBb6rxx4FOnhYyWRCGzqa1mSTSTc186bmPMoNXK8GjczHN3Pf94
SNexW4fmHMHpGzhZVGKL7Nnf4Akrsup0g0EpSL3CQzlrTCLOaLoDHPEa8wiXAmMR
TeUOhzITUEXQmiuCiVzr5kPGpZFsfuua0D5do17ZQ4mAC99eMF5XYrhfMnRfswF1
0B0s8UsZ93VQsOPHxt/751kkze9C5CkmcfNPjnHOKt7jlPYx3b2dwiMPp5hvjlgq
1ZLAxTmKJhix8pqTNdVUnKVG4ncbXIfLrKvuHzRn/GExys2Wy/g=
=rbNG
-----END PGP SIGNATURE-----

--h3qNqyDfruqFGQPuKHOADNQnMmF6kbClR--
