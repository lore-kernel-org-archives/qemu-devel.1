Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD5dk-00034g-2P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD5dj-0005rW-1o
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:34:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD5di-0005rC-Kc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:34:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id l197-v6so23568919oib.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 03:34:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 11:34:29 +0100
Message-ID: <CAFEAcA-NEN7MymyzmeOwz7bX99P_o6D9dMraHYA8LcFS7w9=_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2018 at 18:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit ff56877e911782dedc9a424233fd3f62369c258c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20181015-pull-request' into staging (2018-10-15 15:03:45 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181016
>
> for you to fetch changes up to e3e9d1ea20c75718ce7c528c588a0a497f12f750:
>
>   cputlb: read CPUTLBEntry.addr_write atomically (2018-10-16 10:04:27 -0700)
>
> ----------------------------------------------------------------
> Queued tcg patches
>

Hi; I get compile failures, I'm afraid:

FreeBSD's compiler gives warnings:
In file included from /var/tmp/qemu-test.bVaUEj/accel/tcg/user-exec.c:28:
/var/tmp/qemu-test.bVaUEj/include/qemu/atomic128.h:148:23: warning:
unknown attribute 'error' ignored [-Wunknown-attributes]
Int128 __attribute__((error("unsupported atomic")))
                      ^
/var/tmp/qemu-test.bVaUEj/include/qemu/atomic128.h:150:21: warning:
unknown attribute 'error' ignored [-Wunknown-attributes]
void __attribute__((error("unsupported atomic")))
                    ^

x86-64 Linux clang fails with the same issue:
In file included from
/home/petmay01/linaro/qemu-for-merges/accel/tcg/user-exec.c:28:
/home/petmay01/linaro/qemu-for-merges/include/qemu/atomic128.h:148:23:
error: unknown attribute 'error' ignored
[-Werror,-Wunknown-attributes]
Int128 __attribute__((error("unsupported atomic")))
                      ^
/home/petmay01/linaro/qemu-for-merges/include/qemu/atomic128.h:150:21:
error: unknown attribute 'error' ignored
[-Werror,-Wunknown-attributes]
void __attribute__((error("unsupported atomic")))
                    ^


The win32 build fails with:

target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_le_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:573: undefined
reference to `helper_atomic_cmpxchgo_le_mmu'
target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_be_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:647: undefined
reference to `helper_atomic_cmpxchgo_be_mmu'
target/arm/helper-a64.o: In function `helper_casp_le_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:669: undefined
reference to `helper_atomic_cmpxchgo_le_mmu'
target/arm/helper-a64.o: In function `helper_casp_be_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:690: undefined
reference to `helper_atomic_cmpxchgo_be_mmu'


thanks
-- PMM
