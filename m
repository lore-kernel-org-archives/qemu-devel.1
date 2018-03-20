Received: from eggs.gnu.org ([2001:4830:134:3::10]:45976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey97D-0005xZ-RA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey979-0001wY-KR
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:43:15 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:34919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ey979-0001tv-Da
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:43:11 -0400
Received: by mail-pf0-x22c.google.com with SMTP id y186so203878pfb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 21:43:11 -0700 (PDT)
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75283674-1f4b-453c-0833-d84ab76a52cd@linaro.org>
Date: Tue, 20 Mar 2018 12:43:04 +0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>

On 03/20/2018 02:35 AM, Michael Clark wrote:
> FYI - I also have an experimental branch containing a RISC-V TCG back-end
> that I started on during the RISC-V Hackathon in Portland last week:
> 
> - https://github.com/michaeljclark/riscv-qemu/tree/wip-riscv-tcg-backend

Cool.

> I'm able to run a very simple x86_64 hello world program on RISC-V,
> avoiding all of the usual libc startup. However, it may be some time before
> I submit a patch series for this branch. So far the RISC-V TCG backend
> doesn't implement softmmu, have bigendian byteswapping in its load/store
> implementation ...

Before you work too hard on this last, ping me.  I've been intending to change
TCG such that hosts that do not support byte-swapping memory operations do not
need to handle them specially.  Instead, we'd expand a "normal" byte swap from
a temporary after a load (and similarly before a store).

I expect this to improve the state of affairs for i386 (without movbe), where
we are currently extremely limited in the available registers.


r~
