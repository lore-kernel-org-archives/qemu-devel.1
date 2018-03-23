Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNaw-0007v0-JS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNav-0004jo-Od
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:23:02 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:47005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezNav-0004jU-IL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:23:01 -0400
Received: by mail-ot0-x243.google.com with SMTP id g97-v6so13394779otg.13
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 07:23:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322215833.7713-2-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
	<20180322215833.7713-2-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 14:22:40 +0000
Message-ID: <CAFEAcA-xXP2sBWFknM4gKsVNSqGu7=JnF0xD8gGbSerWnznOiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.13 1/5] linux-user: cleanup signal.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 22 March 2018 at 21:58, Laurent Vivier <laurent@vivier.eu> wrote:
> move all target specific parts to
> signal.inc.c in arch directory
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/aarch64/signal.inc.c    |  556 +++
>  linux-user/alpha/signal.inc.c      |  258 ++
>  linux-user/arm/signal.inc.c        |  749 +++++
>  linux-user/cris/signal.inc.c       |  166 +
>  linux-user/hppa/signal.inc.c       |  188 ++
>  linux-user/i386/signal.inc.c       |  579 ++++
>  linux-user/m68k/signal.inc.c       |  406 +++
>  linux-user/microblaze/signal.inc.c |  226 ++
>  linux-user/mips/signal.inc.c       |  378 +++
>  linux-user/mips64/signal.inc.c     |    1 +
>  linux-user/nios2/signal.inc.c      |  232 ++
>  linux-user/openrisc/signal.inc.c   |  209 ++
>  linux-user/ppc/signal.inc.c        |  667 ++++
>  linux-user/riscv/signal.inc.c      |  196 ++
>  linux-user/s390x/signal.inc.c      |  305 ++
>  linux-user/sh4/signal.inc.c        |  327 ++
>  linux-user/signal.c                | 6487 +-----------------------------------
>  linux-user/sparc/signal.inc.c      |  601 ++++
>  linux-user/sparc64/signal.inc.c    |    1 +
>  linux-user/tilegx/signal.inc.c     |  163 +
>  linux-user/x86_64/signal.inc.c     |    1 +
>  linux-user/xtensa/signal.inc.c     |  253 ++
>  22 files changed, 6463 insertions(+), 6486 deletions(-)

I think anything with a diffstat like this is basically
unreviewable, at least for me :-(

> diff --git a/linux-user/aarch64/signal.inc.c b/linux-user/aarch64/signal.inc.c
> new file mode 100644
> index 0000000000..28fa0f2f22
> --- /dev/null
> +++ b/linux-user/aarch64/signal.inc.c

I was hoping we could have these be standalone .c files,
rather than just #included from linux-user/signal.c.
I appreciate this requires a bit more teasing out of what
needs to become non-static in the common code signal.c
to be callable from the per-target code, though.

> @@ -0,0 +1,556 @@
> +struct target_sigcontext {

New source files should all have the usual sort of comment
header with a copyright and license statement.

thanks
-- PMM
