Received: from eggs.gnu.org ([2001:4830:134:3::10]:37817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgY48-00016U-Bq
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgY45-0007rR-6H
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:36 -0400
Received: from mail-bl2nam02on0133.outbound.protection.outlook.com
	([104.47.38.133]:65216
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fgY44-0007qZ-Ph
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:33 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 20 Jul 2018 16:15:28 +0000
Message-ID: <BN7PR08MB48689FC1E72B07CD227864DAC6510@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-15-git-send-email-stefan.markovic@rt-rk.com>,
	<c9a8b3f6-39da-94af-32f5-3af812f3d7d8@linaro.org>
In-Reply-To: <c9a8b3f6-39da-94af-32f5-3af812f3d7d8@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/40] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32axf)
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
> Sent: Thursday, July 19, 2018 9:13 PM
>
> >          case NM_POOL32A7:
> > +        {
> > +            switch ((ctx->opcode >> 3) & 0x07) {
> > +            case NM_POOL32AXF:
> > +                gen_pool32axf_nanomips_insn(env, ctx);
> > +                break;
> > +            }
> > +        }
>
> Bad indentation of a block that need not exist anyway.
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Outer braces are unnecessary. The switch is missing the default case. This =
switch statement is amended in one of subsequent patches, and at the end it=
 contains four cases, but no default case. The missing default should be fi=
xed in this patch.
