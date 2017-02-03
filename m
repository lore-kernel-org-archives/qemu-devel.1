Received: from eggs.gnu.org ([2001:4830:134:3::10]:41165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgL0-0004W4-Jh
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgKz-0006C6-SX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:03:50 -0500
Received: from mail-wj0-x230.google.com ([2a00:1450:400c:c01::230]:36445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgKz-0006Be-NT
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:03:49 -0500
Received: by mail-wj0-x230.google.com with SMTP id n2so2299240wjq.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 08:03:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ca20462a044848000370318a8bd41dd0a4ed273f.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<ca20462a044848000370318a8bd41dd0a4ed273f.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 16:03:27 +0000
Message-ID: <CAFEAcA8am+TXYzW5c58WSh6d2JeXUdeov1n=jWjE-fCuf=Nkww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 6/7] Fix Thumb-1 BE32 execution and
 disassembly.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:32, Julian Brown <julian@codesourcery.com> wrote:
> Thumb-1 code has some issues in BE32 mode (as currently implemented). In
> short, since bytes are swapped within words at load time for BE32
> executables, this also swaps pairs of adjacent Thumb-1 instructions.
>
> This patch un-swaps those pairs of instructions again, both for execution,
> and for disassembly. (The previous version of the patch always read four
> bytes in arm_read_memory_func and then extracted the proper two bytes,
> in a probably misguided attempt to match the behaviour of actual hardware
> as described by e.g. the ARM9TDMI TRM, section 3.3 "Endian effects for
> instruction fetches". It's less complicated to just read the correct
> two bytes though.)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
