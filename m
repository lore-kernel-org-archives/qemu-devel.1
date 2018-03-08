Received: from eggs.gnu.org ([2001:4830:134:3::10]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etu2q-0008IZ-0e
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etu2m-0000jr-Uk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:49:12 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etu2m-0000hx-Nd
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:49:08 -0500
Received: by mail-wr0-f181.google.com with SMTP id a63so1756899wrc.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 03:49:07 -0800 (PST)
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_G1tHrBZ=GxAy0b-SLbYU2-XOAUNL0D=8MQeL0Roz_cQ@mail.gmail.com>
	<CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
	<CAHNT7NuqgY-zgPJT4gUJMaHr24E-PwrN=Eje+m1XW24mAf07Ag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f03bbee3-f308-9ec8-050e-3a0534837b9c@redhat.com>
Date: Thu, 8 Mar 2018 12:49:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuqgY-zgPJT4gUJMaHr24E-PwrN=Eje+m1XW24mAf07Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 08/03/2018 12:18, Michael Clark wrote:
>> There are multiple sign-offs in all
>> 23 commits. The tag is riscv-qemu-upstream-v8.2

Except your cover letter lists 45 commits and, as Daniel has already confirmed,
Peter is right: these commits listed in the cover letter have no sign-off and
have not been reviewed:

      RISC-V - Make virt create_fdt interface consistent with other boards
      RISC-V - Replace hardcoded device-tree constants with enum values
      RISC-V - Make virt board description match spike format
      RISC-V - Use ROM base address and size constants from memory map
      RISC-V - Remove redundant identity_translate callback from load_elf
      RISC-V - Mark ROM read-only after copying in reset vector and config
      RISC-V - Remove unused class definitions from machines
      RISC-V - Make sure the emulated mask rom has space for device-tree
      RISC-V - Include hexidecimal instruction packets in disassembly
      RISC-V - Need to hold rcu_read_lock when accessing memory directly
      RISC-V - Improve page table walker spec compliance and add comments
      RISC-V - Update E order and note that add E and I are mutually exclusive
      RISC-V - Make spike and virt header guards more specific
      RISC-V - Make virt header comment consistent with source file
      RISC-V - Use memory_region_is_ram in atomic pte update
      RISC-V - Remove EM_RISCV ELF_MACHINE indirection from load_elf
      RISC-V - Ingore satp writes and return 0 for reads when no-mmu
      RISC-V - Remove braces from satp case statement with no locals
      RISC-V - riscv-qemu port supports sv39 and sv48
      RISC-V - vectored traps for asynchrounous interrupts are optional
      RISC-V - Dont' trap on writes to misa,minstret[h],mcycle[h]
      RISC-V - Remove support for adhoc non-standard X_COP local-interrupt

> You are making this very hard. Do you work for Arm perchance? I really
> wouldn’t be surprised if our port is being sandbagged by Arm. Apologies for
> being so direct about this, but things like this happen...
> 
> I have complied with practically every review request and the sign-offs are
> there. It’s a bit ridiculous.
> 
> It would be nice to find someone neutral, unrelated to Arm, to merge our PR

Just don't do this.  If you don't trust the maintainers, I don't see why 
the maintainers should merge the RISC-V port; no one needs an history
lesson on RISC or ARM or RISC-V either.  And you can understand that adding
and reviewing 10K lines of code requires a significant effort, that some of
the maintainers are doing in their spare time.

In fact, I looked at "RISC-V - Need to hold rcu_read_lock when accessing
memory directly" and from a first look it's wrong.  So I think you owe an
apology...

Paolo
