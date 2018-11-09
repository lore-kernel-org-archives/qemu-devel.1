Received: from eggs.gnu.org ([2001:4830:134:3::10]:38503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9jd-0004vm-Da
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9jX-0007VI-1I
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:34:16 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:52794
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9jW-0007QC-Mv
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:34:10 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992871AbeKIQeHueWov (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Fri, 9 Nov 2018 17:34:07 +0100
Date: Fri, 9 Nov 2018 16:34:07 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <8aee2864-4fb1-73e8-42d0-44598e663ac2@vivier.eu>
Message-ID: <alpine.LFD.2.21.1811091618230.27920@eddie.linux-mips.org>
References: <cover.1541701393.git.noring@nocrew.org>
	<39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
	<alpine.LFD.2.21.1811091403450.27920@eddie.linux-mips.org>
	<8aee2864-4fb1-73e8-42d0-44598e663ac2@vivier.eu>
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

> >  I believe MIPS64 Debian is all n32.
> 
> Some readelf results:
> 
> mips64el/stretch
> 
>   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
>   Class:   ELF64
>   Flags:   0x80000007, noreorder, pic, cpic, mips64r2

 Hmm, that's weird -- what executable did you check?  There may be some 
that are n64, or maybe they've switched (which I would applaud, FWIW).  I 
remember seeing mostly n32, with minimal support for n64, but that was a 
while ago -- jessie or suchlike, I believe.  Using MIPS64r2 as the base 
ISA also looks new to me, that used to be plain MIPS III, and some of 
Debian's MIPS build systems used to be either MIPS III (Lemote Loongson) 
or MIPS64r1 (Broadcom SiByte).

> Are there any distros that are 32bit but n32?

 You need 64-bit hardware for n32, so you can't do a 32-bit distribution 
with n32.  FAOD n32 is ILP32 with 64-bit `long long' and 64-bit stack 
slots both using the native 64-bit register width.

> Any binaries that need qemu-mipsn32 or qemu-mipsn32el?

 I'd expect at least the n32 dynamic loader (along with libc and some 
other essential DSOs) to be present with MIPS64 Debian.  Traditionally, 
under the FHS rules, it would be installed as /lib32/ld.so.1 (with the o32 
one as /lib/ld.so.1 and the n64 as /lib64/ld.so.1), but Debian uses their 
own multiarch filesystem layout standard, and offhand I don't remember 
what the paths are defined to there.

 Anyway, once you have tracked down the `ld.so.1' binary you can invoke it 
directly for some output, and it should be good enough for your smoke test 
purposes IIUC.

 I am away travelling through the end of this week and I have limited 
access to resources.  I can help more once I am back next week.

  Maciej
