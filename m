Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fktZu-0004oR-1y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fktZo-0002Cs-Dt
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:22 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com
	([104.47.36.97]:59840
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fktZo-0002Bk-4L
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:16 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 1 Aug 2018 16:02:10 +0000
Message-ID: <BN7PR08MB4868954A9B34D08D2DA861F1C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-20-git-send-email-aleksandar.markovic@rt-rk.com>,
	<3cc80633-3b9f-07a4-1600-ca367dc6f5ba@linaro.org>
In-Reply-To: <3cc80633-3b9f-07a4-1600-ca367dc6f5ba@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 19/76] target/mips: Add emulation of
 nanoMIPS 16-bit arithmetic instructions
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

Hi, Richard.

> > +    case NM_P16_A2:
> > +        switch (extract32(ctx->opcode, 3, 1)) {
> > +        case NM_ADDIUR2:
> > +            rd =3D extract32(ctx->opcode, 0, 3) << 2;
> > +            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, rd);
> > +            break;
> > +        case NM_P_ADDIURS5:
> > +            rt =3D extract32(ctx->opcode, 5, 5);
> > +            if (rt !=3D 0) {
> > +                rs =3D (sextract32(ctx->opcode, 4, 1) << 3) |
> > +                      extract32(ctx->opcode, 0, 3);
> > +                /* s =3D sign_extend( s[3] . s[2:0] , from_nbits =3D 4=
)*/
> > +                gen_arith_imm(ctx, OPC_ADDIU, rt, rt, rs);
> > +            }
> > +            break;
> > +        }
>=20
> Now, these re-uses of RD and RS variables are misleading.
> These are immediates that you are extracting, not register numbers.
>=20
> I suggest a "target_long imm;" at the top of the function to handle all s=
uch
> that will be required when this function is filled out.

gen_arith_imm() and similar functions have "int" as the type of offset/imm =
parameter (in this case the last parameter) - shouldn't "int" be more appro=
priate type for local variable than "target_long"?

Aleksandar M.
