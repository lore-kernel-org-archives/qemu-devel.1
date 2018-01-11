Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eZiLW-0004AL-S0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eZiLS-0000Uq-RW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:17:02 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1eZiLS-0000UU-Kg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:16:58 -0500
Received: by mail-pg0-x243.google.com with SMTP id 136so2273749pgd.8
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:16:58 -0800 (PST)
Date: Thu, 11 Jan 2018 11:16:56 -0800 (PST)
In-Reply-To: <20180111075812.GA32651@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-24816c3a-ac9d-4537-8b58-6717618946e8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hch@lst.de
Cc: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de, patches+subscribe@groups.riscv.org, sagark@eecs.berkeley.edu

On Wed, 10 Jan 2018 23:58:12 PST (-0800), hch@lst.de wrote:
> On Wed, Jan 10, 2018 at 03:46:19PM -0800, Michael Clark wrote:
>> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
>> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
>> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
>
> Same question as for V2:  Why do you want to add code for an obsolete
> version of the privileged ISA spec? (which as far as I can tell
> can't even be found online).

We have a 1.9.1 chip, and that currently constitutes the vast majority of the 
RISC-V silicon in the wild.  The (somewhat lofty) goal is to eventually be able 
to emulate every RISC-V system in the world.

The spec is still available online

  https://github.com/riscv/riscv-isa-manual/blob/master/release/riscv-privileged-v1.9.1.pdf
