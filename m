Received: from eggs.gnu.org ([209.51.188.92]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtyD-0005CY-1U
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtyB-0005Z1-Fa
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDtyB-0005YL-5P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id h18so4158265wml.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
	<CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
In-Reply-To: <CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:21:21 +0530
Message-ID: <CAH95U0jVP2SXr9+t+NQ4xoWODMJgMxpSgdMM4RiTSKcEX9v6ZQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

Ok, thanks

On Tue, Apr 9, 2019 at 10:20 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 9 Apr 2019 at 17:42, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >
> > Yeah this is a stand alone patch.
>
> OK, thanks -- just wanted to check there wasn't a missing
> bit. I think this could go in via the qemu-trivial tree
> so I have cc'd them.
>
> We're in the middle of a release at the moment, but we
> should reopen for development in a couple of weeks. If
> this patch still hasn't gone anywhere by a week or so after
> that then please follow up with a 'ping' to check it hasn't
> been forgotten by accident.
>
> > On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.or=
g>
> wrote:
> >> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >> >
> >> > Removed unwanted includes from cpu-common.h
> >> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >> >
> >> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >> >
> >> > ---
> >> >  include/exec/cpu-common.h | 2 --
> >> >  1 file changed, 2 deletions(-)
> >> >
> >> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> >> > index cef8b88a2a..a3594f3f50 100644
> >> > --- a/include/exec/cpu-common.h
> >> > +++ b/include/exec/cpu-common.h
> >> > @@ -7,8 +7,6 @@
> >> >  #include "exec/hwaddr.h"
> >> >  #endif
> >> >
> >> > -#include "qemu/bswap.h"
> >> > -#include "qemu/queue.h"
> >> >  #include "qemu/fprintf-fn.h"
> >> >
> >>
> >> I was surprised that no .c files are implicitly relying
> >> on these includes, but apparently none are, so we can
> >> safely remove them.
> >>
> >> A couple of notes:
> >>  * this doesn't need to go to qemu-stable as it's just a
> >>    code cleanup
> >>  * did something go wrong with your sending of this patch?
> >>    Its subject is "PATCH 0/4" which would usually indicate
> >>    a cover letter for a four-patch series, but this seems
> >>    to be a stand-alone patch.
> >>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
