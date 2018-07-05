Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb17X-0005S9-Uu
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb17U-0001Wn-05
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:04:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58892 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fb17T-0001T6-Kk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:04:11 -0400
in-reply-to: <d87018ab-f66f-565c-813e-e1cdd204e635@amsat.org>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <2a85-5b3ded00-1-74fc2b80@223492324>
date: Thu, 05 Jul 2018 12:04:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQQVRDSCB2MyAzLzhdIHRh?=
 =?utf-8?q?rget/mips=3A_Update_some_CP0_registers_bit_definitions?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, qemu-devel@nongnu.org

Hi, Philippe!

I truly appreciate your review.

> > #define CP0C5=5FEVA 28
> > #define CP0C5=5FMSAEn 27
> > +#define CP0C5=5FPMJ2 25
> > +#define CP0C5=5FPMJ1 24
> > +#define CP0C5=5FPMJ0 23
> 
> Why not use:
> 
> #define CP0C5=5FPMJ 23 /* 25..23 */
> 

I now think that the way you suggested here is better, and will integra=
te it in v4.

> > +#define CP0C5=5FWR2 22
> > +#define CP0C5=5FNMS 21
> > +#define CP0C5=5FULS 20
> > +#define CP0C5=5FXPA 19
> > +#define CP0C5=5FCRCP 18
> > +#define CP0C5=5FMI 17
> > +#define CP0C5=5FGI1 16
> > +#define CP0C5=5FGI0 15
> 
> Ditto:
> 
> #define CP0C5=5FGI 15 /* 16..15 */
> 

The same.

> > +#define CP0C5=5FCA2 14
> > #define CP0C5=5FXNP 13
> > +#define CP0C5=5FDEC 11

Sincerely,
Aleksandar
