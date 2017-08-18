Received: from eggs.gnu.org ([2001:4830:134:3::10]:45767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1difKS-0000sO-8D
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1difKR-0004Vu-Ce
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:20:40 -0400
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Message-ID: <ae5953f1-267c-af76-e92e-3ad423ed2478@free.fr>
Date: Fri, 18 Aug 2017 13:20:27 +0200
MIME-Version: 1.0
In-Reply-To: <AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

Hi,

Le 18/08/2017 =C3=A0 11:30, luigi burdo a =C3=A9crit :
> hi Balaton, i can help with amigaos4 for sam . i can test it on P5040
> book3e and on G5 quad book3s machine. note sam for boot amigaos need
> a special modified version of uboot that is available on acube
> website it is a firmware update. without modified uboot will be not
> posdible auto boot amigaos. idont know if is possible use standard
> uboot incuded in qemu for boot amigaos from uboot command line. i can
> ask help to Enrico Vidale as my FB friend but i dont know if he will
> be available for this kind of helping.
>=20

Yes they use their own custom U-Boot, with a lot of changes and code
duplication, and added x86 emulation to run a VGA BIOS, and never
upstreamed the changes... much like any other vendor, sadly.

I once managed to build a binary from their published source code with
an old compiler, although it's not exactly the same of the binary used,
which I think is actually run with the on-chip RAM or something weird ali=
ke.

Fran=C3=A7ois.
