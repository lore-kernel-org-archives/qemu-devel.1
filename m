Received: from eggs.gnu.org ([209.51.188.92]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtpt-0002He-CP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtpr-0008Vn-Sp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDtpq-0008TL-Fa
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:42:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id y7so6180126wrn.11
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
In-Reply-To: <CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:12:39 +0530
Message-ID: <CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Yeah this is a stand alone patch.

On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >
> > Removed unwanted includes from cpu-common.h
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >
> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >
> > ---
> >  include/exec/cpu-common.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index cef8b88a2a..a3594f3f50 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -7,8 +7,6 @@
> >  #include "exec/hwaddr.h"
> >  #endif
> >
> > -#include "qemu/bswap.h"
> > -#include "qemu/queue.h"
> >  #include "qemu/fprintf-fn.h"
> >
>
> I was surprised that no .c files are implicitly relying
> on these includes, but apparently none are, so we can
> safely remove them.
>
> A couple of notes:
>  * this doesn't need to go to qemu-stable as it's just a
>    code cleanup
>  * did something go wrong with your sending of this patch?
>    Its subject is "PATCH 0/4" which would usually indicate
>    a cover letter for a four-patch series, but this seems
>    to be a stand-alone patch.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
