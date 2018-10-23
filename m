Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF24q-0003U1-4P
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF24m-0003ig-V6
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:10:52 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gF24k-0003PA-Oq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:10:48 -0400
Date: Tue, 23 Oct 2018 21:10:23 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181023191023.GB2244@sx9>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
	<alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Maciej,

>  I have no authority to approve such a change for the kernel, but it looks 
> reasonable to me and I will support you with it, with one reservation 
> however.  As this is an ISA extension in the vendor-specific space, I 
> think it belongs to a vendor-specific namespace, so as to make it clear it 
> is not a generic architectural feature and also to avoid name clashes.
> 
>  So it has to be called Toshiba MMI or suchlike, similarly to how I 
> requested that for the Longsoon MMI feature in a recent binutils review 
> (cf <https://sourceware.org/ml/binutils/2018-07/msg00201.html> and 
> binutils commit 8095d2f70e1a ("MIPS/GAS: Split Loongson MMI Instructions 
> from loongson2f/3a")), with all the consequences throughout.

Vendor ASE namespaces makes sense to me. I can prepare a patch for it.

>  NB all but pipeline 1 instructions of these are also implemented by other 
> members of the TXx9 family.  They seem to be referred to as just "multiply 
> and multiply-add instructions" in the TX79 manual (cf Section B.3.1).

Would

ASE_TOSHIBA_MMI  -- TX79 128-bit multimedia instructions
ASE_TOSHIBA_MAC  -- TXx9 multiply and multiply-add instructions (MADD etc.)
ASE_TOSHIBA_MAC1 -- TX79 pipeline 1 variant of ASE_TOSHIBA_MAC
ASE_TOSHIBA_FMA  -- R5900 FPU extensions (MADD.s etc.)

be acceptable for the currently known Toshiba extensions? (Please propose
better names.) One complication is that it seems only 8 bits are available
for all vendor ASEs, and Toshiba would then scoop up half of those.

Fredrik
