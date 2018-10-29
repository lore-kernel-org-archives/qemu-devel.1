Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH5VN-00029J-8j
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH5VI-0002oB-FA
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:14:45 -0400
Received: from mail-eopbgr680102.outbound.protection.outlook.com
	([40.107.68.102]:39796
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gH5VH-000228-LC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:14:40 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 11:14:21 +0000
Message-ID: <BN6PR2201MB125136E747A2C4C4051A814DC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-3-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA9H9gWbdcxvfJqcubAR0xaGaZfHTnBu-99KEWbV+uqxbA@mail.gmail.com>
In-Reply-To: <CAFEAcA9H9gWbdcxvfJqcubAR0xaGaZfHTnBu-99KEWbV+uqxbA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 2/3] target/mips: Implement emulation of
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Monday, October 29, 2018 11:57 AM
> Subject: Re: [PULL 2/3] target/mips: Implement emulation of nanoMIPS EVA =
instructions
>=20
> On 25 October 2018 at 21:19, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> > From: Dimitrije Nikolic <dnikolic@wavecomp.com>
> >
> > Implement emulation of nanoMIPS EVA instructions. They are all
> > part of P.LS.E0 instruction pool, or one of its subpools.
> >
> > Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> > Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > --
>=20
> Hi; Coverity points out (CID 1396475) that the switch
> cases for NM_LLWPE and NM_SCWPE fall through without
> either a 'break' statement or a '/* fall through */' comment:
>=20
> > +                case NM_P_LLE:
> > +                    switch (extract32(ctx->opcode, 2, 2)) {
> > +                    case NM_LLE:
> > +                        check_xnp(ctx);
> > +                        check_eva(ctx);
> > +                        check_cp0_enabled(ctx);
> > +                        gen_ld(ctx, OPC_LLE, rt, rs, s);
> > +                        break;
> > +                    case NM_LLWPE:
> > +                        check_xnp(ctx);
> > +                        check_eva(ctx);
> > +                        check_cp0_enabled(ctx);
> > +                        gen_llwp(ctx, rs, 0, rt, extract32(ctx->opcode=
, 3, 5));
> > +                    default:
> > +                        generate_exception_end(ctx, EXCP_RI);
> > +                        break;
> > +                    }
> > +                    break;
> > +                case NM_P_SCE:
> > +                    switch (extract32(ctx->opcode, 2, 2)) {
> > +                    case NM_SCE:
> > +                        check_xnp(ctx);
> > +                        check_eva(ctx);
> > +                        check_cp0_enabled(ctx);
> > +                        gen_st_cond(ctx, OPC_SCE, rt, rs, s);
> > +                        break;
> > +                    case NM_SCWPE:
> > +                        check_xnp(ctx);
> > +                        check_eva(ctx);
> > +                        check_cp0_enabled(ctx);
> > +                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode=
, 3, 5));
> > +                    default:
> > +                        generate_exception_end(ctx, EXCP_RI);
> > +                        break;
> > +                    }
> > +                    break;
> > +                }
> > +                break;
> >              case NM_P_LS_WM:
> >              case NM_P_LS_UAWM:
> >                  check_nms(ctx);
>=20
> Could you send a patch which adds whichever of the two is correct, please=
?
>

Sure. 'break' is missing in both cases.

Thanks,
Aleksandar

> thanks
> -- PMM
