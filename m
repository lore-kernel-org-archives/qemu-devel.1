Received: from eggs.gnu.org ([208.118.235.92]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezqh6-0000II-II
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezqg2-0008Tn-I7
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:27:20 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezqg2-0008TP-Dr
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:26:14 -0400
Received: by mail-oi0-x233.google.com with SMTP id u141-v6so13144274oif.1
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 14:26:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521915220-65389-3-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-3-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Mar 2018 21:25:53 +0000
Message-ID: <CAFEAcA8ByeRz-=3juyLZMeW8zK2Sa=u547ZCrEqgXqBibygQ=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 08/26] RISC-V: Make sure rom has space
 for fdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
> Remove a potential buffer overflow (not seen in practice).
> Perhaps cpu_physical_memory_write already has bound checks.

cpu_physical_memory_write() writes to the guest address
space, so it won't overflow. If you ask it to write
off the end of a ROM then it will correctly write into
an unassigned part of the guest memory space (which does
nothing) or into whatever device or other ram is there.
You probably don't want to do that, but it is not a buffer
overflow.

thanks
-- PMM
