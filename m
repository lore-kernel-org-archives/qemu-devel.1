Received: from eggs.gnu.org ([2001:4830:134:3::10]:38443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZrUN-000309-1K
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 01:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZrUF-00008N-TD
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 01:07:17 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZrUF-00007z-53
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 01:07:11 -0500
Received: by mail-pf1-x442.google.com with SMTP id u6so378939pfh.11
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 22:07:11 -0800 (PST)
References: <cover.1545246859.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19f7305e-ae63-3a5b-87dd-e0cfd835462f@linaro.org>
Date: Wed, 19 Dec 2018 22:07:07 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/23] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/19/18 11:16 AM, Alistair Francis wrote:
> This patch set adds RISC-V backend support to QEMU. This is based on
> Michael Clark's original work with extra work on top.
> 
> This has been somewhat tested and can run other architecture softmmu
> code. It seems that any complex OS will eventually hang, but we can
> run the BIOS and OS startup code for a number of different operating
> systems.
> 
> I haven't tested linux user support at all yet. I think Michael had that
> working reliably though and hopefully my changes haven't broken it.
> 
> There are still some todos in the code (there are missing instructions
> and byte swapping) but these should assert instead of generating invalid
> code.

Queued to tcg-next, with the extrh fix.

Some of those todos are no longer todos, since e.g. bswap is now optional.
Those asserts should never fire (as a good assert should do, I suppose).

The missing instructions are only for riscv32, which afaik is just now making
its way to glibc.  So a chroot complete enough to build qemu is a ways away.
I'm ok with leaving that incomplete for now.


r~
