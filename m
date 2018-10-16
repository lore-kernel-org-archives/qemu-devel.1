Received: from eggs.gnu.org ([2001:4830:134:3::10]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCQxc-0004PK-J7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCQxX-0005j6-Mx
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:08:40 -0400
Received: from mail-co1nam03on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe48::71a]:24668
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCQxW-0005Yk-FZ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:08:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 16 Oct 2018 15:08:25 +0000
Message-ID: <BN6PR2201MB1251D7F521F61B0598E0D2F1C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-9-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAAdtpL44km+bdSVfx=M-eMaXSrAKvChbAvED--9-nQxv=5-Esg@mail.gmail.com>
In-Reply-To: <CAAdtpL44km+bdSVfx=M-eMaXSrAKvChbAvED--9-nQxv=5-Esg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 08/28] target/mips: Add CPO PWBase
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philippe@mathieu-daude.net>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philippe@mathieu-daude.net>

> > @@ -6948,6 +6969,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
> >              tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Seg=
Ctl2));
> >              rn =3D "SegCtl2";
> >              break;
> > +        case 5:
> > +            check_pw(ctx);
> > +            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWB=
ase));

> Shouldn't you use gen_mfc0_load64()?

It looks to me that  tcg_gen_ld_tl() is appropriate here. It will properly =
handle endianess. There is no need for sign-extension here.

There are other 64-bit related issues wrt PWxxx registers in this patch, bu=
t this particular line looks OK to me.

Thanks,
Aleksandar
