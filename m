Received: from eggs.gnu.org ([209.51.188.92]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJtBz-00078X-OT
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJtBy-0001ib-SK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:35 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hJtBy-0001df-Nx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:34 -0400
Received: by mail-yb1-xb44.google.com with SMTP id u187so831834ybg.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 22:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556110623-655-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 Apr 2019 22:14:23 -0700
Message-ID: <CAMo8BfKTHd5Ycz-E=_nbX7JQmhU_kiOc7ZMSauae7GsRr9QpFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add support for the
 SIOCSPGRP ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, daniel.santos@pobox.com, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Wed, Apr 24, 2019 at 5:58 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add support for setting the process (or process group) to receive SIGIO
> or SIGURG signals when I/O becomes possible or urgent data is available,
> using SIOCSPGRP ioctl.
>
> The ioctl numeric values for SIOCSPGRP are platform-dependent and are
> determined by following files in Linux kernel source tree:
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCSPGRP    0x8902
> arch/mips/include/uapi/asm/sockios.h:#define SIOCSPGRP    _IOW('s', 8, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCSPGRP  0x8902
> arch/sh/include/uapi/asm/sockios.h:#define SIOCSPGRP      _IOW('s', 8, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCSPGRP  _IOW('s', 8, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCSPGRP   _IOW('s', 8, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCSPGRP   0x8902
> include/uapi/asm-generic/sockios.h:#define SIOCSPGRP      0x8902
>
> Hence the different definition for alpha, mips, sh4, and extensa.

Typo: xtensa.

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 1 +
>  linux-user/syscall_defs.h | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
