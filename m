Received: from eggs.gnu.org ([2001:4830:134:3::10]:47828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJTD-0003RD-Q0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJTD-0005Vm-2N
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:39:11 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJTC-0005Uj-Sx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:39:10 -0400
Received: by mail-ot0-x241.google.com with SMTP id a5-v6so6964582otf.12
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:39:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-14-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:38:49 +0100
Message-ID: <CAFEAcA9p63Fq+jjRpfwuXsubdVG-M9fjpdVx8JKRRyMgPOQfKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 13/19] linux-user: Split out close, open,
 openat, read, write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 12 June 2018 at 01:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.h           |  51 ++++
>  linux-user/strace.c            |  35 ---
>  linux-user/syscall.c           | 402 +------------------------------
>  linux-user/syscall_file.c      | 423 +++++++++++++++++++++++++++++++++
>  linux-user/Makefile.objs       |   3 +-
>  linux-user/gen_syscall_list.py |   5 +
>  linux-user/strace.list         |  15 --
>  7 files changed, 484 insertions(+), 450 deletions(-)
>  create mode 100644 linux-user/syscall_file.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> +SYSCALL_IMPL(close)
> +{
> +    fd_trans_unregister(arg1);
> +    return get_errno(close(arg1));
> +}
> +SYSCALL_DEF(close, ARG_DEC);

If in future we wanted to extend the set of information
we had for each syscall in the SyscallDef struct, I guess
we'd add parameters to the SYSCALL_DEF macro (or have
more variant macros)? I can't offhand think of something I'd
want to use that for, so it's a bit of an abstract question
for the moment.

thanks
-- PMM
