Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digvz-0005uH-MZ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digvu-0004Ir-OR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:03:31 -0400
Date: Fri, 18 Aug 2017 15:03:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <ae5953f1-267c-af76-e92e-3ad423ed2478@free.fr>
Message-ID: <alpine.BSF.2.21.1708181500260.19483@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<ae5953f1-267c-af76-e92e-3ad423ed2478@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?ISO-8859-15?Q?Fran=E7ois_Revol?= <revol@free.fr>
Cc: luigi burdo <intermediadc@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 18 Aug 2017, Fran=C3=A7ois Revol wrote:
> I once managed to build a binary from their published source code with
> an old compiler,

It builds here with the patch I've posted next to the bin image.

> although it's not exactly the same of the binary used,
> which I think is actually run with the on-chip RAM or something weird a=
like.

Maybe it's the same but we may have a problem with MMU emulation so it=20
behaves differently (or they've compiled with different compiler/version=20
which generates different code, I haven't checked that deep).

But AROS has a problem with MMU so it may be a bug. I'll send a separate=20
message about that.

Regards,
BALATON Zoltan
