Received: from eggs.gnu.org ([209.51.188.92]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hB0Dj-0000kO-EI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hB0Dh-0004gE-KC
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:55:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hB0Dg-0004cE-20
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:55:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id a184so147749wma.2
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 09:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190401160849.26083-1-aruna.15@cse.mrt.ac.lk>
	<CAH95U0gCsCE4zxHM3Lmim4jMi-pYHTPCkkOVKpCONyA5rG8_Uw@mail.gmail.com>
	<8597afaa-9bfb-d18d-a8b6-6bbab5d020ca@redhat.com>
In-Reply-To: <8597afaa-9bfb-d18d-a8b6-6bbab5d020ca@redhat.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon, 1 Apr 2019 22:25:19 +0530
Message-ID: <CAH95U0jC2cUGWvTvONfDOv5Cp=Az33F26AbtQHK-XNhyT0SH+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] Header cleanups qemu_is* macros were
 moved from qemu-common.h to qemu/cutils.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Sure, no problem.

On Mon, Apr 1, 2019 at 10:18 PM, Thomas Huth <thuth@redhat.com> wrote:

> On 01/04/2019 18.13, Aruna Jayasena wrote:
> > qemu_is* macros were moved from qemu-common.h to qemu/cutils.h
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> > * Description was combined with the subject of the email
> >
> > On Mon, 1 Apr 2019 at 21:39, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >
> >> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >> ---
> >>  hw/core/qdev-properties.c |  1 +
> >>  include/qemu-common.h     | 11 -----------
> >>  include/qemu/cutils.h     | 12 ++++++++++++
> >>  qapi/qapi-util.c          |  2 +-
> >>  util/id.c                 |  2 +-
> >>  5 files changed, 15 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> >> index 5da1439a8b..821a4ab311 100644
> >> --- a/hw/core/qdev-properties.c
> >> +++ b/hw/core/qdev-properties.c
> >> @@ -10,6 +10,7 @@
> >>  #include "qapi/visitor.h"
> >>  #include "chardev/char.h"
> >>  #include "qemu/uuid.h"
> >> +#include "qemu/cutils.h"
> >>
> >>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
> >>                                    Error **errp)
> >> diff --git a/include/qemu-common.h b/include/qemu-common.h
> >> index a102245519..0066e45a6b 100644
> >> --- a/include/qemu-common.h
> >> +++ b/include/qemu-common.h
> >> @@ -33,17 +33,6 @@ int qemu_main(int argc, char **argv, char **envp);
> >>  void qemu_get_timedate(struct tm *tm, int offset);
> >>  int qemu_timedate_diff(struct tm *tm);
> >>
> >> -#define qemu_isalnum(c)                isalnum((unsigned char)(c))
> >> -#define qemu_isalpha(c)                isalpha((unsigned char)(c))
> >> -#define qemu_iscntrl(c)                iscntrl((unsigned char)(c))
> >> -#define qemu_isdigit(c)                isdigit((unsigned char)(c))
> >> -#define qemu_isgraph(c)                isgraph((unsigned char)(c))
> >> -#define qemu_islower(c)                islower((unsigned char)(c))
> >> -#define qemu_isprint(c)                isprint((unsigned char)(c))
> >> -#define qemu_ispunct(c)                ispunct((unsigned char)(c))
> >> -#define qemu_isspace(c)                isspace((unsigned char)(c))
> >> -#define qemu_isupper(c)                isupper((unsigned char)(c))
> >> -#define qemu_isxdigit(c)       isxdigit((unsigned char)(c))
> >>  #define qemu_tolower(c)                tolower((unsigned char)(c))
> >>  #define qemu_toupper(c)                toupper((unsigned char)(c))
> >>  #define qemu_isascii(c)                isascii((unsigned char)(c))
> >> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> >> index d2dad3057c..797c5bc560 100644
> >> --- a/include/qemu/cutils.h
> >> +++ b/include/qemu/cutils.h
> >> @@ -3,6 +3,18 @@
> >>
> >>  #include "qemu/fprintf-fn.h"
> >>
> >> +#define qemu_isalnum(c)    isalnum((unsigned char)(c))
> >> +#define qemu_isalpha(c)    isalpha((unsigned char)(c))
> >> +#define qemu_iscntrl(c)    iscntrl((unsigned char)(c))
> >> +#define qemu_isdigit(c)    isdigit((unsigned char)(c))
> >> +#define qemu_isgraph(c)    isgraph((unsigned char)(c))
> >> +#define qemu_islower(c)    islower((unsigned char)(c))
> >> +#define qemu_isprint(c)    isprint((unsigned char)(c))
> >> +#define qemu_ispunct(c)    ispunct((unsigned char)(c))
> >> +#define qemu_isspace(c)    isspace((unsigned char)(c))
> >> +#define qemu_isupper(c)    isupper((unsigned char)(c))
> >> +#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
>
>  Hi,
>
> moving the qemu_is* macros around does not make too much sense to
> me... I've now tried to have a closer look at that BiteSizeTask,
> and it sounds to me like something different was meant here instead.
> And indeed, after looking through the QEMU history for a while, I
> spotted this commit here:
>
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df348b6d1a53e5271cf1=
c9#patch81
>
> So looks like this task has been handled in the past already and
> apparently we've forgotten to remove it from the BiteSizeTask page
> afterwards. Sorry for this, I'll remove it now...
>
> May I suggest to you to have a look at the "avoid including files from
> include/exec/cpu-common.h" task instead? I think you could remove the
> #include "qemu/bswap.h" and #include "qemu/queue.h" lines in there withou=
t
> too much hassle...
>
>  Thomas
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
