Received: from eggs.gnu.org ([2001:4830:134:3::10]:40097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs5qj-0007w5-52
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs5qf-0005VC-2w
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:33:29 -0400
Received: from mail-by2nam05on0703.outbound.protection.outlook.com
	([2a01:111:f400:fe52::703]:16056
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fs5qe-0005TP-K8
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:33:24 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 21 Aug 2018 12:33:05 +0000
Message-ID: <BN7PR08MB4868FACE2B457905E4A4CA68C6310@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>
	<97501a9d-c00f-7aba-1af2-256629f9abf5@linaro.org>
	<BN7PR08MB486867F6E966AB071EAC4ADBC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<444c2388-6f96-71ae-db7c-38a1d72c8954@linaro.org>,
	<BN7PR08MB4868A7DAB03930DC49C88EFCC63D0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868A7DAB03930DC49C88EFCC63D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT
 ASE instructions availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>


> > I think some of the previously-implemented similar cases involving read=
-only bits were handled the same way, and we just built on that. What would=
 you suggest as a more appropriate solution in such cases (of accessing "pr=
eset by hardware" bits)?
>
> Well, ctx->insn_flags and ctx->CP0_Config1 are good examples.
> These are 100% read-only and fixed at cpu instantiation.
>
> I see that CP0_Config3 has one writable bit for micromips, but
> is fully readonly for nanomips.  Therefore XNP and MT need not
> be copied to hflags because they will never vary.
>
> I'd suggest copying CP0_Config3 to ctx as with Config1.
>
>
> r~

Hi, Richard,

We ended up implementing this feature the way you suggested in the v11. Sor=
ry about snafu.

Regards,
Aleksandar
