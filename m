Received: from eggs.gnu.org ([209.51.188.92]:44674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Jic-0001lx-CV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Jib-0005OT-LL
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:55:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2Jib-0005No-E5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:55:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id b3so18097232otp.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 09:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
	<d0855c42-bd84-4f90-9af3-0080e0de1740@redhat.com>
In-Reply-To: <d0855c42-bd84-4f90-9af3-0080e0de1740@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 17:55:25 +0000
Message-ID: <CAFEAcA-vMz=2XNkZ7n1WUBj6sMXk4Ffe_-3=tO1-2rowD0O0KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] contrib/elf2dmp: add kernel start address
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Roman Kagan <rkagan@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 20 Feb 2019 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/02/19 22:19, Viktor Prutyanov wrote:
> > Before this patch, if elf2dmp failed to find NT kernel PE magic in
> > allowed virtual address range, then it assumes NULL as NT kernel
> > address and cause segfault.
> >
> > This patch fix the problem described above by checking NT kernel address
> > before futher processing.
> >
> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> > ---
> >  contrib/elf2dmp/main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> > index 1a45eaf565..1bfeb89ba7 100644
> > --- a/contrib/elf2dmp/main.c
> > +++ b/contrib/elf2dmp/main.c
> > @@ -524,6 +524,12 @@ int main(int argc, char *argv[])
> >          }
> >      }
> >
> > +    if (!nt_start_addr) {
> > +        eprintf("Failed to find NT kernel image\n");
> > +        err = 1;
> > +        goto out_ps;
> > +    }
> > +
> >      printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
> >              (char *)nt_start_addr);
> >
> >
>
> Queued, thanks.

Hi Paolo -- I noticed this fix wasn't in master yet -- is it in
a tree you're planning on sending a pullreq for soon?

thanks
-- PMM
