Received: from eggs.gnu.org ([209.51.188.92]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJt8f-0005Qq-MC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJt8e-0001iW-4E
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:09 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hJt8d-0001bm-T8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:08 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m5so825358ybk.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 22:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 Apr 2019 22:10:55 -0700
Message-ID: <CAMo8BfLGg7RLMR_wLhqrKz=hE-jhgUoLzUxjURwQES-s118xRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for eXtensa
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

On Wed, Apr 24, 2019 at 5:57 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix support for the SIOCATMARK and SIOCGPGRP ioctls for eXtensa by

xtensa is the official name of this architecture, please fix the spelling
here...

> correcting corresponding macro definition.
>
> Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
> Linux kernel. Following relevant lines are from kernel source tree:
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
> arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
> arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
> include/uapi/asm-generic/sockios.h:#define SIOCATMARK      0x8905
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
> arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
> arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
> include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904
>
> It is visible that eXtensa should have the same definitions as

...here, and in the subject line.

> alpha, mips and sh4 already do. This patch brings that to the
> accurate state.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall_defs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
