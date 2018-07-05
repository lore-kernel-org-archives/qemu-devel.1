Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb1Bg-0007Iy-VM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb1Bd-0005FP-ME
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:08:32 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60027 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fb1Bd-0005Cn-Dc
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:08:29 -0400
in-reply-to: <57a2af86-a882-7974-645b-048b630e9ef7@amsat.org>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <305b-5b3dee00-15-2f189dc0@98075977>
date: Thu, 05 Jul 2018 12:08:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQQVRDSCB2MyA1LzhdIHRh?=
 =?utf-8?q?rget/mips=3A_Add_CP0_BadInstrX_register?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, qemu-devel@nongnu.org

Hi, Philippe!

> > @@ -6711,6 +6720,11 @@ static void gen=5Fdmfc0(DisasContext *ctx, T=
CGv arg, int reg, int sel)
> > gen=5Fmfc0=5Fload32(arg, offsetof(CPUMIPSState, CP0=5FBadInstrP));
> > rn =3D "BadInstrP";
> > break;
> > + case 3:
> > + CP0=5FCHECK(ctx->bi);
> > + gen=5Fmfc0=5Fload32(arg, offsetof(CPUMIPSState, CP0=5FBadInstrX))=
;
> 
> I'm unsure re-using gen=5Fmfc0=5Fload32() is enough, shouldn't we zer=
o the
> 16 lower bits?

I contacted Stefan, and he says that you are right - zeroing 16 lower b=
its seems to be necessary. We'll hopefully fix this in v4.

Yours,
Aleksandar
