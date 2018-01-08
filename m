Received: from eggs.gnu.org ([2001:4830:134:3::10]:33207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYfgA-0000Jd-56
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYfg8-00030Y-UF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:02 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:37528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYfg8-000309-P1
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:00 -0500
Received: by mail-oi0-x231.google.com with SMTP id e144so3431211oib.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 14:14:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 22:13:39 +0000
Message-ID: <CAFEAcA82JWTRWZ2nEesHve=trZVsvpiZa9G5zHJ+b5AyPu6OtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 January 2018 at 16:42, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to cc5230267678c26b7f96157086f45fd8a347eb21:
>
>   target/m68k: fix m68k_cpu_dump_state() (2018-01-04 17:24:35 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (17):
>   target-m68k: sync CC_OP before gen_jmp_tb()
>   target/m68k: fix gen_get_ccr()
>   linux-user, m68k: correctly manage SR in context
>   target/m68k: use insn_pc to generate instruction fault address
>   target/m68k: add CPU_LOG_INT trace
>   target/m68k: manage 680x0 stack frames
>   target/m68k: add chk and chk2
>   target/m68k: add move16
>   target/m68k: softmmu cleanup
>   target/m68k: add cpush/cinv
>   target/m68k: add reset
>   target/m68k: implement fsave/frestore
>   target/m68k: move CCR/SR functions
>   target/m68k: add 680x0 "move to SR" instruction
>   target/m68k: add andi/ori/eori to SR/CCR
>   target/m68k: add the Interrupt Stack Pointer
>   target/m68k: fix m68k_cpu_dump_state()
>

Applied, thanks.

-- PMM
