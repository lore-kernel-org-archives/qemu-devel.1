Received: from eggs.gnu.org ([2001:4830:134:3::10]:50210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF2JB-0000TS-CQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF2J6-0001BZ-8w
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:25:41 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gF2J5-00013s-F1
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:25:36 -0400
Date: Tue, 23 Oct 2018 21:25:25 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181023192525.GC2244@sx9>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Maciej,

> target/mips/translate.c:4888:38: error: passing argument 3 of
> =E2=80=98tcg_gen_add2_i32=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>              tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3)=
;
>                                       ^~~~~~

Would you know if any MIPS ISA have LO and HI registers that are not
32-bit? In QEMU they can obviously be either 32-bit or 64-bit, which
causes the compilation error here.

Fredrik
