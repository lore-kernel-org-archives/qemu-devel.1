Received: from eggs.gnu.org ([2001:4830:134:3::10]:47335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fc8X4-0008Jx-Pg
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 08:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fc8X0-0007HV-Rj
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 08:11:14 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:42911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1fc8X0-0007Az-KR
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 08:11:10 -0400
Date: Sun, 8 Jul 2018 14:10:59 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20180708121057.GA13853@localhost.localdomain>
References: <20180707194137.GB14409@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180707194137.GB14409@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@debian.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

> I have tested the patch with Linux user mode emulation on a root filesystem
> compiled for R5900 and it worked without apparent issues, apart from:
> 
> 	qemu: Unsupported syscall: 4352 (seccomp)

I have also observed the following QEMU crash:

qemu-mipsel: qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

It occurred when compiling Perl, and it seems to be identical to this bug
reported by John Paul Adrian Glaubitz for SH4:

https://bugs.launchpad.net/qemu/+bug/1768246

Fredrik
