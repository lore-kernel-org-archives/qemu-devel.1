Received: from eggs.gnu.org ([2001:4830:134:3::10]:41736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6MU-0000hb-WA
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6MQ-00048y-VJ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB6MQ-00048e-Lf
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:19:58 -0400
References: <218478942.134698.1495055111655.ref@mail.yahoo.com>
	<218478942.134698.1495055111655@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <044ef9e7-ffea-f096-69f6-a390c48b4970@redhat.com>
Date: Wed, 17 May 2017 16:19:55 -0500
MIME-Version: 1.0
In-Reply-To: <218478942.134698.1495055111655@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r4D1ocXILU6cmsF9jB6PLePvNCDwj3Q6S"
Subject: Re: [Qemu-devel] [PATCH] Add BCM2835 devices to Arm hardware.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "qemu-website@weilnetz.de" <qemu-website@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4D1ocXILU6cmsF9jB6PLePvNCDwj3Q6S
From: Eric Blake <eblake@redhat.com>
To: John Bradley <flypie1@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Martin Ijewski <gm.ijewski@web.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-website@weilnetz.de" <qemu-website@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <044ef9e7-ffea-f096-69f6-a390c48b4970@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Add BCM2835 devices to Arm hardware.
References: <218478942.134698.1495055111655.ref@mail.yahoo.com>
 <218478942.134698.1495055111655@mail.yahoo.com>
In-Reply-To: <218478942.134698.1495055111655@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 04:05 PM, John Bradley via Qemu-devel wrote:
>>From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Wed, 17 May 2017 18:57:21 +0100
> Subject: [PATCH] Add BCM2835 devices to Arm hardware.
>=20
> Signed-off-by: John Bradley <flypie@rocketmail.com>
> ---
> hw/arm/bcm2835.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> 1 file changed, 114 insertions(+)
>=20

> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/arm/bcm2835.h"

This file does not exist in master. Since it is obvious that this patch
depends on other patches you have pending, you should submit everything
as a patch series (where the patch adding bcm2835.h would be labeled
1/2, and this patch labeled 2/2, as well as with a 0/2 cover letter - or
0/N for however many N patches you plan to submit).  Posting each
dependent patch as a top-level thread with no documentation on how they
interrelate is just going to waste reviewer's time, as well as trigger
more bot-related compile failure messages to you, that could have been
prevented if it had been properly submitted as a series.

It looks like you are not using 'git send-email' to send your patches.
That makes it highly likely that your patches will be corrupted to the
point that they cannot be applied by automated tooling.  While a one-off
patch submission can usually be manually beaten into correct form by the
maintainer, it is much harder to offload this burden onto others when
you plan to submit a series - so you should really fix your workflow to
get 'git send-email' working properly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--r4D1ocXILU6cmsF9jB6PLePvNCDwj3Q6S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHL57AAoJEKeha0olJ0Nqnt8IAKYKRQsWGNqqDbSt/GN/N40/
xx4wJaIRe/Fpp9UvmRPekLiXFYMPV07SHEPHldCHLq/Q6RujFb5TpxQWN5eMcqx0
v3UcQvHNV4DVZK0zAbE/vTtAfddrj4gqbHJJqB+iTCkR/PXgMUZetYcwX9CBMmGE
e8khBSto9JSneJxLr1IIlft5DMgsYcbVBeAzWk6IrB4HZnfObgY/wr68YT76xajQ
n5UFzFApq23UPXW+evfTcExglwYKSLFssjMicvO8wf9ryjTWBXIE2PASrT0fh7E8
dsRi6zg4PQbn2ASVdUqeHpBRZXcvlROodCFNQ24XPIKI9yDWS9khDzJbQiKQTuo=
=4+Lx
-----END PGP SIGNATURE-----

--r4D1ocXILU6cmsF9jB6PLePvNCDwj3Q6S--
