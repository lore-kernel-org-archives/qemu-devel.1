Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gOlme-0003k1-SR
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gOlma-00019r-UH
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:20 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:48182
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gOlma-00018t-LH
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:16 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992246AbeKSPqaSR0tA (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Mon, 19 Nov 2018 16:46:30 +0100
Date: Mon, 19 Nov 2018 15:46:30 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181119152952.GA2405@sx9>
Message-ID: <alpine.LFD.2.21.1811191537140.22162@eddie.linux-mips.org>
References: <20181118203312.5376-1-f4bug@amsat.org> <20181119152952.GA2405@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Mon, 19 Nov 2018, Fredrik Noring wrote:

> > The first patch adds a cross toolchain for the R5900 MIPS.
> > It is working correctly but the patches provided by Fredrik in [1] don't
> > have proper S-o-b, thus it is tagged RFC.
> > Fredrik: any update on the status of those patches upstream?
> 
> With GCC 8.2.0 and a current Gentoo this is even simpler. You should
> only need commit d728eb9085d8 ("MIPS: Default to --with-llsc for the
> R5900 Linux target as well"):
> 
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d728eb9085d8

 Of course you can instead just set the default manually by using 
`--with-llsc' when configuring GCC or specify `-mllsc' explicitly in 
CFLAGS with a compiler that has been already built without that set by 
default.

> For the o32 ABI with Glibc, only commit 8e3c00db16fc ("MIPS: Use `.set
> mips2' to emulate LL/SC for the R5900 too") is needed:
> 
> https://sourceware.org/git/?p=glibc.git;a=commit;h=8e3c00db16fc
> 
> Eventually, with a future GCC/Glibc release, no patches will be needed.

 For the record the glibc change will be available with upcoming glibc 
2.29, currently scheduled Feb 1st, 2019, and the GCC change will appear in 
GCC 9.1.0, currently scheduled Mar-Apr 2019.

 FWIW,

  Maciej
