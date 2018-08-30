Received: from eggs.gnu.org ([2001:4830:134:3::10]:34322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvN6x-0007ty-15
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvN3h-0004Of-Tc
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:32:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvN3h-0004O9-Jd
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:32:25 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 13:27:22 +0000
Message-ID: <85c2f315a87b473097798ed0a41c9e44@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
	<BN7PR08MB48689B528AF7931D4D0CAB63C6080@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB48689B528AF7931D4D0CAB63C6080@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

That seems like a good plan to separate these tasks. I will implement this =
in the next patchset. Thank you

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Thursday, August 30, 2018 8:40 AM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Petar Jovanovic <pjovanovic@wavecomp.com>; Richar=
d Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 0/8] Add limited MXU instruction support

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
