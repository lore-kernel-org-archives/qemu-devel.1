Received: from eggs.gnu.org ([2001:4830:134:3::10]:45675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdiB-0003WM-IZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdi9-0002mT-0f
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:19 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVdi8-0002mA-Q6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:16 -0400
Received: by mail-wr0-f173.google.com with SMTP id r103so52707943wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:59:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
References: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 13:57:54 +0100
Message-ID: <CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nigel Horne <njh@bandsman.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13 July 2017 at 13:51, Nigel Horne <njh@bandsman.co.uk> wrote:
> The latest version in github fails to link (using gcc-7) with this error:
>
>   LINK    aarch64-softmmu/qemu-system-aarch64
> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_le_mmu':
> cputlb.c:(.text+0x5f3d): undefined reference to
> `__atomic_compare_exchange_16'
> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_be_mmu':
> cputlb.c:(.text+0x6000): undefined reference to
> `__atomic_compare_exchange_16'
> accel/tcg/cputlb.o: In function `helper_atomic_ldo_be_mmu':
> cputlb.c:(.text+0x602f): undefined reference to `__atomic_load_16'
> accel/tcg/cputlb.o: In function `helper_atomic_ldo_le_mmu':
> cputlb.c:(.text+0x5f73): undefined reference to `__atomic_load_16'
> accel/tcg/cputlb.o: In function `helper_atomic_sto_le_mmu':
> cputlb.c:(.text+0x5fa9): undefined reference to `__atomic_store_16'
> accel/tcg/cputlb.o: In function `helper_atomic_sto_be_mmu':
> cputlb.c:(.text+0x607f): undefined reference to `__atomic_store_16'
> collect2: error: ld returned 1 exit status
> Makefile:197: recipe for target 'qemu-system-aarch64' failed
> make[1]: *** [qemu-system-aarch64] Error 1
> Makefile:328: recipe for target 'subdir-aarch64-softmmu' failed
> make: *** [subdir-aarch64-softmmu] Error 2

Emilio's recent-ish change (commit f3ced3c5928) maybe?

Nigel -- what host architecture are you building for?

thanks
-- PMM
