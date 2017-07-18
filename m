Received: from eggs.gnu.org ([2001:4830:134:3::10]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaNi-0004Be-FZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaNh-0003Hr-Gi
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:50:14 -0400
References: <20170718045540.16322-1-f4bug@amsat.org>
	<20170718045540.16322-4-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ee89ade-2aae-4259-4c3a-651d1bee42a4@redhat.com>
Date: Tue, 18 Jul 2017 16:50:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170718045540.16322-4-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EOhfRSfjLkDbxG3iASoq2sMvlPR4Fx84r"
Subject: Re: [Qemu-devel] [PATCH v5 03/10] target/arm: optimize aarch64
 rev16() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOhfRSfjLkDbxG3iASoq2sMvlPR4Fx84r
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <0ee89ade-2aae-4259-4c3a-651d1bee42a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] target/arm: optimize aarch64
 rev16() using extract op
References: <20170718045540.16322-1-f4bug@amsat.org>
 <20170718045540.16322-4-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 11:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Aurelien Jarno denoted this function could be implemented more effectiv=
ely using
> the aarch32 rev16() pattern.
>   [http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03180.htm=
l]
>=20
> Done with the Coccinelle semantic patch from commit 58daf05d07dd

This commit id is not stable, unless it gets merged as a PULL request
from you.  When submitting a series, it's okay to just refer to "the
previous patch" or "an earlier patch" without a commit id, especially if
you know your patch will go through a different maintainer (and thus
change id's the moment it is modified to add an R-b or S-o-b).

>     (see scripts/coccinelle/tcg_gen_extract.cocci)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Richard: maybe you need to update 58daf05d07dd to your commit...

Indeed, you already noticed that the maintainer has to do more work to
rewrite any commit messages that refer to mid-series patch ids.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EOhfRSfjLkDbxG3iASoq2sMvlPR4Fx84r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllugooACgkQp6FrSiUn
Q2plgQgAld95AtqxbQkLwhG9oauu7DflX3uwb86zylh9rLFPUdokRC2hQYU/GYyC
ylD6I9AjZq+5ZuF2/uKUyoIRNWTl9KhC49FWObwuaN25kFmkcEsNhoOD0/q7RS3U
XFTGLrx/uZuvRpjxgxKoYNsDz7AvN2WSD4XMhVUjdcuKy+rPa1zzNXa+dCWPucXR
oFbN90xreQ68JRLqeP2ACnVB4YA6usLvAw0YNvjgw0eDo/6OdmiFXrRA5V91rukn
vSUFfPMuUgKnlJDyagIX9viGbvuAeRICRT8eGWBXmTc//ThdPNsk7Kr3eCmBumco
+ZaASmdy0zzFxbWKt1R78+1pRRectQ==
=9svZ
-----END PGP SIGNATURE-----

--EOhfRSfjLkDbxG3iASoq2sMvlPR4Fx84r--
