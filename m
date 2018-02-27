Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sorear2@gmail.com>) id 1eqhWZ-0006GY-1e
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sorear2@gmail.com>) id 1eqhWX-0002PB-QF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:50:39 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sorear2@gmail.com>) id 1eqhWX-0002NR-IU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:50:37 -0500
Received: by mail-lf0-x244.google.com with SMTP id x196so28193199lfd.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:50:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
From: "Stef O'Rear" <sorear2@gmail.com>
Date: Tue, 27 Feb 2018 07:50:34 -0800
Message-ID: <CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re:  [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: patches@groups.riscv.org
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Feb 27, 2018 at 6:01 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>>
>>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>>
>> are available in the git repository at:
>>
>>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v7
>>
>> for you to fetch changes up to 170a9d412ca1eb3b7ae6f6c1ff86dcbdff0fd7a8:
>>
>>   RISC-V Build Infrastructure (2018-02-27 11:09:43 +1300)
>>
>> - ----------------------------------------------------------------
>> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
>
> Hi; thanks for this pull request. Unfortunately it seems to
> be missing Signed-off-by: tags. Every commit needs to have
> the Signed-off-by: tags from the people who contributed code to
> it, indicating that they're OK with the code going into QEMU.
> (If the work was done by and copyright a company then you don't
> need to provide signoffs from every person at the company who
> worked on the code if you don't want to.)

I'll add mine.

>> The spike_v1.9
>> machine has been renamed to spike_v1.9.1 to match the privileged ISA
>> version and spike_v1.10 has been made the default machine.
>
> I'm confused about this. Generally QEMU boards should model
> hardware, and the board shouldn't care about the ISA versions.

The spike boards model the Berkeley architectural simulator "spike"
(https://github.com/riscv/riscv-isa-sim), which does not have a formal
release process or version numbers so we are using the ISA version as
a proxy for spike's version.

When physical boards are released with full documentation I presume we
will be adding board definitions for them, and they will imply
specific ISA versions.

> Versioned board names in QEMU generally follow _QEMU_'s versioning,
> and indicate that a board is identical to whatever we modelled
> in that earlier QEMU version, for VM migration compatibility.

In this case we're handling two logically distinct boards.  We could
combine them and implement a parameter; I was having trouble finding a
suitable example to follow earlier but it looks like gic-version in
hw/arm/virt.c is one.  This seems like a bad thing to change this late
in the review though?

> Board renames for minor ISA version bumps sounds like there's going
> to be a lot of churn and breakage -- is this stuff really ready?
> (Also, should we really have two different board source files
> for two different ISA versions? I would have expected these to
> share a source file to share code.)

1.10 is the version we have committed to long term support for; it
matches all public hardware the upstream Linux port, so it seems
appropriate to use for QEMU.

1.9.1 was the version supported by riscv-qemu at the time Michael
Clark took over maintainership; we have not removed support for it
because we cannot prove that there is nobody depending on it, although
I do not use it myself and do not know anyone else who does, so I
would not personably object to removing it if that were required.

Combining spike_v1.10 and spike_v1.9.1 would also be an option amenable to us.

-s
