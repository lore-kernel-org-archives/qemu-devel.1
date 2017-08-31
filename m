Received: from eggs.gnu.org ([2001:4830:134:3::10]:49577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnSEN-0007Ag-Mh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnSEK-0000x3-Gw
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnSEK-0000wo-8u
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:22:08 -0400
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<20170831161835.GQ17315@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f9a3540-2c90-5ded-9581-d1098070f40e@redhat.com>
Date: Thu, 31 Aug 2017 11:21:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170831161835.GQ17315@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xlmxCmmawX6tv3Cd1U012kLPFoQpepB4O"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xlmxCmmawX6tv3Cd1U012kLPFoQpepB4O
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Message-ID: <5f9a3540-2c90-5ded-9581-d1098070f40e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
References: <20170831112210.19921-1-famz@redhat.com>
 <20170831112210.19921-4-famz@redhat.com> <20170831161835.GQ17315@redhat.com>
In-Reply-To: <20170831161835.GQ17315@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 11:18 AM, Daniel P. Berrange wrote:
>=20
> 'qcow' (v1) was also passing last time I checked, though it is
> waaaaaay slow to run compared to qcow2, so I'd understand if you
> were reluctant to turn that on due to speed

Even './check -qcow -g quick' might be nicer than nothing, but that is
also slooooooow

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xlmxCmmawX6tv3Cd1U012kLPFoQpepB4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoN6QACgkQp6FrSiUn
Q2rAZQgAox9mO5tak1MJdYXndSUuZnk3mjHg/1lSitpfLTCZypHWJNZrQMfF+Pjp
n6P8OLHw9VCrQgQ5naYkWKQdVDszkhuNz795nCeyqxwTcIsOuQlg0mToRMMgfxz4
1B51NrhkyExFaOGOs6X81/YEn8Q85D3xQcAMpf3QWQ4axrh6XgkeQzdOjg2lZmAI
uuXlZWiZMpzmgP+n78xk4DQtC1mRTKdSgSVyDIX+k9yqJaddzBKGJBUVOtgnPYcn
B9Ikj7s9yejf0AxwiVvieJIbyUhAbMo6V2kMQqZgnLFv78nhJAUbPUMx2CdmcT8J
dE35M6tJXPp7pVdRF5r+/7ARdlQnIw==
=XF8N
-----END PGP SIGNATURE-----

--xlmxCmmawX6tv3Cd1U012kLPFoQpepB4O--
