Received: from eggs.gnu.org ([2001:4830:134:3::10]:46064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxqc-0003VW-Fx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxqY-00039o-Cb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtxqY-00039e-3a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:20:30 -0400
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-13-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3266d0b-afdd-385e-e407-5fe05aa49f1d@redhat.com>
Date: Mon, 18 Sep 2017 10:20:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170918024402.3265-13-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p0Qt2M1wh0Hhe0Kj02aMLIR2JFLrvq7oi"
Subject: Re: [Qemu-devel] [PATCH v8 12/13] tests: Add README for vm tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p0Qt2M1wh0Hhe0Kj02aMLIR2JFLrvq7oi
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <e3266d0b-afdd-385e-e407-5fe05aa49f1d@redhat.com>
Subject: Re: [PATCH v8 12/13] tests: Add README for vm tests
References: <20170918024402.3265-1-famz@redhat.com>
 <20170918024402.3265-13-famz@redhat.com>
In-Reply-To: <20170918024402.3265-13-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2017 09:44 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/README | 85 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 tests/vm/README

The README should ALSO mention that (some) of the guests created in this
manner are using a well-known public/private-key pair, and MUST NOT be
exposed to external interfaces if you are at all concerned about an
attacker being able to take over the guest VM and exploit any other qemu
bug that can then take over your host machine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p0Qt2M1wh0Hhe0Kj02aMLIR2JFLrvq7oi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/5DYACgkQp6FrSiUn
Q2rv9gf/dk9vRcOuhAWOKOUPl7Yut6lDtwCFBBQBCOzlOEZvixWtfBCOQFVDR1MX
pjl917RUkP8kXUQUO2QcLGqZD6Sqz51EEun8lOFjh8pEIY4Hs5NpMvUxv/EGQ0wP
qJeLMnfsU0kghXWG7CxgEDPNY6SvD5fohVlFL6A5RiwTA+BVyr5sWkyMXwKXkpp5
v8rwYL1ByfABb6mKBe8lRxhHXsAPuisMKLV5Kw2ONOTMLxfl5AnwhrNodgbiwu6u
05xPMtvR3wsIWQ26d99TGp7+2VtPHbTv9F4xyAdaly5ZyQu6yXIonAm6FwD3silE
CvIRTlBAomkF3Zuez83+n3tDAQULgg==
=GVfn
-----END PGP SIGNATURE-----

--p0Qt2M1wh0Hhe0Kj02aMLIR2JFLrvq7oi--
