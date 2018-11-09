Received: from eggs.gnu.org ([2001:4830:134:3::10]:47772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7aM-00020I-3U
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7aE-0000sC-B6
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:16:31 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:37082
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7a9-0000io-AW
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:16:24 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992869AbeKIOOKJSQWw (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Fri, 9 Nov 2018 15:14:10 +0100
Date: Fri, 9 Nov 2018 14:14:10 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
Message-ID: <alpine.LFD.2.21.1811091403450.27920@eddie.linux-mips.org>
References: <cover.1541701393.git.noring@nocrew.org>
	<39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On Fri, 9 Nov 2018, Laurent Vivier wrote:

> if you have time, o32 & n32 support needs to be reworked.
> 
> We have two binaries qemu-mips and qemu-mipsn32 sharing the same ELF
> mask/magic.
> 
> As n32 identifies a kernel ABI version, we should have only one binary
> for qemu-mips and qemu-mipsn32 and the ABI version should be identified
> at runtime as it is done for ARM:
> 
>   ce4defa062 Arm Linux EABI syscall support.

 Are you sure?  So is the ARM ABI handled with ce4defa062 64-bit?

 The o32 ABI is 32-bit (32-bit GPR width) while n32 is 64-bit (64-bit GPR 
width).  The correspondence between the i386 ABI and the x86-64 x32 ABI is 
analogous to these two ABIs.

 How are these x86 ABIs handled WRT the user emulation mode; are they 
analogous to the ARM ABIs you've mentioned?

> [I think we can use e_flags for that]

 The EF_MIPS_ABI2 `e_flags' bit denotes the n32 ABI.  The container format 
is ELF32 obviously, because addressing is 32-bit with n32.

> I never did the change because I don't know where to find mipsn32
> binaries to test my changes.

 I believe MIPS64 Debian is all n32.

  Maciej
