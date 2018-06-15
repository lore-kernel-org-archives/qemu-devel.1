Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmAw-0001ly-Am
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmAv-0000uo-IX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:41:50 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTmAv-0000uZ-Cs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:41:49 -0400
Received: by mail-oi0-x22e.google.com with SMTP id d5-v6so8400536oib.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:41:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:41:28 +0100
Message-ID: <CAFEAcA-n9U90h8j_-cu0Y+vxnM0mJra0Ldw880t33G122jdCiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] tcg queued patches
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

On 14 June 2018 at 20:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180614
>
> for you to fetch changes up to ba3e9674da7b60ad627e122a6496d3e13f20c34f:
>
>   tcg: remove tb_lock (2018-06-12 08:26:19 -1000)
>
> ----------------------------------------------------------------
> Workaround macos assembler lossage.
> Eliminate tb_lock.
>

Hi; I get compile failures with clang I'm afraid
(seen on x86-64 Linux, OSX and FreeBSD):

/home/petmay01/linaro/qemu-for-merges/accel/tcg/translate-all.c:1800:44:
error: incompatible integer to pointer conversion passing 'uintptr_t'
(aka 'unsigned long') to parameter of type 'void *'
[-Werror,-Wint-conversion]
        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
                                           ^~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/include/qemu/atomic.h:134:30:
note: expanded from macro 'atomic_set'
    atomic_set__nocheck(ptr, i);                      \
                             ^
/home/petmay01/linaro/qemu-for-merges/include/qemu/atomic.h:130:27:
note: expanded from macro 'atomic_set__nocheck'
    __atomic_store_n(ptr, i, __ATOMIC_RELAXED)
                          ^
1 error generated.

thanks
-- PMM
