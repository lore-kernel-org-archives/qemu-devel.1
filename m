Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqfWk-0007bl-1B
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqfWd-0007UV-51
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:14:56 -0400
Received: from mail-by2nam01on0115.outbound.protection.outlook.com
	([104.47.34.115]:35136
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqfWb-0007Sd-9V
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:14:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 17 Aug 2018 14:14:46 +0000
Message-ID: <BN7PR08MB48688FC1A005754C38D30573C63D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-49-git-send-email-aleksandar.markovic@rt-rk.com>,
	<b0b20986-875c-7c8e-a74f-ea7b27e1ec02@linaro.org>
In-Reply-To: <b0b20986-875c-7c8e-a74f-ea7b27e1ec02@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 48/84] disas: Add support for microMIPS
 and nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 16, 2018 7:57 PM
>=20
> Subject: Re: [PATCH v9 48/84] disas: Add support for microMIPS and nanoMI=
PS
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > +#define umips_decode_gpr3_reg_names(rn) mips_gpr_names[umips_decode_gp=
r3[rn]]
> > +#define umips_decode_gpr3_src_store_reg_names(rn) \
> > +    mips_gpr_names[umips_decode_gpr3_src_store[rn]]
> > +
> > +int nanomips_dis(char *buf, unsigned address, unsigned short one,
> > +                 unsigned short two, unsigned short three);
> > +
> > +int print_insn_micromips(bfd_vma memaddr, struct disassemble_info *inf=
o)
> > +{
>=20
> All of the umips stuff is GPLv3 code and cannot be included in QEMU.
>=20
> At least it corresponds quite closely to binutils commit
>=20
> commit df58fc944dbc6d5efd8d3826241b64b6af22f447 (HEAD)
> Author: Richard Sandiford <rdsandiford@googlemail.com>
> Date:   Sun Jul 24 14:20:15 2011 +0000
>=20
>     bfd/
>     2011-02-25  Chao-ying Fu  <fu@mips.com>
>                 Ilie Garbacea  <ilie@mips.com>
>                 Maciej W. Rozycki  <macro@codesourcery.com>
>                 Joseph Myers  <joseph@codesourcery.com>
>                 Catherine Moore  <clm@codesourcery.com>
>                 Richard Sandiford  <rdsandiford@googlemail.com>
>=20
> IANAL, and the GNU project has always allowed the original
> license holder to distribute under multiple licenses, which
> in this case would be mips.com, now wavecomp.com, but... ug.
>=20
> That said, you don't seem to actually be using *any* of the
> micromips bits.  You've stripped all of that out from the
> body of print_insn_micromips and then call into nanomips_dis.
>=20
> So just remove all of the bits you aren't using, and rename
> the entry point, and you'll be fine.
>=20
>=20
> > new file mode 100644
> > index 0000000..35c3973
> > --- /dev/null
> > +++ b/disas/nanomips.cpp
> > @@ -0,0 +1,15752 @@
> > +
> > +#include <cstring>
> > +#include <stdexcept>
> > +#include <sstream>
> > +
> > +#define INCLUDE_STANDALONE_UNIT_TEST
>=20
> This is new code and needs a comment at the top for its license.
>=20

Hi, Richard.

This is also all fixed in v10.

Ragards,
Aleksandar M.=
