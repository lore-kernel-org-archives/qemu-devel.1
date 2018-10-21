Received: from eggs.gnu.org ([2001:4830:134:3::10]:37110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gED6S-00066a-2P
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gECw8-0004vt-9D
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:34:32 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:53317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gECw8-0004uJ-1f
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:34:28 -0400
Date: Sun, 21 Oct 2018 14:34:23 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181021123423.GA2666@sx9>
References: <cover.1537379317.git.noring@nocrew.org>
	<b4a7f8e59ba8f6eaa03e7fe24690df7b39b17e8d.1537379317.git.noring@nocrew.org>
	<f299b045-eac4-9dec-3999-627d9984141f@amsat.org>
	<alpine.LFD.2.21.1809210020490.19067@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1809210020490.19067@eddie.linux-mips.org>
Subject: Re: [Qemu-devel] [PATCH v5 6/8] target/mips: Define the R5900 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Maciej,

>  The C790 is a follow-up to the R5900.  The R5900 has an FPU that is not 
> compliant to the IEEE 754 standard for floating-point arithmetic.  It 
> doesn't implement exceptions, infinities, NaNs or denormals.  It doesn't 
> implement the the double format either, but that is really tangential, 
> because the same was the case with the IDT R4650, which had a standard 
> IEEE 754 FPU, but no double format either.  Finally it has some anomalies 
> in the FP instruction set; not all opcode encodings are standard.

Do you know where one might find a list of the nonstandard FP instructions?

The command

% grep 'FP_.*EE' binutils/opcodes/mips-opc.c

gives a list of candidates, I suppose?

Fredrik
