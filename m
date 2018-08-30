Received: from eggs.gnu.org ([2001:4830:134:3::10]:46902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvMFF-00032b-9N
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvMFA-0006jk-CX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:40:15 -0400
Received: from mail-by2nam03on0125.outbound.protection.outlook.com
	([104.47.42.125]:24308
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fvMFA-0006jD-1B
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:40:12 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 30 Aug 2018 12:40:07 +0000
Message-ID: <BN7PR08MB48689B528AF7931D4D0CAB63C6080@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add limited MXU instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

Hi, Craig,

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
>=20
> Subject: [PATCH v3 0/8] Add limited MXU instruction support
>=20
> This patch set begins to add MXU instruction support for mips emulation.

Based on the info I have, I think a reasonable approach to integration of t=
his series would be:

- Add this line in mips-defs.h

#define   ASE_MXU       0x02000000

- In main switch, use this segment

        if (ctx->insn_flags & ASE_MXU) {
                decode_opc_special2_mxu(env, ctx);
        } else {
                decode_opc_special2_legacy(env, ctx);
        }

That way, you would be able to add MXU code without specifying CPU that sup=
ports it. This will enable you to focus on MXU, which is a serieoous task a=
nyway. Hopefully, a CPU will be added at some later date.

Thanks,
Aleksandar
