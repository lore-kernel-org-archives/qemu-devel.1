Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmFuO-0004oh-1a
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmFuM-00040t-PZ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:28:20 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cmFuM-00040f-Hu
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:28:18 -0500
Received: by mail-wr0-x22c.google.com with SMTP id l37so60144268wrc.1
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 00:28:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310074218.5372-1-alex.bennee@linaro.org>
References: <20170303131113.25898-3-pbonzini@redhat.com>
	<20170310074218.5372-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Mar 2017 09:27:56 +0100
Message-ID: <CAFEAcA9KXuqqZ0TDASBbgx-vUOC4He5agBUCo6FJZKFOWzXPKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fixup! qemu-timer: do not include
 sysemu/cpus.h from util/qemu-timer.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 10 March 2017 at 08:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> ---
>  hw/ppc/pnv.c             | 1 +
>  target/alpha/translate.c | 1 +
>  2 files changed, 2 insertions(+)

I'm guessing you didn't intend to post a fixup! patch without
a signoff line? :-)

thanks
-- PMM


>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 09f0d22def..3fa722af82 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -21,6 +21,7 @@
>  #include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/cpus.h"
>  #include "hw/hw.h"
>  #include "target/ppc/cpu.h"
>  #include "qemu/log.h"
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 055286a7b8..df5d695344 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -19,6 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "sysemu/cpus.h"
>  #include "disas/disas.h"
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
> --
> 2.11.0
