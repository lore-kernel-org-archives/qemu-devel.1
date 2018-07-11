Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdFfz-0000I4-Ur
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdFfu-00048a-5U
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:01:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdFft-00048H-Ug
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:00:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id h10-v6so18292237wre.6
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:00:57 -0700 (PDT)
Date: Wed, 11 Jul 2018 15:00:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711140054.GL31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 11:11:29AM +0200, Emanuele Giuseppe Esposito wrote:
> Basic framework steps are the following:
> - All nodes and edges are created in their respective machine/driver/test files
> - The framework starts QEMU and asks for a list of available drivers
>   and machines

QEMU doesn't know about qtest drivers.  Does "drivers" mean "devices"
(i.e. qemu -device \?) and they have a 1:1 correspondence with qtest
drivers?

The concept of qgraph makes sense.  Ease of use and documentation will
be critical to gain adoption.  The extra complexity makes it hard for
people writing and running tests, so it's important that it's clear
which tests will get run and why (or why not).

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRg2WAAoJEJykq7OBq3PIpkcH/RfWLfRYmo15XMwtMu+x57Ed
2SW0AIezexO9RLdeolIqZxHEBh39Fb2yz72JU5w+DWjIXbyO6rbOgQgK3P4d7xvi
rnoTfjuE276cqxTGk+R8d7wRtlAwTayFLo2DaENmEQRsEhbPt5QoQc2pthaupyW5
fytMQv6QcHqsiMzY0obPgYW5aO1u2orjLH32MwVDu49WNbavplVE4zoX4OPTmmZu
8+iJvhn9ggNWHgDMJe9eoLgr1vA/1ccF1fA7xouOQevppaslg6txbe8JIuQWpE9b
gDFmvh3b6soWI1zL7nAqgfVea2CAmc6pHJ+MAeSKASvqQDlr12hHCDCPCvSFcLE=
=NYzH
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
