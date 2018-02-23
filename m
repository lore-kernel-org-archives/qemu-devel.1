Received: from eggs.gnu.org ([2001:4830:134:3::10]:38043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1epLlJ-0002h8-Lz
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1epLlI-00019O-Lc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:24:17 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:41686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1epLlI-00018T-Em
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:24:16 -0500
Received: by mail-ot0-x22e.google.com with SMTP id w38so8629697ota.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 14:24:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dc9974bc-0428-1a20-52c1-0aa46c7eebf9@linaro.org>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<dc9974bc-0428-1a20-52c1-0aa46c7eebf9@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Feb 2018 11:24:15 +1300
Message-ID: <CAHNT7Nvd+kxAdgbx2a5N9TfEWDmqvUrVCTXpy4MgGeo9aoJq2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, Peter Maydell <peter.maydell@linaro.org>

On Sat, Feb 24, 2018 at 10:31 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 02/22/2018 04:11 PM, Michael Clark wrote:
> > QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> >
> > This is hopefully the "fix remaining issues in-tree" release.
>
> FWIW, I'm happy with this.
>
> For those patches that I haven't given an explicit R-b, e.g. most of hw/, I
> didn't see anything obviously wrong.  So I'll give them
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>
> Unless anyone has any other comments, I would expect the next step would
> be for
> you to create a signed pull request for Peter.
>

Thanks Richard!

I might see if I can sort out the license changes for include/hw/riscv/*.h
and hw/riscv/*.h

In either case, I've set the wheels in motion for the license change so it
can happen out-of-tree or in-tree... as SiFive is fine with GPLv2+, at
least for their stuff...
