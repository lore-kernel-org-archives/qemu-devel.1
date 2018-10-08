Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9WCU-0006Ow-7w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9WCQ-0003fF-Vb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:07:58 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com
	([104.47.40.139]:20800
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1g9WCQ-0003eS-IZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:07:54 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 8 Oct 2018 14:07:50 +0000
Message-ID: <BN6PR2201MB1251B6322CF31E67F901AA9BC6E60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1538752793-6875-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538752793-6875-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target/mips: Add opcodes for
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>


> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
>=20
> Add opcodes for nanoMIPS EVA instructions: CACHEE, LBE, LBUE, LHE,
LHUE, LLE, LLWPE, LWE, PREFE, SBE, SCE, SCWPE, SHE, SWE.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch is incomplete. The pool P.LS.E0 has three subpools, and, for eac=
h of them,
corresponding opcodes should be created.

Thanks,
Aleksandar=
