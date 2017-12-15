Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePl7d-0002sj-Lp
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePl7Z-0006l5-Jz
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:13:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePl7Z-0006kd-Ak
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:13:29 -0500
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
	<20171214090658.GA3731@dhcp-200-186.str.redhat.com>
	<10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
	<481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6325b8e-e0b0-ae9f-6729-b951c9f0caba@redhat.com>
Date: Fri, 15 Dec 2017 09:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1bDncdU2SVtRV8Uo6lONFNNAowh1PRTBt"
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1bDncdU2SVtRV8Uo6lONFNNAowh1PRTBt
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <b6325b8e-e0b0-ae9f-6729-b951c9f0caba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
References: <20171213232025.24503-1-f4bug@amsat.org>
 <20171213232025.24503-2-f4bug@amsat.org>
 <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
 <10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
 <481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
In-Reply-To: <481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/12/2017 14:25, Philippe Mathieu-Daud=C3=A9 wrote:
> Yes, a SDHCI qtest is added in a later series (in C) using MMIO access:=

> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02391.html
>=20
> But to be sure the SDHCI is correct I needed a SD slave to behave
> correctly ;) Hence this "bus test".

You could also use the SPI interface for a lower-level test.

Paolo


--1bDncdU2SVtRV8Uo6lONFNNAowh1PRTBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlozhBcACgkQv/vSX3jH
roPi5Af9Fv91K2X7KlKq3p6A7d0QjupD7ZfQVaTve2X5ODPrBcJVc0+NBy8Q5GT4
ICyYWtkGFosfTbxkd39lsTbonc1lgUGt3BjNba5S55pRPYUUO9Zttxt76ahEs71T
+Vpa//9/RsvQ2KpfRLI6maolOhA/ZebVeFXGuIlzl+CNbWcukJkMwduvN/lzCALG
mAZt42BLDFvSFAfXTXnQwSFQ3cdyN+oemD9UG0n0Q5agjuoQ/9imQNnwfHF+M+ML
EulFYkeLmACIebosrHrFtXmLEjsQN45aVi3TvZ9wJ+8dDShLc0s4Yi3QLDUMvtRC
FJbK8+Ykx0tlyaNeIcT+Y/C8BE9y3g==
=EJrj
-----END PGP SIGNATURE-----

--1bDncdU2SVtRV8Uo6lONFNNAowh1PRTBt--
