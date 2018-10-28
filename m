Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGpM0-0004lW-EN
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 14:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGpLl-0001Ue-Ac
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 13:59:51 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com
	([40.107.68.106]:47680
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gGpK5-0000sj-Nk
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 13:59:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sun, 28 Oct 2018 17:57:54 +0000
Message-ID: <BN6PR2201MB12514D71C5469F4080A1C123C6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540383527-7923-5-git-send-email-aleksandar.markovic@rt-rk.com>,
	<51e7458e-935f-5775-af64-0908b2110ed7@wavecomp.com>
In-Reply-To: <51e7458e-935f-5775-af64-0908b2110ed7@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 04/20] target/mips: Add and integrate
 MXU decoding engine placeholder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Is the best way to implement this to include processing of MUL, CLZ,
> CLO, SDBBP instructions into decode_opc_mxu as their encodings aren't
> overlaid by MXU instructions considering MIPS SPECIAL2 instruction
> pool and MXU Instruction Set?

The problem is that we don't have the documentation for Ingenic's base
instruction set. My understanding is that Craig established necessity of
including non-MXU MUL into decode_opc_mxu() by experimentation,
or by looking at Ingenic's toolchain source code.

Note that CLZ, CLO, SDBBP are moved from SPECIAL2 to another
place in opcode space in MIPS R6.

Craig, can you offer any insight on CLZ, CLO, SDBBP in Ingenic's base
instruction set? They are in SPECIAL2 opcode space for MIPS pre-R6.

Worse come to worst, I recommend adding "TODO" comment to an
appropriate place in decode_opc_mxu(), and go forward without handling
CLZ, CLO, SDBBP - given that all changes in this series are just the first
phase of implementing MXU support - they won't affect any production
code at this moment.

I appreciate your review,
Aleksandar=
