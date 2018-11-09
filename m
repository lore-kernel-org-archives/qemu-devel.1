Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL4SA-0005O8-Kc
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL4Rz-0001aI-Qd
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:55:49 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:42453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gL4Rx-0000po-MX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:55:43 -0500
References: <cover.1541701393.git.noring@nocrew.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
Date: Fri, 9 Nov 2018 11:55:05 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1541701393.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user/mips: Support the n32 ABI
 for the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On 08/11/2018 19:42, Fredrik Noring wrote:
> Recognise the R5900, which reports itself as MIPS III, as a 64-bit CPU
> supporting the n32 ABI. Test that DMULT is emulated in user mode.

if you have time, o32 & n32 support needs to be reworked.

We have two binaries qemu-mips and qemu-mipsn32 sharing the same ELF
mask/magic.

As n32 identifies a kernel ABI version, we should have only one binary
for qemu-mips and qemu-mipsn32 and the ABI version should be identified
at runtime as it is done for ARM:

  ce4defa062 Arm Linux EABI syscall support.

[I think we can use e_flags for that]

I never did the change because I don't know where to find mipsn32
binaries to test my changes.

Thanks,
Laurent
