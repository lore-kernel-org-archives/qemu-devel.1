Received: from eggs.gnu.org ([2001:4830:134:3::10]:39994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flDU3-0001L0-L5
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 09:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flDTy-0008Uo-NA
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 09:17:39 -0400
Received: from mail-eopbgr730110.outbound.protection.outlook.com
	([40.107.73.110]:53696
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flDTy-0008Ub-Cd
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 09:17:34 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 2 Aug 2018 13:17:30 +0000
Message-ID: <BN7PR08MB4868B3B9B13EA336975B2FA0C62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-33-git-send-email-aleksandar.markovic@rt-rk.com>,
	<2a146c97-8dc7-31d8-a0eb-4e92216b16d5@linaro.org>
In-Reply-To: <2a146c97-8dc7-31d8-a0eb-4e92216b16d5@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 32/76] target/mips: Add emulation of
 misc nanoMIPS instructions (p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Something like
>=20
>     unsigned opc =3D extract32(ctx->opcode, 7, 4);
>     TCGMemOp mop;
>=20
>     switch (opc) {
>     case NM_LBX:
>         mop =3D MO_SB;
>         break;
>     ...
>     }
>     mop |=3D ctx->default_tcg_memop_mask;
>=20
>     if (extract32(ctx->opcode, 6, 1)) {
>         tcg_gen_shli_tl(t0, t0, mop & MO_SIZE);
>     }
>     gen_op_addr_add(ctx, t0, t0, t1);
>=20
>     switch (opc) {
>     case NM_LBX: // and all other integer loads
>        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mop);
>        gen_store_gpr(t0, rd);
>        break;
>     case NM_SBX: // and all other integer stores
>        gen_load_gpr(t1, td);
>        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mop);
>        break;
>     case NM_LWC1X: // and all other fp ops
>        if (ctx->CP0_Config1...) {
>           ...
>        }
>     }

We plan to do this this way, but this will not be ready for v6, since it is=
 deemed low priority (there is no bug in emulator behavior related to this =
code segment).

Regards,
Aleksandar=
