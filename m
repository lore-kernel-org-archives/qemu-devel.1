Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhuzF-0005Mu-TK
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhuzC-0008By-0W
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:56:13 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com
	([104.47.32.109]:24005
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fhuzB-0008Bi-OZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:56:09 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 24 Jul 2018 10:56:05 +0000
Message-ID: <BN7PR08MB4868284B9D3E798D810F1B1FC6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-5-git-send-email-stefan.markovic@rt-rk.com>,
	<469970e4-21cf-e7e6-bd3d-cedf265e5741@linaro.org>
In-Reply-To: <469970e4-21cf-e7e6-bd3d-cedf265e5741@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/40] target/mips: Add
 decode_nanomips_opc() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, July 19, 2018 6:39 PM
> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> >          decode_opc(env, ctx);
> >      } else if (ctx->insn_flags & ASE_MICROMIPS) {
> > -        ctx->opcode =3D cpu_lduw_code(env, ctx->base.pc_next);
> > -        insn_bytes =3D decode_micromips_opc(env, ctx);
> > +        if (env->insn_flags & ISA_NANOMIPS32) {
>
> Be consistent and use ctx->insn_flags.
>
> > +            ctx->opcode =3D cpu_lduw_code(env, ctx->base.pc_next);
> > +            insn_bytes =3D decode_nanomips_opc(env, ctx);
> > +        } else {
> > +            ctx->opcode =3D cpu_lduw_code(env, ctx->base.pc_next);
> > +            insn_bytes =3D decode_micromips_opc(env, ctx);
> > +        }
> >      } else if (ctx->insn_flags & ASE_MIPS16) {
> >          ctx->opcode =3D cpu_lduw_code(env, ctx->base.pc_next);
>
> Do you really want to nest nanoMIPS within microMIPS?
>
> I would have thought a better structure was
>
>   } else if (ctx->insn_flags & ISA_NANOMIPS32) {
>       ...
>   } else if (ctx->insn_flags & ASE_MICROMIPS) {
>       ...
>   } else if (ctx->insn_flags & ASE_MIPS16) {
>
>
> r~

Hi, Richard,

This will be fixed in the way you described in v4.

Aleksandar
